require_relative 'em_additions'

module VistaTV
  module StatsServer
    class Controller
      attr_accessor :command, :server, :events

      # @param server [StatsServer]
      # @param logger [Logger] A logger object, to receive status messages.
      #
      def initialize(server, logger)
        @server = server
        @logger = logger
        @events = Hash.new
      end

      # @param data_source [#data]
      #
      def respond_and_repeat(data_source, period=5)
        response_message = command.message

        timer = EventMachine.now_and_every(period) do
          respond_with_data data_source, response_message
        end

        events[command.message] = timer
      end

      # @param data_source [#data]
      #
      def respond_with_data(data_source, message=nil)
        if @logger
          @logger.debug("respond_with_data, data_source=#{data_source}, response_message=#{message}")
        end

        message ||= command.message
        server.send_data 'DATA', message, data_source.data
      end

      def halt_event!
        stop_command = command.param.to_s

        if events.include?(stop_command)
          event = events.delete(stop_command)
          event.cancel
          server.send_data 'OK', command.message
        else
          server.send_data 'ACK', command.message, {:error => "event #{command.param} not found, cannot stop."}
        end
      end
    end
  end
end
