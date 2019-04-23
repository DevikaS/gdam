Feature: Create Project in another Business Unit
Narrative:
In order to work with the system
As a AgencyAdmin
I want to Create Project in another Business Unit


Scenario: Check that agency/guest user could create project in another BU
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role          | Agency        |
| U_ACTA_S01_1 | agency.admin  | DefaultAgency |
| U_ACTA_S01_2 | agency.admin  | AnotherAgency |
| <UserEmail>  | <UserRole>    | AnotherAgency |
And added agency 'AnotherAgency' as a partner to agency 'DefaultAgency'
And logged in with details of 'U_ACTA_S01_2'
And I created '<GlobalRole>' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission            |
| element.read          |
| folder.read           |
| project.create        |
| project.write         |
| project.read          |
And created following categories:
| Name           |
| <CategoryName> |
And logged in with details of 'U_ACTA_S01_1'
And created following categories:
| Name           |
| <CategoryName> |
And I added next users for following categories:
| CategoryName   | UserName     | RoleName      |
| <CategoryName> | <UserEmail>  | library.admin  |
And I edited user '<UserEmail>' with following fields:
| Role          |
| <GlobalRole>  |
And logged in with details of '<UserEmail>'
When I go to Create New Project page
And I fill the following fields for project:
| Name           | Business Unit    |
| <ProjectName>  | DefaultAgency    |
And click Save button on project popup
And wait for '5' seconds
And go to Project list page
Then I should see '<ProjectName>' project in project list

Examples:
| UserEmail    | UserRole    | ProjectName  | GlobalRole   | CategoryName |
| U_ACTA_S01_3 | guest.user  | P_ACTA_S01_1 | R_ACTA_S01_1 | C_ACTA_S01_1 |
| U_ACTA_S01_4 | agency.user | P_ACTA_S01_2 | R_ACTA_S01_2 | C_ACTA_S01_2 |


Scenario: Check that agency/guest user could create work request in another BU
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role          | Agency        |
| U_ACTA_S02_1 | agency.admin  | DefaultAgency |
| U_ACTA_S02_2 | agency.admin  | AnotherAgency |
| <UserEmail>  | <UserRole>    | AnotherAgency |
And added agency 'AnotherAgency' as a partner to agency 'DefaultAgency'
And logged in with details of 'U_ACTA_S02_2'
And I created '<GlobalRole>' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission            |
| element.read          |
| folder.read           |
| adkit.create          |
| adkit.write           |
| adkit.read            |
| adkit.complete        |
| project.create        |
| project.write         |
| project.read          |
And created following categories:
| Name           |
| <CategoryName> |
And logged in with details of 'U_ACTA_S02_1'
And created following categories:
| Name           |
| <CategoryName> |
And I added next users for following categories:
| CategoryName   | UserName     | RoleName      |
| <CategoryName> | <UserEmail>  | library.admin  |
And I edited user '<UserEmail>' with following fields:
| Role          |
| <GlobalRole>  |
And logged in with details of '<UserEmail>'
When I create new work request with following fields:
| FieldName  | FieldValue     |
| Name       | <ProjectName> |
| Media type | Broadcast      |
| Start date | 5 days ago     |
| End date   | 5 days since   |
And I go to work request list page
Then I 'should' see following work request '<ProjectName>' in work request list

Examples:
| UserEmail    | UserRole    | ProjectName  | GlobalRole   | CategoryName |
| U_ACTA_S02_3 | agency.user | W_ACTA_S02_1 | R_ACTA_S02_1 | C_ACTA_S02_1 |
| U_ACTA_S02_4 | agency.user | W_ACTA_S02_2 | R_ACTA_S02_2 | C_ACTA_S02_2 |


