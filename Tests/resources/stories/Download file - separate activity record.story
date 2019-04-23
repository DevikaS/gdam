!--NGN-5272
Feature:          Download file - separate activity record
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that Download of a preview/proxy should generate separate activity record

Scenario: Check that activity on download File master appears for different asset types
Meta:@gdam
@projects
Given I created 'P_DPP_S1' project
And created '/P_DPP_S1' folder for project 'P_DPP_S1'
And uploaded '/files/New Text Document.txt' file into '/P_DPP_S1' folder for 'P_DPP_S1' project
And waited while preview is available in folder '/P_DPP_S1' on project 'P_DPP_S1' files page
And I am on file 'New Text Document.txt' info page in folder '/P_DPP_S1' project 'P_DPP_S1'
When I download 'original' file 'New Text Document.txt' on folder '/P_DPP_S1' project 'P_DPP_S1' file info page
And wait for '5' seconds
Then I 'should' see on Activity tab for file 'New Text Document.txt' in folder '/P_DPP_S1' project 'P_DPP_S1' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file master |
And 'should not' see on Activity tab for file 'New Text Document.txt' in folder '/P_DPP_S1' project 'P_DPP_S1' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage         |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file preview |


Scenario: Check that activity on download File proxy appears for different asset types
!--NGN-5789
Meta:@gdam
@projects
Given I created 'P_DPP_S2' project
And created '/P_DPP_S2' folder for project 'P_DPP_S2'
And uploaded '/files/Fish Ad.mov' file into '/P_DPP_S2' folder for 'P_DPP_S2' project
And waited while preview is available in folder '/P_DPP_S2' on project 'P_DPP_S2' files page
And I am on file 'Fish Ad.mov' info page in folder '/P_DPP_S2' project 'P_DPP_S2'
When I download 'proxy' file 'Fish Ad.mov' on folder '/P_DPP_S2' project 'P_DPP_S2' file info page
And wait for '5' seconds
Then I 'should not' see on Activity tab for file 'Fish Ad.mov' in folder '/P_DPP_S2' project 'P_DPP_S2' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file master |
And 'should' see on Activity tab for file 'Fish Ad.mov' in folder '/P_DPP_S2' project 'P_DPP_S2' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage         |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file preview |


Scenario: Check that on download of new version from version history tab is generated activity
!--NGN-5802
Meta:@gdam
@projects
Given I created 'P_DPP_S3' project
And created '/P_DPP_S3' folder for project 'P_DPP_S3'
And uploaded 'files/atCalcVideo.mov' file into '/P_DPP_S3' folder for 'P_DPP_S3' project
And waited while preview is available in folder '/P_DPP_S3' on project 'P_DPP_S3' files page
And I am on file 'files/atCalcVideo.mov' info page in folder '/P_DPP_S3' project 'P_DPP_S3'
When I download 'original' file 'files/atCalcVideo.mov' on folder '/P_DPP_S3' project 'P_DPP_S3' file info page
And I download 'proxy' file 'files/atCalcVideo.mov' on folder '/P_DPP_S3' project 'P_DPP_S3' file info page
And wait for '5' seconds
Then I 'should' see on Activity tab for file 'atCalcVideo.mov' in folder '/P_DPP_S3' project 'P_DPP_S3' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file master |
And 'should' see on Activity tab for file 'atCalcVideo.mov' in folder '/P_DPP_S3' project 'P_DPP_S3' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage         |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file preview |


Scenario: Check that on download file from folder is generated activity
Meta:@gdam
@projects
Given I created 'P_DPP_S4' project
And created '/P_DPP_S4' folder for project 'P_DPP_S4'
And I uploaded into project 'P_DPP_S4' following files:
| FileName            | Path      |
| /files/Fish2-Ad.mov | /P_DPP_S4 |
And I uploaded into project 'P_DPP_S4' following revisions:
| FileName                   | Path      | MasterFileName |
| /files/13DV-CAPITAL-10.mpg | /P_DPP_S4 | Fish2-Ad.mov   |
And waited while preview is available in folder '/P_DPP_S4' on project 'P_DPP_S4' files page
When I download 'original' file 'Fish2-Ad.mov' for revision '2' on folder '/P_DPP_S4' project 'P_DPP_S4'
And I download 'proxy' file 'Fish2-Ad.mov' for revision '2' on folder '/P_DPP_S4' project 'P_DPP_S4'
And wait for '5' seconds
Then I 'should' see on Activity tab for file 'Fish2-Ad.mov' in folder '/P_DPP_S4' project 'P_DPP_S4' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file master |
And 'should' see on Activity tab for file 'Fish2-Ad.mov' in folder '/P_DPP_S4' project 'P_DPP_S4' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage         |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file preview |


