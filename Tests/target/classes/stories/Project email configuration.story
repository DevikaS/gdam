!--NGN-538 NGN-3394
Feature:          Project email configuration
Narrative:
In order to
As a              AgencyAdmin
I want to         Check project email configuration

Scenario: Check that email notification is sent with new user details (S7)
Meta:
@skip
@gdam
@gdamemails
Given I created users with following fields:
| Email    |
| PemcoS7A |
| PemcoS7B |
And I logged in with details of 'PemcoS7A'
And I created following projects:
| Name               | Advertiser    | Administrators |
| Bandstand PEN S7 A | DefaultAgency | PemcoS7B       |
And I am on user 'PemcoS7A' details page
When I change fields on page user details on following values:
| FirstName | LastName   |
| Sibra     | Arqanovich |
And I open project 'Bandstand PEN S7 A' settings page
When I edit the following fields for 'Bandstand PEN S7 A' project:
| Name               | Administrators |
| Bandstand PEN S7 A | NoviceS7A      |
And click on element 'SaveButton'
Then I 'should' see email notification for 'Project owner added' with field to 'PemcoS7B' and subject 'has been added as Project Owner on Project' contains following attributes:
| UserName  | Agency        | ProjectName        |
| NoviceS7A | DefaultAgency | Bandstand PEN S7 A |


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. Project owner removed (S10)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS10A |
And I created following projects:
| Name            | Advertiser    | Administrators |
| Flier PEN S10 A | DefaultAgency | PemcoS10A      |
And I created '/Shirt PEN S10 A' folder for project 'Flier PEN S10 A'
And I uploaded into project 'Flier PEN S10 A' following files:
| FileName          | Path             |
| /files/filetext.txt | /Shirt PEN S10 A |
And I am on project 'Flier PEN S10 A' settings page
And I removed administrator 'PemcoS10A' from project 'Flier PEN S10 A'
When I click Save button on project popup
And I edit the following fields for 'Flier PEN S10 A' project:
| Name            | Administrators |
| Flier PEN S10 A | NoviceS10A     |
And click on element 'SaveButton'
And I remove administrator 'NoviceS10A' from project 'Flier PEN S10 A'
Then I 'should not' see email notification for 'Project owner removed' with field to 'PemcoS10A' and subject 'has been removed from owners of' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. Shared folder through popup window (S11).
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS11A |
And I created following projects:
| Name          | Advertiser    | Administrators |
| Shy PEN S11 A | DefaultAgency | PemcoS11A      |
And I created '/Shoes PEN S11 A' folder for project 'Shy PEN S11 A'
And I uploaded into project 'Shy PEN S11 A' following files:
| FileName          | Path             |
| /files/filetext.txt | /Shoes PEN S11 A |
And I am on project 'Shy PEN S11 A' settings page
And I removed administrator 'PemcoS11A' from project 'Shy PEN S11 A'
When I click Save button on project popup
And I open Share window from popup menu for folder '/Shoes PEN S11 A' on project 'Shy PEN S11 A'
And fill Share popup of project folder for user 'new_user10' with role 'project.user' expired '12.12.2021' and 'should not' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS11A' and subject 'Folder(s) were shared with you' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. Add user through team page (S12).
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS12A |
And I created following projects:
| Name           | Advertiser    | Administrators |
| Damn PEN S12 A | DefaultAgency | PemcoS12A      |
And I created '/Singlet PEN S12 A' folder for project 'Damn PEN S12 A'
And I uploaded into project 'Damn PEN S12 A' following files:
| FileName          | Path               |
| /files/filetext.txt | /Singlet PEN S12 A |
And I am on project 'Damn PEN S12 A' settings page
And I removed administrator 'PemcoS12A' from project 'Damn PEN S12 A'
When I click Save button on project popup
And I go to project 'Damn PEN S12 A' teams page
And I add user 'NoviceS12A' into project 'Damn PEN S12 A' team with role 'Project User' expired '12.12.2021' for folder on popup '/Singlet PEN S12 A'
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS12A' and subject 'Folder(s) were shared with' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. Folder change permission (S13).
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS13A |
| PemcoS13B |
And I created following projects:
| Name           | Advertiser    | Administrators |
| Dice PEN S13 A | DefaultAgency | PemcoS13A      |
And I created '/Pants PEN S13 A' folder for project 'Dice PEN S13 A'
And added users 'PemcoS13B' to project 'Dice PEN S13 A' team folders '/Pants PEN S13 A' with role 'project.user' expired '12.12.2021'
And I uploaded into project 'Dice PEN S13 A' following files:
| FileName          | Path             |
| /files/filetext.txt | /Pants PEN S13 A |
And I am on project 'Dice PEN S13 A' settings page
And I removed administrator 'PemcoS13A' from project 'Dice PEN S13 A'
When I click Save button on project popup
And I open Share window from popup menu for folder '/Pants PEN S13 A' on project 'Dice PEN S13 A'
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
And I remove user 'PemcoS13B' from users tab on Share window
And I click 'OK' on the alert
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS13A' and subject 'changed permissions to folder(s) for' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. Unshare folder (S14)
Meta:@skip
     @gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS14A |
