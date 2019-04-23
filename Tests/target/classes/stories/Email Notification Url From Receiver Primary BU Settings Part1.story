!--NGN-5154
Feature:          Email Notification Url From Receiver Primary BU Settings
Narrative:
In order to
As a              GlobalAdmin
I want to         Check Email Notification Url From Receiver Primary BU Settings


Scenario: Check Email Notification Url for all project activities when custom urls are set on sender ,primary and secondary receiver BU s
Meta:@gdam
     @gdamemails
Given I created the agency 'ENUFRPBUS_A21' with default attributes
And I created the agency 'ENUFRPBUS_A22' with default attributes
And I created the agency 'ENUFRPBUS_A23' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| ENUFRPBUS_U49 | agency.admin |ENUFRPBUS_A21 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U50 | agency.admin |ENUFRPBUS_A22 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U51 | agency.user  |ENUFRPBUS_A21 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U52 | agency.user  |ENUFRPBUS_A21 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U53 | agency.user  |ENUFRPBUS_A21 |streamlined_library,library,folders,adkits,approvals|
| ENUFRPBUS_U54 | agency.user  |ENUFRPBUS_A21 |streamlined_library,library,folders,adkits,approvals|
And added existing user 'ENUFRPBUS_U50' to agency 'ENUFRPBUS_A23' with role 'agency.admin'
And I updated the following agency:
| Name              | Email Notification URL                        |Custom URL                                      |
| ENUFRPBUS_A21     |                                               |http://qacustomsenderpage.adstreamdev.com       |
| ENUFRPBUS_A22     |                                               |http://qacustompagePrimary.adstreamdev.com      |
| ENUFRPBUS_A23     |                                               |http://qacustompageSecondary.adstreamdev.com    |
When I login with details of 'ENUFRPBUS_U51'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U51  | projectPublished     | on           |
When I login with details of 'ENUFRPBUS_U53'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U53  | projectTeamAdded     | on           |
When I login with details of 'ENUFRPBUS_U54'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
|ENUFRPBUS_U54   | fileCommented        | on           |
When I login with details of 'ENUFRPBUS_U51'
And set following notification settings for user:
| UserEmail      | SettingName          | SettingState |
| ENUFRPBUS_U51  | filesUploaded        | on           |
When I login with details of 'ENUFRPBUS_U54'
And set following notification settings for user:
| UserEmail      | SettingName                | SettingState |
| ENUFRPBUS_U54  | filesMovedToLibrary        | on           |
When I login with details of 'ENUFRPBUS_U49'
And added user 'ENUFRPBUS_U53' into address book
And added user 'ENUFRPBUS_U54' into address book
And create 'ENUFRPBUS_P09' project
And create '/PSF109' folder for project 'ENUFRPBUS_P09'
And add users 'ENUFRPBUS_U51' to project 'ENUFRPBUS_P09' team folders '/PSF109' with role 'Project User' expired '12.12.2021'
And publish the project 'ENUFRPBUS_P09'
And I open project 'ENUFRPBUS_P09' settings page
When I edit the following fields for 'ENUFRPBUS_P09' project:
| Name          | Administrators |
| ENUFRPBUS_P09 |  ENUFRPBUS_U53 |
And click on element 'SaveButton'
And I open project 'ENUFRPBUS_P09' settings page
When I edit the following fields for 'ENUFRPBUS_P09' project:
| Name          | Administrators |
| ENUFRPBUS_P09 | ENUFRPBUS_U54 |
And click on element 'SaveButton'
And open link from email with shared project 'ENUFRPBUS_P09' which user 'ENUFRPBUS_U51' received
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U51' received email with next subject 'shared project'
When I open link from email when user 'ENUFRPBUS_U53' received email with next subject 'shared project'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U53' received email with next subject 'shared project'
When I go to project 'ENUFRPBUS_P09' folder '/PSF109' page
And go to project 'ENUFRPBUS_P09' folder 'root' page
And select folder '/PSF109' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'ENUFRPBUS_U52' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user 'ENUFRPBUS_U52' received email with next subject 'Folders have been shared with'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U52' received email with next subject 'Folders have been shared with'
When I upload '/files/logo2.png' file into '/PSF109' folder for 'ENUFRPBUS_P09' project
And wait while preview is available in folder '/PSF109' on project 'ENUFRPBUS_P09' files page
And add approval stage on file 'logo2.png' approvals page in folder '/PSF109' project 'ENUFRPBUS_P09':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP11  |ENUFRPBUS_U54 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
When I go to project 'ENUFRPBUS_P09' files page
And add secure share for file 'logo2.png' from folder '/PSF109' and project 'ENUFRPBUS_P09' to following users:
| UserEmails      | Message | DownloadOriginal |
| ENUFRPBUS_U50   | hi dude | true             |
And I go to the file comments page project 'ENUFRPBUS_P09' and folder '/PSF109' and file 'logo2.png'
And I add comment 'It is my point of view' into current file
When I go to project 'ENUFRPBUS_P09' folder '/PSF109' page
And I select file 'logo2.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'SendToLibrary' on page 'FilesPage'
And fill following data on add file to library page:
| ID       |
| dispense |
And click on element 'SaveButton'
And open link from email when user 'ENUFRPBUS_U50' received email with next subject 'Files have been shared'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U50' received email with next subject 'Files have been shared'
When I open link from email when user 'ENUFRPBUS_U51' received email with next subject 'Files were uploaded'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U51' received email with next subject 'Files were uploaded'
When I open link from email when user 'ENUFRPBUS_U54' received email with next subject 'comment has been made on file'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U54' received email with next subject 'comment has been made on file'
When I open link from email when user 'ENUFRPBUS_U54' received email with next subject 'has requested your approval'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U54' received email with next subject 'has requested your approval'
When I open link from email when user 'ENUFRPBUS_U54' received email with next subject 'have been moved to Library'
Then I should see navigating url as 'hostIp' when user 'ENUFRPBUS_U54' received email with next subject 'have been moved to Library'



