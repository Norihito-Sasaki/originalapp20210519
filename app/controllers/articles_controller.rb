class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @article = Article.find(params[:id])
    @interpretations = @article.interpretations.all
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
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      flash[:success] = '記事は正常に更新されました'
      redirect_to @article
    else
      flash.now[:danger] = '記事は更新されませんでした。'
      render :edit
    end
  end

  def destroy
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title,:theme)
  end 
end
