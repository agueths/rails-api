class ArticlesController < ApplicationController
  before_action :authorization_required

  def index
    @articles = Article.all
    render json: @articles, status: 200
  end

  def show
    @article = Article.find(params[:id])
    render json: @article, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: 404
  end

  def create
    @article = Article.create(article_params)
    render json: @article, status: 201
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
