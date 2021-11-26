class Customer::ContributionsController < ApplicationController
before_action :authenticate_customer!
before_action :ensure_current_customer, {only: [:edit, :update]}


  def create
    @customer = Customer.find(params[:id])
    @contribution = Contribution.new(contribution_params)
    @contribution.customer = current_customer
    @contribution.save!
    redirect_to customers_my_dictionary_path(current_customer)
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
    if @contribution.update(contribution_params)
      redirect_to customers_my_dictionary_path(current_customer)
    else
      render "customer/contribution/edit"
    end
  end

  def destroy
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    redirect_to customers_my_dictionary_path(current_customer)
  end

  def index_search
    @keyword = params[:keyword]
    @contributions = Contribution.order("created_at DESC").page(params[:page]).per(6).search(params[:keyword])
    render "customer/contributions/index"
  end

  def autocomplete_index_search
    contributions = Contribution.where(["title like?", "%#{params[:keyword]}%"]).limit(5).pluck(:title).reject(&:blank?) #Contribution.by_title_like?(params[:keyword]).pluck(:title).reject(&:blank?)
    render json: contributions
  end

  def ensure_current_customer
    if current_customer.id != params[:id].to_i
      redirect_to contributions_path
    end
  end

  private

  def contribution_params
    params.require(:contribution).permit(:title, :body, contribution_genres_attributes: [:genre_id])
  end
end