And I created following projects:
| Name             | Advertiser    | Administrators |
| Mailed PEN S14 A | DefaultAgency | PemcoS14A      |
And I created users with following fields:
| Email     |
| PemcoS14B |
And I created '/Hat PEN S14 A' folder for project 'Mailed PEN S14 A'
And I uploaded into project 'Mailed PEN S14 A' following files:
| FileName          | Path           |
| /files/filetext.txt | /Hat PEN S14 A |
And I added users 'PemcoS14B' to project 'Mailed PEN S14 A' team folders '/Hat PEN S14 A' with role 'project.user' expired '12.12.2021'
And I am on project 'Mailed PEN S14 A' settings page
And I removed administrator 'PemcoS14A' from project 'Mailed PEN S14 A'
When I click Save button on project popup
And I go to project 'Mailed PEN S14 A' folder '/Hat PEN S14 A' page
And I click element 'Share' on page 'FilesPage'
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
And I remove user 'PemcoS14B' from users tab on Share window
And click element 'Save' on page 'ShareWindow'
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS14A' and subject 'Skiped - bug' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. Remove user from team page (S15)
Meta:
@skip
@gdam
@gdamemails
Given I created users with following fields:
| Email     |
| PemcoS15A |
| PemcoS15B |
And I created following projects:
| Name            | Advertiser    | Administrators |
| Blown PEN S15 A | DefaultAgency | PemcoS15A      |
And I created '/Tie PEN S15 A' folder for project 'Blown PEN S15 A'
And added users 'PemcoS15B' to project 'Blown PEN S15 A' team folders '/Tie PEN S15 A' with role 'project.user' expired '12.12.2021'
And I uploaded into project 'Blown PEN S15 A' following files:
| FileName          | Path           |
| /files/filetext.txt | /Tie PEN S15 A |
And I am on project 'Blown PEN S15 A' settings page
And I removed administrator 'PemcoS15A' from project 'Blown PEN S15 A'
When I click Save button on project popup
And go to project 'Blown PEN S15 A' teams page
And I remove user 'PemcoS15B' from project 'Blown PEN S15 A' team page
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS15A' and subject 'skip - bug' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. Comment file (S16)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS16A |
And I created following projects:
| Name                | Advertiser    | Administrators |
| Got a bee PEN S16 A | DefaultAgency | PemcoS16A      |
And I created '/Button PEN S16 A' folder for project 'Got a bee PEN S16 A'
And I uploaded into project 'Got a bee PEN S16 A' following files:
| FileName          | Path              |
| /files/filetext.txt | /Button PEN S16 A |
And I am on project 'Got a bee PEN S16 A' settings page
And I removed administrator 'PemcoS16A' from project 'Got a bee PEN S16 A'
When I click Save button on project popup
And wait while transcoding is finished in folder '/Button PEN S16 A' on project 'Got a bee PEN S16 A' files page
And I go to the file comments page project 'Got a bee PEN S16 A' and folder '/Button PEN S16 A' and file 'filetext.txt'
When I add comment 'It is my point of view' into current file
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS16A' and subject 'Comment on file' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. Download file (S17)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS17A |
And I created following projects:
| Name              | Advertiser    | Administrators |
| Blanket PEN S17 A | DefaultAgency | PemcoS17A      |
And I created '/Cuff PEN S17 A' folder for project 'Blanket PEN S17 A'
And I uploaded into project 'Blanket PEN S17 A' following files:
| FileName          | Path            |
| /files/filetext.txt | /Cuff PEN S17 A |
And I am on project 'Blanket PEN S17 A' settings page
And I removed administrator 'PemcoS17A' from project 'Blanket PEN S17 A'
When I click Save button on project popup
And wait while transcoding is finished in folder '/Cuff PEN S17 A' on project 'Blanket PEN S17 A' files page
And I downloaded file 'filetext.txt' on folder '/Cuff PEN S17 A' project 'Blanket PEN S17 A' file info page
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS17A' and subject 'File downloaded:' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. File played (S18)
Meta: @gdam
      @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS18A |
