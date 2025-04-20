require "test_helper"

class Jumpstart::PlansTest < ActionDispatch::IntegrationTest
  fixtures :plans

  test "redirects when there are no plans" do
    Plan.delete_all
    get "/pricing"
    assert_redirected_to root_url
  end

  test "view pricing page when there are plans" do
    get "/pricing"

    Plan.visible.find_each do |plan|
      assert_includes response.body, plan.name
    end
  end

  test "enterprise plan shows up" do
    get "/pricing"

    assert_select "a[href=?]", "mailto:user@example.com"
    assert_select "a", text: I18n.t("subscriptions.plan.contact_us")
    assert_select "span", text: I18n.t("subscriptions.plan.contact_us_price")
  end
end
