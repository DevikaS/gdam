!--NGN-5699 NGN-6951 NGN-7470 NGN-11507
Feature:          Rewrite Approval - approve and reject of file and stage
Narrative:
In order to:
As a              AgencyAdmin
I want to         Check approving and rejecting of file and stage

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
| U_RAARFS_S01_2 | P_RAARFS_S01_2 | AS_RAARFS_S01_2   | Reject  | Rejected       |


Scenario: Check the default page view (elements) for approver
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email          | Role        | Access                      |
| U_RAARFS_S02_1 | agency.user | folders,approvals,dashboard |
| U_RAARFS_S02_2 | agency.user | folders,approvals,dashboard |
And created 'P_RAARFS_S02' project
And created '/F_RAARFS_S02' folder for project 'P_RAARFS_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S02' folder for 'P_RAARFS_S02' project
And waited while preview is available in folder '/F_RAARFS_S02' on project 'P_RAARFS_S02' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S02' project 'P_RAARFS_S02':
| Name          | Approvers                     | Deadline         | Reminder         | Started |
| AS_RAARFS_S02 | U_RAARFS_S02_1,U_RAARFS_S02_2 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I login with details of 'U_RAARFS_S02_1'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'U_RAARFS_S02_2'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
Then I 'should' see approval stages with the following information:
| Name          | Status  | Reminder         | Deadline         | Description |
| AS_RAARFS_S02 | pending | 5/1/23, 8:00 AM | 5/1/23, 12:15 PM |             |
And 'should' see following approvers information in stage 'AS_RAARFS_S02' on opened file approvals page:
| UserName       | Comment      | Status   |
| U_RAARFS_S02_1 | test comment | Approved |
| U_RAARFS_S02_2 |              | Pending  |


Scenario: Check that next stage becomes active only when previous has been approved and approver of next stage has access to file
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email          | Role        | Access                      |
| U_RAARFS_S03_1 | agency.user | folders,approvals,dashboard |
| U_RAARFS_S03_2 | agency.user | folders,approvals,dashboard |
And created 'P_RAARFS_S03' project
And created '/F_RAARFS_S03' folder for project 'P_RAARFS_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S03' folder for 'P_RAARFS_S03' project
And waited while preview is available in folder '/F_RAARFS_S03' on project 'P_RAARFS_S03' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S03' project 'P_RAARFS_S03':
| Name            | Approvers      | Deadline         | Description       | Started |
| AS_RAARFS_S03_1 | U_RAARFS_S03_1 | 01/05/2023 12:15 | test description1 | false   |
| AS_RAARFS_S03_2 | U_RAARFS_S03_2 | 01/05/2023 12:15 | test description2 | true    |
When I login with details of 'U_RAARFS_S03_1'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
When I login with details of 'U_RAARFS_S03_2'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And click element 'ApprovalsTab' on page 'FileInfoPage'
Then I 'should' see approvals buttons on opened file details page
And 'should' see approval stages with the following information:
| Name            | Status  | Deadline         | Description       |
| AS_RAARFS_S03_2 | pending | 5/1/23, 12:15 PM | test description2 |


Scenario: Check that approver does not see approval on approvals tab if he was removed from the stage
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email          | Role        | Access                      |
| U_RAARFS_S04_1 | agency.user | folders,approvals,dashboard |
| U_RAARFS_S04_2 | agency.user | folders,approvals,dashboard |
And created 'P_RAARFS_S04' project
And created '/F_RAARFS_S04' folder for project 'P_RAARFS_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S04' folder for 'P_RAARFS_S04' project
And waited while preview is available in folder '/F_RAARFS_S04' on project 'P_RAARFS_S04' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S04' project 'P_RAARFS_S04':
| Name          | Approvers                     | Deadline         | Reminder         | Description      | Started |
| AS_RAARFS_S04 | U_RAARFS_S04_1,U_RAARFS_S04_2 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | true    |
And on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S04' project 'P_RAARFS_S04'
And removed the approver 'U_RAARFS_S04_1' from the stage 'AS_RAARFS_S04'
When I login with details of 'U_RAARFS_S04_1'
And switch tab to 'Received' for section 'Approvals' on Dashboard page
Then I 'should not' see files 'Fish Ad.mov' in 'Approvals' section on Dashboard page


Scenario: Check that approver user can be added to several stages but he sees only active one
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email        | Role        | Access                      |
| U_RAARFS_S05 | agency.user | folders,approvals,dashboard |
And created 'P_RAARFS_S05' project
And created '/F_RAARFS_S05' folder for project 'P_RAARFS_S05'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S05' folder for 'P_RAARFS_S05' project
And waited while preview is available in folder '/F_RAARFS_S05' on project 'P_RAARFS_S05' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S05' project 'P_RAARFS_S05':
| Name            | Approvers    | Deadline         | Reminder         | Description       | Started |
| AS_RAARFS_S05_1 | U_RAARFS_S05 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 | false   |
| AS_RAARFS_S05_2 | U_RAARFS_S05 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description2 | true    |
When I login with details of 'U_RAARFS_S05'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
Then I 'should' see approval stages with the following information:
| Name            | Status  | Deadline         | Reminder         | Description       |
| AS_RAARFS_S05_1 | pending | 5/1/23, 12:15 PM | 5/1/23, 8:00 AM | test description1 |
Then I 'should not' see approval stages with the following information:
| Name            | Status  | Deadline         | Reminder         | Description       |
| AS_RAARFS_S05_2 | pending | 5/1/23, 12:15 PM | 5/1/23, 8:00 AM| test description2 |



