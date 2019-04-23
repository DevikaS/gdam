!--NGN-13139
Feature:          Project overview tab - Project Activity Filter
Narrative:
In order to
As a              AgencyAdmin
I want to         Check project activity filter on project overview

Scenario: Check that project activities are filtered by action and username
Meta:@gdam
@projects
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And I logged in as 'AgencyAdmin'
And waited for '3' seconds
When I go to project 'POTP2' overview page
And I type an userName 'POTU2' on project overview page for project
And I set Action 'Created project' on project overview page for project
When I click on filter button on project overview page
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'created project' and value 'POTP2'


Scenario: Check that filter can be reset
Meta:@gdam
@projects
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators
| POTP2 | POTJ2      | AgencyAdmin    |
And I logged in as 'AgencyAdmin'
And waited for '3' seconds
When I go to project 'POTP2' overview page
And I type an userName 'POTU2' on project overview page for project
And I set Action 'Created project' on project overview page for project
And I reset an userName on project overview page for project
And I set Action ' All ' on project overview page for project
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'created project' and value 'POTP2'


Scenario: Check that project activities are sorted on Project overview
Meta:@gdam
@projects
Given I created following users:
| User Name |
| POTU1_1   |
And I created 'POTP1' project
And created '/F1' folder for project 'POTP1'
And I logged in with details of 'POTU1_1'
And uploaded into project 'POTP1' following files:
| FileName                   | Path |
| /files/filetext.txt        | /F1  |
| /files/video10s.avi        | /F1  |
And waited while transcoding is finished in folder '/F1' on project 'POTP1' files page
When I go to project 'POTP1' overview page
Then I should see following activities are sorted on project 'POTP1' overview page:
| UserName     | Message                            | Value                        |
| POTU1_1      | uploaded 1 files video10s.avi      | POTP1/POTP1/F1/video10s.avi  |
| POTU1_1      | uploaded 1 files filetext.txt      | POTP1/POTP1/F1/filetext.txt  |
| AgencyAdmin  | created folder                     | F1                           |
| AgencyAdmin  | shared folder                      | POTP1                        |
| AgencyAdmin  | published project                  | POTP1                        |
| AgencyAdmin  | created project                    | POTP1                        |


Scenario: Check that project activity filter display user from address book
Meta:@gdam
@projects
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And I added user 'POTU2' to Address book
And I logged in as 'AgencyAdmin'
And waited for '3' seconds
When I go to project 'POTP2' overview page
Then I should be able to enter the following users in project activity filter:
| UserName             |
| POTU2                |


Scenario: Check that project activity could be filtered by user (user from another BU make some activity)
Meta:@gdam
@projects
Given I created users with following fields:
| Email   | Role       | Agency       |
| <email> | <roleName> | <agencyName> |
And I logged in with details of '<email>'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
When I go to project 'POTP2' overview page
And I type an userName '<email>' on project overview page for project
And I set Action 'Created project' on project overview page for project
When I click on filter button on project overview page
Then I 'should' see activity for user '<email>' on project 'POTP2' overview page with message 'created project' and value 'POTP2'
Examples:
| email     | roleName     | agencyName    |
| ACLVAU5_1 | agency.admin | AnotherAgency |

