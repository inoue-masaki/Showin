require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  include SessionsHelper

  let(:user) { create(:user) }
  let(:no_activation_user) { create(:no_activation_user) }

  def post_invalid_information
    post login_path, params: {
      session: {
        email: "",
        password: ""
      }
    }
  end

  def post_valid_information(remember_me = 0)
    post login_path, params: {
      session: {
        email: user.email,
        password: user.password,
        remember_me: remember_me
      }
    }
  end

  describe "GET /login" do
    context "invalid form information" do
      it "fails having a danger flash message" do
        get login_path
        post_invalid_information
        expect(flash[:danger]).to be_truthy
        expect(is_logged_in?).to be_falsey
        expect(request.fullpath).to eq '/login'
      end
      
      it "fails having a danger flash message" do
        get login_path
        post_invalid_information
        expect(flash[:danger]).to be_truthy
        expect(is_logged_in?).to be_falsey
        expect(request.fullpath).to eq '/login'
      end

      it "fails because they have not activated account" do
        get login_path
        post_valid_information(no_activation_user)
        expect(flash[:danger]).to be_truthy
        expect(is_logged_in?).to be_falsey
        follow_redirect!
        expect(request.fullpath).to eq '/'
      end

      it "succeeds having no danger flash message" do
        get login_path
        post_valid_information(user)
        expect(flash[:danger]).to be_falsey
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/users/1'
      end
    end

    context "valid form information" do
      it "succeeds having no danger flash message" do
        get login_path
        post_valid_information
        expect(flash[:danger]).to be_falsey
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/users/1'
      end

      it "succeeds logout" do
        get login_path
        post_valid_information
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/users/1'
        delete logout_path
        expect(is_logged_in?).to be_falsey
        follow_redirect!
        expect(request.fullpath).to eq '/'
      end

      it "does not log out twice" do
        get login_path
        post_valid_information
        expect(is_logged_in?).to be_truthy
        follow_redirect!
        expect(request.fullpath).to eq '/users/1'
        delete logout_path
        expect(is_logged_in?).to be_falsey
        follow_redirect!
        expect(request.fullpath).to eq '/'
        delete logout_path
        follow_redirect!
        expect(request.fullpath).to eq '/'
      end

      it "succeeds remember_token because of check remember_me" do
        get login_path
        post_valid_information(1)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).not_to be_empty
      end

      it "has no remember_token because of check remember_me" do
        get login_path
        post_valid_information(0)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).to be_nil
      end

      it "has no remember_token when users logged out and logged in" do
        get login_path
        post_valid_information(1)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).not_to be_empty
        delete logout_path
        expect(is_logged_in?).to be_falsey
        expect(cookies[:remember_token]).to be_empty
      end
    end
  end
end