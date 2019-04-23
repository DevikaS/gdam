!--NGN-538 NGN-3392
Feature:          File email configuration
Narrative:
In order to
As a              AgencyAdmin
I want to         Check file email configuration

Scenario: Check that user receives email notification that comment is written if he has permissions to folder where it is located (S01)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email          |
| <ProjectOwner> |
| <ProjectAdmin> |
| <ProjectUser>  |
And set following notification settings for users:
| UserEmail      | SettingName    | SettingState        |
| <ProjectOwner> | File Commented | <NotificationState> |
| <ProjectAdmin> | File Commented | <NotificationState> |
| <ProjectUser>  | File Commented | <NotificationState> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/TestFolder' folder for project '<ProjectName>'
And uploaded '/files/filetext.txt' file into '/TestFolder' folder for '<ProjectName>' project
When I open project '<ProjectName>' settings page
And edit the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <ProjectAdmin> |
And click on element 'SaveButton'
And filling Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/TestFolder' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And wait while transcoding is finished in folder '/TestFolder' on project '<ProjectName>' files page
And go to the file comments page project '<ProjectName>' and folder '/TestFolder' and file 'filetext.txt'
And add comment 'It is my point of view' into current file
Then I 'should not' see email notification for 'Comment on file' with field to '<ProjectOwner>' and subject 'comment has been made on file' contains following attributes: ||
And '<Condition>' see email notification for 'Comment on file' with field to '<ProjectAdmin>' and subject 'comment has been made on file' contains following attributes:
| Agency        | FileName   | Comment                | ProjectName   | FolderName |
| DefaultAgency | filetext.txt | It is my point of view | <ProjectName> | TestFolder |
And '<Condition>' see email notification for 'Comment on file' with field to '<ProjectUser>' and subject 'comment has been made on file' contains following attributes:
| Agency        | FileName   | Comment                | ProjectName   | FolderName |
| DefaultAgency | filetext.txt | It is my point of view | <ProjectName> | TestFolder |

Examples:
| ProjectOwner | ProjectAdmin | ProjectUser  | ProjectName | NotificationState | Condition  |
| PO_FEC_S01_2 | PA_FEC_S01_2 | PU_FEC_S01_2 | P FEC S01 2 | off               | should not |


Scenario: Check that user receives email notification that file is deleted if he has permissions to folder where it has been located (S02)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email          |
| <ProjectOwner> |
| <ProjectAdmin> |
| <ProjectUser>  |
And set following notification settings for users:
| UserEmail      | SettingName   | SettingState        |
| <ProjectOwner> | Files Deleted | <NotificationState> |
| <ProjectAdmin> | Files Deleted | <NotificationState> |
| <ProjectUser>  | Files Deleted | <NotificationState> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/TestFolder' folder for project '<ProjectName>'
And uploaded '/files/filetext.txt' file into '/TestFolder' folder for '<ProjectName>' project
When I open project '<ProjectName>' settings page
And edit the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <ProjectAdmin> |
And click on element 'SaveButton'
And filling Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/TestFolder' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And go to project '<ProjectName>' folder '/TestFolder' page
And 'delete' file 'filetext.txt' from project files page
Then I 'should not' see email notification for 'File deleted' with field to '<ProjectOwner>' and subject 'has been deleted' contains following attributes: ||
And '<Condition>' see email notification for 'File deleted' with field to '<ProjectAdmin>' and subject 'has been deleted' contains following attributes:
| Agency        | FileName   | ProjectName   | FolderName |
| DefaultAgency | filetext.txt | <ProjectName> | TestFolder |
And '<Condition>' see email notification for 'File deleted' with field to '<ProjectUser>' and subject 'has been deleted' contains following attributes:
| Agency        | FileName   | ProjectName   | FolderName |
| DefaultAgency | filetext.txt | <ProjectName> | TestFolder |

Examples:
| ProjectOwner | ProjectAdmin | ProjectUser  | ProjectName | NotificationState | Condition  |
| PO_FEC_S02_2 | PA_FEC_S02_2 | PU_FEC_S02_2 | P FEC S02 2 | off               | should not |


