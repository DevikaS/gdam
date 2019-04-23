!--ORD-2091
!--ORD-2265
!--ORD-2264
Feature: Order Confirmation Email
Narrative:
In order to:
As a AgencyAdmin
I want to check order confirmation email

Scenario: Notification after confirmation an order
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        |
| OCEA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCEU1 | agency.admin | OCEA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OCEA1':
| Advertiser | Brand  | Sub Brand | Product |
| OCEAR1     | OCEBR1 | OCESB1    | OCEPR1  |
And logged in with details of 'OCEU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | OCEAR1     | OCEBR1 | OCESB1    | OCEPR1  | OCEC1    | OCECN1       | 20       | 10/14/2022     | HD 1080i 25fps | OCET1 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OCECN1' with following fields:
| Job Number | PO Number |
| OCEJN1     | OCEPN1    |
Then I 'should' see email notification for 'Order Confirmation' with field to 'OCEU1' and subject 'Order Confirmation:' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | OCEU1    | OCECN1       | OCEJN1     | OCEPN1    |