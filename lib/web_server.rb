require 'sinatra'
require 'eventmachine'
require 'json'
require 'time'

require_relative 'discovery'
require_relative 'overview'
require_relative 'historical_data'

module VistaTV
  module StatsServer
    class WebServer < Sinatra::Base

      configure do
        set :threaded, true
        set :root,     File.dirname(__FILE__) + '/../'
        set :static,   false
      end

      get "/" do
        redirect '/status'
      end

      get '/status' do
        content_type 'text/plain', :charset => 'utf-8'
        "VistaTV Stats Web Server up and running"
      end

      get '/discovery.json' do
        content_type 'application/json', :charset => 'utf-8'
        discovery = Discovery.new
        JSON.generate(discovery.data)
      end

      get '/latest.json' do
        overview = Overview.new(settings.logger)
        data = overview.data
        content_type 'application/json', :charset => 'utf-8'
        JSON.generate(data) 
      end

      get '/:service/historical.json' do |service|
        current_time = Time.now
        historical_data = HistoricalData.new(settings.logger)
        data = historical_data.query(current_time, service)
        content_type 'application/json', :charset => 'utf-8'
        JSON.generate(data) 
      end
    end
  end
end
