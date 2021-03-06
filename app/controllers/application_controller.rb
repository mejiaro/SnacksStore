class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin_only
    if user_signed_in?
      error(root_path, 'Access denied') unless current_user.admin?
    else
      error(root_path, 'Access denied')
    end
  end

  def user_only
    if user_signed_in?
      error(root_path, 'Access denied') if current_user.admin?
    else
      error(root_path, 'Access denied')
    end
  end

  def error(path, message)
    redirect_to(path, flash: {
                  alert: message.to_s, alert_type: 'danger'
                }) && return
  end

  def success(path, message)
    redirect_to(path,
                flash: { alert: message.to_s,
                         alert_type: 'success' }) && return
  end

  def success_back(message)
    redirect_back(fallback_location:
      root_path, flash: { alert: message, alert_type: 'success' })
  end

  def error_back(message)
    redirect_back(fallback_location:
      root_path, flash: { alert: message, alert_type: 'danger' })
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i[username email password]
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i[username email password current_password]
    )
  end
end
