module SessionsHelper

  # Logs in the given user (using a session cookie).
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  # Tells if any user is logged in
  def logged_in?
    !!current_user
  end

  # Log out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