Scenario: Check Email Notification Url for all Library activities when mails are sent from user of one Bu to other
Meta:@gdam
     @gdamemails
Given I created the agency '<Agency1>' with default attributes
And I created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| <User1>       | agency.admin |<Agency1>     |streamlined_library,presentations|
| <User2>       | agency.admin |<Agency2>     |streamlined_library,presentations|
| <User3>       | agency.user  |<Agency1>     |streamlined_library,presentations|
| <User4>       | agency.user  |<Agency1>     |streamlined_library,presentations|
And I logged in with details of '<User2>'
And set following notification settings for user:
| UserEmail| SettingName              | SettingState |
| <User2>  | assetFilterShared        | on           |
When I create following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency1>':
| Advertiser |
| ZIPP_A1    |
And I updated the following agency:
| Name             | Email Notification URL |Custom URL             |
| <Agency1>        | <senderEmailUrl>       |<senderCustomUrl>      |
| <Agency2>        | <receiverEmailUrl>     | <receiverCustomUrl>    |
When I login with details of '<User1>'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | Advertiser       |
| Fish Ad.mov | ZIPP_A1 |
And create 'ZIP_C1' category
And add agency '<Agency2>' to category 'ZIP_C1' on Asset Categories and Permissions page
And add into category 'ZIP_C1' following metadata:
| FilterName | FilterValue |
| Advertiser | ZIPP_A1     |
And create following reels:
| Name               |
| <presentationName> |
And I add asset 'Fish Ad.mov' into existing presentation '<presentationName>' from collection 'My Assets'NEWLIB
And add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails  | ExpireDate |
| <User2>     | 12.12.2021 |
And add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails  | ExpireDate |
| <User3>     | 12.12.2021 |
And wait for '2' seconds
And open link from email when user '<User2>' received email with next subject 'ASSETS HAS BEEN SHARED'
Then I should see navigating url as '<landingUrl>' when user '<User2>' received email with next subject 'ASSETS HAS BEEN SHARED'
When I open link from email when user '<User3>' received email with next subject 'ASSETS HAS BEEN SHARED'
Then I should see navigating url as '<NavigationUrl>' when user '<User3>' received email with next subject 'ASSETS HAS BEEN SHARED'
When I share presentation '<presentationName>' to user '<User2>' with personal message 'I reel you!'
When I share presentation '<presentationName>' to user '<User4>' with personal message 'I reel you!'
And open link from email when user '<User2>' received email with next subject 'has been shared with'
Then I should see navigating url as '<landingUrl>' when user '<User2>' received email with next subject 'has been shared with'
When I open link from email when user '<User4>' received email with next subject 'has been shared with'
Then I should see navigating url as '<NavigationUrl>' when user '<User4>' received email with next subject 'has been shared with'
When I open link from email when user '<User2>' received email with next subject 'Collection has been shared with'
Then I should see navigating url as '<landingUrl>' when user '<User2>' received email with next subject 'Collection has been shared with'



