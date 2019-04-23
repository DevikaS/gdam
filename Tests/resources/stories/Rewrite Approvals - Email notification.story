!--NGN-5698 NGN-5816 NGN-7471
Feature:          Rewrite Approvals - Email notification
Narrative:
In order to:
As a              AgencyAdmin
I want to         Check email notifications after start or edit approval stage

Scenario: Check that approver receives email notification after start stage
Meta: @qagdamsmoke
	  @livegdamsmoke
	  @gdam
	  @gdamemails
	  @devopstests
	  @gdamcrossbrowser
Given I created users with following fields:
| Email      | Agency        |
| U_RAEN_S01 | DefaultAgency |
And created 'P_RAEN_S01' project
And created '/F_RAEN_S01' folder for project 'P_RAEN_S01'
And uploaded '/files/logo3.jpg' file into '/F_RAEN_S01' folder for 'P_RAEN_S01' project
And waited while preview is available in folder '/F_RAEN_S01' on project 'P_RAEN_S01' files page
And added approval stage on file 'logo3.jpg' approvals page in folder '/F_RAEN_S01' project 'P_RAEN_S01':
| Name        | Approvers  | Deadline         | Reminder         | Description      | Started |
| AS_RAEN_S01 | U_RAEN_S01 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | true    |
Then I 'should' see email notification for 'Approval request' with field to 'U_RAEN_S01' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail   | UserName    | ApprovalMessage  | ProjectName | FileName  | RequiredDate |
| DefaultAgency | AgencyAdmin | AgencyAdmin | test description | P_RAEN_S01  | logo3.jpg | 01/05/2023   |


Scenario: Check that approver can open approvals stage by the link in email
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |
| U_RAEN_S02 | DefaultAgency |
And created 'P_RAEN_S02' project
And created '/F_RAEN_S02' folder for project 'P_RAEN_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_RAEN_S02' folder for 'P_RAEN_S02' project
And waited while preview is available in folder '/F_RAEN_S02' on project 'P_RAEN_S02' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAEN_S02' project 'P_RAEN_S02':
| Name        | Approvers  | Deadline         | Reminder         | Description      | Started |
| AS_RAEN_S02 | U_RAEN_S02 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | true    |
And logged in with details of 'U_RAEN_S02'
When I open link from email when user 'U_RAEN_S02' received email with next subject 'has requested your approval'
And wait for '5' seconds
Then I 'should' see approvals buttons on opened file details page
And 'should' see approval stages with the following information:
| Name        | Status  | Reminder        | Deadline        | Description      |
| AS_RAEN_S02 | pending | 5/1/23, 8:00 AM | 5/1/23, 12:15 PM| test description |


Scenario: Check that user receives notification after adding for already started stage
Meta: @qagdamsmoke
	  @livegdamsmoke
	  @gdam
	  @gdamemails
Given I created users with following fields:
| Email        | Agency        |
| U_RAEN_S03_1 | DefaultAgency |
| U_RAEN_S03_2 | DefaultAgency |
And added users 'U_RAEN_S03_1,U_RAEN_S03_2' to Address book
And created 'P_RAEN_S03' project
And created '/F_RAEN_S03' folder for project 'P_RAEN_S03'
And uploaded '/files/logo3.jpg' file into '/F_RAEN_S03' folder for 'P_RAEN_S03' project
And waited while preview is available in folder '/F_RAEN_S03' on project 'P_RAEN_S03' files page
And added approval stage on file 'logo3.jpg' approvals page in folder '/F_RAEN_S03' project 'P_RAEN_S03':
| Name        | Approvers    | Deadline         | Reminder         | Description      | Started |
| AS_RAEN_S03 | U_RAEN_S03_1 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | true    |
And on file 'logo3.jpg' approvals page in folder '/F_RAEN_S03' project 'P_RAEN_S03'
When I add the following users to the stage 'AS_RAEN_S03':
| Name         |
| U_RAEN_S03_2 |
And wait for '60' seconds
Then I 'should' see email notification for 'Approval request' with field to 'U_RAEN_S03_2' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail   | UserName    | ApprovalMessage  | ProjectName | FileName  | RequiredDate |
| DefaultAgency | AgencyAdmin | AgencyAdmin | test description | P_RAEN_S03  | logo3.jpg | 01/05/2023   |


