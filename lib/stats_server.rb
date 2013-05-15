require 'em-logger'
require 'logger'
require 'thin'

require_relative 'config'
require_relative 'stats_connection'
require_relative 'web_server'

# http://stackoverflow.com/questions/2999430

module VistaTV
  module StatsServer
    class StatsServer
      def run
        EventMachine.run {
          config = Config.new

          dest_logger = Logger.new(STDERR)
          dest_logger.level = Logger::INFO

          logger = EventMachine::Logger.new(dest_logger)

          Signal.trap("INT")  { EventMachine.stop }
          Signal.trap("TERM") { EventMachine.stop }

          hostname = config.stats_server.host
          port     = config.stats_server.port

          EventMachine::start_server(
            hostname,
            port,
            StatsConnection,
            logger
          )

          logger.info("Running stats server on #{hostname}:#{port}")

          WebServer.set(:logger, logger)
          WebServer.set(:config, config)

          http_server_host = config.stats_http_server.host
          http_server_port = config.stats_http_server.port

          Thin::Server.start(
            WebServer,
            http_server_host,
            http_server_port
          )

          logger.info("Running stats http server on #{http_server_host}:#{http_server_port}")
        }
      end
    end
  end
end
