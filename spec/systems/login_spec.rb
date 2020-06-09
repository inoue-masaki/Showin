require 'rails_helper'

RSpec.describe "Logins", type: :system do

  let(:user) { create(:user) }

  def submit_with_invalid_information
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: ''
    find(".form-submit").click
  end

  def submit_with_valid_information(remember_me = 0)
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    check 'session_remember_me' if remember_me == 1
    find(".form-submit").click
  end

  describe "Login" do
    context "invalid" do
      it "has no information and has flash danger message" do
        visit login_path
        expect(page).to have_selector '.login-container'
        submit_with_invalid_information
        expect(current_path).to eq login_path
        expect(page).to have_selector '.login-container'
        expect(page).to have_selector '.alert-danger'
      end

      it "deletes flash messages when users input invalid information then other links" do
        visit login_path
        submit_with_invalid_information
        expect(current_path).to eq login_path
        visit root_path
        expect(page).not_to have_selector '.alert-danger'
      end
    end

    context "valid" do
      it "has valid information and will link to user path" do
        visit login_path
        submit_with_valid_information
        expect(current_path).to eq user_path(1)
        expect(page).to have_selector '.show-container'
      end

      it "contains logout button without login button at user path" do
        visit login_path
        submit_with_valid_information
        expect(current_path).to eq user_path(1)
        expect(page).to have_selector '.btn-logout-extend'
        expect(page).not_to have_selector '.btn-login-extend'
      end
    end
  end

  describe "Logout" do 
    it "contains login button without logout button at root path" do
      visit login_path
      submit_with_valid_information
      expect(current_path).to eq user_path(1)
      expect(page).to have_selector '.btn-logout-extend'
      expect(page).not_to have_selector '.btn-login-extend'
      click_on 'ログアウト'
      expect(current_path).to eq root_path
      expect(page).to have_selector '.home-container'
      expect(page).to have_selector '.btn-login-extend'
      expect(page).not_to have_selector '.btn-logout-extend'
    end
  end
end