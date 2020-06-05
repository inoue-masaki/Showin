require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
    describe "#full_title" do
        content "page_title is empty" do
            it "removes symbol" do
                expect(helper.full_title).to eq('Lantern Lantern')
            end 
        end
        
        content "page_title is not empty" do
            it "returns title and application name where contains symbol" do
                expect(helper.full_title('hoge')).to eq('hoge | Lantern Lantern')
            end
        end
    end
end
