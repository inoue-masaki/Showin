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
RSpec.describe "SiteLayouts",type: :system do
    
    describe "home layout" do
        it "return title with 'Lantern Lantern'" do
            visit root_path
            expect(page).to have_title 'Lantern Lantern'
        end 
    end
    
    describe "about layout" do
        it "returns title with 'About | Lantern Lantern'" do
            visit about_path
            expect(page).to have_title'About | Lantern Lantern'
        end
    end
end
