require "rails_helper"

RSpec.feature "Create Category", type: :feature do
  scenario "User creates a new category" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    visit categories_path

    click_link "New Category"
    fill_in "Name", with: "Electronics"
    click_button "Create Category"

    expect(page).to have_content("Electronics")
  end
  scenario "User views a category" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    category = Category.create!(
      name: "Electronics"
    )

    visit categories_path

    click_link "Show"

    expect(page).to have_content("Electronics")
  end
  scenario "User deletes a category" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    category = Category.create!(
      name: "Electronics"
    )

    visit categories_path

    accept_confirm do
      click_link "Delete"
    end

    expect(page).not_to have_content("Electronics")
  end
  scenario "User edits an existing category" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    category = Category.create!(
      name: "Electronics"
    )

    visit categories_path

    click_link "Edit"

    fill_in "Name", with: "Mobile"

    click_button "Update Category"

    expect(page).to have_content("Mobile")
    expect(page).not_to have_content("Electronics")
  end
end
