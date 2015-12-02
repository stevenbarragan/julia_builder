$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "codeclimate-test-reporter"
require 'ostruct'
require 'pry-byebug'

require 'julia'

CodeClimate::TestReporter.start
