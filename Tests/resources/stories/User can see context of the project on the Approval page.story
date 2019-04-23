!--NGN-10343
Feature:          User can see context of the project on the Approval page
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check access to project by approver when he is a team member


Scenario: Check that user can see breadcrumbs and has access to folder from file details after open approval (check link from Dashboard)
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role        |
| U_UCSCOTPNAP_1 | agency.user |
And created 'UCSCOTPNAP_P1' project
And created '/folder1' folder for project 'UCSCOTPNAP_P1'
And uploaded '/files/image9.jpg' file into '/folder1' folder for 'UCSCOTPNAP_P1' project
And waited while preview is available in folder '/folder1' on project 'UCSCOTPNAP_P1' files page
And I am on project 'UCSCOTPNAP_P1' teams page
And added user 'U_UCSCOTPNAP_1' into project 'UCSCOTPNAP_P1' team with role 'project.contributor' expired '12.12.2021' for folder '/folder1'
And added approval stage on file 'image9.jpg' approvals page in folder '/folder1' project 'UCSCOTPNAP_P1':
| Name       | Approvers      | Deadline         | Description      | Started |
| UCSCOTPNAP | U_UCSCOTPNAP_1 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_UCSCOTPNAP_1'
And go to Dashboard page
And click file 'image9.jpg' in 'Received' tab in 'Approvals' section on dashboard page
Then I should see following breadcrumbs 'folder1 > image9.jpg' on approvals page
When click by following breadcrumb link 'folder1'
Then I should see project 'UCSCOTPNAP_P1' folder '/folder1' page


Scenario: Check that user sees Download button according to his permission (using project->folder)
Meta:@gdam
@projects
Given I created users with following fields:
| Email   | Role        |
| <Email> | agency.user |
And created 'UCSCOTPNAP_P2' project
And created '/folder1' folder for project 'UCSCOTPNAP_P2'
And uploaded '/files/image9.jpg' file into '/folder1' folder for 'UCSCOTPNAP_P2' project
And waited while preview is available in folder '/folder1' on project 'UCSCOTPNAP_P2' files page
And I am on project 'UCSCOTPNAP_P2' teams page
And added user '<Email>' into project 'UCSCOTPNAP_P2' team with role '<Role>' expired '12.12.2021' for folder '/folder1'
And added approval stage on file 'image9.jpg' approvals page in folder '/folder1' project 'UCSCOTPNAP_P2':
| Name       | Approvers | Deadline         | Description      | Started |
| UCSCOTPNAP | <Email>   | 01/05/2023 12:15 | test description | true    |
When I login with details of '<Email>'
And go to Dashboard page
And I open project 'UCSCOTPNAP_P2' files page
And I select file 'image9.jpg' on project files page
And I click element 'DownloadButton' on page 'FileInfoPage'
Then I '<Condition>' see Download link next to original file 'image9.jpg' and Download master using nVerge button on Download popup for current project

Examples:
| Email            | Role                | Condition  |
| U_UCSCOTPNAP_2_1 | project.contributor | should     |


Scenario: Check that approver can edit file according to role permissions (use link from Projects -> Approvals page)
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role        |
| U_UCSCOTPNAP_3 | agency.user |
And created 'UCSCOTPNAP_P3' project
And created '/folder1' folder for project 'UCSCOTPNAP_P3'
And uploaded '/files/image9.jpg' file into '/folder1' folder for 'UCSCOTPNAP_P3' project
And waited while preview is available in folder '/folder1' on project 'UCSCOTPNAP_P3' files page
And I am on project 'UCSCOTPNAP_P3' teams page
And added user 'U_UCSCOTPNAP_3' into project 'UCSCOTPNAP_P3' team with role 'project.contributor' expired '12.12.2021' for folder '/folder1'
And added approval stage on file 'image9.jpg' approvals page in folder '/folder1' project 'UCSCOTPNAP_P3':
| Name       | Approvers      | Deadline         | Description      | Started |
| UCSCOTPNAP | U_UCSCOTPNAP_3 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_UCSCOTPNAP_3'
And click file 'image9.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And go to file '/folder1/image9.jpg' info page in folder '/folder1' project 'UCSCOTPNAP_P3'
Then 'should' see Edit link on opened asset info page

Scenario: Check that approver can see status icon on folder view
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role        |
| U_UCSCOTPNAP_4 | agency.user |
And created '<Project>' project
And created '/folder1' folder for project '<Project>'
And uploaded '/files/image9.jpg' file into '/folder1' folder for '<Project>' project
And waited while preview is available in folder '/folder1' on project '<Project>' files page
And I am on project '<Project>' teams page
And added user 'U_UCSCOTPNAP_4' into project '<Project>' team with role 'project.contributor' expired '12.12.2021' for folder '/folder1'
And added approval stage on file 'image9.jpg' approvals page in folder '/folder1' project '<Project>':
| Name       | Approvers      | Deadline         | Description      | Started |
| UCSCOTPNAP | U_UCSCOTPNAP_4 | 01/05/2023 12:15 | test description | true    |
When I '<Action>' stage 'UCSCOTPNAP' with comment 'test comment' on file 'image9.jpg' approvals page in folder '/folder1' project '<Project>'
And I login with details of 'U_UCSCOTPNAP_4'
And go to file 'image9.jpg' info page in folder '/folder1' project '<Project>'
And go to project '<Project>' folder '/folder1' page
Then I 'should' see approval status icon '<ExpectedStatus>' in file 'image9.jpg' preview on project '<Project>' folder '/folder1' files page

Examples:
| Action  | ExpectedStatus | Project         |
| Approve | approved       | UCSCOTPNAP_P4_1 |
| Reject  | rejected       | UCSCOTPNAP_P4_2 |


Scenario: Check that user sees Upload new version  button on file details (link from email)
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role         |
| U_UCSCOTPNAP_5 | agency.admin |
And on user 'U_UCSCOTPNAP_5' Notifications Settings page
And set notification 'Files Uploaded' into state 'on' for current user
And saved current user notifications setting
And created following projects:
| Name         | Administrators |
| P_ANPVHR_S05 | U_UCSCOTPNAP_5 |
And created '/F_ANPVHR_S05' folder for project 'P_ANPVHR_S05'
And uploaded '/images/logo.jpg' file into '/F_ANPVHR_S05' folder for 'P_ANPVHR_S05' project
And waited while transcoding is finished on project 'P_ANPVHR_S05' in folder '/F_ANPVHR_S05' for 'logo.jpg' file
And I logged in with details of 'U_UCSCOTPNAP_5'
When I open link from email when user 'U_UCSCOTPNAP_5' received email with next subject 'Files were uploaded'
And go to file 'logo.jpg' info page in folder '/F_ANPVHR_S05' project 'P_ANPVHR_S05'
Then I 'should' see Upload new version button on file 'logo.jpg' info page in folder '/F_ANPVHR_S05' project 'P_ANPVHR_S05'