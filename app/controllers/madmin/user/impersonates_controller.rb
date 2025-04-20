class Madmin::User::ImpersonatesController < Madmin::ApplicationController
  def create
    user = ::User.find(params[:user_id])
    impersonate_user(user)
    redirect_to main_app.root_path, status: :see_other
  end

  def destroy
    user = current_user
    stop_impersonating_user
    redirect_to main_app.madmin_user_path(user), status: :see_other
  end
end
