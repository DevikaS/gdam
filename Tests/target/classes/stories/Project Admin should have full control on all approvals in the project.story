!--NGN-8878
Feature:          Project Admin should have full control on all approvals in the project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that Project Admin have full control on all approvals in the project

Meta:
@component project

Scenario: Check that project admin can add user to the stage (stage created by another user)
Meta:@gdam
@approvals
Given I created users with following fields:
| Email           |
| U_PAHFCOA_S01_1 |
| U_PAHFCOA_S01_2 |
| U_PAHFCOA_S01_3 |
And added user 'U_PAHFCOA_S01_3' into address book
And created 'P_PAHFCOA_S01' project
And created '/F_PAHFCOA_S01' folder for project 'P_PAHFCOA_S01'
And fill Share popup by users 'U_PAHFCOA_S01_1' in project 'P_PAHFCOA_S01' folders '/F_PAHFCOA_S01' with role 'project.contributor' expired '11.11.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_PAHFCOA_S01' folder for 'P_PAHFCOA_S01' project
And waited while preview is available in folder '/F_PAHFCOA_S01' on project 'P_PAHFCOA_S01' files page
And logged in with details of 'U_PAHFCOA_S01_1'
And added user 'U_PAHFCOA_S01_2' into address book
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S01' project 'P_PAHFCOA_S01':
| Name           | Approvers       | Deadline         | Description      | Started |
| AS_PAHFCOA_S01 | U_PAHFCOA_S01_2 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'AgencyAdmin'
And go to file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S01' project 'P_PAHFCOA_S01'
And add the following users to the stage 'AS_PAHFCOA_S01':
| Name            |
| U_PAHFCOA_S01_3 |
And wait for '5' seconds
Then I 'should' see following approvers information in stage 'AS_PAHFCOA_S01' on opened file approvals page:
| UserName        | Comment | Status  |
| U_PAHFCOA_S01_2 |         | Pending |
| U_PAHFCOA_S01_3 |         | Pending |


Scenario: Check that project admin can add user to the stage (stage created by another user)
Meta:@gdam
@approvals
Given I created users with following fields:
| Email           |
| U_PAHFCOA_S02_1 |
| U_PAHFCOA_S02_2 |
| U_PAHFCOA_S02_3 |
And created 'P_PAHFCOA_S02' project
And created '/F_PAHFCOA_S02' folder for project 'P_PAHFCOA_S02'
And fill Share popup by users 'U_PAHFCOA_S02_1' in project 'P_PAHFCOA_S02' folders '/F_PAHFCOA_S02' with role 'project.contributor' expired '11.11.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_PAHFCOA_S02' folder for 'P_PAHFCOA_S02' project
And waited while preview is available in folder '/F_PAHFCOA_S02' on project 'P_PAHFCOA_S02' files page
And logged in with details of 'U_PAHFCOA_S02_1'
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S02' project 'P_PAHFCOA_S02':
| Name           | Approvers       | Deadline         | Description      | Started |
| AS_PAHFCOA_S02 | U_PAHFCOA_S02_2 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'AgencyAdmin'
And add user 'U_PAHFCOA_S02_3' to Address book
And go to file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S02' project 'P_PAHFCOA_S02'
And update approval stages using the following data:
| Name           | Approvers       | Owner           |
| AS_PAHFCOA_S02 | U_PAHFCOA_S02_3 | U_PAHFCOA_S02_3 |
And wait for '5' seconds
Then I 'should' see following owners 'U_PAHFCOA_S02_3' on Advanced Settings popup for stage 'AS_PAHFCOA_S02' on opened file approvals page