And I created following projects:
| Name            | Advertiser    | Administrators |
| Under PEN S18 A | DefaultAgency | PemcoS18A      |
And I created '/Frack PEN S18 A' folder for project 'Under PEN S18 A'
And I uploaded into project 'Under PEN S18 A' following files:
| FileName           | Path             |
| /files/Fish Ad.mov | /Frack PEN S18 A |
And I am on project 'Under PEN S18 A' settings page
And I removed administrator 'PemcoS18A' from project 'Under PEN S18 A'
When I click Save button on project popup
And wait while transcoding is finished in folder '/Frack PEN S18 A' on project 'Under PEN S18 A' files page
And I go to file 'Fish Ad.mov' info page in folder '/Frack PEN S18 A' project 'Under PEN S18 A'
And I wait while proxy is visible on file info page
And play clip on file 'Fish Ad.mov' info page in folder '/Frack PEN S18 A' project 'Under PEN S18 A'
And wait for '1' seconds
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS18A' and subject 'Preview file played:' contains following attributes: ||


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. File upload (S19)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS19A |
And I created following projects:
| Name             | Advertiser    | Administrators |
| Awhile PEN S19 A | DefaultAgency | PemcoS19A      |
And I created '/Sleeve PEN S19 A' folder for project 'Awhile PEN S19 A'
And I uploaded into project 'Awhile PEN S19 A' following files:
| FileName          | Path              |
| /files/filetext.txt | /Sleeve PEN S19 A |
And I am on project 'Awhile PEN S19 A' settings page
And I removed administrator 'PemcoS19A' from project 'Awhile PEN S19 A'
When I click Save button on project popup
And I upload into project 'Awhile PEN S19 A' following files:
| FileName      | Path              |
| /files/file_1 | /Sleeve PEN S19 A |
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS19A' and subject 'File uploaded:' contains following attributes: ||



Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. File deleted (S21)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS21A |
And I created following projects:
| Name                | Advertiser    | Administrators |
| Break out PEN S21 A | DefaultAgency | PemcoS21A      |
And I created '/Ugg boots PEN S21 A' folder for project 'Break out PEN S21 A'
And I uploaded into project 'Break out PEN S21 A' following files:
| FileName          | Path                 |
| /files/_file1.gif | /Ugg boots PEN S21 A |
And I am on project 'Break out PEN S21 A' settings page
And I removed administrator 'PemcoS21A' from project 'Break out PEN S21 A'
When I click Save button on project popup
And I go to project 'Break out PEN S21 A' folder '/Ugg boots PEN S21 A' page
When I 'delete' file '_file1.gif' from project files page
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS21A' and subject 'File has been deleted:' contains following attributes: ||


Scenario: Check that project owner receives email notification about actions in his project
!--NGN-4108 NGN-3127 NGN-3886
Meta:
@skip
@gdam
@gdamemails
Given created the following users:
| first name | last name | email     | Advertiser |
| first16-1  | last16-1  | email16-1 | qa agency  |
| first16-2  | last16-2  | email16-2 | qa agency  |
And logged in by 'email16-1' user
And created 'project16' project with 'email16-2@adstream.com' user as project administrator
And 'email16-2@adstream.com' user has all email notifications turned on
And created 'folder16' folder in 'project16' project
And uploaded 'file16' file into 'folder16' folder
When I do '<Action>'
Then I should see that 'email16-2' user receives '<email>'

