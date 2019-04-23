!--NGN-17777
Feature:          Role - Can Share To Section
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Can Share to Section for project roles

Scenario: Check that CanShareTo section appears only when folder.share permission enabled for project role
Meta:@globaladmin
     @gdam
Given I created the following agency:
| Name      | A4User        | Country        |
| RCSTS_A01 | DefaultA4User | United Kingdom |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| RCSTS_U01 | agency.admin | RCSTS_A01    |
And created '<RoleName>' role with '<Permissions>' permissions in 'project' group for advertiser 'RCSTS_A01'
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser 'RCSTS_A01' on global roles page
And I selected advertiser 'RCSTS_A01' on global roles page
And opened role '<RoleName>' on global role page
When I select '<ButtonName>' for '<RoleName>' with parent 'RCSTS_A01'
Then I '<shouldState>' see CanShareTo section
And '<FolderShareState>' see 'selected' permissions 'folder.share' on opened global role page
And '<PermissionsState>' see 'selected' permissions '<Permissions>' on opened global role page

Examples:
| RoleName | Permissions                             | ButtonName                 | shouldState | FolderShareState | PermissionsState |
| RCSTS_01 | project.read,project.write,folder.share | Enable Sharing permissions | should      | should           | should           |
| RCSTS_02 | project.read,project.write              | Disable permissions        | should not  | should not       | should           |

Scenario: Check that changes made to CanShareTo section are saved
Meta:@globaladmin
     @gdam
Given I created the following agency:
| Name      | A4User        | Country        |
| RCSTS_A02 | DefaultA4User | United Kingdom |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| RCSTS_U01 | agency.admin | RCSTS_A02    |
And created 'RCSTS_R03' role with 'folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser 'RCSTS_A02'
And I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role        |
| UserFN    | UserLN   | agencytestuser  | 80501554825 | guest.user  |
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser 'RCSTS_A02' on global roles page
And I selected advertiser 'RCSTS_A02' on global roles page
And opened role 'RCSTS_R03' on global role page
When I select 'Enable Sharing permissions' for 'RCSTS_R03' with parent 'RCSTS_A02'
And I change 'RCSTS_R03' permissions to 'project.contributor,folder.read,element.read,project.read,folder.share' in agency 'RCSTS_A02'
And save changes in can share to section
Then I 'should' see 'selected' permissions 'folder.read,element.read,project.read,folder.share,project.contributor' on opened global role page


Scenario: Check that user can only share Folders to users with Project Roles predefined via Share To Role function, else should show all project roles (including custom project roles)
Meta: @uatgdamsmoke
	  @livegdamsmoke
Given I created 'RCSTS_R03' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email           | Role         |
| agencytestadmin1 | agency.admin |
| agencytestuser1  | agency.user  |
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I have refreshed the page
And I search advertiser 'DefaultAgency' on global roles page
And waited for '15' seconds
And I selected advertiser 'DefaultAgency' on global roles page
And waited role 'RCSTS_R03' on global role page to load
And opened role 'RCSTS_R03' on global role page
And waited for '3' seconds
And selected 'Enable Sharing permissions' for 'RCSTS_R03' with parent 'DefaultAgency' if not already clicked
And waited for '3' seconds
And selected 'Project Contributor' in can share to section for 'RCSTS_R03' role in agency 'DefaultAgency'
And saved changes in can share to section
And logged in with details of 'agencytestadmin1'
And created 'RCSTS_P01' project
And created '/RCSTS_F01' folder for project 'RCSTS_P01'
And I am on project 'RCSTS_P01' folder '/RCSTS_F01' page
When go to project 'RCSTS_P01' folder 'root' page
And select folder '/RCSTS_F01' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'agencytestuser1' with role 'RCSTS_R03' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And login with details of 'agencytestuser1'
And open Share window from popup menu for folder '/RCSTS_F01' on project 'RCSTS_P01'
Then I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should not' see role 'Project User,approver,folder.or.element.owner,public_project_template.reader,Project Observer,RCSTS_R03' in the role dropdown on Share popup
When I login as 'GlobalAdmin'
And I go to global roles page
And I search advertiser 'DefaultAgency' on global roles page
And wait for '10' seconds
And I select advertiser 'DefaultAgency' on global roles page
And wait for '10' seconds
And wait role 'RCSTS_R03' on global role page to load
And open role 'RCSTS_R03' on global role page
And select 'Disable permissions' for 'RCSTS_R03' with parent 'DefaultAgency' if not already clicked
And wait for '1' seconds
And login with details of 'agencytestuser1'
And open Share window from popup menu for folder '/RCSTS_F01' on project 'RCSTS_P01'
Then I 'should' see role 'Project Observer' in the role dropdown on Share popup
And I 'should' see role 'RCSTS_R03' in the role dropdown on Share popup
And I 'should' see role 'Project Contributor' in the role dropdown on Share popup


