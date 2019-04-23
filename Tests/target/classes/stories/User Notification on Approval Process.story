!--NGN-5154
Feature:          A5 Dashboard ACL
Narrative:
In order to
As a           AgencyAdmin
I want to         Check A5 Dashboard ACL]

Scenario: Check whether user in notify component and user who sent file for approval receives email
Meta:@gdam
@bug
@gdamemails
!--QAB-887 bug raised
Given I created users with following fields:
| Email      | Agency        |
| U_NPA_01 | DefaultAgency   |
| U_NPA_02 | DefaultAgency   |
| U_NPA_03 | DefaultAgency   |
And logged in with details of 'U_NPA_01'
And added users 'U_NPA_01,U_NPA_02,U_NPA_03' to Address book
And created  'P_NAP_01' project
And created '/F_NAP_01' folder for project 'P_NAP_01'
And uploaded '/images/logo.png' file into '/F_NAP_01' folder for 'P_NAP_01' project
And waited while preview is available in folder '/F_NAP_01' on project 'P_NAP_01' files page
When I go to file 'logo.png' info page in folder '/F_NAP_01' project 'P_NAP_01' tab approvals
And I click Send for Approval button in More dropdown on file approvals page
And fill approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers  | Deadline         | Description      | Started |NotifyUsers|
| AS_NPA_S01  | U_NPA_02   | 01/05/2023 12:15 | test description | true    | U_NPA_03  |
And click 'Start' element on opened Add a new Stage popup
Then I 'should' see email notification for 'Approval request' with field to 'U_NPA_02' and subject 'has requested your approval' contains following attributes:
| Agency                | UserEmail      |ProjectName | FileName          | RequiredDate |
| DefaultAgency         | U_NPA_01       |P_NAP_01    | logo.png          | 01/05/2023   |
When I login with details of 'U_NPA_02'
And go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_01' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_02   | DefaultAgency | logo.png          | AS_NPA_S01   |
And I 'should' see email notification for 'Approval completed' with field to 'U_NPA_03' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_02   | DefaultAgency | logo.png          | AS_NPA_S01    |

