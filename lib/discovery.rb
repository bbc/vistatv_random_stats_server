module VistaTV
  module StatsServer
    class Discovery
      STATIONS = %w{
        bbc_radio_one bbc_radio_two bbc_radio_three bbc_radio_four
      }

      # @return [Array<Hash>] An array of all unique stations / streams
      #
      def data
        @data ||= STATIONS.collect do |id|
          { :id => id }
        end
      end
    end
  end
end
