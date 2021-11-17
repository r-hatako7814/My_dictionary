class Customer::SearchesController < ApplicationController

  # def search
  #   @contributions = Contribution.search(params[:keyword])
  #   respond_to do |format|
  #     format.html
  #     format.json
  #   end
  # end
  
  def index_search
    @contributions = Contribution.order("created_at DESC").page(params[:page]).per(6).search(params[:search])
    @keyword = params[:keyword]
    render "customer/contributions/index"
  end
  
  def show_search
    @customer = current_customer
    @contributions = @customer.contributions.order("created_at DESC").page(params[:page]).per(6)
    @keyword = params[:keyword]
    render "customer/customers/show"
    Genre.all.each do |genre|
      @contribution.contribution_genres.build(genre_id: genre.id)
    end
    
  end
  
  
  
  private

  def contribution_params
    params.require(:contribution).permit(:title, :body, contribution_genres_attributes: [:genre_id])
  end
end
