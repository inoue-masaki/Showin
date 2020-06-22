require 'rails_helper'

RSpec.describe Micropost, type: :model do

  let(:user) { create(:user) }
  let(:micropost) { user.microposts.build(time: 240, memo: "Lorem ipsum", user_id: user.id) }

  describe "Micropost" do
    it "should be valid" do
      expect(micropost).to be_valid
    end

    it "should not be valid" do
      micropost.update_attributes(time: 1, memo: "  ", picture: nil, user_id: user.id)
      expect(micropost).to be_valid
      micropost.update_attributes(time: nil, memo: "  ", picture: nil, user_id: user.id)
      expect(micropost).to be_invalid
    end

    it "should be most recent first" do
      create(:memos, :memo_1, created_at: 10.minutes.ago)
      create(:memos, :memo_2, created_at: 3.years.ago)
      create(:memos, :memo_3, created_at: 2.hours.ago)
      memo_4 = create(:memos, :memo_4, created_at: Time.zone.now)
      expect(Micropost.first).to eq memo_4
    end
  end

  describe "user_id" do
    it "should not be present" do
      micropost.user_id = nil
      expect(micropost).to be_invalid
    end
  end

  describe "memo" do
    it "should not be at most 255 characters" do
      micropost.memo = "a" * 255
      expect(micropost).to be_valid
      micropost.memo = "a" * 256
      expect(micropost).to be_invalid
    end
  end
  
  describe "picture" do
    it "should be valid if all columns are nil except picture" do
      micropost.update_attributes(time: nil, memo: nil, user_id: user.id)
      expect(micropost).to be_invalid
      micropost.picture.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test.jpg')), filename: 'test.jpg', content_type: 'image/jpg')
      expect(micropost).to be_valid
    end

    it "should not be over than 5MB" do
      micropost.picture.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test_5mb.jpg')), filename: 'test_5mb.jpg', content_type: 'image/jpg')
      expect(micropost).to be_invalid
    end

    it "should be only images file" do
      micropost.picture.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test.pdf')), filename: 'test.pdf', content_type: 'application/pdf')
      expect(micropost).to be_invalid
    end
  end
end