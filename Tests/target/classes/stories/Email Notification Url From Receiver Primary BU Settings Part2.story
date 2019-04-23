!--NGN-5154
Feature:          Email Notification Url From Receiver Primary BU Settings
Narrative:
In order to
As a              GlobalAdmin
I want to         Check Email Notification Url From Receiver Primary BU Settings


Scenario: Check Email Notification Url for all project activities when no email urls are set on sender and receiver BU s
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A01' with default attributes
And I created the agency 'ENUFRPBUS_A02' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| ENUFRPBUS_U01 | agency.admin |ENUFRPBUS_A01 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U02 | agency.admin |ENUFRPBUS_A02 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U03 | agency.user  |ENUFRPBUS_A01 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U04 | agency.user  |ENUFRPBUS_A01 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U05 | agency.user  |ENUFRPBUS_A01 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U06 | agency.user  |ENUFRPBUS_A01 |streamlined_library,library,folders,adkits,approvals|
When I login as 'GlobalAdmin'
And I go to agency 'ENUFRPBUS_A01' overview page
And I go to Global Admin system branding page of 'ENUFRPBUS_A01'
And I fill From email Url field with text '' on Global system branding page of 'ENUFRPBUS_A01'
And I fill From custom Url field with text '' on Global system branding page of 'ENUFRPBUS_A01'
When I go to agency 'ENUFRPBUS_A02' overview page
And I go to Global Admin system branding page of 'ENUFRPBUS_A02'
And I fill From email Url field with text '' on Global system branding page of 'ENUFRPBUS_A02'
And I fill From custom Url field with text '' on Global system branding page of 'ENUFRPBUS_A02'
When I login with details of 'ENUFRPBUS_U03'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U03  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U03'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U03  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U06'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U06  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U05'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U05  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U06'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U06  | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U01'
And added user 'ENUFRPBUS_U05' into address book
And added user 'ENUFRPBUS_U06' into address book
And create 'ENUFRPBUS_P01' project
And create '/PSF101' folder for project 'ENUFRPBUS_P01'
And add users 'ENUFRPBUS_U03' to project 'ENUFRPBUS_P01' team folders '/PSF101' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P01'
And I open project 'ENUFRPBUS_P01' settings page
When I edit the following fields for 'ENUFRPBUS_P01' project:
| Name          | Administrators |
| ENUFRPBUS_P01 |  ENUFRPBUS_U05 |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P01' settings page
When I edit the following fields for 'ENUFRPBUS_P01' project:
| Name          | Administrators |
| ENUFRPBUS_P01 |  ENUFRPBUS_U06 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P01' which user 'ENUFRPBUS_U03' received
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U03' received email with next subject 'shared project'
When I open link from email with shared project 'ENUFRPBUS_P01' which user 'ENUFRPBUS_U05' received
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U05' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P01' folder '/PSF101' page
And go to project 'ENUFRPBUS_P01' folder 'root' page
And select folder '/PSF101' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U04' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U04' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U04' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF101' folder for 'ENUFRPBUS_P01' project
And wait while preview is available in folder '/PSF101' on project 'ENUFRPBUS_P01' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF101' project 'ENUFRPBUS_P01':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP06  | ENUFRPBUS_U06 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P01' files page
And add secure share for file 'logo2.png' from folder '/PSF101' and project 'ENUFRPBUS_P01' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U02   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P01' and folder '/PSF101' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P01' folder '/PSF101' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U02' received email with next subject 'Files have been shared'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U02' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U03' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U03' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U06' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U06' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U06' received email with next subject 'has requested your approval'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U06' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U06' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U06' received email with next subject 'have been moved to Library'