Scenario: Check that user can create project in other BU, if project schema of current BU contain radio-button,dropdown and catalog group and schema of another BU not(NGN-11601)
Meta: @gdam
@projects
Given I created the agency 'A_UWPCCPIABU_S03_1' with default attributes
And created following 'common' custom metadata fields for agency 'A_UWPCCPIABU_S03_1':
| FieldType          | Description            | Choices                                         |
| RadioButtons       | RBF UWPCCPIABU S03 1   | RBFV UWPCCPIABU S03 1 1,RBFV UWPCCPIABU S03 1 2 |
| Dropdown           | DDF UWPCCPIABU S03 1   | DDFV UWPCCPIABU S03 1 1,DDFV UWPCCPIABU S03 1 2 |
| catalogueStructure | DDF UWPCCPIABU S03 1   | DDFV UWPCCPIABU S03 1 1,DDFV UWPCCPIABU S03 1 2 |
And I created the agency 'A_UWPCCPIABU_S03_2' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |
| U_UWPCCPIABU_S03_1 | agency.admin  | A_UWPCCPIABU_S03_1 |
| U_UWPCCPIABU_S03_2 | agency.admin  | A_UWPCCPIABU_S03_2 |
And added agency 'A_UWPCCPIABU_S03_1' as a partner to agency 'A_UWPCCPIABU_S03_2'
And logged in with details of 'U_UWPCCPIABU_S03_1'
And created following categories:
| Name               |
| C_UWPCCPIABU_S03   |
And logged in with details of 'U_UWPCCPIABU_S03_2'
And created following categories:
| Name             |
| C_UWPCCPIABU_S03 |
And I added next users for following categories:
| CategoryName      | UserName           | RoleName      |
| C_UWPCCPIABU_S03  | U_UWPCCPIABU_S03_1 | library.admin |
And edited for user 'U_UWPCCPIABU_S03_1' agency role 'Administrator'
And waited for '3' seconds
And logged in with details of 'U_UWPCCPIABU_S03_1'
When I go to Create New Project page
And I fill the following fields for project:
| Name                  | Business Unit      |
| P_UWPCCPIABU_S03     | A_UWPCCPIABU_S03_2 |
And click Save button on project popup
And go to Project list page
Then I should see 'P_UWPCCPIABU_S03' project in project list


Scenario: Check that Project created for another agency with radio button/DropDown or Catalog group,could be edited by creator (NGN-11632)
Meta: @gdam
@projects
Given I created the agency 'A_UWPCCPIABU_S04_1' with default attributes
And created following 'common' custom metadata fields for agency 'A_UWPCCPIABU_S04_1':
| FieldType          | Description            | Choices                                         |
| Dropdown           | DDF UWPCCPIABU S04 1   | DDFV UWPCCPIABU S03 1 1,DDFV UWPCCPIABU S04 1 2 |
| catalogueStructure | DDF UWPCCPIABU S04 1   | DDFV UWPCCPIABU S03 1 1,DDFV UWPCCPIABU S04 1 2 |
And I created the agency 'A_UWPCCPIABU_S04_2' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |
| U_UWPCCPIABU_S04_1 | agency.admin  | A_UWPCCPIABU_S04_1 |
| U_UWPCCPIABU_S04_2 | agency.admin  | A_UWPCCPIABU_S04_2 |
And added agency 'A_UWPCCPIABU_S04_1' as a partner to agency 'A_UWPCCPIABU_S04_2'
And logged in with details of 'U_UWPCCPIABU_S04_1'
And created following categories:
| Name               |
| C_UWPCCPIABU_S04   |
And logged in with details of 'U_UWPCCPIABU_S04_2'
And created following categories:
| Name             |
| C_UWPCCPIABU_S04 |
And I added next users for following categories:
| CategoryName      | UserName           | RoleName      |
| C_UWPCCPIABU_S04  | U_UWPCCPIABU_S04_1 | library.admin |
And edited for user 'U_UWPCCPIABU_S04_1' agency role 'Business Unit Admin'
And logged in with details of 'U_UWPCCPIABU_S04_1'
And created following projects:
| Name                  | Business Unit      |
| P_UWPCCPIABU_S04      | A_UWPCCPIABU_S04_2 |
When I open project 'P_UWPCCPIABU_S04' settings page
And I edit the following fields for 'P_UWPCCPIABU_S04' project:
| Name                  |
| P_UWPCCPIABU_S04_EDIT |
And click on element 'SaveButton'
And go to Project list page
Then I should see 'P_UWPCCPIABU_S04_EDIT' project in project list


