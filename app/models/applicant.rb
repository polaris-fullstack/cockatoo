class Applicant < ApplicationRecord
  belongs_to :application
  has_many :employment_histories, dependent: :destroy
  has_many :documents, dependent: :destroy
  accepts_nested_attributes_for :employment_histories, allow_destroy: true
  accepts_nested_attributes_for :documents, allow_destroy: true

  broadcasts_refreshes
end
