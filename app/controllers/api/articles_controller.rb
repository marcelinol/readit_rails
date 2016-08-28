# open API to create articles
class Api::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :log_request, :check_token

  AUTHORIZED_TOKEN = 'xunda'

  def create
    article = Article.new(article_params).extend(MetaTagsParser)
    article.parse
    if article.valid?
      article.save
      render plain: 'article successfuly created. Congratulations!', status: :ok
    else
      render plain: creating_error_message(article.errors), status: :bad_request
    end
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
    render plain: "Unauthorized request.", status: :unauthorized unless token_param['token'] == AUTHORIZED_TOKEN
  end

  def creating_error_message(errors)
    message = errors.messages.map do |key, value|
      "#{key} #{value.join(',')}"
    end.join(' and ')
  end
end
