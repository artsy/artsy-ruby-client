require 'spec_helper'

describe Artsy::Client do
  it "has a version" do
    Artsy::Client::VERSION.should_not be_nil
  end
  subject do
    Artsy::Client::Instance.new({ :access_token => "magic" })
  end
  context "with module configuration" do
    before do
      Artsy::Client.configure do |config|
        Artsy::Client::Configurable.keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end
    after do
      Artsy::Client.reset!
    end
    it "inherits the module configuration" do
      client = Artsy::Client::Instance.new
      Artsy::Client::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq key
      end
    end
    context "with class configuration" do
      before do
        @configuration = {
          :connection_options => {:timeout => 10},
          :access_token => 'magic',
          :endpoint => 'http://tumblr.com/',
          :middleware => Proc.new { }
        }
      end
      context "during initialization" do
        it "overrides the module configuration" do
          client = Artsy::Client::Instance.new(@configuration)
          Artsy::Client::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
          end
        end
      end
      context "after initialization" do
        it "overrides the module configuration after initialization" do
          client = Artsy::Client::Instance.new
          client.configure do |config|
            @configuration.each do |key, value|
              config.send("#{key}=", value)
            end
          end
          Artsy::Client::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
          end
        end
      end
    end
  end
  describe "#delete" do
    before do
      stub_delete("/custom/delete").with(:query => {:deleted => "object"})
    end
    it "allows custom delete requests" do
      subject.delete("/custom/delete", {:deleted => "object"})
      expect(a_delete("/custom/delete").with(:query => {:deleted => "object"})).to have_been_made
    end
  end
  describe "#put" do
    before do
      stub_put("/custom/put").with(:body => {:updated => "object"})
    end
    it "allows custom put requests" do
      subject.put("/custom/put", {:updated => "object"})
      expect(a_put("/custom/put").with(:body => {:updated => "object"})).to have_been_made
    end
  end
  describe "#connection" do
    it "looks like Faraday connection" do
      expect(subject.send(:connection)).to respond_to(:run_request)
    end
    it "memoizes the connection" do
      c1, c2 = subject.send(:connection), subject.send(:connection)
      expect(c1.object_id).to eq c2.object_id
    end
  end
end
