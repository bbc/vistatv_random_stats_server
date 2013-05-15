require 'eventmachine'

require 'stats_protocol'

require_relative 'overview'
require_relative 'discovery'
require_relative 'controller'

module VistaTV
  module StatsServer
    class StatsConnection < EventMachine::Connection
      include EventMachine::Protocols::LineProtocol

      # @param logger [Logger] A logger object, to receive status messages.
      #
      def initialize(logger)
        @logger = logger
      end

      def post_init
        @controller = Controller.new(self, @logger)
      end

      def send_data(*data)
        super StatsProtocol::Message.new(*data).to_send_data
      end

      # Processes a single line of text received from the socket connection.
      #
      # @param line [String]
      #
      def receive_line(line)
        respond_to_command(line)
      end

      def respond_to_command(cmd)
        @logger.info("Received command: #{cmd}")

        begin
          command = StatsProtocol::Command.new(cmd)
        rescue StatsProtocol::Command::NotFoundError => e
          send_data 'ACK', cmd, {:error => e.to_s}
          return
        end

        @controller.command = command

        case command.type
        when :overview
          @logger.debug "OVERVIEW"
          overview = Overview.new(@logger)
          @controller.respond_and_repeat(overview)
        when :discovery
          @logger.debug "DISCOVERY"
          @controller.respond_with_data(Discovery.new)
        when :stop
          @logger.debug "STOP"
          @controller.halt_event!
        else
          @logger.debug "UNKNOWN"
          send_data "Unknown command #{command.command}"
        end
      end
    end
  end
end
