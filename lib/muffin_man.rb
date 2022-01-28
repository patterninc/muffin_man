require "muffin_man/version"
require "muffin_man/sp_api_client"
require "muffin_man/solicitations/v1"
require "muffin_man/reports/v20210630"
require "muffin_man/catalog_items/v20201201"

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
