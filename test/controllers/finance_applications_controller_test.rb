require "test_helper"

class FinanceApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @finance_application = finance_applications(:one)
  end

  test "should get index" do
    get finance_applications_url
    assert_response :success
  end

  test "should get new" do
    get new_finance_application_url
    assert_response :success
  end

  test "should create finance_application" do
    assert_difference("FinanceApplication.count") do
      post finance_applications_url, params: { finance_application: { assets: @finance_application.assets, declaration: @finance_application.declaration, dwelling_age: @finance_application.dwelling_age, expenses: @finance_application.expenses, fhog_eligible: @finance_application.fhog_eligible, first_time_owner: @finance_application.first_time_owner, income: @finance_application.income, liabilities: @finance_application.liabilities, property_address: @finance_application.property_address, property_postcode: @finance_application.property_postcode, property_state: @finance_application.property_state, purchase_price: @finance_application.purchase_price, purpose: @finance_application.purpose } }
    end

    assert_redirected_to finance_application_url(FinanceApplication.last)
  end

  test "should show finance_application" do
    get finance_application_url(@finance_application)
    assert_response :success
  end

  test "should get edit" do
    get edit_finance_application_url(@finance_application)
    assert_response :success
  end

  test "should update finance_application" do
    patch finance_application_url(@finance_application), params: { finance_application: { assets: @finance_application.assets, declaration: @finance_application.declaration, dwelling_age: @finance_application.dwelling_age, expenses: @finance_application.expenses, fhog_eligible: @finance_application.fhog_eligible, first_time_owner: @finance_application.first_time_owner, income: @finance_application.income, liabilities: @finance_application.liabilities, property_address: @finance_application.property_address, property_postcode: @finance_application.property_postcode, property_state: @finance_application.property_state, purchase_price: @finance_application.purchase_price, purpose: @finance_application.purpose } }
    assert_redirected_to finance_application_url(@finance_application)
  end

  test "should destroy finance_application" do
    assert_difference("FinanceApplication.count", -1) do
      delete finance_application_url(@finance_application)
    end

    assert_redirected_to finance_applications_url
  end
end
