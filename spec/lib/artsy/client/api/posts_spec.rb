require 'spec_helper'

describe Artsy::Client::API::Profile do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#post" do
    before do
      stub_get("/api/v1/posts/featured/feed").to_return({
        :body => fixture("featured_posts.json"),
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns a feed of posts" do
      posts = @client.featured_posts
      expect(a_get("/api/v1/posts/featured/feed")).to have_been_made
      expect(posts).to be_a Hash
      expect(posts[:results].size).to eq 5
      expect(posts[:next]).to_not be_nil
      post = posts[:results].first
      expect(post).to be_a Artsy::Client::Domain::Post
      expect(post.to_s).to eq 'TGIF'
      expect(post.title).to eq 'TGIF'
      expect(post.summary).to eq "Not sure how to plan your weekend? Here are five new galleries to follow, to keep up with the latest shows.  1. Alexander Gr..."
      # author
      author = post.author
      expect(author).to be_a Artsy::Client::Domain::User
      expect(author.to_s).to eq "Artsy Editorial"
      # profile
      profile = post.profile
      expect(profile).to be_a Artsy::Client::Domain::Profile
      expect(profile.to_s).to eq "Artsy Editorial"
      expect(profile.posts_count).to eq 549
    end
  end
end
