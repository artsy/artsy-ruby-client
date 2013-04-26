require 'spec_helper'

describe Artsy::Client::API::Me do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "me" do
    before do
      stub_get("/api/v1/me").to_return({
        :body => fixture("me.json"), 
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns me" do
      me = @client.me
      expect(a_get("/api/v1/me")).to have_been_made
      expect(me).to be_an Artsy::Client::Domain::User
      expect(me.name).to eq "Name"
    end
  end
end
