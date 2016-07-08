desc "it is dummy namespace"
namespace :dummy do
  task :dummy_task do
    puts "this is dummy_task"
  end
  task :another_task do
    Rake::Task['demo:first_task'].invoke
    puts "this is dummy_task's another_task which is invoking demo's first_task"
  end
end

# User.create!(email: 'deep.indore111@gmail.com', password: '123456', first_name: 'deepak', last_name: 'yadav', username: 'deep.indore', user_type: 'Job-recruiter')