Scenario: Check that user can share mutiple folders to multiple users with different Project Roles predefined via Share To Role function
Meta:@projects
     @gdam
Given I created the following agency:
| Name      | A4User        | Country       |
| RCSTS_A05 | DefaultA4User | United Kingdom |
And created 'RCSTS_R04' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser 'RCSTS_A05'
And created 'RCSTS_R05' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser 'RCSTS_A05'
And created users with following fields:
| Email           | Role         | AgencyUnique |
| agencytestadmin | agency.admin | RCSTS_A05    |
| agencytestuser1 | agency.user  | RCSTS_A05    |
| agencytestuser2 | agency.user  | RCSTS_A05    |
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser 'RCSTS_A05' on global roles page
And I selected advertiser 'RCSTS_A05' on global roles page
And opened role 'RCSTS_R04' on global role page
And selected 'Enable Sharing permissions' for 'RCSTS_R04' with parent 'RCSTS_A05'
And selected 'project.contributor' in can share to section for 'RCSTS_R04' role in agency 'RCSTS_A05'
And saved changes in can share to section
And opened role 'RCSTS_R05' on global role page
And selected 'approver' in can share to section for 'RCSTS_R05' role in agency 'RCSTS_A05'
And saved changes in can share to section
And logged in with details of 'agencytestadmin'
And created 'RCSTS_P01' project
And created '/RCSTS_F01' folder for project 'RCSTS_P01'
And created '/RCSTS_F02' folder for project 'RCSTS_P01'
And I am on project 'RCSTS_P01' folder '/RCSTS_F01' page
When go to project 'RCSTS_P01' folder 'root' page
And select folder '/RCSTS_F01' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'agencytestuser1' with role 'RCSTS_R04' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And refresh the page
When go to project 'RCSTS_P01' folder 'root' page
And select folder '/RCSTS_F02' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'agencytestuser2' with role 'RCSTS_R05' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And login with details of 'agencytestuser1'
And open Share window from popup menu for folder '/RCSTS_F01' on project 'RCSTS_P01'
Then I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should not' see role 'Project User,folder.or.element.owner,public_project_template.reader,Project Observer,RCSTS_R04,RCSTS_R05' in the role dropdown on Share popup
When I login with details of 'agencytestuser2'
And open Share window from popup menu for folder '/RCSTS_F02' on project 'RCSTS_P01'
Then I 'should' see role 'approver' in the role dropdown on Share popup
And I 'should not' see role 'Project Contributor,Project User,folder.or.element.owner,public_project_template.reader,Project Observer,RCSTS_R04,RCSTS_R05' in the role dropdown on Share popup

Scenario: Check that user cannot share a project/Folders to project Admin
Meta:@projects
     @gdam
Given I created the following agency:
| Name      | A4User        | Country        |
| RCSTS_A06 | DefaultA4User | United Kingdom |
And created users with following fields:
| Email           | Role         | AgencyUnique |
| agencytestadmin | agency.admin | RCSTS_A06    |
And logged in with details of 'agencytestadmin'
And created 'RCSTS_P01' project
And created '/RCSTS_F01' folder for project 'RCSTS_P01'
And I am on project 'RCSTS_P01' folder '/RCSTS_F01' page
When go to project 'RCSTS_P01' folder 'root' page
And select folder '/RCSTS_F01' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
Then I 'should not' see role 'project.admin' in the role dropdown on Share popup
When go to project 'RCSTS_P01' folder 'root' page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
Then I 'should not' see role 'project.admin' in the role dropdown on Share popup

