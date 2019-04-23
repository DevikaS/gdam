Feature: Billing information on Order Summary Page for Standard Price Model for UK (BEAM)
Narrative:
In order to: Validate SAP Integration with A5
As a AgencyAdmin
I want to check billing information on Order Summary

Lifecycle:
Before:
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID   | Labels              |
| SPMUK02 | DefaultA4User | United Kingdom | BMTest02 | production_services |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| SPMUK02 | agency.admin | SPMUK02      |streamlined_library,ordering,folders,dashboard|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SPMUK02':
| Advertiser | Brand   | Sub Brand | Product |
| SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR |
And logged in with details of 'SPMUK02'
And 'enable' Billing Service


Scenario: Add Media via FTP, One Clock to more than one Destination within Market, no subtitles,Standard Service Level, no additional services, standard rate card
Meta: @ordering
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN1_1   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT  | None               | Aastha:Standard;ABP News:Standard;ARY News:Standard;BSkyB Green Button:Standard;CBS:Standard;Channel Starz:Standard;News 18:Standard;Clubland:Standard;Discovery UK:Standard;E! Entertainment:Standard;Forces TV:Standard;GEO News:Standard;Global Music TV:Standard;Horse and Country:Standard;Lamhe/Zing:Standard;MTV/Viva/VH1/Nickelodeon/BET:Standard;UMP Movies:Standard;Rishtey UK:Standard;SAB:Standard;Sony Movies Channel/Movies4Men:Standard |
And add for 'tv' order to item with clock number 'SPMUKCN1_1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | SPMUK02  | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'SPMUKCN1_1'
And click active Proceed button on order item page
And wait for '5' seconds
And 'confirm' and 'accept' reading BSkyB confirmation popup on order item page if pop-up is visible
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax     | Total   |
| SD Standard Normal (Digital) | 20  | 40.00 | 800.00      | 800.00  | 168.00 | 968.00 |


Scenario: Add Media via Projects, One Clock to Multiple Destination Outside Market(Ireland), no subtitles, Standard Service Level, no additional services, standard rate card
Meta: @ordering
Given I created 'SPMUKP1' project
And created '/SPMUKF1' folder for project 'SPMUKP1'
And uploaded into project 'SPMUKP1' following files:
| FileName             | Path     |
| /files/Fish1-Ad.mov  | /SPMUKF1 |
And waited while transcoding is finished in folder '/SPMUKF1' on project 'SPMUKP1' files page
And I create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                                                                       |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN9     | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | TG4:Standard;Irish TV:Standard;Discovery Ireland:Standard;RTE:Standard;Universal Ireland:Standard |
And add to 'tv' order item with clock number 'SPMUKCN9' following file '/files/Fish1-Ad.mov' from folder '/SPMUKF1' of project 'SPMUKP1'
When I go to Order Proceed page for order contains order item with following clock number 'SPMUKCN9'
Then I should see following Billing data on Order Proceed page:
| Item                                          | QTY | Unit    | TotalPerItem | Subtotal | Tax   | Total  |
| SD International Standard Normal (Digital) IE | 5   | 150.00  | 750.00       | 750.00  | 157.50 | 907.50 |


Scenario: Add Media via Nverge, More than One Clock to more than one Destination within Market, no subtitles, Express Service Level, no additional services, standard rate card
Meta: @ordering
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                                                                                                                                                                                                                                                                                                                                                                                                        |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_1   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_2   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_3   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_4   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_5   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_6   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_7   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_8   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_9   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN2_10  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
And add for 'tv' order to item with clock number 'SPMUKCN2_1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | SPMUK02  | should not       | automated test | 12/14/2022    |
When I open order item with following clock number 'SPMUKCN2_1'
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
And wait for '5' seconds
And 'confirm' and 'accept' reading BSkyB confirmation popup on order item page if pop-up is visible
Then I should see following Billing data on Order Proceed page:
| Item                        | QTY | Unit   | TotalPerItem | Subtotal   | Tax       | Total      |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |
| SD Express Normal (Digital) | 20  | 70.00 | 1,400.00    | 14,000.00 | 2,940.00 | 16,940.00 |


