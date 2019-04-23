!--QA-388
Feature:          set ApprovalOnly Flag and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery for ApprovalOnly Destinations

Scenario: set ApprovalOnly Destinations and check Delivery for German Markets
Meta:@GDN
Given modify Destination collection for following fields:
| DestinationName | HoldForApproval | HouseNumberMandatory | ProxyApprove | ApprovalOnly |
|    Westwing     |  true           |  true                |  true        |  true        |
And refresh destinations
And I created the following agency:
| Name   |    A4User     |
| GDNTDA31 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU31 | agency.admin | GDNTDA31     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA31':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR31 | GDNTDBR31 | GDNTDSB31 | GDNTDP31 |
And logged in with details of 'GDNTDU31'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR31   | GDNTDBR31   | GDNTDSB31   | GDNTDP31   | GDNTDC31   |GDNTDCN31_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT31 | Westwing:Standard|
And complete order contains item with clock number 'GDNTDCN31_1' with following fields:
| Job Number  | PO Number |
| GDNTD3131   | GDNTD3131 |
And wait for finish place order with following item clock number 'GDNTDCN31_1' to A4
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA31    | GDNTDCN31_1  |
And wait for delivery doc available with following fields:
| ClockNumberList | Email |
| GDNTDCN31_1 |  GDNTDU31 |
And check DeliveryStatus of A5 with following fields:
| ClockNumberList | Email | DestinationID | Status |
| GDNTDCN31_1 |  GDNTDU31 |  8056         | [GDN] Awaiting station release |
And approve destinations with following fields:
|ClockNumber  | Email    | HouseNumber | DestinationID |
| GDNTDCN31_1 | GDNTDU31 |  123456789  |   8056        |
Then redeliver asset using externalId to the destinations with following fields:
| ClockNumberList | Email | DestinationID |
| GDNTDCN31_1 |  GDNTDU31 |  8056         |
And find 'DeliveryJobResponse' to the '1' destinations


Scenario: set Approval and Non Approved Destinations and check Delivery
Meta:@GDN
Given modify Destination collection for following fields:
| DestinationName | HoldForApproval | HouseNumberMandatory | ProxyApprove | ApprovalOnly |
|    Westwing     |  true           |  true                |  true        |  true        |
And refresh destinations
And I created the following agency:
| Name   |    A4User     |
| GDNTDA32 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU32 | agency.admin | GDNTDA32     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA32':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR32 | GDNTDBR32 | GDNTDSB32 | GDNTDP32 |
And logged in with details of 'GDNTDU32'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR32   | GDNTDBR32   | GDNTDSB32   | GDNTDP32   | GDNTDC32   |GDNTDCN32_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT32 | Westwing:Standard;MediaGroup One:Standard|
And complete order contains item with clock number 'GDNTDCN32_1' with following fields:
| Job Number  | PO Number |
| GDNTD3232   | GDNTD3232 |
And wait for finish place order with following item clock number 'GDNTDCN32_1' to A4
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA32    | GDNTDCN32_1  |
And wait for delivery doc available with following fields:
| ClockNumberList | Email |
| GDNTDCN32_1 |  GDNTDU32 |
And check DeliveryStatus of A5 with following fields:
| ClockNumberList | Email | DestinationID | Status |
| GDNTDCN32_1 |  GDNTDU32 |  8056         | [GDN] Awaiting station release |
And approve destinations with following fields:
|ClockNumber  | Email    | HouseNumber | DestinationID |
| GDNTDCN32_1 | GDNTDU32 |  123456789  |   8056        |
Then redeliver asset using externalId to the destinations with following fields:
| ClockNumberList | Email | DestinationID |
| GDNTDCN32_1 |  GDNTDU32 |  8056         |
And find 'DeliveryJobResponse' to the '1' destinations
And check DeliveryStatus of A5 with following fields:
| ClockNumberList | Email | DestinationID | Status |
| GDNTDCN32_1 |  GDNTDU32 |  8056         | [GDN] Transfer Complete |



