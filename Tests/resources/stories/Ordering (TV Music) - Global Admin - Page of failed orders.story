!--ORD-2551
Feature: Page of failed order for global admin
Narrative:
In order to:
As a AgencyAdmin
I want to check page of failed orders

Scenario: Check that failed order appears on the page
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Country | SAP ID       |
| OPFOA1 | DefaultA4User | Ukraine | DefaultSapID |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OPFOU1 | agency.admin | OPFOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OPFOA1':
| Advertiser | Brand   | Sub Brand | Product |
| OPFOAR1    | OPFOBR1 | OPFOSB1   | OPFOPR1 |
And logged in with details of 'OPFOU1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination                 |
| automated test info    | OPFOAR1    | OPFOBR1 | OPFOSB1   | OPFOPR1 | OPFOC1   | OPFOCN1      | 20       | 10/14/2022     | HD 1080i 25fps | OPFOT1 | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OPFOCN1' with following fields:
| Job Number | PO Number |
| OPFOJN1    | OPFOPN1   |
And I logged in as 'GlobalAdmin'
And I am on Failed Order page
Then I 'should' see order with following item clock number 'OPFOCN1' in failed orders list

Scenario: Check that order can be deleted from the page
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Country | SAP ID       |
| OPFOA1 | DefaultA4User | Ukraine | DefaultSapID |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OPFOU1 | agency.admin | OPFOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OPFOA1':
| Advertiser | Brand   | Sub Brand | Product |
| OPFOAR1    | OPFOBR1 | OPFOSB1   | OPFOPR1 |
And logged in with details of 'OPFOU1'
And 'enable' Billing Service
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination                |
| automated test info    | OPFOAR1    | OPFOBR1 | OPFOSB1   | OPFOPR1 | OPFOC2   | OPFOCN2      | 20       | 10/14/2022     | HD 1080i 25fps | OPFOT2 | Universal Ireland:Standard |
And complete order contains item with clock number 'OPFOCN2' with following fields:
| Job Number | PO Number |
| OPFOJN2    | OPFOPN2   |
And I logged in as 'GlobalAdmin'
And I am on Failed Order page
When I delete order with following item clock number 'OPFOCN2' in failed orders list
And refresh the page without delay
Then I 'should not' see order with following market 'Republic of Ireland' in failed orders list

Scenario: Check that failed order can be resend
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Country | SAP ID       |
| OPFOA1 | DefaultA4User | Ukraine | DefaultSapID |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| OPFOU1 | agency.admin | OPFOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OPFOA1':
| Advertiser | Brand   | Sub Brand | Product |
| OPFOAR1    | OPFOBR1 | OPFOSB1   | OPFOPR1 |
And logged in with details of 'OPFOU1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Destination                 |
| automated test info    | OPFOAR1    | OPFOBR1 | OPFOSB1   | OPFOPR1 | OPFOC3   | OPFOCN3      | 20       | 10/14/2022     | HD 1080i 25fps | OPFOT3 | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OPFOCN3' with following fields:
| Job Number | PO Number |
| OPFOJN3    | OPFOPN3   |
And updated the following agency:
| Name   | Country        |
| OPFOA1 | United Kingdom |
And I logged in as 'GlobalAdmin'
And I am on Failed Order page
When I resend order with following item clock number 'OPFOCN3' in failed orders list
And refresh the page without delay
Then I 'should not' see order with following item clock number 'OPFOCN3' in failed orders list