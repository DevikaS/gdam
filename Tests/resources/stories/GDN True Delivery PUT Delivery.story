!--QA-378
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery PUT Delivery When Destination offline



Scenario: Delivery using orderId when destination is offline
Meta:@GDN
Given modify Destination collection for following fields:
| DestinationName | statusID |
|    YOC          |    50    |
And refresh destinations
And I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA26  | DefaultA4User  |  Advertiser |      ordering      |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU26 |       agency.admin  |   GDNTDA26  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA26':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR26 | GDNTDBR26 | GDNTDSB26 | GDNTDP26 |
And logged in with details of 'GDNTDU26'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR26 | GDNTDBR26 | GDNTDSB26 | GDNTDP26 | GDNTDC26 |GDNTDCN26_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT26 | YOC:Standard|
And complete order contains item with clock number 'GDNTDCN26_1' with following fields:
| Job Number  | PO Number |
| GDNTD2626   | GDNTD2626 |
And wait for finish place order with following item clock number 'GDNTDCN26_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA26 | GDNTDCN26_1  |
And find 'DeliveryJobResponse' to the '0' destinations
And modify Destination collection for following fields:
| DestinationName | statusID |
|    YOC          |    51    |
And refresh destinations
Then deliver order using orderId with following fields:
| ClockNumberList | Email   |
| GDNTDCN26_1     |GDNTDU26 |
And find 'DeliveryJobResponse' to the '1' destinations


Scenario: Delivery using orderId with one destination is offline and the other online
Meta:@GDN
Given modify Destination collection for following fields:
| DestinationName | statusID |
|    YOC          |    50    |
And refresh destinations
And I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA27  | DefaultA4User  |  Advertiser |      ordering      |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU27 |       agency.admin  |   GDNTDA27  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA27':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR27 | GDNTDBR27 | GDNTDSB27 | GDNTDP27 |
And logged in with details of 'GDNTDU27'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR27 | GDNTDBR27 | GDNTDSB27 | GDNTDP27 | GDNTDC27 |GDNTDCN27_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT27 | YOC:Standard;Moviepilot:Standard|
And complete order contains item with clock number 'GDNTDCN27_1' with following fields:
| Job Number  | PO Number |
| GDNTD2727   | GDNTD2727 |
And wait for finish place order with following item clock number 'GDNTDCN27_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA27 | GDNTDCN27_1  |
And find 'DeliveryJobResponse' to the '1' destinations
And modify Destination collection for following fields:
| DestinationName | statusID |
|    YOC          |    51    |
And refresh destinations
Then deliver order using orderId with following fields:
| ClockNumberList | Email   |
| GDNTDCN27_1     |GDNTDU27 |
And find 'DeliveryJobResponse' to the '1' destinations