Scenario: QC Ingest Asset and Non Approved destination and check Delivery for German Markets
Meta:@GDN
Given modify Destination collection for following fields:
| DestinationName | HoldForApproval | HouseNumberMandatory | ProxyApprove | ApprovalOnly |
|    Westwing     |  true           |  true                |  true        |  true        |
And refresh destinations
And I created the following agency:
| Name   |    A4User     |
| GDNTDA33 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU33 | agency.admin | GDNTDA33     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA33':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR33 | GDNTDBR33 | GDNTDSB33 | GDNTDP33 |
And logged in with details of 'GDNTDU33'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR33   | GDNTDBR33   | GDNTDSB33   | GDNTDP33   | GDNTDC33   |GDNTDCN33_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT33 | Westwing:Standard|
And complete order contains item with clock number 'GDNTDCN33_1' with following fields:
| Job Number  | PO Number |
| GDNTD3333   | GDNTD3333 |
And wait for finish place order with following item clock number 'GDNTDCN33_1' to A4
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA33    | GDNTDCN33_1  |
And wait for delivery doc available with following fields:
| ClockNumberList | Email |
| GDNTDCN33_1 |  GDNTDU33 |
And check DeliveryStatus of A5 with following fields:
| ClockNumberList | Email | DestinationID | Status |
| GDNTDCN33_1 |  GDNTDU33 |  8056         | [GDN] Awaiting station release |
And created 'tv' order with market 'Germany' and items with following fields:
| Clock Number   | Destination     |
| GDNTDCN33_2     | MediaGroup One:Standard |
And I open order item with following clock number 'GDNTDCN33_2'
And add to order for order item at Add media to your order form following assets 'GDNTDT33'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD33_2 | GDNTD33_2 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'GDNTDCN33_1' to A4
Then find 'DeliveryJobResponse' to the '1' destinations
And check DeliveryStatus of A5 with following fields:
| ClockNumberList | Email | DestinationID | Status |
| GDNTDCN33_1 |  GDNTDU33 |  7384         | [GDN] Transfer Complete |



Scenario: QC Ingest Asset and Approved destination and check Delivery for German Markets
Meta:@GDN
Given I created the following agency:
| Name   |    A4User     |
| GDNTDA34 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU34 | agency.admin | GDNTDA34     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA34':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR34 | GDNTDBR34 | GDNTDSB34 | GDNTDP34 |
And logged in with details of 'GDNTDU34'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR34   | GDNTDBR34   | GDNTDSB34   | GDNTDP34   | GDNTDC34   |GDNTDCN34_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT34 | MediaGroup One:Standard|
And complete order contains item with clock number 'GDNTDCN34_1' with following fields:
| Job Number  | PO Number |
| GDNTD3434   | GDNTD3434 |
And wait for finish place order with following item clock number 'GDNTDCN34_1' to A4
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA34    | GDNTDCN34_1  |
And find 'DeliveryJobResponse' to the '1' destinations
And wait for delivery doc available with following fields:
| ClockNumberList | Email |
| GDNTDCN34_1 |  GDNTDU34 |
And check DeliveryStatus of A5 with following fields:
| ClockNumberList | Email | DestinationID | Status |
| GDNTDCN34_1 |  GDNTDU34 |  7384         | [GDN] Transfer Complete |
And modify Destination collection for following fields:
| DestinationName | HoldForApproval | HouseNumberMandatory | ProxyApprove | ApprovalOnly |
|    Westwing     |  true           |  true                |  true        |  true        |
And refresh destinations
And created 'tv' order with market 'Germany' and items with following fields:
| Clock Number   | Destination     |
| GDNTDCN34_2     | Westwing:Standard |
And I open order item with following clock number 'GDNTDCN34_2'
And add to order for order item at Add media to your order form following assets 'GDNTDT34'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD34_2 | GDNTD34_2 |
And confirm order on Order Proceed page
And wait for '60' seconds
And check DeliveryStatus of A5 with following fields:
| ClockNumberList | Email | DestinationID | Status |
| GDNTDCN34_1 |  GDNTDU34 |  8056        | [GDN] Awaiting station release |
And approve destinations with following fields:
|ClockNumber  | Email    | HouseNumber | DestinationID |
| GDNTDCN34_1 | GDNTDU34 |  123456789  |   8056        |
Then redeliver asset using externalId to the destinations with following fields:
| ClockNumberList | Email | DestinationID |
| GDNTDCN34_1 |  GDNTDU34 |  8056         |
And find 'DeliveryJobResponse' to the '1' destinations
And check DeliveryStatus of A5 with following fields:
| ClockNumberList | Email | DestinationID | Status |
| GDNTDCN34_1 |  GDNTDU34 |  8056         | [GDN] Transfer Complete |


