# 2.4.1 [#xx](https://github.com/patterninc/muffin_man/pull/xx)

- Support for Listings Restrictions API v2021-08-01
# 2.4.0 [#72](https://github.com/patterninc/muffin_man/pull/72)

- Support for the following:
  Vendor Direct Fulfillment Inventory API v1
  Vendor Direct Fulfillment Orders API v2021-12-28
  Vendor Direct Fulfillment Payments API v1
  Vendor Direct Fulfillment Shipping API v2021-12-28
  Vendor Direct Fulfillment Transactions API v2021-12-28
  Vendor Invoices API v1
  Vendor Orders API v1
  Vendor Shipments API v1
  Vendor Transaction Status API v1

# 2.2.0 [#66](https://github.com/patterninc/muffin_man/pull/66)

- Support for Data Kiosk API v2023-11-15

# 2.1.3

- Support for AWD getInboundShipment [#64](https://github.com/patterninc/muffin_man/pull/64)

# 2.1.2 [#63](https://github.com/patterninc/muffin_man/pull/63)

- Support for patchListingsItem

# 2.1.1 [#62](https://github.com/patterninc/muffin_man/pull/62)

- SearchCatalogItems validations on keywords & identifiers

# 2.1.0 [#58](https://github.com/patterninc/muffin_man/pull/58)

- Support for Product Type Definitions

# 2.0.6 [#54](https://github.com/patterninc/muffin_man/pull/54)

- Support for getOrder

# 2.0.5 [#53](https://github.com/patterninc/muffin_man/pull/53)

- Fix for files auto-unzipping from GZIP now

# 2.0.4 [#52](https://github.com/patterninc/muffin_man/pull/52)

- Support for deleteListingsItem

# 2.0.3 [#50](https://github.com/patterninc/muffin_man/pull/50)

- Support for putListingsItem

# 2.0.2 [#49](https://github.com/patterninc/muffin_man/pull/49)

- Better error handling for unauthorized errors when getting LWA tokens

# 2.0.1 [#46](https://github.com/patterninc/muffin_man/pull/46)

- Support for passing an array of identifiers to search_catalog_items

# 2.0.0 [#47](https://github.com/patterninc/muffin_man/pull/47)

- BREAKING CHANGES: Changed signature of processing_directive check as it was confusing and was not working. processing_directive is a nested structure. It has marketplace_ids. Having marketplace_ids as an independent parameter was confusing.
- Added new endpoint support - delete_subscription.

# 1.5.12 [#45](https://github.com/patterninc/muffin_man/pull/45)

- Small update to putTransportDetails

# 1.5.11

- Add sandbox support for inbound small parcel get labels

# 1.5.10

- Add sandbox support for inbound small parcel

# 1.5.9

- Support for estimateTransport, getTransportDetails, confirmTransport, and voidTransport [#44](https://github.com/patterninc/muffin_man/pull/44)

# 1.5.8

- Add batch functionality to competitive price

# 1.5.7

- Fix sandbox support for create shipments in Merchant Fulfillment

# 1.5.6

- Sandbox support for create/delete shipments in Merchant Fulfillment [#42](https://github.com/patterninc/muffin_man/pull/42)

# 1.5.5

- Support for Merchant Fulfillment [#41](https://github.com/patterninc/muffin_man/pull/41)

# 1.5.4

- Fix to format create outbound fulfillment request [#40](https://github.com/patterninc/muffin_man/pull/40)

# 1.5.3

- Support for getInventorySummaries [#36](https://github.com/patterninc/muffin_man/pull/36)
- Support for Fulfillment Outbound [#34](https://github.com/patterninc/muffin_man/pull/34)

# 1.5.2

- Support for Feeds and Notifications [#33](https://github.com/patterninc/muffin_man/pull/33)

# 1.5.1

- Support for getItemEligibilityPreview [#35](https://github.com/patterninc/muffin_man/pull/35)

# 1.5.0

## Breaking changes - 1. v20220401 search_catalog_items method signature updated

- [#32](https://github.com/patterninc/muffin_man/pull/32) Removes `keywords` argument requirement for v20220401 search_catalog_items as it is not required in v20220401. You'll need to pass `keywords` as a param rather than as an argument for the method

# 1.4.13

- Support for updateInboundShipment [#28](https://github.com/patterninc/muffin_man/pull/28)

# 1.4.12

- Support for getShipmentItemsByShipmentId [#30](https://github.com/patterninc/muffin_man/pull/30)

# 1.4.11

- Support for getLabels [#25](https://github.com/patterninc/muffin_man/pull/29)

# 1.4.10

- Support for getShipments [#27](https://github.com/patterninc/muffin_man/pull/27)

# 1.4.9

- Fix to override global AWS config with credentials that are passed [#26](https://github.com/patterninc/muffin_man/pull/26)

# 1.4.8

- Support for createInboundShipment [#25](https://github.com/patterninc/muffin_man/pull/25)

# 1.4.7

- Support for createInboundShipmentPlan [#24](https://github.com/patterninc/muffin_man/pull/24)

# 1.4.6

- Support for Catalog API's of version 20220401 [#22](https://github.com/patterninc/muffin_man/pull/22)

# 1.4.5

- Support for GetCompetitivePricing endpoint [#19] (https://github.com/patterninc/muffin_man/pull/19)

# 1.4.4

- Support for Tokens API [#17](https://github.com/patterninc/muffin_man/pull/17)

# 1.4.3

- Support for getOrderAddress [#16](https://github.com/patterninc/muffin_man/pull/16)

# 1.4.2

- Support for getOrders and getOrderItems [#15](https://github.com/patterninc/muffin_man/pull/15)

# 1.4.0

- Pass cache key to client for caching access tokens [#11](https://github.com/patterninc/muffin_man/pull/11)
