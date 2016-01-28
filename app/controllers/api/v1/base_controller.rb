class Api::V1::BaseController < ApplicationController
	# 禁止了 CSRF token 和 cookies
  protect_from_forgery with: :null_session
  before_action :destroy_session
  skip_before_action :verify_authenticity_token
end
