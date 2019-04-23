!--QA-382
Feature:          Delete and Add Ingest Repo
Narrative:
In order to
As a              AgencyAdmin
I want to         Check to Delete and Add Ingest Repo


Scenario: Delete Ingest Repo for German Markets
Meta:@GDN
Given I created the following agency:
| Name   |    A4User     |
| GDNTDA35 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU35 | agency.admin | GDNTDA35     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA35':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR35 | GDNTDBR35 | GDNTDSB35 | GDNTDP35 |
And logged in with details of 'GDNTDU35'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR35   | GDNTDBR35   | GDNTDSB35  | GDNTDP35   | GDNTDC35   |GDNTDCN35_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT35 | Filmstarts:Standard|
And complete order contains item with clock number 'GDNTDCN35_1' with following fields:
| Job Number  | PO Number |
| GDNTD3535   | GDNTD3535 |
When waited for finish place order with following item clock number 'GDNTDCN35_1' to A4
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN35_1 |
Then delete ingest repo with following fields:
| ClockNumberList |
| GDNTDCN35_1     |
And verify ingest doc for following fields:
| status | clockNumber |
|  Null   | GDNTDCN35_1 |


Scenario: Add Ingest Repo for German Markets
Meta:@GDN
Given I created the following agency:
| Name   |    A4User     |
| GDNTDA36 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU36 | agency.admin | GDNTDA36     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA36':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR36 | GDNTDBR36 | GDNTDSB36 | GDNTDP36 |
And logged in with details of 'GDNTDU36'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR36   | GDNTDBR36   | GDNTDSB36  | GDNTDP36   | GDNTDC36   |GDNTDCN36_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT36 | Filmstarts:Standard|
And complete order contains item with clock number 'GDNTDCN36_1' with following fields:
| Job Number  | PO Number |
| GDNTD3636   | GDNTD3636 |
When waited for finish place order with following item clock number 'GDNTDCN36_1' to A4
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN36_1 |
And delete ingest repo with following fields:
| ClockNumberList |
| GDNTDCN36_1     |
And verify ingest doc for following fields:
| status | clockNumber |
|  Null   | GDNTDCN36_1 |
Then add ingest repo with following fields:
| ClockNumberList |
| GDNTDCN36_1     |
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN36_1 |


Scenario: Delete and Add Ingest Repo and Ingest for German Markets
Meta:@GDN
Given I created the following agency:
| Name   |    A4User     |
| GDNTDA37 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU37 | agency.admin | GDNTDA37     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA37':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR37 | GDNTDBR37 | GDNTDSB37 | GDNTDP37 |
And logged in with details of 'GDNTDU37'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR37   | GDNTDBR37   | GDNTDSB37  | GDNTDP37   | GDNTDC37   |GDNTDCN37_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT37 | Filmstarts:Standard|
And complete order contains item with clock number 'GDNTDCN37_1' with following fields:
| Job Number  | PO Number |
| GDNTD3737   | GDNTD3737 |
When waited for finish place order with following item clock number 'GDNTDCN37_1' to A4
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN37_1 |
And delete ingest repo with following fields:
| ClockNumberList |
| GDNTDCN37_1     |
And verify ingest doc for following fields:
| status | clockNumber |
|  Null   | GDNTDCN37_1 |
Then add ingest repo with following fields:
| ClockNumberList |
| GDNTDCN37_1     |
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN37_1 |
And ingest assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA37 | GDNTDCN37_1  |
And find 'DeliveryJobResponse' to the '1' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN37_1 |  GDNTDU37 | GDNTDAR37 | GDNTDP37 | AutoTest | GDNTDT37 | GDNTDC37 | GDNTDA37 |


