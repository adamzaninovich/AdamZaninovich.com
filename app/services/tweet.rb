class Tweet
  def self.user_timeline(username)
    self.initialize_tweets(Twitter.user_timeline(username))
  end
  
  def self.initialize_tweets(tweets)
    tweets.reject! do |tweet|
      tweet.text.match(/^@/)
    end.map do |tweet|
      new(tweet)
    end
  end
  
  attr_reader :text, :time
  
  def initialize(twitter_status_object)
    @time = twitter_status_object.created_at
    @text = twitter_status_object.text
  end
  
end
