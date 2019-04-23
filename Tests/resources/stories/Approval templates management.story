!--NGN-735 NGN-738
Feature:          Approval templates management
Narrative:
In order to:
As a              AgencyAdmin
I want to         Check approvals template management in Admin area

Scenario: Check that stage saved as template appears on Admin Approvals page
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email     | Agency        |
| U_ATM_S01 | DefaultAgency |
And added user 'U_ATM_S01' into address book
And created 'P_ATM_S01' project
And created '/F_ATM_S01' folder for project 'P_ATM_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_ATM_S01' folder for 'P_ATM_S01' project
And waited while preview is available in folder '/F_ATM_S01' on project 'P_ATM_S01' files page
And on file 'Fish Ad.mov' info page in folder '/F_ATM_S01' project 'P_ATM_S01' tab approvals
And clicked Submit for approval on opened approvals page
And filled approval stage on opened Add a new Stage popup with following information:
| Name       | Approvers | Description      |
| AS_ATM_S01 | U_ATM_S01 | test description |
And clicked 'Save and close' element on opened Add a new Stage popup
And saved approval as template 'AT_ATM_S01' on opened approvals page
When I go to the approval templates page
Then I 'should' see template 'AT_ATM_S01' on approval templates page


Scenario: Check default values for newly created template in (add template functionality on Admin page)
Meta:@gdam
     @approvals
!--NGN-738
Given I created approval templates with following information on approval templates page:
| Name       | Description      |
| AT_ATM_S02 | test descriprion |
Then I 'should' see following information on opened template page:
| FieldName   | FieldValue       |
| Title       | AT_ATM_S02       |
| Description | test descriprion |
And 'should' see approval stages with following information on opened template page:
| Name    | Description | Deadline               | Reminder               |
| Stage 1 |             | No deadline specified. | No reminder specified. |
And 'should' see template 'AT_ATM_S02' on approval templates page


Scenario: Check edit stage details in template in Admin area and saving changes after applying for file
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email       | Agency        |
| U_ATM_S03_1 | DefaultAgency |
| U_ATM_S03_2 | DefaultAgency |
And added users 'U_ATM_S03_1,U_ATM_S03_2' to Address book
And created approval templates with following information on approval templates page:
| Name       | Description      |
| AT_ATM_S03 | test descriprion |
And created approval stage with following information on opened approval template page:
| Name       | Approvers   |
| AS_ATM_S03 | U_ATM_S03_1 |
And created 'P_ATM_S03' project
And created '/F_ATM_S03' folder for project 'P_ATM_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_ATM_S03' folder for 'P_ATM_S03' project
And waited while preview is available in folder '/F_ATM_S03' on project 'P_ATM_S03' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_ATM_S03' project 'P_ATM_S03' tab approvals
And apply approval template 'AT_ATM_S03' on opened approvals page
And update approval stage 'AS_ATM_S03' with following information on 'AT_ATM_S03' approval template page:
| Approvers               |
| U_ATM_S03_1,U_ATM_S03_2 |
And go to file 'Fish Ad.mov' info page in folder '/F_ATM_S03' project 'P_ATM_S03' tab approvals
Then I 'should' see approval stages with the following information:
| Name       | Status | Description |
| AS_ATM_S03 | hidden |             |
And 'should' see following approvers information in stage 'AS_ATM_S03' on opened file approvals page:
| UserName    | Comment | Status  |
| U_ATM_S03_1 |         | Pending |


Scenario: Check that after delete template, it doesn't appear in the list
Meta:@gdam
     @approvals
Given I created approval templates with following information on approval templates page:
| Name       | Description      |
| AT_ATM_S04 | test descriprion |
When I click Delete button on opened approval template page
And click '<Button>' button on opened Removing popup
Then I '<Condition>' see template 'AT_ATM_S04' on approval templates page

Examples:
| Button | Condition  |
| Yes    | should not |
| No     | should     |


Scenario: Check that after delete template it doesn't appear in 'apply template' dropdown on Approvals tab for file
Meta:@gdam
     @approvals
Given I created approval templates with following information on approval templates page:
| Name       | Description      |
| AT_ATM_S05 | test descriprion |
And clicked Delete button on opened approval template page
And clicked '<Button>' button on opened Removing popup
And created 'P_ATM_S05' project
And created '/F_ATM_S05' folder for project 'P_ATM_S05'
And uploaded '/files/Fish Ad.mov' file into '/F_ATM_S05' folder for 'P_ATM_S05' project
And waited while preview is available in folder '/F_ATM_S05' on project 'P_ATM_S05' files page
When I go to file 'Fish Ad.mov' info page in folder '/F_ATM_S05' project 'P_ATM_S05' tab approvals
Then I '<Condition>' see template 'AT_ATM_S05' in available templates list on Apply template popup

Examples:
| Button | Condition  |
| Yes    | should not |
| No     | should     |


Scenario: Check add new stage functionality in template
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email     | Agency        |
| U_ATM_S06 | DefaultAgency |
And created approval templates with following information on approval templates page:
| Name       | Description      |
| AT_ATM_S06 | test descriprion |
When I create new approval stage with following information on opened approval template page:
| Name       | Description      | Approvers |
| AS_ATM_S06 | test descriprion | U_ATM_S06 |
Then I 'should' see approval stages with following information on opened template page:
| Name       | Description      |
| Stage 1    |                  |
| AS_ATM_S06 | test descriprion |


Scenario: Check that 'Remove stage' button is absent in case of one stage in template
Meta:@gdam
     @approvals
!--NGN-7538
Given I created users with following fields:
| Email     | Agency        |
| U_ATM_S06 | DefaultAgency |
And created approval templates with following information on approval templates page:
| Name       | Description      |
| AT_ATM_S06 | test descriprion |
When I create approval stage with following information on opened approval template page:
| Name         | Description      | Approvers |
| AS_ATM_S06_1 | test descriprion | U_ATM_S06 |
When I create approval stage with following information on opened approval template page:
| Name         | Description      | Approvers |
| AS_ATM_S06_2 | test descriprion | U_ATM_S06 |
When I remove approval stage 'AS_ATM_S06_1' on opened approval template page
Then I 'should not' see Remove link on stage 'AS_ATM_S06_1' on opened approval template page
And 'should not' see approval stage 'AS_ATM_S06_1' on opened approval template page
And 'should' see approval stage 'AS_ATM_S06_2' on opened approval template page