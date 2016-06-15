class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # before_filter :mailer_set_url_options

  def after_sign_in_path_for(resource)
    welcome_index_path
  end

  # def mailer_set_url_options
  #   ActionMailer::Base.default_url_options[:host] = request.host_with_port
  # end

end

