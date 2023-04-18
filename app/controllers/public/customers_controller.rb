class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer

  end

  def edit
     @customer = current_customer
  end

  def update
     @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "更新しました"
      redirect_to my_page_path
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)

  end

end
