!--NGN-5158
Feature:          A5 Dashboard Approval
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 Dashboard Approval

Meta:
@component dashboard

Scenario: check that Submitted approval appear at dashboard
Meta:@approvals
     @gdam
Given I created users with following fields:
| Email        | Role         |
| AU_A5DAP_S01 | agency.admin |
| U_A5DAP_S01  | agency.admin |
And logged in with details of 'AU_A5DAP_S01'
And created 'P_A5DAP_S01' project
And created '/F_A5DAP_S01' folder for project 'P_A5DAP_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DAP_S01' folder for 'P_A5DAP_S01' project
And waited while preview is available in folder '/F_A5DAP_S01' on project 'P_A5DAP_S01' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_A5DAP_S01' project 'P_A5DAP_S01':
| Name         | Approvers   | Deadline         | Description      | Started |
| AS_A5DAP_S01 | U_A5DAP_S01 | 01/05/2023 12:15 | test description | true    |
When I go to Dashboard page
And switch tab to 'Submitted' for section 'Approvals' on Dashboard page
Then I 'should' see files 'Fish Ad.mov' in 'Approvals' section on Dashboard page


Scenario: check that approval appear at received dashboard
Meta:@approvals
     @gdam
Given I created users with following fields:
| Email       | Role         |
| U_A5DAP_S02 | agency.admin |
And created 'P_A5DAP_S02' project
And created '/F_A5DAP_S02' folder for project 'P_A5DAP_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DAP_S02' folder for 'P_A5DAP_S02' project
And waited while preview is available in folder '/F_A5DAP_S02' on project 'P_A5DAP_S02' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_A5DAP_S02' project 'P_A5DAP_S02':
| Name         | Approvers   | Deadline         | Description      | Started |
| AS_A5DAP_S02 | U_A5DAP_S02 | 01/05/2023 12:15 | test description | true    |
And logged in with details of 'U_A5DAP_S02'
When I go to Dashboard page
And switch tab to 'Received' for section 'Approvals' on Dashboard page
Then I 'should' see files 'Fish Ad.mov' in 'Approvals' section on Dashboard page


Scenario: check that link to approval opened file to approve
Meta:@approvals
     @gdam
Given I created users with following fields:
| Email       | Role         |
| U_A5DAP_S03 | agency.admin |
And created 'P_A5DAP_S03' project
And created '/F_A5DAP_S03' folder for project 'P_A5DAP_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DAP_S03' folder for 'P_A5DAP_S03' project
And waited while preview is available in folder '/F_A5DAP_S03' on project 'P_A5DAP_S03' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_A5DAP_S03' project 'P_A5DAP_S03':
| Name         | Approvers   | Deadline         | Description      | Started |
| AS_A5DAP_S03 | U_A5DAP_S03 | 01/05/2023 12:15 | test description | true    |
And logged in with details of 'U_A5DAP_S03'
When I go to Dashboard page
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
Then I 'should' be on the file approvals page


Scenario: check that after approve file for approve disappear at Submitted dashborad when automatically checkbox selected on approval stage
Meta:@approvals
     @gdam
!-- QAB-847
Given I created users with following fields:
| Email        | Role         |
| AU_A5DAP_S04 | agency.admin |
| U_A5DAP_S04  | agency.admin |
And logged in with details of 'AU_A5DAP_S04'
And created 'P_A5DAP_S04' project
And created '/F_A5DAP_S04' folder for project 'P_A5DAP_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DAP_S04' folder for 'P_A5DAP_S04' project
And waited while preview is available in folder '/F_A5DAP_S04' on project 'P_A5DAP_S04' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_A5DAP_S04' project 'P_A5DAP_S04':
| Name         | Approvers   | Deadline         | Description      | Started |
| AS_A5DAP_S04 | U_A5DAP_S04 | 01/05/2023 12:15 | test description | true    |
When I 'check' auto close checkbox on file 'Fish Ad.mov' approvals page in folder '/F_A5DAP_S04' in project 'P_A5DAP_S04'
And wait for '5' seconds
And I login with details of 'U_A5DAP_S04'
And go to file 'Fish Ad.mov' info page in folder '/F_A5DAP_S04' project 'P_A5DAP_S04'
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'AU_A5DAP_S04'
And switch tab to 'Submitted' for section 'Approvals' on Dashboard page
Then I 'should not' see files 'Fish Ad.mov' in 'Approvals' section on Dashboard page


Scenario: check that after approve file for approve not appear at Received dashborad
Meta:@approvals
     @gdam
Given I created users with following fields:
| Email       | Role         | Agency        |
| U_A5DAP_S05 | agency.admin | DefaultAgency |
And created 'P_A5DAP_S05' project
And created '/F_A5DAP_S05' folder for project 'P_A5DAP_S05'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DAP_S05' folder for 'P_A5DAP_S05' project
And waited while preview is available in folder '/F_A5DAP_S05' on project 'P_A5DAP_S05' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_A5DAP_S05' project 'P_A5DAP_S05':
| Name         | Approvers   | Deadline         | Description      | Started |
| AS_A5DAP_S05 | U_A5DAP_S05 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_A5DAP_S05'
And go to file 'Fish Ad.mov' info page in folder '/F_A5DAP_S05' project 'P_A5DAP_S05'
And 'approve' file with comment 'test comment' on opened file info page
And go to Dashboard page
And switch tab to 'Received' for section 'Approvals' on Dashboard page
Then I 'should not' see files 'Fish Ad.mov' in 'Approvals' section on Dashboard page

Scenario: check that after approve file for approve appear at Submitted dashborad when automatically checkbox not selected on approval stage
Meta:@approvals
     @gdam
!-- QAB-847
Given I created users with following fields:
| Email        | Role         |
| AU_A5DAP_S06 | agency.admin |
| U_A5DAP_S06  | agency.admin |
And logged in with details of 'AU_A5DAP_S06'
And created 'P_A5DAP_S06' project
And created '/F_A5DAP_S06' folder for project 'P_A5DAP_S06'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DAP_S06' folder for 'P_A5DAP_S06' project
And waited while preview is available in folder '/F_A5DAP_S06' on project 'P_A5DAP_S06' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_A5DAP_S06' project 'P_A5DAP_S06':
| Name         | Approvers   | Deadline         | Description      | Started |
| AS_A5DAP_S06 | U_A5DAP_S06 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_A5DAP_S06'
And go to file 'Fish Ad.mov' info page in folder '/F_A5DAP_S06' project 'P_A5DAP_S06'
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'AU_A5DAP_S06'
And switch tab to 'Submitted' for section 'Approvals' on Dashboard page
Then I 'should' see files 'Fish Ad.mov' in 'Approvals' section on Dashboard page