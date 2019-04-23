!--NGN-8872
Feature:          Secure share of Files and Assets
Narrative:
In order to
As a              AgencyAdmin
I want to         check sharing of files and assets via secure share



Scenario: User can see Activity about sharing in File details
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S03 | agency.user |
And created 'P_SSOFAA_S03' project
And created '/F_SSOFAA_S03' folder for project 'P_SSOFAA_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S03' folder for 'P_SSOFAA_S03' project
And waited while transcoding is finished in folder '/F_SSOFAA_S03' on project 'P_SSOFAA_S03' files page
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S03' and project 'P_SSOFAA_S03' to following users:
| UserEmails   |
| U_SSOFAA_S03 |
And refresh the page
Then I 'should' see activity for user 'AgencyAdmin' on file 'Fish Ad.mov' activity tab in project 'P_SSOFAA_S03' folder '/F_SSOFAA_S03' page with message 'shared file with U_SSOFAA_S03' and value ''


Scenario: Project Owner can see Activity about File share on Project Overview
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S04 | agency.user |
And created 'P_SSOFAA_S04' project
And created '/F_SSOFAA_S04' folder for project 'P_SSOFAA_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S04' folder for 'P_SSOFAA_S04' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S04' and project 'P_SSOFAA_S04' to following users:
| UserEmails   |
| U_SSOFAA_S04 |
And wait for '10' seconds
Then 'should' see activity where user 'AgencyAdmin' on project 'P_SSOFAA_S04' shared file 'Fish Ad.mov' to user 'U_SSOFAA_S04' on Project Overview page


Scenario: Project Owner can see Activity about File share on Dashboard
Meta: @gdam
@projects
Given I created the following agency:
| Name         |
| A_SSOFAA_S05 |
And created users with following fields:
| Email          | Role         | Agency       |
| U_SSOFAA_S05_1 | agency.admin | A_SSOFAA_S05 |
| U_SSOFAA_S05_2 | agency.user  | A_SSOFAA_S05 |
And logged in with details of 'U_SSOFAA_S05_1'
And created 'P_SSOFAA_S05' project
And created '/F_SSOFAA_S05' folder for project 'P_SSOFAA_S05'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S05' folder for 'P_SSOFAA_S05' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S05' and project 'P_SSOFAA_S05' to following users:
| UserEmails     |
| U_SSOFAA_S05_2 |
And wait for '5' seconds
Then I 'should' see activity where user 'U_SSOFAA_S05_1' shared file 'Fish Ad.mov' to user 'U_SSOFAA_S05_2' on Dashboard


Scenario: User can see Activity about sharing on Dashboard
Meta: @gdam
@library
Given I created the following agency:
| Name         |
| A_SSOFAA_S07 |
And created users with following fields:
| Email          | Role         | Agency       |Access|
| U_SSOFAA_S07_1 | agency.admin | A_SSOFAA_S07 |streamlined_library,dashboard|
| U_SSOFAA_S07_2 | agency.user  | A_SSOFAA_S07 |streamlined_library,dashboard|
And logged in with details of 'U_SSOFAA_S07_1'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And I have refreshed the page
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails     |
| U_SSOFAA_S07_2 |
And wait for '5' seconds
And go to Dashboard page
Then I 'should' see activity where user 'U_SSOFAA_S07_1' shared asset 'Fish Ad.mov' to user 'U_SSOFAA_S07_2' on Dashboard


Scenario: User cannot edit metadata on shared to him File
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S08 | agency.user |
And created 'P_SSOFAA_S08' project
And created '/F_SSOFAA_S08' folder for project 'P_SSOFAA_S08'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S08' folder for 'P_SSOFAA_S08' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S08' and project 'P_SSOFAA_S08' to following users:
| UserEmails   |
| U_SSOFAA_S08 |
And login with details of 'U_SSOFAA_S08'
And wait for '10' seconds
And open link from email when user 'U_SSOFAA_S08' received email with next subject 'Files have been shared with'
Then I 'should not' see Edit link on opened file preview page



Scenario: User to whom File was securely shared can Download file
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S14 | agency.user |
And created 'P_SSOFAA_S14' project
And created '/F_SSOFAA_S14' folder for project 'P_SSOFAA_S14'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S14' folder for 'P_SSOFAA_S14' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S14' and project 'P_SSOFAA_S14' to following users:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S14 | true             |
And login with details of 'U_SSOFAA_S14'
And open link from email when user 'U_SSOFAA_S14' received email with next subject 'Files have been shared with'
Then I 'should' see Download original button on opened file preview page


Scenario: User can see Activity about download by Secure Share user in File Activity tab
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S16 | agency.user |
And created 'P_SSOFAA_S16' project
And created '/F_SSOFAA_S16' folder for project 'P_SSOFAA_S16'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S16' folder for 'P_SSOFAA_S16' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S16' and project 'P_SSOFAA_S16' to following users:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S16 | true             |
And login with details of 'U_SSOFAA_S16'
And open link from email when user 'U_SSOFAA_S16' received email with next subject 'Files have been shared with'
And download original file on opened file preview page
And login with details of 'AgencyAdmin'
Then I 'should' see activity for user 'U_SSOFAA_S16' on file 'Fish Ad.mov' activity tab in project 'P_SSOFAA_S16' folder '/F_SSOFAA_S16' page with message 'downloaded file master' and value ''


Scenario: User can see Activity about downloading file by Secure Share user on Dashboard page
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S18 | agency.user |
And created 'P_SSOFAA_S18' project
And created '/F_SSOFAA_S18' folder for project 'P_SSOFAA_S18'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S18' folder for 'P_SSOFAA_S18' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S18' and project 'P_SSOFAA_S18' to following users:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S18 | true             |
And login with details of 'U_SSOFAA_S18'
And open link from email when user 'U_SSOFAA_S18' received email with next subject 'Files have been shared with'
And download original file on opened file preview page
And login with details of 'AgencyAdmin'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message                | Value                                  |
| U_SSOFAA_S18 | downloaded file master | /P_SSOFAA_S18/F_SSOFAA_S18/Fish Ad.mov |




