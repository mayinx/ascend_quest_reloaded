require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expense = expenses(:one)
  end

  test "should get index" do
    get expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_expense_url
    assert_response :success
  end

  test "should create expense" do
    assert_difference("Expense.count") do
      post expenses_url, params: { expense: { amount: @expense.amount, category: @expense.category, category_type: @expense.category_type, comment: @expense.comment, description: @expense.description, end_date: @expense.end_date, frequency: @expense.frequency, interval_unit: @expense.interval_unit, interval_value: @expense.interval_value, start_date: @expense.start_date, target_amount: @expense.target_amount } }
    end

    assert_redirected_to expense_url(Expense.last)
  end

  test "should show expense" do
    get expense_url(@expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_expense_url(@expense)
    assert_response :success
  end

  test "should update expense" do
    patch expense_url(@expense), params: { expense: { amount: @expense.amount, category: @expense.category, category_type: @expense.category_type, comment: @expense.comment, description: @expense.description, end_date: @expense.end_date, frequency: @expense.frequency, interval_unit: @expense.interval_unit, interval_value: @expense.interval_value, start_date: @expense.start_date, target_amount: @expense.target_amount } }
    assert_redirected_to expense_url(@expense)
  end

  test "should destroy expense" do
    assert_difference("Expense.count", -1) do
      delete expense_url(@expense)
    end

    assert_redirected_to expenses_url
  end
end
