module Celluloid
  class Actor
    class Manager
      include Celluloid

      class << self

        INJECTION_POINTS = [
          :actor_created,
          :actor_removed,
          :initializer
        ]

        @@injections = {}

        # Reminder: Do not mutate these values once set!
        
        INJECTION_POINTS.each { |ip|
          @@injections[ip] = []
          define_method(ip) { @@injections[ip] }
          define_method(:"#{ip}!") { |*args|
            #de puts "adding injection #{ip}: #{args}";
            @@injections[ip] << args
          }
        }

      end

      #de This needs to come after the above, because it needs the Array
      #de and it needs the initializer! class method to be present.
      include Celluloid::Actor::LockDetector if $CELLULOID_LOCKDETECTOR

      trap_exit :actor_removed

      def initialize
        self.class.initializer.map { |args|
          async.send(args.first, *args.slice(1,-1))
        }
      end

      #Actor should remove from cheching for deadlock
      def actor_removed(actor)
        self.class.actor_removed.map { |args|
          async.send(args.first, actor)
        }
      end

      #New Actor Created for deadlock checking
      def actor_created(actor)
        monitor(actor) #de Will link, and cause :actor_removed when actor is terminated.
        self.class.actor_created.map { |args|
          async.send(args.first, actor)
        }
      end

    end
  end
end