Scenario: Project Owner can see Activty about File download by secure share user on Project Overview
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S20 | agency.user |
And created 'P_SSOFAA_S20' project
And created '/F_SSOFAA_S20' folder for project 'P_SSOFAA_S20'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S20' folder for 'P_SSOFAA_S20' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S20' and project 'P_SSOFAA_S20' to following users:
| UserEmails   | Message | DownloadOriginal |
| U_SSOFAA_S20 | hi dude | true             |
And login with details of 'U_SSOFAA_S20'
And open link from email when user 'U_SSOFAA_S20' received email with next subject 'Files have been shared with'
And download original file on opened file preview page
And login with details of 'AgencyAdmin'
Then I 'should' see activity for user 'U_SSOFAA_S20' on project 'P_SSOFAA_S20' overview page with message 'downloaded file master' and value '/P_SSOFAA_S20/F_SSOFAA_S20/Fish Ad.mov'


Scenario: User to whom File was shared securely can Comment on File
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S21 | agency.user |
And created 'P_SSOFAA_S21' project
And created '/F_SSOFAA_S21' folder for project 'P_SSOFAA_S21'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S21' folder for 'P_SSOFAA_S21' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S21' and project 'P_SSOFAA_S21' to following users:
| UserEmails   |
| U_SSOFAA_S21 |
And login with details of 'U_SSOFAA_S21'
And open link from email when user 'U_SSOFAA_S21' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
Then I 'should' see following comments on opened file preview comments page:
| UserName     | Content     | Date  |
| U_SSOFAA_S21 | hello admin | Today |


Scenario: User to whom File was shared securely can see responses to their Comment
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S22 | agency.user |
And created 'P_SSOFAA_S22' project
And created '/F_SSOFAA_S22' folder for project 'P_SSOFAA_S22'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S22' folder for 'P_SSOFAA_S22' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S22' and project 'P_SSOFAA_S22' to following users:
| UserEmails   |
| U_SSOFAA_S22 |
And login with details of 'U_SSOFAA_S22'
And open link from email when user 'U_SSOFAA_S22' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
And login with details of 'AgencyAdmin'
And go to the file comments page project 'P_SSOFAA_S22' and folder '/F_SSOFAA_S22' and file 'Fish Ad.mov'
And replay 'hi dude' on comment 'hello admin' for file 'Fish Ad.mov' in project 'P_SSOFAA_S22' and folder '/F_SSOFAA_S22'
And login with details of 'U_SSOFAA_S22'
And open link from email when user 'U_SSOFAA_S22' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
Then I 'should' see following comments on opened file preview comments page:
| UserName     | Content     | Date  |
| U_SSOFAA_S22 | hello admin | Today |
| AgencyAdmin  | hi dude     | Today |


Scenario: User should not see other comments on this shared File
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S23 | agency.user |
And created 'P_SSOFAA_S23' project
And created '/F_SSOFAA_S23' folder for project 'P_SSOFAA_S23'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S23' folder for 'P_SSOFAA_S23' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S23' and project 'P_SSOFAA_S23' to following users:
| UserEmails   |
| U_SSOFAA_S23 |
And go to the file comments page project 'P_SSOFAA_S23' and folder '/F_SSOFAA_S23' and file 'Fish Ad.mov'
And add comment 'hi dude' into current file
And login with details of 'U_SSOFAA_S23'
And open link from email when user 'U_SSOFAA_S23' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
Then I 'should not' see following comments on opened file preview comments page:
| UserName     | Content     | Date  |
| AgencyAdmin  | hi dude     | Today |


Scenario: User to whom File was shared securely can see Sharing Comment on Comments tab, and reply to it
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S24 | agency.user |
And created 'P_SSOFAA_S24' project
And created '/F_SSOFAA_S24' folder for project 'P_SSOFAA_S24'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S24' folder for 'P_SSOFAA_S24' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S24' and project 'P_SSOFAA_S24' to following users:
| UserEmails   |
| U_SSOFAA_S24 |
And login with details of 'U_SSOFAA_S24'
And open link from email when user 'U_SSOFAA_S24' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
And login with details of 'AgencyAdmin'
And go to the file comments page project 'P_SSOFAA_S24' and folder '/F_SSOFAA_S24' and file 'Fish Ad.mov'
And replay 'hi dude' on comment 'hello admin' for file 'Fish Ad.mov' in project 'P_SSOFAA_S24' and folder '/F_SSOFAA_S24'
And login with details of 'U_SSOFAA_S24'
And open link from email when user 'U_SSOFAA_S24' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And replay 'how are you?' on comment 'hi dude' on opened file preview comments page
Then I 'should' see following comments on opened file preview comments page:
| UserName     | Content      | Date  |
| U_SSOFAA_S24 | hello admin  | Today |
| AgencyAdmin  | hi dude      | Today |
| U_SSOFAA_S24 | how are you? | Today |


Scenario: Users who can see all Comments on shared file, can see comments from Secure Share user on Comments tab
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S25 | agency.user |
And created 'P_SSOFAA_S25' project
And created '/F_SSOFAA_S25' folder for project 'P_SSOFAA_S25'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S25' folder for 'P_SSOFAA_S25' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S25' and project 'P_SSOFAA_S25' to following users:
| UserEmails   | Message |
| U_SSOFAA_S25 | hi dude |
And login with details of 'U_SSOFAA_S25'
And open link from email when user 'U_SSOFAA_S25' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
And login with details of 'AgencyAdmin'
And go to the file comments page project 'P_SSOFAA_S25' and folder '/F_SSOFAA_S25' and file 'Fish Ad.mov'
Then I should see following comments for current file:
| Name        | UserType    | Email        |
| hi dude     | AgencyAdmin |              |
| hello admin |             | U_SSOFAA_S25 |


