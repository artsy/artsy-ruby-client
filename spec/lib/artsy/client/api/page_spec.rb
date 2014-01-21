require 'spec_helper'

describe Artsy::Client::API::Page do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#create_page" do
    before do
      stub_post("/api/v1/page").to_return(
        body: fixture("page.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end

    it "returns creates page" do
      page = @client.create_page(name: 'Terms', content: "Subheader\n---\n\n* list 1\n* list 2", published: true)
      expect(a_post("/api/v1/page")).to have_been_made
      expect(page).to be_an Artsy::Client::Domain::Page
      expect(page.id).to eq("terms")
    end
  end
end
