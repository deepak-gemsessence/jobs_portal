require "rails_helper"

RSpec.describe Comment, type: :model do
  it "create new comment" do
    parent =  create(:comment)
    comment =  create(:comment, parent_id: parent.id)
  end
  it "delete last comment"

end

