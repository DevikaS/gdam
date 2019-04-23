!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery when Disabling A4


Scenario: Disabling A4 integration One Asset and Ingest for Germany Markets
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA23 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU23 | agency.admin | GDNTDA23    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA23':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR23 | GDNTDBR23 | GDNTDSB23 | GDNTDP23 |
And logged in with details of 'GDNTDU23'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR23 | GDNTDBR23 | GDNTDSB23 | GDNTDP23 | GDNTDC23 |GDNTDCN23_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT23 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN23_1' with following fields:
| Job Number  | PO Number |
| GDNTD2323   | GDNTD2323 |
And wait for finish place order with following item clock number 'GDNTDCN23_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA23 | GDNTDCN23_1  |
Then find 'DeliveryJobResponse' to the '5' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN23_1 |  GDNTDU23 | GDNTDAR23 | GDNTDP23 | AutoTest | GDNTDT23 | GDNTDC23 | GDNTDA23 |


Scenario: Disabling A4 integration TWO Assets and Ingest for Germany Markets
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA24 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU24 | agency.admin | GDNTDA24    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA24':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR24 | GDNTDBR24 | GDNTDSB24 | GDNTDP24 |
And logged in with details of 'GDNTDU24'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR24 | GDNTDBR24 | GDNTDSB24 | GDNTDP24 | GDNTDC24 |GDNTDCN24_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT24 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
| automated test info    | GDNTDAR24 | GDNTDBR24 | GDNTDSB24 | GDNTDP24 | GDNTDC24 |GDNTDCN24_2 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT24 | MediaGroup One:Standard;Viacom DE online:Standard;WeischerOnline:Standard;Moviepilot:Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN24_1' with following fields:
| Job Number  | PO Number |
| GDNTD2424   | GDNTD2424 |
And wait for finish place order with following item clock number 'GDNTDCN24_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA24 | GDNTDCN24_1  |
 | GDNTDA24 | GDNTDCN24_2  |
Then find 'DeliveryJobResponse' to the '10' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN24_1 |  GDNTDU24 | GDNTDAR24 | GDNTDP24 | AutoTest | GDNTDT24 | GDNTDC24 | GDNTDA24 |
| GDNTDCN24_2 |  GDNTDU24 | GDNTDAR24 | GDNTDP24 | AutoTest | GDNTDT24 | GDNTDC24 | GDNTDA24 |


Scenario: Disabling A4 integration check order status
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA25 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU25 | agency.admin | GDNTDA25    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA25':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR25 | GDNTDBR25 | GDNTDSB25 | GDNTDP25 |
And logged in with details of 'GDNTDU25'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR25 | GDNTDBR25 | GDNTDSB25 | GDNTDP25 | GDNTDC25 |GDNTDCN25_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT25 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN25_1' with following fields:
| Job Number  | PO Number |
| GDNTD2525   | GDNTD2525 |
And wait for finish place order with following item clock number 'GDNTDCN25_1' to A4
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA25 | GDNTDCN25_1  |
Then find 'DeliveryJobResponse' to the '5' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN25_1 |  GDNTDU25 | GDNTDAR25 | GDNTDP25 | AutoTest | GDNTDT25 | GDNTDC25 | GDNTDA25 |
And check order status set to 'completed' for clock 'GDNTDCN25_1'

