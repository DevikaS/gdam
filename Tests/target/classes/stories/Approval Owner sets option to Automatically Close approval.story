!-- NGN-10784
Feature:          Approval Owner sets option to Automatically Close approval
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check Automatically Close approval option for approval


Scenario: Check that 'Automatically close approval' checkbox is off by default
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email          | Role         |
| U_AOSOTACA_S01 | agency.admin |
And added user 'U_AOSOTACA_S01' into address book
And created 'P_AOSOTACA_S01' project
And created '/F_AOSOTACA_S01' folder for project 'P_AOSOTACA_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_AOSOTACA_S01' folder for 'P_AOSOTACA_S01' project
And waited while preview is available in folder '/F_AOSOTACA_S01' on project 'P_AOSOTACA_S01' files page
When create approval stage on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S01' project 'P_AOSOTACA_S01':
| Name             | Approvers       | Deadline         | Description       | Started |
| AS_AOSOTACA_S01  | U_AOSOTACA_S01  | 12/12/2023 12:15 | test description2 | true    |
Then I should see elements on page 'ProjectFileApproval' in the following state:
| element           | state     |
| AutoCloseCheckbox | unselected  |


Scenario: Check that 'Automatically close approval' checkbox is not visible for approver
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email          | Role         |
| U_AOSOTACA_S02 | agency.admin |
And created 'P_AOSOTACA_S02' project
And created '/F_AOSOTACA_S02' folder for project 'P_AOSOTACA_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_AOSOTACA_S02' folder for 'P_AOSOTACA_S02' project
And waited while preview is available in folder '/F_AOSOTACA_S02' on project 'P_AOSOTACA_S02' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S02' project 'P_AOSOTACA_S02':
| Name            | Approvers      | Started |
| AS_AOSOTACA_S02 | U_AOSOTACA_S02 | true    |
When login with details of 'U_AOSOTACA_S02'
And go to file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S02' project 'P_AOSOTACA_S02'
Then I should see element 'AutoCloseCheckbox' on page 'ProjectFileApproval' in following state 'invisible'

Scenario: Check that stage is closed after approval with ticked 'Automatically close approval' checkbox (approver)
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email          | Role         |
| U_AOSOTACA_S03 | agency.admin |
And created 'P_AOSOTACA_S03' project
And created '/F_AOSOTACA_S03' folder for project 'P_AOSOTACA_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_AOSOTACA_S03' folder for 'P_AOSOTACA_S03' project
And waited while preview is available in folder '/F_AOSOTACA_S03' on project 'P_AOSOTACA_S03' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S03' project 'P_AOSOTACA_S03':
| Name            | Approvers      | Started |
| AS_AOSOTACA_S03 | U_AOSOTACA_S03 | true    |
When I 'check' auto close checkbox on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S03' in project 'P_AOSOTACA_S03'
When login with details of 'U_AOSOTACA_S03'
And go to file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S03' project 'P_AOSOTACA_S03'
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And go to project 'P_AOSOTACA_S03' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status            | ApprovalStage     |
| Fish Ad.mov       | Approved + Closed | AS_AOSOTACA_S03   |

Scenario: Check that stage is closed after force approval by approval ower  (checkbox is on) (file info)
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email          | Role         |
| U_AOSOTACA_S04 | agency.admin |
And created 'P_AOSOTACA_S04' project
And created '/F_AOSOTACA_S04' folder for project 'P_AOSOTACA_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_AOSOTACA_S04' folder for 'P_AOSOTACA_S04' project
And waited while preview is available in folder '/F_AOSOTACA_S04' on project 'P_AOSOTACA_S04' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S04' project 'P_AOSOTACA_S04':
| Name            | Approvers      | Started |
| AS_AOSOTACA_S04 | U_AOSOTACA_S04 | true    |
When I 'check' auto close checkbox on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S04' in project 'P_AOSOTACA_S04'
When I 'approve' stage 'AS_AOSOTACA_S04' with comment 'test comment' on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S04' project 'P_AOSOTACA_S04'
And go to project 'P_AOSOTACA_S04' approvals submitted page
Then I should see element 'CloseButton' on page 'ProjectFileApproval' in following state 'invisible'
And I should see element 'CancelButton' on page 'ProjectFileApproval' in following state 'invisible'
And I 'should' see following approvals on opened project approvals page:
| FileName          | Status            | ApprovalStage     |
| Fish Ad.mov       | Approved + Closed | AS_AOSOTACA_S04   |


Scenario: Check that stage is closed automatically after approve from Received tab (Projects -> Approval page checkbox is on)(approver )
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email          | Role         |
| U_AOSOTACA_S05 | agency.admin |
And created 'P_AOSOTACA_S05' project
And created '/F_AOSOTACA_S05' folder for project 'P_AOSOTACA_S05'
And uploaded '/files/Fish Ad.mov' file into '/F_AOSOTACA_S05' folder for 'P_AOSOTACA_S05' project
And waited while preview is available in folder '/F_AOSOTACA_S05' on project 'P_AOSOTACA_S05' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S05' project 'P_AOSOTACA_S05':
| Name            | Approvers      | Started |
| AS_AOSOTACA_S05 | U_AOSOTACA_S05 | true    |
When I 'check' auto close checkbox on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S05' in project 'P_AOSOTACA_S05'
When login with details of 'U_AOSOTACA_S05'
And I go to project 'P_AOSOTACA_S05' approvals received page
And select approval by file name 'Fish Ad.mov' from folder '/F_AOSOTACA_S05' and project 'P_AOSOTACA_S05' on opened approvals page
And 'approve' selected approvals on opened approvals page
And login with details of 'AgencyAdmin'
And go to project 'P_AOSOTACA_S05' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status            | ApprovalStage     |
| Fish Ad.mov       | Approved + Closed | AS_AOSOTACA_S05   |


Scenario: Check that approval with 'Automatically close approval' is off left in Approval state (File info) OR status = Approved
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email          | Role         |
| U_AOSOTACA_S06 | agency.admin |
And created 'P_AOSOTACA_S06' project
And created '/F_AOSOTACA_S06' folder for project 'P_AOSOTACA_S06'
And uploaded '/files/Fish Ad.mov' file into '/F_AOSOTACA_S06' folder for 'P_AOSOTACA_S06' project
And waited while preview is available in folder '/F_AOSOTACA_S06' on project 'P_AOSOTACA_S06' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S06' project 'P_AOSOTACA_S06':
| Name            | Approvers      | Started |
| AS_AOSOTACA_S06 | U_AOSOTACA_S06 | true    |
When I 'uncheck' auto close checkbox on file 'Fish Ad.mov' approvals page in folder '/F_AOSOTACA_S06' in project 'P_AOSOTACA_S06'
And approve stage section 'AS_AOSOTACA_S06' on opened file approvals page
And go to project 'P_AOSOTACA_S06' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status   |
| Fish Ad.mov | Approved |