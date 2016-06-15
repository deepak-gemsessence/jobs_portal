class UserProfile < ActiveRecord::Base
  belongs_to :user

  validates :graduation, :post_graduation, :contact, :address, presence: true#, on: :create
end