Examples:
| Action                                      | Email                                                                                                               |
| add project owner 'newuser16'               | newuser16 from qa agency has been added as owner on project16 by first16-1 last16-1 from qa agency                  |
| remove project owner 'newuser16'            | newuser16 from qa agency has been removed from owners of project16 by first16-1 last16-1 from qa agency             |
| share 'folder16' folder to newuser17 user   | first16-1 last16-1 from qa agency shared folder(s) with 'newuser17' from qa agency: project16\folder16              |
| folder change permission for newuser17 user | first16-1 last16-1 from qa agency changed permissions to folder(s) for newuser17 from qa agency: project16\folder16 |
| unshare folder                              | skip due to bug                                                                                                     |
| add user via Team                           | skip due to bug                                                                                                     |
| remove user via Team                        | skip due to bug                                                                                                     |
| write 'test' comment on 'file16' file       | first16-1 last16-1 has left a comment on file16 test                                                                |
| 'file16' file downloaded                    | File has been downloaded by first16-1 last16-1 from qa agency: project16/folder16/file16                            |
| 'file17' file played                        | Preview file has been played by first16-1 last16-1 from qa agency: project16/folder16/file17                        |
| 'file17' file upload                        | first16-1 last16-1 from qa agency uploaded file17 to project16\folder16                                             |
| 'file18' file upload failed                 |                                                                                                                     |
| 'file19' preview transcode failed           |                                                                                                                     |
| move 'file17' file to library               | Your file has been moved to library successfully:                                                                   |
| 'file19' file deleted                       | File has been deleted: project16/folder16/file19                                                                    |


Scenario: Check that project owner receives email notification about actions in his project. Shared folder through popup window (S24). (link project and folder)
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS24A |
| PemcoS24B |
And I created following projects:
| Name                | Advertiser    | Administrators      |
| Dollin Up PEN S24 A | DefaultAgency | PemcoS24A,PemcoS24B |
And I created '/Tape PEN S24 A' folder for project 'Dollin Up PEN S24 A'
And I uploaded into project 'Dollin Up PEN S24 A' following files:
| FileName          | Path            |
| /files/filetext.txt | /Tape PEN S24 A |
And I am on project 'Dollin Up PEN S24 A' folder '/Tape PEN S24 A' page
When I open Share window from popup menu for folder '/Tape PEN S24 A' on project 'Dollin Up PEN S24 A'
And fill Share popup of project folder for user 'NoviceS24A' with role 'project.user' expired '12.12.2021' and 'should not' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Then I 'should' see email notification for 'Folder sharing for' with field to 'PemcoS24A' and subject 'has been shared with' contains following attributes:
| Agency        | ProjectName         | FolderName     | UserName1  |
| DefaultAgency | Dollin Up PEN S24 A | Tape PEN S24 A | NoviceS24A |


Scenario: Check that project owner receives email notification about actions in his project. Folder change permission (S25).
Meta:
@skip
@gdam
@gdamemails
Given I created users with following fields:
| Email     |
| PemcoS25A |
| PemcoS25B |
And I created following projects:
| Name                | Advertiser    | Administrators |
| Slinkiest PEN S25 A | DefaultAgency | PemcoS25A      |
And I created '/Gloves PEN S25 A' folder for project 'Slinkiest PEN S25 A'
And added users 'PemcoS25B' to project 'Slinkiest PEN S25 A' team folders '/Gloves PEN S25 A' with role 'project.user' expired '12.12.2021'
And I uploaded into project 'Slinkiest PEN S25 A' following files:
| FileName          | Path              |
| /files/filetext.txt | /Gloves PEN S25 A |
And I am on project 'Slinkiest PEN S25 A' folder '/Gloves PEN S25 A' page
When I open Share window from popup menu for folder '/Gloves PEN S25 A' on project 'Slinkiest PEN S25 A'
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
And I remove user 'PemcoS25B' from users tab on Share window
And click element 'Save' on page 'ShareWindow'
Then I 'should' see email notification for 'Folder sharing for user' with field to 'Tarantul_ns421' and subject 'Skip - bug' contains following attributes:
| Agency        | ProjectName         | Message               | FolderName       |
| DefaultAgency | Slinkiest PEN S25 A | shared folder(s) with | Gloves PEN S25 A |


