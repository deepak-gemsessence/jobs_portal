require "rails_helper"

RSpec.describe Skill, type: :model do

  describe "ActiveModel validations" do

    it "is valid if all validations are present" do
      expect(create(:skill)).to be_valid
    end

    it "is invalid name is nil" do
      expect(build(:skill, name: nil)).to_not be_valid
    end

  end

  describe "ActiveRecord association" do

    it "has many Skill sets" do
      assoc = described_class.reflect_on_association(:skill_sets)
      expect(assoc.macro).to eq :has_many
    end

    it "has many Jobs through Skill sets" do
      assoc = described_class.reflect_on_association(:jobs)
      expect(assoc.macro).to eq :has_many
    end

  end

end