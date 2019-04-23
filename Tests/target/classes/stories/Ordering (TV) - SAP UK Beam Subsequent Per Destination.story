Feature: Billing information on Order Summary Page for Subsequent Per Destination Price Model for UK (BEAM)
Narrative:
In order to: Validate SAP Integration with A5
As a AgencyAdmin
I want to check billing information on Order Summary

Lifecycle:
Before:
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   |
| SAPUKBSPD07 | DefaultA4User | United Kingdom | BMTest07 |
And created users with following fields:
| Email       | Role         | AgencyUnique     |
| SAPUKBSPD07 | agency.admin | SAPUKBSPD07 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SAPUKBSPD07':
| Advertiser  | Brand       | Sub Brand   | Product     |
| SAPUKBSPDAR | SAPUKBSPDBR | SAPUKBSPDPR | SAPUKBSPDPR |
And logged in with details of 'SAPUKBSPD07'
And 'enable' Billing Service

Scenario: Add Media via Nverge, One Clock to Multiple Destination within Market, no subtitles, Standard Service Level, no additional services, Subsequent per Destn rate card
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                      |
| automated test info    | SAPUKBSPDAR | SAPUKBSPDBR | SAPUKBSPDPR | SAPUKBSPDPR | SAPUKBSPDC | SAPUKBSPDCN1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPDT | None               | Aastha:Standard;ABP News:Standard;ARY News:Standard;CBS:Standard |
And add for 'tv' order to item with clock number 'SAPUKBSPDCN1' a New Master with following fields:
| Supply Via | Assignee    | Already Supplied | Message        | Deadline Date |
| nVerge     | SAPUKBSPD06 | should not       | automated test | 12/14/2022    |
When I go to Order Proceed page for order contains order item with following clock number 'SAPUKBSPDCN1'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock           |destn   |Item                               | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
|                |Aastha  |SD Standard Normal (Digital)       | 1   | 50.00   | 50.00        | 200.00   | 42.00  | 242.00  |
|                |CBS     |SD Standard Normal (Digital)       | 1   | 50.00   | 50.00        | 200.00   | 42.00  | 242.00  |
|                |ABP News|SD Standard Normal (Digital)       | 1   | 50.00   | 50.00        | 200.00   | 42.00  | 242.00  |
|                |Aastha  |SD Standard Normal (Digital)       | 1   | 50.00   | 50.00        | 200.00   | 42.00  | 242.00  |

Scenario: Add Media via Physical Media, Multiple clock to Multiple Destination within Market, no subtitles, Standard/Express Service Level, no additional services, Subsequent per Destn rate card
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                          |
| automated test info    | SAPUKBSPDAR | SAPUKBSPDBR | SAPUKBSPDPR | SAPUKBSPDPR | SAPUKBSPDC | SAPUKBSPDCN2_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPDT | None               | Bangla TV:Standard                   |
| automated test info    | SAPUKBSPDAR | SAPUKBSPDBR | SAPUKBSPDPR | SAPUKBSPDPR | SAPUKBSPDC | SAPUKBSPDCN2_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPDT | None               | ABP News:Express                     |
| automated test info    | SAPUKBSPDAR | SAPUKBSPDBR | SAPUKBSPDPR | SAPUKBSPDPR | SAPUKBSPDC | SAPUKBSPDCN2_3 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPDT | None               | Bangla TV:Standard;Channel I:Express |
When I open order item with following clock number 'SAPUKBSPDCN2_1'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee    | Already Supplied | Message        | Deadline Date |
| SAPUKBSPD07 | should not       | automated test | 12/14/2022    |
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock          |destn         |Item                                   | QTY | Unit   | TotalPerItem | Subtotal | Tax     | Total  |
|               |Bangla TV     |SD Standard Normal (Digital)           | 1   | 50.00  | 50.00        | 240.00  | 50.40    | 290.40 |
|               |Bangla TV     |Subsequent SD Standard Normal(Digital) | 1   | 50.00  | 50.00        | 240.00  | 50.40    | 290.40 |
|SAPUKBSPDCN2_2 |              |SD Express Normal (Digital)            | 1   | 70.00  | 70.00        | 240.00  | 50.40    | 290.40 |
|SAPUKBSPDCN2_3 |              |SD Express Normal (Digital)            | 1   | 70.00  | 70.00        | 240.00  | 50.40    | 290.40 |


