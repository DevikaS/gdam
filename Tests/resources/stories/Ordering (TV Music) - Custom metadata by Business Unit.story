!--ORD-1375
Feature: Check custom metadata for delivery
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of metadata for delivery

Lifecycle:
Before:
Given I created the following agency:
| Name       | A4User        |
| CTOCBCWCD1 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| CTOCBCWCDUE1 | agency.admin | CTOCBCWCD1   |
And logged in with details of 'CTOCBCWCDUE1'
And I am on the global 'video asset' metadata page for agency 'CTOCBCWCD1'
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
And created 'Hyperlink' custom metadata field with following information on opened metadata page:
| Description     | Delivery |
| hyperlink-test1 | should   |
And created 'Address' custom metadata field with following information on opened metadata page:
| Description   | Delivery |
| address-test1 | should   |

Scenario: Check that order can be confirmed with custom data
Meta: @ordering
Given logged in with details of 'CTOCBCWCDUE1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | CTOCBCWCD1 | OTVCSDCMBR1 | OTVCSDCMSB1 | OTVCSDCMP1 | OTVCSDCMC1 | OTVCSDCMCN1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVCSDCMT1 | Already Supplied   | Aastha:Standard |
When open order item with following clock number 'OTVCSDCMCN1'
And fill following fields for Additional information section on order item page:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-phone1 | custom-date1 | radio-buttons1 | custom-dropdown1 | address-test1                                         | hyperlink-test1      |
| catalog1                    | value1 | value2 | string1-custom-value | multiline1-custom-value | 666666        | 01/28/2022   | t2             | drop1            | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me |
And click Proceed button on order item page
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'OTVCSDCMCN1' and following fields:
| Order# | DateTime    | Advertiser | Brand       | Sub Brand   | Product    | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit# | CurrentTime | CTOCBCWCD1 | OTVCSDCMBR1 | OTVCSDCMSB1 | OTVCSDCMP1 | United Kingdom |           |         | 1        | 0/1 Delivered |

Scenario: Check that data in Additional Information section is copied using Copy Current and retreived from Library
Meta: @ordering
Given logged in with details of 'CTOCBCWCDUE1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | CTOCBCWCD4 | OTVCSDCMBR4 | OTVCSDCMSB4 | OTVCSDCMP4 | OTVCSDCMC4 | OTVCSDCMCN4  | 20       | 08/14/2022     | HD 1080i 25fps | OTVCSDCMT4 | Already Supplied   | Aastha:Standard |
When open order item with following clock number 'OTVCSDCMCN4'
And fill following fields for Additional information section on order item page:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-phone1 | custom-date1 | custom-dropdown1 | hyperlink-test1      | address-test1                                         | radio-buttons1 |
| catalog1                    | value1 | value2 | string1-custom-value | multiline1-custom-value | 666666        | 01/28/2022   | drop1,drop2      | http://www.adbank.me | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | t2             |
And click Proceed button on order item page
And confirm order on Order Proceed page
And create 'tv' order on View Draft Orders tab on ordering page
And add to order for order item at Add media to your order form following qc assets 'OTVCSDCMT4'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data for order item on Additional information section:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-phone1 | custom-date1 | custom-dropdown1 | hyperlink-test1      | address-test1                                         | radio-buttons1 |
| catalog1                    | value1 | value2 | string1-custom-value | multiline1-custom-value | 666666        | 01/28/2022   | drop1 drop2      | http://www.adbank.me | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | t2             |

Scenario: Check that data in Additional Information section is cleared using Clear Section
Meta: @ordering
Given logged in with details of 'CTOCBCWCDUE1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand       | Sub Brand   | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | CTOCBCWCD5 | OTVCSDCMBR5 | OTVCSDCMSB5 | OTVCSDCMP5 | OTVCSDCMC5 | OTVCSDCMCN5  | 20       | 08/14/2022     | HD 1080i 25fps | OTVCSDCMT5 | Already Supplied   | Aastha:Standard |
When open order item with following clock number 'OTVCSDCMCN5'
And fill following fields for Additional information section on order item page:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-phone1 | custom-date1 | custom-dropdown1 | hyperlink-test1      | address-test1                                         |
| catalog1                    | value1 | value2 | string1-custom-value | multiline1-custom-value | 666666        | 01/28/2022   | drop1,drop2      | http://www.adbank.me | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine |
And click Proceed button on order item page
And confirm order on Order Proceed page
And create 'tv' order on View Draft Orders tab on ordering page
And add to order for order item at Add media to your order form following qc assets 'OTVCSDCMT5'
And 'copy current' order item by Add Commercial button on order item page
And clear 'Additional information' section on order item page
Then I should see following data for order item on Additional information section:
| custom-catalogue-structure1 | cat1 | cat2 | custom-string1 | custom-multiline1 | custom-phone1 | custom-date1 | custom-dropdown1 | hyperlink-test1 | address-test1 | radio-buttons1 |
|                             |      |      |                |                   |               |              |                  | http://         | ,,,,          |                |

Scenario: Check that data in Additional Information section is copied using Copy to All
Meta: @ordering
Given logged in with details of 'CTOCBCWCDUE1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| OTVCSDCMCN5_1 |
| OTVCSDCMCN5_2 |
When open order item with following clock number 'OTVCSDCMCN5_1'
And fill following fields for Additional information section on order item page:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-phone1 | custom-date1 | custom-dropdown1 | hyperlink-test1      | address-test1                                         | radio-buttons1 |
| catalog1                    | value1 | value2 | string1-custom-value | multiline1-custom-value | 666666        | 01/28/2022   | drop1,drop2      | http://www.adbank.me | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | t2             |
And copy data from 'Additional information' section of order item page to all other items
And select order item with following clock number 'OTVCSDCMCN5_2' on cover flow
Then I should see following data for order item on Additional information section:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-phone1 | custom-date1 | custom-dropdown1 | hyperlink-test1      | address-test1                                         | radio-buttons1 |
| catalog1                    | value1 | value2 | string1-custom-value | multiline1-custom-value | 666666        | 01/28/2022   | drop1 drop2      | http://www.adbank.me | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | t2             |

Scenario: Check that custom data is saved in case to use Save as Draft
Meta: @ordering
Given logged in with details of 'CTOCBCWCDUE1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCSDCMCN6  |
When open order item with following clock number 'OTVCSDCMCN6'
And fill following fields for Additional information section on order item page:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-date1 | custom-phone1 | custom-dropdown1 | hyperlink-test1      | address-test1                                         | radio-buttons1 | radio-buttons1 |
| catalog1                    | value1 | value2 | custom-string1-value | custom-multiline1-value | 01/02/2028   | 911           | drop1,drop2      | http://www.adbank.me | Chreshatik Street 35. Apart. 44,Kiev,Kiev,777,Ukraine | t2             | t2             |
And save as draft order
And open order item with following clock number 'OTVCSDCMCN6'
Then I should see following data for order item on Additional information section:
| custom-catalogue-structure1 | cat1   | cat2   | custom-string1       | custom-multiline1       | custom-date1 | custom-phone1 | custom-dropdown1 | hyperlink-test1      | address-test1                                         | radio-buttons1 | radio-buttons1 |
| catalog1                    | value1 | value2 | custom-string1-value | custom-multiline1-value | 01/02/2028   | 911           | drop1 drop2      | http://www.adbank.me | Chreshatik Street 35. Apart. 44,Kiev,Kiev,777,Ukraine | t2             | t2             |

