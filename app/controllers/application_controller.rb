class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # helper_method :show_messages

  def after_sign_in_path_for(resource)
    root_path
  end

  # def show_message
  #   "hello deepak"
  # end
end

