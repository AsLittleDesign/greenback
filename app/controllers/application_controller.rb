class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, except: :create
  # skip_before_filter :verify_authenticity_token, :only =>

  include SessionsHelper
  include ApplicationHelper

  before_filter :user_records
  def user_records
  	@bills ||= Bill.where(owner_id: current_user.id)
  	@debts ||= Debt.where(owner_id: current_user.id)
  	@budgets ||= Budget.where(owner_id: current_user.id)
  end
end
