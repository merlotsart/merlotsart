require "rails_helper"

RSpec.describe "A visitor places an order", type: :feature do

  scenario "A visitor visits the home page" do

    visit "/"

    expect(page).to have_content "It's easy to get started"
  end
end
