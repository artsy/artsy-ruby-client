module Artsy
  module Client
    module Domain
      class Post < Artsy::Client::Base
        include Artsy::Client::API::Parse

        def profile
          @profile ||= Artsy::Client::Domain::Profile.new(self[:profile]).tap do |profile|
            profile.instance = instance
          end
        end

        def author
          @author ||= Artsy::Client::Domain::User.new(self[:author]).tap do |author|
            author.instance = instance
          end
        end

        def title
          self[:title]
        end

        def summary
          self[:summary].strip
        end

        def body
          self[:body]
        end

        def to_s
          title
        end

      end
    end
  end
end
