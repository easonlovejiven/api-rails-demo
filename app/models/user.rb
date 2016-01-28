class User < ActiveRecord::Base
	before_create :generate_authentication_token

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(64)
      break if !User.find_by(authentication_token: authentication_token)
    end
  end

  # 重置user的authentication_token
  # 如果用户的authentication_token泄漏了,通过reset_auth_token!方法方便地重置(新建)用户token;
  def reset_auth_token!
    generate_authentication_token
    save
  end
end