Scenario: Check that only common roles are available when sharing the root project - Positive Case
Meta:@globaladmin
     @gdam
     @skip
!--skipping till sendkeys is fixed QA-785
Given I created the following agency:
| Name         | A4User        | Country        |
| <AgencyName> | DefaultA4User | United Kingdom |
Given I created '<RoleName1>' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser '<AgencyName>'
And created '<RoleName2>' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser '<AgencyName>'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| agencytestadmin1 | agency.admin | <AgencyName> |
| agencytestuser3  | agency.user  | <AgencyName> |
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser '<AgencyName>' on global roles page
And I selected advertiser '<AgencyName>' on global roles page
And opened role '<RoleName1>' on global role page
And selected 'Enable Sharing permissions' for '<RoleName1>' with parent '<AgencyName>'
And selected '<Role1>' in can share to section for '<RoleName1>' role in agency '<AgencyName>'
And saved changes in can share to section
And opened role '<RoleName2>' on global role page
And selected '<Role2>' in can share to section for '<RoleName2>' role in agency '<AgencyName>'
And saved changes in can share to section
And logged in with details of 'agencytestadmin1'
And created 'RCSTS_P01' project
And created '/RCSTS_F01' folder for project 'RCSTS_P01'
And created '/RCSTS_F02' folder for project 'RCSTS_P01'
And I am on project 'RCSTS_P01' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And share with user 'agencytestuser3' both project 'RCSTS_P01' and folder '/RCSTS_F01' with role '<RoleName1>' expired '12.12.2021'
And click 'OK' button on Add User pop-up
And refresh the page
And go to project 'RCSTS_P01' teams page
And click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And share with user 'agencytestuser3' both project 'RCSTS_P01' and folder '/RCSTS_F02' with role '<RoleName2>' expired '12.12.2021'
And click 'OK' button on Add User pop-up
And login with details of 'agencytestuser3'
And open Share window from popup menu for folder '/RCSTS_F01,/RCSTS_F02' on project 'RCSTS_P01'
Then I '<Condition>' see role '<ExpectedRole1>' in the role dropdown on Share popup
And I '<Condition>' see role '<ExpectedRole2>' in the role dropdown on Share popup

Examples:
| AgencyName  | RoleName1   | RoleName2   | Role1               | Role2                        | Condition  | ExpectedRole1       | ExpectedRole2       |
| RCSTS_A03_2 | RCSTS_R07_2 | RCSTS_R08_2 | project.contributor | project.contributor,approver | should     | project.contributor | project.contributor |

Scenario: Check that only common roles are available when sharing the root project - Negative Case
Meta:@globaladmin
     @gdam
     @skip
