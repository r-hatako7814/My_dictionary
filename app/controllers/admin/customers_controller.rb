class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update!(admin_customer_params)
    redirect_to admin_customer_path
  end
  
  private
  
  def admin_customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,:email, :is_deleted) 
  end
end
