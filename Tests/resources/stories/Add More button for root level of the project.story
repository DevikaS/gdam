!-- NGN-12937
Feature:          Add More button for root level of the project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Add More button for root level of the project


Scenario: Check that file could be shared from root folder (secure share)
Meta:@gdam
     @projects
Given I created users with following fields:
| Email           | Role       |
| U_AMBFRLOTP_S01 | guest.user |
And I created 'PSP501' project
And uploaded '/files/logo2.png' file into '/' folder for 'PSP501' project
And waited while preview is available in folder '/' on project 'PSP501' files page
When I go to project 'PSP501' files page
And add secure share for file 'logo2.png' from folder '/' and project 'PSP501' to following users:
| UserEmails      | Message | DownloadOriginal |
| U_AMBFRLOTP_S01 | hi dude | true             |
And login with details of 'U_AMBFRLOTP_S01'
And open link from email when user 'U_AMBFRLOTP_S01' received email with next subject 'Files have been shared'
And open comments tab on opened file preview page
Then I 'should' be on file preview page


Scenario: Check that file could be moved from root folder
Meta:@gdam
     @projects
Given I created 'P_AMBFRLOTP_02' project
And created '/folder2' folder for project 'P_AMBFRLOTP_02'
And uploaded '/files/logo2.png' file into '/' folder for 'P_AMBFRLOTP_02' project
And waited while preview is available in folder '/' on project 'P_AMBFRLOTP_02' files page
When I go to project 'P_AMBFRLOTP_02' files page
And move 'logo2.png' file into '/folder2' folder from folder '/' for 'P_AMBFRLOTP_02' project
And I go to project 'P_AMBFRLOTP_02' overview page
And open file 'logo2.png' on project 'P_AMBFRLOTP_02' overview page
Then I should see file 'logo2.png' info page in project 'P_AMBFRLOTP_02' folder '/folder2'


Scenario: Check that file could be send to approval from root folder
Meta:@gdam
     @approvals
Given I created users with following fields:
| Email           | Role       |
| U_AMBFRLOTP_S03 | guest.user |
And I created 'P_AMBFRLOTP_03' project
And uploaded '/files/logo2.png' file into '/' folder for 'P_AMBFRLOTP_03' project
And waited while preview is available in folder '/' on project 'P_AMBFRLOTP_03' files page
And added approval stage on file 'logo2.png' approvals page in folder '/' project 'P_AMBFRLOTP_03':
| Name             | Approvers       | Deadline         | Reminder         | Started |
| AS_AMBFRLOTP_S03 | U_AMBFRLOTP_S03 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I login with details of 'U_AMBFRLOTP_S03'
And go to projects approvals received page
Then I 'should' see file names 'logo2.png' on opened project approvals page


Scenario: Check that butch files could be edited from root folder
Meta:@gdam
     @projects
Given I created 'P_AMBFRLOTP_04' project
And uploaded '/files/logo2.png' file into '/' folder for 'P_AMBFRLOTP_04' project
And waited while preview is available in folder '/' on project 'P_AMBFRLOTP_04' files page
When I go to file 'logo2.png' info page in folder '/' project 'P_AMBFRLOTP_04'
And 'save' file info by next information:
| FieldName | FieldValue |
| Title     | logo24.png |
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName  | FieldValue |
| Title      | logo24.png |


Scenario: Check that user with muted permission on folder cant see this permissions on more button
Meta:@gdam
     @projects
Given I created users with following fields:
| Email           | Role       |
| U_AMBFRLOTP_S05 | guest.user |
And created 'P_AMBFRLOTP_05' project
And uploaded '/files/logo2.png' file into '/' folder for 'P_AMBFRLOTP_05' project
And waited while transcoding is finished in folder '/' on project 'P_AMBFRLOTP_05' files page
And added users 'U_AMBFRLOTP_S05' to project 'P_AMBFRLOTP_05' team folders '' with role 'project.user' expired '12.12.2020'
When I login with details of 'U_AMBFRLOTP_S05'
And go to project 'P_AMBFRLOTP_05' files page
And refresh the page
And select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
Then I 'should not' see active options 'Edit selected by one,Edit all selected,Edit Usage Rights,Delete,Send for approval' in More drop down menu on project files page
Then I 'should' see active options 'Move,Copy' in More drop down menu on project files page