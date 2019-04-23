!--ORD-3727
!--ORD-3860
Feature: Labels to manage visibility of Additional Services
Narrative:
In order to:
As a AgencyAdmin
I want to check labels to manage visibility of Additional Services

Scenario: Check that Dubbing Services label is displayed in BU details by defualt
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| LTMVASA1 | DefaultA4User |
Then I should see for agency 'LTMVASA1' following data:
| Labels           |
| dubbing_services |

Scenario: Check that Additional Services section is not displayed if Dubbing Services and Production Services labels aren't specified
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| LTMVASA1 | DefaultA4User |
And updated the following agency:
| Name     | Labels |
| LTMVASA1 |        |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| LTMVASU2 | agency.admin | LTMVASA1     |
And logged in with details of 'LTMVASU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| LTMVASCN2    |
When I open order item with following clock number 'LTMVASCN2'
Then I 'should not' see following sections 'Additional Services' on order item page

Scenario: Check that only Dubbing Services is avaialable in Additional Services section if only Dubbing Services label is specified in BU details
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| LTMVASA3 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| LTMVASU3 | agency.admin | LTMVASA3     |
And logged in with details of 'LTMVASU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| LTMVASCN3    |
When I open order item with following clock number 'LTMVASCN3'
Then I 'should' see 'Dubbing' services switcher for order item on Additional Services section
And 'should not' see 'Production' services switcher for order item on Additional Services section

Scenario: Check that only Production Services is avaialable in Additional Services section if only Production Services label is specified in BU details
Meta: @ordering
!-- This scenario is failing due to FAB-326
Given I created the following agency:
| Name     | A4User        |
| LTMVASA4 | DefaultA4User |
And updated the following agency:
| Name     | Labels              |
| LTMVASA4 | production_services |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| LTMVASU4 | agency.admin | LTMVASA4     |
And logged in with details of 'LTMVASU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| LTMVASCN4    |
When I open order item with following clock number 'LTMVASCN4'
Then I 'should' see 'Production' services switcher for order item on Additional Services section
And 'should not' see 'Dubbing' services switcher for order item on Additional Services section

Scenario: Check that both Dubbing Services and Production Services are avaialable in Additional Services section if Production Services and Dubbing Services labels are specified in BU details
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Labels              |
| LTMVASA5 | DefaultA4User | production_services |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| LTMVASU5 | agency.admin | LTMVASA5     |
And logged in with details of 'LTMVASU5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| LTMVASCN5    |
When I open order item with following clock number 'LTMVASCN5'
Then I 'should' see 'Dubbing' services switcher for order item on Additional Services section
And 'should' see 'Production' services switcher for order item on Additional Services section

Scenario: Check that Dubbing Services is selected by default in Additional Services section if Production Services and Dubbing Services labels are specified in BU details
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Labels              |
| LTMVASA5 | DefaultA4User | production_services |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| LTMVASU5 | agency.admin | LTMVASA5     |
And logged in with details of 'LTMVASU5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| LTMVASCN6    |
When I open order item with following clock number 'LTMVASCN6'
Then I 'should' see that 'Dubbing' services switcher is selected for order item on Additional Services section
And 'should not' see that 'Production' services switcher is selected for order item on Additional Services section