require 'active_support/concern'

module JobActions
  extend ActiveSupport::Concern

  included do
    before_action :get_job_id, only: [:show, :update, :edit, :destroy, :apply, :un_apply, :decline]
    before_action :all_skills, only: [:new, :create]
  end


end