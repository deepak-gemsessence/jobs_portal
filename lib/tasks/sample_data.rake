namespace :sample_data do

  desc "creating multiple users"
  task create_user: :environment do
    email_name, first_name, last_name, username = '@yopmail.com', 'hi', 'hello', 'testing'
    (1..10).each do |var|
      first = first_name+var.to_s
      last = last_name+var.to_s
      user_name = username+var.to_s
      email = user_name+email_name
      # puts email, first, last, user_name
      # puts
      User.create!(first_name: first, last_name: last, username: user_name, user_type: 'Job-recruiter', email: email, password: '123456')
    end
    # User.create!(email: 'deep@yopmail.com', password: '123456', first_name: 'deepak', last_name: 'yadav', username: 'deep@yopmail', user_type: 'Job-recruiter')
  end

end