Scenario: Check that project admin can add new stage to approvals
Meta:@gdam
@approvals
Given I created users with following fields:
| Email           |
| U_PAHFCOA_S03_1 |
| U_PAHFCOA_S03_2 |
| U_PAHFCOA_S03_3 |
And added user 'U_PAHFCOA_S03_3' to Address book
And created 'P_PAHFCOA_S03' project
And created '/F_PAHFCOA_S03' folder for project 'P_PAHFCOA_S03'
And fill Share popup by users 'U_PAHFCOA_S03_1' in project 'P_PAHFCOA_S03' folders '/F_PAHFCOA_S03' with role 'project.contributor' expired '11.11.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_PAHFCOA_S03' folder for 'P_PAHFCOA_S03' project
And waited while preview is available in folder '/F_PAHFCOA_S03' on project 'P_PAHFCOA_S03' files page
And logged in with details of 'U_PAHFCOA_S03_1'
And waited for '5' seconds
And added user 'U_PAHFCOA_S03_2' to Address book
And waited for '5' seconds
And created approval     stage on file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S03' project 'P_PAHFCOA_S03':
| Name             | Approvers       | Deadline         | Description       |
| AS_PAHFCOA_S03_1 | U_PAHFCOA_S03_2 | 11/11/2023 12:15 | test description1 |
When I login with details of 'AgencyAdmin'
And go to file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S03' project 'P_PAHFCOA_S03'
And wait for '5' seconds
And create approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S03' project 'P_PAHFCOA_S03':
| Name             | Approvers       | Deadline         | Description       |
| AS_PAHFCOA_S03_2 | U_PAHFCOA_S03_3 | 12/12/2023 12:15 | test description2 |
And refresh the page
Then I 'should' see approval stages with the following information:
| Name             | Status | Description       | Deadline           |
| AS_PAHFCOA_S03_1 | hidden | test description1 | 11/11/23, 12:15 PM |
| AS_PAHFCOA_S03_2 | hidden | test description2 | 12/12/23, 12:15 PM |


Scenario: Check that project admin can approve stage
Meta:@gdam
@approvals
Given I created users with following fields:
| Email           |
| U_PAHFCOA_S04_1 |
| U_PAHFCOA_S04_2 |
And created 'P_PAHFCOA_S04' project
And created '/F_PAHFCOA_S04' folder for project 'P_PAHFCOA_S04'
And fill Share popup by users 'U_PAHFCOA_S04_1' in project 'P_PAHFCOA_S04' folders '/F_PAHFCOA_S04' with role 'project.contributor' expired '11.11.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_PAHFCOA_S04' folder for 'P_PAHFCOA_S04' project
And waited while preview is available in folder '/F_PAHFCOA_S04' on project 'P_PAHFCOA_S04' files page
And logged in with details of 'U_PAHFCOA_S04_1'
And added user 'U_PAHFCOA_S04_2' to Address book
And created approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S04' project 'P_PAHFCOA_S04':
| Name           | Approvers       | Deadline         | Description      | Started |
| AS_PAHFCOA_S04 | U_PAHFCOA_S04_2 | 11/11/2023 12:15 | test description | true    |
When I login with details of 'AgencyAdmin'
And go to file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S04' project 'P_PAHFCOA_S04'
And approve stage section 'AS_PAHFCOA_S04' on opened file approvals page
Then I 'should' see approval stages with the following information:
| Name           | Status   | Description      | Deadline           |
| AS_PAHFCOA_S04 | approved | test description | 11/11/23, 12:15 PM |


Scenario: Check that project admin can reject stage
Meta:@gdam
@approvals
Given I created users with following fields:
| Email           |
| U_PAHFCOA_S05_1 |
| U_PAHFCOA_S05_2 |
And created 'P_PAHFCOA_S05' project
And created '/F_PAHFCOA_S05' folder for project 'P_PAHFCOA_S05'
And fill Share popup by users 'U_PAHFCOA_S05_1' in project 'P_PAHFCOA_S05' folders '/F_PAHFCOA_S05' with role 'project.contributor' expired '11.11.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_PAHFCOA_S05' folder for 'P_PAHFCOA_S05' project
And waited while preview is available in folder '/F_PAHFCOA_S05' on project 'P_PAHFCOA_S05' files page
And logged in with details of 'U_PAHFCOA_S05_1'
And added user 'U_PAHFCOA_S05_2' into address book
And created approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S05' project 'P_PAHFCOA_S05':
| Name           | Approvers       | Deadline         | Description      | Started |
| AS_PAHFCOA_S05 | U_PAHFCOA_S05_2 | 11/11/2023 12:15 | test description | true    |
When I login with details of 'AgencyAdmin'
And go to file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S05' project 'P_PAHFCOA_S05'
And reject stage section 'AS_PAHFCOA_S05' on opened file approvals page
Then I 'should' see approval stages with the following information:
| Name           | Status   | Description      | Deadline           |
| AS_PAHFCOA_S05 | rejected | test description | 11/11/23, 12:15 PM |


