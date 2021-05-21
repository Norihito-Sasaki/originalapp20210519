class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article  = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    
    if @article.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render root_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title,:theme)
  end 
end
