class TweetCache
  class Expired < RuntimeError;end
  
  @@last_download ||= Time.now
  
  def self.user_timeline(username)
    begin
      self.expire!
      CachedTweet.user_timeline(username)
    rescue CachedTweet::NoTweets, TweetCache::Expired
      tweets = Tweet.user_timeline(username)
      CachedTweet.save_tweets(tweets)
      tweets
    end
  end
  
  def self.last_download;@@last_download;end
  def self.last_download=(time)
    @@last_download = time
  end
  
  private
  
  def self.expire!
    # expires after 1 day
    raise TweetCache::Expired if @@last_download < 1.day.ago
  end
  
end