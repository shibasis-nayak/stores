class RatingsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @product = Product.find(params[:product_id])
    
    @rating = Rating.new(rating_params)
    
    @rating.user = current_user
    @rating.product = @product
    
    if @rating.save
      redirect_to @product,
      notice: "Your rating and review have been submitted successfully."
    else
      redirect_to @product,
      alert: @rating.errors.full_messages.to_sentence
    end
  end
  
  private
  
  def rating_params
    params.require(:rating).permit(
    :rating,
    :review
    )
  end
end 