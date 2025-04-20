require "application_system_test_case"

class PropertiesTest < ApplicationSystemTestCase
  setup do
    @property = properties(:one)
  end

  test "visiting the index" do
    visit properties_url
    assert_selector "h1", text: "Properties"
  end

  test "should create property" do
    visit properties_url
    click_on "New property"

    fill_in "Address", with: @property.address
    fill_in "Amount", with: @property.amount
    fill_in "Purchase date", with: @property.purchase_date
    fill_in "Status", with: @property.status
    click_on "Create Property"

    assert_text "Property was successfully created"
    click_on "Back"
  end

  test "should update Property" do
    visit property_url(@property)
    click_on "Edit this property", match: :first

    fill_in "Address", with: @property.address
    fill_in "Amount", with: @property.amount
    fill_in "Purchase date", with: @property.purchase_date
    fill_in "Status", with: @property.status
    click_on "Update Property"

    assert_text "Property was successfully updated"
    click_on "Back"
  end

  test "should destroy Property" do
    visit property_url(@property)
    accept_confirm { click_on "Destroy this property", match: :first }

    assert_text "Property was successfully destroyed"
  end
end
