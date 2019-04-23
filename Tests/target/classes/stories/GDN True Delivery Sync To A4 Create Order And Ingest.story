!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery Create Order and Ingest

Scenario: Ingest with One Asset and delivery to destinations using German Markets
Meta:@OneAssetperOrder
Given I created the following agency:
| Name   |    A4User     |
| GDNTDA1 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU1 | agency.admin | GDNTDA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR1 | GDNTDBR1 | GDNTDSB1 | GDNTDP1 |
And logged in with details of 'GDNTDU1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR1   | GDNTDBR1   | GDNTDSB1   | GDNTDP1   | GDNTDC1   |GDNTDCN1_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT1 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN1_1' with following fields:
| Job Number  | PO Number |
| GDNTD11   | GDNTD11 |
And wait for finish place order with following item clock number 'GDNTDCN1_1' to A4
When ingested assests with following clocks:
|ClockNumberList|
| GDNTDCN1_1    |
Then find 'DeliveryJobResponse' to the '5' destinations


Scenario: Ingest with Two Assets and delivery to destinations using German Markets
Meta:@TwoAssetsperOrder
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU2 | agency.admin | GDNTDA2    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA2':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR2 | GDNTDBR2 | GDNTDSB2 | GDNTDP2 |
And logged in with details of 'GDNTDU2'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR2 | GDNTDBR2 | GDNTDSB2 | GDNTDP2 | GDNTDC2 |GDNTDCN2_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT2 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
| automated test info    | GDNTDAR2 | GDNTDBR2 | GDNTDSB2 | GDNTDP2 | GDNTDC2 |GDNTDCN2_2 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT2 | MediaGroup One:Standard;Viacom DE online:Standard;WeischerOnline:Standard;kino.de:Standard;YOC:Standard|
And complete order contains item with clock number 'GDNTDCN2_1' with following fields:
| Job Number  | PO Number |
| GDNTD22   | GDNTD22 |
And wait for finish place order with following item clock number 'GDNTDCN2_1' to A4
When ingested assests with following clocks:
|ClockNumberList|
| GDNTDCN2_1 |
| GDNTDCN2_2 |
Then find 'DeliveryJobResponse' to the '10' destinations


Scenario: A5 Ingest with one Asset and delivery to destinations using German Markets
Meta:@A5IngestoneAssetsperOrder
     @GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA3 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU3 | agency.admin | GDNTDA3    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA3':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR3 | GDNTDBR3 | GDNTDSB3 | GDNTDP3 |
And logged in with details of 'GDNTDU3'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR3 | GDNTDBR3 | GDNTDSB3 | GDNTDP3 | GDNTDC3 |GDNTDCN3_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT3 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN3_1' with following fields:
| Job Number  | PO Number |
| GDNTD33   | GDNTD33 |
And wait for finish place order with following item clock number 'GDNTDCN3_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA3 | GDNTDCN3_1  |
Then find 'DeliveryJobResponse' to the '5' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN3_1 |  GDNTDU3 | GDNTDAR3 | GDNTDP3 | AutoTest | GDNTDT3 | GDNTDC3 | GDNTDA3 |


Scenario: A5 Ingest with multiple Assets and delivery to destinations using German Markets
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA4 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU4 | agency.admin | GDNTDA4    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA4':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR4 | GDNTDBR4 | GDNTDSB4 | GDNTDP4 |
And logged in with details of 'GDNTDU4'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR4 | GDNTDBR4 | GDNTDSB4 | GDNTDP4 | GDNTDC4 |GDNTDCN4_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT4 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
| automated test info    | GDNTDAR4 | GDNTDBR4 | GDNTDSB4 | GDNTDP4 | GDNTDC4 |GDNTDCN4_2 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT4 | MediaGroup One:Standard;Viacom DE online:Standard;WeischerOnline:Standard;kino.de:Standard;Moviepilot:Standard|
And complete order contains item with clock number 'GDNTDCN4_1' with following fields:
| Job Number  | PO Number |
| GDNTD4   | GDNTD4 |
And wait for finish place order with following item clock number 'GDNTDCN4_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA4 | GDNTDCN4_1  |
 | GDNTDA4 | GDNTDCN4_2  |
Then find 'DeliveryJobResponse' to the '10' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN4_1 |  GDNTDU4 | GDNTDAR4 | GDNTDP4 | AutoTest | GDNTDT4 | GDNTDC4 | GDNTDA4 |
| GDNTDCN4_2 |  GDNTDU4 | GDNTDAR4 | GDNTDP4 | AutoTest | GDNTDT4 | GDNTDC4 | GDNTDA4 |



