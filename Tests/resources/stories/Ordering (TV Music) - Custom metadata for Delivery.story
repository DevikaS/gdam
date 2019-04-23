!--ORD-1375
Feature: Check custom metadata for delivery of assets
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of metadata for delivery of assets

Scenario: Check validation of custom data after clicking Proceed button
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| CTOCBCWCD2 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| CTOCBCWCDUE2 | agency.admin | CTOCBCWCD2   |
And logged in with details of 'CTOCBCWCDUE2'
And I am on the global 'video asset' metadata page for agency 'CTOCBCWCD2'
And created 'String' custom metadata field with following information on opened metadata page:
| Description    | Delivery | Compulsory |
| custom-string1 | should   | true       |
And created 'Multiline' custom metadata field with following information on opened metadata page:
| Description       | Delivery | Compulsory |
| custom-multiline1 | should   | true       |
And created 'Date' custom metadata field with following information on opened metadata page:
| Description  | Delivery | Compulsory |
| custom-date1 | should   | true       |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description                 | Descendants | Delivery | AddOnFly | MultipleChoices | Compulsory |
| custom-catalogue-structure1 | cat1,cat2   | should   | should   | should          | true       |
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description      | Delivery | AddOnFly | MultipleChoices | Descendants | Compulsory |
| custom-dropdown1 | should   | should   | should          | drop1,drop2 | true       |
And created 'Phone' custom metadata field with following information on opened metadata page:
| Description   | Delivery | Compulsory |
| custom-phone1 | should   | true       |
And created 'Hyperlink' custom metadata field with following information on opened metadata page:
| Description     | Delivery | Compulsory |
| hyperlink-test1 | should   | true       |
And created 'Address' custom metadata field with following information on opened metadata page:
| Description   | Delivery | Compulsory |
| address-test1 | should   | true       |
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description    | Delivery | Descendants | Compulsory |
| radio-buttons1 | should   | t1,t2       | true       |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | CTOCBCWCD2 | OTVCSDCMBR2 | OTVCSDCMSB2 | OTVCSDCMP2 | OTVCSDCMC2 | OTVCSDCMCN2  | 20       | 08/14/2022     | HD 1080i 25fps | OTVCSDCMT2 | Already Supplied   | BSkyB Green Button:Standard |
When open order item with following clock number 'OTVCSDCMCN2'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Additional information'
And 'should' see expanded following sections 'Additional information' on order item page
And should see following data for order item on Additional information section:
| custom-catalogue-structure1 | cat1 | cat2 | custom-string1 | custom-multiline1 | custom-phone1 | custom-date1 | custom-dropdown1 | hyperlink-test1 | address-test1 | radio-buttons1 |
|                             |      |      |                |                   |               |              |                  | http://         | ,,,,          |                |

Scenario: Check that data is correctly displayed on QC-ed assets
Meta: @ordering
Given I created the following agency:
| Name          | A4User        |Save In Library |Allow To Save In Library|
| CTOCBCWCD_ATP | DefaultA4User |should          |should                  |
And created users with following fields:
| Email           | Role         | AgencyUnique    |Access|
| CTOCBCWCDUE_ATP | agency.admin | CTOCBCWCD_ATP   |streamlined_library,ordering|
And logged in with details of 'CTOCBCWCDUE_ATP'
And I am on the global 'video asset' metadata page for agency 'CTOCBCWCD_ATP'
And created 'String' custom metadata field with following information on opened metadata page:
| Description    | Delivery |
| custom-string1 | should   |
And created 'Multiline' custom metadata field with following information on opened metadata page:
| Description       | Delivery |
| custom-multiline1 | should   |
And created 'Date' custom metadata field with following information on opened metadata page:
| Description  | Delivery |
| custom-date1 | should   |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description                 | Descendants | Delivery | AddOnFly | MultipleChoices |
| custom-catalogue-structure1 | cat1,cat2   | should   | should   | should          |
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description      | Delivery | AddOnFly | MultipleChoices | Descendants |
| custom-dropdown1 | should   | should   | should          | drop1,drop2 |
And created 'Phone' custom metadata field with following information on opened metadata page:
| Description   | Delivery |
| custom-phone1 | should   |
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description    | Delivery | Descendants |
| radio-buttons1 | should   | t1,t2       |
And created 'Address' custom metadata field with following information on opened metadata page:
| Description   | Delivery |
| address-test1 | should   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | CTOCBCWCD3 | OTVCSDCMBR3 | OTVCSDCMSB3 | OTVCSDCMP3 | OTVCSDCMC3 | OTVCSDCMCN3  | 20       | 08/14/2022     | HD 1080i 25fps | OTVCSDCMT3 | Already Supplied   | Aastha:Standard |
When open order item with following clock number 'OTVCSDCMCN3'
And fill following fields for Additional information section on order item page:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-phone1 | custom-date1 | radio-buttons1 | custom-dropdown1 | address-test1                                         |
| catalog1                    | value1 | value2 | string1-custom-value | multiline1-custom-value | 666666        | 10/28/2022   | t2             | drop1            | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine |
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'OTVCSDCMCN3' of QC View summary on Order Proceed page
And confirm order on Order Proceed page
When I go to asset 'OTVCSDCMT3' info page in Library for collection 'Everything'NEWLIB
And I wait for '2' seconds
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                                            |
| custom-catalogue-structure1 | catalog1                                              |
| cat1                        | value1                                                |
| cat2                        | value2                                                |
| custom-string1              | string1-custom-value                                  |
| custom-multiline1           | multiline1-custom-value                               |
| custom-phone1               | 666666                                                |
| custom-date1                | 10/28/2022                                            |
| radio-buttons1              | t2                                                    |
| custom-dropdown1            | drop1                                                 |
| address-test1               | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine |


Scenario: Check that empty Additional Information section isn't displayed
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMCMBUA7 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMCMBUU7 | agency.admin | OTVMCMBUA7   |
And logged in with details of 'OTVMCMBUU7'
When I create 'tv' order on View Draft Orders tab on ordering page
Then I 'should not' see following sections 'Additional information' on order item page