!--skipping till sendkeys is fixed QA-785..FAB-454 is the bug raised for it
Given I created the following agency:
| Name         | A4User        | Country        |
| <AgencyName> | DefaultA4User | United Kingdom |
Given I created '<RoleName1>' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser '<AgencyName>'
And created '<RoleName2>' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser '<AgencyName>'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| agencytestadmin1 | agency.admin | <AgencyName> |
| agencytestuser3  | agency.user  | <AgencyName> |
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser '<AgencyName>' on global roles page
And I selected advertiser '<AgencyName>' on global roles page
And opened role '<RoleName1>' on global role page
And selected 'Enable Sharing permissions' for '<RoleName1>' with parent '<AgencyName>'
And selected '<Role1>' in can share to section for '<RoleName1>' role in agency '<AgencyName>'
And saved changes in can share to section
And opened role '<RoleName2>' on global role page
And selected '<Role2>' in can share to section for '<RoleName2>' role in agency '<AgencyName>'
And saved changes in can share to section
And logged in with details of 'agencytestadmin1'
And created 'RCSTS_P01' project
And created '/RCSTS_F01' folder for project 'RCSTS_P01'
And created '/RCSTS_F02' folder for project 'RCSTS_P01'
And I am on project 'RCSTS_P01' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And share with user 'agencytestuser3' both project 'RCSTS_P01' and folder '/RCSTS_F01' with role '<RoleName1>' expired '12.12.2021'
And click 'OK' button on Add User pop-up
And refresh the page
And go to project 'RCSTS_P01' teams page
And click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And share with user 'agencytestuser3' both project 'RCSTS_P01' and folder '/RCSTS_F02' with role '<RoleName2>' expired '12.12.2021'
And click 'OK' button on Add User pop-up
And login with details of 'agencytestuser3'
And open Share window from popup menu for folder '/RCSTS_F01,/RCSTS_F02' on project 'RCSTS_P01'
Then I '<Condition>' see role '<ExpectedRole1>' in the role dropdown on Share popup
And I '<Condition>' see role '<ExpectedRole2>' in the role dropdown on Share popup

Examples:
| AgencyName  | RoleName1   | RoleName2   | Role1               | Role2                        | Condition  | ExpectedRole1       | ExpectedRole2       |
| RCSTS_A03_1 | RCSTS_R07_1 | RCSTS_R08_1 | project.contributor | approver                     | should not | approver            | project.contributor |


Scenario: Check that Newly added project owners (agency user ) are able to share folders
Meta:@projects
     @gdam
Given I created users with following fields:
| Email            | Role         |
| RCSTS_A07_U2     | agency.user  |
And added user 'RCSTS_A07_U2' into address book
And created 'RCSTS_P07' project
And created '/RCSTS_F07' folder for project 'RCSTS_P07'
And I am on project 'RCSTS_P07' settings page
When I edit the following fields for 'RCSTS_P07' project:
| Name      | Administrators |
| RCSTS_P07 | RCSTS_A07_U2   |
And click on element 'SaveButton'
And I login with details of 'RCSTS_A07_U2'
And go to Project list page
And I go to project 'RCSTS_P07' folder '/RCSTS_F07' page
And open Share window from popup menu for folder '/RCSTS_F07' on project 'RCSTS_P07'
Then I 'should' see role 'Project Observer' in the role dropdown on Share popup
And I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should' see role 'Project User' in the role dropdown on Share popup

Scenario: Check that Newly added project owners (agency user ) are able to share folders
!-- Adding due scenarios just for live and UAT bcoz the role names are different
Meta:@uatgdamsmoke
     @livegdamsmoke
Given I created users with following fields:
| Email            | Role         |
| RCSTS_A07_U2     | agency.user  |
And added user 'RCSTS_A07_U2' into address book
And created 'RCSTS_P07' project
And created '/RCSTS_F07' folder for project 'RCSTS_P07'
And I am on project 'RCSTS_P07' settings page
When I edit the following fields for 'RCSTS_P07' project:
| Name      | Administrators |
| RCSTS_P07 | RCSTS_A07_U2   |
And click on element 'SaveButton'
And I login with details of 'RCSTS_A07_U2'
And go to Project list page
And I refresh the page
And I go to project 'RCSTS_P07' folder '/RCSTS_F07' page
And open Share window from popup menu for folder '/RCSTS_F07' on project 'RCSTS_P07'
Then I 'should' see role 'Project Observer' in the role dropdown on Share popup
And I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should' see role 'Project  User' in the role dropdown on Share popup

