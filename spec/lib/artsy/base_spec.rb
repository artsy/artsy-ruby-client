# heavily inspired from https://github.com/sferik/twitter
require 'spec_helper'

describe Artsy::Client::Base do

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(Artsy::Client::Base.new(:id => 1).attrs).to eq({ :id => 1 })
    end
  end

end
