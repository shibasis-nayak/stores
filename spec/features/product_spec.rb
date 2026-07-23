require "rails_helper"

RSpec.feature "Create Product", type: :feature do
  scenario "User creates a new product" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    category = Category.create!(name: "Electronics")

    visit products_path

    click_link "New Product"

    fill_in "Name", with: "Laptop"
    fill_in "Price", with: "50000"
    fill_in "Description", with: "Gaming Laptop"
    fill_in "Stock", with: "10"

    select "Electronics", from: "Category"

    click_button "Create Product"

    expect(page).to have_content("Laptop")
  end

  scenario "User deletes a product" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    category = Category.create!(name: "Electronics")

    Product.create!(
      name: "Laptop",
      price: 50000,
      description: "Gaming",
      stock: 5,
      category: category
    )

    visit products_path

    accept_confirm do
      click_link "Delete"
    end

    expect(page).not_to have_content("Laptop")
  end

   scenario "User edits a product" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    category = Category.create!(name: "Electronics")

    product = Product.create!(
      name: "Laptop",
      price: 50000,
      description: "Gaming",
      stock: 5,
      category: category
    )

    visit products_path

    click_link "Edit"

    fill_in "Name", with: "MacBook"

    click_button "Update Product"

    expect(page).to have_content("MacBook")
  end

  scenario "User searches for a product" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    category = Category.create!(name: "Electronics")

    Product.create!(
      name: "Laptop",
      price: 50000,
      description: "Gaming",
      stock: 5,
      category: category
    )

    visit products_path

    # fill_in "Enter Product Name", with: "Laptop"
    # fill_in "#name", with: "Laptop"
    find("input#name").set("Laptop")
    find("input#price").set("50000")

    click_button "Search"

    expect(page).to have_content("Laptop")
  end
end
