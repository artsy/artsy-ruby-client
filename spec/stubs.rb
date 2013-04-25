# heavily inspired from https://github.com/sferik/twitter

def a_delete(path)
  a_request(:delete, Artsy::Client::Default::ENDPOINT + path)
end

def a_get(path)
  a_request(:get, Artsy::Client::Default::ENDPOINT + path)
end

def a_post(path)
  a_request(:post, Artsy::Client::Default::ENDPOINT + path)
end

def a_put(path)
  a_request(:put, Artsy::Client::Default::ENDPOINT + path)
end

def stub_delete(path)
  stub_request(:delete, Artsy::Client::Default::ENDPOINT + path)
end

def stub_get(path)
  stub_request(:get, Artsy::Client::Default::ENDPOINT + path)
end

def stub_post(path)
  stub_request(:post, Artsy::Client::Default::ENDPOINT + path)
end

def stub_put(path)
  stub_request(:put, Artsy::Client::Default::ENDPOINT + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
