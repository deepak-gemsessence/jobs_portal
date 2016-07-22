FactoryGirl.define do

  # factory :user, class: User do
  factory :user, aliases: [:recruiter, :seeker] do
    sequence(:email, 10) { |n| "deepakg#{n}@yopmail.com" }
    sequence(:username, 10) { |n| "deepakg#{n}" }
    password '123456'
    first_name 'deepak'
    user_type 'Job-seeker'
    # factory :user_with_user_profile do
    #   after(:create) do |user|
    #     create(:user_profile, user: user)
    #   end
    # end
  end

end