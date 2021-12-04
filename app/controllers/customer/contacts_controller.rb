class Customer::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  
  # ↓調べるとアンチパターンとの指摘があるが現状これしか対応策なし（rb:10）
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      redirect_to new_contact_path, flash: { error: @contact.errors.full_messages }
    end
  end

  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to contacts_done_path
    else
      render :new
    end
  end

  def done
  end

  private

  def contact_params
    params.require(:contact).permit(:email,:name,:phone_number,:subject,:message)
  end
end
