class AddDetailsToProperties < ActiveRecord::Migration[8.0]
  def change
    change_table :properties do |t|
      t.references :finance_application, null: true, foreign_key: true
      t.string :property_type
      t.string :occupancy_type
      t.string :property_state
      t.string :property_postcode
      t.integer :purchase_price
      t.string :dwelling_age
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :car_spaces
      t.boolean :newly_built
      t.boolean :off_the_plan
      t.boolean :strata_title
      t.string :land_size
      t.decimal :rental_income, precision: 12, scale: 2
      t.decimal :outstanding_loan_amount, precision: 12, scale: 2
      t.string :current_lender
      t.string :zoning
      t.string :property_usage
      t.text :property_notes
    end
    # Remove fields from properties that are now handled by the new columns
    remove_column :properties, :status, :string
    remove_column :properties, :purchase_date, :date
    remove_column :properties, :amount, :integer
    # Remove property fields from finance_applications if present
    remove_column :finance_applications, :property_address, :string, if_exists: true
    remove_column :finance_applications, :property_state, :string, if_exists: true
    remove_column :finance_applications, :property_postcode, :string, if_exists: true
    remove_column :finance_applications, :purchase_price, :integer, if_exists: true
    remove_column :finance_applications, :dwelling_age, :string, if_exists: true
  end
end
