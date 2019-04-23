!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery Set Master Arrived Options


Scenario: set master arrived options for order
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA20  | DefaultA4User  |  Advertiser |      ordering      |
| GDNTDTI20 | DefaultA4User  |   Ingest    |       adpath       |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU20 |       agency.admin  |   GDNTDA20  | ordering |
| GDNTDTM20| traffic.traffic.manager |   GDNTDTI20  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA20':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR20 | GDNTDBR20 | GDNTDSB20 | GDNTDP20 |
And logged in with details of 'GDNTDU20'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR20 | GDNTDBR20 | GDNTDSB20 | GDNTDP20 | GDNTDC20 |GDNTDCN20_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT20 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN20_1' with following fields:
| Job Number  | PO Number |
| GDNTD2020   | GDNTD2020 |
And wait for finish place order with following item clock number 'GDNTDCN20_1' to A4
When set master arrived comment to order using traffic manager:
| OrderingEmail | adpathEmail | clockNumber |tapeNumber | masterArrivedComment | masterArrivedDate |
| GDNTDU20      | GDNTDTM20   | GDNTDCN20_1 |123456789  | Test for GDN Automation Regression | currentTime |
And wait for '20' seconds
Then verify ingest doc for following fields:
|clockNumber | tapeNumber | masterArrivedComment | masterArrivedDate |
|GDNTDCN20_1 | 123456789  | Test for GDN Automation Regression     | currentTime |



Scenario: delete master arrived options for order
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA21  | DefaultA4User  |  Advertiser |      ordering      |
| GDNTDTI21 | DefaultA4User  |   Ingest    |       adpath       |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU21 |       agency.admin  |   GDNTDA21  | ordering |
| GDNTDTM21| traffic.traffic.manager |   GDNTDTI21  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA21':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR21 | GDNTDBR21 | GDNTDSB21 | GDNTDP21 |
And logged in with details of 'GDNTDU21'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR21 | GDNTDBR21 | GDNTDSB21 | GDNTDP21 | GDNTDC21 |GDNTDCN21_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT21 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN21_1' with following fields:
| Job Number  | PO Number |
| GDNTD2121   | GDNTD2121 |
And wait for finish place order with following item clock number 'GDNTDCN21_1' to A4
When set master arrived comment to order using traffic manager:
| OrderingEmail | adpathEmail | clockNumber |tapeNumber | masterArrivedComment | masterArrivedDate |
| GDNTDU21      | GDNTDTM21   | GDNTDCN21_1 |123456789  | Test for GDN Automation Regression | currentTime |
And wait for '20' seconds
Then remove master arrived comment to order using traffic manager:
| OrderingEmail | adpathEmail | clockNumber |tapeNumber | masterArrivedComment | masterArrivedDate |
| GDNTDU21      | GDNTDTM21   | GDNTDCN21_1 |123456789  | Test for GDN Automation Regression | currentTime |
And wait for '20' seconds
And verify ingest doc for following fields:
|clockNumber | tapeNumber | masterArrivedComment | masterArrivedDate |
|GDNTDCN21_1 | Null  | Null     | Null |

