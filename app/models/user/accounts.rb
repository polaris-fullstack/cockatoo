module User::Accounts
  extend ActiveSupport::Concern

  included do
    has_many :account_invitations, dependent: :nullify, foreign_key: :invited_by_id
    has_many :account_users, dependent: :destroy
    has_many :accounts, through: :account_users
    has_many :owned_accounts, class_name: "Account", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
    has_one :personal_account, -> { where(personal: true) }, class_name: "Account", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy

    after_create :create_default_account
    after_update :sync_personal_account_name, if: -> { Jumpstart.config.personal_accounts? }

    accepts_nested_attributes_for :owned_accounts, reject_if: :all_blank
  end

  def create_default_account
    if (account = accounts.where(personal: Jumpstart.config.personal_accounts?).first)
      return account
    end

    account = accounts.new(owner: self, name: name, personal: Jumpstart.config.personal_accounts?)
    account.account_users.new(user: self, admin: true)
    account.save!
    account
  end

  def sync_personal_account_name
    return unless first_name_previously_changed? || last_name_previously_changed?

    # Accepting an invitation calls this when the user's name is updated
    if personal_account.nil?
      create_default_account
      reload_personal_account
    else
      # Sync the personal account name with the user's name
      personal_account.update(name: name)
    end
  end
end
