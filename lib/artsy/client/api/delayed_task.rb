module Artsy
  module Client
    module API
      module DelayedTask
        include Artsy::Client::API::Parse

        # Rebuild a delayed task.
        #
        # @return [Artsy::Client::Domain::DelayedTask]
        def rebuild_delayed_task(task_id, params = {})
          object_from_response(self, Artsy::Client::Domain::DelayedTask, :put, "/api/v1/delayed_task/#{task_id}/rebuild", params)
        end
      end
    end
  end
end
