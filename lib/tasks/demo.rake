desc "it is demo namespace"
namespace :demo do

  desc "this is first task"
  task first_task: :environment do
    puts "hello deepak for first_task"
  end

  desc "this is second task"
  task second_task: :environment do
    name = ENV["name"] || 'deepak'
    puts "hello #{name} for second_task"
  end

  task combined: [:second_task, :first_task] do
    puts "all tasks"
  end

end
# task default: 'demo:first_task'
