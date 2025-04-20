json.extract! applicant, :id, :finance_application_id, :title, :surname, :given_names, :dob, :drivers_licence, :licence_state, :marital_status, :dependants, :email, :phone, :address, :address_state, :address_postcode, :residency_status, :us_citizen, :tin, :other_tax_countries, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)
