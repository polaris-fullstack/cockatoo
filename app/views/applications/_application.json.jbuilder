json.extract! application, :id, :purpose, :first_time_owner, :fhog_eligible, :property_address, :property_state, :property_postcode, :purchase_price, :dwelling_age, :assets, :liabilities, :income, :expenses, :declaration, :created_at, :updated_at
json.url application_url(application, format: :json)
