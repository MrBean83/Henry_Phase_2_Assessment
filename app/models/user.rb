class User < ActiveRecord::Base
  validates :email, presence: true
  validates :password, presence: true
  validates :password, confirmation: true, on: :create

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_digest = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    user if user && (user.password == password)
  end
end
