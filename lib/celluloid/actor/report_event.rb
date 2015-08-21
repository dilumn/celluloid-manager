module Celluloid
  class Actor
    class Manager
      class ReportEvent < Celluloid::SystemEvent

        handler { |event|
          event.trigger
        }

        def initialize(uuid,timer)
          @uuid = uuid
          @timer = timer
        end
        
        def trigger
          Celluloid.manager.async.report!(@uuid,@timer)
        end
      end
    end
  end
end
