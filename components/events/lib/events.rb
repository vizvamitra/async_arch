# frozen_string_literal: true

require "waterdrop"
require "dry-struct"

module Events
  class Error < StandardError; end

  Types = Dry.Types()
end

# require_relative "events/version"
Gem.find_files("events/**/*.rb").each { |path| require path }