Scenario: Check that user from next rank stage receives email notification after previous stage has been approved
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role         | Agency        |
| U_RAEN_S04_1 | agency.admin | DefaultAgency |
| U_RAEN_S04_2 | agency.admin | DefaultAgency |
And created 'P_RAEN_S04' project
And created '/F_RAEN_S04' folder for project 'P_RAEN_S04'
And uploaded '/files/128_shortname.jpg' file into '/F_RAEN_S04' folder for 'P_RAEN_S04' project
And waited while preview is available in folder '/F_RAEN_S04' on project 'P_RAEN_S04' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAEN_S04' project 'P_RAEN_S04':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_RAEN_S04_1 | U_RAEN_S04_1 | 01/05/2023 12:15 | test description | true    |
When I 'uncheck' auto close checkbox on file '128_shortname.jpg' approvals page in folder '/F_RAEN_S04' in project 'P_RAEN_S04'
And login with details of 'U_RAEN_S04_1'
And go to file '128_shortname.jpg' info page in folder '/F_RAEN_S04' project 'P_RAEN_S04'
And 'approve' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And add approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAEN_S04' project 'P_RAEN_S04':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_RAEN_S04_2 | U_RAEN_S04_2 | 01/05/2023 12:15 | test description | true    |
And wait for '60' seconds
Then I 'should' see email notification for 'Approval request' with field to 'U_RAEN_S04_2' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail   | UserName    | ApprovalMessage  | ProjectName | FileName    | RequiredDate |
| DefaultAgency | AgencyAdmin | AgencyAdmin | test description | P_RAEN_S04  | 128_shortname.jpg | 01/05/2023   |



Scenario: Check notification to approval owner after approval stage
Meta: @qagdamsmoke
	  @livegdamsmoke
	  @gdam
	  @gdamemails
Given I created users with following fields:
| Email      | Role         | Agency        |
| U_RAEN_S05 | agency.admin | DefaultAgency |
And created 'P_RAEN_S05' project
And created '/F_RAEN_S05' folder for project 'P_RAEN_S05'
And uploaded '/files/128_shortname.jpg' file into '/F_RAEN_S05' folder for 'P_RAEN_S05' project
And waited while preview is available in folder '/F_RAEN_S05' on project 'P_RAEN_S05' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAEN_S05' project 'P_RAEN_S05':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAEN_S05 | U_RAEN_S05 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_RAEN_S05'
And go to file '128_shortname.jpg' approvals page in folder '/F_RAEN_S05' project 'P_RAEN_S05'
And 'approve' file with comment 'test comment' on opened file info page
Then I 'should' see email notification for 'Approval completed' with field to 'AgencyAdmin' and subject 'has completed' contains following attributes:
| UserName   | Agency        | FileName          | ApprovalStage |
| U_RAEN_S05 | DefaultAgency | 128_shortname.jpg | AS_RAEN_S05   |


Scenario: Check notification to stage owner after changing status of stage
Meta: @gdam
      @gdamemails
Given I created users with following fields:
| Email        | Role         | Agency        |
| U_RAEN_S06_1 | agency.admin | DefaultAgency |
| U_RAEN_S06_2 | agency.admin | DefaultAgency |
And created 'P_RAEN_S06' project
And created '/F_RAEN_S06' folder for project 'P_RAEN_S06'
And uploaded '/files/Fish Ad.mov' file into '/F_RAEN_S06' folder for 'P_RAEN_S06' project
And waited while preview is available in folder '/F_RAEN_S06' on project 'P_RAEN_S06' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAEN_S06' project 'P_RAEN_S06':
| Name        | Approvers                 | Deadline         | Description      | Owner        | Started |
| AS_RAEN_S06 | U_RAEN_S06_1,U_RAEN_S06_2 | 01/05/2023 12:15 | test description | U_RAEN_S06_1 | true    |
When I login with details of 'U_RAEN_S06_2'
And go to file 'Fish Ad.mov' info page in folder '/F_RAEN_S06' project 'P_RAEN_S06'
And 'approve' file with comment 'test comment' on opened file info page
Then I 'should' see email notification for 'Approved by user' with field to 'U_RAEN_S06_1' and subject 'approved' contains following attributes:
| UserName     | Agency        | FileName    | ApprovalStage |
| U_RAEN_S06_2 | DefaultAgency | Fish Ad.mov | AS_RAEN_S06   |


Scenario: Check notification after click 'Send Reminder' button and check Deadline date in email body
Meta: @gdam
      @gdamemails
