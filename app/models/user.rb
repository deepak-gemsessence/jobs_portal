class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :user_profile, dependent: :destroy
  accepts_nested_attributes_for :user_profile
  has_many :skill_sets, as: :skillable
  has_many :skills, through: :skill_sets
  accepts_nested_attributes_for :skill_sets, allow_destroy: true

  validates :username, uniqueness: true
  validates :first_name, :last_name, :username, presence: true

  # GRADUATION = [['B.A.', 'B.A.'], ['B.B.A.', 'B.B.A.'], ['B.Com', 'B.Com'], ['B.C.A.', 'B.C.A.'], ['B.E.', 'B.E.'], ['B.Sc', 'B.Sc']].freeze
  # POST_GRADUATION = [['M.A.', 'M.A.'], ['M.B.A.', 'M.B.A.'], ['M.Com', 'M.Com'], ['M.C.A.', 'M.C.A.'], ['M.E.', 'M.E.'], ['M.Sc', 'M.Sc']].freeze

  GRAD = ['B.A.', 'B.B.A.', 'B.Com', 'B.C.A.', 'B.E.', 'B.Sc']
  POST_GRAD = ['M.A.', 'M.B.A.', 'M.Com', 'M.C.A.', 'M.E.', 'M.Sc']
end
