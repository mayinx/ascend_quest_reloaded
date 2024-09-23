class ExpenseDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper # Include the TagHelper module
  include ActionView::Helpers::FormHelper # Needed for form generation
  
  delegate_all

  # FYI: Edit available columns tro be displayed here - along with their order ...  
  def self.table_headers(options={})
    header_class = options[:class] || "p-2 text-left"

    [
      { key: :description, label: "Description", class: header_class },
      { key: :amount, label: "Amount", class: header_class },
      { key: :frequency, label: "Frequency", class: header_class },
      { key: :formatted_interval, label: "Interval", class: header_class }, # Updated key 
      { key: :start_date, label: "Start Date", class: header_class },
      { key: :end_date, label: "End Date", class: header_class },
      { key: :category, label: "Category", class: header_class },
      { key: :target_amount, label: "Target Amount", class: header_class },
      { key: :comment, label: "Comment", class: header_class },
      { key: :actions, label: "Actions", class: header_class }
    ]
  end

  def header_row(options = {})
    thead_class = options.delete(:thead_class) || ""
    row_class = options.delete(:row_class) || ""

    header_cells = self.class.table_headers(options).map do |header|
      content_tag(:th, header[:label], class: header[:class])
    end

    content_tag(:thead, class: thead_class) do
      content_tag(:tr, class: row_class) do
        header_cells.join.html_safe
      end
    end
  end

  def table_row_cells
    self.class.table_headers.map do |header|
      case header[:key]
      when :formatted_interval
        formatted_interval
      when :actions
        nil
      else
        object.send(header[:key])
      end
    end
  end

  # def formatted_interval
  #   "#{interval_value} #{interval_unit.pluralize(interval_value)}"
  # end

  # Render form fields dynamically, ensuring it's in sync with table_row_cells
  def form_fields(f)
    self.class.table_headers.map do |header|
      case header[:key]
      when :description
        f.text_field(:description, value: object.description, class: "input input-bordered w-full")
      when :amount
        f.text_field(:amount, value: object.amount, class: "input input-bordered w-full")
      when :frequency
        f.select(:frequency, ['Monthly', 'Yearly'], selected: object.frequency, class: "select select-bordered w-full")
      when :formatted_interval
        interval_fields(f) # Custom method to handle interval fields
      when :start_date
        f.date_field(:start_date, value: object.start_date, class: "input input-bordered w-full")
      when :end_date
        f.date_field(:end_date, value: object.end_date, class: "input input-bordered w-full")
      when :category
        f.select(:category, ['Rent', 'Loan', 'Subscription'], selected: object.category, class: "select select-bordered w-full")
      when :target_amount
        f.text_field(:target_amount, value: object.target_amount, class: "input input-bordered w-full")
      when :comment
        f.text_area(:comment, value: object.comment, class: "textarea textarea-bordered w-full")
      else
        nil
      end
    end.compact
  end

  # Custom method to handle the interval field split into value and unit
  def interval_fields(f)
    f.text_field(:interval_value, value: object.interval_value, class: "input input-bordered w-1/3") +
    f.select(:interval_unit, ['Day', 'Week', 'Month', 'Year'], selected: object.interval_unit, class: "select select-bordered w-2/3")
  end

  def formatted_interval
    "#{object.interval_value} #{object.interval_unit.pluralize(object.interval_value)}"
  end
end
