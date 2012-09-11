require 'sinatra/base'

$stdout.sync = true

require './app'
run BASE_APP::App