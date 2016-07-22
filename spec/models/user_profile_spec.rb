require "rails_helper"

RSpec.describe UserProfile, type: :model do

  describe "ActiveModel validations" do

    it "is valid with all validations" do
      expect(create(:user_profile)).to be_valid
    end

    it "is invalid in absence of 'post_graduation'" do
      expect(build(:user_profile, post_graduation: nil)).to_not be_valid
    end

    it "is invalid in absence of 'graduation'" do
      expect(build(:user_profile, graduation: nil)).to_not be_valid
    end

    it "is invalid in absence of 'contact'" do
      expect(build(:user_profile, contact: nil)).to_not be_valid
    end

    it "is invalid in absence of 'address'" do
      expect(build(:user_profile, address: nil)).to_not be_valid
    end

  end


  describe "ActiveRecord associations" do

    it "belongs to user" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

  end

end