require 'spec_helper'

describe Artsy::Client::API::Profile do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#profile" do
    before do
      stub_get("/api/v1/profile/art21").to_return({
        :body => fixture("profile.json"),
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns profile" do
      profile = @client.profile('art21')
      expect(a_get("/api/v1/profile/art21")).to have_been_made
      expect(profile).to be_an Artsy::Client::Domain::Profile
      expect(profile.owner).to be_an Artsy::Client::Domain::User
      expect(profile.owner.name).to eq "Art21"
      expect(profile.short_description).to eq 'Nonprofit producer of the award-winning PBS series "Art in the Twenty-First Century"'
    end
  end
end