Scenario: Project Owner can see activity about Comment by Secure Share user on Project Dashboard
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S26 | agency.user |
And created 'P_SSOFAA_S26' project
And created '/F_SSOFAA_S26' folder for project 'P_SSOFAA_S26'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S26' folder for 'P_SSOFAA_S26' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S26' and project 'P_SSOFAA_S26' to following users:
| UserEmails   | Message |
| U_SSOFAA_S26 | hi dude |
And login with details of 'U_SSOFAA_S26'
And open link from email when user 'U_SSOFAA_S26' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
And login with details of 'AgencyAdmin'
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message                           | Value       |
| U_SSOFAA_S26 | commented on file - "hello admin" | Fish Ad.mov |


Scenario: User adds Expiry Date on Secure Share for file
!-- 31/07/2015-Confirmed with Maria that this scenario is no longer valid as its a date picker and user shouldnt be allowed to enter a old date
Meta: @skip
      @gdam
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S27 | agency.user |
And created 'P_SSOFAA_S27' project
And created '/F_SSOFAA_S27' folder for project 'P_SSOFAA_S27'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S27' folder for 'P_SSOFAA_S27' project
And added secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S27' and project 'P_SSOFAA_S27' to following users:
| UserEmails   | ExpireDate |
| U_SSOFAA_S27 | Yesterday  |
And waited for '60' seconds
When I login with details of 'U_SSOFAA_S27'
And open link from email when user 'U_SSOFAA_S27' received email with next subject 'Files have been shared with'
And wait for '5' seconds
Then I should see text on page contains 'We are sorry! You do not have permission to access this area.'
And 'should not' be on file preview page


Scenario: User adds Expiry Date on Secure Share for asset
!-- 31/07/2015-Confirmed with Maria that this scenario is no longer valid as its a date picker and user shouldnt be allowed to enter a old date
Meta: @skip
      @gdam
Given I created users with following fields:
| Email         | Role         |
| AU_SSOFAA_S28 | agency.admin |
| U_SSOFAA_S28  | agency.user  |
And logged in with details of 'AU_SSOFAA_S28'
And uploaded file '/files/Fish Ad.mov' into my library
And waited while transcoding is finished in collection 'My Assets'
And I added secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following users:
| UserEmails   | ExpireDate |
| U_SSOFAA_S28 | Yesterday  |
And waited for '60' seconds
When I login with details of 'U_SSOFAA_S28'
And open link from email when user 'U_SSOFAA_S28' received email with next subject 'has been shared'
And wait for '5' seconds
Then I should see text on page contains 'We are sorry! You do not have permission to access this area.'
And 'should not' be on asset preview page


Scenario: User to whom File was shared securely is notified by email when someone replies to their Comment
!-- 04/08/2015-Confirmed with Maria that this scenario is no longer valid
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email          | Role         |
| U_SSOFAA_S29_1 | agency.admin |
| U_SSOFAA_S29_2 | agency.user  |
And set following notification settings for users:
| UserEmail      | SettingName    | SettingState |
| U_SSOFAA_S29_2 | File Commented | on           |
And logged in with details of 'U_SSOFAA_S29_1'
And created 'P_SSOFAA_S29' project
And created '/F_SSOFAA_S29' folder for project 'P_SSOFAA_S29'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S29' folder for 'P_SSOFAA_S29' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S29' and project 'P_SSOFAA_S29' to following users:
| UserEmails     |
| U_SSOFAA_S29_2 |
And login with details of 'U_SSOFAA_S29_2'
And open link from email when user 'U_SSOFAA_S29_2' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
And login with details of 'U_SSOFAA_S29_1'
And go to the file comments page project 'P_SSOFAA_S29' and folder '/F_SSOFAA_S29' and file 'Fish Ad.mov'
And replay 'hi dude' on comment 'hello admin' for file 'Fish Ad.mov' in project 'P_SSOFAA_S29' and folder '/F_SSOFAA_S29'
Then I 'should' see email notification for 'Comment on secure shared file' with field to 'U_SSOFAA_S29_2' and subject 'comment has been made on file' contains following attributes:
| Agency        | UserName       | FileName    | Comment | ProjectName  |
| DefaultAgency | U_SSOFAA_S29_1 | Fish Ad.mov | hi dude | P_SSOFAA_S29 |


Scenario: User should not receive email notifications on comments not addressed to them
Meta: @gdam
      @gdamemails
Given I created users with following fields:
| Email          | Role         |
| U_SSOFAA_S30_1 | agency.admin |
| U_SSOFAA_S30_2 | agency.user  |
And set following notification settings for users:
| UserEmail      | SettingName    | SettingState |
| U_SSOFAA_S30_2 | File Commented | on           |
And logged in with details of 'U_SSOFAA_S30_1'
And created 'P_SSOFAA_S30' project
And created '/F_SSOFAA_S30' folder for project 'P_SSOFAA_S30'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S30' folder for 'P_SSOFAA_S30' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S30' and project 'P_SSOFAA_S30' to following users:
| UserEmails     |
| U_SSOFAA_S30_2 |
And login with details of 'U_SSOFAA_S30_2'
And open link from email when user 'U_SSOFAA_S30_2' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
And login with details of 'U_SSOFAA_S30_1'
And go to the file comments page project 'P_SSOFAA_S30' and folder '/F_SSOFAA_S30' and file 'Fish Ad.mov'
And add comment 'hi dude' into current file
Then I 'should not' see email notification for 'Comment on secure shared file' with field to 'U_SSOFAA_S30_2' and subject 'comment has been made on file' contains following attributes:
| Agency        | UserName       | FileName    | Comment | ProjectName  |
| DefaultAgency | U_SSOFAA_S30_1 | Fish Ad.mov | hi dude | P_SSOFAA_S30 |


Scenario: Users who can see all Comments on shared file receive email notification when Secure Share user comments on File
Meta: @gdam
      @gdamemails
