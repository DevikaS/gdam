Feature:          Project Owner can Publish and Unpublish a Project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that project owner can publish and unpublish a project

Scenario: Check button text after Publish/Unpublish actions
Meta:@gdam
@projects
When I create 'P_POCPUP_S01' project
And publish the project 'P_POCPUP_S01'
Then I 'should' see 'Unpublish' button on project 'P_POCPUP_S01' Overview page
When I unpublish the project 'P_POCPUP_S01'
Then I 'should' see 'Publish' button on project 'P_POCPUP_S01' Overview page


Scenario: Check that 'Unpublish' button is not visible for user with 'project.contributor' role
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S02 | agency.user |
And created 'P_POCPUP_S02' project
And created '/F_POCPUP_S02' folder for project 'P_POCPUP_S02'
And added users 'U_POCPUP_S02' to project 'P_POCPUP_S02' team folders '/F_POCPUP_S02' with role 'project.contributor' expired '12.12.2031'
When I login with details of 'U_POCPUP_S02'
Then I 'should not' see 'Unpublish' button on project 'P_POCPUP_S02' Overview page


Scenario: Check that project is not visible for user from team before publish
Meta:@gdam
@projects
!--NGN-8183
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S03 | agency.user |
When I create 'P_POCPUP_S03' project
And create '/F_POCPUP_S03' folder for project 'P_POCPUP_S03'
And add users 'U_POCPUP_S03' to project 'P_POCPUP_S03' team folders '/F_POCPUP_S03' with role 'project.user' expired '01.01.2022'
And I login with details of 'U_POCPUP_S03'
Then I 'should not' see project 'P_POCPUP_S03' on project list page


Scenario: Check that user receives email notification after publish project ('Notify/Do not notify' options)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And created following projects:
| Name          | Published |
| <ProjectName> | false     |
And set following notification settings for users:
| UserEmail    | SettingName       | SettingState |
| <UserEmail>  | Project Published | on           |
And created '/F_POCPUP_S04' folder for project '<ProjectName>'
And added users '<UserEmail>' to project '<ProjectName>' team folders '/F_POCPUP_S04' with role 'project.user' expired '01.01.2022'
When I click publish button on project '<ProjectName>' Overview page
And I click '<Option>' button on opened publish project pop-up
Then I '<condition>' see email with subject '<subject>' sent to '<UserEmail>'

Examples:
| ProjectName    | UserEmail      | Option        | condition  | subject              |
| P_POCPUP_S04_1 | U_POCPUP_S04_1 | Notify        | should     | has shared project   |
| P_POCPUP_S04_2 | U_POCPUP_S04_2 | Do not notify | should not | has shared project   |


Scenario: Check that user from project team loses access after Unpublish project
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S05 | agency.user |
And created following projects:
| Name         | Published |
| P_POCPUP_S05 | true      |
And created '/F_POCPUP_S05' folder for project 'P_POCPUP_S05'
And added users 'U_POCPUP_S05' to project 'P_POCPUP_S05' team folders '/F_POCPUP_S05' with role 'project.contributor' expired '01.01.2016'
When I unpublish the project 'P_POCPUP_S05'
And login with details of 'U_POCPUP_S05'
Then I 'should not' see project 'P_POCPUP_S05' on project list page


Scenario: Check that user cannot open project from email link after unpublish project
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        | Password     |
| U_POCPUP_S06 | agency.user | TestPassw0rd |
And created following projects:
| Name         | Published |
| P_POCPUP_S06 | true      |
And created '/F_POCPUP_S06' folder for project 'P_POCPUP_S06'
And added users 'U_POCPUP_S06' to project 'P_POCPUP_S06' team folders '/F_POCPUP_S06' with role 'project.contributor' expired '01.01.2016'
When I unpublish the project 'P_POCPUP_S06'
And logout from account
And open link from email with subject 'Folders have been shared with' which user 'U_POCPUP_S06' received
When I login to system as user with name 'U_POCPUP_S06' and password 'TestPassw0rd'
Then I should see message without delay warning 'We are sorry! You do not have permission to view this area.'