Examples:

|Agency1      |Agency2      |User1         |User2        |User3        |User4        |senderEmailUrl                              |receiverEmailUrl                       |senderCustomUrl                     |receiverCustomUrl                  |presentationName  |landingUrl                          |NavigationUrl                       |
|ENUFRPBUS_A24|ENUFRPBUS_A25|ENUFRPBUS_U55 |ENUFRPBUS_U56|ENUFRPBUS_U57|ENUFRPBUS_U58|                                            |                                       |                                    |                                   |ENUFRPBUS_PR1     |    hostIp                          |   hostIp                           |
|ENUFRPBUS_A26|ENUFRPBUS_A27|ENUFRPBUS_U60 |ENUFRPBUS_U61|ENUFRPBUS_U62|ENUFRPBUS_U63| http://qasenderEmail.adstreamdev.com       |http://qalandingpage.adstreamdev.com   |                                    |                                   |ENUFRPBUS_PR2     |http://qalandingpage.adstreamdev.com|http://qasenderEmail.adstreamdev.com|
|ENUFRPBUS_A28|ENUFRPBUS_A29|ENUFRPBUS_U65 |ENUFRPBUS_U66|ENUFRPBUS_U67|ENUFRPBUS_U68|                                            |http://qalandingpage.adstreamdev.com   |                                    |                                   |ENUFRPBUS_PR3     |http://qalandingpage.adstreamdev.com|hostIp                              |
|ENUFRPBUS_A30|ENUFRPBUS_A31|ENUFRPBUS_U70 |ENUFRPBUS_U71|ENUFRPBUS_U72|ENUFRPBUS_U73|                                            |                                       |http://qacustompage.adstreamdev.com |http://qacustompage.adstreamdev.com|ENUFRPBUS_PR4     |hostIp                              |hostIp                              |



Scenario: Check Email Notification Url for all Library activities when mails are sent to user who belongs to multiple BUs
Meta:@gdam
     @gdamemails
Given I created the agency '<Agency1>' with default attributes
And I created the agency '<Agency2>' with default attributes
And I created the agency '<Agency3>' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| <User1>       | agency.admin |<Agency1>     |streamlined_library,presentations|
| <User2>       | agency.admin |<Agency2>     |streamlined_library,presentations|
| <User3>       | agency.user  |<Agency1>     |streamlined_library,presentations|
| <User4>       | agency.user  |<Agency1>     |streamlined_library,presentations|
And added existing user '<User2>' to agency '<Agency3>' with role 'agency.admin'
And I logged in with details of '<User2>'
And set following notification settings for user:
| UserEmail| SettingName               | SettingState |
| <User2>  | assetFilterShared        | on           |
When I create following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency1>':
| Advertiser |
| ZIPP_A2    |
And I updated the following agency:
| Name             | Email Notification URL        |Custom URL                    |
| <Agency1>        | <senderEmailUrl>              |<senderCustomUrl>             |
| <Agency2>        | <primaryreceiverEmailUrl>     |<primaryreceiverCustomUrl>    |
| <Agency3>        |  <secondaryReceiverEmailUrl>  |<secondaryReceiverCustomUrl>  |
When I login with details of '<User1>'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | Advertiser       |
| Fish Ad.mov | ZIPP_A2 |
And create 'ZIP_C2' category
And add agency '<Agency2>' to category 'ZIP_C2' on Asset Categories and Permissions page
And add into category 'ZIP_C2' following metadata:
| FilterName | FilterValue |
| Advertiser | ZIPP_A2     |
And create following reels:
| Name               |
| <presentationName> |
And I add asset 'Fish Ad.mov' into existing presentation '<presentationName>' from collection 'My Assets'NEWLIB
And add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails  | ExpireDate |
| <User2>     | 12.12.2021 |
And add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails  | ExpireDate |
| <User3>     | 12.12.2021 |
And open link from email when user '<User2>' received email with next subject 'ASSETS HAS BEEN SHARED'
Then I should see navigating url as '<landingUrl>' when user '<User2>' received email with next subject 'ASSETS HAS BEEN SHARED'
When I open link from email when user '<User3>' received email with next subject 'ASSETS HAS BEEN SHARED'
Then I should see navigating url as '<NavigationUrl>' when user '<User3>' received email with next subject 'ASSETS HAS BEEN SHARED'
When I share presentation '<presentationName>' to user '<User2>' with personal message 'I reel you!'
When I share presentation '<presentationName>' to user '<User4>' with personal message 'I reel you!'
And open link from email when user '<User2>' received email with next subject 'has been shared with'
Then I should see navigating url as '<landingUrl>' when user '<User2>' received email with next subject 'has been shared with'
When I open link from email when user '<User4>' received email with next subject 'has been shared with'
Then I should see navigating url as '<NavigationUrl>' when user '<User4>' received email with next subject 'has been shared with'
When I open link from email when user '<User2>' received email with next subject 'Collection has been shared with'
Then I should see navigating url as '<landingUrl>' when user '<User2>' received email with next subject 'Collection has been shared with'

