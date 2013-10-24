class User < ActiveRecord::Base
  validates :email, presence: true, :uniqueness => true, :format => /.+@.+\..+/
  validates :password, presence: true, :length => { :minimum => 6, :message => "Passwords must be at least six characters long." }
  validates :password, confirmation: true, on: :create

  #validates :name, :length => { :minimum => 3, :message => "must be at least 3 characters, fool!" }

  has_many :created_events, class_name: "Event"
  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event

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