Scenario: Check that activity on download Asset proxy appears for different asset types
!--NGN-5789
Meta:@gdam
@library
Given I created users with following fields:
| Email    |Access|
| U_DPP_S5 |streamlined_library|
When I login with details of 'U_DPP_S5'
And upload file '/files/atCalcVideo.mov' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And I go to asset 'atCalcVideo.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'download original' on opened asset info pageNEWLIB
And I go to asset 'atCalcVideo.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'atCalcVideo.mov' activity page for collection 'My Assets'NEWLIB:
| UserName | Message                 | Value |
| U_DPP_S5 | Downloaded by |       |
And I 'should not' see the following activities on asset 'atCalcVideo.mov' activity page for collection 'My Assets'NEWLIB:
| UserName | Message               | Value |
| U_DPP_S5 | Preview downloaded by |       |


Scenario: Check that activity on download Asset master appears for different asset types
Meta:@gdam
@library
Given I created users with following fields:
| Email    | Role         |Access|
| U_DPP_S6 | agency.admin |streamlined_library|
When I login with details of 'U_DPP_S6'
And upload file '/files/atCalcVideo.mov' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And I go to asset 'atCalcVideo.mov' info page in Library for collection 'My Assets'NEWLIB
And I 'download proxy' on opened asset info pageNEWLIB
And I go to asset 'atCalcVideo.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'atCalcVideo.mov' activity page for collection 'My Assets'NEWLIB:
| UserName | Message                 | Value |
| U_DPP_S6 | Preview downloaded by |       |
And I 'should not' see the following activities on asset 'atCalcVideo.mov' activity page for collection 'My Assets'NEWLIB:
| UserName | Message                | Value |
| U_DPP_S6 | Downloaded by |       |


Scenario: Check that activity about download File proxy appears on dashboard
Meta:@gdam
@projects
Given I created users with following fields:
| Email    |
| U_DPP_S7 |
And I logged in with details of 'U_DPP_S7'
And I created 'P_DPP_S7' project
And created '/P_DPP_S7' folder for project 'P_DPP_S7'
And uploaded '/files/atCalcVideo.mov' file into '/P_DPP_S7' folder for 'P_DPP_S7' project
And waited while preview is available in folder '/P_DPP_S7' on project 'P_DPP_S7' files page
When I download 'proxy' file 'atCalcVideo.mov' on folder '/P_DPP_S7' project 'P_DPP_S7' file info page
And wait for '5' seconds
And I go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName | Message                 | Value                              |
| U_DPP_S7 | downloaded file preview | /P_DPP_S7/P_DPP_S7/atCalcVideo.mov |
And I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName | Message                | Value                              |
| U_DPP_S7 | downloaded file master | /P_DPP_S7/P_DPP_S7/atCalcVideo.mov |


Scenario: Check that activity about download File master appears on dashboard
Meta:@gdam
@projects
Given I created users with following fields:
| Email    |
| U_DPP_S8 |
And I logged in with details of 'U_DPP_S8'
And I created 'P_DPP_S8' project
And created '/P_DPP_S8' folder for project 'P_DPP_S8'
And uploaded '<File>' file into '/P_DPP_S8' folder for 'P_DPP_S8' project
And waited while preview is available in folder '/P_DPP_S8' on project 'P_DPP_S8' files page
When I download 'original' file '<File>' on folder '/P_DPP_S8' project 'P_DPP_S8' file info page
And wait for '5' seconds
And I go to Dashboard page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName | Message               | Value  |
| U_DPP_S8 | downloaded file preview | <Path> |
And I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName | Message                | Value  |
| U_DPP_S8 | downloaded file master | <Path> |

Examples:
| File                  | Path                               |
| files/atCalcVideo.mov | /P_DPP_S8/P_DPP_S8/atCalcVideo.mov |


Scenario: Check that activity about download Asset master appears on dashboard
Meta:@gdam
@library
Given I created users with following fields:
| Email    |Access|
| U_DPP_S9 |streamlined_library,dashboard|
When I login with details of 'U_DPP_S9'
And upload file '<File>' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And I go to asset '<Name>' info page in Library for collection 'My Assets'NEWLIB
And I 'download original' on opened asset info pageNEWLIB
And I go to Dashboard page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName | Message                | Value           |
| U_DPP_S9 | downloaded asset proxy | <ActivityValue> |
And I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName | Message                 | Value           |
| U_DPP_S9 | downloaded asset master | <ActivityValue> |

