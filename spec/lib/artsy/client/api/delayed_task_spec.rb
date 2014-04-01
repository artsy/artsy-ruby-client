require 'spec_helper'

describe Artsy::Client::API::DelayedTask do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#rebuild_delayed_task" do
    before do
      stub_put("/api/v1/delayed_task/9/rebuild").to_return(body: fixture("rebuild_delayed_task.json"), headers: { content_type: "application/json; charset=utf-8" })
    end
    it "returns success status" do
      status = @client.rebuild_delayed_task(9)
      expect(status.status).to eq('success')
    end
  end
end
