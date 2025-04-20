class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.string :address
      t.string :status
      t.date :purchase_date
      t.integer :amount

      t.timestamps
    end
  end
end
