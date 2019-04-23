Feature:             User can see action buttons in Folder Columns view
Narrative:
In order to
As a                 AgencyAdmin
I want to            check that user can see action buttons in Folder Columns view


Scenario: check that user see actions buttons across permissions (Edit metadata, Usage Rights, Send for Approval)
Meta:@gdam
@projects
Given I created the agency 'A_UCSABIFC_1' with default attributes
And I created '<RoleName>' role with '<Permissions>' permissions in 'project' group for advertiser 'A_UCSABIFC_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCSABIFC_1_A | agency.admin | A_UCSABIFC_1 |
| <UserEmail>    | guest.user   | A_UCSABIFC_1 |
And logged in with details of 'U_UCSABIFC_1_A'
And created 'P_UCSABIFC_1' project
And created '/F_UCSABIFC_1' folder for project 'P_UCSABIFC_1'
And uploaded 'files/13DV-CAPITAL-10.mpg' file into '/F_UCSABIFC_1' folder for 'P_UCSABIFC_1' project
And waited while preview is available in folder '/F_UCSABIFC_1' on project 'P_UCSABIFC_1' files page
And fill Share popup by users '<UserEmail>' in project 'P_UCSABIFC_1' folders '/F_UCSABIFC_1' with role '<RoleName>' expired '21.12.2021' and 'should not' access to subfolders
When I login with details of '<UserEmail>'
And go to project 'P_UCSABIFC_1' folder '/F_UCSABIFC_1' page
And switch to 'list' view
And select file '13DV-CAPITAL-10.mpg' on project files page
And click element 'MoreButton' on page 'FilesPage'
Then I should see elements on page 'FilesPage' in the following state:
| element              | state                  |
| EditSelectedOneByOne | <EditMetadataState>    |
| EditAllSelected      | <EditMetadataState>    |
| EditUsageRights      | <UsageRightsState>     |
| SendForApproval      | <SendForApprovalState> |

Examples:
| RoleName       | Permissions                                                                                                | UserEmail      | EditMetadataState | UsageRightsState | SendForApprovalState |
| R_UCSABIFC_1_1 | project.read,folder.read,element.read,element.write,element.usage_rights.read,element.usage_rights.write   | U_UCSABIFC_1_1 | enabled           | enabled          | disabled             |
| R_UCSABIFC_1_2 | project.read,folder.read,element.read,element.write,approval.create                                        | U_UCSABIFC_1_2 | enabled           | disabled         | enabled              |
| R_UCSABIFC_1_3 | project.read,folder.read,element.read,element.usage_rights.read,element.usage_rights.write,approval.create | U_UCSABIFC_1_3 | disabled          | enabled          | enabled              |


Scenario: check workflow for edit Usage Rights on folders column view
Meta:@gdam
@projects
Given I created the agency 'A_UCSABIFC_1' with default attributes
And I created 'R_UCSABIFC_2' role with 'project.read,folder.read,element.read,element.usage_rights.read,element.usage_rights.write' permissions in 'project' group for advertiser 'A_UCSABIFC_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCSABIFC_1_A | agency.admin | A_UCSABIFC_1 |
| U_UCSABIFC_2   | guest.user   | A_UCSABIFC_1 |
And logged in with details of 'U_UCSABIFC_1_A'
And created 'P_UCSABIFC_1' project
And created '/F_UCSABIFC_1' folder for project 'P_UCSABIFC_1'
And uploaded 'files/13DV-CAPITAL-10.mpg' file into '/F_UCSABIFC_1' folder for 'P_UCSABIFC_1' project
And waited while preview is available in folder '/F_UCSABIFC_1' on project 'P_UCSABIFC_1' files page
And fill Share popup by users 'U_UCSABIFC_2' in project 'P_UCSABIFC_1' folders '/F_UCSABIFC_1' with role 'R_UCSABIFC_2' expired '21.12.2021' and 'should not' access to subfolders
When I login with details of 'U_UCSABIFC_2'
And go to project 'P_UCSABIFC_1' folder '/F_UCSABIFC_1' page
And switch to 'list' view
And select file '13DV-CAPITAL-10.mpg' on project files page
And I add Batch Usage Right 'Countries' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 02.02.2014 | 20.02.2015     |
Then I 'should' see 'Countries' usage rule with following fields on file '13DV-CAPITAL-10.mpg' and folder '/F_UCSABIFC_1' and project 'P_UCSABIFC_1' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 02.02.2014 | 20.02.2015     |


Scenario: check workflow for Send for Approval on folders column view
Meta:@gdam
@approvals
Given I created the agency 'A_UCSABIFC_1' with default attributes
And I created 'R_UCSABIFC_3' role with 'project.read,folder.read,element.read,approval.create' permissions in 'project' group for advertiser 'A_UCSABIFC_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| U_UCSABIFC_1_A | agency.admin | A_UCSABIFC_1 |
| U_UCSABIFC_3   | guest.user   | A_UCSABIFC_1 |
And logged in with details of 'U_UCSABIFC_1_A'
And created 'P_UCSABIFC_1' project
And created '/F_UCSABIFC_1' folder for project 'P_UCSABIFC_1'
And uploaded 'files/13DV-CAPITAL-10.mpg' file into '/F_UCSABIFC_1' folder for 'P_UCSABIFC_1' project
And waited while preview is available in folder '/F_UCSABIFC_1' on project 'P_UCSABIFC_1' files page
And fill Share popup by users 'U_UCSABIFC_3' in project 'P_UCSABIFC_1' folders '/F_UCSABIFC_1' with role 'R_UCSABIFC_3' expired '21.12.2021' and 'should not' access to subfolders
When I login with details of 'U_UCSABIFC_3'
And add user 'U_UCSABIFC_1_A' to Address book
And go to project 'P_UCSABIFC_1' folder '/F_UCSABIFC_1' page
And switch to 'list' view
And select file '13DV-CAPITAL-10.mpg' on project files page
And click Send for Approval button in More dropdown on project files page
And click Create new approval on Submit files for approval popup
And fill approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers      | Deadline         | Description      |
| AS_UCSABIFC | U_UCSABIFC_1_A | 01/05/2023 12:15 | test description |
And click 'Start' element on opened Add a new Stage popup
Then I 'should' see '13DV-CAPITAL-10.mpg' file on tab 'Submitted' on project 'P_UCSABIFC_1' approvals page