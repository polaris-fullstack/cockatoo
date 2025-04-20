class CreateApplicants < ActiveRecord::Migration[8.0]
  def change
    create_table :applicants do |t|
      t.references :finance_application, null: false, foreign_key: true
      t.string :title
      t.string :surname
      t.string :given_names
      t.date :dob
      t.string :drivers_licence
      t.string :licence_state
      t.string :marital_status
      t.integer :dependants
      t.string :email
      t.string :phone
      t.string :address
      t.string :address_state
      t.string :address_postcode
      t.string :residency_status
      t.boolean :us_citizen
      t.string :tin
      t.string :other_tax_countries

      t.timestamps
    end
  end
end
