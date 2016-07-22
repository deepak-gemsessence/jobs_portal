FactoryGirl.define do

  factory :user_profile do
    graduation 'bca'
    post_graduation 'mca'
    contact '9977732004'
    address 'indore'
    user
    # association :seeker, factory: :user
  end

end