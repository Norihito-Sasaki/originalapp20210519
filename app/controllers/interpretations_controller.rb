class InterpretationsController < ApplicationController
  
  
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
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @article = Article.find(params[:article_id])
    @interpretation = Interpretation.find(params[:id])
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
    @interpretation.destroy
    flash[:success] = '記事を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
   private
   
   def interpretation_params
     params.require(:interpretation).permit(:content)
   end 
end