Scenario: Add Media via Physical Media, More than One Clock to One Destination within Market, with Adtext subtitles, Express Service Level, no additional services, standard rate card
Meta: @ordering
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination    |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_1    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_2    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_3    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_4    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_5    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_6    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_7    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_8    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_9    | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN3_10   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Express |
When I open order item with following clock number 'SPMUKCN3_1'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| SPMUK02  | should not       | automated test | 12/14/2022    |
And copy data from 'Add media' section of order item page to all other items
And click Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                          | QTY | Unit   | TotalPerItem | Subtotal   | Tax     | Total     |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |
| SD Express Normal (Digital)   | 1   | 70.00 | 70.00       | 1,110.00  | 233.10 | 1,343.10 |
| Subtitling - Adtext SD        | 1   | 41.00 | 41.00       | 1,110.00  | 233.10 | 1,343.10 |



Scenario: Add Media via FTP, One Clock to more than one Destination within Market, with IMS subtitles, Express Service Level, no additional services, standard rate card
Meta: @ordering
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                                                                                                                                                                                                                                                                                                                                                                                                        |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKSB   | SPMUKPR | SPMUKC   | SPMUKCN4     | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | BTI Studios        | Aastha:Express;ABP News:Express;ARY News:Express;BSkyB Green Button:Express;CBS:Express;Channel Starz:Express;News 18:Express;Clubland:Express;Discovery UK:Express;E! Entertainment:Express;Forces TV:Express;GEO News:Express;Global Music TV:Express;Horse and Country:Express;Lamhe/Zing:Express;MTV/Viva/VH1/Nickelodeon/BET:Express;UMP Movies:Express;Rishtey UK:Express;SAB:Express;Sony Movies Channel/Movies4Men:Express |
And add for 'tv' order to item with clock number 'SPMUKCN4' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | SPMUK02  | should not       | automated test | 12/14/2022    |
When I go to Order Proceed page for order contains order item with following clock number 'SPMUKCN4'
Then I should see following Billing data on Order Proceed page:
| Item                               | QTY | Unit   | TotalPerItem | Subtotal  | Tax     | Total    |
| SD Express Normal (Digital)        | 20  | 70.00  | 1,400.00     | 1,442.00  | 302.82  | 1,744.82 |
| Subtitling - IMS                   | 1   | 42.00  | 42.00        | 1,442.00  | 302.82  | 1,744.82 |



Scenario: Add Media via Library and Physical Media Multiple Clock to Multiple Destination within Market,IMS/Adtext subtitles,Adbank,Standard/Express Service Level, standard rate card
Meta: @ordering
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                                                                                        |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN7_1   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Standard;ABP News:Standard;ARY News:Standard;BSkyB Green Button:Standard;CBS:Standard;Channel Starz:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN7_2   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | BTI Studios        | Aastha:Standard;ABP News:Standard;ARY News:Express;BSkyB Green Button:Express;Channel Starz:Express                |
When I open order item with following clock number 'SPMUKCN7_2'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| SPMUK02  | should not       | automated test | 12/14/2022    |
And I upload following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
And I go to the Library page for collection 'My Assets'NEWLIB
And wait while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And I open order item with following clock number 'SPMUKCN7_1'
And add to order for order item at Add media to your order form following assets 'Fish Ad.mov'
And wait for '5' seconds
And click active Proceed button on order item page
And wait for '5' seconds
And 'confirm' and 'accept' reading BSkyB confirmation popup on order item page if pop-up is visible
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock      | Item                               | QTY | Unit   | TotalPerItem | Subtotal | Tax     | Total   |
|SPMUKCN7_1 | SD Standard Normal (Digital)       | 5   | 40.00 | 200.00      | 643.00  | 135.03 | 778.03 |
|SPMUKCN7_1 | SD Express Normal (Digital)        | 1   | 70.00 | 70.00       | 643.00  | 135.03 | 778.03 |
|SPMUKCN7_1 | Subtitling - Adtext SD             | 1   | 41.00 | 41.00       | 643.00  | 135.03 | 778.03 |
|SPMUKCN7_2 | SD Standard Normal (Digital)       | 2   | 40.00 | 80.00       | 643.00  | 135.03 | 778.03 |
|SPMUKCN7_2 | SD Express Normal (Digital)        | 3   | 70.00 | 210.00      | 643.00  | 135.03 | 778.03 |
|SPMUKCN7_2 | Subtitling - IMS                   | 1   | 42.00 | 42.00       | 643.00  | 135.03 | 778.03 |


