class PlanResource < Madmin::Resource
  menu parent: "Payments", position: 0

  scope :visible
  scope :hidden

  # Attributes
  attribute :id, form: false
  attribute :hidden, index: true
  attribute :name, description: "User-facing name for this plan"
  attribute :description, description: "A short description for this plan"
  attribute :amount, description: "Amount in cents for the plan", index: true
  attribute :currency
  attribute :interval, :select, collection: ["month", "year"], index: true
  attribute :interval_count
  attribute :contact_url, description: "Contact link for enterprise plans"
  attribute :trial_period_days
  attribute :charge_per_unit, description: "Used for per-seat pricing"
  attribute :unit_label, description: "The label for per-seat pricing. For example: \"user\""
  attribute :stripe_tax, :boolean do |config|
    config.description = "Automatically collect tax with Stripe?"
  end
  attribute :stripe_id, label: "Stripe ID"
  attribute :paddle_billing_id, label: "Paddle Billing ID"
  attribute :paddle_classic_id, label: "Paddle Classic ID"
  attribute :lemon_squeezy_id, label: "Lemon Squeezy ID"
  attribute :braintree_id, label: "Braintree ID"
  attribute :fake_processor_id, label: "Fake Processor ID"
  attribute :features, field: ArrayField
  attribute :created_at, form: false
  attribute :updated_at, form: false

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
end
