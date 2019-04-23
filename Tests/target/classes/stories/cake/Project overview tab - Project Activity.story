!--NGN-34
Feature:          Project overview tab - Project Activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check project activity on project overview
Meta:
@cake

Scenario: Check that 'create project' is displayed on Project Last activities with filter in project overview
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And I logged in as 'AgencyAdmin'
When I go to project 'POTP2' overview page
And I type an userName 'POTU2' on project overview page for project
And I set Action 'created project' on project overview page for project
And click on filter button on project overview page
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'created project' and value 'POTP2'
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'copied file from "POTP2/F1" to "POTP2/F2"' and value '/F1/logo.png'
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'moved file from "POTP2/F1" to "POTP2/F3"' and value '/F3/logo.png'