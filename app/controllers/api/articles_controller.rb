# open API to create articles
class Api::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :log_request, :authenticate

  TOKEN = ENV['AUTH_TOKEN']

  def create
    article = Article.new(article_params).extend(MetaTagsParser)
    article.parse
    if article.valid?
      article.save
      send_articles_to_pocket(article)
      render plain: 'Article successfuly created. Congratulations!', status: :ok
    else
      render plain: article.errors.full_messages.join(', '), status: :bad_request
    end
  end

  private
  def authenticate
    authenticate_or_request_with_http_token do |token|
      # Compare the tokens in a time-constant manner, to mitigate
      # timing attacks.
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(TOKEN)
      )
    end
  end

  def article_params
    params.require(:article).permit(:address, :title, :tag, :recommender, :recorder)
  end

  def token_param
    params.permit(:token)
  end

  def log_request
    Rails.logger.info "Api::ArticlesController: Request to create Article with: #{params}"
  end

  def send_articles_to_pocket(article)
    PocketAccount.where('access_token is not NULL').each do |pocket_account|
      Pocket.client(access_token: pocket_account.access_token).add(url: article.address, title: article.title, tags: 'readit')
    end
  end
end
