Feature: Default market setting
Narrative:
In order to:
As a AgencyAdmin
I want to check a correct default market settings for music orders

Scenario: check default market settings for music order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMDMSA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMDMSU1 | agency.admin | OMDMSA1     |
And logged in with details of 'OMDMSU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Default Market |
| <Market>       |
And save own Delivery Setting
And go to View Draft Orders tab of 'music' order on ordering page
And create 'music' order on View Draft Orders tab on ordering page
Then I should see selected following market '<Market>' on order item page

Examples:
| Market              |
| United Kingdom      |
| Republic of Ireland |
| Australia           |