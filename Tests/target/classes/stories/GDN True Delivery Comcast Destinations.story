!--QA-249
Feature:          GDN Ingest and Delivery for Comcast Destinations
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery for Comcast Destinations


Scenario: Ingest with One Asset and delivery to destinations using German Markets
Meta:@GDN
Given I created the following agency:
| Name   |    A4User     |
| GDNTDA40 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU40 | agency.admin | GDNTDA40     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA40':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR40 | GDNTDBR40 | GDNTDSB40 | GDNTDP40 |
And logged in with details of 'GDNTDU40'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |Destination         |
| automated test info    | GDNTDAR40   | GDNTDBR40   | GDNTDSB40   | GDNTDP40   | GDNTDC40   |GDNTDCN40_1    | 20       | 12/14/2022 |HD 1080i 25fps  | GDNTDT40 | Yes            |0891:Standard (US);0892:Standard (US)|
And complete order contains item with clock number 'GDNTDCN40_1' with following fields:
| Job Number  | PO Number |
| GDNTD4040   | GDNTD4040 |
And wait for finish place order with following item clock number 'GDNTDCN40_1' to A4
When ingested assests with following clocks:
 | ClockNumberList |
 | GDNTDCN40_1 |
And wait for '120' seconds
Then find 'DeliveryJobResponse' to the '1' destinations


Scenario: Ingest with Two Assets and delivery to destinations using German Markets
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA41 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU41 | agency.admin | GDNTDA41    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA41':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR41 | GDNTDBR41 | GDNTDSB41 | GDNTDP41 |
And logged in with details of 'GDNTDU41'
And create 'tv' order with market 'United States & Canada' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |Destination         |
| automated test info    | GDNTDAR41   | GDNTDBR41   | GDNTDSB41   | GDNTDP41   | GDNTDC41   |GDNTDCN41_1    | 20       | 12/14/2022 |HD 1080i 25fps  | GDNTDT41 | Yes            |0891:Standard (US);0892:Standard (US)|
| automated test info    | GDNTDAR41   | GDNTDBR41   | GDNTDSB41   | GDNTDP41   | GDNTDC41   |GDNTDCN41_2    | 20       | 12/14/2022 |HD 1080i 25fps  | GDNTDT41 | Yes            |0891:Standard (US);0893:Standard (US)|
And complete order contains item with clock number 'GDNTDCN41_1' with following fields:
| Job Number  | PO Number |
| GDNTD4141  | GDNTD4141 |
And wait for finish place order with following item clock number 'GDNTDCN41_1' to A4
When ingested assests with following clocks:
 | ClockNumberList |
 | GDNTDCN41_1 |
 | GDNTDCN41_2 |
And wait for '120' seconds
Then find 'DeliveryJobResponse' to the '2' destinations



