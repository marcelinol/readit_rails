class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by!(email: session_params[:email].downcase)
    if user.authenticate(session_params[:password])
      log_in user
      redirect_to index_path
    else
      render :new, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render :new, status: :not_found
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
