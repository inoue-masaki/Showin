require 'rails_helper'

RSpec.describe "Microposts", type: :request do

  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }

  def post_valid_information
    post microposts_path, params: { micropost: { memo: "aaa" } }
  end

  def post_invalid_information
    post microposts_path, params: { micropost: { memo: nil } }
  end

  def patch_valid_information
    patch micropost_path, params: { micropost: { memo: "bbb" } }
  end

  def patch_invalid_information
    patch micropost_path, params: { micropost: { memo: nil } }
  end

  describe "POST /microposts" do
    it "does not add a micropost when not logged in" do
      expect{ post_valid_information }.not_to change(Micropost, :count)
      follow_redirect!
      expect(request.fullpath).to eq '/login'
    end

    it "does not add a micropost when the form has no information" do
      log_in_as(user)
      get user_path(user)
      expect{ post_invalid_information }.not_to change(Micropost, :count)
    end

    it "succeeds to add a micropost" do
      log_in_as(user)
      get user_path(user)
      expect(request.fullpath).to eq '/users/1'
      expect{ post_valid_information }.to change(Micropost, :count).by(1)
      follow_redirect!
      expect(request.fullpath).to eq '/users/1'
    end
  end

  describe "DELETE /micropost" do
    it "does not destroy a micropost when not logged in" do
      delete micropost_path(1)
      follow_redirect!
      expect(request.fullpath).to eq '/login'
    end

    it "does not destroy a micropost when other users logged in" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      delete logout_path
      log_in_as(other_user)
      get user_path(other_user)
      expect(request.fullpath).to eq '/users/2'
      post_valid_information
      expect{ delete micropost_path(1) }.not_to change(Micropost, :count)
      expect{ delete micropost_path(2) }.to change(Micropost, :count).by(-1)
    end

    it "succeeds to destroy a micropost" do
      log_in_as(user)
      get user_path(user)
      expect{ post_valid_information }.to change(Micropost, :count).by(1)
      follow_redirect!
      expect{ delete micropost_path(1) }.to change(Micropost, :count).by(-1)
      follow_redirect!
      expect(request.fullpath).to eq '/users/1'
      expect(flash[:success]).to be_truthy
    end
  end

  describe "GET /microposts/:id/edit" do
    it "does not edit a micropost when not logged in" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      delete logout_path
      follow_redirect!
      get edit_micropost_path(1)
      follow_redirect!
      expect(request.fullpath).to eq '/login'
    end

    it "does not edit a micropost when other users logged in" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      delete logout_path
      follow_redirect!
      log_in_as(other_user)
      get edit_micropost_path(1)
      follow_redirect!
      expect(request.fullpath).to eq '/'
    end

    it "does not edit a micropost when the form has no information" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      get edit_micropost_path(1)
      expect(request.fullpath).to eq '/microposts/1/edit'
      patch_invalid_information
      expect(request.fullpath).to eq '/microposts/1'
    end

    it "succeeds to edit a micropost" do
      log_in_as(user)
      get user_path(user)
      post_valid_information
      follow_redirect!
      get edit_micropost_path(1)
      expect(request.fullpath).to eq '/microposts/1/edit'
      patch_valid_information
      follow_redirect!
      expect(request.fullpath).to eq '/users/1'
    end
  end
end