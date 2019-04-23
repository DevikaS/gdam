!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery Redeliver Cancel and Complete Deliveries



Scenario: Redeliver Asset using externalId
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA14  | DefaultA4User  |  Advertiser |      ordering      |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU14 |       agency.admin  |   GDNTDA14  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA14':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR14 | GDNTDBR14 | GDNTDSB14 | GDNTDP14 |
And logged in with details of 'GDNTDU14'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR14 | GDNTDBR14 | GDNTDSB14 | GDNTDP14 | GDNTDC14 |GDNTDCN14_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT14 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN14_1' with following fields:
| Job Number  | PO Number |
| GDNTD1414   | GDNTD1414 |
And wait for finish place order with following item clock number 'GDNTDCN14_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA14 | GDNTDCN14_1  |
And find 'DeliveryJobResponse' to the '5' destinations
Then redeliver asset using externalId to the destinations with following fields:
| ClockNumberList | Email | DestinationID |
| GDNTDCN14_1 |  GDNTDU14 | 7390          |
| GDNTDCN14_1 |  GDNTDU14 | 7386          |
And find 'DeliveryJobResponse' to the '2' destinations


Scenario: Redeliver Asset using deliveryId
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA15  | DefaultA4User  |  Advertiser |      ordering      |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU15 |       agency.admin  |   GDNTDA15  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA15':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR15 | GDNTDBR15 | GDNTDSB15 | GDNTDP15 |
And logged in with details of 'GDNTDU15'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR15 | GDNTDBR15 | GDNTDSB15 | GDNTDP15 | GDNTDC15 |GDNTDCN15_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT15 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN15_1' with following fields:
| Job Number  | PO Number |
| GDNTD1515   | GDNTD1515 |
And wait for finish place order with following item clock number 'GDNTDCN15_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA15 | GDNTDCN15_1  |
And find 'DeliveryJobResponse' to the '5' destinations
Then redeliver asset using deliveryId to the destinations with following fields:
| ClockNumberList | Email |
| GDNTDCN15_1 |  GDNTDU15 |
And find 'DeliveryJobResponse' to the '5' destinations


Scenario: Cancel Delivery using externalId
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA16  | DefaultA4User  |  Advertiser |      ordering      |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU16 |       agency.admin  |   GDNTDA16  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA16':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR16 | GDNTDBR16 | GDNTDSB16 | GDNTDP16 |
And logged in with details of 'GDNTDU16'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR16 | GDNTDBR16 | GDNTDSB16 | GDNTDP16 | GDNTDC16 |GDNTDCN16_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT16 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN16_1' with following fields:
| Job Number  | PO Number |
| GDNTD1616   | GDNTD1616 |
And wait for finish place order with following item clock number 'GDNTDCN16_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA16 | GDNTDCN16_1  |
And wait for delivery doc available with following fields:
| ClockNumberList | Email |
| GDNTDCN16_1     | GDNTDU16 |
Then cancel delivery using externalId to the destinations with following fields:
| ClockNumberList | Email |
| GDNTDCN16_1 |  GDNTDU16 |
And find 'TerminateJobResponse' to the destinations with following fields:
| ClockNumberList | Email |
| GDNTDCN16_1 |  GDNTDU16 |


Scenario: Cancel Delivery using deliveryId
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA17  | DefaultA4User  |  Advertiser |      ordering      |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU17 |       agency.admin  |   GDNTDA17  | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA17':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR17 | GDNTDBR17 | GDNTDSB17 | GDNTDP17 |
And logged in with details of 'GDNTDU17'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR17 | GDNTDBR17 | GDNTDSB17 | GDNTDP17 | GDNTDC17 |GDNTDCN17_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT17 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN17_1' with following fields:
| Job Number  | PO Number |
| GDNTD1717   | GDNTD1717 |
And wait for finish place order with following item clock number 'GDNTDCN17_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA17 | GDNTDCN17_1  |
And wait for delivery doc available with following fields:
| ClockNumberList | Email |
| GDNTDCN17_1     | GDNTDU17 |
Then cancel delivery using deliveryId to the destinations with following fields:
| ClockNumberList | Email |
| GDNTDCN17_1 |  GDNTDU17 |
And find 'TerminateJobResponse' to the destinations with following fields:
| ClockNumberList | Email |
| GDNTDCN17_1 |  GDNTDU17 |