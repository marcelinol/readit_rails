class MainController < ApplicationController
  def index
    @recommendations = ActiveSupport::HashWithIndifferentAccess.new
    @recommendations[:articles] = Article.all
    @recommendations[:videos] = nil
  end
end
