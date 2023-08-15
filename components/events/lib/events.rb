# frozen_string_literal: true

require "waterdrop"
require "dry-struct"

require_relative "events/version"

module Events
  class Error < StandardError; end

  Types = Dry.Types()
end

require "events/event"
Gem.find_files("events/**/*.rb").each { |path| require path }
