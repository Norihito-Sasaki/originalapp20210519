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
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
   private
   
   def interpretation_params
     params.require(:interpretation).permit(:content)
   end 
end
