!--ORD-3689
!--ORD-3826
Feature: Domestic billing product for Additional services for friendly markets
Narrative:
In order to:
As a AgencyAdmin
I want to check a domestic billing product for Additional services for friendly markets

Scenario: check domestic billing product for Additional services is shown for friendly markets
Meta: @ordering
!--NGN-19470 ---Added enable QC & Ingest step and edited the Billing data
Given I created the following agency:
| Name    | A4User        | Country        | Labels              | SAP ID       |
| DBPASA1 | DefaultA4User | United Kingdom | production_services | DefaultSapID |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DBPASU1 | agency.admin | DBPASA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBPASA1':
| Advertiser | Brand    | Sub Brand | Product  |
| DBPASAR1   | DBPASBR1 | DBPASSB1  | DBPASPR1 |
And logged in with details of 'DBPASU1'
And 'enable' Billing Service
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required |
| automated test info    | DBPASAR1   | DBPASBR1 | DBPASSB1  | DBPASPR1 | DBPASC1  | DBPASCN1     | 20       | 10/14/2022     | HD 1080i 25fps | DBPAST1 | BTI Studios        |
And create for 'tv' order with item clock number 'DBPASCN1' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'DBPASCN1'
When I go to Order Proceed page for order contains order item with following clock number 'DBPASCN1'
Then I should see following Billing data on Order Proceed page:
| Item                               | QTY | Unit   | TotalPerItem | Subtotal | Tax   | Total  |
| Subtitling - IMS                   | 1   | 42.00  | 42.00        | 360.00   | 75.60 | 435.60 |
| QC & Ingest Fee                    | 1   | 200.00 | 200.00       | 360.00   | 75.60 | 435.60 |
| Production - Tagging - UpTo 60SD IE  | 1   | 118.00 | 118.00       | 360.00   | 75.60 | 435.60 |


Scenario: check domestic billing product for Additional services for not-friendly markets
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | Labels              | SAP ID       |
| DBPASA1 | DefaultA4User | United Kingdom | production_services | DefaultSapID |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DBPASU1 | agency.admin | DBPASA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DBPASA1':
| Advertiser | Brand    | Sub Brand | Product  |
| DBPASAR1   | DBPASBR1 | DBPASSB1  | DBPASPR1 |
And logged in with details of 'DBPASU1'
And 'enable' Billing Service
And create 'tv' order with market 'Belgium' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   |Destination             |
| automated test info    | DBPASAR1   | DBPASBR1 | DBPASSB1  | DBPASPR1 | DBPASC2  | DBPASCN2     | 20       | 10/14/2022     | HD 1080i 25fps | DBPAST2 |New Station - Belgium:Standard |
And create for 'tv' order with item clock number 'DBPASCN2' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
When I go to Order Proceed page for order contains order item with following clock number 'DBPASCN2'
Then I should see following Billing data on Order Proceed page:
| Item                                      | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| SD International Standard Normal (Digital)| 1   | 150.00 | 150.00      | 268.00  | 56.28 | 324.28 |
| Production - Tagging - UpTo 60SD BE            | 1   | 118.00 | 118.00      | 268.00  | 56.28 | 324.28 |