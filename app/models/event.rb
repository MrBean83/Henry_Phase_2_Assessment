class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :event_attendances
  has_many :attendees, through: :event_attendances, source: :user
end
