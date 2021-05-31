class ToppagesController < ApplicationController
  def index
    if logged_in?
      @recipe = current_user.recipes.build
      @recipes = current_user.recipes.order(id: :desc).page(params[:page])
      @followingrecipes = current_user.feed_flollowings_recipes.order(id: :desc).page(params[:page])
      @allrecipes = Recipe.all.order(id: :desc)
    end
  end
end
