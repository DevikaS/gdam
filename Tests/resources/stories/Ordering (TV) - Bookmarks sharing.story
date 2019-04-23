!--ORD-3916
!--ORD-4677
Feature: Make bookmarks appear in all users within BU
Narrative:
In order to:
As a AgencyAdmin
I want to check Bookmarks sharing

Scenario: Check correct saving of Bookmarks while sharing it
Meta: @ordering
Given I created the following agency:
| Name | A4User        |
| BSA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| BSU1  | agency.admin | BSA1         |
And logged in with details of 'BSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| BSCN1        |
When I open order item with following clock number 'BSCN1'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           | Express   |
| BSkyB Green Button | PTV Prime |
And fill following fields for Bookmark stations form of Select Broadcast Destinations section on order item page:
| Name  | Make Bookmark Available To All BU Users |
| BSBN1 | should                                  |
And bookmark selected station list on Bookmark stations form of Select Broadcast Destinations section
Then I 'should not' see Bookmark stations form of Select Broadcast Destinations section on order item page
And 'should' see following bookmark 'BSBN1' on Select a pre-set you wish to load form of Select Broadcast Destinations section

Scenario: Check that another user within the same BU will have shared bookmark available
Meta: @ordering
Given I created the following agency:
| Name | A4User        |
| BSA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| BSU2_1 | agency.admin | BSA2         |
| BSU2_2 | agency.admin | BSA2         |
And logged in with details of 'BSU2_1'
And create bookmark for order with market 'United Kingdom' with following fields:
| Name  | Destination                                   | Make Bookmark Available To All BU Users |
| BSBN2 | BSkyB Green Button:Standard;PTV Prime:Express | should                                  |
And logged in with details of 'BSU2_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| BSCN2        |
When I open order item with following clock number 'BSCN2'
Then I 'should' see following bookmark 'BSBN2' on Select a pre-set you wish to load form of Select Broadcast Destinations section

Scenario: Check that only bookmark creator could delete his shared bookmark
Meta: @ordering
Given I created the following agency:
| Name | A4User        |
| BSA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| BSU2_1 | agency.admin | BSA2         |
| BSU2_2 | agency.admin | BSA2         |
And logged in with details of 'BSU2_1'
And create bookmark for order with market 'United Kingdom' with following fields:
| Name  | Destination                                   | Make Bookmark Available To All BU Users |
| BSBN3 | BSkyB Green Button:Standard;PTV Prime:Express | should                                  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| BSCN3        |
When I open order item with following clock number 'BSCN3'
Then I 'should' see Remove icon for following bookmark 'BSBN3' on Select a pre-set you wish to load form of Select Broadcast Destinations section
When I login with details of 'BSU2_2'
And open order item with following clock number 'BSCN3'
Then I 'should not' see Remove icon for following bookmark 'BSBN3' on Select a pre-set you wish to load form of Select Broadcast Destinations section