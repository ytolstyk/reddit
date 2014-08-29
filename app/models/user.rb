# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password
  
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, :session_token, uniqueness: true
  
  after_initialize :ensure_session_token
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if user.nil?
    user.is_password?(password) ? user : nil 
  end
  
  def reset_session_token!
    self.update(session_token: User.generate_session_token)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  private
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
