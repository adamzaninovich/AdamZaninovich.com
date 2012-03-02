require 'active_support/core_ext'
require_relative "../../app/services/tweet_cache"
require_relative "../../app/services/tweet"
require 'timecop'

class CachedTweet # ActiveRecord Store
  class NoTweets < RuntimeError;end
end

describe TweetCache do
  let(:tweet1) { stub }
  let(:tweet2) { stub }
  
  context "when the tweets are cached" do
    before(:each) do
      CachedTweet.stub(:user_timeline).with('thezanino') { [tweet1, tweet2] }
    end
    
    it "returns cached tweets" do
      TweetCache.user_timeline('thezanino').should == [tweet1, tweet2]
    end

    it "downloads and stores new tweets after a day" do
      tweet3 = stub
      Tweet.stub(:user_timeline).with('thezanino') { [tweet2, tweet3] }
      Timecop.freeze(Time.now) do
        # they are over a day old
        TweetCache.last_download = 25.hours.ago
        CachedTweet.should_receive(:save_tweets).with([tweet2, tweet3])
        TweetCache.user_timeline('thezanino')
      end
    end
    
  end
    
  context "when the tweets are not cached" do
    before(:each) do
      Tweet.stub(:user_timeline).with('thezanino') { [tweet1, tweet2] }
      CachedTweet.stub(:user_timeline).with('thezanino').and_raise(CachedTweet::NoTweets)
      CachedTweet.stub(:save_tweets)
    end
    
    it "downloads new tweets" do
      TweetCache.user_timeline('thezanino').should == [tweet1, tweet2]
    end

    it "stores new tweets in the database" do
      CachedTweet.should_receive(:save_tweets).with([tweet1, tweet2])
      TweetCache.user_timeline('thezanino')
    end
  end
  
end
