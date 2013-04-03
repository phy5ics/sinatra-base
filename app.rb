require 'rubygems'
require 'sinatra'
require 'sinatra/flash'
require "sinatra/reloader" if development?
require 'haml'
require 'sass'
require 'compass'
require 'mongoid'

set :environment, ENV['RACK_ENV']

configure do
	Mongoid.configure do |config|
		Mongoid.load!('config/mongoid.yml')
		# Mongoid.logger = nil
	end
	
	Compass.configuration do |config|
		config.project_path = File.dirname __FILE__
		config.sass_dir = 'views/css'
	end

	set :sass, Compass.sass_engine_options
end

module Base
  class App < Sinatra::Base
   
    get '/' do
			@js = ['/js/jquery-1.9.1.min.js']
			@css = ['/css/global.css']
      haml :index
    end

		# ---------------------------------------------------------
		# Helpers
		#	---------------------------------------------------------
	
		get '/css/:name.css' do
			content_type 'text/css', :charset => 'utf-8'
			sass :"css/#{params[:name]}", Compass.sass_engine_options
		end
		
		def render_file(filename)
      contents = File.read('views/' + filename)
      Haml::Engine.new(contents).render
    end
  
  end
end
