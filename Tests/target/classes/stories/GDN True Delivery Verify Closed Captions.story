!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery Verify Closed Captions


Scenario: Check subtitling for Spain markets after ingest
Meta: @GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA18 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU18 | agency.admin | GDNTDA18    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA18':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR18 | GDNTDBR18 | GDNTDSB18 | GDNTDP18 |
And logged in with details of 'GDNTDU18'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  |  Clave   | Watermarking Required | Subtitles Required | Destination         |
| automated test info    | GDNTDAR18 | GDNTDBR18 | GDNTDSB18 | GDNTDP18 | GDNTDC18 |GDNTDCN18_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT18 | GDNTDC18 | Yes | Yes  |8TV:Standard|
And complete order contains item with clock number 'GDNTDCN18_1' with following fields:
| Job Number  | PO Number |
| GDNTD1818   | GDNTD1818 |
And wait for finish place order with following item clock number 'GDNTDCN18_1' to A4
And verify ingest doc for following fields:
|closedCaptionStatus | watermarkingInitialised | clockNumber |
|Awaiting            | true                    |  GDNTDCN18_1 |
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA18 | GDNTDCN18_1  |
Then find 'DeliveryJobResponse' to the '1' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Title | Campaign| AgencyUnique | Clave   | Watermarking Required | Subtitles Required |
| GDNTDCN18_1 |  GDNTDU18 | GDNTDAR18 | GDNTDP18 |GDNTDT18 | GDNTDC18 | GDNTDA18 |GDNTDC18 | Yes | Yes  |




Scenario: Check subtitling for Spain markets after ingest
Meta: @GDN
Given I created the following agency:
| Name    |    A4User     |
| GDNTDA19 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| GDNTDU19 | agency.admin | GDNTDA19    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA19':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR19 | GDNTDBR19 | GDNTDSB19 | GDNTDP19 |
And logged in with details of 'GDNTDU19'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  |  Clave   | Watermarking Required | Subtitles Required | Destination         |
| automated test info    | GDNTDAR19 | GDNTDBR19 | GDNTDSB19 | GDNTDP19 | GDNTDC19 |GDNTDCN19_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT19 | GDNTDC19 | Yes | Already Supplied  |8TV:Standard|
And complete order contains item with clock number 'GDNTDCN19_1' with following fields:
| Job Number  | PO Number |
| GDNTD1919   | GDNTD1919 |
And wait for finish place order with following item clock number 'GDNTDCN19_1' to A4
And verify ingest doc for following fields:
|closedCaptionStatus | watermarkingInitialised | clockNumber |
|Supplied            | true                    |  GDNTDCN19_1 |
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA19 | GDNTDCN19_1  |
Then find 'DeliveryJobResponse' to the '1' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Title | Campaign| AgencyUnique | Clave   | Watermarking Required | Subtitles Required |
| GDNTDCN19_1 |  GDNTDU19 | GDNTDAR19 | GDNTDP19 | GDNTDT19 | GDNTDC19 | GDNTDA19 |GDNTDC19 | Yes | Already Supplied |
