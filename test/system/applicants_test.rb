require "application_system_test_case"

class ApplicantsTest < ApplicationSystemTestCase
  setup do
    @applicant = applicants(:one)
  end

  test "visiting the index" do
    visit applicants_url
    assert_selector "h1", text: "Applicants"
  end

  test "should create applicant" do
    visit applicants_url
    click_on "New applicant"

    fill_in "Address", with: @applicant.address
    fill_in "Address postcode", with: @applicant.address_postcode
    fill_in "Address state", with: @applicant.address_state
    fill_in "Dependants", with: @applicant.dependants
    fill_in "Dob", with: @applicant.dob
    fill_in "Drivers licence", with: @applicant.drivers_licence
    fill_in "Email", with: @applicant.email
    fill_in "Finance application", with: @applicant.finance_application_id
    fill_in "Given names", with: @applicant.given_names
    fill_in "Licence state", with: @applicant.licence_state
    fill_in "Marital status", with: @applicant.marital_status
    fill_in "Other tax countries", with: @applicant.other_tax_countries
    fill_in "Phone", with: @applicant.phone
    fill_in "Residency status", with: @applicant.residency_status
    fill_in "Surname", with: @applicant.surname
    fill_in "Tin", with: @applicant.tin
    fill_in "Title", with: @applicant.title
    check "Us citizen" if @applicant.us_citizen
    click_on "Create Applicant"

    assert_text "Applicant was successfully created"
    click_on "Back"
  end

  test "should update Applicant" do
    visit applicant_url(@applicant)
    click_on "Edit this applicant", match: :first

    fill_in "Address", with: @applicant.address
    fill_in "Address postcode", with: @applicant.address_postcode
    fill_in "Address state", with: @applicant.address_state
    fill_in "Dependants", with: @applicant.dependants
    fill_in "Dob", with: @applicant.dob
    fill_in "Drivers licence", with: @applicant.drivers_licence
    fill_in "Email", with: @applicant.email
    fill_in "Finance application", with: @applicant.finance_application_id
    fill_in "Given names", with: @applicant.given_names
    fill_in "Licence state", with: @applicant.licence_state
    fill_in "Marital status", with: @applicant.marital_status
    fill_in "Other tax countries", with: @applicant.other_tax_countries
    fill_in "Phone", with: @applicant.phone
    fill_in "Residency status", with: @applicant.residency_status
    fill_in "Surname", with: @applicant.surname
    fill_in "Tin", with: @applicant.tin
    fill_in "Title", with: @applicant.title
    check "Us citizen" if @applicant.us_citizen
    click_on "Update Applicant"

    assert_text "Applicant was successfully updated"
    click_on "Back"
  end

  test "should destroy Applicant" do
    visit applicant_url(@applicant)
    accept_confirm { click_on "Destroy this applicant", match: :first }

    assert_text "Applicant was successfully destroyed"
  end
end
