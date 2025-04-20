class AddMoreDetailsToProperties < ActiveRecord::Migration[8.0]
  def change
    change_table :properties do |t|
      t.string :title_reference
      t.string :lot_number
      t.date :estimated_completion_date
      t.string :construction_type
      t.string :floor_area
      t.date :valuation_date
      t.boolean :tenanted
      t.date :lease_expiry_date
      t.decimal :council_rates, precision: 10, scale: 2
      t.decimal :strata_fees, precision: 10, scale: 2
      t.string :insurance_details
      t.string :energy_rating
    end
  end
end
