!--ORD-3100
!--ORD-3332
Feature: Default additional recipients
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of default additional recipients

Scenario: check default email recipients on Delivery Setting page
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        |
| DARA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DARU1 | agency.admin | DARA1        |
And logged in with details of 'DARU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU1_1,DARU1_2             |
And save own Delivery Setting
And refresh the page without delay
Then I should see following data for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU1_1,DARU1_2             |

Scenario: check default email recipients on Order Summary page
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        |
| DARA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DARU1 | agency.admin | DARA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DARA1':
| Advertiser | Brand  | Sub Brand | Product |
| DARAR2     | DARBR2 | DARSB2    | DARPR2  |
And logged in with details of 'DARU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | DARAR2     | DARBR2 | DARSB2    | DARPR2  | DARC2    | DARCN2       | 20       | 10/14/2022     | HD 1080i 25fps | DART2 | Already Supplied   | BSkyB Green Button:Standard |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU2_1,DARU2_2             |
And save own Delivery Setting
And go to Order Proceed page for order contains order item with following clock number 'DARCN2'
Then I should see following data for order on Order Proceed page:
| Order Confirmed Recipients|Order Completed Recipients|Order Ingested Recipients|
| DARU2_1,DARU2_2           | DARU2_1,DARU2_2          | DARU2_1,DARU2_2         |

Scenario: check validation for field Default Email Notifications
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        |
| DARA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DARU1 | agency.admin | DARA1        |
And logged in with details of 'DARU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU3@                      |
And save own Delivery Setting
Then I should see message error 'Default Email Notifications are incorrect'
And 'should' see validation error for following fields 'Default Email Notifications' for Delivery Setting form on user delivery setting page

Scenario: check default email recipients on Order Summary page for music
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        |
| DARA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DARU1 | agency.admin | DARA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DARA1':
| Advertiser | Brand  | Sub Brand | Product |
| DARAR2     | DARBR2 | DARSB2    | DARPR2  |
And logged in with details of 'DARU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Artist | ISRC Code | Release Date | Format         | Title | Destination                 |
| automated test info    | DARAR2     | DARBR2 | DARSB2    | DARPR2  | DARC4  | DARCN4    | 10/14/2022   | HD 1080i 25fps | DART4 | BSkyB Green Button:Standard |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU4_1,DARU4_2             |
And save own Delivery Setting
And go to Order Proceed page for order contains order item with following isrc code 'DARCN4'
Then I should see following data for order on Order Proceed page:
| Order Confirmed Recipients|Order Completed Recipients|Order Ingested Recipients|
| DARU4_1,DARU4_2           | DARU4_1,DARU4_2          | DARU4_1,DARU4_2         |

Scenario: check autocompleting default email notification for field Default Email Notifications
!--ORD-3505
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        |
| DARA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DARU1 | agency.admin | DARA1        |
And logged in with details of 'DARU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU5_1                     |
And save own Delivery Setting
And fill following fields for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU5_2                     |
And fill following fields for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU5_1                     |
Then I should see auto complete default email notifications count '1' for Delivery Setting form on user delivery setting page

Scenario: check default email recipient in the mailbox
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name  | A4User        |
| DARA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DARU1 | agency.admin | DARA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DARA1':
| Advertiser | Brand  | Sub Brand | Product |
| DARAR2     | DARBR2 | DARSB2    | DARPR2  |
And logged in with details of 'DARU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | DARAR2     | DARBR2 | DARSB2    | DARPR2  | DARC6    | DARCN6       | 20       | 10/14/2022     | HD 1080i 25fps | DART6 | Already Supplied   | BSkyB Green Button:Standard |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Email Notifications |
| DARU6                       |
And save own Delivery Setting
And go to Order Proceed page for order contains order item with following clock number 'DARCN6'
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| DARJN6     | DARPN6    |
And confirm order on Order Proceed page
Then I 'should' see email notification for 'Order Confirmation' with field to 'DARU1' and subject 'Order Confirmation:' contains following attributes:
| Account Type | UserName | Clock Number | Job Number | PO Number |
| adstream     | DARU1    | DARCN6       | DARJN6     | DARPN6    |
