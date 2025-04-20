class AddIncomeAndExpensesToApplicants < ActiveRecord::Migration[8.0]
  def change
    add_column :applicants, :income, :decimal
    add_column :applicants, :expenses, :decimal
  end
end
