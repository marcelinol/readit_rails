class PocketAccountsController < ApplicationController

  CALLBACK_URL = "http://localhost:3000/oauth/callback"

  def connect
    session[:code] = Pocket.get_code(redirect_uri: pocket_callback_url)
    new_url = Pocket.authorize_url(code: session[:code], redirect_uri: pocket_callback_url)
    redirect_to new_url
  end

  def callback
    result = Pocket.get_result(session[:code], redirect_uri: pocket_callback_url)
    pocket_account = PocketAccount.where(user_id: current_user.id).first_or_create
    pocket_account.update_attributes(
      access_token: result['access_token'],
      username: result['username']
    )
    redirect_to root_path
  end

end