Scenario: Check that approval owner can approve/reject whole stage (force approval)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @approvals
Given I created users with following fields:
| Email       | Role        | Access            |
| <UserEmail> | agency.user | folders,approvals |
And created '<ProjectName>' project
And created '/F_RAARFS_S06' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S06' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S06' on project '<ProjectName>' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S06' project '<ProjectName>':
| Name          | Approvers   | Description      | Started |
| AS_RAARFS_S06 | <UserEmail> | test description | true    |
When I '<Action>' stage 'AS_RAARFS_S06' with comment 'test comment' on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S06' project '<ProjectName>'
And refresh the page
Then I 'should' see approval stages with the following information:
| Name          | Status           |
| AS_RAARFS_S06 | <ExpectedStatus> |
And 'should not' see approvals buttons for stage 'AS_RAARFS_S06' on opened file approvals page

Examples:
| UserEmail      | ProjectName    | Action  | ExpectedStatus |
| U_RAARFS_S06_1 | P_RAARFS_S06_1 | Approve | approved       |
| U_RAARFS_S06_2 | P_RAARFS_S06_2 | Reject  | rejected       |


Scenario: Check that stage owner can approve/reject whole stage (force approval)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       | Role        | Access                      |
| <UserEmail> | agency.user | folders,approvals,dashboard |
And created '<ProjectName>' project
And created '/F_RAARFS_S07' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S07' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S07' on project '<ProjectName>' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S07' project '<ProjectName>':
| Name          | Approvers   | Deadline         | Description      | Owner       | Started |
| AS_RAARFS_S07 | <UserEmail> | 01/05/2023 12:15 | test description | <UserEmail> | true    |
When I login with details of '<UserEmail>'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And '<Action>' file with comment 'test comment' on opened file info page
Then I 'should' see approval stages with the following information:
| Name          | Status           | Deadline         | Description      |
| AS_RAARFS_S07 | <ExpectedStatus> | 5/1/23, 12:15 PM | test description |
And 'should not' see approvals buttons for stage 'AS_RAARFS_S07' on opened file approvals page

Examples:
| UserEmail      | ProjectName    | Action  | ExpectedStatus |
| U_RAARFS_S07_1 | P_RAARFS_S07_1 | Approve | approved       |
| U_RAARFS_S07_2 | P_RAARFS_S07_2 | Reject  | rejected       |


Scenario: Check that in case of multiply files approvals each file has stage with the same settings
!-- NGN-747 Send multiple files for approval at once
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @approvals
Given I created users with following fields:
| Email       | Role        | Access            |
| <UserEmail> | agency.user | folders,approvals |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_RAARFS_S08' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAARFS_S08' folder for '<ProjectName>' project
And uploaded '/files/image11.jpg' file into '/F_RAARFS_S08' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S08' on project '<ProjectName>' files page
When I select file 'image10.jpg,image11.jpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Create new approval on Submit files for approval popup
And fill approval stage on opened Add a new Stage popup with following information:
| Name          | Approvers   | Deadline         | Description      |
| AS_RAARFS_S08 | <UserEmail> | 01/05/2023 12:15 | test description |
And click '<Button>' element on opened Add a new Stage popup
Then I 'should' see 'image10.jpg,image11.jpg' file on tab '<ApprovalsTab>' on project '<ProjectName>' approvals page

Examples:
| UserEmail      | ProjectName    | Button         | ApprovalsTab |
| U_RAARFS_S08_1 | P_RAARFS_S08_1 | Save and close | Not started  |
| U_RAARFS_S08_2 | P_RAARFS_S08_2 | Start          | Submitted    |


Scenario: Check warning message if file has already had approvals stage
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email        | Role        | Access            |
| U_RAARFS_S09 | agency.user | folders,approvals |
And added user 'U_RAARFS_S09' into address book
And created 'P_RAARFS_S09' project
And created '/F_RAARFS_S09' folder for project 'P_RAARFS_S09'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S09' folder for 'P_RAARFS_S09' project
And waited while preview is available in folder '/F_RAARFS_S09' on project 'P_RAARFS_S09' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S09' project 'P_RAARFS_S09':
| Name          | Approvers    | Deadline         | Description      | Owner        | Started |
| AS_RAARFS_S09 | U_RAARFS_S09 | 01/05/2023 12:15 | test description | U_RAARFS_S09 | true    |
When I select file 'Fish Ad.mov' on project files page
And click Send for Approval button in More dropdown on project files page
And click Create new approval on Submit files for approval popup
And fill approval stage on opened Add a new Stage popup with following information:
| Deadline         |
| 01/05/2023 12:15 |
And click 'Save and close' element on opened Add a new Stage popup without delay
Then I should see message warning 'File 'Fish Ad.mov' already has approval. Please deselect this file and try again.'

Scenario: Check that stage becomes approved after all approvals are given ('Multiple Approval Stage' mode - default value)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @approvals
Given I created users with following fields:
| Email          | Role        | Access                      |
| U_RAARFS_S10_1 | agency.user | folders,approvals,dashboard |
| U_RAARFS_S10_2 | agency.user | folders,approvals,dashboard |
And created 'P_RAARFS_S10' project
And created '/F_RAARFS_S10' folder for project 'P_RAARFS_S10'
And uploaded '/files/image10.jpg' file into '/F_RAARFS_S10' folder for 'P_RAARFS_S10' project
And waited while preview is available in folder '/F_RAARFS_S10' on project 'P_RAARFS_S10' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAARFS_S10' project 'P_RAARFS_S10':
| Name          | Approvers                     | Description      | Started |
| AS_RAARFS_S10 | U_RAARFS_S10_1,U_RAARFS_S10_2 | test description | true    |
When I login with details of 'U_RAARFS_S10_1'
And click file 'image10.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
When I login with details of 'U_RAARFS_S10_2'
And click file 'image10.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And go to file 'image10.jpg' approvals page in folder '/F_RAARFS_S10' project 'P_RAARFS_S10'
Then I 'should' see approval stages with the following information:
| Name          | Status   |
| AS_RAARFS_S10 | Approved |


