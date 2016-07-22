class Skill < ActiveRecord::Base
  has_many :skill_sets
  has_many :jobs, through: :skill_sets, source: :skill

  validates :name, presence: true
end
