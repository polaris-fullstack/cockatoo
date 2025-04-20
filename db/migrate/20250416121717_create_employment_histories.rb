class CreateEmploymentHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :employment_histories do |t|
      t.references :applicant, null: false, foreign_key: true
      t.string :employer_name
      t.string :address
      t.string :state
      t.string :postcode
      t.string :phone
      t.string :occupation
      t.date :start_date
      t.date :end_date
      t.string :employment_type
      t.string :accountant_name
      t.string :accountant_firm
      t.string :accountant_phone

      t.timestamps
    end
  end
end
