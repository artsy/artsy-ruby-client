require 'spec_helper'

describe Artsy::Client do
  it "has a version" do
    Artsy::Client::VERSION.should_not be_nil
  end
end

