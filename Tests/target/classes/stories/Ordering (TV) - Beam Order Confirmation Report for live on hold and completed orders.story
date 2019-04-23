!--ORD-3354
!--ORD-3576
Feature: Beam Order Confirmation Report for live on hold and completed orders
Narrative:
In order to:
As a AgencyAdmin
I want to check order confirmation report for live on hold and completed orders

Scenario: Check that View Confirmation Report is available only for Beam agencies for Live Hold and Completed orders
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels |
| BOCRA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email  | Role         | AgencyUnique | Language |
| BOCRU1 | agency.admin | BOCRA1       | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BOCRA1':
| Advertiser | Brand   | Sub Brand | Product |
| BOCRAR1    | BOCRBR1 | BOCRSB1   | BOCRPR1 |
And logged in with details of 'BOCRU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | BOCRAR1    | BOCRBR1 | BOCRSB1   | BOCRPR1 | BOCRC1   | BOCRCN1      | 20       | 10/14/2022     | HD 1080i 25fps | BOCRT1 | Already Supplied   | BSkyB Green Button:Standard |
And hold for approval 'tv' order items with following clock numbers 'BOCRCN1'
And complete order contains item with clock number 'BOCRCN1' with following fields:
| Job Number | PO Number |
| BOCRJN1    | BOCRPN1   |
And I am on Order Summary page for order contains item with following clock number 'BOCRCN1'
Then I 'should' see 'View Confirmation Report' button on order summary page

Scenario: Check that View Confirmation Report is unavailable for not Beam agencies
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| BOCRA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| BOCRU2 | agency.admin | BOCRA2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BOCRA2':
| Advertiser | Brand   | Sub Brand | Product |
| BOCRAR2    | BOCRBR2 | BOCRSB2   | BOCRPR2 |
And logged in with details of 'BOCRU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | BOCRAR2    | BOCRBR2 | BOCRSB2   | BOCRPR2 | BOCRC2   | BOCRCN2      | 20       | 10/14/2022     | HD 1080i 25fps | BOCRT2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'BOCRCN2' with following fields:
| Job Number | PO Number |
| BOCRJN2    | BOCRPN2   |
And I am on Order Summary page for order contains item with following clock number 'BOCRCN2'
Then I 'should not' see 'View Confirmation Report' button on order summary page

Scenario: Check that View Confirmation Report is correctly opened
Meta: @ordering
Given I created the following agency:
| Name   | A4User        | Labels |
| BOCRA1 | DefaultA4User | Beam   |
And created users with following fields:
| Email  | Role         | AgencyUnique | Language |
| BOCRU1 | agency.admin | BOCRA1       | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BOCRA1':
| Advertiser | Brand   | Sub Brand | Product |
| BOCRAR1    | BOCRBR1 | BOCRSB1   | BOCRPR1 |
And logged in with details of 'BOCRU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | BOCRAR1    | BOCRBR1 | BOCRSB1   | BOCRPR1 | BOCRC3   | BOCRCN3      | 20       | 10/14/2022     | HD 1080i 25fps | BOCRT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'BOCRCN3' with following fields:
| Job Number | PO Number |
| BOCRJN3    | BOCRPN3   |
And I am on Order Summary page for order contains item with following clock number 'BOCRCN3'
Then I should see that View 'Confirmation' report opens for order with clock number 'BOCRCN3'