require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "#full_title" do
    context "page_title is empty" do
      it "removes symbol" do
        expect(helper.full_title).to eq('Lantern Lantern')
      end
    end

    context "page_title is not empty" do
      it "returns title and application name where contains symbol" do
        expect(helper.full_title('hoge')).to eq('hoge | Lantern Lantern')
      end
    end
  end
end