Scenario: Add Media via Physical Media, Multiple clock to Multiple Destination within Market with different Advertiser, no subtitles, Standard Service Level, no additional services, Subsequent per Destn rate card
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SAPUKBSPD07':
| Advertiser     | Brand          | Sub Brand      | Product        |
| SAPUKBSPDAR3_2 | SAPUKBSPDBR3_2 | SAPUKBSPDPR3_2 | SAPUKBSPDPR3_2 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser     | Brand          | Sub Brand      | Product        | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                           |
| automated test info    | SAPUKBSPDAR    | SAPUKBSPDBR    | SAPUKBSPDPR    | SAPUKBSPDPR    | SAPUKBSPDC | SAPUKBSPDCN3_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPDT | None               | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard |
| automated test info    | SAPUKBSPDAR3_2 | SAPUKBSPDBR3_2 | SAPUKBSPDPR3_2 | SAPUKBSPDPR3_2 | SAPUKBSPDC | SAPUKBSPDCN3_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPDT | None               | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard |
When I open order item with following clock number 'SAPUKBSPDCN3_1'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee    | Already Supplied | Message        | Deadline Date |
| SAPUKBSPD06 | should not       | automated test | 12/14/2022    |
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock          |  dest          | Item                                            | QTY | Unit   | TotalPerItem  | Subtotal | Tax    | Total   |
|               |  Akaal TV      |Subsequent SD Standard Normal(Digital)           | 1   | 50.00  | 50.00         | 400.00   | 84.00  | 484.00  |
|               |  MATV          |Subsequent SD Standard Normal(Digital)           | 1   | 50.00  | 50.00         | 400.00   | 84.00  | 484.00  |
|               |  ABP News      |SD Standard Normal (Digital)                     | 1   | 50.00  | 50.00         | 400.00   | 84.00  | 484.00  |
|               |  Akaal TV      |SD Standard Normal (Digital)                     | 1   | 50.00  | 50.00         | 400.00   | 84.00  | 484.00  |
|               |  B4U Movies    |Subsequent SD Standard Normal(Digital)           | 1   | 50.00  | 50.00         | 400.00   | 84.00  | 484.00  |
|               |  MATV          |SD Standard Normal (Digital)                     | 1   | 50.00  | 50.00         | 400.00   | 84.00  | 484.00  |
|               |  B4U Movie     |SD Standard Normal (Digital)                     | 1   | 50.00  | 50.00         | 400.00   | 84.00  | 484.00  |
|               |  ABP News      |Subsequent SD Standard Normal(Digital)           | 1   | 50.00  | 50.00         | 400.00   | 84.00  | 484.00  |


Scenario: Add Media via Physical Media, Multiple clock to Multiple Destination within Market,BTI subtitles, AdbankStandard/express Service Level, no additional services, Subsequent per Destn rate card
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I updated the following agency:
| Name        | Save In Library | Allow To Save In Library |
| SAPUKBSPD07 | should          | should                   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser     | Brand          | Sub Brand      | Product        | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                                           |
| automated test info    | SAPUKBSPDAR    | SAPUKBSPDBR    | SAPUKBSPDPR    | SAPUKBSPDPR    | SAPUKBSPDC | SAPUKBSPDCN4_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPDT | BTI Studios        | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Express;Nepali TV:Express;Zee TV:Express |
| automated test info    | SAPUKBSPDAR    | SAPUKBSPDBR    | SAPUKBSPDPR    | SAPUKBSPDPR    | SAPUKBSPDC | SAPUKBSPDCN4_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBSPDT | BTI Studios        | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;Zee TV:Express                                |
When I open order item with following clock number 'SAPUKBSPDCN4_1'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee    | Already Supplied | Message        | Deadline Date |
| SAPUKBSPD06 | should not       | automated test | 12/14/2022    |
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock           |dest         |Item                                               | QTY | Unit     | TotalPerItem | Subtotal    | Tax     | Total     |
|SAPUKBSPDCN4_1  |             | Adbank - Standard                                 | 1   | 150.00   | 150.00       | 964.00      | 202.44  | 1,166.44  |
|                |ABP News     | SD Standard Normal (Digital)                      | 1   |  50.00   | 50.00        | 964.00      | 202.44  | 1,166.44  |
|SAPUKBSPDCN4_1  |             | Subsequent Subtitling: Standard (BTI Studios)     | 1   |  42.00   | 42.00        | 964.00      | 202.44  | 1,166.44  |
|                |Akaal TV     |SD Standard Normal (Digital)                       | 1   |  50.00   | 50.00        | 964.00      | 202.44  | 1,166.44  |
|                |Akaal TV     | Subsequent SD Standard Normal(Digital             | 1   |  50.00   | 50.00        | 964.00      | 202.44  | 1,166.44  |
|SAPUKBSPDCN4_2  |             |Subsequent Subtitling: Standard (BTI Studios)      | 1   |  42.00   | 42.00        | 964.00      | 202.44  | 1,166.44  |
|                | B4U Movies  |SD Standard Normal (Digital)                       | 1   |  50.00   | 50.00        | 964.00      | 202.44  | 1,166.44  |
|                | B4U Movies  | Subsequent SD Standard Normal(Digital)            | 1   |  50.00   | 50.00        | 964.00      | 202.44  | 1,166.44  |
|SAPUKBSPDCN4_2  |             |Adbank - Standard                                  | 1   |  150.00  | 150.00       | 964.00      | 202.44  | 1,166.44  |
|                |ABP News     | Subsequent SD Standard Normal(Digital)            | 1   |  50.00   | 50.00        | 964.00      | 202.44  | 1,166.44  |
|SAPUKBSPDCN4_1  |             |SD Express Normal (Digital)                        | 3   |  70.00   | 210.00       | 964.00      | 202.44  | 1,166.44  |
|SAPUKBSPDCN4_2  |             |SD Express Normal (Digital)                        | 1   |  70.00   | 70.00        | 964.00      | 202.44  | 1,166.44  |


