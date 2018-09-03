class Tweet < ApplicationRecord
  belongs_to :user
  has_many :re_tweets, dependent: :destroy

  has_one_attached :image

  def retweets_count
    re_tweets.length
  end
end
