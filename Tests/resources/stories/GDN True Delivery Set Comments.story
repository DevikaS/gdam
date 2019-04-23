!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery check comments for ingest Doc


Scenario: Adding comments using traffic user and verify from ingest doc
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA7  | DefaultA4User  |  Advertiser |      ordering      |
| GDNTDTI7 | DefaultA4User  |   Ingest    |       adpath       |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU7 |       agency.admin  |   GDNTDA7  | ordering |
| GDNTDTM7| traffic.traffic.manager |   GDNTDTI7  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA7':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR7 | GDNTDBR7 | GDNTDSB7 | GDNTDP7 |
And logged in with details of 'GDNTDU7'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR7 | GDNTDBR7 | GDNTDSB7 | GDNTDP7 | GDNTDC7 |GDNTDCN7_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT3 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN7_1' with following fields:
| Job Number  | PO Number |
| GDNTD77   | GDNTD77 |
And wait for finish place order with following item clock number 'GDNTDCN7_1' to A4
When set comment to order using traffic manager:
| Email   | clockNumber |
| GDNTDTM7| GDNTDCN7_1 |
And wait for '20' seconds
And verify ingest doc for following fields:
| comment | clockNumber |
| Auto test to verify comment on ingestdoc   | GDNTDCN7_1 |



Scenario: Adding comments using traffic user and ingest, check comment not removed
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA8  | DefaultA4User  |  Advertiser |      ordering      |
| GDNTDTI8 | DefaultA4User  |   Ingest    |       adpath       |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU8 |       agency.admin  |   GDNTDA8  | ordering |
| GDNTDTM8| traffic.traffic.manager |   GDNTDTI8  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA8':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR8 | GDNTDBR8 | GDNTDSB8 | GDNTDP8 |
And logged in with details of 'GDNTDU8'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR8 | GDNTDBR8 | GDNTDSB8 | GDNTDP8 | GDNTDC8 |GDNTDCN8_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT8 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN8_1' with following fields:
| Job Number  | PO Number |
| GDNTD88   | GDNTD88 |
And wait for finish place order with following item clock number 'GDNTDCN8_1' to A4
When set comment to order using traffic manager:
| Email   | clockNumber |
| GDNTDTM8| GDNTDCN8_1 |
And wait for '20' seconds
And verify ingest doc for following fields:
| comment | clockNumber |
| Auto test to verify comment on ingestdoc   | GDNTDCN8_1 |
Then ingest assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA8    | GDNTDCN8_1  |
And wait for '20' seconds
And verify ingest doc for following fields:
| comment | clockNumber |
| Auto test to verify comment on ingestdoc   | GDNTDCN8_1 |