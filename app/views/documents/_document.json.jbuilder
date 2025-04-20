json.extract! document, :id, :applicant_id, :document_type, :file, :created_at, :updated_at
json.url document_url(document, format: :json)
