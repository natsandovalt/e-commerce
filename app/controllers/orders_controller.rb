class OrdersController < ApplicationController
  def create
    @order_form = OrderForm.from(params.require(:order))
    if @order_form.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end