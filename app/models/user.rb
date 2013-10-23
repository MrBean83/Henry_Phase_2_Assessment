class User < ActiveRecord::Base
  validates :email, presence: true
  validates :password, presence: true
  validates :password, confirmation: true, on: :create

  #validates :name, :length => { :minimum => 3, :message => "must be at least 3 characters, fool!" }
  #validates :password, :length => { :minimum => 6, :message => "password must be at least 6 letters, fool!" }
  #validates :email, :uniqueness => true, :format => /.+@.+\..+/ # imperfect, but okay

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