Given I created users with following fields:
| Email          | Role         |
| U_SSOFAA_S31_1 | agency.admin |
| U_SSOFAA_S31_2 | agency.user  |
And set following notification settings for users:
| UserEmail      | SettingName    | SettingState |
| U_SSOFAA_S31_1 | File Commented | on           |
And logged in with details of 'U_SSOFAA_S31_1'
And created 'P_SSOFAA_S31' project
And created '/F_SSOFAA_S31' folder for project 'P_SSOFAA_S31'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S31' folder for 'P_SSOFAA_S31' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S31' and project 'P_SSOFAA_S31' to following users:
| UserEmails     |
| U_SSOFAA_S31_2 |
And login with details of 'U_SSOFAA_S31_2'
And open link from email when user 'U_SSOFAA_S31_2' received email with next subject 'Files have been shared with'
And open comments tab on opened file preview page
And add comment 'hello admin' on opened file preview comments page
And login with details of 'U_SSOFAA_S31_1'
Then I 'should' see email notification for 'Comment on secure shared file' with field to 'U_SSOFAA_S31_1' and subject 'comment has been made on file' contains following attributes:
| Agency        | UserName       | FileName    | Comment     | ProjectName  |
| DefaultAgency | U_SSOFAA_S31_2 | Fish Ad.mov | hello admin | P_SSOFAA_S31 |

Scenario: check that user see UI notification about shared asset
Meta: @gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created users with following fields:
| Email         | Role         |
| AU_SSOFAA_S32 | agency.admin |
| U_SSOFAA_S32  | agency.user  |
And logged in with details of 'AU_SSOFAA_S32'
And uploaded file '/files/Fish1-Ad.mov' into my library
And waited while transcoding is finished in collection 'My Assets'
When I add secure share for asset 'Fish1-Ad.mov' from collection 'My Assets' to following users:
| UserEmails   |
| U_SSOFAA_S32 |
And login with details of 'U_SSOFAA_S32'
And wait for '5' seconds
Then I 'should' see following notifications about sharing 'asset' on notification page:
| UserName      | FileName     |
| AU_SSOFAA_S32 | Fish1-Ad.mov |


Scenario: check that user see UI notification about shared file
Meta: @gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created users with following fields:
| Email          | Role        |
| U_SSOFAA_S33_2 | agency.user |
And created 'P_SSOFAA_S33' project
And created '/F_SSOFAA_S33' folder for project 'P_SSOFAA_S33'
And uploaded '/files/Fish1-Ad.mov' file into '/F_SSOFAA_S33' folder for 'P_SSOFAA_S33' project
When I add secure share for file 'Fish1-Ad.mov' from folder '/F_SSOFAA_S33' and project 'P_SSOFAA_S33' to following users:
| UserEmails     |
| U_SSOFAA_S33_2 |
And login with details of 'U_SSOFAA_S33_2'
Then I 'should' see following notifications about sharing 'file' on notification page:
| UserName    | FileName     |
| AgencyAdmin | Fish1-Ad.mov |


Scenario: check that shared asset is available by link in UI notification
Meta: @gdam
      @skip
Given I created users with following fields:
| Email         | Role         |
| AU_SSOFAA_S34 | agency.admin |
| U_SSOFAA_S34  | agency.user  |
And logged in with details of 'AU_SSOFAA_S34'
And uploaded file '/files/Fish1-Ad.mov' into my library
And waited while transcoding is finished in collection 'My Assets'
When I add secure share for asset 'Fish1-Ad.mov' from collection 'My Assets' to following users:
| UserEmails   |
| U_SSOFAA_S34 |
And login with details of 'U_SSOFAA_S34'
And click on share 'asset' link 'Fish1-Ad.mov' on notifications page
Then I 'should' be on asset preview page


Scenario: check that shared file is available by link in UI notification
Meta: @gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created users with following fields:
| Email          | Role        |
| U_SSOFAA_S35_2 | agency.user |
And created 'P_SSOFAA_S35' project
And created '/F_SSOFAA_S35' folder for project 'P_SSOFAA_S35'
And uploaded '/files/Fish1-Ad.mov' file into '/F_SSOFAA_S35' folder for 'P_SSOFAA_S35' project
When I add secure share for file 'Fish1-Ad.mov' from folder '/F_SSOFAA_S35' and project 'P_SSOFAA_S35' to following users:
| UserEmails     |
| U_SSOFAA_S35_2 |
And login with details of 'U_SSOFAA_S35_2'
And click on share 'file' link 'Fish1-Ad.mov' on notifications page
Then I 'should' be on file preview page


Scenario: check that activity about view file appear only for owner
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S37 | agency.user |
And created 'P_SSOFAA_S37' project
And created '/F_SSOFAA_S37' folder for project 'P_SSOFAA_S37'
And uploaded '/files/Fish1-Ad.mov' file into '/F_SSOFAA_S37' folder for 'P_SSOFAA_S37' project
When I add secure share for file 'Fish1-Ad.mov' from folder '/F_SSOFAA_S37' and project 'P_SSOFAA_S37' to following users:
| UserEmails   |
| U_SSOFAA_S37 |
And wait for '5' seconds
And login with details of 'U_SSOFAA_S37'
And click file 'Fish1-Ad.mov' link in 'shared with you' activity in My Recent Activity section on Dashboard page
And wait for '5' seconds
And login with details of 'AgencyAdmin'
Then I 'should' see activity for user 'AgencyAdmin' on file 'Fish1-Ad.mov' activity tab in project 'P_SSOFAA_S37' folder '/F_SSOFAA_S37' page with message 'shared file with U_SSOFAA_S37' and value ''


Scenario: check that activity about view asset NOT appear for recipient user on his dashboard
!--NGN-9682
Meta: @skip
      @gdam
