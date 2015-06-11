class DebtsController < ApplicationController
	def create
	  @debt = Debt.new(debt_params)
	  @debt.owner_id = current_user.id
	  if @debt.save
		  flash[:success] = "Added your debt!"
	    render 'index'
	  else
	    render 'index'
	  end
	end

	private

	def debt_params
	  params.require(:debt).permit(:name, :debt_category, :amount, :interest, :minimum_payment, :duration, :description)
	end
end
