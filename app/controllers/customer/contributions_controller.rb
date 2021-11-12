class Customer::ContributionsController < ApplicationController

  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.customer = current_customer
    @contribution.save!
    redirect_to customers_my_dictionary_path
  end

  def index
    @contributions = Contribution.order("created_at DESC").page(params[:page]).per(6)
  end

  def show
    @contribution = Contribution.find(params[:id])
    @customer = @contribution.customer
  end

  def edit
    @contribution = Contribution.find(params[:id])
  end

  def update
    @contribution = Contribution.find(params[:id])
    @contribution.update(contribution_params)
    redirect_to customers_my_dictionary_path
  end

  def destroy
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    redirect_to customers_my_dictionary_path
  end


  private

  def contribution_params
    params.require(:contribution).permit(:title, :body, contribution_genres_attributes: [:genre_id])
  end
end