Examples:

|Agency1      |Agency2      |Agency3       |User1         |User2         |User3         |User4         |senderEmailUrl                              |primaryreceiverEmailUrl                       |secondaryReceiverEmailUrl                     |senderCustomUrl                    |primaryreceiverCustomUrl                  |secondaryReceiverCustomUrl                    |presentationName  |landingUrl                                 |NavigationUrl                       |
|ENUFRPBUS_A32|ENUFRPBUS_A33|ENUFRPBUS_A34 |ENUFRPBUS_U96 |ENUFRPBUS_U97 |ENUFRPBUS_U98 |ENUFRPBUS_U99 |                                            |                                              |                                              |                                   |                                          |                                              |ENUFRPBUS_PR5     |    hostIp                                 |   hostIp                           |
|ENUFRPBUS_A35|ENUFRPBUS_A36|ENUFRPBUS_A37 |ENUFRPBUS_U100|ENUFRPBUS_U101|ENUFRPBUS_U102|ENUFRPBUS_U103|                                            |http://qaprimarylandingpage.adstreamdev.com   |                                              |                                   |                                          |                                              |ENUFRPBUS_PR6     |http://qaprimarylandingpage.adstreamdev.com|hostIp                              |
|ENUFRPBUS_A38|ENUFRPBUS_A39|ENUFRPBUS_A40 |ENUFRPBUS_U104|ENUFRPBUS_U105|ENUFRPBUS_U106|ENUFRPBUS_U108|                                            |http://qaprimarylandingpage.adstreamdev.com   |http://qasecondarylandingpage.adstreamdev.com |                                   |                                          |                                              |ENUFRPBUS_PR7     |http://qaprimarylandingpage.adstreamdev.com|hostIp                              |
|ENUFRPBUS_A41|ENUFRPBUS_A42|ENUFRPBUS_A43 |ENUFRPBUS_U109|ENUFRPBUS_U110|ENUFRPBUS_U111|ENUFRPBUS_U112|http://qasenderEmail.adstreamdev.com        |                                              |http://qasecondarylandingpage.adstreamdev.com |                                   |                                          |                                              |ENUFRPBUS_PR8     |hostIp                                     |http://qasenderEmail.adstreamdev.com|
|ENUFRPBUS_A44|ENUFRPBUS_A45|ENUFRPBUS_A46 |ENUFRPBUS_U113|ENUFRPBUS_U114|ENUFRPBUS_U115|ENUFRPBUS_U116|                                            |                                              |                                              |http://qacustompage.adstreamdev.com|http://qaprimarycustompage.adstreamdev.com |http://qasecondarycustompage.adstreamdev.com |ENUFRPBUS_PR9     |hostIp                                     |hostIp                              |

