Feature: Billing information on Order Summary Page for Capping on Quantity for UK (BEAM) a
Narrative:
In order to: Validate SAP Integration with A5
As a AgencyAdmin
I want to check billing information on Order Summary

Lifecycle:
Before:
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   | Labels              |
| SAPUKBCOQ03 | DefaultA4User | United Kingdom | BMTest03 | production_services |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| SAPUKBCOQ03 | agency.admin | SAPUKBCOQ03  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SAPUKBCOQ03':
| Advertiser  | Brand       | Sub Brand   | Product     |
| SAPUKBCOQAR | SAPUKBCOQBR | SAPUKBCOQBR | SAPUKBCOQPR |
And logged in with details of 'SAPUKBCOQ03'
And 'enable' Billing Service


Scenario: Add Media via FTP Multiple Clock to Multiple Destination within Market, no subtitles, Standard Service Level, no additional services,Cappinng on Quantity rate card
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                                                                                                                                                                                                                                                         |
| automated test info    | SAPUKBCOQAR | SAPUKBCOQBR | SAPUKBCOQBR | SAPUKBCOQPR | SAPUKBCOQC | SAPUKBCOQCN1_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOQT | None               | SAB:Standard;ABP News:Standard;ARY News:Standard;Channel 5:Standard;CBS:Standard;Channel Starz:Standard;News 18:Standard;Clubland:Standard;Discovery UK:Standard;E! Entertainment:Standard;Forces TV:Standard;GEO News:Standard;Global Music TV:Standard;Horse and Country:Standard;Lamhe/Zing:Standard |
| automated test info    | SAPUKBCOQAR | SAPUKBCOQBR | SAPUKBCOQBR | SAPUKBCOQPR | SAPUKBCOQC | SAPUKBCOQCN1_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOQT | None               | SAB:Standard;ABP News:Standard;ARY News:Standard;Channel 5:Standard;CBS:Standard;Channel Starz:Standard;News 18:Standard;Clubland:Standard;Discovery UK:Standard;E! Entertainment:Standard;Forces TV:Standard;GEO News:Standard;Global Music TV:Standard;Horse and Country:Standard;Lamhe/Zing:Standard |
And add for 'tv' order to item with clock number 'SAPUKBCOQCN1_1' a New Master with following fields:
| Supply Via | Assignee         | Already Supplied | Message        | Deadline Date |
| FTP        | SAPUKBCOQ03 | should not       | automated test | 12/14/2022    |
When I go to Order Proceed page for order contains order item with following clock number 'SAPUKBCOQCN1_1'
Then I should see following Billing data on Order Proceed page:
| Item                                 | QTY | Unit    | TotalPerItem | Subtotal | Tax     | Total   |
| Maximum SD Standard Normal (Digital) | 1   | 400.00 | 400.00      | 800.00  | 168.00 | 968.00 |
| Maximum SD Standard Normal (Digital) | 1   | 400.00 | 400.00      | 800.00  | 168.00 | 968.00 |


Scenario: Reorder - Cappinng on Quantity rate card - Add Media via Library with Single Clock to Multiple Destination within Market,Standard Service Level
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                             |
| automated test info    | SAPUKBCOQAR | SAPUKBCOQBR | SAPUKBCOQBR | SAPUKBCOQPR | SAPUKBCOQC | SAPUKBCOQCN3_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOQT | None               | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard;Nepali TV:Standard |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue  |
| Advertiser | SAPUKBCOQAR |
| Brand      | SAPUKBCOQBR |
| Sub Brand  | SAPUKBCOQBR |
| Clock number    | SAPUKBCOQCN3_1 |
And open order item with following clock number 'SAPUKBCOQCN3_1'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax     | Total   |
| SD Standard Normal (Digital) | 5   | 40.00 | 200.00      | 200.00   | 42.00 | 242.00 |
When I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| SAPUKBCOQJN1 | SAPUKBCOQPN1 |
And confirm order on Order Proceed page
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                              |
| automated test info    | SAPUKBCOQAR | SAPUKBCOQBR | SAPUKBCOQBR | SAPUKBCOQPR | SAPUKBCOQC | SAPUKBCOQCN3_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOQT | None               | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard;Nepali TV:Standard |
And I open order item with following clock number 'SAPUKBCOQCN3_2'
And add to order for order item at Add media to your order form following assets 'SAPUKBCOQCN3_1'
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital) | 5   | 40.00 | 200.00      | 200.00  | 42.00 | 242.00 |


Scenario: Add Media via Nverge, One Clock to Multiple Destination within Market, no subtitles, Standard Service Level, no additional services,Cappinng on Quantity rate card
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   |
| SAPUKBCOQ01 | DefaultA4User | United Kingdom | BMTest01 |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| SAPUKBCOQ01 | agency.admin | SAPUKBCOQ01  |
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SAPUKBCOQ01':
| Advertiser   | Brand        | Sub Brand    | Product      |
| SAPUKBCOQAR1 | SAPUKBCOQBR1 | SAPUKBCOQBR1 | SAPUKBCOQPR1 |
And logged in with details of 'SAPUKBCOQ01'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product      | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                                                                 |
| automated test info    | SAPUKBCOQAR1 | SAPUKBCOQBR1 | SAPUKBCOQBR1 | SAPUKBCOQPR1 | SAPUKBCOQC | SAPUKBCOQCN1_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOQT | None               | Akaal TV:Standard;ABP News:Standard;ARY News:Standard;Nepali TV:Standard;CBS:Standard;Channel Starz:Standard;News 18:Standard |
And add for 'tv' order to item with clock number 'SAPUKBCOQCN1_1' a New Master with following fields:
| Supply Via | Assignee         | Already Supplied | Message        | Deadline Date |
| FTP        | SAPUKBCOQ01 | should not       | automated test | 12/14/2022    |
When I go to Order Proceed page for order contains order item with following clock number 'SAPUKBCOQCN1_1'
Then I should see following Billing data on Order Proceed page:
| Item                                 | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| Maximum SD Standard Normal (Digital) | 1   | 400.00 | 400.00      | 400.00  | 84.00 | 484.00 |


