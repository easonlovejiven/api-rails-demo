class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 实现当前用户method
  
  attr_accessor :current_user
end