Scenario: Check that project admin can cancel whole approval with status 'Cancelled + Closed'
Meta:@gdam
@approvals
Given I created users with following fields:
| Email           |
| U_PAHFCOA_S06_1 |
| U_PAHFCOA_S06_2 |
And created 'P_PAHFCOA_S06' project
And created '/F_PAHFCOA_S06' folder for project 'P_PAHFCOA_S06'
And fill Share popup by users 'U_PAHFCOA_S06_1' in project 'P_PAHFCOA_S06' folders '/F_PAHFCOA_S06' with role 'project.contributor' expired '11.11.2022' and 'should' access to subfolders
And uploaded '/files/128_shortname.jpg' file into '/F_PAHFCOA_S06' folder for 'P_PAHFCOA_S06' project
And waited while preview is available in folder '/F_PAHFCOA_S06' on project 'P_PAHFCOA_S06' files page
And logged in with details of 'U_PAHFCOA_S06_1'
And added user 'U_PAHFCOA_S06_2' into address book
And created approval stage on file '128_shortname.jpg' approvals page in folder '/F_PAHFCOA_S06' project 'P_PAHFCOA_S06':
| Name           | Approvers       | Deadline         | Description      | Started |
| AS_PAHFCOA_S06 | U_PAHFCOA_S06_2 | 11/11/2023 12:15 | test description | true    |
When I login with details of 'AgencyAdmin'
And go to file '128_shortname.jpg' approvals page in folder '/F_PAHFCOA_S06' project 'P_PAHFCOA_S06'
And cancel approval on opened file approvals page
And login with details of 'U_PAHFCOA_S06_1'
And go to project 'P_PAHFCOA_S06' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status             | ApprovalStage  |
| 128_shortname.jpg | Cancelled + Closed | AS_PAHFCOA_S06 |


Scenario: Check that project admin can save stage as template
Meta:@gdam
@approvals
Given I created users with following fields:
| Email           |
| U_PAHFCOA_S07_1 |
| U_PAHFCOA_S07_2 |
And created 'P_PAHFCOA_S07' project
And created '/F_PAHFCOA_S07' folder for project 'P_PAHFCOA_S07'
And fill Share popup by users 'U_PAHFCOA_S07_1' in project 'P_PAHFCOA_S07' folders '/F_PAHFCOA_S07' with role 'project.contributor' expired '11.11.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_PAHFCOA_S07' folder for 'P_PAHFCOA_S07' project
And waited while preview is available in folder '/F_PAHFCOA_S07' on project 'P_PAHFCOA_S07' files page
And logged in with details of 'U_PAHFCOA_S07_1'
And added user 'U_PAHFCOA_S07_2' into address book
And created approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S07' project 'P_PAHFCOA_S07':
| Name           | Approvers       | Deadline         | Description      | Started |
| AS_PAHFCOA_S07 | U_PAHFCOA_S07_2 | 11/11/2023 12:15 | test description | true    |
When I login with details of 'AgencyAdmin'
And go to file 'Fish1-Ad.mov' approvals page in folder '/F_PAHFCOA_S07' project 'P_PAHFCOA_S07'
And save approval as template 'AT_PAHFCOA_S07' on opened approvals page
Then I 'should' see template 'AT_PAHFCOA_S07' on approval templates page