Scenario: Add Media via Nverge, Multiple Clock to Multiple Destination within Market, Adtext subtitles, Adbank,Standard/Express Service Level, Data DVD/Tape,Cappinng on Quantity rate card
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I updated the following agency:
| Name        | Save In Library | Allow To Save In Library |
| SAPUKBCOQ03 | should          | should                   |
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                                                                                                                                                                                                                                                                                                                                                                             |
| automated test info    | SAPUKBCOQAR | SAPUKBCOQBR | SAPUKBCOQBR | SAPUKBCOQPR | SAPUKBCOQC | SAPUKBCOQCN2_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOQT | Adtext SD          | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard;Nepali TV:Standard;NTV Europe:Express;Sony Entertainment Asia:Express;Aastha:Express;Bangla TV:Express;Channel I:Express;Channel S:Express;Deepam TV:Express;Phoenix CNE:Express;Playboy:Express;PTV Prime:Express;Ummah Channel:Express;Venus TV:Express;PTV Global2:Express;OHTV:Express;Zee TV:Express |
| automated test info    | SAPUKBCOQAR | SAPUKBCOQBR | SAPUKBCOQBR | SAPUKBCOQPR | SAPUKBCOQC | SAPUKBCOQCN2_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOQT | Adtext SD          | ABP News:Express;Akaal TV:Express;B4U Movies:Express;MATV:Express;Nepali TV:Express                                                                                                                                                                                                                                                                                            |
And add for 'tv' order to item with clock number 'SAPUKBCOQCN2_1' a New Master with following fields:
| Supply Via | Assignee    | Already Supplied | Message        | Deadline Date |
| nVerge     | SAPUKBCOQ03 | should not       | automated test | 12/14/2022    |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address  | City        | Post Code    | Country     |  Market        |
| Physical | SAPUKBCOQDN1     | SAPUKBCOQCnN1 | SAPUKBCOQCD1    | SAPUKBCOQSA1    | SAPUKBCOQC1 | SAPUKBCOQPC1 | SAPUKBCOQC1 | United Kingdom |
And create for 'tv' order with item clock number 'SAPUKBCOQCN2_1' additional services with following fields:
| Type | Destination   | Format | Specification  | Media Compile | No copies  | Delivery Details                                                                           | Notes & Labels        | Standard | Express    |
| Tape | SAPUKBCOQDN1  | D2     | Same as Master | Compile 1     | 5          | SAPUKBCOQDN13 SAPUKBCOQCnN1 SAPUKBCOQCD1 SAPUKBCOQSA1 SAPUKBCOQC1 SAPUKBCOQPC1 SAPUKBCOQC1 | automated test notes  | should   | should not |
And create for 'tv' order with item clock number 'SAPUKBCOQCN2_2' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                           | Notes & Labels        | Standard   | Express |
| Data DVD | SAPUKBCOQDN1 | Avid DNxHD | Same as Master | Compile 1     | 3          | SAPUKBCOQDN13 SAPUKBCOQCnN1 SAPUKBCOQCD1 SAPUKBCOQSA1 SAPUKBCOQC1 SAPUKBCOQPC1 SAPUKBCOQC1 | automated test notes  | should not | should  |
When I open order item with following clock number 'SAPUKBCOQCN2_1'
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock          | Item                                          | QTY | Unit    | TotalPerItem | Subtotal | Tax     | Total     |
|SAPUKBCOQCN2_1 | SD Standard Normal (Digital)                  | 5   | 40.00  | 200.00      | 2,086.00 | 438.06 | 2,524.06 |
|SAPUKBCOQCN2_1 | Maximum SD Express Normal (Digital)           | 1   | 700.00 | 700.00      | 2,086.00 | 438.06 | 2,524.06 |
|SAPUKBCOQCN2_1 | Subtitling: Standard (Adtext)                 | 1   | 41.00  | 41.00       | 2,086.00 | 438.06 | 2,524.06 |
|SAPUKBCOQCN2_1 | Dubbing Service: Tape - Standard Domestic     | 5   | 71.00  | 355.00      | 2,086.00 | 438.06 | 2,524.06 |
|SAPUKBCOQCN2_1 | Adbank - Standard                             | 1   | 150.00 | 150.00      | 2,086.00 | 438.06 | 2,524.06 |
|SAPUKBCOQCN2_2 | SD Express Normal (Digital)                   | 5   | 70.00  | 350.00      | 2,086.00 | 438.06 | 2,524.06 |
|SAPUKBCOQCN2_2 | Dubbing Service: Data DVD - Express Domestic  | 3   | 33.00  | 99.00       | 2,086.00 | 438.06 | 2,524.06 |
|SAPUKBCOQCN2_2 | Subtitling: Standard (Adtext)                 | 1   | 41.00  | 41.00       | 2,086.00 | 438.06 | 2,524.06 |
|SAPUKBCOQCN2_2 | Adbank - Standard                             | 1   | 150.00 | 150.00      | 2,086.00 | 438.06 | 2,524.06 |