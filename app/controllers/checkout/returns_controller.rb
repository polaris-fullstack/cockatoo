class Checkout::ReturnsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_account_admin

  def show
    object = Pay.sync(params)

    if object.is_a?(Pay::Charge)
      flash[:notice] = t(".success")
    elsif object.is_a?(Pay::Subscription) && object.active?
      flash[:notice] = t("subscriptions.created")
    else
      flash[:alert] = t("something_went_wrong")
    end

    redirect_to params.fetch(:return_to, root_path)
  end
end
