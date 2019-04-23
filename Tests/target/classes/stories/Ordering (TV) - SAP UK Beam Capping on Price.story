Feature: Billing information on Order Summary Page for Capping on Price for UK (BEAM)
Narrative:
In order to: Validate SAP Integration with A5
As a AgencyAdmin
I want to check billing information on Order Summary

Lifecycle:
Before:
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   | Labels              |
| SAPUKBCOP04 | DefaultA4User | United Kingdom | BMTest04 | production_services |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| SAPUKBCOP04 | agency.admin | SAPUKBCOP04  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SAPUKBCOP04':
| Advertiser  | Brand       | Sub Brand   | Product     |
| SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR |
And logged in with details of 'SAPUKBCOP04'
And 'enable' Billing Service


Scenario: Cappinng on Price  rate card - Add Media via FTP Multiple Clock to Multiple Destination within Market, no subtitles, Standard Service Level, no additional services
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                                                                                                                                                                              |
| automated test info    | SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR | SAPUKBCOPC | SAPUKBCOPCN1_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOPT | None               | ABP News:Standard;Bangla TV:Standard;ARY News:Standard;Global Music TV:Standard;CBS:Standard;Channel Starz:Standard;News 18:Standard;Clubland:Standard;Rishtey UK:Standard;UMP Movies:Standard;Forces TV:Standard;Horse and Country:Standard|
| automated test info    | SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR | SAPUKBCOPC | SAPUKBCOPCN1_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOPT | None               | ABP News:Standard;Bangla TV:Standard;ARY News:Standard;Global Music TV:Standard;CBS:Standard;Channel Starz:Standard;News 18:Standard;Clubland:Standard;Rishtey UK:Standard;UMP Movies:Standard;Forces TV:Standard                           |
And add for 'tv' order to item with clock number 'SAPUKBCOPCN1_1' a New Master with following fields:
| Supply Via | Assignee    | Already Supplied | Message        | Deadline Date |
| FTP        | SAPUKBCOP04 | should not       | automated test | 12/14/2022    |
When I go to Order Proceed page for order contains order item with following clock number 'SAPUKBCOPCN1_1'
Then I should see following Billing data on Order Proceed page:
| Item                                 | QTY | Unit    | TotalPerItem | Subtotal | Tax     | Total   |
| Maximum SD Standard Normal (Digital) | 1   | 400.00 | 400.00      | 800.00  | 168.00 | 968.00 |
| Maximum SD Standard Normal (Digital) | 1   | 400.00 | 400.00      | 800.00  | 168.00 | 968.00 |


Scenario: Cappinng on Price  rate card - Add Media via Nverge, Multiple Clock to Multiple Destination within Market, Adtext subtitles, Adbank,Express/Express Service Level, Data DVD/Tape
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                                                                                                                                                                                                                                                                                                                                                                             |
| automated test info    | SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR | SAPUKBCOPC | SAPUKBCOPCN2_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOPT | Adtext SD          | Aastha:Standard;ABP News:Standard;ARY News:Standard;BSkyB Green Button:Standard;CBS:Standard;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR | SAPUKBCOPC | SAPUKBCOPCN2_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOPT | Adtext SD          | Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express |
And add for 'tv' order to item with clock number 'SAPUKBCOPCN2_1' a New Master with following fields:
| Supply Via | Assignee    | Already Supplied | Message        | Deadline Date |
| nVerge     | SAPUKBCOP04 | should not       | automated test | 12/14/2022    |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     | Market         |
| Physical | SAPUKBCOPDN14    | SAPUKBCOPCnN1 | SAPUKBCOPCD1    | SAPUKBCOPSA1   | SAPUKBCOPC1 | SAPUKBCOPPC1 | SAPUKBCOPC1 | United Kingdom |
And create for 'tv' order with item clock number 'SAPUKBCOPCN2_1' additional services with following fields:
| Type | Destination   | Format | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard | Express    |
| Tape | SAPUKBCOPDN1  | D2     | Same as Master | Compile 1     | 5          | SAPUKBCOPDN1 SAPUKBCOPCnN1 SAPUKBCOPCD1 SAPUKBCOPSA1 SAPUKBCOPC1 SAPUKBCOPPC1 SAPUKBCOPC1 | automated test notes  | should   | should not |
And create for 'tv' order with item clock number 'SAPUKBCOPCN2_2' additional services with following fields:
| Type      | Destination  | Format             | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard   | Express |
| Data DVD  | SAPUKBCOPDN1 | Authored with menu | Same as Master | Compile 1     | 3          | SAPUKBCOPDN1 SAPUKBCOPCnN1 SAPUKBCOPCD1 SAPUKBCOPSA1 SAPUKBCOPC1 SAPUKBCOPPC1 SAPUKBCOPC1 | automated test notes  | should not | should  |
When I go to Order Proceed page for order contains order item with following clock number 'SAPUKBCOPCN2_1'
Then I should see following Billing data on Order Proceed page specific to clocks:
| clock          | Item                                          | QTY | Unit    | TotalPerItem | Subtotal | Tax     | Total    |
| SAPUKBCOPCN2_1 | SD Standard Normal (Digital)                  | 5   | 40.00  | 200.00      | 1,856.00 | 389.76 | 2,245.76 |
| SAPUKBCOPCN2_1 | Maximum SD Express Normal (Digital)           | 1   | 700.00 | 700.00      | 1,856.00 | 389.76 | 2,245.76 |
| SAPUKBCOPCN2_1 | Subtitling: Standard (Adtext)                 | 1   | 41.00  | 41.00       | 1,856.00 | 389.76 | 2,245.76 |
| SAPUKBCOPCN2_1 | Dubbing Service: Tape - Standard Domestic     | 5   | 71.00  | 355.00      | 1,856.00 | 389.76 | 2,245.76 |
| SAPUKBCOPCN2_2 | Subtitling: Standard (Adtext)                 | 1   | 41.00  | 41.00       | 1,856.00 | 389.76 | 2,245.76 |
| SAPUKBCOPCN2_2 | SD Express Normal (Digital)                   | 6   | 70.00  | 420.00      | 1,856.00 | 389.76 | 2,245.76 |
| SAPUKBCOPCN2_2 | Dubbing Service: Data DVD - Express Domestic  | 3   | 33.00  | 99.00       | 1,856.00 | 389.76 | 2,245.76 |