Scenario: Check that stage becomes rejected if one of user reject the file ('Multiple Approval Stage' mode)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email          | Role        | Access                      |
| U_RAARFS_S11_1 | agency.user | folders,approvals,dashboard |
| U_RAARFS_S11_2 | agency.user | folders,approvals,dashboard |
And created 'P_RAARFS_S11' project
And created '/F_RAARFS_S11' folder for project 'P_RAARFS_S11'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S11' folder for 'P_RAARFS_S11' project
And waited while preview is available in folder '/F_RAARFS_S11' on project 'P_RAARFS_S11' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S11' project 'P_RAARFS_S11':
| Name          | Approvers                     | Deadline         | Description      | Started |
| AS_RAARFS_S11 | U_RAARFS_S11_1,U_RAARFS_S11_2 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_RAARFS_S11_1'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
When I login with details of 'U_RAARFS_S11_2'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'reject' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And go to file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S11' project 'P_RAARFS_S11'
Then I 'should' see approval stages with the following information:
| Name          | Status   | Deadline         | Description      |
| AS_RAARFS_S11 | Rejected | 5/1/23, 12:15 PM | test description |


Scenario: Check that stage becomes approved after one of members gave approval ('Single Approval Stage' mode)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email          | Role        | Access                      |
| U_RAARFS_S12_1 | agency.user | folders,approvals,dashboard |
| U_RAARFS_S12_2 | agency.user | folders,approvals,dashboard |
And created 'P_RAARFS_S12' project
And created '/F_RAARFS_S12' folder for project 'P_RAARFS_S12'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S12' folder for 'P_RAARFS_S12' project
And waited while preview is available in folder '/F_RAARFS_S12' on project 'P_RAARFS_S12' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S12' project 'P_RAARFS_S12':
| Name          | Approvers                     | Deadline         | Description      | SingleApproval | Started |
| AS_RAARFS_S12 | U_RAARFS_S12_1,U_RAARFS_S12_2 | 01/05/2023 12:15 | test description | true           | true    |
When I login with details of 'U_RAARFS_S12_1'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And go to file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S12' project 'P_RAARFS_S12'
Then I 'should' see approval stages with the following information:
| Name          | Status   | Deadline         | Description      |
| AS_RAARFS_S12 | Approved | 5/1/23, 12:15 PM | test description |


Scenario: Check that all pending approvals removed after moving to another folder/project
Meta: @skip
      @gdam
Given I created users with following fields:
| Email        | Agency        |
| U_RAARFS_S13 | DefaultAgency |
And created 'P_RAARFS_S13_1' project
And created 'P_RAARFS_S13_2' project
And created '/F_RAARFS_S13' folder for project 'P_RAARFS_S13_1'
And created '/F_RAARFS_S13' folder for project 'P_RAARFS_S13_2'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S13' folder for 'P_RAARFS_S13_1' project
And waited while preview is available in folder '/F_RAARFS_S13' on project 'P_RAARFS_S13_1' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S13' project 'P_RAARFS_S13_1':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S13 | U_RAARFS_S13 | 01/05/2023 12:15 | true    |
And on project 'P_RAARFS_S13_1' folder '/F_RAARFS_S13' page
And clicked on Want to move files to another project link on move/copy file 'Fish Ad.mov' popup
And entered 'P_RAARFS_S13_2' in search field on move/copy file popup
And selected folder 'F_RAARFS_S13' on move/copy file popup
And clicked move button on move/copy files popup
And refreshed the page
When I login with details of 'U_RAARFS_S13'
And switch tab to 'Received' for section 'Approvals' on Dashboard page
Then I 'should not' see files 'Fish Ad.mov' in 'Approvals' section on Dashboard page
When I go to projects approvals received page
Then I 'should not' see following approvals on opened project approvals page:
| FileName    | Status  |
| Fish Ad.mov | Pending |


Scenario: Check ability to add users who are not registered in the system to the stage (easy share case)
Meta: @gdam
	  @approvals
!--NGN-7398
Given I created 'P_RAARFS_S14' project
And created '/F_RAARFS_S14' folder for project 'P_RAARFS_S14'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S14' folder for 'P_RAARFS_S14' project
And waited while preview is available in folder '/F_RAARFS_S14' on project 'P_RAARFS_S14' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S14' project 'P_RAARFS_S14':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S14 | U_RAARFS_S14 | 01/05/2023 12:15 | true    |
When I go to file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S14' project 'P_RAARFS_S14'
Then I 'should' see following approvers information in stage 'AS_RAARFS_S14' on opened file approvals page:
| UserName     | Comment      | Status  |
| U_RAARFS_S14 |              | Pending |


