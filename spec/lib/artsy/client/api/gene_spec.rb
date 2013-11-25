require 'spec_helper'

describe Artsy::Client::API::Gene do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#gene" do
    before do
      stub_get("/api/v1/gene/art").to_return({
        :body => fixture("gene.json"),
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns gene" do
      gene = @client.gene('art')
      expect(a_get("/api/v1/gene/art")).to have_been_made
      expect(gene).to be_an Artsy::Client::Domain::Gene
      expect(gene.name).to eq "Art"
    end
  end
end
