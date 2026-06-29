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

    @products = @products.page(params[:page]).per(10)

    @categories = Category.all
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
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

    if @product.update(product_params)
      redirect_to "/products"
    else
      render :edit
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
    :category_id,
    images: []
  )
end

end