json.extract! employment_history, :id, :applicant_id, :employer_name, :address, :state, :postcode, :phone, :occupation, :start_date, :end_date, :employment_type, :accountant_name, :accountant_firm, :accountant_phone, :created_at, :updated_at
json.url employment_history_url(employment_history, format: :json)