Scenario:  Check that Newly added project owners (agency user from another bu) are able to share folders
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role         | Agency         |
| RCSTS_A10_U2   |agency.user   | AnotherAgency  |
And added user 'RCSTS_A10_U2' into address book
And created 'RCSTS_P10' project
And created '/RCSTS_F10' folder for project 'RCSTS_P10'
And I am on project 'RCSTS_P10' settings page
When I edit the following fields for 'RCSTS_P10' project:
| Name      | Administrators |
| RCSTS_P10 | RCSTS_A10_U2   |
And click on element 'SaveButton'
And refresh the page
And I login with details of 'RCSTS_A10_U2'
And go to Project list page
And I go to project 'RCSTS_P10' folder '/RCSTS_F10' page
And open Share window from popup menu for folder '/RCSTS_F10' on project 'RCSTS_P10'
Then I 'should' see role 'Project Observer' in the role dropdown on Share popup
And I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should' see role 'Project User' in the role dropdown on Share popup

Scenario: Check that users assigned to the project against Project-Access-Rule able set for Advertiser are able to share folders to user of same BU-Enabled Sharing Permissions
Meta:@gdam
@projects
Given I created the agency 'RCSTS_A12' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| RCSTS_A12_U2   | agency.admin | RCSTS_A12      |
| RCSTS_A12_U3   |agency.user   | RCSTS_A12      |
| RCSTS_A12_U4   |agency.user   | RCSTS_A12      |
And created 'RCSTS_R12' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser 'RCSTS_A12'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RCSTS_A12':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR      | PARBR   | PARSB     | PARPR |
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser 'RCSTS_A12' on global roles page
And I selected advertiser 'RCSTS_A12' on global roles page
And opened role 'RCSTS_R12' on global role page
And selected 'Enable Sharing permissions' for 'RCSTS_R12' with parent 'RCSTS_A12'
And selected 'project.contributor' in can share to section for 'RCSTS_R12' role in agency 'RCSTS_A12'
And saved changes in can share to section
And I updated agency 'RCSTS_A12' with following fields on agency overview page:
| FieldName                   | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'RCSTS_A12_U2'
And I created new project with following fields:
| FieldName    | FieldValue    |
| Name         | RCSTS_P12     |
| Media type   | Broadcast     |
| Advertiser   | PARAR         |
| Start date   | Today         |
| End date     | Tomorrow      |
And created '/RCSTS_F12' folder for project 'RCSTS_P12'
And I am on Users list page
When I select user 'RCSTS_A12_U3' on Users page
And refresh the page
And I create project access rule:
| MetaData     | MetaValue   | Role                |
| Advertiser   |  PARAR      | RCSTS_R12           |
And publish the project 'RCSTS_P12'
And refresh the page
Then I '<Should>' see the following users on project team page with interval:
|UserName    |Project       |Should|
|RCSTS_A12_U2| RCSTS_P12    |should|
|RCSTS_A12_U3| RCSTS_P12    |should|
And I should see 'RCSTS_P12' project in project list
When I login with details of 'RCSTS_A12_U3'
Then I should see 'RCSTS_P12' project in project list
When I go to Project list page
And I go to project 'RCSTS_P12' folder '/RCSTS_F12' page
And open Share window from popup menu for folder '/RCSTS_F12' on project 'RCSTS_P12'
Then I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should not' see role 'Project User,Project Contributor,folder.or.element.owner,public_project_template.reader,approver,RCSTS_R12' in the role dropdown on Share popup
When I fill Share popup of project folder for user 'RCSTS_A12_U4' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should' see email with subject 'Folders have been shared with you' sent to 'RCSTS_A12_U4'
When I login with details of 'RCSTS_A12_U4'
And go to Project list page
And I go to project 'RCSTS_P12' folder '/RCSTS_F12' page
And open Share window from popup menu for folder '/RCSTS_F12' on project 'RCSTS_P12'
Then I 'should' see role 'Project User' in the role dropdown on Share popup
And I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should' see role 'Project Observer' in the role dropdown on Share popup
And I 'should' see role 'Project User' in the role dropdown on Share popup
And I 'should' see role 'RCSTS_R12' in the role dropdown on Share popup
And I 'should not' see role 'folder.or.element.owner,public_project_template.reader,approver' in the role dropdown on Share popup

