class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])

    @rating = Rating.find_or_initialize_by(
      user: current_user,
      product: @product
    )

    @rating.rating = params[:rating][:rating]

    if @rating.save
      redirect_to @product, notice: "Rating submitted successfully."
    else
      redirect_to @product, alert: @rating.errors.full_messages.to_sentence
    end
  end
end