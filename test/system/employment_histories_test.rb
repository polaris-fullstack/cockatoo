require "application_system_test_case"

class EmploymentHistoriesTest < ApplicationSystemTestCase
  setup do
    @employment_history = employment_histories(:one)
  end

  test "visiting the index" do
    visit employment_histories_url
    assert_selector "h1", text: "Employment histories"
  end

  test "should create employment history" do
    visit employment_histories_url
    click_on "New employment history"

    fill_in "Accountant firm", with: @employment_history.accountant_firm
    fill_in "Accountant name", with: @employment_history.accountant_name
    fill_in "Accountant phone", with: @employment_history.accountant_phone
    fill_in "Address", with: @employment_history.address
    fill_in "Applicant", with: @employment_history.applicant_id
    fill_in "Employer name", with: @employment_history.employer_name
    fill_in "Employment type", with: @employment_history.employment_type
    fill_in "End date", with: @employment_history.end_date
    fill_in "Occupation", with: @employment_history.occupation
    fill_in "Phone", with: @employment_history.phone
    fill_in "Postcode", with: @employment_history.postcode
    fill_in "Start date", with: @employment_history.start_date
    fill_in "State", with: @employment_history.state
    click_on "Create Employment history"

    assert_text "Employment history was successfully created"
    click_on "Back"
  end

  test "should update Employment history" do
    visit employment_history_url(@employment_history)
    click_on "Edit this employment history", match: :first

    fill_in "Accountant firm", with: @employment_history.accountant_firm
    fill_in "Accountant name", with: @employment_history.accountant_name
    fill_in "Accountant phone", with: @employment_history.accountant_phone
    fill_in "Address", with: @employment_history.address
    fill_in "Applicant", with: @employment_history.applicant_id
    fill_in "Employer name", with: @employment_history.employer_name
    fill_in "Employment type", with: @employment_history.employment_type
    fill_in "End date", with: @employment_history.end_date
    fill_in "Occupation", with: @employment_history.occupation
    fill_in "Phone", with: @employment_history.phone
    fill_in "Postcode", with: @employment_history.postcode
    fill_in "Start date", with: @employment_history.start_date
    fill_in "State", with: @employment_history.state
    click_on "Update Employment history"

    assert_text "Employment history was successfully updated"
    click_on "Back"
  end

  test "should destroy Employment history" do
    visit employment_history_url(@employment_history)
    accept_confirm { click_on "Destroy this employment history", match: :first }

    assert_text "Employment history was successfully destroyed"
  end
end
