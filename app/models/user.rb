class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :user_profile
  accepts_nested_attributes_for :user_profile

  validates :username, uniqueness: true
  validates :first_name, :last_name, :username, presence: true
end
