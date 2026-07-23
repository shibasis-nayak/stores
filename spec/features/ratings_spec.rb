require "rails_helper"

RSpec.feature "Product Ratings", type: :feature do
  scenario "User submits a rating and review successfully" do
    # Create a user

    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    login_as(user, scope: :user)

    # Create category
    category = Category.create!(
      name: "Electronics"
    )

    # Create product
    product = Product.create!(
      name: "Mobile",
      price: 30000,
      description: "Gaming Mobile",
      stock: 10,
      category: category
    )
    # Open product page
    visit product_path(product)

    # Fill rating form
    select "⭐⭐⭐⭐⭐ 5 Stars", from: "Rating"

    click_button "Submit Rating"

    # Expectations
    expect(page).to have_content("Your rating and review have been submitted successfully.")
    expect(page).to have_content("This mobile is really amazing for gaming.")
    expect(page).to have_content(user.email)
    expect(page).to have_content("5")
  end
end
