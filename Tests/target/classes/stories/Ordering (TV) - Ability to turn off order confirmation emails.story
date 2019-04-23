!--ORD-3109
!--ORD-3233
Feature: Ability to turn off order confirmation emails
Narrative:
In order to:
As a AgencyAdmin
I want to check ability to turn off order confirmation emails

Scenario: check turning off the confirmation email sending
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        |
| ATOOCEA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ATOOCEU1 | agency.admin | ATOOCEA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOOCEA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ATOOCEAR1  | ATOOCEBR1 | ATOOCESB1 | ATOOCEPR1 |
And logged in with details of 'ATOOCEU1'
And I am on my Notifications Settings page
And set notification 'Order Placed' into state 'off' for current user
And saved current user notifications setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ATOOCEAR1  | ATOOCEBR1 | ATOOCESB1 | ATOOCEPR1 | ATOOCEC1 | ATOOCECN1    | 20       | 10/14/2022     | HD 1080i 25fps | ATOOCET1 | Already Supplied   | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'ATOOCECN1'
When I fill following fields on Order Proceed page:
| Order Confirmed Recipients | Job Number | PO Number |
| ATOOCEU1                   | ATOOCEJN1  | ATOOCEPN1 |
And confirm order on Order Proceed page
And wait for '10' seconds
Then I 'should not' see email notification for 'Order Confirmation' with field to 'ATOOCEU1' and subject 'Order Confirmation:' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | ATOOCEU1 | ATOOCECN1    | ATOOCEJN1  | ATOOCEPN1 |


Scenario: check turning on the confirmation email sending
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        |
| ATOOCEA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ATOOCEU1 | agency.admin | ATOOCEA1     |
| ATOOCER2 | agency.admin | ATOOCEA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOOCEA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ATOOCEAR1  | ATOOCEBR1 | ATOOCESB1 | ATOOCEPR1 |
And logged in with details of 'ATOOCEU1'
And I am on my Notifications Settings page
And set notification 'Order Placed' into state 'on' for current user
And saved current user notifications setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ATOOCEAR1  | ATOOCEBR1 | ATOOCESB1 | ATOOCEPR1 | ATOOCEC2 | ATOOCECN2    | 20       | 10/14/2022     | HD 1080i 25fps | ATOOCET2 | Already Supplied   | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'ATOOCECN2'
When I fill following fields on Order Proceed page:
| Order Confirmed Recipients | Job Number | PO Number |
| ATOOCER2                   | ATOOCEJN2  | ATOOCEPN2 |
And confirm order on Order Proceed page
Then I 'should' see email notification for 'Order Confirmation' with field to 'ATOOCEU1' and subject 'Order Confirmation:' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | ATOOCEU1 | ATOOCECN2    | ATOOCEJN2  | ATOOCEPN2 |
And 'should' see email notification for 'Order Confirmation' with field to 'ATOOCER2' and subject 'Order Confirmation:' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | ATOOCEU1 | ATOOCECN2    | ATOOCEJN2  | ATOOCEPN2 |

Scenario: check turning off the Beam confirmation email with sending only to default UK recipient
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| ATOOCEA3 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| ATOOCEU3 | agency.admin | ATOOCEA3     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOOCEA3':
| Advertiser | Brand     | Sub Brand | Product   |
| ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 |
And logged in with details of 'ATOOCEU3'
And I am on my Notifications Settings page
And set notification 'Order Placed' into state 'off' for current user
And saved current user notifications setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 | ATOOCEC3 | ATOOCECN3    | 20       | 10/14/2022     | HD 1080i 25fps | ATOOCET3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ATOOCECN3' with following fields:
| Job Number | PO Number |
| ATOOCEJN3  | ATOOCEPN3 |
Then I 'should not' see email notification for 'Order Confirmation' with field to 'ATOOCEU3' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Country        |
| beam         | ATOOCEU3 | ATOOCECN3    | ATOOCEJN3  | ATOOCEPN3 | United Kingdom |
And 'should' see email notification for 'Order Confirmation' with field to 'transmission@beam.tv' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration | Format         | First Air Date | Archive | Note                | Subtitles Required | Destination Group | Destination        | Service Level |
| beam         | ATOOCEU3 | ATOOCECN3    | ATOOCEJN3  | ATOOCEPN3 | 1                 | 1                 | United Kingdom | ATOOCECN3 | ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 | ATOOCET3 | 20       | HD 1080i 25fps | 10/14/2022     | Yes     | automated test info | Already Supplied   | BSkyB             | BSkyB Green Button | Standard      |

Scenario: check turning off the Beam confirmation email with sending only to default Belgium recipient
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| ATOOCEA3 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| ATOOCEU3 | agency.admin | ATOOCEA3     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOOCEA3':
| Advertiser | Brand     | Sub Brand | Product   |
| ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 |
And logged in with details of 'ATOOCEU3'
And I am on my Notifications Settings page
And set notification 'Order Placed' into state 'off' for current user
And saved current user notifications setting
And create 'tv' order with market 'Belgium' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                         |
| automated test info    | ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 | ATOOCEC4 | ATOOCECN4    | 20       | 10/14/2022     | HD 1080i 25fps | ATOOCET4 | Discovery Networks Benelux:Standard |
And complete order contains item with clock number 'ATOOCECN4' with following fields:
| Job Number | PO Number |
| ATOOCEJN4  | ATOOCEPN4 |
Then I 'should not' see email notification for 'Order Confirmation' with field to 'ATOOCEU3' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Country |
| beam         | ATOOCEU3 | ATOOCECN4    | ATOOCEJN4  | ATOOCEPN4 | Belgium |
And 'should' see email notification for 'Order Confirmation' with field to 'International@beam.tv' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country | Spot Code | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration | Format         | First Air Date | Archive | Note                | Destination Group | Destination                | Service Level |
| beam         | ATOOCEU3 | ATOOCECN4    | ATOOCEJN4  | ATOOCEPN4 | 1                 | 1                 | Belgium | ATOOCECN4 | ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 | ATOOCET4 | 20       | HD 1080i 25fps | 10/14/2022     | Yes     | automated test info | Belgium           | Discovery Networks Benelux | Standard      |

Scenario: check turning on the Beam confirmation email sending
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| ATOOCEA3 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique | Language |
| ATOOCEU3 | agency.admin | ATOOCEA3     | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOOCEA3':
| Advertiser | Brand     | Sub Brand | Product   |
| ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 |
And logged in with details of 'ATOOCEU3'
And I am on my Notifications Settings page
And set notification 'Order Placed' into state 'on' for current user
And saved current user notifications setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 | ATOOCEC5 | ATOOCECN5    | 20       | 10/14/2022     | HD 1080i 25fps | ATOOCET5 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ATOOCECN5' with following fields:
| Job Number | PO Number |
| ATOOCEJN5  | ATOOCEPN5 |
Then I 'should' see email notification for 'Order Confirmation' with field to 'ATOOCEU3' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Spot Code | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration | Format         | First Air Date | Archive | Note                | Subtitles Required | Destination Group | Destination        | Service Level |
| beam         | ATOOCEU3 | ATOOCECN5    | ATOOCEJN5  | ATOOCEPN5 | 1                 | 1                 | United Kingdom | ATOOCECN5 | ATOOCEAR3  | ATOOCEBR3 | ATOOCESB3 | ATOOCEPR3 | ATOOCET5 | 20       | HD 1080i 25fps | 10/14/2022     | Yes     | automated test info | Already Supplied   | BSkyB             | BSkyB Green Button | Standard      |