Scenario: Add Media via FTP, Single Clock to Multiple Destination outside Market, Standard, standard rate card
Meta: @ordering
Given I create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                                                                 |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN8     | 20       | 10/14/2022     | SD PAL 16x9    | SPMUKT | None               | Armor TV:Standard;Bip TV:Standard;BDM TV:Standard;Berbere TV:Standard;AfricaBox TV:Standard |
And add for 'tv' order to item with clock number 'SPMUKCN8' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | SPMUK02  | should not       | automated test | 12/14/2022    |
When I go to Order Proceed page for order contains order item with following clock number 'SPMUKCN8'
Then I should see following Billing data on Order Proceed page:
| Item                                          | QTY | Unit     | TotalPerItem   | Subtotal    | Tax     | Total     |
| SD International Standard Normal (Digital) FR | 5   | 150.00   | 750.00         | 750.00      | 157.50  | 907.50    |


Scenario: Add Media via FTP, Multiple Clock,no subtitles, Express/Standard Service Level,Multiple Data DVD Destination, standard rate card
Meta: @ordering
!--NIR-1194 SAPserviceID chnaged for HD Format
!--NGN-19470 ---Added enable QC & Ingest step and edited the Billing data
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN11_1  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN11_2  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
And add for 'tv' order to item with clock number 'SPMUKCN11_1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | SPMUK02  | should not       | automated test | 12/14/2022    |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City      | Post Code  | Country   |  Market        |
| Physical | SPMUKDN1         | SPMUKCnN1_1  | SPMUKCD1_1      | SPMUKSA1_1     | SPMUKC1_1 | SPMUKPC1_1 | SPMUKC1_1 | United Kingdom |
And create for 'tv' order with item clock number 'SPMUKCN11_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | SPMUKDN1     | Avid DNxHD | Same as Master | Compile 1     | 5          | SPMUKDN1 SPMUKCnN1_1 SPMUKCD1_1 SPMUKSA1_1 SPMUKC1_1 SPMUKPC1_1 SPMUKC1_1 | automated test notes  | should     | should not |
And create for 'tv' order with item clock number 'SPMUKCN11_2' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                          | Notes & Labels        | Standard   | Express |
| Data DVD | SPMUKDN1     | Avid DNxHD | Same as Master | Compile 1     | 3          | SPMUKDN1 SPMUKCnN1_1 SPMUKCD1_1 SPMUKSA1_1 SPMUKC1_1 SPMUKPC1_1 SPMUKC1_1 | automated test notes  | should not | should  |
And enable QC & Ingest Only for 'tv' order for item with following clock numbers 'SPMUKCN11_1,SPMUKCN11_2'
When I open order item with following clock number 'SPMUKCN11_1'
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                                          | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total |
|QC & Ingest Fee                                | 1   | 200.00  | 200.00       | 654.00  | 137.34 | 791.34 |
|QC & Ingest Fee                                | 1   | 200.00  | 200.00       | 654.00  | 137.34 | 791.34 |
| Dubbing Service: Data DVD - Standard Domestic | 5   | 31.00  | 155.00        | 654.00  | 137.34 | 791.34 |
| Dubbing Service: Data DVD - Express Domestic  | 3   | 33.00  | 99.00         | 654.00  | 137.34 | 791.34 |