Scenario: Check that user receives email notification that file downloaded if he has permissions to folder where it has been located (S03_2)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        |
| PO_FEC_S03_2 |
| PA_FEC_S03_2 |
| PU_FEC_S03_2 |
And set following notification settings for users:
| UserEmail    | SettingName               | SettingState |
| PO_FEC_S03_2 | File Downloaded As Master | off          |
| PA_FEC_S03_2 | File Downloaded As Master | off          |
| PU_FEC_S03_2 | File Downloaded As Master | off          |
And logged in with details of 'PO_FEC_S03_2'
And created 'P FEC S03 2' project
And created '/TestFolder' folder for project 'P FEC S03 2'
And uploaded '/files/filetext.txt' file into '/TestFolder' folder for 'P FEC S03 2' project
When I open project 'P FEC S03 2' settings page
And edit the following fields for 'P FEC S03 2' project:
| Name        | Administrators |
| P FEC S03 2 | PA_FEC_S03_2   |
And click on element 'SaveButton'
And filling Share popup by users 'PU_FEC_S03_2' in project 'P FEC S03 2' folders '/TestFolder' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And wait while transcoding is finished in folder '/TestFolder' on project 'P FEC S03 2' files page
And downloaded file 'filetext.txt' on folder '/TestFolder' project 'P FEC S03 2' file info page
Then I 'should not' see email notification for 'Download file' with field to 'PO_FEC_S03_2' and subject 'has been successfully downloaded' contains following attributes: ||
And 'should not' see email notification for 'Download file' with field to 'PA_FEC_S03_2' and subject 'has been successfully downloaded' contains following attributes: ||
And 'should not' see email notification for 'Download file' with field to 'PU_FEC_S03_2' and subject 'has been successfully downloaded' contains following attributes: ||



Scenario: Check that user receives email notification that file played if he has direct access to folder where it has been located (S05)
Meta: @gdam
      @gdamemails
Given I created users with following fields:
| Email          |
| <ProjectOwner> |
| <ProjectAdmin> |
| <ProjectUser>  |
And set following notification settings for users:
| UserEmail      | SettingName | SettingState        |
| <ProjectOwner> | File Preview Played | <NotificationState> |
| <ProjectAdmin> | File Preview Played | <NotificationState> |
| <ProjectUser>  | File Preview Played | <NotificationState> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/TestFolder' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/TestFolder' folder for '<ProjectName>' project
When I open project '<ProjectName>' settings page
And edit the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <ProjectAdmin> |
And click on element 'SaveButton'
And filling Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/TestFolder' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And wait while transcoding is finished in folder '/TestFolder' on project '<ProjectName>' files page
And go to file 'Fish Ad.mov' info page in folder '/TestFolder' project '<ProjectName>'
And wait while proxy is visible on file info page
And play clip on file 'Fish Ad.mov' info page in folder '/TestFolder' project '<ProjectName>'
And wait for '10' seconds
Then I 'should not' see email notification for 'File played' with field to '<ProjectOwner>' and subject 'has been viewed' contains following attributes: ||
And '<Condition>' see email notification for 'File played' with field to '<ProjectAdmin>' and subject 'has been viewed' contains following attributes:
| Agency        | FileName    | ProjectName   | FolderName |
| DefaultAgency | Fish Ad.mov | <ProjectName> | TestFolder |
And '<Condition>' see email notification for 'File moved to library' with field to '<ProjectUser>' and subject 'has been viewed' contains following attributes:
| Agency        | FileName    | ProjectName   | FolderName |
| DefaultAgency | Fish Ad.mov | <ProjectName> | TestFolder |

Examples:
| ProjectOwner | ProjectAdmin | ProjectUser  | ProjectName | NotificationState | Condition  |
| PO_FEC_S05_2 | PA_FEC_S05_2 | PU_FEC_S05_2 | P FEC S05 2 | off               | should not |


Scenario: Check that user receives email notification that file upload failed if he has direct access to folder where it has been located (S07)
Meta: @skip
      @gdam
      @gdamemails
Given I am logged as the following user:
| First Name | Last Name | Email               |
| first9     | last9     | email9@adstream.com |
And 'email9@adstream.com' user '<has>' checked 'File upload failed' settings
And created 'prject9' project
And created 'folder9' folder in 'prject9' project
And uploaded 'file9' file into 'folder9' folder
And added 'user9@adstream.com' user as project owner for 'prject9' project
And 'user9@adstream.com' user has checked 'File upload failed' settings
And shared 'folder9' folder to 'user10@adstream.com' user
And 'user10@adstream.com' user has checked 'File upload failed' settings
When I upload 'file9' file into 'folder9' folder
And remove 'file9' file from 'input' temp storage to fail 'file9' file uploading
Then I '<should>' see that 'email9@adstream.com' user receives the following email with link to 'file9' file:
| Email                                                             |
| We are sorry! Your file upload has failed: project9/folder9/file9 |
And should not see that 'user9@adstream.com' user receives the email about failed 'file9' file uploading
And should not see that 'user10@adstream.com' user receives the email about failed 'file9' file uploading

