require "muffin_man/version"
require "muffin_man/sp_api_client"
require "muffin_man/lwa/auth_helper"
require "muffin_man/solicitations/v1"
require "muffin_man/orders/v0"
require "muffin_man/reports/v20210630"
require "muffin_man/catalog_items/v20201201"
require "muffin_man/catalog_items/v20220401"
require "muffin_man/data_kiosk/v20231115"
require "muffin_man/finances/v0"
require "muffin_man/finances/v20240619"
require "muffin_man/product_fees/v0"
require "muffin_man/authorization/v1"
require "muffin_man/tokens/v20210301"
require "muffin_man/product_pricing/v0"
require "muffin_man/listings/v20210801"
require "muffin_man/listings/v20200901"
require "muffin_man/listings_restrictions/v20210801"
require "muffin_man/fulfillment_inbound/v0"
require "muffin_man/fulfillment_inbound/v1"
require "muffin_man/fulfillment_inbound/v20240320"
require "muffin_man/fulfillment_outbound/v20200701"
require "muffin_man/fba_inventory/v1"
require "muffin_man/request_helpers"
require "muffin_man/feeds/v20210630"
require "muffin_man/notifications/v1"
require "muffin_man/merchant_fulfillment/v0"
require "muffin_man/definitions/v20200901"
require "muffin_man/awd/v20240509"
require "muffin_man/sellers/v1"
require "muffin_man/vendor_direct_fulfillment_inventory/v1"
require "muffin_man/vendor_direct_fulfillment_orders/v20211228"
require "muffin_man/vendor_direct_fulfillment_payments/v1"
require "muffin_man/vendor_direct_fulfillment_shipping/v20211228"
require "muffin_man/vendor_direct_fulfillment_transactions/v20211228"
require "muffin_man/vendor_invoices/v1"
require "muffin_man/vendor_orders/v1"
require "muffin_man/vendor_shipments/v1"
require "muffin_man/vendor_transaction_status/v1"
require "muffin_man/customer_feedback/v20240601"
require "muffin_man/uploads/v20201101"
require "muffin_man/aplus_content/v20201101"
require "muffin_man/application_management/v20231130"

module MuffinMan
  class Error < StandardError; end

  class SpApiAuthError < StandardError
    attr_reader :auth_response

    def initialize(auth_response)
      super
      @auth_response = auth_response
    end
  end

  class << self
    attr_accessor :configuration, :logger
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    self.logger = configuration.logger if configuration.logger
  end

  class Configuration
    attr_accessor :save_access_token, :get_access_token, :logger
  end
end

# Set default logger
MuffinMan.logger = Logger.new($stdout)
