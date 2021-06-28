class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_host
  

  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :title])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :title])
  end

  def counts(user)
    @count_recipes = user.recipes.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
  
   def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
   end
  
   def after_sign_out_path_for(resource)
    root_path  # ログアウト後に遷移するpathを設定
   end
   
   def set_host
      Rails.application.routes.default_url_options[:host] = request.host_with_port
   end
   
end
