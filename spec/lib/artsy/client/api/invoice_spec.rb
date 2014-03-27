require 'spec_helper'

describe Artsy::Client::API::Invoice do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#invoice_by_token" do
    before do
      stub_get("/api/v1/invoice?token=xyz").to_return(
        body: fixture("invoice.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns invoice" do
      invoice = @client.invoice_by_token('xyz')
      expect(a_get("/api/v1/invoice?token=xyz")).to have_been_made
      expect(invoice).to be_an Artsy::Client::Domain::Invoice
      expect(invoice.total).to eq "$12,300.45"
    end
  end
end
