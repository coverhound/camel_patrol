$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "json"
require "active_support/core_ext/hash/keys"
require "active_support/inflector"
require "rack/test"
require 'camel_patrol'
require "rails/version"

require 'minitest/autorun'
require "minitest/reporters"

Minitest::Reporters.use!(
  [
    Minitest::Reporters::DefaultReporter.new,
    # This path should match up, save for the last directory, with the value
    # in `store_test_results` and `store_artifacts` in .circleci/config.yml
    Minitest::Reporters::JUnitReporter.new("tmp/test_results/minitest"),
  ],
)