Scenario: Check whether user in notify component and users from multiple Bus and easy share users who sent file for approval receives email
Meta:@gdam
@bug
@gdamemails
!--QAB-887 bug raised
Given I created the agency 'A_USRNOTAPPPROCESS_01' with default attributes
And I created the agency 'A_USRNOTAPPPROCESS_02' with default attributes
And I created users with following fields:
| Email        | Agency                  |
| U_NPA_BU1_01 | A_USRNOTAPPPROCESS_01   |
| U_NPA_BU1_02 | A_USRNOTAPPPROCESS_01   |
| U_NPA_BU1_03 | A_USRNOTAPPPROCESS_01   |
And I created users with following fields:
| Email        | Agency                  |
| U_NPA_BU2_01 | A_USRNOTAPPPROCESS_02   |
| U_NPA_BU2_02 | A_USRNOTAPPPROCESS_02   |
And logged in with details of 'U_NPA_BU1_01'
And added users 'U_NPA_BU1_01,U_NPA_BU1_02,U_NPA_BU1_03,U_NPA_BU2_01,U_NPA_BU2_02' to Address book
And created  'P_NAPS2_01' project
And created '/F_NAPS2_01' folder for project 'P_NAPS2_01'
And uploaded '/images/logo.png' file into '/F_NAPS2_01' folder for 'P_NAPS2_01' project
And waited while preview is available in folder '/F_NAPS2_01' on project 'P_NAPS2_01' files page
When I go to file 'logo.png' info page in folder '/F_NAPS2_01' project 'P_NAPS2_01' tab approvals
And I click Send for Approval button in More dropdown on file approvals page
And fill approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers                                | Deadline         | Description      | Started |NotifyUsers                              |
| AS_NPA_APS01  | U_NPA_BU1_02,U_NPA_BU2_01                | 01/05/2023 12:15 | test description | true    | easyshareau1,U_NPA_BU1_03,U_NPA_BU2_02  |
And click 'Start' element on opened Add a new Stage popup
Then I 'should' see email notification for 'Approval request' with field to 'U_NPA_BU1_02' and subject 'has requested your approval' contains following attributes:
| Agency                | UserEmail    | ProjectName | FileName          | RequiredDate |
| A_USRNOTAPPPROCESS_01 | U_NPA_BU1_01 | P_NAPS2_01  | logo.png          | 01/05/2023   |
And I 'should' see email notification for 'Approval request' with field to 'U_NPA_BU2_01' and subject 'has requested your approval' contains following attributes:
| Agency                | UserEmail    | ProjectName | FileName          | RequiredDate |
| A_USRNOTAPPPROCESS_01 | U_NPA_BU1_01 | P_NAPS2_01  | logo.png          | 01/05/2023   |
And I 'should not' see email notification for 'Approval request' with field to 'U_NPA_BU1_03' and subject 'has requested your approval' contains following attributes:
| Agency                | UserEmail    | ProjectName | FileName          | RequiredDate |
| A_USRNOTAPPPROCESS_01 | U_NPA_BU1_01  | P_NAPS2_01  | logo.png          | 01/05/2023   |
And I 'should not' see email notification for 'Approval request' with field to 'U_NPA_BU2_02' and subject 'has requested your approval' contains following attributes:
| Agency                | UserEmail      | ProjectName | FileName          | RequiredDate |
| A_USRNOTAPPPROCESS_01 | U_NPA_BU1_01   | P_NAPS2_01  | logo.png          | 01/05/2023   |
And I 'should' see email notification for 'Invite user' with field to 'easyshareau1' and subject 'You are invited to the Adstream Platform' contains following attributes:
| EmailFrom            | UserEmail    | Agency                |
| test@notadstream.com | easyshareau1 | A_USRNOTAPPPROCESS_01 |
When I login with details of 'U_NPA_BU1_02'
And go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'easyshareau1'
Then I 'should' see email notification for 'Approval completed' with field to 'easyshareau1' and subject 'has completed' contains following attributes:
| UserName       | Agency                | FileName          | ApprovalStage |
| U_NPA_BU1_02   | A_USRNOTAPPPROCESS_01 | logo.png          | AS_NPA_APS01    |
And login with details of 'U_NPA_BU1_03'
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_BU1_03' and subject 'has completed' contains following attributes:
| UserName       | Agency                | FileName          | ApprovalStage |
| U_NPA_BU1_02   | A_USRNOTAPPPROCESS_01 | logo.png          | AS_NPA_APS01    |
And login with details of 'U_NPA_BU2_02'
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_BU2_02' and subject 'has completed' contains following attributes:
| UserName       | Agency                | FileName          | ApprovalStage |
| U_NPA_BU1_02   | A_USRNOTAPPPROCESS_01 | logo.png          | AS_NPA_APS01    |
When I login with details of 'U_NPA_BU2_01'
And go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'easyshareau1'
Then I 'should' see email notification for 'Approval completed' with field to 'easyshareau1' and subject 'has completed' contains following attributes:
| UserName       | Agency                | FileName          | ApprovalStage |
| U_NPA_BU2_01   | A_USRNOTAPPPROCESS_02 | logo.png          | AS_NPA_APS01    |
And login with details of 'U_NPA_BU1_03'
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_BU1_03' and subject 'has completed' contains following attributes:
| UserName       | Agency                | FileName          | ApprovalStage |
| U_NPA_BU2_01   | A_USRNOTAPPPROCESS_02 | logo.png          | AS_NPA_APS01    |
And login with details of 'U_NPA_BU2_02'
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_BU2_02' and subject 'has completed' contains following attributes:
| UserName       | Agency                | FileName          | ApprovalStage |
| U_NPA_BU2_01   | A_USRNOTAPPPROCESS_02 | logo.png          | AS_NPA_APS01    |

Scenario: Check whether user in notify component receives email when approval is cancelled
Meta:@gdam
@bug
@gdamemails
!--QAB-887 bug raised
Given I created users with following fields:
| Email      | Agency          |
| U_NPA_04   | DefaultAgency   |
| U_NPA_05   | DefaultAgency   |
| U_NPA_06   | DefaultAgency   |
And logged in with details of 'U_NPA_04'
And added users 'U_NPA_04,U_NPA_05,U_NPA_06' to Address book
And created  'P_NAP_02' project
And created '/F_NAP_02' folder for project 'P_NAP_02'
And uploaded '/images/logo.png' file into '/F_NAP_02' folder for 'P_NAP_02' project
And waited while preview is available in folder '/F_NAP_02' on project 'P_NAP_02' files page
When I go to file 'logo.png' info page in folder '/F_NAP_02' project 'P_NAP_02' tab approvals
And I click Send for Approval button in More dropdown on file approvals page
And fill approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers  | Deadline         | Description      | Started |NotifyUsers|
| AS_NPA_S02  | U_NPA_05   | 01/05/2023 12:15 | test description | true    | U_NPA_06  |
And click 'Start' element on opened Add a new Stage popup
When I login with details of 'U_NPA_05'
Then I 'should' see email notification for 'Approval request' with field to 'U_NPA_05' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail    | ApprovalMessage  | ProjectName | FileName          | RequiredDate |
| DefaultAgency | U_NPA_04     | test description | P_NAP_02    | logo.png          | 01/05/2023   |
When I go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'cancel' file with comment 'test comment' on opened file info page
And login with details of 'U_NPA_04'
Then I 'should' see email notification for 'Approval cancelled' with field to 'U_NPA_04' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_05   | DefaultAgency | logo.png          | AS_NPA_S02   |
When I login with details of 'U_NPA_06'
Then I 'should' see email notification for 'Approval cancelled' with field to 'U_NPA_06' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_05   | DefaultAgency | logo.png          | AS_NPA_S02    |


