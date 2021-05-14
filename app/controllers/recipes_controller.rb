class RecipesController < ApplicationController
  def new
    if logged_in?
      @recipe = current_user.recipes.build  # form_with 用
    end
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
