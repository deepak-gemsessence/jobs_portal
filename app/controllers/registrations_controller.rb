class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  after_filter :methodss

  def edit
    resource.build_user_profile if resource.user_profile.blank?
    @skills = Skill.all
    @skills.each do |skill|
      unless resource.skills.map(&:id).include? skill.id
        resource.skill_sets.build(skill_id: skill.id)
      end
    end
  end

  def update
    super
  end

  protected

  def methodss
    # binding.pry
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :user_type, :username) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password, :first_name, :last_name, user_profile_attributes: [:graduation, :post_graduation, :contact, :address], skill_sets_attributes: [:id, :skill_id, :_destroy]) }
  end

  def after_inactive_sign_up_path_for(resource_or_scope)
    session["user_return_to"] || root_path
  end

end
