require 'spec_helper'

describe Artsy::Client::API::System do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#clear_cache" do
    before do
      stub_delete("/api/v1/system/cache").to_return(body: fixture("cache.json"), headers: { content_type: "application/json; charset=utf-8" })
    end
    it "returns success status" do
      status = @client.clear_cache
      expect(status.status).to eq('success')
    end
  end
  describe "#up" do
    context "all up" do
      before do
        stub_get("/api/v1/system/up").to_return(body: fixture("up.json"), headers: { content_type: "application/json; charset=utf-8" })
      end
      it "responds to field methods" do
        up = @client.up
        up.respond_to?(:rails?).should be_true
        up.respond_to?(:monkey?).should be_false
      end
      it "returns the system status" do
        up = @client.up
        expect(a_get("/api/v1/system/up")).to have_been_made
        expect(up).to be_an Artsy::Client::Domain::System
        expect(up.rails?).to be_true
      end
      it "returns up summary" do
        expect(@client.up?).to be_true
      end
    end
    context "one down" do
      before do
        stub_get("/api/v1/system/up").to_return(body: fixture("down.json"), headers: { content_type: "application/json; charset=utf-8" })
      end
      it "returns the system status" do
        up = @client.up
        expect(a_get("/api/v1/system/up")).to have_been_made
        expect(up).to be_an Artsy::Client::Domain::System
        expect(up.rails?).to be_false
        expect(up.database?).to be_true
      end
      it "returns down summary" do
        expect(@client.up?).to be_false
      end
    end
  end
end
