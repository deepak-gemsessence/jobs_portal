class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def edit
    resource.build_user_profile if resource.user_profile.blank?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :user_type, :username) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password, :first_name, :last_name, user_profile_attributes: [:graduation, :post_graduation, :contact, :address]) }
  end

  def after_inactive_sign_up_path_for(resource_or_scope)
    session["user_return_to"] || root_path
  end

end
