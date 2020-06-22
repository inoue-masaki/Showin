require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do

  let(:user) { create(:user) }

  describe "POST /password_resets" do
    it "is invalid email address" do
      get new_password_reset_path
      expect(request.fullpath).to eq '/password_resets/new'
      post password_resets_path, params: { password_reset: { email: "" } }
      expect(flash[:danger]).to be_truthy
      expect(request.fullpath).to eq '/password_resets'
    end

    it "is valid email address" do
      get new_password_reset_path
      expect(request.fullpath).to eq '/password_resets/new'
      post password_resets_path, params: { password_reset: { email: user.email } }
      expect(flash[:info]).to be_truthy
      expect(flash[:danger]).to be_falsey
      follow_redirect!
      expect(request.fullpath).to eq '/'
    end
  end

  describe "GET /password_resets/:id/edit" do
    it "is invalid email address" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: "")
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/password_resets/new'
    end


    it "is invalid user" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/password_resets/new'
      user.toggle!(:activated)
    end

    it "is invalid token" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path('wrong token', email: user.email)
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/password_resets/new'
    end

    it "is valid information" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(flash[:danger]).to be_falsey
      expect(request.fullpath).to eq "/password_resets/#{user.reset_token}/edit?email=#{CGI.escape(user.email)}"
    end
  end

  describe "PATCH /password_resets/:id" do
    it "is invalid password" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email)
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: "foobaz",
          password_confirmation: "barquux"
        }
      }
      expect(request.fullpath).to eq "/password_resets/#{user.reset_token}"
    end

    it "is empty password" do
    post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email)
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: "",
          password_confirmation: ""
        }
      }
      expect(request.fullpath).to eq "/password_resets/#{user.reset_token}"
    end

    it "has expired token" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      user.update_attribute(:reset_sent_at, 3.hours.ago)
      get edit_password_reset_path(user.reset_token, email: user.email)
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: "foobaz",
          password_confirmation: "foobaz"
        }
      }
      expect(flash[:danger]).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/password_resets/new'
    end

    it "is valid information" do
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email)
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: "foobaz",
          password_confirmation: "foobaz"
        }
      }
      expect(flash[:success]).to be_truthy
      expect(is_logged_in?).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq "/users/1"
    end
  end
end