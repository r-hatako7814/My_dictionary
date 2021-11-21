class Customer::CustomersController < ApplicationController

  def show
    @customer = current_customer
    @contribution = Contribution.new
    @contributions = @customer.contributions.order("created_at DESC").page(params[:page]).per(6)
    Genre.all.each do |genre|
      @contribution.contribution_genres.build(genre_id: genre.id)
    end
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_dictionary_path
      flash[:notice_customer] = "会員情報が更新されました。"
    else
      @customer = current_customer
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to new_customer_session_path
  end

  def show_search
    @customer = current_customer
    @contribution = Contribution.new
    @contributions = @customer.contributions.order("created_at DESC").page(params[:page]).per(6).search(params[:keyword])
    @keyword = params[:keyword]
    Genre.all.each do |genre|
      @contribution.contribution_genres.build(genre_id: genre.id)
    end
    render "customer/customers/show"
  end

  def increment_show_search
    @customer = current_customer
    @contribution = Contribution.new
    @contributions = @customer.contributions.order("created_at DESC").page(params[:page]).per(6).search(params[:keyword])
      respond_to do |format|
        format.html
        format.json
      end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :customer_image, :is_deleted)
  end

end