require "rails_helper"

describe "User" do

  before(:each) do
    stub_request(:get, /api.cognitive.microsoft.com/).
    with(headers: {'Ocp-Apim-Subscription-Key'=>ENV['BING_API_KEY']}).
    to_return(body: File.read("./spec/fixtures/bing_search_results.json"))
  end

  scenario "Can disable a Topic" do
    user = create(:user)
    topic_1 = create(:topic, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("Status: enable")

    within(first(".topic_link")) do
      # expect(page).to have_content("Disable")
      click_on("Disable")
    end

     expect(page).to have_content("Status: disable")
     expect(page).to have_button("Enable")
  end

  scenario "Can enable a Topic" do
    user = create(:user)
    topic_1 = create(:topic, user_id: user.id, status: 'disable')
    topic_2= create(:topic, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    
    expect(page).to have_content("Status: disable")

    within(first(".topic_link")) do
      # expect(page).to have_content("Disable")
      click_on("Enable")
    end

     expect(page).to have_content("Status: enable")
     expect(page).to have_button("Disable")
  end
end