Scenario: Check whether user in notify component receives email when approval is Rejected
Meta:@gdam
@bug
@gdamemails
!--QAB-887 bug raised
Given I created users with following fields:
| Email      | Agency          |
| U_NPA_07   | DefaultAgency   |
| U_NPA_08   | DefaultAgency   |
| U_NPA_09   | DefaultAgency   |
And logged in with details of 'U_NPA_07'
And added users 'U_NPA_07,U_NPA_08,U_NPA_09' to Address book
And created  'P_NAP_03' project
And created '/F_NAP_03' folder for project 'P_NAP_03'
And uploaded '/images/logo.png' file into '/F_NAP_03' folder for 'P_NAP_03' project
And waited while preview is available in folder '/F_NAP_03' on project 'P_NAP_03' files page
When I go to file 'logo.png' info page in folder '/F_NAP_03' project 'P_NAP_03' tab approvals
And I click Send for Approval button in More dropdown on file approvals page
And fill approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers  | Deadline         | Description      | Started |NotifyUsers|
| AS_NPA_S03  | U_NPA_08   | 01/05/2023 12:15 | test description | true    | U_NPA_09  |
And click 'Start' element on opened Add a new Stage popup
When I login with details of 'U_NPA_08'
Then I 'should' see email notification for 'Approval request' with field to 'U_NPA_08' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail    | ApprovalMessage  | ProjectName | FileName          | RequiredDate |
| DefaultAgency | U_NPA_07     | test description | P_NAP_03    | logo.png          | 01/05/2023   |
When I go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'reject' file with comment 'test comment' on opened file info page
And login with details of 'U_NPA_07'
Then I 'should' see email notification for 'Approval rejected' with field to 'U_NPA_07' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_08   | DefaultAgency | logo.png          | AS_NPA_S03   |
When I login with details of 'U_NPA_09'
Then I 'should' see email notification for 'Approval rejected' with field to 'U_NPA_09' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_08   | DefaultAgency | logo.png          | AS_NPA_S03    |


Scenario: Check whether user in notify component receives email when approval is created using template
Meta:@gdam
@bug
@gdamemails
!--QAB-887 bug raised
Given I created users with following fields:
| Email      | Agency          |
| U_NPA_10   | DefaultAgency   |
| U_NPA_11   | DefaultAgency   |
| U_NPA_12   | DefaultAgency   |
And logged in with details of 'U_NPA_10'
And added users 'U_NPA_10,U_NPA_11,U_NPA_12' to Address book
And created approval templates with following information on approval templates page:
| Name       | Description      |
| AS_NPA_S04 | test descriprion |
And created new approval stage with following information on opened approval template page:
| Approvers               |NotifyUsers|
| U_NPA_11                | U_NPA_12  |
And created  'P_NAP_03' project
And created '/F_NAP_03' folder for project 'P_NAP_03'
And uploaded '/images/logo.png' file into '/F_NAP_03' folder for 'P_NAP_03' project
And waited while preview is available in folder '/F_NAP_03' on project 'P_NAP_03' files page
When I go to file 'logo.png' info page in folder '/F_NAP_03' project 'P_NAP_03' tab approvals
And apply approval template 'AS_NPA_S04' on opened approvals page
And click start approval
When I login with details of 'U_NPA_11'
Then I 'should' see email notification for 'Approval request' with field to 'U_NPA_11' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail    | ApprovalMessage  | ProjectName | FileName          | RequiredDate |
| DefaultAgency | U_NPA_10     | test description | P_NAP_03    | logo.png          | 01/05/2023   |
When I go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'Approve' file with comment 'test comment' on opened file info page
And login with details of 'U_NPA_10'
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_10' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_11   | DefaultAgency | logo.png          | AS_NPA_S03   |
When I login with details of 'U_NPA_12'
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_12' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_11   | DefaultAgency | logo.png          | AS_NPA_S03    |