Scenario: Reorder - Cappinng on Price rate card - Add Media via Library, Single Clock to Multiple Destination within Market, Standard Service Level
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                           |
| automated test info    | SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR | SAPUKBCOPC | SAPUKBCOPCN3_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOPT | None               | Aastha:Standard;ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue  |
| Advertiser | SAPUKBCOPAR |
| Brand      | SAPUKBCOPBR |
| Sub Brand  | SAPUKBCOPBR |
| Product    | SAPUKBCOPPR |
| Clock number    | SAPCLK |
And open order item with following clock number 'SAPUKBCOPCN3_1'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax     | Total   |
| SD Standard Normal (Digital) | 5   | 40.00 | 200.00      | 200.00  | 42.00 | 242.00 |
When I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| SAPUKBCOPJN1 | SAPUKBCOPPN1 |
And confirm order on Order Proceed page
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                           |
| automated test info    | SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR | SAPUKBCOPC | SAPUKBCOPCN3_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOPT | None               | Aastha:Standard;ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard |
And I open order item with following clock number 'SAPUKBCOPCN3_2'
And add to order for order item at Add media to your order form following assets 'SAPUKBCOPCN3_1'
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital) | 5   | 40.00 | 200.00      | 200.00  | 42.00 | 242.00 |


Scenario: Reorder - Already reached cap and within Midnight - Cappinng on Price rate card - Add Media via Library, Single Clock to Multiple Destination within Market, Standard Service Level
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I created the following agency:
| Name        | A4User        | Country        | SAP ID   |
| SAPUKBCOQ05 | DefaultA4User | United Kingdom | BMTest05 |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| SAPUKBCOQ05 | agency.admin | SAPUKBCOQ05  |streamlined_library,ordering|
And I uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                                  |
| automated test info    | SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR | SAPUKBCOPC | SAPUKBCOPCN4_1 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOPT | None               | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard;Nepali TV:Standard;NTV Europe:Standard;Sony Entertainment Asia:Standard;Aastha:Standard;Bangla TV:Standard;Channel I:Standard;Channel S:Standard;Deepam TV:Standard;Phoenix CNE:Standard;Playboy:Standard;PTV Prime:Standard;Ummah Channel:Standard;Venus TV:Standard;PTV Global2:Standard;OHTV:Standard;Zee TV:Standard |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue  |
| Advertiser | SAPUKBCOPAR |
| Brand      | SAPUKBCOPBR |
| Sub Brand  | SAPUKBCOPBR |
| Product    | SAPUKBCOPPR |
| Clock number    | SAPCLK1 |
And open order item with following clock number 'SAPUKBCOPCN4_1'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                                 | QTY | Unit    | TotalPerItem | Subtotal  | Tax     | Total   |
| Maximum SD Standard Normal (Digital) | 1   | 400.00 | 400.00      | 400.00   | 84.00 | 484.00 |
When I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| SAPUKBCOPJN1 | SAPUKBCOPPN1 |
And confirm order on Order Proceed page
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                                                                                                                                                                                                                                                                                                                                                                                   |
| automated test info    | SAPUKBCOPAR | SAPUKBCOPBR | SAPUKBCOPBR | SAPUKBCOPPR | SAPUKBCOPC | SAPUKBCOPCN4_2 | 20       | 10/14/2022     | HD 1080i 25fps | SAPUKBCOPT | None               | ABP News:Standard;Akaal TV:Standard;B4U Movies:Standard;MATV:Standard;Nepali TV:Standard;NTV Europe:Standard;Sony Entertainment Asia:Standard;Aastha:Standard;Bangla TV:Standard;Channel I:Standard;Channel S:Standard;Deepam TV:Standard;Phoenix CNE:Standard;Playboy:Standard;PTV Prime:Standard;Ummah Channel:Standard;Venus TV:Standard;PTV Global2:Standard;OHTV:Standard;Zee TV:Standard |
And I open order item with following clock number 'SAPUKBCOPCN4_2'
And add to order for order item at Add media to your order form following assets 'SAPUKBCOPCN4_1'
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                                 | QTY | Unit    | TotalPerItem | Subtotal  | Tax    | Total   |
| Maximum SD Standard Normal (Digital) | 1   | 400.00 | 400.00      | 400.00   | 84.00 | 484.00 |