Scenario: Add Media via Nverge, Multiple Clock,no subtitles, Standard/Express Service Level,Multiple Tape/DVD/Generic Upload Destination, standard rate card
Meta: @ordering
!--NIR-1194 SAPServiceID is changed for HD specific format
!--NGN-19470 ---Added enable QC & Ingest step and edited the Billing data
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN12_1  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN12_2  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN12_3  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
And add for 'tv' order to item with clock number 'SPMUKCN12_1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | SPMUK02  | should not       | automated test | 12/14/2022    |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | SPMUKDN12         | SPMUKCnN12_1 | SPMUKCD12_1     | SPMUKSA12_1    | SPMUKC12_1 | SPMUKPC12_1 | SPMUKC12_1 | United Kingdom |
And create additional destinations with following fields:
| Type     | Email             |
| Generics | Generics_email_12 |
And create for 'tv' order with item clock number 'SPMUKCN12_1' additional services with following fields:
| Type | Destination  | Format             | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels        | Standard   | Express |
| DVD  | SPMUKDN12    | Authored with menu | Same as Master | Compile 1     | 3          | SPMUKDN12 SPMUKCnN12_1 SPMUKCD12_1 SPMUKSA12_1 SPMUKC12_1 SPMUKPC12_1 SPMUKC12_1 | automated test notes  | should not | should  |
And create for 'tv' order with item clock number 'SPMUKCN12_2' additional services with following fields:
| Type | Destination  | Format             | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels        | Standard | Express    |
| Tape | SPMUKDN12    | D2                 | Same as Master | Compile 1     | 5          | SPMUKDN12 SPMUKCnN12_1 SPMUKCD12_1 SPMUKSA12_1 SPMUKC12_1 SPMUKPC12_1 SPMUKC12_1 | automated test notes  | should   | should not |
| DVD  | SPMUKDN12    | Authored with menu | Same as Master | Compile 1     | 3          | SPMUKDN12 SPMUKCnN12_1 SPMUKCD12_1 SPMUKSA12_1 SPMUKC12_1 SPMUKPC12_1 SPMUKC12_1 | automated test notes  | should   | should not |
And create for 'tv' order with item clock number 'SPMUKCN12_3' additional services with following fields:
| Type            | Destination       | Format         | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels       | Standard   | Express    |
| Tape            | SPMUKDN12         | D2             | Same as Master | Compile 1     | 5          | SPMUKDN12 SPMUKCnN12_1 SPMUKCD12_1 SPMUKSA12_1 SPMUKC12_1 SPMUKPC12_1 SPMUKC12_1 | automated test notes | should     | should not |
| Generics Upload | Generics_email_12 | Master Toolkit | As required    | Compile 1     | 1          | Generics_email_12                                                                | automated test notes | should not | should     |
And enable QC & Ingest Only for 'tv' order for item with following clock numbers 'SPMUKCN12_1,SPMUKCN12_2,SPMUKCN12_3'
When I open order item with following clock number 'SPMUKCN12_1'
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                                               | QTY | Unit    | TotalPerItem | Subtotal  | Tax     | Total|
|QC & Ingest Fee                                     | 1   | 200.00  | 200.00     | 1,645.00 |345.45|  1,990.45  |
|QC & Ingest Fee                                     | 1   | 200.00  | 200.00     | 1,645.00 |345.45|  1,990.45  |
|QC & Ingest Fee                                     | 1   | 200.00  | 200.00     | 1,645.00 |345.45|  1,990.45  |
| Dubbing Service: DVD - Express Domestic            | 3   | 43.00  | 129.00      | 1,645.00 |345.45|  1,990.45  |
| Dubbing Service: Tape - Standard Domestic          | 5   | 71.00  | 355.00      | 1,645.00 |345.45|  1,990.45  |
| Dubbing Service: DVD - Standard Domestic           | 3   | 41.00  | 123.00      | 1,645.00 |345.45|  1,990.45  |
| Dubbing Service: Tape - Standard Domestic          | 5   | 71.00  | 355.00      | 1,645.00 |345.45|  1,990.45  |
| Dubbing Service: Generics Upload - Express Domesti | 1   | 83.00  | 83.00       | 1,645.00 |345.45|  1,990.45  |


