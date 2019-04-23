!--NGN-7339
Feature: User can see activity about Approvals on Dashboard and Project Overview tab
Narrative:
In order to
As a              AgencyAdmin
I want to         Check activities On Dashboard and Project Overview after approval actions


Scenario: Check that user sees activity after start approval stage on Project Overview tab
Meta:@gdam
@projects
!--13/08 -confirmed with Maria that activity is not visible on dashboard and only on project overview--hence removing that step
Given I created users with following fields:
| Email        | Agency        |
| U_AAODPO_S01 | DefaultAgency |
And created  'P_AAODPO_S01' project
And created '/F_AAODPO_S01' folder for project 'P_AAODPO_S01'
And uploaded '/images/logo.png' file into '/F_AAODPO_S01' folder for 'P_AAODPO_S01' project
And waited while preview is available in folder '/F_AAODPO_S01' on project 'P_AAODPO_S01' files page
And added approval stage on file 'logo.png' approvals page in folder '/F_AAODPO_S01' project 'P_AAODPO_S01':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_AAODPO_S01 | U_AAODPO_S01 | 01/05/2023 12:15 | test description | true    |
When I go to project 'P_AAODPO_S01' overview page
Then I 'should' see activity where user 'AgencyAdmin' has shared for approval 'logo.png' on project 'P_AAODPO_S01' Overview page


Scenario: Check that activity contains link to file with approval
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Agency        |
| U_AAODPO_S02 | DefaultAgency |
And created 'P_AAODPO_S02' project
And created '/F_AAODPO_S02' folder for project 'P_AAODPO_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_AAODPO_S02' folder for 'P_AAODPO_S02' project
And waited while preview is available in folder '/F_AAODPO_S02' on project 'P_AAODPO_S02' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_AAODPO_S02' project 'P_AAODPO_S02':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_AAODPO_S02 | U_AAODPO_S02 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_AAODPO_S02'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And 'Approve' file with comment 'link to file with approval' on opened file info page
And login with details of 'AgencyAdmin'
And I go to Dashboard page
When I go to project 'P_AAODPO_S02' overview page
And click on 'Fish Ad.mov' file in 'has approved' activity on Project Overview page
Then I should see file 'Fish Ad.mov' info page in folder '/F_AAODPO_S02' project 'P_AAODPO_S02'


Scenario: Check activity on file details after approver's feedback
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Agency        | Access                      |
| U_AAODPO_S03 | DefaultAgency | folders,approvals,dashboard |
And created '<Project>' project
And created '/F_AAODPO_S03' folder for project '<Project>'
And uploaded '/files/Fish Ad.mov' file into '/F_AAODPO_S03' folder for '<Project>' project
And waited while preview is available in folder '/F_AAODPO_S03' on project '<Project>' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_AAODPO_S03' project '<Project>':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_AAODPO_S03 | U_AAODPO_S03 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_AAODPO_S03'
And click file 'Fish Ad.mov' in 'Received' tab in 'Approvals' section on dashboard page
And I '<Action>' file with comment 'Approve/Reject Stage' on opened file info page
And login with details of 'AgencyAdmin'
Then I 'should' see activity for user 'U_AAODPO_S03' on file 'Fish Ad.mov' activity tab in project '<Project>' folder '/F_AAODPO_S03' page with message '<Message>' and value ''

Examples:
| Project         | Action  | Message      |
| P_AAODPO_S03Ap  | approve | has approved |
| P_AAODPO_S03Rej | reject  | has rejected |


Scenario: Check that approval owner sees approver's activity on Dashboard after feedback
Meta: @skip
      @gdam
!--13/08: Confirmed with Maria that the activities in this case will only be on project overview and wont be on dashboard. Hence obsolete
Given I created users with following fields:
| Email        | Agency        | Access             |
| U_AAODPO_S04 | DefaultAgency | folders, approvals |
And created '<Project>' project
And created '/F_AAODPO_S04' folder for project '<Project>'
And uploaded '/files/logo3.png' file into '/F_AAODPO_S04' folder for '<Project>' project
And waited while preview is available in folder '/F_AAODPO_S04' on project '<Project>' files page
And added approval stage on file 'logo3.png' approvals page in folder '/F_AAODPO_S04' project '<Project>':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_AAODPO_S04 | U_AAODPO_S04 | 01/05/2023 12:15 | test activity    | true    |
When I login with details of 'U_AAODPO_S04'
And go to projects approvals received page
And select approval by file name 'logo3.png' from folder '/F_AAODPO_S04' and project '<Project>' on opened approvals page
And '<Action>' selected approvals on opened approvals page
And login with details of 'AgencyAdmin'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName       | Message   | Value     |
| U_AAODPO_S04   | <Message> | logo3.png |

Examples:
| Project         | Action  | Message      |
| P_AAODPO_S04Ap  | approve | has approved |
| P_AAODPO_S04Rej | reject  | has rejected |
