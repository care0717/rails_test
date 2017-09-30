class ArticlesController < ApplicationController
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
  
  private

    def article_params
    # submitしたデータのうち、Model作成に必要なものを
    # permitの引数に指定する
    params.require(:article).permit(
      :title, :content
    )
    end
end
