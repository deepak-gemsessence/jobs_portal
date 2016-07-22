FactoryGirl.define do

  factory :comment do
    parent_id nil
    association :job
    association :user
    body 'first comment through rspecs'
  end

end