Scenario: Check that emails are not being sent after Unpublish project ('File uploaded' action)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S07 | agency.user |
And I am on user 'U_POCPUP_S07' Notifications Settings page
And set notification 'Files Uploaded' into state 'On' for current user
And created following projects:
| Name         | Published |
| P_POCPUP_S07 | false     |
And created '/F_POCPUP_S07' folder for project 'P_POCPUP_S07'
And added users 'U_POCPUP_S07' to project 'P_POCPUP_S07' team folders '/F_POCPUP_S07' with role 'project.contributor' expired '01.01.2016'
And published the project 'P_POCPUP_S07'
When I unpublish the project 'P_POCPUP_S07'
And upload '/files/Fish-Ad.mov' file into 'F_POCPUP_S07' folder for 'P_POCPUP_S07' project
Then I 'should not' see email notification for 'File Uploaded to Projects' with field to 'PemcoS07A' and subject 'has been successfully uploaded' contains following attributes: ||


Scenario: Check that you cannot share file before publish project ('Share file(s)' button is disabled )
Meta:@gdam
@projects
Given I created following projects:
| Name          | Published |
| <ProjectName> | <Status>  |
And created '/F_POCPUP_S08' folder for project '<ProjectName>'
And uploaded '/files/Fish-Ad.mov' file into '/F_POCPUP_S08' folder for '<ProjectName>' project
When go to project '<ProjectName>' folder '/F_POCPUP_S08' page
And select file 'Fish-Ad.mov' on project files page
Then I '<Condition>' see active Share files button on opened project files page

Examples:
| ProjectName    | Button    | Condition  | Status |
| P_POCPUP_S08_1 | Publish   | should     | true   |
| P_POCPUP_S08_2 | Unpublish | should not | false  |


Scenario: Check that you cannot start approval stage for unpublished project (Warning message)
Meta:@gdam
@approvals
!--NGN-8247
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S09 | agency.user |
And added user 'U_POCPUP_S09' into address book
And created following projects:
| Name         | Published |
| P_POCPUP_S09 | false     |
And created '/F_POCPUP_S09' folder for project 'P_POCPUP_S09'
And uploaded '/files/Fish-Ad.mov' file into '/F_POCPUP_S09' folder for 'P_POCPUP_S09' project
And waited while transcoding is finished in folder '/F_POCPUP_S09' on project 'P_POCPUP_S09' files page
When go to file 'Fish-Ad.mov' info page in folder '/F_POCPUP_S09' project 'P_POCPUP_S09' tab approvals
And click Submit for approval on opened approvals page
And fill approval stage on opened Add a new Stage popup with following information:
| Name       | Approvers    | Deadline         | Description                   |
| AS_PUP_S09 | U_POCPUP_S09 | 11/11/2023 12:15 | Stage for unpublished project |
And click 'Start' element on opened Add a new Stage popup
Then I should see alert text is 'This project is not published. Please publish the project to be able to start an approval.'


Scenario: Check that user can save approval stage in unpublished project
Meta:@gdam
@approvals
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S10 | agency.user |
And added user 'U_POCPUP_S10' into address book
And created following projects:
| Name         | Published |
| P_POCPUP_S10 | false     |
And created '/F_POCPUP_S10' folder for project 'P_POCPUP_S10'
And uploaded '/files/Fish-Ad.mov' file into '/F_POCPUP_S10' folder for 'P_POCPUP_S10' project
And waited while transcoding is finished in folder '/F_POCPUP_S10' on project 'P_POCPUP_S10' files page
When go to file 'Fish-Ad.mov' info page in folder '/F_POCPUP_S10' project 'P_POCPUP_S10' tab approvals
And click Submit for approval on opened approvals page
And fill approval stage on opened Add a new Stage popup with following information:
| Name       | Approvers    | Reminder         | Deadline         | Description                        |
| AS_PUP_S10 | U_POCPUP_S10 | 01/05/2023 08:00 | 01/05/2023 12:15 | Save stage for unpublished project |
And click 'save and close' element on opened Add a new Stage popup
Then I 'should' see approval stages with the following information:
| Name       | Status | Reminder        | Deadline         | Description                        |
| AS_PUP_S10 | hidden | 5/1/23, 8:00 AM | 5/1/23, 12:15 PM | Save stage for unpublished project |


