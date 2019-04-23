!--NGN-5154
Feature:          Email Notification Url From Receiver Primary BU Settings
Narrative:
In order to
As a              GlobalAdmin
I want to         Check Email Notification Url From Receiver Primary BU Settings


Scenario: Check Email Notification Url for all project activities when no email urls are set on sender , primary and secondary receiver BU s
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A09' with default attributes
And I created the agency 'ENUFRPBUS_A10' with default attributes
And I created the agency 'ENUFRPBUS_A11' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| ENUFRPBUS_U25 | agency.admin |ENUFRPBUS_A09 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U26 | agency.admin |ENUFRPBUS_A10 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U27 | agency.user  |ENUFRPBUS_A09 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U28 | agency.user  |ENUFRPBUS_A09 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U29 | agency.user  |ENUFRPBUS_A09 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U30 | agency.user  |ENUFRPBUS_A09 |streamlined_library,library,folders,adkits,approvals|
And added existing user 'ENUFRPBUS_U26' to agency 'ENUFRPBUS_A11' with role 'agency.admin'
And I updated the following agency:
| Name              | Email Notification URL                     | Custom URL                          |
| ENUFRPBUS_A09     |                                            |                                     |
| ENUFRPBUS_A10     |                                            |                                     |
| ENUFRPBUS_A11     |                                            |                                     |
When I login with details of 'ENUFRPBUS_U27'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U27  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U29'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U29  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U30'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U30  | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U27'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U27  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U30'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U30  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U25'
And added user 'ENUFRPBUS_U29' into address book
And added user 'ENUFRPBUS_U30' into address book
And create 'ENUFRPBUS_P05' project
And create '/PSF105' folder for project 'ENUFRPBUS_P05'
And add users 'ENUFRPBUS_U27' to project 'ENUFRPBUS_P05' team folders '/PSF105' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P05'
And I open project 'ENUFRPBUS_P05' settings page
When I edit the following fields for 'ENUFRPBUS_P05' project:
| Name          | Administrators |
| ENUFRPBUS_P05 |  ENUFRPBUS_U29 |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P05' settings page
When I edit the following fields for 'ENUFRPBUS_P05' project:
| Name          | Administrators |
| ENUFRPBUS_P05 |  ENUFRPBUS_U30 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P05' which user 'ENUFRPBUS_U27' received
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U27' received email with next subject 'shared project'
When I open link from email when user 'ENUFRPBUS_U29' received email with next subject 'shared project'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U29' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P05' folder '/PSF105' page
And go to project 'ENUFRPBUS_P05' folder 'root' page
And select folder '/PSF105' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U28' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U28' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U28' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF105' folder for 'ENUFRPBUS_P05' project
And wait while preview is available in folder '/PSF105' on project 'ENUFRPBUS_P05' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF105' project 'ENUFRPBUS_P05':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP11  | ENUFRPBUS_U30 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P05' files page
And add secure share for file 'logo2.png' from folder '/PSF105' and project 'ENUFRPBUS_P05' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U26   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P05' and folder '/PSF105' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P05' folder '/PSF105' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U26' received email with next subject 'Files have been shared'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U26' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U27' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U27' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U30' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U30' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U30' received email with next subject 'has requested your approval'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U30' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U30' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U30' received email with next subject 'have been moved to Library'



