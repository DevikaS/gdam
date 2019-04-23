Feature:          Project Owner can see Activity when user accepts TnC
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that project owner can see activity when user accepts TnC


Scenario: Check that after share user accepts TnC, Project Owner can see Activity - User has accepted TnC on project overview page
Meta:@gdam
@projects
Given I created the agency 'POCSAWUATC_A1' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| POCSAWUATC_E1 | agency.admin | POCSAWUATC_A1 |
| POCSAWUATC_E2 | agency.user  | POCSAWUATC_A1 |
| POCSAWUATC_E3 | agency.user  | POCSAWUATC_A1 |
And logged in with details of 'POCSAWUATC_E1'
And added users 'POCSAWUATC_E2,POCSAWUATC_E3' to Address book
And I am on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue    |
| Name               | POCSAWUATC_P1 |
| Media type         | Broadcast     |
| Start date         | Today         |
| End date          | Tomorrow      |
| Terms & Conditions | test          |
And accept agency Terms and Conditions
When I edit the following fields for 'POCSAWUATC_P1' project:
| Name          | Administrators |
| POCSAWUATC_P1 | POCSAWUATC_E2  |
And click on element 'SaveButton'
And edit the following fields for 'POCSAWUATC_P1' project:
| Name          | Administrators |
| POCSAWUATC_P1 | POCSAWUATC_E3  |
And click on element 'SaveButton'
And refresh the page
And login with details of 'POCSAWUATC_E2'
And go to project list page
And I click by project name 'POCSAWUATC_P1'
And accept agency Terms and Conditions
And login with details of 'POCSAWUATC_E3'
And go to project list page
And I click by project name 'POCSAWUATC_P1'
And accept agency Terms and Conditions
Then I 'should' see activity for user 'POCSAWUATC_E2' on project 'POCSAWUATC_P1' overview page with message 'accepted project' and value 'Terms & Conditions Terms and Conditions'


Scenario: Check that after project owner accepts TnC, Project creator can see Activity on dashboard
Meta:@gdam
@projects
Given I created the agency 'POCSAWUATC_A2' with default attributes
And created users with following fields:
| Email           | Role         | Agency        |
| POCSAWUATC_E2_1 | agency.admin | POCSAWUATC_A2 |
| POCSAWUATC_E2_2 | agency.user  | POCSAWUATC_A2 |
And logged in with details of 'POCSAWUATC_E2_1'
And added user 'POCSAWUATC_E2_2' to Address book
And I am on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue    |
| Name               | POCSAWUATC_P2 |
| Media type         | Broadcast     |
| Start date         | Today         |
| End date          | Tomorrow      |
| Terms & Conditions | test          |
And accept agency Terms and Conditions
And I edit the following fields for 'POCSAWUATC_P2' project:
| Name          | Administrators  |
| POCSAWUATC_P2 | POCSAWUATC_E2_2 |
And click on element 'SaveButton'
And refresh the page
And login with details of 'POCSAWUATC_E2_2'
And go to project list page
And I click by project name 'POCSAWUATC_P2'
And accept agency Terms and Conditions
And login with details of 'POCSAWUATC_E2_1'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName        | Message                             | Value                |
| POCSAWUATC_E2_2 | accepted project Terms & Conditions | Terms and Conditions |


Scenario: Check that after share user accepts TnC, Project owner can see Activity on team page
Meta:@gdam
@projects
Given I created the agency 'POCSAWUATC_A3' with default attributes
And created users with following fields:
| Email           | Role         | Agency        |
| POCSAWUATC_E3_1 | agency.admin | POCSAWUATC_A3 |
| POCSAWUATC_E3_2 | agency.user  | POCSAWUATC_A3 |
And logged in with details of 'POCSAWUATC_E3_1'
And added users 'POCSAWUATC_E3_1,POCSAWUATC_E3_2' to Address book
And I am on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue    |
| Name               | POCSAWUATC_P3 |
| Media type         | Broadcast     |
| Start date         | Today         |
| End date          | Tomorrow      |
| Terms & Conditions | test          |
And accept agency Terms and Conditions
When I edit the following fields for 'POCSAWUATC_P3' project:
| Name          | Administrators  |
| POCSAWUATC_P3 | POCSAWUATC_E3_2 |
And create '/PSF101' folder for project 'POCSAWUATC_P3'
And refresh the page
And go to project 'POCSAWUATC_P3' folder '/PSF101' page
And I open Share window from popup menu for folder '/PSF101' on project 'POCSAWUATC_P3'
And fill Share popup of project folder for user 'POCSAWUATC_E3_2' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And publish the project 'POCSAWUATC_P3'
And login with details of 'POCSAWUATC_E3_2'
And go to project list page
And I click by project name 'POCSAWUATC_P3'
And accept agency Terms and Conditions
And login with details of 'POCSAWUATC_E3_1'
And I go to project 'POCSAWUATC_P3' teams page
Then 'should' see activity for user 'POCSAWUATC_E3_2' on project team page with message 'accepted project' and value 'Terms & Conditions Terms and Conditions'