Given I created users with following fields:
| Email      | Agency        |
| U_RAEN_S07 | DefaultAgency |
And created 'P_RAEN_S07' project
And created '/F_RAEN_S07' folder for project 'P_RAEN_S07'
And uploaded '/files/Fish Ad.mov' file into '/F_RAEN_S07' folder for 'P_RAEN_S07' project
And waited while preview is available in folder '/F_RAEN_S07' on project 'P_RAEN_S07' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAEN_S07' project 'P_RAEN_S07':
| Name        | Approvers  | Deadline         | Reminder         | Description      | Owner      | Started |
| AS_RAEN_S07 | U_RAEN_S07 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description | U_RAEN_S07 | true    |
And on file 'Fish Ad.mov' approvals page in folder '/F_RAEN_S07' project 'P_RAEN_S07'
When I send reminder for 'AS_RAEN_S07' approval stage
Then I 'should' see email notification for 'Approval required reminder' with field to 'U_RAEN_S07' and subject 'Approval required - reminder!' contains following attributes:
| Agency        | UserName    | ApprovalMessage  | ProjectName | FileName    | RequiredDate |
| DefaultAgency | AgencyAdmin | test description | P_RAEN_S07  | Fish Ad.mov | 01/05/2023   |


Scenario: Check reminder notification triggered automatically (by date and time set as Reminder)
Meta: @qagdamsmoke
	  @livegdamsmoke
	  @gdam
	  @gdamemails
Given I created users with following fields:
| Email      | Agency        |
| U_RAEN_S08 | DefaultAgency |
And created 'P_RAEN_S08' project
And created '/F_RAEN_S08' folder for project 'P_RAEN_S08'
And uploaded '/files/128_shortname.jpg' file into '/F_RAEN_S08' folder for 'P_RAEN_S08' project
And waited while preview is available in folder '/F_RAEN_S08' on project 'P_RAEN_S08' files page
And on file '128_shortname.jpg' approvals page in folder '/F_RAEN_S08' project 'P_RAEN_S08'
When I add approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAEN_S08' project 'P_RAEN_S08':
| Name        | Approvers  | Deadline      | Reminder        | Description      | Started |
| AS_RAEN_S08 | U_RAEN_S08 | 1 month since | 2 minutes since | test description | true    |
And wait for '45' seconds
And go to file '128_shortname.jpg' approvals page in folder '/F_RAEN_S08' project 'P_RAEN_S08'
And wait for '45' seconds
And go to file '128_shortname.jpg' approvals page in folder '/F_RAEN_S08' project 'P_RAEN_S08'
And wait for '45' seconds
And go to file '128_shortname.jpg' approvals page in folder '/F_RAEN_S08' project 'P_RAEN_S08'
And wait for '45' seconds
And go to file '128_shortname.jpg' approvals page in folder '/F_RAEN_S08' project 'P_RAEN_S08'
Then I 'should' see email notification for 'Approval required reminder' with field to 'U_RAEN_S08' and subject 'Approval required - reminder!' contains following attributes:
| Agency        | UserName    | ApprovalMessage  | ProjectName | FileName          | RequiredDate  |
| DefaultAgency | AgencyAdmin | test description | P_RAEN_S08  | 128_shortname.jpg | 1 month since |


Scenario: Check notification with empty date fields (no additional letters)
Meta: @gdam
      @gdamemails
Given I created users with following fields:
| Email      | Agency        |
| U_RAEN_S09 | DefaultAgency |
And created 'P_RAEN_S09' project
And created '/F_RAEN_S09' folder for project 'P_RAEN_S09'
And uploaded '/files/Fish Ad.mov' file into '/F_RAEN_S09' folder for 'P_RAEN_S09' project
And waited while preview is available in folder '/F_RAEN_S09' on project 'P_RAEN_S09' files page
When I add approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAEN_S09' project 'P_RAEN_S09':
| Name        | Approvers  | Description      | Started |
| AS_RAEN_S09 | U_RAEN_S09 | test description | true    |
And wait for '60' seconds
Then I 'should' see email notification for 'Approval request' with field to 'U_RAEN_S09' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail   | UserName    | ApprovalMessage  | ProjectName | FileName    | RequiredDate |
| DefaultAgency | AgencyAdmin | AgencyAdmin | test description | P_RAEN_S09  | Fish Ad.mov | 01/05/2023   |
Then I 'should not' see email notification for 'Approval required reminder' with field to 'U_RAEN_S09' and subject 'Approval required - reminder!' contains following attributes: ||


