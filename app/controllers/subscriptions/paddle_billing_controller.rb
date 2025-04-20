class Subscriptions::PaddleBillingController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :require_current_account_admin, only: :show

  # Paddle update / cancel renders here
  def edit
  end
end