Scenario: Check that project owner receives email notification about actions in his project. File upload (S29)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email       |
| PemcoS29A_1 |
| PemcoS29A_2 |
And logged in with details of 'PemcoS29A_2'
And on user 'PemcoS29A_2' Notifications Settings page
And set notification 'Files Uploaded' into state 'on' for current user
And saved current user notifications setting
And logged in with details of 'PemcoS29A_1'
And I created following projects:
| Name             | Advertiser    | Administrators |
| Awhile PEN S29 A | DefaultAgency | PemcoS29A_2    |
And I created '/Sleeve PEN S29 A' folder for project 'Awhile PEN S29 A'
And uploaded into project 'Awhile PEN S29 A' following files:
| FileName          | Path              |
| /files/filetext.txt | /Sleeve PEN S29 A |
And logged in with details of 'PemcoS29A_2'
When wait while transcoding is finished in folder '/Sleeve PEN S29 A' on project 'Awhile PEN S29 A' files page
Then I 'should' see email notification for 'Files were uploaded' with field to 'PemcoS29A_2' and subject 'Files were uploaded' contains following attributes:
| Agency        | ProjectName      | FolderName       | FileName   | UserName    |
| DefaultAgency | Awhile PEN S29 A | Sleeve PEN S29 A | filetext.txt | PemcoS29A_1 |


Scenario: Check that project owner receives email notification about actions in his project. File deleted (S31)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |
| PemcoS21A |
And I created following projects:
| Name                | Advertiser    | Administrators |
| Break out PEN S21 A | DefaultAgency | PemcoS21A      |
And I created '/Ugg boots PEN S21 A' folder for project 'Break out PEN S21 A'
And I uploaded into project 'Break out PEN S21 A' following files:
| FileName          | Path                 |
| /files/_file1.gif | /Ugg boots PEN S21 A |
And logged in with details of 'PemcoS21A'
And on user 'PemcoS21A' Notifications Settings page
And set notification 'Files Deleted' into state 'on' for current user
And saved current user notifications setting
And logged in with details of 'AgencyAdmin'
When I go to project 'Break out PEN S21 A' folder '/Ugg boots PEN S21 A' page
And I 'delete' file '_file1.gif' from project files page
Then I 'should' see email notification for 'File deleted' with field to 'PemcoS21A' and subject 'has deleted files' contains following attributes:
| Agency        | ProjectName         |  FileName  | FolderName          |
| DefaultAgency | Break out PEN S21 A | _file1.gif | Ugg boots PEN S21 A |


Scenario: Check that user doesn't receive any email notification if he was deleted from project owners and doesn't have any relations with project. File send to library (S20)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email     |Access|
| PemcoS20A |streamlined_library,library,folders,adkits|
And I created following projects:
| Name               | Advertiser    | Administrators |
| Squabble PEN S20 A | DefaultAgency | PemcoS20A      |
And I created '/Shawl PEN S20 A' folder for project 'Squabble PEN S20 A'
And I uploaded into project 'Squabble PEN S20 A' following files:
| FileName          | Path             |
| /files/_file1.gif | /Shawl PEN S20 A |
And I am on project 'Squabble PEN S20 A' settings page
And I removed administrator 'PemcoS20A' from project 'Squabble PEN S20 A'
When I click Save button on project popup
And wait while transcoding is finished in folder '/Shawl PEN S20 A' on project 'Squabble PEN S20 A' files page
And select file '_file1.gif' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID      |
| jst_kio |
And click on element 'SaveButton'
Then I 'should not' see email notification for 'Folder sharing for user' with field to 'PemcoS20A' and subject 'File moved to library:' contains following attributes: ||

