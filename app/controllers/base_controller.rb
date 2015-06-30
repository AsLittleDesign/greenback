class BaseController < ApplicationController
	def application
		@root_path = Rails.root.to_s
	end
end
