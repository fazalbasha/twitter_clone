class Tweet < ApplicationRecord
  belongs_to :user
  has_many :re_tweets, dependent: :destroy

  def retweets_count
    re_tweets.length
  end
end