Given I created users with following fields:
| Email         | Role         |
| AU_SSOFAA_S38 | agency.admin |
| U_SSOFAA_S38  | agency.user  |
And logged in with details of 'AU_SSOFAA_S38'
And uploaded file '/files/Fish1-Ad.mov' into my library
And waited while transcoding is finished in collection 'My Assets'
When I add secure share for asset 'Fish1-Ad.mov' from collection 'My Assets' to following users:
| UserEmails   |
| U_SSOFAA_S38 |
And login with details of 'U_SSOFAA_S38'
And click on share 'asset' link 'Fish1-Ad.mov' on notifications page
And refresh the page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message     | Value        |
| U_SSOFAA_S38 | viewed file | Fish1-Ad.mov |


Scenario: check that activity about view file NOT appear for recipient user on his dashboard
!--NGN-9682
Meta: @skip
      @gdam
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S39 | agency.user |
And created 'P_SSOFAA_S39' project
And created '/F_SSOFAA_S39' folder for project 'P_SSOFAA_S39'
And uploaded '/files/Fish1-Ad.mov' file into '/F_SSOFAA_S39' folder for 'P_SSOFAA_S39' project
When I add secure share for file 'Fish1-Ad.mov' from folder '/F_SSOFAA_S39' and project 'P_SSOFAA_S39' to following users:
| UserEmails   |
| U_SSOFAA_S39 |
And login with details of 'U_SSOFAA_S39'
And click on share 'file' link 'Fish1-Ad.mov' on notifications page
And refresh the page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message     | Value        |
| U_SSOFAA_S39 | viewed file | Fish1-Ad.mov |


Scenario: check that activity about download master asset NOT appear for recipient user on his dashboard
!--NGN-9683
Meta: @skip
      @gdam
Given I created users with following fields:
| Email         | Role         |
| AU_SSOFAA_S40 | agency.admin |
| U_SSOFAA_S40  | agency.user  |
And logged in with details of 'AU_SSOFAA_S40'
And uploaded file '/files/Fish Ad.mov' into my library
And waited while transcoding is finished in collection 'My Assets'
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following users:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S40 | true             |
And login with details of 'U_SSOFAA_S40'
And open link from email when user 'U_SSOFAA_S40' received email with next subject 'has been shared'
And download original file on opened asset preview page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message                     | Value       |
| U_SSOFAA_S40 | downloaded the asset master | Fish Ad.mov |


Scenario: check that activity about download master file NOT appear for recipient user on his dashboard
!--NGN-9683
Meta: @skip
      @gdam
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S41 | agency.user |
And created 'P_SSOFAA_S41' project
And created '/F_SSOFAA_S41' folder for project 'P_SSOFAA_S41'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S41' folder for 'P_SSOFAA_S41' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S41' and project 'P_SSOFAA_S41' to following users:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S41 | true             |
And login with details of 'U_SSOFAA_S41'
And open link from email when user 'U_SSOFAA_S41' received email with next subject 'Files have been shared with'
And download original file on opened file preview page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message                | Value                     |
| U_SSOFAA_S41 | downloaded file master | /F_SSOFAA_S41/Fish Ad.mov |


Scenario: check that activity about download asset proxy appear for owner
Meta: @skip
      @gdam
Given I created users with following fields:
| Email         | Role         |
| AU_SSOFAA_S42 | agency.admin |
| U_SSOFAA_S42  | agency.user  |
And logged in with details of 'AU_SSOFAA_S42'
And uploaded file '/files/Fish Ad.mov' into my library
And waited while transcoding is finished in collection 'My Assets'
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following users:
| UserEmails   | DownloadProxy |
| U_SSOFAA_S42 | true          |
And login with details of 'U_SSOFAA_S42'
And open link from email when user 'U_SSOFAA_S42' received email with next subject 'has been shared'
And download proxy file on opened asset preview page
And login with details of 'AU_SSOFAA_S42'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message                    | Value       |
| U_SSOFAA_S42 | downloaded the asset proxy | Fish Ad.mov |


Scenario: check that activity about download file proxy appear for owner
Meta: @gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S43 | agency.user |
And created 'P_SSOFAA_S43' project
And created '/F_SSOFAA_S43' folder for project 'P_SSOFAA_S43'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S43' folder for 'P_SSOFAA_S43' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S43' and project 'P_SSOFAA_S43' to following users:
| UserEmails   | DownloadProxy |
| U_SSOFAA_S43 | true          |
And login with details of 'U_SSOFAA_S43'
And open link from email when user 'U_SSOFAA_S43' received email with next subject 'Files have been shared with'
And download proxy file on opened file preview page
And login with details of 'AgencyAdmin'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message                 | Value                     |
| U_SSOFAA_S43 | downloaded file preview | /P_SSOFAA_S43/F_SSOFAA_S43/Fish Ad.mov |


Scenario: check that activity about download proxy asset NOT appear for recipient user on his dashboard
!--NGN-9683
Meta: @skip
      @gdam
Given I created users with following fields:
| Email         | Role         |
| AU_SSOFAA_S44 | agency.admin |
| U_SSOFAA_S44  | agency.user  |
And logged in with details of 'AU_SSOFAA_S44'
And uploaded file '/files/Fish Ad.mov' into my library
And waited while transcoding is finished in collection 'My Assets'
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following users:
| UserEmails   | DownloadProxy |
| U_SSOFAA_S44 | true          |
And login with details of 'U_SSOFAA_S44'
And open link from email when user 'U_SSOFAA_S44' received email with next subject 'has been shared'
And download proxy file on opened asset preview page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message                    | Value       |
| U_SSOFAA_S44 | downloaded the asset proxy | Fish Ad.mov |


Scenario: check that activity about download proxy file NOT appear for recipient user on his dashboard
!--NGN-9683
Meta: @skip
      @gdam
