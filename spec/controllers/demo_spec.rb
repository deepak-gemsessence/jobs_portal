RSpec.describe "something" do
  it "does something" do
    # binding.pry
    puts "hello"
  end
end

RSpec.describe "third group" do
  it "first example in third group" do; end
  context "nested group" do
    it "first example in nested group" do; end
    it "second example in nested group" do; end
  end
end

#  to run this :- rspec demo_spec.rb -fdoc