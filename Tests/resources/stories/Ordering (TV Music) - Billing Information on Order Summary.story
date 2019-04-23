!--ORD-1554
!--ORD-2334
!--ORD-2361
Feature: Billing information on Order Summary
Narrative:
In order to:
As a AgencyAdmin
I want to check billing information on Order Summary

Scenario: Check that billing info section isn't displayed if SAP ID is empty
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Country        | SAP ID |
| BIOSA1 | DefaultA4User | United Kingdom |        |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| BIOSU1 | agency.admin | BIOSA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BIOSA1':
| Advertiser | Brand   | Sub Brand | Product |
| BIOSAR1    | BIOSBR1 | BIOSSB1   | BIOSPR1 |
And logged in with details of 'BIOSU1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | BIOSAR1    | BIOSBR1 | BIOSSB1   | BIOSPR1 | BIOSC1   | BIOSCN1      | 20       | 10/14/2022     | HD 1080i 25fps | BIOST1 | Already Supplied   | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'BIOSCN1'
Then I 'should not' see Billing information on Order Proceed page

Scenario: Check that empty billing info section is displayed if Country isn't equal to United Kingdom
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Country | SAP ID       | SAP Country |
| BIOSA2 | DefaultA4User | Ukraine | DefaultSapID | Spain       |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| BIOSU2 | agency.admin | BIOSA2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BIOSA2':
| Advertiser | Brand   | Sub Brand | Product |
| BIOSAR2    | BIOSBR2 | BIOSSB2   | BIOSPR2 |
And logged in with details of 'BIOSU2'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | BIOSAR2    | BIOSBR2 | BIOSSB2   | BIOSPR2 | BIOSC2   | BIOSCN2      | 20       | 10/14/2022     | HD 1080i 25fps | BIOST2 | Already Supplied   | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'BIOSCN2'
Then I should see following Billing data on Order Proceed page:
| Item | QTY | Unit | TotalPerItem | Subtotal | Tax | Total |
|      |     |      |              |          |     |       |

Scenario: Check that empty billing info section is displayed if SAP ID isn't correct
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Country | SAP ID |
| BIOSA3 | DefaultA4User | Ukraine | 123    |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| BIOSU3 | agency.admin | BIOSA3       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BIOSA3':
| Advertiser | Brand   | Sub Brand | Product |
| BIOSAR3    | BIOSBR3 | BIOSSB3   | BIOSPR3 |
And logged in with details of 'BIOSU3'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | BIOSAR3    | BIOSBR3 | BIOSSB3   | BIOSPR3 | BIOSC3   | BIOSCN3      | 20       | 10/14/2022     | HD 1080i 25fps | BIOST3 | Already Supplied   | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'BIOSCN3'
Then I should see following Billing data on Order Proceed page:
| Item | QTY | Unit | TotalPerItem | Subtotal | Tax | Total |
|      |     |      |              |          |     |       |

Scenario: Check that correct billing info is displayed on Order Summary
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I created the following agency:
| Name   | A4User        | Country        | SAP ID       |
| BIOSA4 | DefaultA4User | United Kingdom | DefaultSapID |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| BIOSU4 | agency.admin | BIOSA4       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BIOSA4':
| Advertiser | Brand     | Sub Brand | Product   |
| BIOSAR4_1  | BIOSBR4_1 | BIOSSB4_1 | BIOSPR4_1 |
| BIOSAR4_2  | BIOSBR4_2 | BIOSSB4_2 | BIOSPR4_2 |
And logged in with details of 'BIOSU4'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                  |
| automated test info    | BIOSAR4_1  | BIOSBR4_1 | BIOSSB4_1 | BIOSPR4_1 | BIOSC4_1 | BIOSCN4_1    | 20       | 10/14/2022     | HD 1080i 25fps | BIOST4_1 | BTI Studios        | BSkyB Green Button:Standard  |
| automated test info    | BIOSAR4_2  | BIOSBR4_2 | BIOSSB4_2 | BIOSPR4_2 | BIOSC4_2 | BIOSCN4_2    | 15       | 10/14/2022     | HD 1080i 25fps | BIOST4_2 | Adtext SD          | New Station - UK HD:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'BIOSCN4_1'
Then I should see following Billing data on Order Proceed page:
| Item                               | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital)       | 1   | 100.00 | 100.00      | 263.00  | 55.23 | 318.23 |
| Subtitling: Standard (BTI Studios) | 1   | 42.00  | 42.00       | 263.00  | 55.23 | 318.23 |
| HD Standard Normal (Digital)       | 1   | 80.00  | 80.00       | 263.00  | 55.23 | 318.23 |
| Subtitling: Standard (Adtext)      | 1   | 41.00  | 41.00       | 263.00  | 55.23 | 318.23 |


Scenario: Check that order is not failed due to incorrect country of BU for billing
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name   | A4User        | Country | SAP ID       |
| BIOSA6 | DefaultA4User | Ukraine | DefaultSapID |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| BIOSU6 | agency.admin | BIOSA6       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BIOSA6':
| Advertiser | Brand   | Sub Brand | Product |
| BIOSAR6    | BIOSBR6 | BIOSSB6   | BIOSPR6 |
And logged in with details of 'BIOSU6'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | BIOSAR6    | BIOSBR6 | BIOSSB6   | BIOSPR6 | BIOSC6   | BIOSCN6      | 20       | 10/14/2022     | HD 1080i 25fps | BIOST6 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'BIOSCN6' with following fields:
| Job Number | PO Number |
| BIOSJN6    | BIOSPN6   |
Then I 'should' see email notification for 'Order Confirmation' with field to 'BIOSU6' and subject 'Order Confirmation:' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | BIOSU6   | BIOSCN6      | BIOSJN6    | BIOSPN6   |