Scenario: Check that user from another agency added as approver has access to the file
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email        | Role         | Agency        |
| U_RAARFS_S16 | agency.admin | AnotherAgency |
Given I created 'P_RAARFS_S16' project
And created '/F_RAARFS_S16' folder for project 'P_RAARFS_S16'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S16' folder for 'P_RAARFS_S16' project
And waited while preview is available in folder '/F_RAARFS_S16' on project 'P_RAARFS_S16' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S16' project 'P_RAARFS_S16':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S16 | U_RAARFS_S16 | 01/05/2023 12:15 | true    |
When I login with details of 'U_RAARFS_S16'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And click element 'ApprovalsTab' on page 'FileInfoPage'
Then I 'should' see following approvers information in stage 'AS_RAARFS_S16' on opened file approvals page:
| UserName     | Comment      | Status  |
| U_RAARFS_S16 |              | Pending |
And 'should not' see approvals buttons for stage 'AS_RAARFS_S16' on opened file approvals page


Scenario: Check that in case of two versions of file only last revision can be submitted for approval
Meta: @gdam
	  @approvals
!--NGN-7627
Given I created 'P_RAARFS_S17' project
And created '/F_RAARFS_S17' folder for project 'P_RAARFS_S17'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S17' folder for 'P_RAARFS_S17' project
And waited while preview is available in folder '/F_RAARFS_S17' on project 'P_RAARFS_S17' files page
And uploaded new file version '/files/Fish Ad.mov' for file 'Fish Ad.mov' into '/F_RAARFS_S17' folder for 'P_RAARFS_S17' project
And waited while preview is available in folder '/F_RAARFS_S17' on project 'P_RAARFS_S17' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_RAARFS_S17' project 'P_RAARFS_S17'
And select revision 'Version 1' from Version drop down list
And select tab 'approvals' on opened file info page
Then I 'should' see message 'Navigate to current version for Approval function' instead of approval stage
When I select revision 'Version 2' from Version drop down list
Then I 'should' see elements 'SubmitForApproval,ApplyTemplate' on page 'FilesPage'


Scenario: Check that approver's comments still appears after edit stage
Meta: @gdam
	  @approvals
!--NGN-7944
Given I created users with following fields:
| Email          | Role        | Access                      |
| U_RAARFS_S18_1 | agency.user | folders,approvals,dashboard |
| U_RAARFS_S18_2 | agency.user | folders,approvals,dashboard |
And created 'P_RAARFS_S18' project
And created '/F_RAARFS_S18' folder for project 'P_RAARFS_S18'
And uploaded '/files/Fish Ad.mov' file into '/F_RAARFS_S18' folder for 'P_RAARFS_S18' project
And waited while preview is available in folder '/F_RAARFS_S18' on project 'P_RAARFS_S18' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S18' project 'P_RAARFS_S18':
| Name          | Approvers                     | Deadline         | Started |
| AS_RAARFS_S18 | U_RAARFS_S18_1,U_RAARFS_S18_2 | 01/05/2023 12:15 | true    |
When I login with details of 'U_RAARFS_S18_1'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And go to file 'Fish Ad.mov' approvals page in folder '/F_RAARFS_S18' project 'P_RAARFS_S18'
Then I 'should' see following approvers information in stage 'AS_RAARFS_S18' on opened file approvals page:
| UserName       | Comment      | Status   |
| U_RAARFS_S18_1 | test comment | Approved |
When I update approval stages using the following data:
| Name          | Deadline         | Description         |
| AS_RAARFS_S18 | 01/05/2023 12:15 | test approval stage |
And wait for '2' seconds
Then I 'should' see following approvers information in stage 'AS_RAARFS_S18' on opened file approvals page:
| UserName       | Comment      | Status   |
| U_RAARFS_S18_1 | test comment | Approved |



Scenario: Check that approval owner sees pending status icon on file details page after start stage
Meta: @gdam
	  @approvals
!--NGN-7348
Given I created users with following fields:
| Email        |
| U_RAARFS_S20 |
And added user 'U_RAARFS_S20' into address book
And created 'P_RAARFS_S20' project
And created '/F_RAARFS_S20' folder for project 'P_RAARFS_S20'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S20' folder for 'P_RAARFS_S20' project
And waited while preview is available in folder '/F_RAARFS_S20' on project 'P_RAARFS_S20' files page
When I create approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S20' project 'P_RAARFS_S20':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S20 | U_RAARFS_S20 | 01/05/2023 12:15 | true    |
And wait for '3' seconds
Then I 'should' see approval status icon 'pending' on file '128_shortname.jpg' info page in folder '/F_RAARFS_S20' for project 'P_RAARFS_S20'


Scenario: Check that approval owner sees approval status icon on file details page (other statuses)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       |
| <UserEmail> |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_RAARFS_S21' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S21' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S21' on project '<ProjectName>' files page
And created approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S21' project '<ProjectName>':
| Name                | Approvers   | Deadline         | Reminder         | Description      | Owner       | Started |
| <ApprovalStageName> | <UserEmail> | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | <UserEmail> | true    |
When I '<Action>' stage '<ApprovalStageName>' with comment 'test comment' on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S21' project '<ProjectName>'
Then I 'should' see approval status icon '<ExpectedStatus>' on file '128_shortname.jpg' info page in folder '/F_RAARFS_S21' for project '<ProjectName>'

Examples:
| UserEmail      | ProjectName    | ApprovalStageName | Action  | ExpectedStatus |
| U_RAARFS_S21_1 | P_RAARFS_S21_1 | AS_RAARFS_S21_1   | Approve | approved       |
| U_RAARFS_S21_2 | P_RAARFS_S21_2 | AS_RAARFS_S21_2   | Reject  | rejected       |