Given I created users with following fields:
| Email        | Role        |
| U_SSOFAA_S45 | agency.user |
And created 'P_SSOFAA_S45' project
And created '/F_SSOFAA_S45' folder for project 'P_SSOFAA_S45'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S45' folder for 'P_SSOFAA_S45' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S45' and project 'P_SSOFAA_S45' to following users:
| UserEmails   | DownloadProxy |
| U_SSOFAA_S45 | true          |
And login with details of 'U_SSOFAA_S45'
And open link from email when user 'U_SSOFAA_S45' received email with next subject 'Files have been shared with'
And download proxy file on opened file preview page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message               | Value                     |
| U_SSOFAA_S45 | downloaded file proxy | /F_SSOFAA_S45/Fish Ad.mov |




Scenario: user without file.download and proxy.download cant secure share to download proxy or master
Meta: @gdam
@gdamemails
!--NGN-16658
Given I created the following agency:
| Name              |
| A_PSOFAA_S17_ATP1 |
And created 'PR_PSOFAA_S17_ATP1' role with 'element.read,element.share,project.read,folder.read,folder.share,element.public_share.create' permissions in 'project' group for advertiser 'A_PSOFAA_S17_ATP1'
And created users with following fields:
| Email               | Role         | Agency            |
| U_PSOFAA_S17_1_ATP1 | agency.admin | A_PSOFAA_S17_ATP1 |
| U_PSOFAA_S17_2_ATP1 | agency.user  | A_PSOFAA_S17_ATP1 |
| U_PSOFAA_S17_3_ATP1 | agency.user  | A_PSOFAA_S17_ATP1 |
And logged in with details of 'U_PSOFAA_S17_1_ATP1'
And created 'P_PSOFAA_S17_ATP1' project
And created '/F_PSOFAA_S17_ATP1' folder for project 'P_PSOFAA_S17_ATP1'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S17_ATP1' folder for 'P_PSOFAA_S17_ATP1' project
And waited while preview is available in folder '/F_PSOFAA_S17_ATP1' on project 'P_PSOFAA_S17_ATP1' files page
And added users 'U_PSOFAA_S17_2_ATP1' to project 'P_PSOFAA_S17_ATP1' team folders 'F_PSOFAA_S17_ATP1' with role 'PR_PSOFAA_S17_ATP1' expired '12.12.2021' and 'should' access to subfolders
And logged in with details of 'U_PSOFAA_S17_2_ATP1'
When I open Secure share for file 'Fish Ad.mov' in folder 'F_PSOFAA_S17_ATP1' and project 'P_PSOFAA_S17_ATP1'
Then I 'should not' see element 'DownloadProxy' on page 'SecureSharePopup'
Then I 'should not' see element 'DownloadOriginal' on page 'SecureSharePopup'
When I refresh the page without delay
And add secure share for file without download permission 'Fish Ad.mov' from folder '/F_PSOFAA_S17_ATP1' and project 'P_PSOFAA_S17_ATP1' to following users:
| UserEmails     |
| U_PSOFAA_S17_3_ATP1 |
And login with details of 'U_PSOFAA_S17_3_ATP1'
And open link from email when user 'U_PSOFAA_S17_3_ATP1' received email with next subject 'Files have been shared'
Then I 'should' be on file preview page
Then I 'should not' see element 'DownloadProxy' on page 'PublicFilePreview'
Then I 'should not' see element 'DownloadMaster' on page 'PublicFilePreview'



Scenario: user with file.download and without proxy.download can secure share to download master
Meta: @gdam
@gdamemails
!--NGN-16658
Given I created the following agency:
| Name              |
| A_PSOFAA_S17_ATP2 |
And created 'PR_PSOFAA_S17_ATP2' role with 'element.read,element.share,project.read,folder.read,folder.share,element.public_share.create,file.download' permissions in 'project' group for advertiser 'A_PSOFAA_S17_ATP2'
And created users with following fields:
| Email               | Role         | Agency            |
| U_PSOFAA_S17_1_ATP2 | agency.admin | A_PSOFAA_S17_ATP2 |
| U_PSOFAA_S17_2_ATP2 | agency.user  | A_PSOFAA_S17_ATP2 |
| U_PSOFAA_S17_3_ATP2 | agency.user  | A_PSOFAA_S17_ATP2 |
And logged in with details of 'U_PSOFAA_S17_1_ATP2'
And created 'P_PSOFAA_S17_ATP2' project
And created '/F_PSOFAA_S17_ATP2' folder for project 'P_PSOFAA_S17_ATP2'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S17_ATP2' folder for 'P_PSOFAA_S17_ATP2' project
And waited while preview is available in folder '/F_PSOFAA_S17_ATP2' on project 'P_PSOFAA_S17_ATP2' files page
And added users 'U_PSOFAA_S17_2_ATP2' to project 'P_PSOFAA_S17_ATP2' team folders 'F_PSOFAA_S17_ATP2' with role 'PR_PSOFAA_S17_ATP2' expired '12.12.2021' and 'should' access to subfolders
And logged in with details of 'U_PSOFAA_S17_2_ATP2'
When I open Secure share for file 'Fish Ad.mov' in folder 'F_PSOFAA_S17_ATP2' and project 'P_PSOFAA_S17_ATP2'
Then I 'should not' see element 'DownloadProxy' on page 'SecureSharePopup'
Then I 'should' see element 'DownloadOriginal' on page 'SecureSharePopup'
When I refresh the page without delay
And add secure share for file 'Fish Ad.mov' from folder '/F_PSOFAA_S17_ATP2' and project 'P_PSOFAA_S17_ATP2' to following users:
| UserEmails          |DownloadOriginal|
| U_PSOFAA_S17_3_ATP2 |true            |
And login with details of 'U_PSOFAA_S17_3_ATP2'
And open link from email when user 'U_PSOFAA_S17_3_ATP2' received email with next subject 'Files have been shared'
Then I 'should' be on file preview page
Then I 'should not' see element 'DownloadProxy' on page 'SecureFilePreview'
Then I 'should' see element 'DownloadMaster' on page 'SecureFilePreview'


