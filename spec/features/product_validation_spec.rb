require "rails_helper"

RSpec.feature "Product Validations", type: :feature do
  #
  # Common setup for every scenario
  #
  before do
    @user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(@user, scope: :user)

    @category = Category.create!(
      name: "Electronics"
    )
  end

  scenario "User cannot create a product without a name" do
    visit new_product_path

    fill_in "Price", with: "50000"
    fill_in "Description", with: "Gaming Laptop"
    fill_in "Stock", with: "10"

    select "Electronics", from: "Category"

    click_button "Create Product"

    expect(page).to have_content("Name can't be blank")
  end

  scenario "User cannot create two products with the same name" do
    Product.create!(
      name: "Laptop",
      price: 50000,
      description: "Gaming Laptop",
      stock: 10,
      category: @category
    )

    visit new_product_path

    fill_in "Name", with: "Laptop"
    fill_in "Price", with: "60000"
    fill_in "Description", with: "Another Laptop"
    fill_in "Stock", with: "8"
    select "Electronics", from: "Category"
    click_button "Create Product"

    expect(page).to have_content("Name has already been taken")
  end

  scenario "User cannot create a product with negative stock" do
    visit new_product_path

    fill_in "Name", with: "Laptop"
    fill_in "Price", with: "50000"
    fill_in "Description", with: "Gaming Laptop"
    fill_in "Stock", with: "-5"
    select "Electronics", from: "Category"
    click_button "Create Product"

    expect(page).to have_content(
      "Stock must be greater than or equal to 0"
    )
  end

  scenario "User cannot create a product without price" do
    visit new_product_path

    fill_in "Name", with: "Laptop"
    fill_in "Description", with: "Gaming Laptop"
    fill_in "Stock", with: "5"
    select "Electronics", from: "Category"
    click_button "Create Product"

    expect(page).to have_content("Price can't be blank")
  end
end
