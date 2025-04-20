module Loan
  class FinanceApplication < ApplicationRecord
    # Explicitly set the table name to match the database schema
    self.table_name = 'applications'
    
    has_many :applicants, dependent: :destroy
    has_many :properties, dependent: :destroy
    has_many_attached :documents

    enum :status, %i[draft complete]
    
    # Set default status to draft
    after_initialize :set_default_status, if: :new_record?

    validates :purpose, presence: true, unless: :draft?

    accepts_nested_attributes_for :properties, allow_destroy: true

    def draft?
      status == "draft"
    end
    
    private
    
    def set_default_status
      self.status ||= :draft
    end
  end
end
