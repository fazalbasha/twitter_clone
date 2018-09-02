class CreateReTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :re_tweets do |t|
      t.integer :tweet_id
      t.integer :user_id

      t.timestamps
    end
  end
end
