Feature:          A5 Dashboard - activity cake
Narrative:
In order to
As a              AgencyAdmin
I want to         Check expand menu for Dashboard

Meta:

Scenario: check that at Activities display no activities if user try to filter by action type
Given I created the agency 'A_A5DA_S02' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_A5DA_S02 | agency.admin | A_A5DA_S02   |
And logged in with details of 'U_A5DA_S02'
And created '<ProjectName>' project
When I go to Dashboard page
And wait while transcoding is finished in collection 'My Assets'
And I set Action 'Cloned project' on Dashboard Page
And I maximize 'recent activity' section on Dashboard page
And click link 'Filter' on Dashboard Page
Then I 'should' see expanded section 'Recent Activity' on Dashboard page
And 'should' see text 'You have no activities' for expanded section 'Recent Activity' on Dashboard page
Examples:
| ProjectName  |
| P_A5DA_S02_1 |


Scenario: check that at Activities display 'project created' if user filters by username
Given I logged in with details of 'U_A5DA_S02'
When I go to Dashboard page
And refresh the page
And I set Action 'Created project' on Dashboard Page
And I type an userName 'U_A5DA_S02' on activity filter Dashboard Page
And I maximize 'recent activity' section on Dashboard page
And click link 'Filter' on Dashboard Page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName   | Message          | Value        |
| U_A5DA_S02 | created project  | <ProjectName>|
Examples:
| ProjectName  |
| P_A5DA_S02_1 |