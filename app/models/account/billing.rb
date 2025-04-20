module Account::Billing
  extend ActiveSupport::Concern

  included do
    pay_customer

    define_method :pay_should_sync_customer? do
      saved_change_to_owner_id? || saved_change_to_billing_email?
    end
  end

  # Email address used for Pay customers and receipts
  # Defaults to billing_email if defined, otherwise uses the account owner's email
  def email
    billing_email? ? billing_email : owner.email
  end

  # Used for per-unit subscriptions on create and update
  # Returns the quantity that should be on the subscription
  def per_unit_quantity
    account_users_count
  end
end
