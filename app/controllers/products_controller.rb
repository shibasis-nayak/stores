class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all

    if params[:name].present?
      @products = @products.where(
        "LOWER(name) LIKE ?",
        "%#{params[:name].downcase}%"
      )
    end

    if params[:price].present?
      @products = @products.where(price: params[:price])
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Stock Filter
    if params[:stock_status].present?

      if params[:stock_status] == "in_stock"
        @products = @products.where("stock >= ?", 1)

      elsif params[:stock_status] == "out_of_stock"
        @products = @products.where(stock: 0)

      end
    end

    @products = @products.page(params[:page]).per(10)

    @categories = Category.all
  end

  def new
    @product = Product.new
  end

  def show
  @product = Product.find(params[:id])
  @rating = Rating.find_or_initialize_by(
    user: current_user,
    product: @product
  )
end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to "/products"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    uploaded_images = product_params[:images]
    update_params = product_params.except(:images)

    if @product.update(update_params)
      @product.images.attach(uploaded_images) if uploaded_images.present?
      redirect_to @product, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy

    redirect_to "/products", notice: "Product deleted successfully!"
  end

  def upload_images
    @product = Product.find(params[:id])

    if params[:product][:images].present?
      @product.images.attach(params[:product][:images])
      redirect_to @product, notice: "Images uploaded successfully."
    else
      redirect_to @product, alert: "Please select at least one image."
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :price,
      :description,
      :stock,
      :category_id,
      images: []
    )
  end
end