Scenario: Check Email Notification Url for all project activities when email url set for Primary receiver BU
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A12' with default attributes
And I created the agency 'ENUFRPBUS_A13' with default attributes
And I created the agency 'ENUFRPBUS_A14' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| ENUFRPBUS_U31 | agency.admin |ENUFRPBUS_A12 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U32 | agency.admin |ENUFRPBUS_A13 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U33 | agency.user  |ENUFRPBUS_A12 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U34 | agency.user  |ENUFRPBUS_A12 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U35 | agency.user  |ENUFRPBUS_A12 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U36 | agency.user  |ENUFRPBUS_A12 |streamlined_library,library,folders,adkits,approvals|
And added existing user 'ENUFRPBUS_U32' to agency 'ENUFRPBUS_A14' with role 'agency.admin'
And I updated the following agency:
| Name              | Email Notification URL                     |Custom URL                          |
| ENUFRPBUS_A12     |                                            |                                    |
| ENUFRPBUS_A13     | http://qalandingpage.adstreamdev.com       |                                    |
| ENUFRPBUS_A14     |                                            |                                    |
When I login with details of 'ENUFRPBUS_U33'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U33  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U35'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U35  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U36'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U36  | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U33'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U33  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U36'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U36  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U31'
And added user 'ENUFRPBUS_U35' into address book
And added user 'ENUFRPBUS_U36' into address book
And create 'ENUFRPBUS_P06' project
And create '/PSF106' folder for project 'ENUFRPBUS_P06'
And add users 'ENUFRPBUS_U33' to project 'ENUFRPBUS_P06' team folders '/PSF106' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P06'
And I open project 'ENUFRPBUS_P06' settings page
When I edit the following fields for 'ENUFRPBUS_P06' project:
| Name          | Administrators |
| ENUFRPBUS_P06 |  ENUFRPBUS_U35 |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P06' settings page
When I edit the following fields for 'ENUFRPBUS_P06' project:
| Name          | Administrators |
| ENUFRPBUS_P06 |  ENUFRPBUS_U36 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P06' which user 'ENUFRPBUS_U33' received
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U33' received email with next subject 'shared project'
When I open link from email when user 'ENUFRPBUS_U35' received email with next subject 'shared project'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U35' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P06' folder '/PSF106' page
And go to project 'ENUFRPBUS_P06' folder 'root' page
And select folder '/PSF106' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U34' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U34' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U34' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF106' folder for 'ENUFRPBUS_P06' project
And wait while preview is available in folder '/PSF106' on project 'ENUFRPBUS_P06' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF106' project 'ENUFRPBUS_P06':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP11  | ENUFRPBUS_U36 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P06' files page
And add secure share for file 'logo2.png' from folder '/PSF106' and project 'ENUFRPBUS_P06' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U32   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P06' and folder '/PSF106' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P06' folder '/PSF106' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U32' received email with next subject 'Files have been shared'
Then I should see navigating url as 'http://qalandingpage.adstreamdev.com' when user 'ENUFRPBUS_U32' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U33' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U33' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U36' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U36' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U36' received email with next subject 'has requested your approval'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U36' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U36' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U36' received email with next subject 'have been moved to Library'



Scenario: Check Email Notification Url for all project activities when email url set for Primary and Secondary receiver BU
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A15' with default attributes
And I created the agency 'ENUFRPBUS_A16' with default attributes
And I created the agency 'ENUFRPBUS_A17' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| ENUFRPBUS_U37 | agency.admin |ENUFRPBUS_A15 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U38 | agency.admin |ENUFRPBUS_A16 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U39 | agency.user  |ENUFRPBUS_A15 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U40 | agency.user  |ENUFRPBUS_A15 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U41 | agency.user  |ENUFRPBUS_A15 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U42 | agency.user  |ENUFRPBUS_A15 |streamlined_library,library,folders,adkits,approvals|
And added existing user 'ENUFRPBUS_U38' to agency 'ENUFRPBUS_A17' with role 'agency.admin'
And I updated the following agency:
| Name              | Email Notification URL                        | Custom URL                                      |
| ENUFRPBUS_A15     |                                               |                                                 |
| ENUFRPBUS_A16     | http://qalandingpage.adstreamdev.com          |                                                 |
| ENUFRPBUS_A17     | http://qasecondarylandingpage.adstreamdev.com |                                                 |
When I login with details of 'ENUFRPBUS_U39'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U39  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U41'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U41  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U42'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U42  | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U39'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U39  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U42'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U42  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U37'
And added user 'ENUFRPBUS_U41' into address book
And added user 'ENUFRPBUS_U42' into address book
And create 'ENUFRPBUS_P07' project
And create '/PSF107' folder for project 'ENUFRPBUS_P07'
And add users 'ENUFRPBUS_U39' to project 'ENUFRPBUS_P07' team folders '/PSF107' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P07'
And I open project 'ENUFRPBUS_P07' settings page
When I edit the following fields for 'ENUFRPBUS_P07' project:
| Name          | Administrators |
| ENUFRPBUS_P07 |  ENUFRPBUS_U41 |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P07' settings page
When I edit the following fields for 'ENUFRPBUS_P07' project:
| Name          | Administrators |
| ENUFRPBUS_P07 |  ENUFRPBUS_U42 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P07' which user 'ENUFRPBUS_U39' received
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U39' received email with next subject 'shared project'
When I open link from email when user 'ENUFRPBUS_U41' received email with next subject 'shared project'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U41' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P07' folder '/PSF107' page
And go to project 'ENUFRPBUS_P07' folder 'root' page
And select folder '/PSF107' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U40' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U40' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U40' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF107' folder for 'ENUFRPBUS_P07' project
And wait while preview is available in folder '/PSF107' on project 'ENUFRPBUS_P07' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF107' project 'ENUFRPBUS_P07':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP11  | ENUFRPBUS_U42 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P07' files page
And add secure share for file 'logo2.png' from folder '/PSF107' and project 'ENUFRPBUS_P07' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U38   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P07' and folder '/PSF107' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P07' folder '/PSF107' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U38' received email with next subject 'Files have been shared'
Then I should see navigating url as 'http://qalandingpage.adstreamdev.com' when user 'ENUFRPBUS_U38' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U39' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U39' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U42' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U42' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U42' received email with next subject 'has requested your approval'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U42' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U42' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U42' received email with next subject 'have been moved to Library'



