class BillsController < ApplicationController
  def create
    @bill = Bill.new(bill_params)
    @bill.owner_id = current_user.id
    if @bill.save
	  flash[:success] = "Added your bill!"
      render 'index'
    else
      render 'index'
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:name, :category, :amount, :duration, :cycle_start, :description)
  end
end