Scenario: Add Media via Nverge, Multiple Clock,no subtitles, Standard/Express Service Level,Multiple Tape/DVD/Generic Upload Destination,Conversion HD<>SD,Conversion PAL<>NTSC,Reslate SD,Reslate HD,Tagging SD,Tagging HD, standard rate card
Meta: @ordering
!--NIR-1194 SAPServiceID is changed for HD specific format
!--NGN-19470 ---Added enable QC & Ingest step and edited the Billing data
Given I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN13_1  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN13_2  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN13_3  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
And add for 'tv' order to item with clock number 'SPMUKCN13_1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | SPMUK02  | should not       | automated test | 12/14/2022    |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | SPMUKDN13        | SPMUKCnN13_1 | SPMUKCD13_1     | SPMUKSA13_1    | SPMUKC13_1 | SPMUKPC13_1 | SPMUKC13_1 | United Kingdom |
And create additional destinations with following fields:
| Type     | Email            |
| Generics | Generics_email_1 |
And create for 'tv' order with item clock number 'SPMUKCN13_1' additional services with following fields:
| Type | Destination  | Format             | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels        | Standard   | Express |
| DVD  | SPMUKDN13    | Authored with menu | Same as Master | Compile 1     | 3          | SPMUKDN13 SPMUKCnN13_1 SPMUKCD13_1 SPMUKSA13_1 SPMUKC13_1 SPMUKPC13_1 SPMUKC13_1 | automated test notes  | should not | should  |
And create for 'tv' order with item clock number 'SPMUKCN13_1' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
| Reslate SD | automated test notes |
And create for 'tv' order with item clock number 'SPMUKCN13_2' additional services with following fields:
| Type | Destination  | Format             | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels        | Standard | Express    |
| Tape | SPMUKDN13    | D2                 | Same as Master | Compile 1     | 5          | SPMUKDN13 SPMUKCnN13_1 SPMUKCD13_1 SPMUKSA13_1 SPMUKC13_1 SPMUKPC13_1 SPMUKC13_1 | automated test notes  | should   | should not |
| DVD  | SPMUKDN13    | Authored with menu | Same as Master | Compile 1     | 3          | SPMUKDN13 SPMUKCnN13_1 SPMUKCD13_1 SPMUKSA13_1 SPMUKC13_1 SPMUKPC13_1 SPMUKC13_1 | automated test notes  | should   | should not |
And create for 'tv' order with item clock number 'SPMUKCN13_2' production additional services with following fields:
| Type       | Notes                |
| Tagging HD | automated test notes |
| Reslate HD | automated test notes |
And create for 'tv' order with item clock number 'SPMUKCN13_3' additional services with following fields:
| Type            | Destination       | Format         | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels       | Standard   | Express    |
| Tape            | SPMUKDN13         | D2             | Same as Master | Compile 1     | 5          | SPMUKDN13 SPMUKCnN13_1 SPMUKCD13_1 SPMUKSA13_1 SPMUKC13_1 SPMUKPC13_1 SPMUKC13_1 | automated test notes | should     | should not |
| Generics Upload | Generics_email_13 | Master Toolkit | As required    | Compile 1     | 1          | Generics_email_13                                                                | automated test notes | should not | should     |
And create for 'tv' order with item clock number 'SPMUKCN13_3' production additional services with following fields:
| Type                 | Notes                |
| Tagging HD           | automated test notes |
| Conversion HD<>SD    | automated test notes |
| Conversion PAL<>NTSC | automated test notes |
And enable QC & Ingest Only for 'tv' order for item with following clock numbers 'SPMUKCN13_1,SPMUKCN13_2,SPMUKCN13_3'
When I open order item with following clock number 'SPMUKCN13_1'
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                                               | QTY | Unit    | TotalPerItem | Subtotal  | Tax     | Total|
| QC & Ingest Fee                                    | 1   | 200.00 | 200.00      |2,457.00| 515.97| 2,972.97 |
| QC & Ingest Fee                                    | 1   | 200.00 | 200.00      |2,457.00| 515.97| 2,972.97 |
| QC & Ingest Fee                                    | 1   | 200.00 | 200.00      |2,457.00| 515.97| 2,972.97 |
| Production service: Reslate SD                     | 1   | 116.00 | 116.00      |2,457.00| 515.97| 2,972.97 |
| Production - Tagging - UpTo 60HD                     | 1   | 119.00 | 119.00      |2,457.00| 515.97| 2,972.97 |
| Production service: Reslate HD                     | 1   | 117.00 | 117.00      |2,457.00| 515.97| 2,972.97 |
| Production - Tagging - UpTo 60HD                     | 1   | 119.00 | 119.00      |2,457.00| 515.97| 2,972.97 |
| Production - Tagging - UpTo 60SD                     | 1   | 118.00 | 118.00      |2,457.00| 515.97| 2,972.97 |
| Dubbing Service: DVD - Express Domestic            | 3   | 43.00  | 129.00      |2,457.00| 515.97| 2,972.97 |
| Dubbing Service: Tape - Standard Domestic          | 5   | 71.00  | 355.00      |2,457.00| 515.97| 2,972.97 |
| Dubbing Service: DVD - Standard Domestic           | 3   | 41.00  | 123.00      |2,457.00| 515.97| 2,972.97 |
| Dubbing Service: Tape - Standard Domestic          | 5   | 71.00  | 355.00      |2,457.00| 515.97| 2,972.97 |
| Dubbing Service: Generics Upload - Express Domesti | 1   | 83.00  | 83.00       |2,457.00| 515.97| 2,972.97 |
| Production service: Conversion PAL<>NTSC           | 1   | 112.00 | 112.00      |2,457.00| 515.97| 2,972.97 |
| Production service: Conversion HD<>SD              | 1   | 111.00 | 111.00      |2,457.00| 515.97| 2,972.97 |


