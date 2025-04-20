class AccountResource < Madmin::Resource
  menu parent: "Users & Accounts"

  # Attributes
  attribute :id, form: false
  attribute :name
  attribute :personal
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :extra_billing_info
  attribute :domain
  attribute :subdomain
  attribute :billing_email
  attribute :account_users_count, form: false
  attribute :avatar, index: false

  # Associations
  attribute :pay_customers, form: false
  attribute :charges, form: false
  attribute :subscriptions, form: false
  attribute :payment_processor, form: false
  attribute :owner, form: false
  attribute :account_invitations, form: false
  attribute :account_users, form: false
  attribute :users, form: false

  # Uncomment this to customize the display name of records in the admin area.
  def self.display_name(record)
    record.name
  end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
