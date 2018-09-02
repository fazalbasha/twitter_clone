class Tweet < ApplicationRecord
  belongs_to :user
  has_many :re_tweets, dependent: :destroy
end
