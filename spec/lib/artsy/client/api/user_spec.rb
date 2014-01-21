require 'spec_helper'

describe Artsy::Client::API::User do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#create_user" do
    before do
      stub_post("/api/v1/user").to_return(
        body: fixture("me.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end

    it "creates user" do
      user = @client.create_user(name: 'Foo', email: 'foo@example.com', password: 'bar')
      expect(a_post("/api/v1/user")).to have_been_made
      expect(user).to be_an Artsy::Client::Domain::User
      expect(user.name).to eq('Name')
    end
  end
end