Scenario: Check that approval owner sees 'Cancelled' icon on file details
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email        | Role        | Access            |
| U_RAARFS_S22 | agency.user | folders,approvals |
And added user 'U_RAARFS_S22' into address book
And created 'P_RAARFS_S22' project
And created '/F_RAARFS_S22' folder for project 'P_RAARFS_S22'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S22' folder for 'P_RAARFS_S22' project
And waited while preview is available in folder '/F_RAARFS_S22' on project 'P_RAARFS_S22' files page
When I create approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S22' project 'P_RAARFS_S22':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S22 | U_RAARFS_S22 | 01/05/2023 12:15 | true    |
And cancel approval on opened file approvals page
Then I 'should' see approval status icon 'cancelled' on file '128_shortname.jpg' info page in folder '/F_RAARFS_S22' for project 'P_RAARFS_S22'


Scenario: Check that another agency admin sees icon on file details
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email         | Role         | Access            |
| AU_RAARFS_S23 | agency.admin | folders,approvals |
| U_RAARFS_S23  | agency.user  | folders,approvals |
And added user 'U_RAARFS_S23' into address book
And created 'P_RAARFS_S23' project
And created '/F_RAARFS_S23' folder for project 'P_RAARFS_S23'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S23' folder for 'P_RAARFS_S23' project
And waited while preview is available in folder '/F_RAARFS_S23' on project 'P_RAARFS_S23' files page
When I create approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S23' project 'P_RAARFS_S23':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S23 | U_RAARFS_S23 | 01/05/2023 12:15 | true    |
And cancel approval on opened file approvals page
And login with details of 'AU_RAARFS_S23'
Then I 'should' see approval status icon 'cancelled' on file '128_shortname.jpg' info page in folder '/F_RAARFS_S23' for project 'P_RAARFS_S23'


Scenario: Check that approver sees pending icon on file details
Meta: @gdam
	  @approvals
!--NGN-7348
Given I created users with following fields:
| Email        | Role        | Access            |
| U_RAARFS_S24 | agency.user | folders,approvals |
And created 'P_RAARFS_S24' project
And created '/F_RAARFS_S24' folder for project 'P_RAARFS_S24'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S24' folder for 'P_RAARFS_S24' project
And waited while preview is available in folder '/F_RAARFS_S24' on project 'P_RAARFS_S24' files page
When I add approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S24' project 'P_RAARFS_S24':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S24 | U_RAARFS_S24 | 01/05/2023 12:15 | true    |
And filling Share popup by users 'U_RAARFS_S24' in project 'P_RAARFS_S24' folders '/F_RAARFS_S24' with role 'project.user' expired '12.12.2020' and 'should' access to subfolders
And login with details of 'U_RAARFS_S24'
Then I 'should' see approval status icon 'pending' on file '128_shortname.jpg' info page in folder '/F_RAARFS_S24' for project 'P_RAARFS_S24'


Scenario: Check that approver sees approval status icon on file details page
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       | Role        | Access                      |
| <UserEmail> | agency.user | folders,approvals,dashboard |
And created '<ProjectName>' project
And created '/F_RAARFS_S25' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S25' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S25' on project '<ProjectName>' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S25' project '<ProjectName>':
| Name                | Approvers   | Deadline         | Reminder         | Description      | Owner       | Started |
| <ApprovalStageName> | <UserEmail> | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | <UserEmail> | true    |
When I filling Share popup by users '<UserEmail>' in project '<ProjectName>' folders '/F_RAARFS_S25' with role 'project.user' expired '12.12.2020' and 'should' access to subfolders
And login with details of '<UserEmail>'
And click file '128_shortname.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And '<Action>' file with comment 'test comment' on opened file info page
Then I 'should' see approval status icon '<ExpectedStatus>' on file '128_shortname.jpg' info page in folder '/F_RAARFS_S25' for project '<ProjectName>'

Examples:
| UserEmail      | ProjectName    | ApprovalStageName | Action  | ExpectedStatus |
| U_RAARFS_S25_1 | P_RAARFS_S25_1 | AS_RAARFS_S25_1   | Approve | approved       |
| U_RAARFS_S25_2 | P_RAARFS_S25_2 | AS_RAARFS_S25_2   | Reject  | rejected       |


Scenario: Check that approval owner sees icon on folder view
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       | Role        | Access            |
| <UserEmail> | agency.user | folders,approvals |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_RAARFS_S26' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S26' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S26' on project '<ProjectName>' files page
And created approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S26' project '<ProjectName>':
| Name          | Approvers   | Deadline         | Reminder         | Description      | Owner       | Started |
| AS_RAARFS_S26 | <UserEmail> | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | <UserEmail> | true    |
When I '<Action>' stage 'AS_RAARFS_S26' with comment 'test comment' on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S26' project '<ProjectName>'
Then I 'should' see approval status icon '<ExpectedStatus>' in file '128_shortname.jpg' preview on project '<ProjectName>' folder '/F_RAARFS_S26' files page

Examples:
| UserEmail      | ProjectName    | Action  | ExpectedStatus |
| U_RAARFS_S26_1 | P_RAARFS_S26_1 | Approve | approved       |
| U_RAARFS_S26_2 | P_RAARFS_S26_2 | Reject  | rejected       |


Scenario: Check that approver doesn't see project in project list
Meta: @gdam
	  @projects
!--NGN-6315
Given I created users with following fields:
| Email        | Role        | Access            |
| U_RAARFS_S27 | agency.user | folders,approvals |
And created 'P_RAARFS_S27' project
And created '/F_RAARFS_S27' folder for project 'P_RAARFS_S27'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S27' folder for 'P_RAARFS_S27' project
And waited while preview is available in folder '/F_RAARFS_S27' on project 'P_RAARFS_S27' files page
When I add approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S27' project 'P_RAARFS_S27':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S27 | U_RAARFS_S27 | 01/05/2023 12:15 | true    |
And login with details of 'U_RAARFS_S27'
Then I 'should not' see project 'P_RAARFS_S27' on project list page