Scenario: Check that user sees files after share folder to him (files are uploaded before publish project)
Meta:@gdam
@devopsuattests
@approvals
!--NGN-8790
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S11 | agency.user |
And created new project with following fields:
| FieldName  | FieldValue   |
| Name       | P_POCPUP_S11 |
| Media type | Broadcast    |
| Start date | Today        |
| End date   | Tomorrow     |
And created '/F_POCPUP_S11' folder for project 'P_POCPUP_S11'
And uploaded into project 'P_POCPUP_S11' following files:
| FileName                  | Path          |
| /files/Fish-Ad.mov        | /F_POCPUP_S11 |
| /files/big_background.jpg | /F_POCPUP_S11 |
And waited while transcoding is finished in folder '/F_POCPUP_S11' on project 'P_POCPUP_S11' files page
And published the project 'P_POCPUP_S11'
And fill Share popup by users 'U_POCPUP_S11' in project 'P_POCPUP_S11' folders '/F_POCPUP_S11' with role 'project.contributor' expired '10.10.2022' and 'should' access to subfolders
When I login with details of 'U_POCPUP_S11'
And I open project 'P_POCPUP_S11' files page
Then I should see files 'Fish-Ad.mov,big_background.jpg' inside '/F_POCPUP_S11' folder for 'P_POCPUP_S11' project


Scenario: Check that user doesn't receive email notification after unpublish project ('share folder' action)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S12 | agency.user |
And set following notification settings for users:
| UserEmail    | SettingName    | SettingState |
| U_POCPUP_S12 | Folders Shared | on           |
And created following projects:
| Name         | Published |
| P_POCPUP_S12 | true      |
And created '/F_POCPUP_S12' folder for project 'P_POCPUP_S12'
When I unpublish the project 'P_POCPUP_S12'
And filling Share popup by users 'U_POCPUP_S12' in project 'P_POCPUP_S12' for following folders '/F_POCPUP_S12' with role 'project.contributor' expired '12.12.2021' and 'should' access to subfolders
Then I 'should not' see email notification for 'Folder sharing for User' with field to 'U_POCPUP_S12' and subject 'Folder(s) has been shared with you' contains following attributes: ||


Scenario: Check that user doesn't receive email notification after unpublish project ('file upload' action)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S13 | agency.user |
And set following notification settings for users:
| UserEmail    | SettingName    | SettingState |
| U_POCPUP_S13 | Files Uploaded | on           |
And created following projects:
| Name         | Published |
| P_POCPUP_S13 | true      |
And created '/F_POCPUP_S13' folder for project 'P_POCPUP_S13'
And added users 'U_POCPUP_S13' to project 'P_POCPUP_S13' team folders '/F_POCPUP_S13' with role 'project.contributor' expired '12.12.2021'
When I unpublish the project 'P_POCPUP_S13'
And upload '/files/Fish1-Ad.mov' file into '/F_POCPUP_S13' folder for 'P_POCPUP_S13' project
And wait while preview is available in folder '/F_POCPUP_S13' on project 'P_POCPUP_S13' files page
Then I 'should not' see email notification for 'File Uploaded to Projects' with field to 'U_POCPUP_S13' and subject 'has been successfully uploaded' contains following attributes: ||


Scenario: Check that user doesn't receive email notification after unpublish project ('add owner to project' action)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S14 | agency.user |
And created following projects:
| Name         | Published |
| P_POCPUP_S14 | true      |
And created '/F_POCPUP_S14' folder for project 'P_POCPUP_S14'
When I unpublish the project 'P_POCPUP_S14'
And edit the following fields for 'P_POCPUP_S14' project:
| Name         | Administrators |
| P_POCPUP_S14 | U_POCPUP_S14   |
And click on element 'SaveButton'
Then I 'should not' see email notification for 'Project owner added' with field to 'U_POCPUP_S14' and subject ' has been added as Project Owner on project ' contains following attributes: ||


Scenario: Check that user doesn't receive email notification after unpublish project ('comment file' action)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_POCPUP_S15 | agency.user |
And set following notification settings for users:
| UserEmail    | SettingName    | SettingState |
| U_POCPUP_S15 | File Commented | on           |
And created following projects:
| Name         | Published |
| P_POCPUP_S15 | true      |
And created '/F_POCPUP_S15' folder for project 'P_POCPUP_S15'
And added users 'U_POCPUP_S15' to project 'P_POCPUP_S15' team folders '/F_POCPUP_S15' with role 'project.contributor' expired '12.12.2021'
And uploaded '/files/Fish1-Ad.mov' file into '/F_POCPUP_S15' folder for 'P_POCPUP_S15' project
And waited while preview is available in folder '/F_POCPUP_S15' on project 'P_POCPUP_S15' files page
When I unpublish the project 'P_POCPUP_S15'
And go to the file comments page project 'P_POCPUP_S15' and folder '/F_POCPUP_S15' and file 'Fish1-Ad.mov'
And add comment 'It is my point of view' into current file
Then I 'should not' see email notification for 'Comment on file' with field to 'U_POCPUP_S15' and subject 'comment has been made on file' contains following attributes: ||