class ArticlesController < ApplicationController
  before_action :signed_in!, only: [:edit, :update, :destroy]
  
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article =  current_user.articles.build
  end
  
  def create
    @article = current_user.articles.build(article_params) 
    if @article.save
      flash[:success] = "Article created!"
      redirect_to root_url
    else
      render 'articles/new'
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id]) 
    if @article.update_attributes(article_params)
      flash[:success] = "Article updated!"
      redirect_to root_url
    else
      render 'edit'
    end
  end
  
  def delete
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_url
  end
  
  private

    def article_params
    # submitしたデータのうち、Model作成に必要なものを
    # permitの引数に指定する
    params.require(:article).permit(
      :title, :content
    )
    end
    
    def signed_in!
      redirect_to new_user_session_path
    end
end
