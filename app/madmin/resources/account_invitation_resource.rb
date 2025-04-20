class AccountInvitationResource < Madmin::Resource
  menu false

  # Attributes
  attribute :id, form: false
  attribute :token
  attribute :name
  attribute :email
  attribute :created_at, form: false
  attribute :updated_at, form: false

  AccountUser::ROLES.each do |role|
    attribute role, :boolean
  end

  # Associations
  attribute :account, form: false
  attribute :invited_by

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

  def self.model_find(id)
    model.find_by(token: id)
  end
end
