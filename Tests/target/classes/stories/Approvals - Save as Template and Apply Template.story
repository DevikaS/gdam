!-- NGN-5796
Feature:         Approvals - Save as Template and Apply Template
Narrative:
In order to
As a           AgencyAdmin
I want to     Check save as template and apply template functionality

Scenario: Check that stage template cannot be save with empty name
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email    | Role        |
| AppT_u1  | agency.user |
And added user 'AppT_u1' into address book
And created 'ApTempl_P1' project
And created '/AppTempl_F1' folder for project 'ApTempl_P1'
And uploaded '/images/logo.png' file into '/AppTempl_F1' folder for 'ApTempl_P1' project
And waited while preview is available in folder '/AppTempl_F1' on project 'ApTempl_P1' files page
And on file 'logo.png' info page in folder '/AppTempl_F1' project 'ApTempl_P1' tab approvals
And clicked Submit for approval on opened approvals page
And filled approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers | Description      |
| AppT_Stage1 | AppT_u1   | test description |
And clicked 'save and close' element on opened Add a new Stage popup
When I click button save as an template on approval page
And click Save button on save as an approval template pop up
Then I 'should' see red field name on pop-up


Scenario: Check that saved template appears in the dropdown list on 'Select an approval template' pop up
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email      | Agency        |
| AppT_u2    | DefaultAgency |
And created 'ApTempl_P2' project
And created '/AppTempl_F2' folder for project 'ApTempl_P2'
And I uploaded into project 'ApTempl_P2' following files:
| FileName           | Path         |
| /images/logo.png   | /AppTempl_F2 |
| /files/Fish Ad.mov | /AppTempl_F2 |
And waited while preview is available in folder '/AppTempl_F2' on project 'ApTempl_P2' files page
And added approval stage on file 'logo.png' approvals page in folder '/AppTempl_F2' project 'ApTempl_P2':
| Name       | Approvers | Description       | Started |
| ApTemp_St2 | AppT_u2   | Applying template | true    |
And on file 'logo.png' approvals page in folder '/AppTempl_F2' project 'ApTempl_P2'
And saved approval as template 'Ap_templ1' on opened approvals page
And waited for '2' seconds
And I am on project 'ApTempl_P2' files page
When I go to file 'Fish Ad.mov' info page in folder '/AppTempl_F2' project 'ApTempl_P2' tab approvals
And clicked Apply a template on opened approvals page
And wait for '3' seconds
Then I 'should' see template 'Ap_templ1' in available templates list on Apply template popup


Scenario: Check that all data appears in stage after applying stage template
Meta:@gdam
     @approvals
Given I created users with following fields:
| Name    | Roles       |
| AppT_u3 | agency.user |
| AppT_u4 | guest       |
And created 'ApTempl_P3' project
And created '/AppTempl_F3' folder for project 'ApTempl_P3'
And I uploaded into project 'ApTempl_P3' following files:
| FileName            | Path         |
| /images/logo.png    | /AppTempl_F3 |
| /images/SB_Logo.png | /AppTempl_F3 |
And waited while preview is available in folder '/AppTempl_F3' on project 'ApTempl_P3' files page
And added approval stage on file 'SB_Logo.png' approvals page in folder '/AppTempl_F3' project 'ApTempl_P3':
| Name       | Approvers       | Description           | Started |
| ApTemp_St3 | AppT_u3,AppT_u4 | Check all data safety | true    |
And on file 'SB_Logo.png' approvals page in folder '/AppTempl_F3' project 'ApTempl_P3'
And saved approval as template 'Ap_templ2' on opened approvals page
And I am on project 'ApTempl_P3' files page
When I go to file 'logo.png' info page in folder '/AppTempl_F3' project 'ApTempl_P3' tab approvals
And apply approval template 'Ap_templ2' on opened approvals page
Then I 'should' see approval stages with the following information:
| Name       | Description           | Status |
| ApTemp_St3 | Check all data safety | hidden |
And 'should' see following approvers information in stage 'ApTemp_St3' on opened file approvals page:
| UserName | Status  | Comment |
| AppT_u3  | Pending |         |
| AppT_u4  | Pending |         |


Scenario: Check that it's possible to save and apply template with more than 1 stage
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email   | Roles       |
| AppT_u5 | agency.user |
| AppT_u6 | agency.user |
And added users 'AppT_u5,AppT_u6' to Address book
And created 'ApTempl_P4' project
And created '/AppTempl_F4' folder for project 'ApTempl_P4'
And I uploaded into project 'ApTempl_P4' following files:
| FileName            | Path         |
| /images/logo.png    | /AppTempl_F4 |
| /images/SB_Logo.png | /AppTempl_F4 |
And waited while preview is available in folder '/AppTempl_F4' on project 'ApTempl_P4' files page
And added approval stage on file 'SB_Logo.png' approvals page in folder '/AppTempl_F4' project 'ApTempl_P4':
| Name        | Approvers | Description   | Started |
| AppTemp_St4 | AppT_u5   | Level 1 stage | true    |
And on file 'SB_Logo.png' approvals page in folder '/AppTempl_F4' project 'ApTempl_P4'
And waited for '2' seconds
And clicked Add approval stage on opened approvals page
And filled approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers | Description   |
| AppTemp_St5 | AppT_u6   | Level 2 stage |
And clicked 'Save and close' element on opened Add a new Stage popup
And saved approval as template 'Ap_templ3' on opened approvals page
And am on Project list page
When I go to file 'logo.png' info page in folder '/AppTempl_F4' project 'ApTempl_P4' tab approvals
And apply approval template 'Ap_templ3' on opened approvals page
Then I 'should' see approval stages with the following information:
| Name        | Description   | Status |
| AppTemp_St4 | Level 1 stage | hidden |
And 'should' see following approvers information in stage 'AppTemp_St4' on opened file approvals page:
| UserName | Status  | Comment |
| AppT_u5  | Pending |         |
And 'should' see approval stages with the following information:
| Name        | Description   | Status |
| AppTemp_St5 | Level 2 stage | hidden |
And 'should' see following approvers information in stage 'AppTemp_St5' on opened file approvals page:
| UserName | Status  | Comment |
| AppT_u6  | Pending |         |


Scenario: Check that after delete asset it still on Admin template page
Meta:@gdam
     @approvals
!--NGN-10552
Given I created users with following fields:
| Email   | Roles       |
| AppT_u5 | agency.user |
And created 'ApTempl_P5' project
And created '/AppTempl_F5' folder for project 'ApTempl_P5'
And I uploaded into project 'ApTempl_P5' following files:
| FileName            | Path         |
| /images/logo.png    | /AppTempl_F5 |
And waited while preview is available in folder '/AppTempl_F5' on project 'ApTempl_P5' files page
And added approval stage on file 'logo.png' approvals page in folder '/AppTempl_F5' project 'ApTempl_P5':
| Name        | Approvers | Description   |
| AppTemp_St5 | AppT_u5   | Level 1 stage |
And I am on file 'logo.png' approvals page in folder '/AppTempl_F5' project 'ApTempl_P5'
And saved approval as template 'AppTempl_T5' on opened approvals page
When I delete file 'logo.png' in project 'ApTempl_P5' folder '/AppTempl_F5'
And go to the approval templates page
Then 'should' see template 'AppTempl_T5' on approval templates page