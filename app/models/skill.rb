class Skill < ActiveRecord::Base
  has_many :skill_sets, as: :skillable
  # has_many :skill_sets

  validates :name, presence: true

  # def self.search(search)
  #   where("name like ?", "%#{search}%")
  # end
end
