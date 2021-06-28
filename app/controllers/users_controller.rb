class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :followings, :followers]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
    @likes = current_user.feed_likes.order(id: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(id: :desc).page(params[:page])
    counts(@user)
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

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'ユーザー情報は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザー情報は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:success] = 'ユーザー情報は正常に削除されました'
    redirect_to root_url  
  end
  
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render"edit"
    else
      redirect_to root_url
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
  end
  

  def search
    @user = User.find(params[:id])
    @results = @user.recipes.search(params[:search])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :title)
  end
end