Scenario: Check that invited user doesn't see project in project list
Meta: @gdam
	  @projects
!--NGN-6513
Given I created 'P_RAARFS_S28' project
And created '/F_RAARFS_S28' folder for project 'P_RAARFS_S28'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S28' folder for 'P_RAARFS_S28' project
And waited while preview is available in folder '/F_RAARFS_S28' on project 'P_RAARFS_S28' files page
When I add approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S28' project 'P_RAARFS_S28':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S28 | U_RAARFS_S28 | 01/05/2023 12:15 | true    |
And open link from email when user 'U_RAARFS_S28' received email with next subject 'You are invited to the Adstream Platform'
And accept new user with first name 'Eric' and last name 'Cartman'
Then I 'should not' see project 'P_RAARFS_S28' on project list page


Scenario: Check that project is not available in search
Meta: @gdam
	  @projects
!--NGN-6513
Given I created users with following fields:
| Email        | Role        | Access            |
| U_RAARFS_S29 | agency.user | folders,approvals |
And created 'P_RAARFS_S29' project
And created '/F_RAARFS_S29' folder for project 'P_RAARFS_S29'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S29' folder for 'P_RAARFS_S29' project
And waited while preview is available in folder '/F_RAARFS_S29' on project 'P_RAARFS_S29' files page
When I add approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S29' project 'P_RAARFS_S29':
| Name          | Approvers    | Deadline         | Started |
| AS_RAARFS_S29 | U_RAARFS_S29 | 01/05/2023 12:15 | true    |
And login with details of 'U_RAARFS_S29'
When I search by text 'P_RAARFS_S29'
Then I 'should not' see search object 'P_RAARFS_S29' with type 'Project' after wrap according to search 'P_RAARFS_S29' with 'Name' type


Scenario: Check that existing templates appear on 'Send for approval' form
Meta: @gdam
	  @projects
!--NGN-9511
Given I created users with following fields:
| Email        |
| U_RAARFS_S30 |
And created approval templates with following information on approval templates page:
| Name          | Description      |
| AT_RAARFS_S30 | test descriprion |
And created new approval stage with following information on opened approval template page:
| Name          | Description      | Approvers    |
| AS_RAARFS_S30 | test descriprion | U_RAARFS_S30 |
And created 'P_RAARFS_S30' project
And created '/F_RAARFS_S30' folder for project 'P_RAARFS_S30'
And uploaded '/files/image10.jpg' file into '/F_RAARFS_S30' folder for 'P_RAARFS_S30' project
And uploaded '/files/image11.jpg' file into '/F_RAARFS_S30' folder for 'P_RAARFS_S30' project
And waited while preview is available in folder '/F_RAARFS_S30' on project 'P_RAARFS_S30' files page
When I select file 'image10.jpg,image11.jpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Apply a template on Submit files for approval popup
Then I 'should' see template 'AT_RAARFS_S30' in available templates list on opened Apply template popup


Scenario: Check that after apply template for group of files each has the same details (check on file details page)
Meta: @gdam
	  @approvals
!--NGN-9511
Given I created users with following fields:
| Email        |
| U_RAARFS_S31 |
And added user 'U_RAARFS_S31' into address book
And created approval templates with following information on approval templates page:
| Name          | Description      |
| AT_RAARFS_S31 | test descriprion |
And created new approval stage with following information on opened approval template page:
| Name          | Description      | Approvers    | Deadline         |
| AS_RAARFS_S31 | test descriprion | U_RAARFS_S31 | 01/05/2023 12:15 |
And created 'P_RAARFS_S31' project
And created '/F_RAARFS_S31' folder for project 'P_RAARFS_S31'
And uploaded '/files/image10.jpg' file into '/F_RAARFS_S31' folder for 'P_RAARFS_S31' project
And uploaded '/files/image11.jpg' file into '/F_RAARFS_S31' folder for 'P_RAARFS_S31' project
And waited while preview is available in folder '/F_RAARFS_S31' on project 'P_RAARFS_S31' files page
When I select file 'image10.jpg,image11.jpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Apply a template on Submit files for approval popup
And select approval template 'AT_RAARFS_S31' on opened select approval template popup
And click Apply Template button on opened select approval template popup
And go to file 'image10.jpg' approvals page in folder '/F_RAARFS_S31' project 'P_RAARFS_S31'
Then I 'should' see following approvers information in stage 'AS_RAARFS_S31' on opened file approvals page:
| UserName     | Comment | Status  |
| U_RAARFS_S31 |         | Pending |
When I go to file 'image11.jpg' approvals page in folder '/F_RAARFS_S31' project 'P_RAARFS_S31'
Then I 'should' see following approvers information in stage 'AS_RAARFS_S31' on opened file approvals page:
| UserName     | Comment | Status  |
| U_RAARFS_S31 |         | Pending |


Scenario: Check that after apply templates for group of files they appear in 'Not started stage' tab (Project -> Approvals page)
Meta: @gdam
	  @approvals
