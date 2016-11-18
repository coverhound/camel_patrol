$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "json"
require "active_support/core_ext/hash/keys"
require "active_support/inflector"
require "rack/test"
require 'camel_patrol'
require "rails/version"

require 'minitest/autorun'