Scenario: Check that remider message is not sent after stage has been approved
Meta: @gdam
      @gdamemails
!--NGN-7483
Given I created users with following fields:
| Email      | Agency        |
| U_RAEN_S10 | DefaultAgency |
And created 'P_RAEN_S10' project
And created '/F_RAEN_S10' folder for project 'P_RAEN_S10'
And uploaded '/files/Fish Ad.mov' file into '/F_RAEN_S10' folder for 'P_RAEN_S10' project
And waited while preview is available in folder '/F_RAEN_S10' on project 'P_RAEN_S10' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAEN_S10' project 'P_RAEN_S10':
| Name        | Approvers  | Deadline      | Reminder       | Description      | Started |
| AS_RAEN_S10 | U_RAEN_S10 | 1 month since | 1 minute since | test description | true    |
When I login with details of 'U_RAEN_S10'
And go to file 'Fish Ad.mov' info page in folder '/F_RAEN_S10' project 'P_RAEN_S10'
And 'approve' file with comment 'test comment' on opened file info page
And wait for '60' seconds
Then I 'should not' see email notification for 'Approval required reminder' with field to 'U_RAEN_S10' and subject 'Approval required - reminder!' contains following attributes: ||


Scenario: Check that filename and Project appear in email if stage created from template
Meta: @gdam
      @gdamemails
!--NGN-7399
Given I created users with following fields:
| Email      | Agency        |
| U_RAEN_S11 | DefaultAgency |
And added user 'U_RAEN_S11' into address book
And created 'P_RAEN_S11' project
And created '/F_RAEN_S11' folder for project 'P_RAEN_S11'
And uploaded '/files/Fish Ad.mov' file into '/F_RAEN_S11' folder for 'P_RAEN_S11' project
And uploaded '/files/Fish1-Ad.mov' file into '/F_RAEN_S11' folder for 'P_RAEN_S11' project
And waited while preview is available in folder '/F_RAEN_S11' on project 'P_RAEN_S11' files page
And on file 'Fish Ad.mov' info page in folder '/F_RAEN_S11' project 'P_RAEN_S11' tab approvals
And clicked Submit for approval on opened approvals page
And filled approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers  | Description      |
| AS_RAEN_S11 | U_RAEN_S11 | test description |
And clicked 'Save and close' element on opened Add a new Stage popup
And saved approval as template 'AT_RAEN_S11' on opened approvals page
And on file 'Fish1-Ad.mov' info page in folder '/F_RAEN_S11' project 'P_RAEN_S11'
And waited for '2' seconds
And selected tab 'approvals' on opened file info page
And applied approval template 'AT_RAEN_S11' on opened approvals page
When I click edit 'AS_RAEN_S11' approval stage
And fill approval stage on opened Add a new Stage popup with following information:
| Deadline         |
| 01/05/2023 12:15 |
And click 'Save and close' element on opened Add a new Stage popup
And click start approval
Then I 'should' see email notification for 'Approval request' with field to 'U_RAEN_S11' and subject 'has requested your approval' contains following attributes:
| Agency        | UserEmail   | UserName    | ApprovalMessage  | ProjectName | FileName    | RequiredDate |
| DefaultAgency | AgencyAdmin | AgencyAdmin | test description | P_RAEN_S11  | Fish1-Ad.mov | 01/05/2023   |


Scenario: Check that From in email is populated from agency settings
Meta: @gdam
      @gdamemails
!--NGN-10185
Given I created the agency 'A_RAEN_S12' with default attributes
And created users with following fields:
| Email       | Role         | Agency     |
| AU_RAEN_S12 | agency.admin | A_RAEN_S12 |
| U_RAEN_S12  | agency.user  | A_RAEN_S12 |
And logged in with details of 'AU_RAEN_S12'
And filled From email field with text 'test@notadstream.com' on system branding page
And clicked save on the system branding page
And created 'P_RAEN_S12' project
And created '/F_RAEN_S12' folder for project 'P_RAEN_S12'
And uploaded '/files/128_shortname.jpg' file into '/F_RAEN_S12' folder for 'P_RAEN_S12' project
And waited while preview is available in folder '/F_RAEN_S12' on project 'P_RAEN_S12' files page
When I add approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAEN_S12' project 'P_RAEN_S12':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAEN_S12 | U_RAEN_S12 | 01/05/2023 12:15 | test description | true    |
Then I 'should' see email notification for 'Approval request' with field to 'U_RAEN_S12' and subject 'has requested your approval' contains following attributes:
| EmailFrom            | Agency     | UserEmail   | UserName    | ApprovalMessage  | ProjectName | FileName          | RequiredDate |
| test@notadstream.com | A_RAEN_S12 | AU_RAEN_S12 | AU_RAEN_S12 | test description | P_RAEN_S12  | 128_shortname.jpg | 01/05/2023   |


