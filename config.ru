# frozen_string_literal: true
require 'bundler'
require './blizzard_api_proxy'
Bundler.setup(:default)
run Sinatra::Application
