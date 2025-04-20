class AddLoanAmountAndLikelihoodToFinanceApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :finance_applications, :loan_amount, :integer
    add_column :finance_applications, :likelihood_of_approval, :float
  end
end
