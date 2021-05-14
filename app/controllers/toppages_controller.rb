class ToppagesController < ApplicationController
  def index
    if logged_in?
      @recipe = current_user.recipes.build  # form_with 用
      @recipes = current_user.recipes.order(id: :desc).page(params[:page])
    end
  end
end
