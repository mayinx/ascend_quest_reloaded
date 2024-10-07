class ExpenseDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper # Include the TagHelper module
  include ActionView::Helpers::FormHelper # Needed for form generation
  
  delegate_all

  # FYI: Edit available columns tro be displayed here - along with their order ...  
  def self.table_headers(options={})
    header_class = options[:class] || "expenses__table-header-cell"

    [
      { key: :description, label: "Description", visible: true, hideable: false, class: header_class },
      { key: :amount, label: "Amount", visible: true, hideable: false, class: header_class }, # Not hideable
      { key: :frequency, label: "Frequency", visible: false, hideable: true, class: header_class }, # Default hidden
      { key: :formatted_interval, label: "Interval", visible: false, hideable: true, class: header_class }, # Default hidden
      { key: :start_date, label: "Start Date", visible: true, hideable: true, class: header_class },
      { key: :end_date, label: "End Date", visible: true, hideable: true, class: header_class },
      { key: :category, label: "Category", visible: true, hideable: true, class: header_class },
      { key: :target_amount, label: "Target Amount", visible: true, hideable: true, class: header_class },
      { key: :comment, label: "Comment", visible: false, hideable: true, class: header_class }, # Default hidden
      { key: :actions, label: "Actions", visible: true, hideable: false, class: header_class } # Not hideable      
    ]
  end


     # Generate the table header row with data-key attributes for sorting and visibility
  def header_row(options = {})
    thead_class = options.delete(:thead_class) || "expenses__table-header"
    row_class = options.delete(:row_class) || "expenses__table-header-row"

    header_cells = self.class.table_headers(options).map do |header|
      header_class = header[:class]  
      header_class += " #{header[:class]}--hidden" unless header[:visible]
      header_data = { key: header[:key] }
      header_data.merge!({hidden: true}) unless header[:visible]
      content_tag(:th, header[:label], class: header_class, data: header_data)
    end

    content_tag(:thead, class: thead_class) do
      content_tag(:tr, class: row_class) do
        header_cells.join.html_safe
      end
    end
  end

  def table_row_cells
    self.class.table_headers.map do |header|
      content = case header[:key]
                when :formatted_interval
                  formatted_interval
                when :actions
                  nil # We'll handle actions separately in the view
                else
                  object.send(header[:key])
                end

      cell_class = "expenses__table-cell expense"
      cell_class += " expenses__table-cell--hidden" unless header[:visible]

      cell_data = { key: header[:key] }      
      cell_data.merge!({hidden: true}) unless header[:visible]

      # Return the full <td> tag with data-key attribute
      content_tag(:td, content, class: cell_class, data: cell_data)
    end.compact # Exclude nil values (like actions)
  end
  

  # def formatted_interval
  #   "#{interval_value} #{interval_unit.pluralize(interval_value)}"
  # end

  # Render form fields dynamically, ensuring it's in sync with table_row_cells
  def form_fields(f)
    self.class.table_headers.map do |header|
      case header[:key]
      when :description
        f.text_field(:description, value: object.description, class: "input input-bordered w-full", data: { key: header[:key] })
      when :amount
        f.text_field(:amount, value: object.amount, class: "input input-bordered w-full", data: { key: header[:key] })
      when :frequency
        f.select(:frequency, ['Monthly', 'Yearly'], selected: object.frequency, class: "select select-bordered w-full", data: { key: header[:key] })
      when :formatted_interval
        interval_fields(f) # Custom method to handle interval fields
      when :start_date
        f.date_field(:start_date, value: object.start_date, class: "input input-bordered w-full", data: { key: header[:key] })
      when :end_date
        f.date_field(:end_date, value: object.end_date, class: "input input-bordered w-full", data: { key: header[:key] })
      when :category
        f.select(:category, ['Rent', 'Loan', 'Subscription'], selected: object.category, class: "select select-bordered w-full", data: { key: header[:key] })
      when :target_amount
        f.text_field(:target_amount, value: object.target_amount, class: "input input-bordered w-full", data: { key: header[:key] })
      when :comment
        f.text_area(:comment, value: object.comment, class: "textarea textarea-bordered w-full", data: { key: header[:key] })
      else
        nil
      end
    end.compact
  end

  # Custom method to handle the interval field split into value and unit
  def interval_fields(f)
    f.text_field(:interval_value, value: object.interval_value, class: "input input-bordered w-1/3", data: { key: "#{key}_value" }) +
    f.select(:interval_unit, ['Day', 'Week', 'Month', 'Year'], selected: object.interval_unit, class: "select select-bordered w-2/3", data: { key: "#{key}_unit" })
  end

  def formatted_interval
    "#{object.interval_value} #{object.interval_unit.pluralize(object.interval_value)}"
  end
end