Scenario: Check email notification with approver's comments after feedback (to approval owner + empty comment)
Meta: @gdam
      @gdamemails
!--NGN-8733
Given I created users with following fields:
| Email      | Role        | Access                      |
| U_RAEN_S13 | agency.user | folders,approvals,dashboard |
| U_RAEN_S55 | agency.user | folders,approvals,dashboard |
And created '<ProjectName>' project
And created '/F_RAEN_S13' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAEN_S13' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAEN_S13' on project '<ProjectName>' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAEN_S13' project '<ProjectName>':
| Name                |         Approvers     | Deadline       | Reminder      | Started |
| <ApprovalStageName> | U_RAEN_S13,U_RAEN_S55 | 2 months since | 1 month since | true    |
When I login with details of 'U_RAEN_S13'
And click file 'image10.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And '<Action>' file with comment '<FeedbackComment>' on opened file info page
And login with details of 'AgencyAdmin'
Then I 'should' see email notification for 'Approval feedback given' with field to 'AgencyAdmin' and subject '<EmailSubject>' contains following attributes:
| UserName   | ApprovalMessage   | FileName    | ApprovalAction     |
| U_RAEN_S13 | <FeedbackComment> | image10.jpg | <ApprovalFeedback> |

Examples:
| ProjectName  | ApprovalStageName | Action  | FeedbackComment | ApprovalFeedback     | EmailSubject                      |
| P_RAEN_S13_1 | AS_RAEN_S13_1     | Approve | test comment    | approved             | approved image10.jpg              |
| P_RAEN_S13_2 | AS_RAEN_S13_2     | Reject  | test comment    | requested changes to | requested changes to image10.jpg  |
| P_RAEN_S13_3 | AS_RAEN_S13_3     | Approve |                 | approved             | approved image10.jpg              |
| P_RAEN_S13_4 | AS_RAEN_S13_4     | Reject  |                 | requested changes to | requested changes to image10.jpg  |


Scenario: Check email notification to approval owner after change feedback (from Reject to Approve)
Meta: @gdam
      @gdamemails
Given I created users with following fields:
| Email      | Role        | Access                      |
| U_RAEN_S14 | agency.user | folders,approvals,dashboard |
And added user 'U_RAEN_S14' into address book
And created 'P_RAEN_S14' project
And created '/F_RAEN_S14' folder for project 'P_RAEN_S14'
And uploaded '/files/image10.jpg' file into '/F_RAEN_S14' folder for 'P_RAEN_S14' project
And waited while preview is available in folder '/F_RAEN_S14' on project 'P_RAEN_S14' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAEN_S14' project 'P_RAEN_S14':
| Name        | Approvers  | Deadline       | Reminder      | Started |
| AS_RAEN_S14 | U_RAEN_S14 | 2 months since | 1 month since | true    |
When I login with details of 'U_RAEN_S14'
And click file 'image10.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And 'Reject' file with comment 'Reject test comment' on opened file info page
And 'Approve' file with comment 'Approve test comment' on opened file info page
And login with details of 'AgencyAdmin'
Then I 'should' see email notification for 'Approval feedback given' with field to 'AgencyAdmin' and subject 'requested changes to image10.jpg' contains following attributes:
| UserName   | ApprovalMessage     | FileName    | ApprovalAction       |
| U_RAEN_S14 | Reject test comment | image10.jpg | requested changes to |
Then I 'should' see email notification for 'Approval completed' with field to 'AgencyAdmin' and subject 'Approval for file image10.jpg has completed' contains following attributes:
| UserName   | ApprovalStage | ApprovalMessage      | FileName    | ApprovalAction |
| U_RAEN_S14 | AS_RAEN_S14   | Approve test comment | image10.jpg | approved       |


