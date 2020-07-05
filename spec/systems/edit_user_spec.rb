require 'rails_helper'

RSpec.describe "EditUser", type: :system do

  let(:user) { create(:user) }

  def valid_information(remember_me = 0)
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    check 'session_remember_me' if remember_me == 1
    find(".form-submit").click
  end

  describe "GET /users/:id/edit" do
    it "can press submit button when check button is pressed" do
      visit login_path
      valid_information
      visit edit_user_path(user)
      check 'microposts_reset_time'
      click_on 'microposts_reset_time_submit'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector '.alert-success'
    end
  end
end