Examples:
| File                  | Name            | ActivityValue   |
| files/atCalcVideo.mov | atCalcVideo.mov | atCalcVideo.mov |


Scenario: Check that activity about download Asset proxy appears on dashboard
Meta:@gdam
@library
Given I created users with following fields:
| Email     | Role         |Access|
| U_DPP_S10 | agency.admin |streamlined_library,dashboard|
When I login with details of 'U_DPP_S10'
And upload file '<File>' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And go to asset '<Name>' info page in Library for collection 'My Assets'NEWLIB
And 'download proxy' on opened asset info pageNEWLIB
And wait for '5' seconds
And I go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName  | Message                | Value           |
| U_DPP_S10 | downloaded asset proxy | <ActivityValue> |
And I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName  | Message                 | Value           |
| U_DPP_S10 | downloaded asset master | <ActivityValue> |

Examples:
| File                  | Name            | ActivityValue   |
| files/atCalcVideo.mov | atCalcVideo.mov | atCalcVideo.mov |


Scenario: Check that activity about download File proxy and master appears on activity for owner(if file downloaded by shareuser from folder)
Meta:@gdam
@projects
Given I created the agency 'A_DPP_S11_1' with default attributes
And created the agency 'A_DPP_S11_2' with default attributes
And created users with following fields:
| Email       | Role        | Agency      |
| U_DPP_S11_1 | agency.user | A_DPP_S11_1 |
| U_DPP_S11_2 | agency.user | A_DPP_S11_2 |
And created 'R_DPP_S11_1' role in 'project' group for advertiser 'A_DPP_S11_1' with following permissions:
| Permission     |
| project.read   |
| folder.read    |
| element.read   |
| file.download  |
| proxy.download |
And I logged in with details of 'U_DPP_S11_1'
And I created 'P_DPP_S11' project
And created '/P_DPP_S11' folder for project 'P_DPP_S11'
And uploaded 'files/atCalcVideo.mov' file into '/P_DPP_S11' folder for 'P_DPP_S11' project
And waited while preview is available in folder '/P_DPP_S11' on project 'P_DPP_S11' files page
And added users 'U_DPP_S11_2' to project 'P_DPP_S11' team folders '/P_DPP_S11' with role 'R_DPP_S11_1' expired '12.02.2021'
And I logged in with details of 'U_DPP_S11_2'
And I am on file 'files/atCalcVideo.mov' info page in folder '/P_DPP_S11' project 'P_DPP_S11'
When I download 'original' file 'files/atCalcVideo.mov' on folder '/P_DPP_S11' project 'P_DPP_S11' file info page
And I download 'proxy' file 'files/atCalcVideo.mov' on folder '/P_DPP_S11' project 'P_DPP_S11' file info page
And I login with details of 'U_DPP_S11_1'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName    | Message                 | Value                                |
| U_DPP_S11_2 | downloaded file preview | /P_DPP_S11/P_DPP_S11/atCalcVideo.mov |
And I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName    | Message                | Value                                |
| U_DPP_S11_2 | downloaded file master | /P_DPP_S11/P_DPP_S11/atCalcVideo.mov |


Scenario: Check that Download "Proxy Files" from Presentation should download Default and Custom Proxies.
Meta:@gdam
@library
!--This will fail on s3 storage..
Given I am on  Library pageNEWLIB
And I uploaded following assetsNEWLIB:
| Name               |
|/files/Fish1-Ad.wmv |
|/files/Fish1-Ad.mpg |
|/files/shortname.wav|
|/files/audio02.mp3     |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish1-Ad.wmv,Fish1-Ad.mpg,shortname.wav,audio02.mp3'NEWLIB
And I created following reels:
| Name              |
| DownloadProxyPresentation |
When I add asset 'Fish1-Ad.wmv,Fish1-Ad.mpg,shortname.wav,audio02.mp3' into existing presentation 'DownloadProxyPresentation' from collection 'Everything'NEWLIB
And I go to preview presentation 'DownloadProxyPresentation' page
Then 'proxy' files 'Fish1-Ad.wmv,Fish1-Ad.mpg,shortname.wav,audio02.mp3' on Presentation 'DownloadProxyPresentation' from collection 'Everything' is downloaded for 'DefaultAgency'
