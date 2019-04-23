!--ORD-271
!--ORD-2276
Feature: Validation for transfered order
Narrative:
In order to:
As a AgencyAdmin
I want to check validation for transfered order

Scenario: check retrieve buttons state of New master after assign
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVVTOA1_1 | DefaultA4User |
| OTVVTOA1_2 | DefaultA4User |
And added agency 'OTVVTOA1_2' as a partner to agency 'OTVVTOA1_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVVTOU1_1 | agency.admin | OTVVTOA1_1   |
| OTVVTOU1_2 | agency.admin | OTVVTOA1_2   |
And logged in with details of 'OTVVTOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVVTOCN1    |
And add for 'tv' order to item with clock number 'OTVVTOCN1' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message        | Deadline Date |
| FTP        | OTVVTOU1_1 | should not       | automated test | 12/14/2022    |
And transfered order contains item with clock number 'OTVVTOCN1' to user 'OTVVTOU1_2' with following message 'autotest transfer message'
And logged in with details of 'OTVVTOU1_2'
And transfered order contains item with clock number 'OTVVTOCN1' to user 'OTVVTOU1_1' with following message 'autotest transfer message'
When I open order item with following clock number 'OTVVTOCN1'
Then I should see 'disabled' New master button for order item on Add media form
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form

Scenario: check visibility Transfer link for previous assignees
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVVTOA1_1 | DefaultA4User |
| OTVVTOA1_2 | DefaultA4User |
And added agency 'OTVVTOA1_2' as a partner to agency 'OTVVTOA1_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVVTOU1_1 | agency.admin | OTVVTOA1_1   |
| OTVVTOU1_2 | agency.admin | OTVVTOA1_2   |
And logged in with details of 'OTVVTOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVVTOCN2    |
And transfered order contains item with clock number 'OTVVTOCN2' to user 'OTVVTOU1_2' with following message 'autotest transfer message'
And logged in with details of 'OTVVTOU1_2'
And transfered order contains item with clock number 'OTVVTOCN2' to user 'OTVVTOU1_1' with following message 'autotest transfer message'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVVTOCN2' in 'draft' order list
Then I 'should not' see Transfer order button on ordering page

Scenario: check validation Transfer Order form
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVVTOA1_1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVVTOU1_1 | agency.admin | OTVVTOA1_1   |
And logged in with details of 'OTVVTOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVVTOCN3    |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVVTOCN3' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to      | Message                   |
| OTVVTOU1_3_email | autotest transfer message |
Then I should see 'disabled' Send button on Transfer Order form

Scenario: assignee shouldn't delete transfered order
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVVTOA1_1 | DefaultA4User |
| OTVVTOA1_2 | DefaultA4User |
And added agency 'OTVVTOA1_2' as a partner to agency 'OTVVTOA1_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVVTOU1_1 | agency.admin | OTVVTOA1_1   |
| OTVVTOU1_2 | agency.admin | OTVVTOA1_2   |
And logged in with details of 'OTVVTOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVVTOCN4    |
And transfered order contains item with clock number 'OTVVTOCN4' to user 'OTVVTOU1_2' with following message 'autotest transfer message'
And logged in with details of 'OTVVTOU1_2'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVVTOCN4' in 'draft' order list
Then I 'should not' see Delete order button on ordering page

Scenario: creator can delete transfered order
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVVTOA1_1 | DefaultA4User |
| OTVVTOA1_2 | DefaultA4User |
And added agency 'OTVVTOA1_2' as a partner to agency 'OTVVTOA1_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVVTOU1_1 | agency.admin | OTVVTOA1_1   |
| OTVVTOU1_2 | agency.admin | OTVVTOA1_2   |
And logged in with details of 'OTVVTOU1_1'
And create 'tv' order with market 'Australia' and items with following fields:
| Clock Number |
| OTVVTOCN5    |
And transfered order contains item with clock number 'OTVVTOCN5' to user 'OTVVTOU1_2' with following message 'autotest transfer message'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVVTOCN5' in 'draft' order list
And delete selected order in order list
Then I 'should not' see orders with following markets 'Australia' in 'draft' order list