Scenario: Add Media via Nverge, Multiple Clock,no subtitles, In France market, with Standard/Express Service Level,Multiple Tape/DVD/Generic Upload Destination,Conversion HD<>SD,Conversion PAL<>NTSC,Reslate SD,Reslate HD,Tagging SD,Tagging HD, standard rate card
Meta: @ordering
!--NGN-19470 ---Added enable QC & Ingest step and edited the Billing data
!--NIR-1194 SAPServiceID is changed for HD specific format
Given I create 'tv' order with market 'France' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN14_1  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN14_2  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN14_3  | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | None               |
And add for 'tv' order to item with clock number 'SPMUKCN14_1' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge     | SPMUK02  | should not       | automated test | 12/14/2022    |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    | Market |
| Physical | SPMUKDN14        | SPMUKCnN14_1 | SPMUKCD14_1     | SPMUKSA14_1    | SPMUKC14_1 | SPMUKPC14_1 | SPMUKC14_1 | France |
And create additional destinations with following fields:
| Type     | Email             |
| Generics | Generics_email_14 |
And create for 'tv' order with item clock number 'SPMUKCN14_1' additional services with following fields:
| Type | Destination  | Format             | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels        | Standard   | Express |
| DVD  | SPMUKDN14    | Authored with menu | Same as Master | Compile 1     | 3          | SPMUKDN14 SPMUKCnN14_1 SPMUKCD14_1 SPMUKSA14_1 SPMUKC14_1 SPMUKPC14_1 SPMUKC14_1 | automated test notes  | should not | should  |
And create for 'tv' order with item clock number 'SPMUKCN14_1' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
| Reslate SD | automated test notes |
And create for 'tv' order with item clock number 'SPMUKCN14_2' additional services with following fields:
| Type | Destination  | Format             | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels        | Standard | Express    |
| Tape | SPMUKDN14    | D2                 | Same as Master | Compile 1     | 5          | SPMUKDN14 SPMUKCnN14_1 SPMUKCD14_1 SPMUKSA14_1 SPMUKC14_1 SPMUKPC14_1 SPMUKC14_1 | automated test notes  | should   | should not |
| DVD  | SPMUKDN14    | Authored with menu | Same as Master | Compile 1     | 3          | SPMUKDN14 SPMUKCnN14_1 SPMUKCD14_1 SPMUKSA14_1 SPMUKC14_1 SPMUKPC14_1 SPMUKC14_1 | automated test notes  | should   | should not |
And create for 'tv' order with item clock number 'SPMUKCN14_2' production additional services with following fields:
| Type       | Notes                |
| Tagging HD | automated test notes |
| Reslate HD | automated test notes |
And create for 'tv' order with item clock number 'SPMUKCN14_3' additional services with following fields:
| Type            | Destination       | Format         | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels       | Standard   | Express    |
| Tape            | SPMUKDN14         | D2             | Same as Master | Compile 1     | 5          | SPMUKDN14 SPMUKCnN14_1 SPMUKCD14_1 SPMUKSA14_1 SPMUKC14_1 SPMUKPC14_1 SPMUKC14_1 | automated test notes | should     | should not |
| Generics Upload | Generics_email_14 | Master Toolkit | As required    | Compile 1     | 1          | Generics_email_14                                                                | automated test notes | should not | should     |
And create for 'tv' order with item clock number 'SPMUKCN14_3' production additional services with following fields:
| Type                 | Notes                |
| Tagging HD           | automated test notes |
| Conversion HD<>SD    | automated test notes |
| Conversion PAL<>NTSC | automated test notes |
And enable QC & Ingest Only for 'tv' order for item with following clock numbers 'SPMUKCN14_1,SPMUKCN14_2,SPMUKCN14_3'
When I open order item with following clock number 'SPMUKCN14_1'
And copy data from 'Add media' section of order item page to all other items
And click active Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                                               | QTY | Unit   | TotalPerItem| Subtotal  | Tax     | Total|
| QC & Ingest Fee                                    | 1   |200.00  | 200.00      | 2,474.00 | 519.54 | 2,993.54 |
| QC & Ingest Fee                                    | 1   |200.00  | 200.00      | 2,474.00 | 519.54 | 2,993.54 |
| QC & Ingest Fee                                    | 1   |200.00  | 200.00      | 2,474.00 | 519.54 | 2,993.54 |
| Dubbing Service: DVD - Express International       | 3   | 44.00  | 132.00      | 2,474.00 | 519.54 | 2,993.54 |
| Production - Tagging - UpTo 60SD                     | 1   | 118.00 | 118.00      | 2,474.00 | 519.54 | 2,993.54 |
| Production service: Reslate SD                     | 1   | 116.00 | 116.00      | 2,474.00 | 519.54 | 2,993.54 |
| Dubbing Service: Tape - Standard International     | 5   | 72.00  | 360.00      | 2,474.00 | 519.54 | 2,993.54 |
| Dubbing Service: DVD - Standard International      | 3   | 42.00  | 126.00      | 2,474.00 | 519.54 | 2,993.54 |
| Production - Tagging - UpTo 60HD                     | 1   | 119.00 | 119.00      | 2,474.00 | 519.54 | 2,993.54 |
| Production service: Reslate HD                     | 1   | 117.00 | 117.00      | 2,474.00 | 519.54 | 2,993.54 |
| Dubbing Service: Tape - Standard International     | 5   | 72.00  | 360.00      | 2,474.00 | 519.54 | 2,993.54 |
| Dubbing Service: Generics Upload - Express Interna | 1   | 84.00  | 84.00       | 2,474.00 | 519.54 | 2,993.54 |
| Production - Tagging - UpTo 60HD                     | 1   | 119.00 | 119.00      | 2,474.00 | 519.54 | 2,993.54 |
| Production service: Conversion HD<>SD              | 1   | 111.00 | 111.00      | 2,474.00 | 519.54 | 2,993.54 |
| Production service: Conversion PAL<>NTSC           | 1   | 112.00 | 112.00      | 2,474.00 | 519.54 | 2,993.54 |

