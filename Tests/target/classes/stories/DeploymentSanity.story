!--NGN-3367 NGN-5005
Feature:          Run Sanity Post deployment to just check user can login and do basic functions
Narrative:
In order to
As a              AgencyAdmin
I want to         Run Sanity Post deployment to just check user can login and do basic functions

Scenario: Check that users have access to category after adding team,on which they are included
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @library
Given I created users with following fields:
| Email         | Role        |
| U_AARLT_S08_1 | agency.user |
| U_AARLT_S08_2 | agency.user |
And created following categories:
| Name        |
| C_AARLT_S08 |
And added users 'U_AARLT_S08_1' to library team 'LT_AARLT_S08'
And added following library teams for following categories:
| CategoryName | TeamName     | RoleName     |
| C_AARLT_S08  | LT_AARLT_S08 | library.user |
When I add users 'U_AARLT_S08_2' to library team 'LT_AARLT_S08'
And login with details of 'U_AARLT_S08_2'
And go to the Library page
Then I 'should' see on the library page collections 'C_AARLT_S08'

Scenario: Successfully creating a new Project(mandatory fields only)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I am on Dashboard page
When I create new project with following fields:
| FieldName  | FieldValue |
| Name       | CP1        |
| Media type | Broadcast  |
| Start Date | Today      |
| End Date   | Tomorrow   |
Then I should see 'CP1' project in project list


Scenario: Check that approver can approve or reject file when stage is started (pending status)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @approvals
Given I created users with following fields:
| Email       | Role        | Access                      |
| <UserEmail> | agency.user | folders,approvals,dashboard |
And created '<ProjectName>' project
And created '/F_RAARFS_S01' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S01' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S01' on project '<ProjectName>' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S01' project '<ProjectName>':
| Name                | Approvers   | Started |
| <ApprovalStageName> | <UserEmail> | true    |
When I login with details of '<UserEmail>'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And '<Action>' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And go to file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S01' project '<ProjectName>'
Then I 'should' see following approvers information in stage '<ApprovalStageName>' on opened file approvals page:
| UserName    | Comment      | Status           |
| <UserEmail> | test comment | <ExpectedStatus> |
And 'should not' see approvals buttons on opened file details page

Examples:
| UserEmail      | ProjectName    | ApprovalStageName | Action  | ExpectedStatus |
| U_RAARFS_S01_1 | P_RAARFS_S01_1 | AS_RAARFS_S01_1   | Approve | Approved       |

Scenario: User can see Activity about sharing on Dashboard
Meta:@gdam
	 @library
Given I created the following agency:
| Name         |
| A_SSOFAA_S07 |
And created users with following fields:
| Email          | Role         | Agency       |Access|
| U_SSOFAA_S07_1 | agency.admin | A_SSOFAA_S07 |streamlined_library|
| U_SSOFAA_S07_2 | agency.user  | A_SSOFAA_S07 |streamlined_library|
And logged in with details of 'U_SSOFAA_S07_1'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails     |
| U_SSOFAA_S07_2 |
And wait for '5' seconds
And go to Dashboard page
Then I 'should' see activity where user 'U_SSOFAA_S07_1' shared asset 'Fish Ad.mov' to user 'U_SSOFAA_S07_2' on Dashboard

