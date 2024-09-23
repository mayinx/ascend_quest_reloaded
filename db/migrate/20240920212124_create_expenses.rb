class CreateExpenses < ActiveRecord::Migration[7.2]
  # amount: The actual expense amount.
  # description: A description of the expense.
  # category: The type or category of the expense (e.g., Rent, Loan, Subscription).
  # category_type: To classify expenses as NEEDS (DEBTS), NEEDS (WANTS), SAVINGS/INVESTMENTS, etc.
  # frequency: General term for how often the expense occurs (monthly, yearly, etc.).
  # interval_unit: Unit of time for the recurrence (e.g., day, week, month, year).
  # interval_value: Numeric value to define how many units (e.g., "every 2 weeks" or "every 3 months").
  # start_date: When the expense starts.
  # end_date: When the expense ends (optional).
  # 
  # target_amount: The user's goal or ideal amount for this expense.
  # comment: A text field for any additional notes or details the user may want to record.

  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.string :description
      t.string :category
      t.string :frequency
      t.string :interval_unit
      t.integer :interval_value
      t.date :start_date
      t.date :end_date
      t.string :category_type
      t.decimal :target_amount
      t.text :comment

      t.timestamps
    end
  end
end