Examples:
| has     | should     |
| has     | should     |
| has not | should not |


Scenario: Check that user receives email notification that file uploaded if he has direct access to folder where it has been located (S07)
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email          |
| <ProjectOwner> |
| <ProjectAdmin> |
| <ProjectUser>  |
And set following notification settings for users:
| UserEmail      | SettingName   | SettingState        |
| <ProjectOwner> | File uploaded | <NotificationState> |
| <ProjectAdmin> | File uploaded | <NotificationState> |
| <ProjectUser>  | File uploaded | <NotificationState> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/TestFolder' folder for project '<ProjectName>'
And uploaded '/files/filetext.txt' file into '/TestFolder' folder for '<ProjectName>' project
When I open project '<ProjectName>' settings page
And edit the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <ProjectAdmin> |
And click on element 'SaveButton'
And filling Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/TestFolder' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And wait while transcoding is finished in folder '/TestFolder' on project '<ProjectName>' files page
Then I 'should not' see email notification for 'File Uploaded to Projects' with field to '<ProjectOwner>' and subject 'has been successfully uploaded' contains following attributes: ||
And '<Condition>' see email notification for 'File Uploaded to Projects' with field to '<ProjectAdmin>' and subject 'has been successfully uploaded' contains following attributes:
| Agency        | FileName   | ProjectName   | FolderName |
| DefaultAgency | filetext.txt | <ProjectName> | TestFolder |
And '<Condition>' see email notification for 'File Uploaded to Projects' with field to '<ProjectUser>' and subject 'has been successfully uploaded' contains following attributes:
| Agency        | FileName   | ProjectName   | FolderName |
| DefaultAgency | filetext.txt | <ProjectName> | TestFolder |

Examples:
| ProjectOwner | ProjectAdmin | ProjectUser  | ProjectName | NotificationState | Condition  |
| PO_FEC_S07_1 | PA_FEC_S07_1 | PU_FEC_S07_1 | P FEC S07 1 | on                | should     |
| PO_FEC_S07_2 | PA_FEC_S07_2 | PU_FEC_S07_2 | P FEC S07 2 | off               | should not |


Scenario: Check that user receives email notification that file's transcoding is failed (S08)
Meta: @skip
      @gdam
      @gdamemails
Given I created users with following fields:
| Email          |
| <ProjectOwner> |
| <ProjectAdmin> |
| <ProjectUser>  |
And set following notification settings for users:
| UserEmail      | SettingName              | SettingState        |
| <ProjectOwner> | Preview transcode failed | <NotificationState> |
| <ProjectAdmin> | Preview transcode failed | <NotificationState> |
| <ProjectUser>  | Preview transcode failed | <NotificationState> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/TestFolder' folder for project '<ProjectName>'
When I open project '<ProjectName>' settings page
And edit the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <ProjectAdmin> |
And click on element 'SaveButton'
And filling Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/TestFolder' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And upload '/files/failed_transcoded.mpg' file into '/TestFolder' folder for '<ProjectName>' project
And refresh the page
And wait while transcoding is finished in folder '/TestFolder' on project '<ProjectName>' files page
Then I '<Condition>' see email notification for 'Transcoding is failed' with field to '<ProjectOwner>' and subject 'but Adbank could not generate a preview for file' contains following attributes:
| Agency        | FileName              | ProjectName   | FolderName |
| DefaultAgency | failed_transcoded.mpg | <ProjectName> | TestFolder |
And 'should not' see email notification for 'Transcoding is failed' with field to '<ProjectAdmin>' and subject 'but Adbank could not generate a preview for file' contains following attributes: ||
And 'should not' see email notification for 'Transcoding is failed' with field to '<ProjectUser>' and subject 'but Adbank could not generate a preview for file' contains following attributes: ||

Examples:
| ProjectOwner | ProjectAdmin | ProjectUser  | ProjectName | NotificationState | Condition  |
| PO_FEC_S08_1 | PA_FEC_S08_1 | PU_FEC_S08_1 | P FEC S08 1 | on                | should     |
| PO_FEC_S08_2 | PA_FEC_S08_2 | PU_FEC_S08_2 | P FEC S08 2 | off               | should not |


