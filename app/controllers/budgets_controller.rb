class BudgetsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :html, :json

  def index
    respond_with @budgets
  end

  def show
    respond_with @budgets.find(params[:id])
  end

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
    @budget.update_attributes(budget_params.reject{|_, v| v.blank?})
    if @budget.save
      flash[:success] = "Added your budget!"
      render 'show'
    else
      render 'show'
    end
  end

  private
    def budget_params
      params.require(:budget).permit(:name, :budget_category, :amount, :duration, :cycle_start, :description)
    end
end