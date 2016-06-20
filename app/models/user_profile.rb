class UserProfile < ActiveRecord::Base
  belongs_to :user

  validates :graduation, :post_graduation, :contact, :address, presence: true
  validates :contact, format: { with: /\A(\+1)?[0-9]{10}\z/, message: "Not a valid 10-digit telephone number" }, on: :create
end
