# open API to create articles
class Api::ArticlesController < ApplicationController
  before_action :log_request, :check_token

  AUTHORIZED_TOKEN = 'xunda'

  def create
  end

  private

  def article_params
    params.require(:article).permit(:address, :title, :tag, :recommender, :recorder)
  end

  def token_param
    params.permit(:token)
  end

  def log_request
    Rails.logger.info "Api::ArticlesController: Request to create Article with: #{params}"
  end

  def check_token
    render plain: "Unauthorized request.", status: 401 unless token_param == AUTHORIZED_TOKEN
  end
end