Scenario: Check Email Notification Url when sent to easy share User with Email url set/notset for sender BU
Meta:@gdam
     @gdamemails
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique |Access|
| <User1>       | agency.admin |<Agency>      |streamlined_library,presentations,folders|
When I go to agency '<Agency>' overview page
And I go to Global Admin system branding page of '<Agency>'
And I fill From email Url field with text '<emailUrl>' on Global system branding page of '<Agency>'
And wait for '3' seconds
And I fill From custom Url field with text '' on Global system branding page of '<Agency>'
And I login with details of '<User1>'
And create '<projectName>' project
And create '<folderName>' folder for project '<projectName>'
And publish the project '<projectName>'
And I open project '<projectName>' settings page
When I go to project '<projectName>' folder '<folderName>' page
And go to project '<projectName>' folder 'root' page
And I refresh the page
And select folder '<folderName>' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share popup of project folder for user '<User2>' with role 'Project Observer' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And I open link from email when user '<User2>' received email with next subject 'You have been invited'
Then I should see navigating url as '<emailUrl>' when user '<User2>' received email with next subject 'You have been invited '
When I upload '/files/logo2.png' file into '<folderName>' folder for '<projectName>' project
And wait while preview is available in folder '<folderName>' on project '<projectName>' files page
And add approval stage on file 'logo2.png' approvals page in folder '<folderName>' project '<projectName>':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| ENUFRPBUS_AP06  | <User3> | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
And I go to project '<projectName>' files page
And add secure share for file 'logo2.png' from folder '<folderName>' and project '<projectName>' to following users:
| UserEmails      | Message | DownloadOriginal |
| <User4>   | hi dude | true             |
And open link from email when user '<User4>' received email with next subject 'You are invited to Adbank'
Then I should see navigating url as '<landingUrl>' when user '<User4>' received email with next subject 'You are invited to Adbank'
When I open link from email when user '<User3>' received email with next subject 'You are invited to the Adstream Platform'
Then I should see navigating url as 'hostIp' when user '<User3>' received email with next subject 'You are invited to the Adstream Platform'
When go to the Library page for collection 'My Assets'NEWLIB
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And I refresh the page
When add secure share for multiple assets from collection 'My Assets' to following usersNEWLIB:
| UserEmails |
| <User5>  |
And create following reels:
| Name               |
| <presentationName> |
And I add asset 'Fish Ad.mov' into existing presentation '<presentationName>' from collection 'My Assets'NEWLIB
And I share presentation '<presentationName>' to user '<User6>' with personal message 'I reel you!'
And I open link from email when user '<User5>' received email with next subject 'You are invited to Adbank'
Then I should see navigating url as '<landingUrl>' when user '<User5>' received email with next subject 'You are invited to Adbank'
When I open link from email when user '<User6>' received email with next subject 'You are invited to Adbank'
Then I should see navigating url as '<landingUrl>' when user '<User6>' received email with next subject 'You are invited to Adbank'

Examples:

|Agency        |User1        |User2        |User3        |User4        |User5        |User6        |emailUrl                             |customurl                          |projectName   |folderName|presentationName  |landingUrl                          |
|ENUFRPBUS_A47 |ENUFRPBUS_U78|ENUFRPBUS_U79|ENUFRPBUS_U80|ENUFRPBUS_U81|ENUFRPBUS_U82|ENUFRPBUS_U83|http://qasenderEmail.adstreamdev.com |                                   |ENUFRPBUS_P11 | /PSF111  | ENUFRPBUS_PR11   |http://qasenderEmail.adstreamdev.com|
|ENUFRPBUS_A48 |ENUFRPBUS_U84|ENUFRPBUS_U85|ENUFRPBUS_U86|ENUFRPBUS_U87|ENUFRPBUS_U88|ENUFRPBUS_U89|                                     |                                   |ENUFRPBUS_P12 | /PSF112  | ENUFRPBUS_PR12   |     hostIp                         |
|ENUFRPBUS_A49 |ENUFRPBUS_U90|ENUFRPBUS_U91|ENUFRPBUS_U92|ENUFRPBUS_U93|ENUFRPBUS_U94|ENUFRPBUS_U95|                                     |http://qacustompage.adstreamdev.com|ENUFRPBUS_P13 | /PSF113  | ENUFRPBUS_PR13   |     hostIp                         |


