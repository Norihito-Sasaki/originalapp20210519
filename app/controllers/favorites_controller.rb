class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    interpretation = Interpretation.find(params[:interpretation_id])
    current_user.favorite(interpretation)
    flash[:success] = '回答をお気に入りしました。'
    redirect_to root_url
  end

  def destroy
    interpretation = Interpretation.find(params[:interpretation_id])
    current_user.unfavorite(interpretation)
    flash[:success] = 'お気に入りから削除しました。'
    redirect_to root_url
  end
end
