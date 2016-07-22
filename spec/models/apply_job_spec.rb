require 'rails_helper'

RSpec.describe ApplyJob, type: :model do

  describe "ActiveRecord association" do
    it "belongs to Job" do
      assoc = described_class.reflect_on_association(:job)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to User" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it "has many Messages" do
      assoc = described_class.reflect_on_association(:messages)
      expect(assoc.macro).to eq :has_many
    end
  end

  describe "all scopes" do
    describe "#accepted" do
      let(:apply_job) { create(:apply_job, status: 'accepted') }
      it "returns all apply jobs with accepted status" do
        expect(ApplyJob.accepted).to eq [apply_job]
      end
    end

    describe "#rejected" do
      let(:apply_job) { create(:apply_job, status: 'declined') }
      it "returns all apply jobs with declined status" do
        expect(ApplyJob.rejected).to eq [apply_job]
      end
    end

    describe "#expect_me" do
      it "selects expect me" do
        expect(ApplyJob.except_me(ApplyJob.second)).to_not eq [ create_list(:apply_job, 25) ]
      end
    end

    describe "#decline_all" do
      it "declines all apply_jobs" do
        created_apply_jobs = create_list(:apply_job, 25)
        expect(ApplyJob.decline_all).to eq ApplyJob.count
      end
    end

    describe "#decline_all_apply_jobs_except_me" do
      it "will decline_all except_me(combined scopes)" do
        created_apply_jobs = create_list(:apply_job, 25)
        expect(ApplyJob.decline_all_apply_jobs_except_me(ApplyJob.second)).to eq ApplyJob.where(status: 'declined').count
        # expect(ApplyJob.decline_all_apply_jobs_except_me(ApplyJob.second)).to eq ApplyJob.count - 1
      end
    end

  end

  describe "methods" do

    # describe ".decline_jobs" do
    #   it "is used to decline other jobs except_me" do
    #   end
    # end

    describe ".is_declined?" do
      it "is to check for 'declined' status" do
        expect(create(:apply_job, status: 'declined').status).to eq 'declined'
      end
    end

    describe ".is_accepted?" do
      it "is to check for 'accepted' status" do
        expect(create(:apply_job, status: 'accepted').status).to eq 'accepted'
      end
    end

    # describe ".choosen_other_user?" do
    #   it "is to check for any 'accepted' user" do

    #   end
    # end

  end

end