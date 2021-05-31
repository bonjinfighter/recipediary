class RecipesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @recipes = Recipe.all.order(id: :desc)
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end 
  
  def new
    if logged_in?
      @recipe = current_user.recipes.build
    end
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
      if @recipe.save
        flash[:success] = 'レシピを投稿しました!'
        redirect_to @recipe
      else
        @recipes = current_user.recipes.order(id: :desc).page(params[:page])
        flash[:danger] = 'レシピの投稿に失敗しました!'
        redirect_back(fallback_location: root_path)
      end
  end

  def destroy
    @recipe.destroy
    flash[:success] = 'レシピを削除しました!'
    redirect_to root_url
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    flash[:success] = 'レシピを編集しました!'
    redirect_to @recipe
  end
  
  def recipe_params
    params.require(:recipe).permit(:title, :content, :image, :date)
  end
  
  def correct_user
    @recipe = current_user.recipes.find_by(id: params[:id])
    unless @recipe
      redirect_to root_url
    end
  end
end