Scenario: Check that user can accept T&C for project which was created by user from another BU
Meta: @gdam
@projects
Given I created the agency 'A_UWPCCPIABU_S05_1' with default attributes
And I created the agency 'A_UWPCCPIABU_S05_2' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |
| U_UWPCCPIABU_S05_1 | agency.admin  | A_UWPCCPIABU_S05_1 |
| U_UWPCCPIABU_S05_2 | agency.admin  | A_UWPCCPIABU_S05_2 |
And added agency 'A_UWPCCPIABU_S05_1' as a partner to agency 'A_UWPCCPIABU_S05_2'
And logged in with details of 'U_UWPCCPIABU_S05_1'
And I am on the T&C page
And enabled current terms and conditions for projects on opened T&C page
And created following categories:
| Name             |
| C_UWPCCPIABU_S05 |
And I added next users for following categories:
| CategoryName     | UserName           | RoleName       |
| C_UWPCCPIABU_S05 | U_UWPCCPIABU_S05_2 | library.admin  |
And edited for user 'U_UWPCCPIABU_S05_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UWPCCPIABU_S05_2'
When create new project with following fields:
| FieldName          | FieldValue       |
| Business Unit      | A_UWPCCPIABU_S05_1 |
| Name               | P_UWPCCPIABU_S05 |
| Media type         | Broadcast        |
| Start date         | Today            |
| End date           | Tomorrow         |
| Terms & Conditions | test             |
And accept agency Terms and Conditions
And go to Project list page
Then I should see 'P_UWPCCPIABU_S05' project in project list
When I login with details of 'U_UWPCCPIABU_S05_1'
And go to Project list page
And I click by project name 'P_UWPCCPIABU_S05'
Then I 'should' see agency Terms and Conditions text 'test' on opened Terms and Conditions popup

Scenario: Check that values for dropdowns/catalog group from another BU are picked up at Create Project page
Meta: @gdam
@projects
Given I created the agency 'A_UWPCCPIABU_S06_1' with default attributes
And created following 'common' custom metadata fields for agency 'A_UWPCCPIABU_S06_1':
| FieldType          | Description            | Choices                                         |
| RadioButtons       | RBF UWPCCPIABU S06 1   | RBFV UWPCCPIABU S06 1 1,RBFV UWPCCPIABU S06 1 2 |
| Dropdown           | DDF UWPCCPIABU S06 1   | DDFV UWPCCPIABU S06 1 1,DDFV UWPCCPIABU S06 1 2 |
| catalogueStructure | CS UWPCCPIABU S06 1    | CS UWPCCPIABU S06 1 1,CS UWPCCPIABU S06 1 2     |
And I created the agency 'A_UWPCCPIABU_S06_2' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |
| U_UWPCCPIABU_S06_1 | agency.admin  | A_UWPCCPIABU_S06_1 |
| U_UWPCCPIABU_S06_2 | agency.admin  | A_UWPCCPIABU_S06_2 |
And added agency 'A_UWPCCPIABU_S06_1' as a partner to agency 'A_UWPCCPIABU_S06_2'
And logged in with details of 'U_UWPCCPIABU_S06_1'
And created following categories:
| Name             |
| C_UWPCCPIABU_S06 |
And I added next users for following categories:
| CategoryName     | UserName           | RoleName       |
| C_UWPCCPIABU_S06 | U_UWPCCPIABU_S06_2 | library.admin  |
And edited for user 'U_UWPCCPIABU_S06_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UWPCCPIABU_S06_2'
When I go to Create New Project page
And I fill the following fields for project:
| Name                  | Business Unit      |
| P_UWPCCPIABU_S06      | A_UWPCCPIABU_S06_1 |
And I wait for '2' seconds
Then I should see on the current project popup that following fields contains values:
| FieldName            | FieldValue |
| RBF UWPCCPIABU S06 1 | RBFV UWPCCPIABU S06 1 1, RBFV UWPCCPIABU S06 1 2  |
| DDF UWPCCPIABU S06 1 | DDFV UWPCCPIABU S06 1 1, DDFV UWPCCPIABU S06 1 2  |
| CS UWPCCPIABU S06 1  | CS UWPCCPIABU S06 1 1,   CS UWPCCPIABU S06 1 2    |