Scenario: Check that users assigned to the project against Project-Access-Rule set for Advertiser are able to share folders to user of same BU-Disabled Sharing Permissions
Meta: @gdam
@gdamemails
Given I created the agency 'RCSTS_A11' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| RCSTS_A11_U2   | agency.admin | RCSTS_A11      |
| RCSTS_A11_U3   | agency.user  | RCSTS_A11      |
| RCSTS_A11_U4   | agency.user  | RCSTS_A11      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RCSTS_A11':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR      | PARBR   | PARSB     | PARPR |
And I logged in as 'GlobalAdmin'
And I updated agency 'RCSTS_A11' with following fields on agency overview page:
| FieldName                   | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'RCSTS_A11_U2'
And I created new project with following fields:
| FieldName    | FieldValue    |
| Name         | RCSTS_P11     |
| Media type   | Broadcast     |
| Advertiser   | PARAR         |
| Start date   | Today         |
| End date     | Tomorrow      |
And waited for '5' seconds
And created '/RCSTS_F11' folder for project 'RCSTS_P11'
And I am on Users list page
When I select user 'RCSTS_A11_U2' on Users page
And I select user 'RCSTS_A11_U3' on Users page
And I create project access rule:
| MetaData     | MetaValue | Role                |
| Advertiser   | PARAR     | Project Contributor |
And publish the project 'RCSTS_P11'
Then I '<Should>' see the following users on project team page with interval:
|UserName    |Project      |Should|
|RCSTS_A11_U2| RCSTS_P11   |should|
|RCSTS_A11_U3| RCSTS_P11   |should|
And I should see 'RCSTS_P11' project in project list
When I login with details of 'RCSTS_A11_U3'
Then I should see 'RCSTS_P11' project in project list
When I go to Project list page
And I go to project 'RCSTS_P11' folder '/RCSTS_F11' page
And open Share window from popup menu for folder '/RCSTS_F11' on project 'RCSTS_P11'
Then I 'should' see role 'Project Observer' in the role dropdown on Share popup
And I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should' see role 'Project User' in the role dropdown on Share popup
And I 'should not' see role 'folder.or.element.owner,public_project_template.reader,approver' in the role dropdown on Share popup
When I fill Share popup of project folder for user 'RCSTS_A11_U4' with role 'Project User' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should' see email with subject 'Folders have been shared with you' sent to 'RCSTS_A11_U4'

Scenario: Check that users assigned to the project against Project-Access-Rule with Project Type as Internal are able to share folders-Enabled Sharing Permissions
Meta:@gdam
@gdamemails
Given I created the agency 'RCSTS_A09' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| RCSTS_A09_U2   | agency.admin | RCSTS_A09      |
| RCSTS_A09_U3   |agency.user   | RCSTS_A09      |
| RCSTS_A09_U4   |agency.user   | RCSTS_A09      |
And created 'RCSTS_R09' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser 'RCSTS_A09'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RCSTS_A09':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR      | PARBR   | PARSB     | PARPR |
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser 'RCSTS_A09' on global roles page
And I selected advertiser 'RCSTS_A09' on global roles page
And opened role 'RCSTS_R09' on global role page
And selected 'Enable Sharing permissions' for 'RCSTS_R09' with parent 'RCSTS_A09'
And selected 'project.contributor' in can share to section for 'RCSTS_R09' role in agency 'RCSTS_A09'
And saved changes in can share to section
And I updated agency 'RCSTS_A09' with following fields on agency overview page:
| FieldName                   | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'RCSTS_A09_U2'
And I am on the 'project' metadata page
And I clicked 'Project Type' button in 'editable metadata' section on opened metadata page
And I created following Catalogue Structure chains on opened Settings and Customization page:
|MetaDataValue|
|Internal|
And I created new project with following fields:
| FieldName    | FieldValue    |
| Name         | RCSTS_A09_P8  |
| Media type   | Broadcast     |
| Project Type | Internal      |
| Advertiser   | PARAR         |
| Start date   | Today         |
| End date     | Tomorrow      |
And waited for '5' seconds
And created '/RCSTS_F08' folder for project 'RCSTS_A09_P8'
And I am on Users list page
And refreshed the page
When I select user 'RCSTS_A09_U2' on Users page
And I select user 'RCSTS_A09_U3' on Users page
And I create project access rule:
| MetaData     | MetaValue | Role                |
| Project Type | Internal  | RCSTS_R09           |
And publish the project 'RCSTS_A09_P8'
And refresh the page
Then I '<Should>' see the following users on project team page with interval:
|UserName    |Project      |Should|
|RCSTS_A09_U2| RCSTS_A09_P8|should|
|RCSTS_A09_U3| RCSTS_A09_P8|should|
And I should see 'RCSTS_A09_P8' project in project list
When I login with details of 'RCSTS_A09_U3'
Then I should see 'RCSTS_A09_P8' project in project list
When I go to Project list page
And I go to project 'RCSTS_A09_P8' folder '/RCSTS_F08' page
And open Share window from popup menu for folder '/RCSTS_F08' on project 'RCSTS_A09_P8'
Then I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should not' see role 'Project User,Project Contributor,folder.or.element.owner,public_project_template.reader,approver' in the role dropdown on Share popup
When I fill Share popup of project folder for user 'RCSTS_A09_U4' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should' see email with subject 'Folders have been shared with you' sent to 'RCSTS_A09_U4'

