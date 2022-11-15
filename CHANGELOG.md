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
