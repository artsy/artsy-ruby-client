require 'i18n'

I18n.load_path << File.join(File.dirname(__FILE__), "config", "locales", "en.yml")

require 'artsy/client/version'
require 'artsy/client/errors'
