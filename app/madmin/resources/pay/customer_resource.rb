class Pay::CustomerResource < Madmin::Resource
  menu parent: "Payments", position: 1

  # Attributes
  attribute :id, form: false
  attribute :processor, form: false
  attribute :processor_id, form: false
  attribute :currency, form: false
  attribute :default, form: false
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :deleted_at
  attribute :stripe_account, form: false
  attribute :type, form: false
  attribute :braintree_account, form: false
  attribute :invoice_credit_balance, form: false

  # Associations
  attribute :owner
  attribute :charges, form: false
  attribute :subscriptions, form: false
  attribute :payment_methods, form: false
  attribute :default_payment_method, form: false

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end

  scope :stripe

  member_action do
    case @record.type
    when "Pay::Stripe::Customer"
      link_to "View on Stripe", ["https://dashboard.stripe.com", ("/test" if Pay::Stripe.public_key&.start_with?("pk_test")), "/customers/#{@record.processor_id}"].join, class: "btn btn-secondary", target: :_blank
    end
  end
end
