namespace :products do
  desc "Create 100 sample products"

  task seed_products: :environment do
    category = Category.first

    if category.nil?
      puts "No category found. Please create a category first."
      #next
    end

    fashion_category = Category.find_or_create_by(name: "Fashion") || category
    100.times do |i|
      Product.create!(
        name: "Product #{i + 1} #{SecureRandom.hex(4)}",
        price: rand(100..1000),
        description: "Description for Product #{i + 1} #{SecureRandom.hex(4)}",
        category: fashion_category
      )
    end

    puts "100 products created successfully!"
  end
end