Scenario: Check Email Notification Url for all project activities when both email urls are set on sender and receiver BU s
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A03' with default attributes
And I created the agency 'ENUFRPBUS_A04' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
|ENUFRPBUS_U07  | agency.admin |ENUFRPBUS_A03 |streamlined_library,library,folders,adkits,approvals|
|ENUFRPBUS_U08  | agency.admin |ENUFRPBUS_A04 |streamlined_library,library,folders,adkits,approvals|
|ENUFRPBUS_U09  | agency.user  |ENUFRPBUS_A03 |streamlined_library,library,folders,adkits,approvals|
|ENUFRPBUS_U10  | agency.user  |ENUFRPBUS_A03 |streamlined_library,library,folders,adkits,approvals|
|ENUFRPBUS_U11  | agency.user  |ENUFRPBUS_A03 |streamlined_library,library,folders,adkits,approvals|
|ENUFRPBUS_U12  | agency.user  |ENUFRPBUS_A03 |streamlined_library,library,folders,adkits,approvals|
And I updated the following agency:
| Name              | Email Notification URL                     |Custom URL             |
| ENUFRPBUS_A03     | http://qasenderEmail.adstreamdev.com       |                       |
| ENUFRPBUS_A04     | http://qalandingpage.adstreamdev.com       |                       |
When I login with details of 'ENUFRPBUS_U09'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U09  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U11'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U11  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U12'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U12  | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U09'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U09  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U12'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U12  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U07'
And added user 'ENUFRPBUS_U11' into address book
And added user 'ENUFRPBUS_U12' into address book
And create 'ENUFRPBUS_P02' project
And create '/PSF102' folder for project 'ENUFRPBUS_P02'
And add users 'ENUFRPBUS_U09' to project 'ENUFRPBUS_P02' team folders '/PSF102' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P02'
And I open project 'ENUFRPBUS_P02' settings page
When I edit the following fields for 'ENUFRPBUS_P02' project:
| Name          | Administrators |
| ENUFRPBUS_P02 | ENUFRPBUS_U11  |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P02' settings page
When I edit the following fields for 'ENUFRPBUS_P02' project:
| Name          | Administrators |
| ENUFRPBUS_P02 |  ENUFRPBUS_U12 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P02' which user 'ENUFRPBUS_U09' received
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U09' received email with next subject 'shared project'
When I open link from email when user 'ENUFRPBUS_U11' received email with next subject 'shared project'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U11' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P02' folder '/PSF102' page
And go to project 'ENUFRPBUS_P02' folder 'root' page
And select folder '/PSF102' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U10' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U10' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U10' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF102' folder for 'ENUFRPBUS_P02' project
And wait while preview is available in folder '/PSF102' on project 'ENUFRPBUS_P02' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF102' project 'ENUFRPBUS_P02':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP07  | ENUFRPBUS_U12 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P02' files page
And add secure share for file 'logo2.png' from folder '/PSF102' and project 'ENUFRPBUS_P02' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U08   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P02' and folder '/PSF102' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P02' folder '/PSF102' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U08' received email with next subject 'Files have been shared'
Then I should see navigating url as 'http://qalandingpage.adstreamdev.com' when user 'ENUFRPBUS_U08' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U09' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U09' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U12' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U12' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U12' received email with next subject 'has requested your approval'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U12' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U12' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U12' received email with next subject 'have been moved to Library'


Scenario: Check Email Notification Url for all project activities when email url alone set on receiver BU
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A05' with default attributes
And I created the agency 'ENUFRPBUS_A06' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| ENUFRPBUS_U13 | agency.admin |ENUFRPBUS_A05 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U14 | agency.admin |ENUFRPBUS_A06 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U15 | agency.user  |ENUFRPBUS_A05 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U16 | agency.user  |ENUFRPBUS_A05 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U17 | agency.user  |ENUFRPBUS_A05 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U18 | agency.user  |ENUFRPBUS_A05 |streamlined_library,library,folders,adkits,approvals|
And I updated the following agency:
| Name              | Email Notification URL                     | Custom URL             |
| ENUFRPBUS_A05     |                                            |                        |
| ENUFRPBUS_A06     | http://qalandingpage.adstreamdev.com       |                        |
When I login with details of 'ENUFRPBUS_U15'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U15  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U17'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U17  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U18'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U18  | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U15'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U15  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U18'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U18  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U13'
And added user 'ENUFRPBUS_U17' into address book
And added user 'ENUFRPBUS_U18' into address book
And create 'ENUFRPBUS_P03' project
And create '/PSF103' folder for project 'ENUFRPBUS_P03'
And add users 'ENUFRPBUS_U15' to project 'ENUFRPBUS_P03' team folders '/PSF103' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P03'
And I open project 'ENUFRPBUS_P03' settings page
When I edit the following fields for 'ENUFRPBUS_P03' project:
| Name          | Administrators |
| ENUFRPBUS_P03 |  ENUFRPBUS_U17 |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P03' settings page
When I edit the following fields for 'ENUFRPBUS_P03' project:
| Name          | Administrators |
| ENUFRPBUS_P03 |  ENUFRPBUS_U18 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P03' which user 'ENUFRPBUS_U15' received
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U15' received email with next subject 'shared project'
When I open link from email when user 'ENUFRPBUS_U17' received email with next subject 'shared project'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U17' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P03' folder '/PSF103' page
And go to project 'ENUFRPBUS_P03' folder 'root' page
And select folder '/PSF103' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U16' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U16' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U16' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF103' folder for 'ENUFRPBUS_P03' project
And wait while preview is available in folder '/PSF103' on project 'ENUFRPBUS_P03' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF103' project 'ENUFRPBUS_P03':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP08  | ENUFRPBUS_U18 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P03' files page
And add secure share for file 'logo2.png' from folder '/PSF103' and project 'ENUFRPBUS_P03' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U14   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P03' and folder '/PSF103' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P03' folder '/PSF103' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U14' received email with next subject 'Files have been shared'
Then I should see navigating url as 'http://qalandingpage.adstreamdev.com' when user 'ENUFRPBUS_U14' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U15' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U15' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U18' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U18' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U18' received email with next subject 'has requested your approval'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U18' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U18' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U18' received email with next subject 'have been moved to Library'


