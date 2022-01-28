require_relative "muffin_man/version"
require "muffin_man/sp_api_client"
require "muffin_man/solicitations"
require "muffin_man/reports"
require "muffin_man/v20201201/catalog_items"

module MuffinMan
  class Error < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :save_access_token, :get_access_token
  end
end