Scenario: Check that values for dropdowns/catalog group from another BU are picked up at Work request page
Meta: @gdam
@projects
Given I created the agency 'A_UWPCCPIABU_S07_1' with default attributes
And created following 'common' custom metadata fields for agency 'A_UWPCCPIABU_S07_1':
| FieldType          | Description            | Choices                                         |
| RadioButtons       | RBF UWPCCPIABU S07 1   | RBFV UWPCCPIABU S07 1 1,RBFV UWPCCPIABU S07 1 2 |
| Dropdown           | DDF UWPCCPIABU S07 1   | DDFV UWPCCPIABU S07 1 1,DDFV UWPCCPIABU S07 1 2 |
| catalogueStructure | CS UWPCCPIABU S07 1    | CS UWPCCPIABU S07 1 1,CS UWPCCPIABU S07 1 2     |
And I created the agency 'A_UWPCCPIABU_S07_2' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |
| U_UWPCCPIABU_S07_1 | agency.admin  | A_UWPCCPIABU_S07_1 |
| U_UWPCCPIABU_S07_2 | agency.admin  | A_UWPCCPIABU_S07_2 |
And added agency 'A_UWPCCPIABU_S07_1' as a partner to agency 'A_UWPCCPIABU_S07_2'
And logged in with details of 'U_UWPCCPIABU_S07_1'
And created following categories:
| Name             |
| C_UWPCCPIABU_S07 |
And I added next users for following categories:
| CategoryName     | UserName           | RoleName       |
| C_UWPCCPIABU_S07 | U_UWPCCPIABU_S07_2 | library.admin  |
And edited for user 'U_UWPCCPIABU_S07_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UWPCCPIABU_S07_2'
When I open Create New Work Request popup
And I fill the following fields for work request:
| Name                  | Business Unit      |
| P_UWPCCPIABU_S07      | A_UWPCCPIABU_S07_1 |
And I wait for '2' seconds
Then I should see on the current project popup that following fields contains values:
| FieldName            | FieldValue                                      |
| RBF UWPCCPIABU S07 1 | RBFV UWPCCPIABU S07 1 1,RBFV UWPCCPIABU S07 1 2 |
| DDF UWPCCPIABU S07 1 | DDFV UWPCCPIABU S07 1 1,DDFV UWPCCPIABU S07 1 2 |
| CS UWPCCPIABU S07 1  | CS UWPCCPIABU S07 1 1,CS UWPCCPIABU S07 1 2     |