Scenario: Check that user receives only 1 email in case of bulk approval
Meta: @gdam
      @gdamemails
!-- NGN-12894
Given I created users with following fields:
| Email      | Role        | Access                      |
| U_NSLPTG_1 | agency.user | folders,approvals,dashboard |
And added user 'U_NSLPTG_1' into address book
And created 'P_NSLPTG_S1' project
And created 'F_NSLPTG_S1' folder for project 'P_NSLPTG_S1'
And uploaded '/files/image10.jpg' file into 'F_NSLPTG_S1' folder for 'P_NSLPTG_S1' project
And uploaded '/files/image11.jpg' file into 'F_NSLPTG_S1' folder for 'P_NSLPTG_S1' project
And waited while preview is available in folder 'F_NSLPTG_S1' on project 'P_NSLPTG_S1' files page
When I select file 'image10.jpg,image11.jpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Create new approval on Submit files for approval popup
And fill approval stage on opened Add a new Stage popup with following information:
| Approvers   | Deadline         | Description      |
| U_NSLPTG_1  | 01/05/2023 12:15 | test description |
And click 'Start' element on opened Add a new Stage popup
Then I 'should' see only one email with subject 'has requested your approval' sent to 'U_NSLPTG_1'


Scenario: Check that approver after start bulk approvals receives only 1 email (Start from Approvals page)
Meta: @gdam
      @gdamemails
!-- NGN-12894
Given I created users with following fields:
| Email      | Role        | Access                      |
| U_NSLPTG_3 | agency.user | folders,approvals,dashboard |
And added user 'U_NSLPTG_3' into address book
And created 'P_NSLPTG_S3' project
And created 'F_NSLPTG_S3' folder for project 'P_NSLPTG_S3'
And uploaded '/files/image10.jpg' file into 'F_NSLPTG_S3' folder for 'P_NSLPTG_S3' project
And uploaded '/files/image11.jpg' file into 'F_NSLPTG_S3' folder for 'P_NSLPTG_S3' project
And waited while preview is available in folder 'F_NSLPTG_S3' on project 'P_NSLPTG_S3' files page
And selected file 'image10.jpg,image11.jpg' on project files page
And clicked Send for Approval button in More dropdown on project files page
And clicked Create new approval on Submit files for approval popup
And filled approval stage on opened Add a new Stage popup with following information:
| Approvers   | Deadline         | Description      |
| U_NSLPTG_3  | 01/05/2023 12:15 | test description |
And clicked 'Save and close' element on opened Add a new Stage popup
And on projects approvals not started page
When I select 'image10.jpg,image11.jpg' file(s) from folder '/F_NSLPTG_S3' and project 'P_NSLPTG_S3' on opened approvals page
And click start button on opened approvals not started page
Then I 'should' see only one email with subject 'has requested your approval' sent to 'U_NSLPTG_3'


Scenario: Check that after open link from email with batch approval you can go to next approval
Meta: @gdam
!-- 17/08/2015-Confirmed with Maria that this scenario is no longer valid see NGN-16281 comment
Meta: @skip
Given I created users with following fields:
| Email      | Role        | Access                      |
| U_NSLPTG_2 | agency.user | folders,approvals,dashboard |
And added user 'U_NSLPTG_2' into address book
And created 'P_NSLPTG_S2' project
And created 'F_NSLPTG_S2' folder for project 'P_NSLPTG_S2'
And uploaded '/files/image10.jpg' file into 'F_NSLPTG_S2' folder for 'P_NSLPTG_S2' project
And uploaded '/files/image11.jpg' file into 'F_NSLPTG_S2' folder for 'P_NSLPTG_S2' project
And waited while preview is available in folder 'F_NSLPTG_S2' on project 'P_NSLPTG_S2' files page
When I select file 'image10.jpg,image11.jpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Create new approval on Submit files for approval popup
And fill approval stage on opened Add a new Stage popup with following information:
| Approvers   | Deadline         | Description      |
| U_NSLPTG_2  | 01/05/2023 12:15 | test description |
And click 'Start' element on opened Add a new Stage popup
And login with details of 'U_NSLPTG_2'
And open link from email when user 'U_NSLPTG_2' received email with next subject 'has requested your approval'
And navigate to 'next' file on preview file of approvals
Then I 'should' be on current position '2' preview of approvals
And I should be on preview file page of approvals