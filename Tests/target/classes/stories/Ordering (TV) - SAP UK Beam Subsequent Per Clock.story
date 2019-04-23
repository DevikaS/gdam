Feature: Billing information on Order Summary Page for Subsequent Per Clock pricing model for UK (BEAM)
Narrative:
In order to: Validate SAP Integration with A5
As a AgencyAdmin
I want to check billing information on Order Summary

Lifecycle:
Before:
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   | Labels              |
| SAPUKBSPC06 | DefaultA4User | United Kingdom | BMTest06 | production_services |
And created users with following fields:
| Email       | Role         | AgencyUnique     |
| SAPUKBSPC06 | agency.admin | SAPUKBSPC06 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SAPUKBSPC06':
| Advertiser  | Brand       | Sub Brand   | Product     |
| SAPUKBSPCAR | SAPUKBSPCBR | SAPUKBSPCPR | SAPUKBSPCPR |
And logged in with details of 'SAPUKBSPC06'
And 'enable' Billing Service


Scenario: Add Media via Nverge, One Clock to Multiple Destination within Market, no subtitles, Standard Service Level, no additional services, Subsequent per clock rate card
Meta: @qaorderingsmoke
@uatorderingsmoke
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                   |
| automated test info    | SAPUKBSPCAR | SAPUKBSPCBR | SAPUKBSPCPR | SAPUKBSPCPR | SAPUKBSPCC | SAPUKBSPCCN1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPCT | None               | SAB:Standard;ABP News:Standard;ARY News:Standard;CBS:Standard |
And add for 'tv' order to item with clock number 'SAPUKBSPCCN1' a New Master with following fields:
| Supply Via | Assignee    | Already Supplied | Message        | Deadline Date |
| nVerge     | SAPUKBSPC06 | should not       | automated test | 12/14/2022    |
When I go to Order Proceed page for order contains order item with following clock number 'SAPUKBSPCCN1'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock          | Item                                            | QTY | Unit   | TotalPerItem  | Subtotal | Tax    | Total   |
|SAPUKBSPCCN1   | SD Standard Normal (Digital)                    | 1   | 40.00  | 40.00         | 190.00   | 39.90  | 229.90  |
|SAPUKBSPCCN1   | Subsequent SD Standard Normal(Digital)          | 3   | 50.00  | 150.00        | 190.00   | 39.90  | 229.90  |

Scenario: Add Media via Nverge, Multiple clock to single Destination within Market, no subtitles, Standard Service Level, no additional services, Subsequent per clock rate card
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination     |
| automated test info    | SAPUKBSPCAR | SAPUKBSPCBR | SAPUKBSPCPR | SAPUKBSPCPR | SAPUKBSPCC | SAPUKBSPCCN2_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPCT | None               | Aastha:Standard |
| automated test info    | SAPUKBSPCAR | SAPUKBSPCBR | SAPUKBSPCPR | SAPUKBSPCPR | SAPUKBSPCC | SAPUKBSPCCN2_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPCT | None               | Aastha:Standard |
| automated test info    | SAPUKBSPCAR | SAPUKBSPCBR | SAPUKBSPCPR | SAPUKBSPCPR | SAPUKBSPCC | SAPUKBSPCCN2_3 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPCT | None               | Aastha:Standard |
| automated test info    | SAPUKBSPCAR | SAPUKBSPCBR | SAPUKBSPCPR | SAPUKBSPCPR | SAPUKBSPCC | SAPUKBSPCCN2_4 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPCT | None               | Aastha:Standard |
And add for 'tv' order to item with clock number 'SAPUKBSPCCN2_1' a New Master with following fields:
| Supply Via | Assignee    | Already Supplied | Message        | Deadline Date |
| nVerge     | SAPUKBSPC06 | should not       | automated test | 12/14/2022    |
When I go to Order Proceed page for order contains order item with following clock number 'SAPUKBSPCCN2_1'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock         | Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax    | Total   |
|SAPUKBSPCCN2_1| SD Standard Normal (Digital) | 1   | 40.00 | 40.00       | 160.00  | 33.60 | 193.60 |
|SAPUKBSPCCN2_2| SD Standard Normal (Digital) | 1   | 40.00 | 40.00       | 160.00  | 33.60 | 193.60 |
|SAPUKBSPCCN2_3| SD Standard Normal (Digital) | 1   | 40.00 | 40.00       | 160.00  | 33.60 | 193.60 |
|SAPUKBSPCCN2_4| SD Standard Normal (Digital) | 1   | 40.00 | 40.00       | 160.00  | 33.60 | 193.60 |


Scenario: Add Media via Physical Media, Multiple clock to Multiple Destination within Market, no subtitles, Standard Service Level, no additional services, Subsequent per clock rate card
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                           |
| automated test info    | SAPUKBSPCAR | SAPUKBSPCBR | SAPUKBSPCPR | SAPUKBSPCPR | SAPUKBSPCC | SAPUKBSPCCN3_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPCT | None               | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard |
| automated test info    | SAPUKBSPCAR | SAPUKBSPCBR | SAPUKBSPCPR | SAPUKBSPCPR | SAPUKBSPCC | SAPUKBSPCCN3_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPCT | None               | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard |
When I open order item with following clock number 'SAPUKBSPCCN3_1'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee    | Already Supplied | Message        | Deadline Date |
| SAPUKBSPC06 | should not       | automated test | 12/14/2022    |
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock         | Item                                   | QTY | Unit   | TotalPerItem | Subtotal | Tax    | Total   |
|SAPUKBSPCCN3_1| Subsequent SD Standard Normal(Digital) | 3   | 50.00  | 150.00       | 380.00   | 79.80  | 459.80  |
|SAPUKBSPCCN3_1| SD Standard Normal (Digital            | 1   | 40.00  | 40.00        | 380.00   | 79.80  | 459.80  |
|SAPUKBSPCCN3_2| Subsequent SD Standard Normal(Digital) | 3   | 50.00  | 150.00       | 380.00   | 79.80  | 459.80  |
|SAPUKBSPCCN3_2| SD Standard Normal (Digital)           | 1   | 40.00  | 40.00        | 380.00   | 79.80  | 459.80  |