Scenario: creator should have possibility to transfer order to yourself after assign it to another
!--ORD-2868
Meta: @ordering
      @obug
!--BugRef-FAB-718
Given I created the following agency:
| Name       | A4User        |
| OTVVTOA1_1 | DefaultA4User |
| OTVVTOA1_2 | DefaultA4User |
And added agency 'OTVVTOA1_2' as a partner to agency 'OTVVTOA1_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVVTOU1_1_email | agency.admin | OTVVTOA1_1   |
| OTVVTOU1_2       | agency.admin | OTVVTOA1_2   |
And logged in with details of 'OTVVTOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVVTOCN6    |
And transfered order contains item with clock number 'OTVVTOCN6' to user 'OTVVTOU1_2' with following message 'autotest transfer message'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVVTOCN6' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to      | Message                   |
| OTVVTOU1_1_email | autotest transfer message |
Then I should see 'enabled' Send button on Transfer Order form

Scenario: Check that draft order cannot be transferred to user without access to Delivery application
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVVTOA1_1 | DefaultA4User |
| OTVVTOA1_2 | DefaultA4User |
And added agency 'OTVVTOA1_2' as a partner to agency 'OTVVTOA1_1'
And created users with following fields:
| Email            | Role         | AgencyUnique | Access                          |
| OTVVTOU1_1       | agency.admin | OTVVTOA1_1   | folders,adkits,library,ordering |
| OTVVTOU1_7_email | agency.admin | OTVVTOA1_2   | folders,adkits,library          |
And logged in with details of 'OTVVTOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVVTOCN7    |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVVTOCN7' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to      | Message                   |
| OTVVTOU1_7_email | autotest transfer message |
Then I should see 'disabled' Send button on Transfer Order form

Scenario: Check that Delivery tab is visible for user without access to Delivery application
!--ORD-4256
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVTOA8 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique | Access                 |
| OTVVTOU8 | agency.admin | OTVVTOA8     | folders,adkits,library |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVTOA8':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVVTOAR8  | OTVVTOBR8 | OTVVTOSB8 | OTVVTOPR8 |
And logged in with details of 'OTVVTOU8'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVVTOAR8  | OTVVTOBR8 | OTVVTOSB8 | OTVVTOPR8 | OTVVTOC8 | OTVVTOCN8    | 20       | 10/14/2022     | HD 1080i 25fps | OTVVTOT8 | Adtext             | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVVTOCN8' with following fields:
| Job Number | PO Number |
| OTVVTOJN8  | OTVVTOPN8 |
When I go to asset 'OTVVTOT8' destinations info page in Library for collection 'My Assets'
And I wait for '5' seconds
Then I should see following data for destination of order with item clock number 'OTVVTOCN8' on assets destinations info page in Library:
| Order # | Destination        | Date Ordered  | Ordered by | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | OTVVTOU8   | Order Placed |

Scenario: Check that draft order cannot be transferred to user of agency which hasn't Delivery application enabled in
!--ORD-4300
Meta: @ordering
      @obug
!--BugRef-FAB-719
Given I created the following agency:
| Name       | A4User        | Application Access              |
| OTVVTOA9_1 | DefaultA4User | folders,adkits,library,ordering |
| OTVVTOA9_2 | DefaultA4User | folders,adkits,library          |
And added agency 'OTVVTOA9_2' as a partner to agency 'OTVVTOA9_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVVTOU9_1       | agency.admin | OTVVTOA9_1   |
| OTVVTOU9_2_email | agency.admin | OTVVTOA9_2   |
And logged in with details of 'OTVVTOU9_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVVTOCN9    |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVVTOCN9' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to      | Message                   |
| OTVVTOU9_2_email | autotest transfer message |
Then I should see 'disabled' Send button on Transfer Order form