Scenario: Check that users assigned to the project against Project-Access-Rule with Project Type as Internal are able to share folders-Diabled Sharing Permissions
Meta: @gdam
@gdamemails
Given I created the agency 'RCSTS_A08' with default attributes
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| RCSTS_A08_U2   | agency.admin | RCSTS_A08      |
| RCSTS_A08_U3   |agency.user   | RCSTS_A08      |
| RCSTS_A08_U4   |agency.user   | RCSTS_A08      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RCSTS_A08':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR      | PARBR   | PARSB     | PARPR |
And I logged in as 'GlobalAdmin'
And waited for '3' seconds
And I updated agency 'RCSTS_A08' with following fields on agency overview page:
| FieldName                   | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'RCSTS_A08_U2'
And I am on the 'project' metadata page
And I clicked 'Project Type' button in 'editable metadata' section on opened metadata page
And I created following Catalogue Structure chains on opened Settings and Customization page:
|MetaDataValue|
|Internal|
And I created new project with following fields:
| FieldName    | FieldValue    |
| Name         | RCSTS_A08_P8  |
| Media type   | Broadcast     |
| Project Type | Internal      |
| Advertiser   | PARAR         |
| Start date   | Today         |
| End date     | Tomorrow      |
And created '/RCSTS_F08' folder for project 'RCSTS_A08_P8'
And I am on Users list page
When I select user 'RCSTS_A08_U3' on Users page
And refresh the page
And I create project access rule:
| MetaData     | MetaValue | Role                |
| Project Type | Internal  | Project Contributor |
And publish the project 'RCSTS_A08_P8'
Then I '<Should>' see the following users on project team page with interval:
|UserName    |Project      |Should|
|RCSTS_A08_U2| RCSTS_A08_P8|should|
|RCSTS_A08_U3| RCSTS_A08_P8|should|
And I should see 'RCSTS_A08_P8' project in project list
When I login with details of 'RCSTS_A08_U3'
Then I should see 'RCSTS_A08_P8' project in project list
When I go to Project list page
And I go to project 'RCSTS_A08_P8' folder '/RCSTS_F08' page
And open Share window from popup menu for folder '/RCSTS_F08' on project 'RCSTS_A08_P8'
Then I 'should' see role 'Project Observer' in the role dropdown on Share popup
And I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should' see role 'Project User' in the role dropdown on Share popup
And I 'should not' see role 'folder.or.element.owner,public_project_template.reader,approver' in the role dropdown on Share popup
When I fill Share popup of project folder for user 'RCSTS_A08_U4' with role 'Project User' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should' see email with subject 'Folders have been shared with you' sent to 'RCSTS_A08_U4'

