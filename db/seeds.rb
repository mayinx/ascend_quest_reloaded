# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Clear existing records (optional)
Expense.destroy_all

# Seed data
expenses = [
  {
    amount: 1200.00,
    description: "Monthly Rent",
    category: "Housing",
    frequency: "monthly",
    interval_unit: "month",
    interval_value: 1,
    start_date: Date.today,
    end_date: nil,
    category_type: "NEEDS (DEBTS)",
    target_amount: 1200.00,
    comment: "Payable on the 1st of every month"
  },
  {
    amount: 300.00,
    description: "Monthly Subscription (Internet)",
    category: "Utilities",
    frequency: "monthly",
    interval_unit: "month",
    interval_value: 1,
    start_date: Date.today,
    end_date: nil,
    category_type: "NEEDS (WANTS)",
    target_amount: 300.00,
    comment: "Payable on the 15th of every month"
  },
  {
    amount: 150.00,
    description: "Weekly Grocery Shopping",
    category: "Food",
    frequency: "weekly",
    interval_unit: "week",
    interval_value: 1,
    start_date: Date.today,
    end_date: nil,
    category_type: "NEEDS (WANTS)",
    target_amount: 150.00,
    comment: "Shopping for groceries every week"
  },
  {
    amount: 50.00,
    description: "Monthly Gym Membership",
    category: "Health & Fitness",
    frequency: "monthly",
    interval_unit: "month",
    interval_value: 1,
    start_date: Date.today,
    end_date: nil,
    category_type: "NEEDS (WANTS)",
    target_amount: 50.00,
    comment: "Payable on the 10th of every month"
  },
  {
    amount: 100.00,
    description: "Quarterly Insurance Payment",
    category: "Insurance",
    frequency: "quarterly",
    interval_unit: "month",
    interval_value: 3,
    start_date: Date.today,
    end_date: nil,
    category_type: "NEEDS (DEBTS)",
    target_amount: 100.00,
    comment: "Payable every three months"
  },
  {
    amount: 500.00,
    description: "Yearly Tax Payment",
    category: "Taxes",
    frequency: "yearly",
    interval_unit: "year",
    interval_value: 1,
    start_date: Date.today,
    end_date: nil,
    category_type: "NEEDS (DEBTS)",
    target_amount: 500.00,
    comment: "Payable on April 15th each year"
  }
]

# Create expenses
expenses.each do |expense_attributes|
  Expense.create!(expense_attributes)
end

puts "Seeded #{expenses.size} recurring expenses."