Scenario: Check Email Notification Url for all project activities when email url set for sender BU and Secondary receiver BU
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A18' with default attributes
And I created the agency 'ENUFRPBUS_A19' with default attributes
And I created the agency 'ENUFRPBUS_A20' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| ENUFRPBUS_U43 | agency.admin |ENUFRPBUS_A18 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U44 | agency.admin |ENUFRPBUS_A19 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U45 | agency.user  |ENUFRPBUS_A18 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U46 | agency.user  |ENUFRPBUS_A18 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U47 | agency.user  |ENUFRPBUS_A18 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U48 | agency.user  |ENUFRPBUS_A18 |streamlined_library,library,folders,adkits,approvals|
And added existing user 'ENUFRPBUS_U44' to agency 'ENUFRPBUS_A20' with role 'agency.admin'
And I updated the following agency:
| Name            | Email Notification URL                         |
| ENUFRPBUS_A18   | http://qasenderEmail.adstreamdev.com           |
| ENUFRPBUS_A19   |                                                |
| ENUFRPBUS_A20   | http://qasecondarylandingpage.adstreamdev.com  |
And I updated the following agency:
| Name            | Custom URL             |
| ENUFRPBUS_A18   |                        |
| ENUFRPBUS_A19   |                        |
| ENUFRPBUS_A20   |                        |
When I login with details of 'ENUFRPBUS_U45'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U45  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U47'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U47  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U48'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
|ENUFRPBUS_U48   | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U45'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U45  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U48'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U48  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U43'
And added user 'ENUFRPBUS_U47' into address book
And added user 'ENUFRPBUS_U48' into address book
And create 'ENUFRPBUS_P08' project
And create '/PSF108' folder for project 'ENUFRPBUS_P08'
And add users 'ENUFRPBUS_U45' to project 'ENUFRPBUS_P08' team folders '/PSF108' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P08'
And I open project 'ENUFRPBUS_P08' settings page
When I edit the following fields for 'ENUFRPBUS_P08' project:
| Name          | Administrators |
| ENUFRPBUS_P08 |  ENUFRPBUS_U47 |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P08' settings page
When I edit the following fields for 'ENUFRPBUS_P08' project:
| Name          | Administrators |
| ENUFRPBUS_P08 | ENUFRPBUS_U48 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P08' which user 'ENUFRPBUS_U45' received
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U45' received email with next subject 'shared project'
When I open link from email when user 'ENUFRPBUS_U47' received email with next subject 'shared project'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U47' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P08' folder '/PSF108' page
And go to project 'ENUFRPBUS_P08' folder 'root' page
And select folder '/PSF108' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U46' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U46' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U46' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF108' folder for 'ENUFRPBUS_P08' project
And wait while preview is available in folder '/PSF108' on project 'ENUFRPBUS_P08' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF108' project 'ENUFRPBUS_P08':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP11  |ENUFRPBUS_U48 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P08' files page
And add secure share for file 'logo2.png' from folder '/PSF108' and project 'ENUFRPBUS_P08' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U44   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P08' and folder '/PSF108' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P08' folder '/PSF108' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U44' received email with next subject 'Files have been shared'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U44' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U45' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U45' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U48' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U48' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U48' received email with next subject 'has requested your approval'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U48' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U48' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'http://qasenderEmail.adstreamdev.com' when user 'ENUFRPBUS_U48' received email with next subject 'have been moved to Library'

