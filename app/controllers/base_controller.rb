class BaseController < ApplicationController
	respond_to :html, :json

	def application
		@root_path = Rails.root.to_s
	end
	def logged_in
		respond_with logged_in?
	end
end