Scenario: Check that users assigned to the project against Project-Access-Rule able set for Advertiser are able to share folders to user of another BU-Enabled Sharing Permissions
Meta: @gdam
@projects
Given I created the agency 'RCSTS_A13' with default attributes
And I created the agency 'RCSTS_A14' with default attributes
And I added agencies 'RCSTS_A14' as a partners to agency 'RCSTS_A13'
And created users with following fields:
| Email          | Role         | AgencyUnique   |
| RCSTS_A13_U2   | agency.admin | RCSTS_A13      |
| RCSTS_A13_U3   |agency.user   | RCSTS_A13      |
| RCSTS_A13_U4   |agency.user   | RCSTS_A13      |
| RCSTS_A14_U1   |agency.user   | RCSTS_A14      |
And added existing user 'RCSTS_A14_U1' to agency 'RCSTS_A13' with role 'agency.admin'
And created 'RCSTS_R13' role with 'element.share,folder.read,element.read,project.read,folder.share' permissions in 'project' group for advertiser 'RCSTS_A13'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RCSTS_A13':
| Advertiser | Brand   | Sub Brand | Product |
| PARAR      | PARBR   | PARSB     | PARPR |
And I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser 'RCSTS_A13' on global roles page
And I selected advertiser 'RCSTS_A13' on global roles page
And opened role 'RCSTS_R13' on global role page
And selected 'Enable Sharing permissions' for 'RCSTS_R13' with parent 'RCSTS_A13'
And selected 'project.contributor' in can share to section for 'RCSTS_R13' role in agency 'RCSTS_A13'
And saved changes in can share to section
And I updated agency 'RCSTS_A13' with following fields on agency overview page:
| FieldName                   | FieldValue |
| Enable Project Access Rules | true       |
And I refreshed the page without delay
And logged in with details of 'RCSTS_A13_U2'
And I created new project with following fields:
| FieldName    | FieldValue    |
| Name         | RCSTS_P13     |
| Media type   | Broadcast     |
| Advertiser   | PARAR         |
| Start date   | Today         |
| End date     | Tomorrow      |
And created '/RCSTS_F13' folder for project 'RCSTS_P13'
And I am on Users list page
When I select user 'RCSTS_A14_U1' on Users page
And refresh the page
And I create project access rule:
| MetaData     | MetaValue   | Role                |
| Advertiser   |  PARAR      | RCSTS_R13           |
And publish the project 'RCSTS_P13'
And refresh the page
Then I '<Should>' see the following users on project team page with interval:
|UserName    |Project       |Should|
|RCSTS_A13_U2| RCSTS_P13    |should|
|RCSTS_A14_U1| RCSTS_P13    |should|
And I should see 'RCSTS_P13' project in project list
When I login with details of 'RCSTS_A14_U1'
Then I should see 'RCSTS_P13' project in project list
When I go to Project list page
And I go to project 'RCSTS_P13' folder '/RCSTS_F13' page
And open Share window from popup menu for folder '/RCSTS_F13' on project 'RCSTS_P13'
Then I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should not' see role 'Project User,Project Contributor,folder.or.element.owner,public_project_template.reader,approver,RCSTS_R13' in the role dropdown on Share popup
When I fill Share popup of project folder for user 'RCSTS_A13_U4' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should' see email with subject 'Folders have been shared with you' sent to 'RCSTS_A13_U4'
When I login with details of 'RCSTS_A13_U4'
And go to Project list page
And I go to project 'RCSTS_P13' folder '/RCSTS_F13' page
And open Share window from popup menu for folder '/RCSTS_F13' on project 'RCSTS_P13'
Then I 'should' see role 'Project User' in the role dropdown on Share popup
And I 'should' see role 'Project Contributor' in the role dropdown on Share popup
And I 'should' see role 'Project Observer' in the role dropdown on Share popup
And I 'should' see role 'Project User' in the role dropdown on Share popup
And I 'should' see role 'RCSTS_R13' in the role dropdown on Share popup
And I 'should not' see role 'folder.or.element.owner,public_project_template.reader,approver' in the role dropdown on Share popup

