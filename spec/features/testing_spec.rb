require "rails_helper"

RSpec.describe "Visit HomePage", type: :feature do
  it "shows the home page" do
    visit "/"

    expect(page).to have_content("Welcome to My Store")
    expect(page).to have_content("Discover amazing products at the best prices.")
    expect(page).to have_content("Start Shopping Today!")
    expect(page).to have_content("welcome to My Store")
  end
end
