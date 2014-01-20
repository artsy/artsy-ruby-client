require 'spec_helper'

describe Artsy::Client do
  it "has a version" do
    Artsy::Client::VERSION.should_not be_nil
  end
  context "instance" do
    subject do
      Artsy::Client::Instance.new
    end
    it "raises a credentials error" do
      expect { subject.configure }.to raise_error(Artsy::Client::Errors::MissingCredentialsError)
    end
  end
  context "with client id and secret" do
    subject do
      Artsy::Client::Instance.new(
        client_id: "CI",
        client_secret: "CS"
      )
    end
    it "#authenticate!" do
      stub_get("/api/v1/xapp_token?client_id=CI&client_secret=CS").to_return(
        body: fixture("xapp_token.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
      subject.authenticate!
      subject.instance_variable_get(:"@xapp_token").should == "xapp token"
    end
    context "with logger" do
      before :each do
        @io = StringIO.new
        logger = Logger.new(@io)
        logger.level = Logger::DEBUG
        subject.logger = logger
      end
      it "logs connection attempts" do
        stub_get("/api/v1/xapp_token?client_id=CI&client_secret=CS").to_return(
          body: fixture("xapp_token.json"),
          headers: { content_type: "application/json; charset=utf-8" }
        )
        subject.authenticate!
        @io.string.should include "GET /api/v1/xapp_token?client_id=CI&client_secret=CS"
      end
    end
  end
  context "with user credentials" do
    subject do
      Artsy::Client::Instance.new(
        client_id: "CI",
        client_secret: "CS",
        user_email: "user@example.com",
        user_password: "password"
      )
    end
    it "#authenticate!" do
      stub_get("/oauth2/access_token?client_id=CI&client_secret=CS&email=user%40example.com&password=password&grant_type=credentials").to_return(
        body: fixture("access_token.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
      subject.authenticate!
      subject.instance_variable_get(:"@access_token").should == "access token"
    end
    context "with logger" do
      before :each do
        @io = StringIO.new
        logger = Logger.new(@io)
        logger.level = Logger::DEBUG
        subject.logger = logger
      end
      it "logs connection attempts" do
        stub_get("/oauth2/access_token?client_id=CI&client_secret=CS&email=user%40example.com&password=password&grant_type=credentials").to_return(
          body: fixture("access_token.json"),
          headers: { content_type: "application/json; charset=utf-8" }
        )
        subject.authenticate!
        @io.string.should include "GET /oauth2/access_token?client_id=CI&client_secret=CS&email=user%40example.com&password=********&grant_type=credentials"
      end
    end
  end
  context "configured instance" do
    subject do
      Artsy::Client::Instance.new(
        access_token: "AT",
        xapp_token: "XT",
        client_id: "CI",
        client_secret: "CS"
      )
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
            connection_options: { timeout: 10 },
            access_token: 'AT2',
            xapp_token: 'XT2',
            client_id: 'CI2',
            client_secret: 'CS2',
            user_email: 'user@example.com',
            user_password: 'password',
            endpoint: 'http://tumblr.com/',
            middleware: proc {},
            logger: Logger.new(STDOUT)
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
        stub_delete("/custom/delete").with(query: { deleted: "object" })
      end
      it "allows custom delete requests" do
        subject.delete("/custom/delete",  deleted: "object")
        expect(a_delete("/custom/delete").with(query: { deleted: "object" })).to have_been_made
      end
    end
    describe "#put" do
      before do
        stub_put("/custom/put").with(body: { updated: "object" })
      end
      it "allows custom put requests" do
        subject.put("/custom/put",  updated: "object")
        expect(a_put("/custom/put").with(body: { updated: "object" })).to have_been_made
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
end
