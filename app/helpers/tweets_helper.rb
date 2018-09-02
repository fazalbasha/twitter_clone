module TweetsHelper
  def retweeted?(tweet)
    tweet.re_tweets.find_by(user_id: current_user.id).present?
  end
end