Scenario: Sharing a project file by S3 BU with Adgate User
Meta: @gdam
@gdamemails
!--QA-607
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name          |
| S3BU_SSOFAA_1   |
And updated the following agency:
| Name          | Storage |
| S3BU_SSOFAA_1 | S3 |
And created users with following fields:
| Email                | Role          | Agency           |
| s3Admin_SSOFAA_1     | agency.admin  |  S3BU_SSOFAA_1   |
| U_SSOFAA_1           | agency.user   |  DefaultAgency   |
And logged in with details of 's3Admin_SSOFAA_1'
And created 'P_SSOFAA_S3BU' project
And created '/F_SSOFAA_S3BU' folder for project 'P_SSOFAA_S3BU'
And uploaded '/files/Fish Ad.mov' file into '/F_SSOFAA_S3BU' folder for 'P_SSOFAA_S3BU' project
When I add secure share for file 'Fish Ad.mov' from folder '/F_SSOFAA_S3BU' and project 'P_SSOFAA_S3BU' to following users:
| UserEmails |
| U_SSOFAA_1 |
And login with details of 'U_SSOFAA_1'
And wait for '10' seconds
And open link from email when user 'U_SSOFAA_1' received email with next subject 'Files have been shared with'
Then I 'should' be on file preview page

Scenario: User with permission asset.share can create secure share of Asset
Meta: @gdam
@library
Given I created the following agency:
| Name         |
| A_SSOFAA_S02 |
And created users with following fields:
| Email          | Role         | Agency       |Access|
| U_SSOFAA_S02_1 | agency.admin | A_SSOFAA_S02 |streamlined_library|
| U_SSOFAA_S02_2 | agency.user  | A_SSOFAA_S02 |streamlined_library|
| U_SSOFAA_S02_3 | agency.user  | A_SSOFAA_S02 |streamlined_library|
And created 'LR_SSOFAA_S02' role with 'asset_filter_category.read,asset.read,asset.write,asset.share' permissions in 'library' group for advertiser 'A_SSOFAA_S02'
And logged in with details of 'U_SSOFAA_S02_1'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_SSOFAA_S02' category
And added users 'U_SSOFAA_S02_2' to category 'C_SSOFAA_S02' with role 'LR_SSOFAA_S02' by users details
When I login with details of 'U_SSOFAA_S02_2'
And go to the Library page for collection 'C_SSOFAA_S02'NEWLIB
And add secure share for asset without download permission 'Fish Ad.mov' from collection 'C_SSOFAA_S02' to following usersNEWLIB:
| UserEmails     |
| U_SSOFAA_S02_3 |
Then I 'should' see following '1' users on Secure Shares tab in Share files popup for asset 'Fish Ad.mov' on 'My Assets' Library pageNEWLIB:
| UserName       |
| U_SSOFAA_S02_3 |

Scenario: User cannot edit metadata on shared to him Asset
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email         | Role         |Access|
| AU_SSOFAA_S09 | agency.admin |streamlined_library|
| U_SSOFAA_S09  | agency.user  |streamlined_library|
And logged in with details of 'AU_SSOFAA_S09'
And set following notification settings for user:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S09 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I add secure share for asset without download permission 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   |
| U_SSOFAA_S09 |
When I login with details of 'U_SSOFAA_S09'
And open link from email when user 'U_SSOFAA_S09' received email with next subject 'has been shared'
Then I 'should not' see Edit link on opened asset preview page

Scenario: User to whom Asset was shared can log in and view shared asset with metadata on secure Share page outside of their Adbank
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email         | Role         |Access|
| AU_SSOFAA_S11 | agency.admin |streamlined_library|
| U_SSOFAA_S11  | agency.user  |streamlined_library|
And logged in with details of 'AU_SSOFAA_S11'
And set following notification settings for user:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S11 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When add secure share for asset without download permission 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails     |
| U_SSOFAA_S11 |
When I login with details of 'U_SSOFAA_S11'
And open link from email when user 'U_SSOFAA_S11' received email with next subject 'has been shared'
Then I 'should' be on asset preview page




Scenario: User should receive email notification about asset sharing with him
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email         | Role         |  Access            |
| AU_SSOFAA_S13 | agency.admin |streamlined_library |
| U_SSOFAA_S13  | agency.user  |                    |
And logged in with details of 'AU_SSOFAA_S13'
And set following notification settings for users:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S13 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   |
| U_SSOFAA_S13 |
And wait for '10' seconds
Then I 'should' see email notification for 'Asset sharing with user' with field to 'U_SSOFAA_S13' and subject 'has been shared with' contains following attributes:
| UserName      | UserName1    | Agency        | FileName    |
| AU_SSOFAA_S13 | U_SSOFAA_S13 | DefaultAgency | Fish Ad.mov |

Scenario: User to whom Asset was securely shared can Download asset
Meta: @qagdamsmoke
      @livegdamsmoke
      @gdam
      @gdamemails
      @gdamcrossbrowser
Given I created users with following fields:
| Email         | Role         |Access|
| AU_SSOFAA_S15 | agency.admin |streamlined_library|
| U_SSOFAA_S15  | agency.user  |streamlined_library|
And logged in with details of 'AU_SSOFAA_S15'
And set following notification settings for user:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S15 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S15 | true             |
And login with details of 'U_SSOFAA_S15'
And open link from email when user 'U_SSOFAA_S15' received email with next subject 'has been shared'
Then I 'should' see Download original button on opened asset preview page

Scenario: User can see Activity about download by Secure Share user in Asset Activity tab
Meta: @gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| AU_SSOFAA_S17 | agency.admin |streamlined_library|
| U_SSOFAA_S17  | agency.user  |streamlined_library|
And logged in with details of 'AU_SSOFAA_S17'
And set following notification settings for user:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S17 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S17 | true             |
And login with details of 'U_SSOFAA_S17'
And open link from email when user 'U_SSOFAA_S17' received email with next subject 'has been shared'
And download original file on opened asset preview page
And login with details of 'AU_SSOFAA_S17'
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName     | Message                        | Value |
| U_SSOFAA_S17 | Downloaded by|       |