!--NGN-9511
Given I created users with following fields:
| Email        |
| U_RAARFS_S32 |
And created approval templates with following information on approval templates page:
| Name          | Description      |
| AT_RAARFS_S32 | test descriprion |
And created new approval stage with following information on opened approval template page:
| Name          | Description      | Approvers    |
| AS_RAARFS_S32 | test descriprion | U_RAARFS_S32 |
And created 'P_RAARFS_S32' project
And created '/F_RAARFS_S32' folder for project 'P_RAARFS_S32'
And uploaded '/files/image10.jpg' file into '/F_RAARFS_S32' folder for 'P_RAARFS_S32' project
And uploaded '/files/image11.jpg' file into '/F_RAARFS_S32' folder for 'P_RAARFS_S32' project
And waited while preview is available in folder '/F_RAARFS_S32' on project 'P_RAARFS_S32' files page
When I select file 'image10.jpg,image11.jpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Apply a template on Submit files for approval popup
And select approval template 'AT_RAARFS_S32' on opened select approval template popup
And click Apply Template button on opened select approval template popup
When I go to project 'P_RAARFS_S32' approvals not started page
Then I 'should' see following approvals on opened project approvals page:
| FileName    |
| image10.jpg |
| image11.jpg |


Scenario: Check that after upload new revision for rejected approval you see status 'Changes requested' or 'Cancelled' for approved approval
Meta: @gdam
	  @approvals
!--FAB-824 (Bug)
!--NGN-11225
Given I created users with following fields:
| Email        | Role        |
| U_RAARFS_S33 | agency.user |
And created '<ProjectName>' project
And created '/F_RAARFS_S33' folder for project '<ProjectName>'
And uploaded '/files/Fish1-Ad.mov' file into '/F_RAARFS_S33' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S33' on project '<ProjectName>' files page
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_RAARFS_S33' project '<ProjectName>':
| Name                | Approvers    | Deadline         | Description      | Started |
| <ApprovalStageName> | U_RAARFS_S33 | 01/05/2023 12:15 | test description | true    |
When I '<AutocloseAction>' auto close checkbox on file 'Fish1-Ad.mov' approvals page in folder '/F_RAARFS_S33' in project '<ProjectName>'
And go to file 'Fish1-Ad.mov' approvals page in folder '/F_RAARFS_S33' project '<ProjectName>'
And '<Action>' stage '<ApprovalStageName>' with comment 'test comment' on file 'Fish1-Ad.mov' approvals page in folder '/F_RAARFS_S33' project '<ProjectName>'
And upload new file version '/files/GWGTest2.pdf' for file 'Fish1-Ad.mov' into '/F_RAARFS_S33' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_RAARFS_S33' on project '<ProjectName>' files page
And go to file 'Fish1-Ad.mov' version history page in folder '/F_RAARFS_S33' project '<ProjectName>'
Then I 'should' see approval status message '<ApprovalStatusMessage>' for revision '1' on file 'Fish1-Ad.mov' version history page in folder '/F_RAARFS_S33' project '<ProjectName>'

Examples:
| ProjectName    | ApprovalStageName | AutocloseAction | Action  | ApprovalStatusMessage |
| P_RAARFS_S33_1 | AS_RAARFS_S33_1   | check           | reject  | Changes Requested     |
| P_RAARFS_S33_2 | AS_RAARFS_S33_2   | uncheck         | reject  | Changes Requested     |
| P_RAARFS_S33_4 | AS_RAARFS_S33_4   | uncheck         | approve | Approved             |


Scenario: Check that after upload new revision for pending approval you see status 'Cancelled'
!-- Bug QAB-876
Meta: @gdam
       @bug
       @approvals
Given I created users with following fields:
| Email        | Role        |
| U_RAARFS_S34 | agency.user |
And created '<ProjectName>' project
And created '/F_RAARFS_S34' folder for project '<ProjectName>'
And uploaded '/files/Fish1-Ad.mov' file into '/F_RAARFS_S34' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S34' on project '<ProjectName>' files page
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_RAARFS_S34' project '<ProjectName>':
| Name                | Approvers    | Deadline         | Description      | Started |
| <ApprovalStageName> | U_RAARFS_S34 | 01/05/2023 12:15 | test description | true    |
When I go to file 'Fish1-Ad.mov' approvals page in folder '/F_RAARFS_S34' project '<ProjectName>'
And upload new file version '/files/GWGTest2.pdf' for file 'Fish1-Ad.mov' into '/F_RAARFS_S34' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_RAARFS_S34' on project '<ProjectName>' files page
And go to file 'Fish1-Ad.mov' version history page in folder '/F_RAARFS_S34' project '<ProjectName>'
Then I 'should' see approval status message '<ApprovalStatusMessage>' for revision '1' on file 'Fish1-Ad.mov' version history page in folder '/F_RAARFS_S34' project '<ProjectName>'

Examples:
| ProjectName    | ApprovalStageName | ApprovalStatusMessage |
| P_RAARFS_S34_1 | AS_RAARFS_S34_1   | Cancelled             |
| P_RAARFS_S34_2 | AS_RAARFS_S34_2   | Cancelled             |


Scenario: Check that you do not see 'Upload new version' button for approval in 'Approval + Closed' status
Meta: @gdam
	  @projects
