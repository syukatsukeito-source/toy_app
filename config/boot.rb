ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "logger"
require "bootsnap/setup" unless Gem.win_platform? # Speed up boot time by caching expensive operations.