Scenario: Check whether user in notify component receives email when approval is created using template and wen approves rejects/Approves
Meta:@gdam
@bug
@gdamemails
!--QAB-887 bug raised
Given I created users with following fields:
| Email      | Agency          |
| U_NPA_13   | DefaultAgency   |
| U_NPA_14   | DefaultAgency   |
| U_NPA_15   | DefaultAgency   |
| U_NPA_16   | DefaultAgency   |
And logged in with details of 'U_NPA_13'
And added users 'U_NPA_13,U_NPA_14,U_NPA_15,U_NPA_16' to Address book
And created approval templates with following information on approval templates page:
| Name       | Description      |
| AS_NPA_S05 | test descriprion |
And created new approval stage with following information on opened approval template page:
| Approvers                        |NotifyUsers|
| U_NPA_14,U_NPA_16                | U_NPA_15  |
And created  'P_NAP_04' project
And created '/F_NAP_04' folder for project 'P_NAP_04'
And uploaded '/images/logo.png' file into '/F_NAP_04' folder for 'P_NAP_04' project
And waited while preview is available in folder '/F_NAP_04' on project 'P_NAP_04' files page
When I go to file 'logo.png' info page in folder '/F_NAP_04' project 'P_NAP_04' tab approvals
And apply approval template 'AS_NPA_S05' on opened approvals page
And click start approval
Then I 'should' see email notification for 'Approval request' with field to 'U_NPA_14' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail    | ApprovalMessage  | ProjectName | FileName          | RequiredDate |
| DefaultAgency | U_NPA_13     | test description | P_NAP_04    | logo.png          | 01/05/2023   |
And I 'should' see email notification for 'Approval request' with field to 'U_NPA_16' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail    | ApprovalMessage  | ProjectName | FileName          | RequiredDate |
| DefaultAgency | U_NPA_13     | test description | P_NAP_04    | logo.png          | 01/05/2023   |
When I login with details of 'U_NPA_16'
And I go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'reject' file with comment 'test comment' on opened file info page
Then I 'should' see email notification for 'Approval rejected' with field to 'U_NPA_13' and subject 'has rejected' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_14   | DefaultAgency | logo.png          | AS_NPA_S05    |
And I 'should' see email notification for 'Approval rejected' with field to 'U_NPA_15' and subject 'has rejected' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_14   | DefaultAgency | logo.png          | AS_NPA_S05    |
When I login with details of 'U_NPA_14'
When I go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'Approve' file with comment 'test comment' on opened file info page
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_13' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_14   | DefaultAgency | logo.png          | AS_NPA_S05   |
And I 'should' see email notification for 'Approval completed' with field to 'U_NPA_15' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_14   | DefaultAgency | logo.png          | AS_NPA_S05    |

Scenario: Check whether user in notify component receives email after editing the approval Stage
Meta:@gdam
@bug
@gdamemails
!--QAB-887 bug raised
Given I created users with following fields:
| Email      | Agency        |
| U_NPA_17 | DefaultAgency   |
| U_NPA_18 | DefaultAgency   |
| U_NPA_19 | DefaultAgency   |
| U_NPA_20 | DefaultAgency   |
| U_NPA_21 | DefaultAgency   |
And logged in with details of 'U_NPA_17'
And added users 'U_NPA_17,U_NPA_18,U_NPA_19' to Address book
And created  'P_NAP_05' project
And created '/F_NAP_05' folder for project 'P_NAP_05'
And uploaded '/images/logo.png' file into '/F_NAP_05' folder for 'P_NAP_05' project
And waited while preview is available in folder '/F_NAP_05' on project 'P_NAP_05' files page
When I go to file 'logo.png' info page in folder '/F_NAP_05' project 'P_NAP_05' tab approvals
And I click Send for Approval button in More dropdown on file approvals page
And fill approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers           | Deadline         | Description      | Started |NotifyUsers|
| AS_NPA_S01  | U_NPA_18,U_NPA_20   | 01/05/2023 12:15 | test description | true    | U_NPA_19  |
And I update approval stages using the following data:
| Name          | NotifyUsers|
| AS_NPA_S01    | U_NPA_21   |
And click 'Start' element on opened Add a new Stage popup
When I login with details of 'U_NPA_18'
Then I 'should' see email notification for 'Approval request' with field to 'U_NPA_18' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail    | ApprovalMessage  | ProjectName | FileName          | RequiredDate |
| DefaultAgency | U_NPA_17     | test description | P_NAP_05    | logo.png          | 01/05/2023   |
And I 'should' see email notification for 'Approval request' with field to 'U_NPA_20' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail    | ApprovalMessage  | ProjectName | FileName          | RequiredDate |
| DefaultAgency | U_NPA_17     | test description | P_NAP_05    | logo.png          | 01/05/2023   |
When I go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
Then I 'should' see email notification for 'Approval completed' with field to 'U_NPA_17' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_18   | DefaultAgency | logo.png          | AS_NPA_S01   |
And I 'should' see email notification for 'Approval completed' with field to 'U_NPA_21' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_18   | DefaultAgency | logo.png          | AS_NPA_S01    |
And I 'should not' see email notification for 'Approval completed' with field to 'U_NPA_19' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_NPA_18   | DefaultAgency | logo.png          | AS_NPA_S01    |