Scenario: User can see Activity about downloading asset by Secure Share user on Dashboard page
Meta: @gdam
@projects
Given I created users with following fields:
| Email         | Role         | Access               |
| AU_SSOFAA_S19 | agency.admin |streamlined_library,dashboard  |
| U_SSOFAA_S19  | agency.user  |streamlined_library ,dashboard  |
And logged in with details of 'AU_SSOFAA_S19'
And set following notification settings for user:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S19 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S19 | true             |
And login with details of 'U_SSOFAA_S19'
And open link from email when user 'U_SSOFAA_S19' received email with next subject 'has been shared'
And download original file on opened asset preview page
And login with details of 'AU_SSOFAA_S19'
And go to Dashboard page
Then I 'should'  see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message                         | Value |
| U_SSOFAA_S19 | has downloaded file Fish Ad.mov |   Fish Ad.mov    |


Scenario: check that activity about view asset appear for owner
Meta: @gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| AU_SSOFAA_S36 | agency.admin |streamlined_library,dashboard|
| U_SSOFAA_S36  | agency.user  |streamlined_library,dashboard|
And logged in with details of 'AU_SSOFAA_S36'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add secure share for asset 'Fish1-Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   |
| U_SSOFAA_S36 |
And wait for '5' seconds
And login with details of 'U_SSOFAA_S36'
And I go to Dashboard page
And click file 'Fish1-Ad.mov' link in 'shared with you' activity in My Recent Activity section on Dashboard page
And wait for '5' seconds
And login with details of 'AU_SSOFAA_S36'
When I go to asset 'Fish1-Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish1-Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName     | Message      | Value |
| U_SSOFAA_S36 | Viewed by |       |

Scenario: check that user can't see tab 'comments' on shared asset
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email         | Role         |Access|
| AU_SSOFAA_S46 | agency.admin |streamlined_library|
| U_SSOFAA_S46  | agency.user  |streamlined_library|
And logged in with details of 'AU_SSOFAA_S46'
And set following notification settings for user:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S46 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   |
| U_SSOFAA_S46 |
And login with details of 'U_SSOFAA_S46'
And open link from email when user 'U_SSOFAA_S46' received email with next subject 'has been shared'
Then I 'should not' see 'Comments' tab on opened asset preview page


Scenario: check that user can't see tab 'comments' on shared asset when some user added some comment after sharing
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email         | Role         |Access|
| AU_SSOFAA_S47 | agency.admin |streamlined_library|
| U_SSOFAA_S47  | agency.user  |streamlined_library|
And logged in with details of 'AU_SSOFAA_S47'
And set following notification settings for user:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S47 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   | Message |
| U_SSOFAA_S47 | Hi dude |
And login with details of 'U_SSOFAA_S47'
And open link from email when user 'U_SSOFAA_S47' received email with next subject 'has been shared'
Then I 'should not' see 'Comments' tab on opened asset preview page

Scenario: Check that if user shared several assets,then recipient should receive one email instead several (user from current BU/from Another)
Meta: @gdam
      @bug
      @gdamemails
!--SPB-2052
Given I created the following agency:
| Name      |
| A_SSA_S01 |
| A_SSA_S02 |
And I created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_SSA_S01 | agency.admin | A_SSA_S01    |streamlined_library|
| U_SSA_S02 | agency.user  | A_SSA_S01    |streamlined_library|
| U_SSA_S03 | agency.user  | A_SSA_S02    |streamlined_library|
And logged in with details of 'U_SSA_S01'
And uploaded following files into my libraryNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name         |
| Fish1-Ad.mov |
| Fish2-Ad.mov |
| Fish3-Ad.mov |
And I have refreshed the page
When add secure share for multiple assets from collection 'My Assets' to following usersNEWLIB:
| UserEmails          |
| U_SSA_S02,U_SSA_S03 |
Then I 'should' see only one email with subject 'Assets has been shared' sent to 'U_SSA_S02'
And I 'should' see only one email with subject 'Assets has been shared' sent to 'U_SSA_S03'


Scenario: Check that file could be playable from this link
Meta: @gdam
@gdamemails
Given I created the following agency:
| Name      |
| A_SSA_S03 |
And I created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_SSA_S04 | agency.admin | A_SSA_S03    |streamlined_library|
| U_SSA_S05 | agency.user  | A_SSA_S03    |streamlined_library|
And logged in with details of 'U_SSA_S04'
And uploaded following files into my libraryNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name         |
| Fish1-Ad.mov |
| Fish2-Ad.mov |
| Fish3-Ad.mov |
And I have refreshed the page
When add secure share for multiple assets from collection 'My Assets' to following usersNEWLIB:
| UserEmails |
| U_SSA_S05  |
And I login with details of 'U_SSA_S05'
And I open link from email when user 'U_SSA_S05' received email with next subject 'Assets has been shared'
Then I 'should' be able to play the asset on preview page

Scenario: Check that if user share several files to not registered user, recipient can open files
Meta: @gdam
@gdamemails
Given I created the following agency:
| Name      |
| A_SSA_S04 |
And I created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_SSA_S06 | agency.admin | A_SSA_S04    |streamlined_library|
And logged in with details of 'U_SSA_S06'
And uploaded following files into my libraryNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name         |
| Fish1-Ad.mov |
| Fish2-Ad.mov |
| Fish3-Ad.mov |
And I have refreshed the page
When add secure share for multiple assets from collection 'My Assets' to following usersNEWLIB:
| UserEmails |
| U_SSA_S07  |
And open link from email when user 'U_SSA_S07' received email with next subject 'You are invited to Adbank'
And fill registration form with following fields:
| FirstName     | LastName      | Password   | ConfirmPassword |
| U_SSA_S07_FN  | U_SSA_S07_LN  | abcdefghA1 | abcdefghA1      |
And click element 'SaveButton' on page 'Registration'
Then I 'should' be on asset preview page