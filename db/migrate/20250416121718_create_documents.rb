class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.references :applicant, null: false, foreign_key: true
      t.string :document_type
      t.string :file

      t.timestamps
    end
  end
end
