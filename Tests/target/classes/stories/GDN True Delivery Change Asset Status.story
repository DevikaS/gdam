!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery Asset status


Scenario: setting Asset status to New
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA9 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU9 | agency.admin | GDNTDA9    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA9':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR9 | GDNTDBR9 | GDNTDSB9 | GDNTDP9 |
And logged in with details of 'GDNTDU9'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR9 | GDNTDBR9 | GDNTDSB9 | GDNTDP9 | GDNTDC9 |GDNTDCN9_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT9 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;MediaGroup One:Standard|
And complete order contains item with clock number 'GDNTDCN9_1' with following fields:
| Job Number  | PO Number |
| GDNTD99   | GDNTD99 |
And wait for finish place order with following item clock number 'GDNTDCN9_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA9 | GDNTDCN9_1  |
Then set assest status to 'New' for following fields:
| Email   | clockNumber |
| GDNTDU9| GDNTDCN9_1 |
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN9_1 |



Scenario: setting Asset status to New and Reingest
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA10 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU10 | agency.admin | GDNTDA10    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA10':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR10 | GDNTDBR10 | GDNTDSB10 | GDNTDP10 |
And logged in with details of 'GDNTDU10'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR10 | GDNTDBR10 | GDNTDSB10 | GDNTDP10 | GDNTDC10 |GDNTDCN10_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT10 |Moviepilot:Standard;dailyme:Standard;IP Deutschland (online):Standard;kino.de:Standard;MediaGroup One:Standard|
And complete order contains item with clock number 'GDNTDCN10_1' with following fields:
| Job Number  | PO Number |
| GDNTD10   | GDNTD10 |
And wait for finish place order with following item clock number 'GDNTDCN10_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA10 | GDNTDCN10_1  |
And set assest status to 'New' for following fields:
| Email   | clockNumber |
| GDNTDU10| GDNTDCN10_1 |
Then verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN10_1 |
And ingest assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA10 | GDNTDCN10_1  |
And find 'DeliveryJobResponse' to the '5' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN10_1 |  GDNTDU10 | GDNTDAR10 | GDNTDP10 | AutoTest | GDNTDT10 | GDNTDC10 | GDNTDA10 |


Scenario: setting Asset status to New and check delivery not started
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA11 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU11 | agency.admin | GDNTDA11    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA11':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR11 | GDNTDBR11 | GDNTDSB11 | GDNTDP11 |
And logged in with details of 'GDNTDU11'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR11 | GDNTDBR11 | GDNTDSB11 | GDNTDP11 | GDNTDC11 |GDNTDCN11_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT11 |IP Deutschland (online):Standard;kino.de:Standard;MediaGroup One:Standard|
And complete order contains item with clock number 'GDNTDCN11_1' with following fields:
| Job Number  | PO Number |
| GDNTD11   | GDNTD11 |
And wait for finish place order with following item clock number 'GDNTDCN11_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA11 | GDNTDCN11_1  |
And set assest status to 'New' for following fields:
| Email   | clockNumber |
| GDNTDU11| GDNTDCN11_1 |
Then find 'DeliveryJobResponse' to the '0' destinations


Scenario: setting Asset status to Tape Received - Awaiting Ingestion
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA12 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU12 | agency.admin | GDNTDA12    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA12':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR12 | GDNTDBR12 | GDNTDSB12 | GDNTDP12 |
And logged in with details of 'GDNTDU12'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR12 | GDNTDBR12 | GDNTDSB12 | GDNTDP12 | GDNTDC12 |GDNTDCN12_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT12 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard;MediaGroup One:Standard|
And complete order contains item with clock number 'GDNTDCN12_1' with following fields:
| Job Number  | PO Number |
| GDNTD1212   | GDNTD1212 |
And wait for finish place order with following item clock number 'GDNTDCN12_1' to A4
When set assest status to 'Tape Received - Awaiting Ingestion' for following fields:
| Email   | clockNumber |
| GDNTDU12| GDNTDCN12_1 |
Then verify ingest doc for following fields:
| status | clockNumber |
|  Tape Received - Awaiting Ingestion   | GDNTDCN12_1 |


Scenario: setting Asset status to Cancelled
Meta:@GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA13 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU13 | agency.admin | GDNTDA13    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA13':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR13 | GDNTDBR13 | GDNTDSB13 | GDNTDP13 |
And logged in with details of 'GDNTDU13'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR13 | GDNTDBR13 | GDNTDSB13 | GDNTDP13 | GDNTDC13 |GDNTDCN13_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT13 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard;MediaGroup One:Standard|
And complete order contains item with clock number 'GDNTDCN13_1' with following fields:
| Job Number  | PO Number |
| GDNTD1213   | GDNTD1213 |
And wait for finish place order with following item clock number 'GDNTDCN13_1' to A4
When set assest status to 'Cancelled' for following fields:
| Email   | clockNumber |
| GDNTDU13| GDNTDCN13_1 |
Then verify ingest doc for following fields:
|status | clockNumber |
|Null   | GDNTDCN13_1 |
And check order status set to 'completed' for clock 'GDNTDCN13_1'