class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         :confirmable

  has_many :tweets, dependent: :destroy
  has_many :re_tweets, dependent: :destroy

  acts_as_followable
  acts_as_follower

  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one_attached :avatar

  before_save :set_username

  def set_username
    self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.jpeg')), filename: 'default-avatar.jpeg', content_type: 'image/jpeg')
    self.username = self.email.split('@')[0]
  end
end
