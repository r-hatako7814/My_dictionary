class Customer::FavoritesController < ApplicationController

  def create
    @contribution = Contribution.find(params[:contribution_id])
    favorite = current_customer.favorites.new(contribution_id: @contribution.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @contribution = Contribution.find(params[:contribution_id])
    favorite = current_customer.favorites.find_by(contribution_id: @contribution.id)
    favorite.destroy
    # redirect_to request.referer
  end
end
