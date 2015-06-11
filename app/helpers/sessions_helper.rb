module SessionsHelper
  # Logs in given user
  def log_in(user)
  	session[:user_id] = user ? user.id : nil
  end

  # Returns the current logged-in user
  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  def bills
    @bills = Bill.where(owner_id: current_user.id)
  end

  # Returns rue if the user is logged in, false otherwise
  def logged_in?
  	!current_user.nil?
  end
  
  # Logs out the current user
  def log_out
  	session.delete(:user_id)
  	@current_user = nil
  end
end
