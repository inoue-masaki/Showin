require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user) { create(:user) }

  describe "GET /users/:id" do
    it "does not go to users/1 because of having not log in" do
      get user_path(user)
      follow_redirect!
      expect(request.fullpath).to eq '/login'
    end
  end
end