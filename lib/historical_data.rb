require 'time'
require 'json'

# fake data
# used by the second screen bar chart
# this data is random / static

module VistaTV
  module StatsServer
    class HistoricalData

      # @param logger [Logger]
      #
      def initialize(logger)
        @logger = logger
      end

      # @param time [Time]
      # @param service_id [String]
      #
      # generate an hour's worth of random data, minute by minute

      def query(time, service_id)
        period = 60 * 60 # 60 minutes
        time = time.utc
        start_time = time - period #an hour ago

        @overview = {
          :timestamp => time.strftime("%FT%H:%M:00Z"),
          :stations => {}
        }


        # minimum data needed, randomised
        # minute by minute daa for that service
        items = []

        (0..60).each do |count|
          new_time = start_time + (count * 60)
          item = {
            :timestamp => new_time.strftime("%FT%H:%M:00Z"),
            :audience => {
              :total  => rand(300..30000),
              :change => rand(-20..20),
              :join => rand(-20..20),
              :quit => rand(-20..20),
              :platforms => {
                 :desktop =>rand(200..25000),
                 :mobile => rand(100..2000),
                 :console => rand(0..10),
                 :stv_tv => rand(0..10),
                 :other => rand(0..10),
              },
              :flux => {
                :from => {
                  :bbc_radio_two => rand(0..10),
                  :bbc_1xtra => rand(0..10)
                },
                :to => {
                  :bbc_1xtra => rand(0..10),
                  :bbc_6music => rand(0..10)
                },
                :arrived => rand(0..20),
                :left => rand(0..20)
              },
              :programme=> {
                :id=>"b01s8qlm", 
                :title=>"Steve Wright in the Afternoon"
              },
            },
          }
          items.push(item)
        end
        @overview[:stations][service_id] = items
        @overview
      end
    end
  end
end
