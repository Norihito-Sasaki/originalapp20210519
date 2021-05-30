class InterpretationsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :edit]
  before_action :correct_user, only: [:destroy, :edit]
  
  def new
    @article = Article.find(params[:article_id])
    @interpretation = @article.interpretations.new
  end

  def create
    @article = Article.find(params[:article_id])
    @interpretation = @article.interpretations.new(interpretation_params)
    @interpretation.user_id = current_user.id
    
    if @interpretation.save
      flash[:success] = '投稿しました。'
      redirect_to @article
    else
      flash.now[:danger] = '回答の投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    @interpretation = Interpretation.find(params[:article_id])
  end

  def update
    @article = Article.find(params[:article_id])
    @interpretation = Interpretation.find(params[:id])
    
    if @interpretation.update(interpretation_params)
      flash[:success] = '回答は正常に更新されました'
      redirect_to @article
    else
      flash.now[:danger] = '回答は更新されませんでした。'
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @interpretation.destroy
    flash[:success] = '記事を削除しました。'
    redirect_to @article
  end
  
  private
   
  def interpretation_params
     params.require(:interpretation).permit(:content)
  end
   
  def correct_user
    @interpretation = current_user.interpretations.find_by(id: params[:article_id])
    unless @interpretation
      redirect_to root_url
    end 
  end 
  
end
