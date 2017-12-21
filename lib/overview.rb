require 'json'
require 'time'

# fake data 
# this is used by the first overview page
# and also used by /latest.json

module VistaTV
  module StatsServer
    class Overview
      def initialize(logger)
        @logger  = logger
      end

      def data
        @overview = {
          :timestamp => Time.now.utc.strftime("%FT%H:%M:00Z"),
          :stations => {}
        }

        # minimum data needed, randomised 

        Discovery::STATIONS.each do |id|
          @overview[:stations][id] = [{
            :audience => {
              :total  => rand(300..30000),
              :change => rand(-20..20),
              :join => rand(-20..20),
              :quit => rand(-20..20),
              :platforms => {
                 :desktop => rand(200..25000),
                 :mobile => rand(100..2000), 
                 :console => rand(0..10),
                 :stv_tv => rand(0..10),
                 :other => rand(0..10),
              },
            },
          }]
        end
        @overview
      end
    end
  end
end

