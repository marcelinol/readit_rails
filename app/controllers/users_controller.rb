class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save!
    log_in @user
    redirect_to index_path
  rescue ActiveRecord::RecordInvalid
    render :new, status: 400
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
