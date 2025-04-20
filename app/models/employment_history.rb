class EmploymentHistory < ApplicationRecord
  broadcasts_refreshes
  belongs_to :applicant
end
