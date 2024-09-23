require "application_system_test_case"

class ExpensesTest < ApplicationSystemTestCase
  setup do
    @expense = expenses(:one)
  end

  test "visiting the index" do
    visit expenses_url
    assert_selector "h1", text: "Expenses"
  end

  test "should create expense" do
    visit expenses_url
    click_on "New expense"

    fill_in "Amount", with: @expense.amount
    fill_in "Category", with: @expense.category
    fill_in "Category type", with: @expense.category_type
    fill_in "Comment", with: @expense.comment
    fill_in "Description", with: @expense.description
    fill_in "End date", with: @expense.end_date
    fill_in "Frequency", with: @expense.frequency
    fill_in "Interval unit", with: @expense.interval_unit
    fill_in "Interval value", with: @expense.interval_value
    fill_in "Start date", with: @expense.start_date
    fill_in "Target amount", with: @expense.target_amount
    click_on "Create Expense"

    assert_text "Expense was successfully created"
    click_on "Back"
  end

  test "should update Expense" do
    visit expense_url(@expense)
    click_on "Edit this expense", match: :first

    fill_in "Amount", with: @expense.amount
    fill_in "Category", with: @expense.category
    fill_in "Category type", with: @expense.category_type
    fill_in "Comment", with: @expense.comment
    fill_in "Description", with: @expense.description
    fill_in "End date", with: @expense.end_date
    fill_in "Frequency", with: @expense.frequency
    fill_in "Interval unit", with: @expense.interval_unit
    fill_in "Interval value", with: @expense.interval_value
    fill_in "Start date", with: @expense.start_date
    fill_in "Target amount", with: @expense.target_amount
    click_on "Update Expense"

    assert_text "Expense was successfully updated"
    click_on "Back"
  end

  test "should destroy Expense" do
    visit expense_url(@expense)
    click_on "Destroy this expense", match: :first

    assert_text "Expense was successfully destroyed"
  end
end