!--NGN-10632
Given I created users with following fields:
| Email        | Role        |
| U_RAARFS_S35 | agency.user |
And created 'P_RAARFS_S35' project
And created '/F_RAARFS_S35' folder for project 'P_RAARFS_S35'
And uploaded '/files/image10.jpg' file into '/F_RAARFS_S35' folder for 'P_RAARFS_S35' project
And waited while preview is available in folder '/F_RAARFS_S35' on project 'P_RAARFS_S35' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAARFS_S35' project 'P_RAARFS_S35':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_RAARFS_S35 | U_RAARFS_S35 | 01/05/2023 12:15 | test description | true    |
When I 'check' auto close checkbox on file 'image10.jpg' approvals page in folder '/F_RAARFS_S35' in project 'P_RAARFS_S35'
And go to file 'image10.jpg' approvals page in folder '/F_RAARFS_S35' project 'P_RAARFS_S35'
And 'approve' stage 'AS_RAARFS_S35' with comment 'test comment' on file 'image10.jpg' approvals page in folder '/F_RAARFS_S35' project 'P_RAARFS_S35'
And go to file 'image10.jpg' version history page in folder '/F_RAARFS_S35' project 'P_RAARFS_S35'
And refresh the page without delay
Then I 'should not' see Upload new version button on file 'image10.jpg' info page in folder '/F_RAARFS_S35' project 'P_RAARFS_S35'
And I should see element 'AnnotateButton' on page 'FileInfoPage' in following state 'invisible'


Scenario: Check that icon from previous version of approval is not visible after upload new revision
Meta: @gdam
	  @approvals
!--NGN-10857
Given I created users with following fields:
| Email        | Role        |
| U_RAARFS_S36 | agency.user |
And created '<ProjectName>' project
And created '/F_RAARFS_S36' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAARFS_S36' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S36' on project '<ProjectName>' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAARFS_S36' project '<ProjectName>':
| Name                | Approvers    | Deadline         | Description      | Started |
| <ApprovalStageName> | U_RAARFS_S36 | 01/05/2023 12:15 | test description | true    |
When I '<AutocloseAction>' auto close checkbox on file 'image10.jpg' approvals page in folder '/F_RAARFS_S36' in project '<ProjectName>'
And '<Action>' stage '<ApprovalStageName>' with comment 'test comment' on file 'image10.jpg' approvals page in folder '/F_RAARFS_S36' project '<ProjectName>'
And upload new file version '/files/image11.jpg' for file 'image10.jpg' into '/F_RAARFS_S36' folder for '<ProjectName>' project
And wait while transcoding is finished in folder '/F_RAARFS_S36' on project '<ProjectName>' files page
Then I 'should' see approval status icon '' on file 'image10.jpg' info page in folder '/F_RAARFS_S36' for project '<ProjectName>'

Examples:
| ProjectName    | ApprovalStageName | AutocloseAction | Action  |
| P_RAARFS_S36_1 | AS_RAARFS_S36_1   | check           | reject  |
| P_RAARFS_S36_2 | AS_RAARFS_S36_2   | uncheck         | reject  |
| P_RAARFS_S36_3 | AS_RAARFS_S36_3   | check           | approve |
| P_RAARFS_S36_4 | AS_RAARFS_S36_4   | uncheck         | approve |


Scenario: Check that you can see 'Pending' icon on Project Overview file carousel
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email          | Role        | Access            |
| U_RAARFS_S37_1 | agency.user | folders,approvals |
And added user 'U_RAARFS_S37_1' into address book
And created 'U_RAARFS_S37_1' project
And created '/F_RAARFS_S37' folder for project 'U_RAARFS_S37_1'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S37' folder for 'U_RAARFS_S37_1' project
When I wait while preview is available in folder '/F_RAARFS_S37' on project 'U_RAARFS_S37_1' files page
And create approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S37' project 'U_RAARFS_S37_1':
| Name          | Approvers      | Deadline         | Reminder         | Description      | Owner          | Started |
| AS_RAARFS_S37 | U_RAARFS_S37_1 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | U_RAARFS_S37_1 | true    |
Then I should see on project 'U_RAARFS_S37_1' on file '128_shortname.jpg' following status approval 'pending'


Scenario: Check that you can see icon on Project Overview file carousel (other statuses)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       | Role        | Access            |
| <UserEmail> | agency.user | folders,approvals |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_RAARFS_S38' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S38' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAARFS_S38' on project '<ProjectName>' files page
And created approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S38' project '<ProjectName>':
| Name          | Approvers   | Deadline         | Reminder         | Description      | Owner       | Started |
| AS_RAARFS_S38 | <UserEmail> | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | <UserEmail> | true    |
When I '<Action>' stage 'AS_RAARFS_S38' with comment 'test comment' on file '128_shortname.jpg' approvals page in folder '/F_RAARFS_S38' project '<ProjectName>'
Then I should see on project '<ProjectName>' on file '128_shortname.jpg' following status approval '<ExpectedStatus>'

Examples:
| UserEmail      | ProjectName    | Action  | ExpectedStatus |
| U_RAARFS_S38_1 | P_RAARFS_S38_1 | Approve | approved       |
| U_RAARFS_S38_2 | P_RAARFS_S38_2 | Reject  | rejected       |


Scenario: Check that you do not see approval options for adbanked files (warning message)
Meta: @gdam
	  @approvals
Given I created 'P_RAARFS_S19' project
And created '/F_RAARFS_S19' folder for project 'P_RAARFS_S19'
And uploaded '/files/128_shortname.jpg' file into '/F_RAARFS_S19' folder for 'P_RAARFS_S19' project
And waited while preview is available in folder '/F_RAARFS_S19' on project 'P_RAARFS_S19' files page
When I move file '128_shortname.jpg' from project 'P_RAARFS_S19' folder '/F_RAARFS_S19' to new library page
And go to file '128_shortname.jpg' info page in folder '/F_RAARFS_S19' project 'P_RAARFS_S19' tab approvals
Then I should see 'You don't have a permission to create or see approval' text on approvals tab
