require "rails_helper"

RSpec.describe Product, type: :model do
  it "creates a product successfully" do
    category = Category.create!(
      name: "Electronics"
    )

    product = Product.create(
      name: "Laptop",
      price: 50000,
      description: "Gaming Laptop",
      stock: 10,
      category: category
    )

    expect(product).to be_persisted
    expect(product.name).to eq("Laptop")
  end
end
