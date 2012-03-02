require_relative "../../app/services/tweet"
require 'vcr'
require 'vcr_helper'
require 'twitter'

describe Tweet do
  before(:each) do
    VCR.use_cassette('tweets_for_thezanino') do
      @tweets = Tweet.user_timeline('thezanino')
      @tweets_from_twitter = Twitter.user_timeline('thezanino')
    end
  end
  
  describe "#user_timeline" do
    it "returns an array of Tweet objects" do
      @tweets.should be_a_kind_of Array
      @tweets.first.should be_a_kind_of Tweet
    end
    
    it "downloads tweets" do
      @tweets.should have_at_least(1).thing
    end
    
    it "only takes tweets that do not start with @" do
      @tweets_from_twitter.select{|t|t.text.match(/^@/)}.should have_at_least(1).thing
      @tweets.select{|t|t.text.match(/^@/)}.should be_empty
    end
  end
  
  describe "tweet object" do
    let(:tweet) { Tweet.new(@tweets_from_twitter.first) }
    
    it "responds to time" do
      tweet.should respond_to :time
    end
    
    it "has a time that is a ruby Time object" do
      tweet.time.should be_a_kind_of Time
    end
    
    it "has the correct time" do
      tweet.time.should == @tweets_from_twitter.first.created_at
    end
    
    it "responds to text" do
      tweet.should respond_to :text
    end
    
    it "has the correct text" do
      tweet.text.should == @tweets_from_twitter.first.text
    end
        
  end
  
end