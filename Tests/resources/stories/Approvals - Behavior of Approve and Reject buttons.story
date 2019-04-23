!--NGN-10617 NGN-10836
Feature:          Approvals - Behavior of Approve and Reject buttons
Narrative:
In order to:
As a              AgencyAdmin
I want to         test improved behavior of Approve and Reject buttons

Scenario: Check that buttons disappears after approve file (2 approvers)
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email        | Role        | Agency        |
| U_ICBARB_S01 | agency.user | DefaultAgency |
| U_ICBARB_S02 | agency.user | DefaultAgency |
And created 'P_ICBARB_S01_1' project
And created '/F_ICBARB_S01' folder for project 'P_ICBARB_S01_1'
And uploaded '/files/Fish Ad.mov' file into '/F_ICBARB_S01' folder for 'P_ICBARB_S01_1' project
And waited while preview is available in folder '/F_ICBARB_S01' on project 'P_ICBARB_S01_1' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_ICBARB_S01' project 'P_ICBARB_S01_1':
| Name            | Approvers                 | Deadline         | Reminder         | Description       |
| AS_ICBARB_S01_1 | U_ICBARB_S01,U_ICBARB_S02 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 |
When I login with details of 'U_ICBARB_S01'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test description1' on opened file info page
When I login with details of 'U_ICBARB_S02'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test description1' on opened file info page
Then I 'should not' see 'Approve' button disabled on opened approvals page


Scenario: Check that approval disappears on dashboard after reject file (2 approvers)
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email        | Role        | Agency        |
| U_ICBARB_S01 | agency.user | DefaultAgency |
| U_ICBARB_S02 | agency.user | DefaultAgency |
And created 'P_ICBARB_S01_2' project
And created '/F_ICBARB_S01' folder for project 'P_ICBARB_S01_2'
And uploaded '/files/Fish Ad.mov' file into '/F_ICBARB_S01' folder for 'P_ICBARB_S01_2' project
And waited while preview is available in folder '/F_ICBARB_S01' on project 'P_ICBARB_S01_2' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_ICBARB_S01' project 'P_ICBARB_S01_2':
| Name            | Approvers                 | Deadline         | Reminder         | Description       |
| AS_ICBARB_S01_1 | U_ICBARB_S01,U_ICBARB_S02 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 |
When I login with details of 'U_ICBARB_S01'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'reject' file with comment 'test description1' on opened file info page
When I login with details of 'U_ICBARB_S02'
Then I 'should not' see files 'Fish Ad.mov' in 'Approvals' section on Dashboard page


Scenario: Check that user cant see button on opened approvals page
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email          | Agency        |
| U_ICBARB_S02_1 | DefaultAgency |
And created '<Project>' project
And created '/F_ICBARB_S02' folder for project '<Project>'
And uploaded '/files/Fish Ad.mov' file into '/F_ICBARB_S02' folder for '<Project>' project
And waited while preview is available in folder '/F_ICBARB_S02' on project '<Project>' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_ICBARB_S02' project '<Project>':
| Name          | Approvers      |
| AS_ICBARB_S02 | U_ICBARB_S02_1 |
And logged in with details of 'U_ICBARB_S02_1'
When I go to project '<Project>' approvals received page
And select approval by file name 'Fish Ad.mov' from folder '/F_ICBARB_S02' and project '<Project>' on opened approvals page
And '<Action>' selected approvals on opened approvals page
And select approval by file name 'Fish Ad.mov' from folder '/F_ICBARB_S02' and project '<Project>' on opened approvals page
And click open selected button on approvals page
Then I 'should not' see '<Button>' button disabled on opened approvals page

Examples:
| Action  | Button  | Project        |
| approve | Approve | P_ICBARB_S02_1 |
| reject  | Reject  | P_ICBARB_S02_2 |


Scenario: Check buttons behavior in case 1 approver in stage
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email   | Role        | Agency        |
| <Users> | agency.user | DefaultAgency |
And created '<Project>' project
And created '/F_ICBARB_S03' folder for project '<Project>'
And uploaded '/files/Fish Ad.mov' file into '/F_ICBARB_S03' folder for '<Project>' project
And waited while preview is available in folder '/F_ICBARB_S03' on project '<Project>' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_ICBARB_S03' project '<Project>':
| Name            | Approvers | Deadline         | Reminder         | Description       |
| AS_ICBARB_S03_1 | <Users>   | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 |
When I login with details of '<Users>'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And '<Action>' file with comment 'test description1' on opened file info page
Then I 'should' see following approvers information in stage 'AS_ICBARB_S03_1' on opened file approvals page:
| UserName | Comment           | Status   |
| <Users>  | test description1 | <Status> |
And '<State>' see button '<Buttons>' on opened file approvals page

Examples:
| Action  | State      | Buttons | Status   | Users          | Project        |
| Approve | should not | Reject  | Approved | U_ICBARB_S03_1 | P_ICBARB_S03_1 |
| Reject  | should     | Approve | Rejected | U_ICBARB_S03_2 | P_ICBARB_S03_2 |