!--ORD-5121
Feature: Synchronization AU markets from A4
Narrative:
In order to:
As a GlobalAdmin
I want to check synchronization AU markets from A4

Scenario: Check that AU Markets are displayed on Metadata page after selection BU with AU label
Meta: @ordering
Given I created the following agency:
| Name   | A4User                | Labels | A4 Agency Id                         |
| SAUMA1 | karan@adstream.com.ua | au     | FD06232F-BE42-4422-BA46-A581061299BA |
And I am on the global 'common ordering' metadata page for agency 'SAUMA1'
Then I 'should' see available following markets 'Inflight Entertainment,Entertainment Venues,New Zealand,All Regional' on the global common ordering metadata page
When I go to the global 'common traffic' metadata page for agency 'SAUMA1'
Then I 'should' see available following markets 'Inflight Entertainment,Entertainment Venues,New Zealand,All Regional' on the global common traffic metadata page

Scenario: Check AU Markets are displayed in Market field after changing Type to TV Broadcast on BU details for BU with AU label
Meta: @ordering
Given I created the following agency:
| Name   | A4User                | Labels | A4 Agency Id                         |
| SAUMA2 | karan@adstream.com.ua | au     | FD06232F-BE42-4422-BA46-A581061299BA |
And filled following fields for agency 'SAUMA2' on Edit agency popup:
| FieldName | FieldValue     |
| Type      | TV Broadcaster |
Then I 'should' see following values 'Inflight Entertainment,Entertainment Venues,New Zealand,All Regional' for field 'Market' on Edit agency popup

Scenario: Check that AU markets are available in case to create order by agency user from BU with AU label
Meta: @ordering
Given I created the following agency:
| Name   | A4User                | Labels | A4 Agency Id                         |
| SAUMA3 | karan@adstream.com.ua | au     | FD06232F-BE42-4422-BA46-A581061299BA |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| SAUMU3 | agency.admin | SAUMA3       |
And logged in with details of 'SAUMU3'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
Then I 'should' see available following markets 'Inflight Entertainment,Entertainment Venues,New Zealand,All Regional' on Select market popup on order item page
