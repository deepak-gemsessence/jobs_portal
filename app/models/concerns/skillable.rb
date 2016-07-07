require 'active_support/concern'

module Skillable
  extend ActiveSupport::Concern

  included do
    has_many :skill_sets, as: :skillable
  end

end