require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:user) { create(:user) }

  # 中略
  describe "password_reset" do
    it "renders mails" do
      user.reset_token = User.new_token
      mail = UserMailer.password_reset(user)
      expect(mail.subject).to eq "【重要】Lantern Lanternよりパスワード再設定のためのメールを届けました"
      expect(mail.to).to eq ["michael@example.com"]
      expect(mail.from).to eq ["noreply@example.com"]
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include "Michael Example"
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include user.reset_token
      expect(mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join).to include CGI.escape(user.email)
    end
  end
end