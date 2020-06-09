require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  include SessionsHelper

  def post_invalid_information
    post signup_path, params: {
      user: {
        name: "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar"
      }
    }
  end

  def post_valid_information
    post signup_path, params: {
      user: {
        name: "Example User",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      }
    }
  end

  describe "GET /signup" do
    it "is invalid signup information" do
      get signup_path
      expect { post_invalid_information }.not_to change(User, :count)
      expect(is_logged_in?).to be_falsey
    end

    it "is valid signup information" do
      get signup_path
      expect { post_valid_information }.to change(User, :count).by(1)
      expect(is_logged_in?).to be_truthy
      follow_redirect!
      expect(request.fullpath).to eq '/users/1'
    end
  end
end