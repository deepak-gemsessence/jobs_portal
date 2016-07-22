require "rails_helper"

RSpec.describe User, type: :model do

  describe "ActiveModel validations" do

    context 'registrations/new:' do
      it "create new user with all valid attributes" do
        expect(create(:user, user_type: 'recruiter')).to be_valid
        expect(create(:user)).to be_valid
      end
    end

    it "is invalid without username" do
      expect(build(:user, username: nil)).to_not be_valid
    end

    it "is invalid without fist_name" do
      expect(build(:user, first_name: nil)).to_not be_valid
    end

    it "is invalid without password" do
      expect(build(:user, password: nil)).to_not be_valid
    end

    it "is invalid without email" do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it "is invalid without user_type" do
      expect(build(:user, user_type: nil)).to_not be_valid
    end

  end

  describe "ActiveRecord associations" do

    it "has one user_profile" do
      asso = described_class.reflect_on_association(:user_profile)
      expect(asso.macro).to eq :has_one
    end

    it "has many skills through skill_sets" do
      asso = described_class.reflect_on_association(:skills)
      expect(asso.macro).to eq :has_many
    end

    it "has many apply_jobs" do
      asso = described_class.reflect_on_association(:apply_jobs)
      expect(asso.macro).to eq :has_many
    end

    it "has accept nested attributes for user_profile" do
      expect(described_class.reflect_on_all_autosave_associations.last.name).to eq :user_profile
    end

    it "has accept nested attributes for skill_sets" do
      expect(described_class.reflect_on_all_autosave_associations.first.name).to eq :skill_sets
    end

    it "has many jobs for 'recruiters'"

    it "has many applied_jobs through apply_jobs for 'seekers'"

    it "has many messages through apply_jobs" do
      asso = described_class.reflect_on_association(:messages)
      expect(asso.macro).to eq :has_many
    end

    it "has many comments" do
      asso = described_class.reflect_on_association(:comments)
      expect(asso.macro).to eq :has_many
    end

  end

  describe "#recruiters" do

    let(:user1){ create(:user, user_type: 'recruiter') }
    it "return all user which type is recruiter" do
      expect(User.recruiters).to eq [user1]
    end

  end

  describe ".is_applied_job?" do

    let(:user) { create(:user) }
    let(:job) { create(:job) }

    it "is false, if job is applied" do
      apply_job = create(:apply_job, user_id: user.id, job_id: job.id)
      expect(user.is_applied_job?(job)).to eq false
    end

    it "is false, if job is applied" do
      expect(user.is_applied_job?(job)).to eq true
    end

  end

  # describe "create user profile with associations" do

  #   it "create user profile for first user" do
  #     create(:user_with_user_profile)
  #   end

  # end

 end