Scenario: Check Email Notification Url for all project activities when custom urls are set on sender and receiver BU s
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A07' with default attributes
And I created the agency 'ENUFRPBUS_A08' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| ENUFRPBUS_U19 | agency.admin |ENUFRPBUS_A07 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U20 | agency.admin |ENUFRPBUS_A08 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U21 | agency.user  |ENUFRPBUS_A07 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U22 | agency.user  |ENUFRPBUS_A07 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U23 | agency.user  |ENUFRPBUS_A07 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U24 | agency.user  |ENUFRPBUS_A07 |streamlined_library,library,folders,adkits,approvals|
When I go to agency 'ENUFRPBUS_A07' overview page
And I updated the following agency:
| Name              | Email Notification URL                     | Custom URL                          |
| ENUFRPBUS_A07     |                                            |http://qacustompage.adstreamdev.com  |
| ENUFRPBUS_A08     |                                            |http://qacustompage.adstreamdev.com  |
When I login with details of 'ENUFRPBUS_U21'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U21  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U23'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U23  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U24'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U24  | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U21'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U21  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U24'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U24  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U19'
And added user 'ENUFRPBUS_U23' into address book
And added user 'ENUFRPBUS_U24' into address book
And create 'ENUFRPBUS_P04' project
And create '/PSF104' folder for project 'ENUFRPBUS_P04'
And add users 'ENUFRPBUS_U21' to project 'ENUFRPBUS_P04' team folders '/PSF104' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P04'
And I open project 'ENUFRPBUS_P04' settings page
When I edit the following fields for 'ENUFRPBUS_P04' project:
| Name          | Administrators |
| ENUFRPBUS_P04 |  ENUFRPBUS_U23 |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P04' settings page
When I edit the following fields for 'ENUFRPBUS_P04' project:
| Name          | Administrators |
| ENUFRPBUS_P04 |  ENUFRPBUS_U24 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P04' which user 'ENUFRPBUS_U21' received
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U21' received email with next subject 'shared project'
When I open link from email when user 'ENUFRPBUS_U23' received email with next subject 'shared project'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U23' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P04' folder '/PSF104' page
And go to project 'ENUFRPBUS_P04' folder 'root' page
And select folder '/PSF104' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U22' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U22' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U22' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF104' folder for 'ENUFRPBUS_P04' project
And wait while preview is available in folder '/PSF104' on project 'ENUFRPBUS_P04' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF104' project 'ENUFRPBUS_P04':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP06  | ENUFRPBUS_U24 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P04' files page
And add secure share for file 'logo2.png' from folder '/PSF104' and project 'ENUFRPBUS_P04' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U20   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P04' and folder '/PSF104' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P04' folder '/PSF104' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U20' received email with next subject 'Files have been shared'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U20' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U21' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U21' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U24' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U24' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U24' received email with next subject 'has requested your approval'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U24' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U24' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U24' received email with next subject 'have been moved to Library'

