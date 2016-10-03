class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by!(email: session_params[:email])
    if user.authenticate(session_params[:password])
      redirect_to index_path
      # to be continued: https://www.railstutorial.org/book/basic_login
    else
      render :new, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render :new, status: :not_found
  end

  def destroy
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
