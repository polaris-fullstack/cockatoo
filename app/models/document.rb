class Document < ApplicationRecord
  broadcasts_refreshes
  belongs_to :applicant
end
