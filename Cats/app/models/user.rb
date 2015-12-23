class User < ActiveRecord::Base
  # after_initialize callback to set the token if it's not already set
  after_initialize :ensure_session_token
  validates :username, :password_digest, presence: true

  def reset_session_token!
    self.session_token = nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_username(user_name)

    if user.nil?
      return nil
    else
      if user.is_password?(password)
        return user
      else
        return nil
      end
    end
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

end
