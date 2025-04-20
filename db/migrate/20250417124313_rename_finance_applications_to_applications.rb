class RenameFinanceApplicationsToApplications < ActiveRecord::Migration[7.1]
  def change
    rename_table :finance_applications, :applications
  end
end
