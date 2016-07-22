FactoryGirl.define do

    factory :job do
      title 'xyz'
      location 'indore'
      expire_time Date.today + 1.week
      min_salary 20000
      max_salary 40000
      description 'greate job for you'
    end

end