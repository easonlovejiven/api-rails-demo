class Api::V1::BaseController < ApplicationController
	# 禁止了 CSRF token 和 cookies
  protect_from_forgery with: :null_session
  before_action :destroy_session
  skip_before_action :verify_authenticity_token
  # 添加 api_error back status
  def api_error(opts = {})
    render nothing: true, status: opts[:status]
  end

  # Api接收email 和 token 能否成功识别用户
  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_email = options.blank?? nil : options[:email]
    user = user_email && User.find_by(email: user_email)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      self.current_user = user
    else
      return unauthenticated!
    end
  end

  # 处理非法的 token 去请求 API的情况
  def unauthenticated!
    api_error(status: 401)
  end

end
