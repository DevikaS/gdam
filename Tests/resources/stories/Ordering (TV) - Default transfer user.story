!--ORD-2779
!--ORD-3328
Feature: Default transfer user
Narrative:
In order to:
As a AgencyAdmin
I want to check default transfer user

Scenario: Check that user specified in Default Transfer User is displayed in Transfer To field on Transfer Order popup
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DTUA1_1 | DefaultA4User |
| DTUA1_2 | DefaultA4User |
And added agency 'DTUA1_2' as a partner to agency 'DTUA1_1'
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DTUU1_1 | agency.admin | DTUA1_1      |
| DTUU1_2 | agency.admin | DTUA1_2      |
And logged in with details of 'DTUU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DTUCN1       |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Transfer User |
| DTUU1_2               |
And save own Delivery Setting
And go to View Draft Orders tab of 'tv' order on ordering page
And select order with following item clock number 'DTUCN1' in 'draft' order list
And open Transfer Order form on ordering page
Then I should see following data on Transfer Order form on ordering page:
| Transfer to |
| DTUU1_2     |

Scenario: Check that updated user specified in Default Transfer User is displayed in Transfer To field on Transfer Order popup
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DTUA1_1 | DefaultA4User |
| DTUA1_2 | DefaultA4User |
And added agency 'DTUA1_2' as a partner to agency 'DTUA1_1'
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DTUU1_1 | agency.admin | DTUA1_1      |
| DTUU1_2 | agency.admin | DTUA1_2      |
| DTUU2_1 | agency.admin | DTUA1_2      |
And logged in with details of 'DTUU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DTUCN2       |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Transfer User |
| DTUU1_2               |
And save own Delivery Setting
And fill following fields for Delivery Setting form on user delivery setting page:
| Default Transfer User |
| DTUU2_1               |
And save own Delivery Setting
And go to View Draft Orders tab of 'tv' order on ordering page
And select order with following item clock number 'DTUCN2' in 'draft' order list
And open Transfer Order form on ordering page
Then I should see following data on Transfer Order form on ordering page:
| Transfer to |
| DTUU2_1     |

Scenario: Check that transfer order works for Default Transfer user
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DTUA1_1 | DefaultA4User |
| DTUA1_2 | DefaultA4User |
And added agency 'DTUA1_2' as a partner to agency 'DTUA1_1'
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DTUU1_1 | agency.admin | DTUA1_1      |
| DTUU1_2 | agency.user  | DTUA1_2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DTUA1_1':
| Advertiser | Brand  | Sub Brand | Product |
| DTUAR1     | DTUBR1 | DTUSB1    | DTUPR1  |
And logged in with details of 'DTUU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | DTUAR1     | DTUBR1 | DTUSB1    | DTUPR1  | DTUC3    | DTUCN3       | 20       | 10/14/2022     | HD 1080i 25fps | DTUT3 | Already Supplied   | BSkyB Green Button:Standard |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Transfer User |
| DTUU1_2               |
And save own Delivery Setting
And go to View Draft Orders tab of 'tv' order on ordering page
And select order with following item clock number 'DTUCN3' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Message                   |
| autotest transfer message |
And click Send button on Transfer Order form on ordering page
And login with details of 'DTUU1_2'
And open order item with following clock number 'DTUCN3'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required |
| automated test info    | DTUAR1     | DTUBR1 | DTUSB1    | DTUPR1  | DTUC3    | DTUCN3       | 20       | 10/14/2022     | HD 1080i 25fps | DTUT3 | Already Supplied   |
And 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard           |
| BSkyB Green Button |

Scenario: Check validation of Default Transfer User field
!--ORD-3334
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DTUA1_1 | DefaultA4User |
| DTUA1_2 | DefaultA4User |
And added agency 'DTUA1_2' as a partner to agency 'DTUA1_1'
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DTUU1_1 | agency.admin | DTUA1_1      |
| DTUU1_2 | agency.admin | DTUA1_2      |
And logged in with details of 'DTUU1_1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Transfer User |
| DTUU1_4@test.com      |
And save own Delivery Setting
Then I should see message error 'Default Transfer User is incorrect'

Scenario: Check that user from partner agency specified in Default Transfer User isn't displayed in Transfer To field on Transfer Order popup if partner agency has been removed
!--ORD-3298
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DTUA5_1 | DefaultA4User |
| DTUA5_2 | DefaultA4User |
And added agency 'DTUA5_2' as a partner to agency 'DTUA5_1'
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DTUU5_1 | agency.admin | DTUA5_1      |
| DTUU5_2 | agency.admin | DTUA5_2      |
And logged in with details of 'DTUU5_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DTUCN5       |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Transfer User |
| DTUU5_2               |
And save own Delivery Setting
When I login as 'GlobalAdmin'
And remove agency 'DTUA5_2' from partners of agency 'DTUA5_1'
And login with details of 'DTUU5_1'
And go to View Draft Orders tab of 'tv' order on ordering page
And select order with following item clock number 'DTUCN5' in 'draft' order list
And open Transfer Order form on ordering page
Then I should see following data on Transfer Order form on ordering page:
| Transfer to |
|            |