class HistoryController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :html, :json

  def index
    budget_versions = []
    @budgets.find(params[:budget_id]).versions.each_with_index do |version, index|
      budget_versions[index] = version.reify.attributes.except("id")
    end
    respond_with budget_versions
  end
end