Scenario: Add Media via Physical Media, One Clock to one Destination within Market, with Adbank,with Adtext subtitles standard Service Level, standard rate card
Meta: @ordering
Given I updated the following agency:
| Name    | Save In Library | Allow To Save In Library |
| SPMUK02 | should          | should                   |
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination     |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN5     | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Aastha:Standard |
When I open order item with following clock number 'SPMUKCN5'
And fill following fields for New Master of order item that supply via 'Physical' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| SPMUK02  | should not       | automated test | 12/14/2022    |
And click Proceed button on order item page
Then I should see following Billing data on Order Proceed page:
| Item                          | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital)  | 1   | 40.00  | 40.00       | 231.00  | 48.51 | 279.51 |
| Subtitling - Adtext SD        | 1   | 41.00  | 41.00       | 231.00  | 48.51 | 279.51 |
| Adbank - Standard             | 1   | 150.00 | 150.00      | 231.00  | 48.51 | 279.51 |


Scenario: Add Media via Library, Multiple Clock to Multiple Destination within Market,adbank, adtext subtitles,Standard/Express Service Level, standard rate card
Meta: @qaorderingsmoke
      @uatorderingsmoke
!-- On UAT's scenario would fail if BU created with S3 storage, FAB-767 should fix the issue
Given I updated the following agency:
| Name    | Save In Library |Allow To Save In Library|
| SPMUK02 | should          |should                  |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And I am on the Library page for collection 'My Assets'NEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov,Fish2-Ad.mov'NEWLIB
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                                                                                     |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN6_1   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Bangla TV:Standard;ABP News:Standard;ARY News:Standard;Channel 5:Standard;CBS:Standard;Channel Starz:Express |
| automated test info    | SPMUKAR    | SPMUKBR | SPMUKPR   | SPMUKPR | SPMUKC   | SPMUKCN6_2   | 20       | 10/14/2022     | HD 1080i 25fps | SPMUKT | Adtext SD          | Bangla TV:Standard;ABP News:Standard;ARY News:Express;Channel 5:Express;Channel Starz:Express                |
When I open order item with following clock number 'SPMUKCN6_1'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
And I go to the Library page for collection 'My Assets'NEWLIB
When I open order item with following clock number 'SPMUKCN6_2'
And add to order for order item at Add media to your order form following assets 'Fish2-Ad.mov'
When I open order item with following clock number 'SPMUKCN6_2'
And I wait for '3' seconds
And click Proceed button on order item page
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock          | Item                          | QTY | Unit    | TotalPerItem | Subtotal | Tax     | Total     |
|SPMUKCN6_1     | SD Standard Normal (Digital)  | 5   | 40.00  | 200.00      | 942.00  | 197.82 | 1,139.82 |
|SPMUKCN6_1     | SD Express Normal (Digital)   | 1   | 70.00  | 70.00       | 942.00  | 197.82 | 1,139.82 |
|SPMUKCN6_1     | Subtitling - Adtext SD        | 1   | 41.00  | 41.00       | 942.00  | 197.82 | 1,139.82 |
|SPMUKCN6_2     | SD Standard Normal (Digital)  | 2   | 40.00  | 80.00       | 942.00  | 197.82 | 1,139.82 |
|SPMUKCN6_2     | SD Express Normal (Digital)   | 3   | 70.00  | 210.00      | 942.00  | 197.82 | 1,139.82 |
|SPMUKCN6_2     | Subtitling - Adtext SD        | 1   | 41.00  | 41.00       | 942.00  | 197.82 | 1,139.82 |
|SPMUKCN6_1     | Adbank - Standard             | 1   | 150.00 | 150.00      | 942.00  | 197.82 | 1,139.82 |
|SPMUKCN6_2     | Adbank - Standard             | 1   | 150.00 | 150.00      | 942.00  | 197.82 | 1,139.82 |


