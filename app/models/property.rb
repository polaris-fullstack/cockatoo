class Property < ApplicationRecord
  broadcasts_refreshes
  belongs_to :application
end
