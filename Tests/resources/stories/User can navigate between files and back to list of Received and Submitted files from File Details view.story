!--NGN-10263
Feature:          Usage can nagivate between files and back to list of Received and Submitted files from details view
Narrative:
In order to
As a              AgencyAdmin
I want to         Usage can nagivate between files and back to list of Received and Submitted files from details view

Scenario: Check that user can open selected files on Received tab, navigate between files and return to received tab
Meta:@gdam
@approvals
Given I created users with following fields:
| Email         |
| U_UNBFBFD_S01 |
And created 'P_UNBFBFD_S01' project
And created '/F_UNBFBFD_S01' folder for project 'P_UNBFBFD_S01'
And uploaded '/files/Fish1-Ad.mov' file into '/F_UNBFBFD_S01' folder for 'P_UNBFBFD_S01' project
And uploaded '/files/Fish2-Ad.mov' file into '/F_UNBFBFD_S01' folder for 'P_UNBFBFD_S01' project
And uploaded '/files/Fish3-Ad.mov' file into '/F_UNBFBFD_S01' folder for 'P_UNBFBFD_S01' project
And waited while preview is available in folder '/F_UNBFBFD_S01' on project 'P_UNBFBFD_S01' files page
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_UNBFBFD_S01' project 'P_UNBFBFD_S01':
| Name             | Approvers     | Started |
| AS_UNBFBFD_S01_1 | U_UNBFBFD_S01 | true    |
And added approval stage on file 'Fish2-Ad.mov' approvals page in folder '/F_UNBFBFD_S01' project 'P_UNBFBFD_S01':
| Name             | Approvers     | Started |
| AS_UNBFBFD_S01_2 | U_UNBFBFD_S01 | true    |
And added approval stage on file 'Fish3-Ad.mov' approvals page in folder '/F_UNBFBFD_S01' project 'P_UNBFBFD_S01':
| Name             | Approvers     | Started |
| AS_UNBFBFD_S01_3 | U_UNBFBFD_S01 | true    |
And logged in with details of 'U_UNBFBFD_S01'
When I go to project 'P_UNBFBFD_S01' approvals received page
And select approval by file name 'Fish1-Ad.mov' from folder '/F_UNBFBFD_S01' and project 'P_UNBFBFD_S01' on opened approvals page
And select approval by file name 'Fish2-Ad.mov' from folder '/F_UNBFBFD_S01' and project 'P_UNBFBFD_S01' on opened approvals page
And click open selected button on approvals page
Then I should be on preview file page of approvals
And should see following count '2' files on preview page of approvals
And 'should' be on current position '1' preview of approvals
And 'should' see following stages 'AS_UNBFBFD_S01_1' on preview of approvals page
When I navigate to 'next' file on preview file of approvals
Then I 'should' be on current position '2' preview of approvals
When I go to project 'P_UNBFBFD_S01' approvals submitted page
And return to previous page
And return to previous page
Then I should be on approvals received page


Scenario: Check that user can open selected files on Submitted tab, navigate between files and return to submitted tab
Meta:@gdam
@approvals
Given I created users with following fields:
| Email           | Agency        |
| U_UNBFBFD_S02_1 | DefaultAgency |
| U_UNBFBFD_S02_2 | DefaultAgency |
And logged in with details of 'U_UNBFBFD_S02_1'
And created 'P_UNBFBFD_S02' project
And created '/F_UNBFBFD_S02' folder for project 'P_UNBFBFD_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_UNBFBFD_S02' folder for 'P_UNBFBFD_S02' project
And uploaded '/files/Fish1-Ad.mov' file into '/F_UNBFBFD_S02' folder for 'P_UNBFBFD_S02' project
And uploaded '/files/Fish2-Ad.mov' file into '/F_UNBFBFD_S02' folder for 'P_UNBFBFD_S02' project
And waited while preview is available in folder '/F_UNBFBFD_S02' on project 'P_UNBFBFD_S02' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_UNBFBFD_S02' project 'P_UNBFBFD_S02':
| Name             | Approvers       | Started |
| AS_UNBFBFD_S02_1 | U_UNBFBFD_S02_2 | true    |
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_UNBFBFD_S02' project 'P_UNBFBFD_S02':
| Name             | Approvers       | Started |
| AS_UNBFBFD_S02_1 | U_UNBFBFD_S02_2 | true    |
And added approval stage on file 'Fish2-Ad.mov' approvals page in folder '/F_UNBFBFD_S02' project 'P_UNBFBFD_S02':
| Name             | Approvers       | Started |
| AS_UNBFBFD_S02_1 | U_UNBFBFD_S02_2 | true    |
When I go to project 'P_UNBFBFD_S02' approvals submitted page
And select approval by file name 'Fish Ad.mov' from folder '/F_UNBFBFD_S02' and project 'P_UNBFBFD_S02' on opened approvals page
And select approval by file name 'Fish1-Ad.mov' from folder '/F_UNBFBFD_S02' and project 'P_UNBFBFD_S02' on opened approvals page
And click open selected button on approvals page
Then I should be on preview file page of approvals
And should see following count '2' files on preview page of approvals
When navigate to 'next' file on preview file of approvals
Then I 'should' be on current position '2' preview of approvals
When I go to project 'P_UNBFBFD_S02' approvals submitted page
And return to previous page
And return to previous page
Then I should be on approvals submitted page