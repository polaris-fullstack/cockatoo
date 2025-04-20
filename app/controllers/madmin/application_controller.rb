module Madmin
  class ApplicationController < Madmin::BaseController
    before_action :authenticate_admin_user
    around_action :without_tenant if defined? ActsAsTenant

    impersonates :user

    def authenticate_admin_user
      redirect_to main_app.root_path unless true_user&.admin?
    end

    def without_tenant
      ActsAsTenant.without_tenant do
        yield
      end
    end
  end
end