Scenario: Check that user receives email notification with updated file's title (S09)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email          |
| <ProjectOwner> |
| <ProjectAdmin> |
| <ProjectUser>  |
And set following notification settings for users:
| UserEmail      | SettingName     | SettingState        |
| <ProjectOwner> | File Commented | <NotificationState> |
| <ProjectAdmin> | File Commented | <NotificationState> |
| <ProjectUser>  | File Commented | <NotificationState> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/TestFolder' folder for project '<ProjectName>'
And uploaded '/files/filetext.txt' file into '/TestFolder' folder for '<ProjectName>' project
When I open project '<ProjectName>' settings page
And edit the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <ProjectAdmin> |
And click on element 'SaveButton'
And filling Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/TestFolder' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And wait while transcoding is finished in folder '/TestFolder' on project '<ProjectName>' files page
And go to file 'filetext.txt' info page in folder '/TestFolder' project '<ProjectName>'
And 'save' file info by next information:
| FieldName | FieldValue |
| Title     | Fillo100   |
And go to the file comments page project '<ProjectName>' and folder '/TestFolder' and file 'Fillo100'
And add comment 'It is my point of view' into current file
Then I 'should not' see email notification for 'Comment on file' with field to '<ProjectOwner>' and subject 'comment has been made on file' contains following attributes: ||
And '<Condition>' see email notification for 'Comment on file' with field to '<ProjectAdmin>' and subject 'comment has been made on file' contains following attributes:
| Agency        | FileName | Comment                | ProjectName   | FolderName |
| DefaultAgency | Fillo100 | It is my point of view | <ProjectName> | TestFolder |
And '<Condition>' see email notification for 'Comment on file' with field to '<ProjectUser>' and subject 'comment has been made on file' contains following attributes:
| Agency        | FileName | Comment                | ProjectName   | FolderName |
| DefaultAgency | Fillo100 | It is my point of view | <ProjectName> | TestFolder |

Examples:
| ProjectOwner | ProjectAdmin | ProjectUser  | ProjectName | NotificationState | Condition  |
| PO_FEC_S09_2 | PA_FEC_S09_2 | PU_FEC_S09_2 | P FEC S09 2 | off               | should not |


Scenario: Check that user receives email notification that file moved to library if he has permissions to folder where it has been located (S04)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email          |Access|
| <ProjectOwner> |streamlined_library,library,folders,adkits|
| <ProjectAdmin> |streamlined_library,library,folders,adkits|
| <ProjectUser>  |streamlined_library,library,folders,adkits|
And set following notification settings for users:
| UserEmail      | SettingName            | SettingState        |
| <ProjectOwner> | Files Moved To Library | <NotificationState> |
| <ProjectAdmin> | Files Moved To Library | <NotificationState> |
| <ProjectUser>  | Files Moved To Library | <NotificationState> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/TestFolder' folder for project '<ProjectName>'
And uploaded '/files/file_1.txt' file into '/TestFolder' folder for '<ProjectName>' project
When I open project '<ProjectName>' settings page
And edit the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <ProjectAdmin> |
And click on element 'SaveButton'
And filling Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/TestFolder' with role 'project.user' expired '12.02.2021' and 'should' access to subfolders
And wait while transcoding is finished in folder '/TestFolder' on project '<ProjectName>' files page
And select file 'file_1.txt' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
Then I 'should not' see email notification for 'File moved to library' with field to '<ProjectOwner>' and subject 'has been sent to Library' contains following attributes: ||
And '<Condition>' see email notification for 'File moved to library' with field to '<ProjectAdmin>' and subject 'has been sent to Library' contains following attributes:
| Agency        | FileName   | ProjectName   | FolderName |
| DefaultAgency | file_1.txt | <ProjectName> | TestFolder |
And '<Condition>' see email notification for 'File moved to library' with field to '<ProjectUser>' and subject 'has been sent to Library' contains following attributes:
| Agency        | FileName   | ProjectName   | FolderName |
| DefaultAgency | file_1.txt | <ProjectName> | TestFolder |

Examples:
| ProjectOwner | ProjectAdmin | ProjectUser  | ProjectName | NotificationState | Condition  |
| PO_FEC_S04_2 | PA_FEC_S04_2 | PU_FEC_S04_2 | P FEC S04 2 | off               | should not |

