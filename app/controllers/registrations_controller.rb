class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def edit
    resource.build_user_profile if resource.user_profile.blank?
    @skills = Skill.all
    # @skills.each do |skill|
    #   unless resource.skills.map(&:id).include? skill.id
    #     resource.skill_sets.build(skill_id: skill.id)
    #   end
    # end
    #build_skill_sets
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      #build_skill_sets if resource.errors.any?
      respond_with resource
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :user_type, :username) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password, :first_name, :last_name, user_profile_attributes: [:graduation, :post_graduation, :contact, :address], skill_sets_attributes: [:id, :skill_id, :_destroy]) }
  end

  def after_inactive_sign_up_path_for(resource_or_scope)
    session["user_return_to"] || root_path
  end

  private

  # def build_skill_sets
  #   @skills = Skill.all
  #   @skills.each do |skill|
  #     resource.skill_sets.build(skill_id: skill.id) if !resource.skill_sets.map(&:skill_id).include? skill.id
  #   end
  # end

end