Scenario: Check that schema on create project page is related to selected BU
Meta: @gdam
@projects
Given I created the agency 'A_UWPCCPIABU_S08_1' with default attributes
And created following 'common' custom metadata fields for agency 'A_UWPCCPIABU_S08_1':
| FieldType          | Description            | Choices                                         |
| RadioButtons       | RBF UWPCCPIABU S08 1   | RBFV UWPCCPIABU S08 1 1,RBFV UWPCCPIABU S08 1 2 |
| Dropdown           | DDF UWPCCPIABU S08 1   | DDFV UWPCCPIABU S08 1 1,DDFV UWPCCPIABU S08 1 2 |
| catalogueStructure | CS UWPCCPIABU S08 1    | CS UWPCCPIABU S08 1 1,CS UWPCCPIABU S08 1 2     |
And I created the agency 'A_UWPCCPIABU_S08_2' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |
| U_UWPCCPIABU_S08_1 | agency.admin  | A_UWPCCPIABU_S08_1 |
| U_UWPCCPIABU_S08_2 | agency.admin  | A_UWPCCPIABU_S08_2 |
And added agency 'A_UWPCCPIABU_S08_1' as a partner to agency 'A_UWPCCPIABU_S08_2'
And logged in with details of 'U_UWPCCPIABU_S08_1'
And created following categories:
| Name             |
| C_UWPCCPIABU_S08 |
And I added next users for following categories:
| CategoryName     | UserName           | RoleName       |
| C_UWPCCPIABU_S08 | U_UWPCCPIABU_S08_2 | library.admin  |
And edited for user 'U_UWPCCPIABU_S08_2' agency role 'Business Unit Admin'
And I waited for '5' seconds
And logged in with details of 'U_UWPCCPIABU_S08_2'
When I go to Create New Project page
Then I 'should not' see metadata field 'RBF UWPCCPIABU S08 1,DDF UWPCCPIABU S08 1,CS UWPCCPIABU S08 1' on New Project popup
When I fill the following fields for project:
| Name                  | Business Unit      |
| P_UWPCCPIABU_S08      | A_UWPCCPIABU_S08_1 |
And I wait for '3' seconds
Then I 'should' see metadata field 'RBF UWPCCPIABU S08 1,DDF UWPCCPIABU S08 1,CS UWPCCPIABU S08 1' on New Project popup


Scenario: Check that schema on work request page is related to selected BU
Meta: @gdam
@projects
Given I created the agency 'A_UWPCCPIABU_S09_1' with default attributes
And created following 'common' custom metadata fields for agency 'A_UWPCCPIABU_S09_1':
| FieldType          | Description            | Choices                                         |
| RadioButtons       | RBF UWPCCPIABU S09 1   | RBFV UWPCCPIABU S09 1 1,RBFV UWPCCPIABU S09 1 2 |
| Dropdown           | DDF UWPCCPIABU S09 1   | DDFV UWPCCPIABU S09 1 1,DDFV UWPCCPIABU S09 1 2 |
| catalogueStructure | CS UWPCCPIABU S09 1    | CS UWPCCPIABU S09 1 1,CS UWPCCPIABU S09 1 2     |
And I created the agency 'A_UWPCCPIABU_S09_2' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |
| U_UWPCCPIABU_S09_1 | agency.admin  | A_UWPCCPIABU_S09_1 |
| U_UWPCCPIABU_S09_2 | agency.admin  | A_UWPCCPIABU_S09_2 |
And added agency 'A_UWPCCPIABU_S09_1' as a partner to agency 'A_UWPCCPIABU_S09_2'
And logged in with details of 'U_UWPCCPIABU_S09_1'
And created following categories:
| Name             |
| C_UWPCCPIABU_S09 |
And I added next users for following categories:
| CategoryName     | UserName           | RoleName       |
| C_UWPCCPIABU_S09 | U_UWPCCPIABU_S09_2 | library.admin  |
And edited for user 'U_UWPCCPIABU_S09_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UWPCCPIABU_S09_2'
When I open Create New Work Request popup
Then I 'should not' see metadata field 'RBF UWPCCPIABU S09 1,DDF UWPCCPIABU S09 1,CS UWPCCPIABU S09 1' on Create new Work Request popup
When I fill the following fields for work request:
| Name                  | Business Unit      |
| P_UWPCCPIABU_S09      | A_UWPCCPIABU_S09_1 |
And I wait for '1' seconds
Then I 'should' see metadata field 'RBF UWPCCPIABU S09 1,DDF UWPCCPIABU S09 1,CS UWPCCPIABU S09 1' on Create new Work Request popup