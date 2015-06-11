class BudgetsController < ApplicationController
  def create
    @budget = Budget.new(budget_params)
    @budget.owner_id = current_user.id
    if @budget.save
  	  flash[:success] = "Added your budget!"
      render 'index'
    else
      render 'index'
    end
  end

  def update
    @budget = Budget.find(params[:id])
    @budget.update_attributes(budget_params)
    if @budget.save
      flash[:success] = "Added your budget!"
      render 'index'
    else
      render 'index'
    end
  end

  private
    def budget_params
      params.require(:budget).permit(:name, :budget_category, :amount, :duration, :cycle_start, :description)
    end
end