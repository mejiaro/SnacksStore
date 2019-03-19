class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin_only
    if user_signed_in?
      redirect_tor(root_path, flash: { alert: 'Access denied', alert_type: 'danger' }) unless current_user.admin?
    else
      redirect_to(root_path, flash: { alert: 'Access denied', alert_type: 'danger' })
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email password current_password])
  end
end
