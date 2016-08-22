class MainController < ApplicationController
  def index
    @recommendations = ActiveSupport::HashWithIndifferentAccess.new
    @recommendations[:articles] = Article.all
    @recommendations[:videos] = Video.all
  end
end
