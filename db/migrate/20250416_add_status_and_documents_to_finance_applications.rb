class AddStatusAndDocumentsToFinanceApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :finance_applications, :status, :integer, default: 0, null: false
    # ActiveStorage handles documents attachment tables, so nothing else needed for documents here
  end
end
