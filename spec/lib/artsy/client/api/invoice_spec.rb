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

  describe "#create_invoice_payment" do
    before do
      stub_post("/api/v1/invoice/x/payment").to_return(
        body: fixture("invoice_payment.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end

    it "creates payment" do
      payment = @client.create_invoice_payment('x', token: 'y', credit_card_token: 'z', amount_cents: 123_45, provider: 'stripe')
      expect(a_post("/api/v1/invoice/x/payment")).to have_been_made
      expect(payment).to be_an Artsy::Client::Domain::InvoicePayment
      expect(payment.amount).to eq "$123.45"
    end
  end
end
