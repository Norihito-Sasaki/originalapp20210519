class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order(id: :desc).page(params[:page])
    @interpretations = @user.interpretations.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def articles
    @user = User.find(params[:id])
    @articles = @user.articles.order(id: :desc).page(params[:page])
  end
  
  def interpretations
    @user = User.find(params[:id])
    @interpretations = @user.interpretations.order(id: :desc).page(params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'プロフィールは正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールは更新されませんでした。'
      render :edit
    end
  end

  def destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:profile)
  end

end
