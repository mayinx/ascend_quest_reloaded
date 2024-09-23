json.extract! expense, :id, :amount, :description, :category, :frequency, :interval_unit, :interval_value, :start_date, :end_date, :category_type, :target_amount, :comment, :created_at, :updated_at
json.url expense_url(expense, format: :json)
