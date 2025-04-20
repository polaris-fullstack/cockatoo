require "test_helper"

class ApplicantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @applicant = applicants(:one)
  end

  test "should get index" do
    get applicants_url
    assert_response :success
  end

  test "should get new" do
    get new_applicant_url
    assert_response :success
  end

  test "should create applicant" do
    assert_difference("Applicant.count") do
      post applicants_url, params: { applicant: { address: @applicant.address, address_postcode: @applicant.address_postcode, address_state: @applicant.address_state, dependants: @applicant.dependants, dob: @applicant.dob, drivers_licence: @applicant.drivers_licence, email: @applicant.email, finance_application_id: @applicant.finance_application_id, given_names: @applicant.given_names, licence_state: @applicant.licence_state, marital_status: @applicant.marital_status, other_tax_countries: @applicant.other_tax_countries, phone: @applicant.phone, residency_status: @applicant.residency_status, surname: @applicant.surname, tin: @applicant.tin, title: @applicant.title, us_citizen: @applicant.us_citizen } }
    end

    assert_redirected_to applicant_url(Applicant.last)
  end

  test "should show applicant" do
    get applicant_url(@applicant)
    assert_response :success
  end

  test "should get edit" do
    get edit_applicant_url(@applicant)
    assert_response :success
  end

  test "should update applicant" do
    patch applicant_url(@applicant), params: { applicant: { address: @applicant.address, address_postcode: @applicant.address_postcode, address_state: @applicant.address_state, dependants: @applicant.dependants, dob: @applicant.dob, drivers_licence: @applicant.drivers_licence, email: @applicant.email, finance_application_id: @applicant.finance_application_id, given_names: @applicant.given_names, licence_state: @applicant.licence_state, marital_status: @applicant.marital_status, other_tax_countries: @applicant.other_tax_countries, phone: @applicant.phone, residency_status: @applicant.residency_status, surname: @applicant.surname, tin: @applicant.tin, title: @applicant.title, us_citizen: @applicant.us_citizen } }
    assert_redirected_to applicant_url(@applicant)
  end

  test "should destroy applicant" do
    assert_difference("Applicant.count", -1) do
      delete applicant_url(@applicant)
    end

    assert_redirected_to applicants_url
  end
end
