FactoryGirl.define do

  factory :apply_job do
    association :user
    association :job
  end

end