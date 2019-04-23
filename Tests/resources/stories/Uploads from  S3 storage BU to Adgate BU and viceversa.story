!--SPB-526
Feature:          Project Share folder - Common
Narrative:
In order to
As a              AgencyAdmin
I want to         Check upload files and assets across BU's with S3 and Adgate storages

Scenario: Whole Project share from S3 BU to Adgate User
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name               |
| UFS3BTABBZ_S3BU1   |
| UFS3BTABAV_S3BU1   |
And updated the following agency:
| Name             | Storage                         |
| UFS3BTABBZ_S3BU1 | 568cec9de4b0ebf465310e1f        |
| UFS3BTABAV_S3BU1 | S3                              |
And created users with following fields:
| Email       | Role          | Agency           |
| UFS3BTABAV_S3_U1     | agency.admin  |  UFS3BTABAV_S3BU1           |
| UFS3BTABAV_Adgate_U1  | agency.user   |  UFS3BTABBZ_S3BU1             |
And logged in with details of 'UFS3BTABAV_S3_U1'
And created 'UFS3BTABAV_S3_P1' project
And created in 'UFS3BTABAV_S3_P1' project next folders:
| folder  |
|/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1|
|/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF2|
And uploaded into project 'UFS3BTABAV_S3_P1' following files:
| FileName                 | Path                |
| /files/Fish2-Ad.mov      | /UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1   |
| /images/logo.gif         | /UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF2   |
And waited while preview is available in folder '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1' on project 'UFS3BTABAV_S3_P1' files page
When go to project 'UFS3BTABAV_S3_P1' folder 'root' page
And select folder '/UFS3BTABAV_S3_F1'  on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'UFS3BTABAV_Adgate_U1' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And login with details of 'UFS3BTABAV_Adgate_U1'
And I go to project list page
Then I should see 'UFS3BTABAV_S3_P1' project in project list
When select folder '/UFS3BTABAV_S3_SF1' in project 'UFS3BTABAV_S3_P1'
Then I 'should' see 'Fish2-Ad.mov' file inside '/UFS3BTABAV_S3_SF1' folder for 'UFS3BTABAV_S3_P1' shared project
When select folder '/UFS3BTABAV_S3_SF2' in project 'UFS3BTABAV_S3_P1'
Then I 'should' see 'logo.gif' file inside '/UFS3BTABAV_S3_SF2' folder for 'UFS3BTABAV_S3_P1' shared project
When I upload into project 'UFS3BTABAV_S3_P1' following revisions:
| FileName           | Path                 | MasterFileName |
| /files/Fish Ad.mov | /UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1    | Fish2-Ad.mov   |
And wait while preview is available in folder '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1' on project 'UFS3BTABAV_S3_P1' files page
And I go to file 'Fish2-Ad.mov' version history page in folder '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1' project 'UFS3BTABAV_S3_P1'
And refresh the page
Then I 'should' see revision '2' on file 'Fish2-Ad.mov' version history page in folder '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1' project 'UFS3BTABAV_S3_P1' marked as Current
When upload '/files/_file1.gif' file into '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1' folder for 'UFS3BTABAV_S3_P1' project
And wait while preview is available in folder '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1' on project 'UFS3BTABAV_S3_P1' files page
Then I should see files '_file1.gif' inside '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF1' folder for 'UFS3BTABAV_S3_P1' project
When I create '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF3' folder in 'UFS3BTABAV_S3_P1' project
And upload '/files/128_shortname.jpg' file into '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF3' folder for 'UFS3BTABAV_S3_P1' project
And wait while preview is available in folder '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF3' on project 'UFS3BTABAV_S3_P1' files page
And refresh the page
Then I should see files '128_shortname.jpg' inside '/UFS3BTABAV_S3_F1/UFS3BTABAV_S3_SF3' folder for 'UFS3BTABAV_S3_P1' project

Scenario: Subfolder share from Adgate User to S3 BU User
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name               |
| UFS3BTABAZ_S3BU1   |
| UFS3BTABAV_S3BU2   |
And updated the following agency:
| Name             | Storage                         |
| UFS3BTABAZ_S3BU1 | 568cec9de4b0ebf465310e1f        |
| UFS3BTABAV_S3BU2 | S3                              |
And created users with following fields:
| Email                 | Role          | Agency             |
| UFS3BTABAV_S3_U2      | agency.user   |  UFS3BTABAV_S3BU2  |
| UFS3BTABAV_Adgate_U2  | agency.user   |  UFS3BTABAZ_S3BU1  |
And logged in with details of 'UFS3BTABAV_Adgate_U2'
And created 'UFS3BTABAV_Adg_P1' project
And created '/UFS3BTABAV_Adg_F1/UFS3BTABAV_Adg_SF1' folder for project 'UFS3BTABAV_Adg_P1'
And uploaded '/files/Fish2-Ad.mov' file into '/UFS3BTABAV_Adg_F1/UFS3BTABAV_Adg_SF1' folder for 'UFS3BTABAV_Adg_P1' project
And waited while preview is available in folder '/UFS3BTABAV_Adg_F1/UFS3BTABAV_Adg_SF1' on project 'UFS3BTABAV_Adg_P1' files page
And I am on project 'UFS3BTABAV_Adg_P1' folder '/UFS3BTABAV_Adg_F1/UFS3BTABAV_Adg_SF1' page
When I open Share window from popup menu for folder '/UFS3BTABAV_Adg_F1/UFS3BTABAV_Adg_SF1' on project 'UFS3BTABAV_Adg_P1'
And fill Share popup of project folder for user 'UFS3BTABAV_S3_U2' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And login with details of 'UFS3BTABAV_S3_U2'
And I go to project 'UFS3BTABAV_Adg_P1' overview page
Then I 'should' see '/UFS3BTABAV_Adg_SF1' folder in 'UFS3BTABAV_Adg_P1' project
When I go to project 'UFS3BTABAV_Adg_P1' overview page
And select folder '/UFS3BTABAV_Adg_SF1' in project 'UFS3BTABAV_Adg_P1'
Then I 'should' see 'Fish2-Ad.mov' file inside '/UFS3BTABAV_Adg_SF1' folder for 'UFS3BTABAV_Adg_P1' shared project
When I open file 'Fish2-Ad.mov' on project 'UFS3BTABAV_Adg_P1' overview page
And I upload new file version '/files/Fish Ad.mov' for file 'Fish2-Ad.mov' into '/UFS3BTABAV_Adg_SF1' shared subfolder for 'UFS3BTABAV_Adg_P1' project
And wait while preview is available in  subfolder '/UFS3BTABAV_Adg_SF1' on project 'UFS3BTABAV_Adg_P1' files page by User 'UFS3BTABAV_S3_U2'
And wait for '3' seconds
Then I 'should' see revision '2' on file 'Fish2-Ad.mov' version history page in folder '/UFS3BTABAV_Adg_SF1' shared project 'UFS3BTABAV_Adg_P1' marked as Current
When I go to project 'UFS3BTABAV_Adg_P1' overview page
And select folder '/UFS3BTABAV_Adg_SF1' in project 'UFS3BTABAV_Adg_P1'
When upload '/files/_file1.gif' file into '/UFS3BTABAV_Adg_SF1' subfolder for 'UFS3BTABAV_Adg_P1' by user 'UFS3BTABAV_S3_U2'
And wait while preview is available in  subfolder '/UFS3BTABAV_Adg_SF1' on project 'UFS3BTABAV_Adg_P1' files page by User 'UFS3BTABAV_S3_U2'
Then I 'should' see '_file1.gif' file inside '/UFS3BTABAV_Adg_SF1' folder for 'UFS3BTABAV_Adg_P1' shared project
When I create '/UFS3BTABAV_Adg_SF2' folder in 'UFS3BTABAV_Adg_P1' project
And upload '/files/128_shortname.jpg' file into '/UFS3BTABAV_Adg_SF2' subfolder for 'UFS3BTABAV_Adg_P1' by user 'UFS3BTABAV_S3_U2'
And wait while preview is available in  subfolder '/UFS3BTABAV_Adg_SF2' on project 'UFS3BTABAV_Adg_P1' files page by User 'UFS3BTABAV_S3_U2'
Then I 'should' see '128_shortname.jpg' file inside '/UFS3BTABAV_Adg_SF2' folder for 'UFS3BTABAV_Adg_P1' shared project

Scenario: Adding S3 BU User on Adgate project Team
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name    |
| UFS3BTABAV_S3BU3   |
And updated the following agency:
| Name  | Storage |
| UFS3BTABAV_S3BU3 | S3 |
And created users with following fields:
| Email       | Role          | Agency           |
| UFS3BTABAV_S3_U3     | agency.admin  |  UFS3BTABAV_S3BU3           |
| UFS3BTABAV_S3_U4      | agency.user   |  UFS3BTABAV_S3BU3           |
And logged in with details of 'AgencyAdmin'
And created 'UFS3BTABAV_Adg_P2' project
And created in 'UFS3BTABAV_Adg_P2' project next folders:
| folder  |
|/UFS3BTABAV_Adg_F2/UFS3BTABAV_Adg_SF3|
And uploaded into project 'UFS3BTABAV_Adg_P2' following files:
| FileName                 | Path                |
| /files/Fish2-Ad.mov      | /UFS3BTABAV_Adg_F2  |
| /images/logo.gif         | /UFS3BTABAV_Adg_F2/UFS3BTABAV_Adg_SF3          |
And waited while preview is available in folder '/UFS3BTABAV_Adg_F2' on project 'UFS3BTABAV_Adg_P2' files page
And I am on project 'UFS3BTABAV_Adg_P2' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And fill add user popup with user 'UFS3BTABAV_S3_U4' into project 'UFS3BTABAV_Adg_P2' team with role 'Project Contributor' expired '12.12.2021' for folder on popup '/UFS3BTABAV_Adg_F2'
And click element 'AddButton' on page 'AddTeamUserPopUp'
And login with details of 'UFS3BTABAV_S3_U4'
Then I should see 'UFS3BTABAV_Adg_P2' project in project list
When select folder '/UFS3BTABAV_Adg_F2' in project 'UFS3BTABAV_Adg_P2'
Then I 'should' see 'Fish2-Ad.mov' file inside '/UFS3BTABAV_Adg_F2' folder for 'UFS3BTABAV_Adg_P2' shared project
When upload '/files/_file1.gif' file into '/UFS3BTABAV_Adg_F2' folder for 'UFS3BTABAV_Adg_P2' project
And wait while preview is available in folder '/UFS3BTABAV_Adg_F2' on project 'UFS3BTABAV_Adg_P2' files page
Then I should see files '_file1.gif' inside '/UFS3BTABAV_Adg_F2' folder for 'UFS3BTABAV_Adg_P2' project
When I create 'UFS3BTABAV_Adg_F2/NewF1' folder in 'UFS3BTABAV_Adg_P2' project
And upload '/files/128_shortname.jpg' file into 'UFS3BTABAV_Adg_F2/NewF1' folder for 'UFS3BTABAV_Adg_P2' project
And wait while preview is available in folder 'UFS3BTABAV_Adg_F2/NewF1' on project 'UFS3BTABAV_Adg_P2' files page
Then I should see files '128_shortname.jpg' inside 'UFS3BTABAV_Adg_F2/NewF1' folder for 'UFS3BTABAV_Adg_P2' project

Scenario: Sharing library asset and presentation from one storage BU  to another storage BU
Meta:@gdam
@gdamemails
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name          |
| UFS3BTABAV_S3BU4   |
And updated the following agency:
| Name             | Storage |
| UFS3BTABAV_S3BU4 | S3 |
And created users with following fields:
| Email                | Role         | Agency              |Access|
| UFS3BTABAV_S3_U5     | agency.admin |  UFS3BTABAV_S3BU4   |streamlined_library,presentations|
| UFS3BTABAV_S3_U6     | agency.user  |  UFS3BTABAV_S3BU4   |streamlined_library,presentations|
| UFS3BTABAV_Adgate_U3 | agency.user  |  DefaultAgency      |streamlined_library,presentations|
| UFS3BTABAV_Adgate_U4 | agency.admin |  DefaultAgency 		|streamlined_library,presentations|
And logged in with details of 'UFS3BTABAV_S3_U5'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   |
| UFS3BTABAV_Adgate_U3 |
And wait for '4' seconds
And login with details of 'UFS3BTABAV_Adgate_U3'
And open link from email when user 'UFS3BTABAV_Adgate_U3' received email with next subject 'has been shared'
Then I 'should' be on asset preview page
When I login with details of 'UFS3BTABAV_Adgate_U4'
And upload file '/files/Fish1-Ad.mov' into libraryNEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And wait while preview is visible on library page for collection 'Everything' for asset 'Fish1-Ad.mov'NEWLIB
And I refresh the page
And I add assets 'Fish1-Ad.mov' to new presentation 'UFS3BTABAV_Adgate_PR1' from collection 'Everything' pageNEWLIB
And send presentation 'UFS3BTABAV_Adgate_PR1' to user 'UFS3BTABAV_S3_U6' with personal message 'Hello'
And wait for '5' seconds
And I login with details of 'UFS3BTABAV_S3_U6'
And open link from email with shared presentation 'UFS3BTABAV_Adgate_PR1' which user 'UFS3BTABAV_S3_U6' received
Then I 'should' see for user 'UFS3BTABAV_S3_U6' presentation name 'UFS3BTABAV_Adgate_PR1' for current preview
And I 'should' see playable preview on presentation preview page


Scenario: Check that Adgate BU user can share whole Project to S3 BU user as partners
Meta:@uatgdamsmoke
@projects
@gdam
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name                    |
| UFS3BTABAV_AdgateBU211   |
| UFS3BTABAV_S3BU23   |
And updated the following agency:
| Name                   | Storage                         |
| UFS3BTABAV_AdgateBU211 | 547f5c85e4b0e3c6faf9d32d        |
| UFS3BTABAV_S3BU23      |   S3                            |
And created users with following fields:
| Email       | Role                   | Agency       |
| UFS3BTABAV_S3_U28    | agency.user    |  UFS3BTABAV_S3BU23       |
| UFS3BTABAV_S3_U29    | agency.user    |  UFS3BTABAV_S3BU23       |
| UFS3BTABAV_Adgate_U25| agency.admin   |  UFS3BTABAV_AdgateBU211    |
And added following partners 'UFS3BTABAV_AdgateBU211' to agency 'UFS3BTABAV_S3BU23' on partners page
And logged in with details of 'UFS3BTABAV_Adgate_U25'
And created 'UFS3BTABAV_Adg_P23' project
And created '/UFS3BTABAV_Adg_F23' folder for project 'UFS3BTABAV_Adg_P23'
And I am on project 'UFS3BTABAV_Adg_P23' folder '/UFS3BTABAV_Adg_F23' page
When I open Share window from popup menu for folder '/UFS3BTABAV_Adg_F23' on project 'UFS3BTABAV_Adg_P23'
And fill Share popup of project folder for user 'UFS3BTABAV_S3_U28' with role 'Project Contributor' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And add users 'UFS3BTABAV_S3_U29' to project 'UFS3BTABAV_Adg_P23' team folders '/UFS3BTABAV_Adg_F23' with role 'Project Contributor' expired '12.12.2021'
And upload into project 'UFS3BTABAV_Adg_P23' following files:
| FileName                 | Path             |
| /files/Fish2-Ad.mov      | /UFS3BTABAV_Adg_F23   |
And wait while preview is available in folder '/UFS3BTABAV_Adg_F23' on project 'UFS3BTABAV_Adg_P23' files page
When I login with details of 'UFS3BTABAV_S3_U28'
And I go to project list page
Then I should see 'UFS3BTABAV_Adg_P23' project in project list
When select folder 'UFS3BTABAV_Adg_F23' in project 'UFS3BTABAV_Adg_P23'
Then I 'should' see 'Fish2-Ad.mov' file inside 'UFS3BTABAV_Adg_F23' folder for 'UFS3BTABAV_Adg_P23' shared project
When upload '/files/_file1.gif' file into '/UFS3BTABAV_Adg_F23' folder for 'UFS3BTABAV_Adg_P23' project
And wait while preview is available in folder '/UFS3BTABAV_Adg_F23' on project 'UFS3BTABAV_Adg_P23' files page
Then I should see files '_file1.gif' inside '/UFS3BTABAV_Adg_F23' folder for 'UFS3BTABAV_Adg_P23' project
When I create '/UFS3BTABAV_Adg_F23/NewF2' folder for project 'UFS3BTABAV_Adg_P23'
And upload '/files/128_shortname.jpg' file into '/UFS3BTABAV_Adg_F23/NewF2' folder for 'UFS3BTABAV_Adg_P23' project
And wait while preview is available in folder '/UFS3BTABAV_Adg_F23/NewF2' on project 'UFS3BTABAV_Adg_P23' files page
Then I should see files '128_shortname.jpg' inside '/UFS3BTABAV_Adg_F23/NewF2' folder for 'UFS3BTABAV_Adg_P23' project
When I login with details of 'UFS3BTABAV_S3_U29'
And I go to project list page
Then I should see 'UFS3BTABAV_Adg_P23' project in project list
When select folder 'UFS3BTABAV_Adg_F23' in project 'UFS3BTABAV_Adg_P23'
Then I 'should' see 'Fish2-Ad.mov' file inside 'UFS3BTABAV_Adg_F23' folder for 'UFS3BTABAV_Adg_P23' shared project
And 'should' see '_file1.gif' file inside 'UFS3BTABAV_Adg_F23' folder for 'UFS3BTABAV_Adg_P23'  shared project


Scenario: Check that Adgate BU user can share Work request to S3 BU user as partners
Meta:@uatgdamsmoke
@projects
@gdam
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name                   |
| UFS3BTABAV_AdgateBU1   |
| UFS3BTABAV_S3BU5       |
And updated the following agency:
| Name                   | Storage                         |
| UFS3BTABAV_AdgateBU1   | 547f5c85e4b0e3c6faf9d32d        |
| UFS3BTABAV_S3BU5       |   S3                            |
And created users with following fields:
| Email               | Role           | Agency       |
| UFS3BTABAV_S3_U7    | agency.user    |  UFS3BTABAV_S3BU5       |
| UFS3BTABAV_Adgate_U5| agency.admin   |  UFS3BTABAV_AdgateBU1    |
And added following partners 'UFS3BTABAV_AdgateBU1' to agency 'UFS3BTABAV_S3BU5' on partners page
And logged in with details of 'UFS3BTABAV_Adgate_U5'
And created 'UFS3BTABAV_Adg_WR1' work request
And created '/UFS3BTABAV_Adg_WRF1/WR_SF1/WR_SFF1' folder for work request 'UFS3BTABAV_Adg_WR1'
And created '/UFS3BTABAV_Adg_WRF1/WR_SF2/WR_SFF2' folder for work request 'UFS3BTABAV_Adg_WR1'
And I am on work request 'UFS3BTABAV_Adg_WR1' folder '/UFS3BTABAV_Adg_WRF1' page
When I open share popup in work request 'UFS3BTABAV_Adg_WR1' for folder '/UFS3BTABAV_Adg_WRF1' from root work request
And fill Share window of project folder for following users:
| User     | Role                | ExpiredDate | ShouldAccess |
| UFS3BTABAV_S3_U7 | Project Contributor |             | should       |
And click element 'Add' on page 'ShareWindow'
And upload '/files/image10.jpg' file into '/UFS3BTABAV_Adg_WRF1' folder for 'UFS3BTABAV_Adg_WR1' work request
When I login with details of 'UFS3BTABAV_S3_U7'
And I go to work request 'UFS3BTABAV_Adg_WR1' folder '/UFS3BTABAV_Adg_WRF1' page
Then I 'should' see file 'image10.jpg' on work request 'UFS3BTABAV_Adg_WR1' folder '/UFS3BTABAV_Adg_WRF1' files page
And I 'should' see following folders in 'UFS3BTABAV_Adg_WR1' work request:
| folder                        |
| /UFS3BTABAV_Adg_WRF1/WR_SF1/WR_SFF1 |
| /UFS3BTABAV_Adg_WRF1/WR_SF2/WR_SFF2 |
When I upload '/files/image9.jpg' file into '/UFS3BTABAV_Adg_WRF1' folder for 'UFS3BTABAV_Adg_WR1' work request
And wait while transcoding is finished on Work request 'UFS3BTABAV_Adg_WR1' in folder '/UFS3BTABAV_Adg_WRF1' for 'image9.jpg' file
Then I 'should' see file 'image9.jpg' on work request 'UFS3BTABAV_Adg_WR1' folder '/UFS3BTABAV_Adg_WRF1' files page
When I create '/UFS3BTABAV_Adg_WRF1/NewWRF1' folder for work request 'UFS3BTABAV_Adg_WR1'
And upload '/files/Fish-Ad.mov' file into '/UFS3BTABAV_Adg_WRF1/NewWRF1' folder for 'UFS3BTABAV_Adg_WR1' work request
And wait while transcoding is finished on Work request 'UFS3BTABAV_Adg_WR1' in folder '/UFS3BTABAV_Adg_WRF1/NewWRF1' for 'Fish-Ad.mov' file
Then I 'should' see file 'Fish-Ad.mov' on work request 'UFS3BTABAV_Adg_WR1' folder '/UFS3BTABAV_Adg_WRF1/NewWRF1' files page



Scenario: Check that user from partner S3 or Adgate BU sees collection in library after share
Meta:@gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency '<Agency1>' with default attributes
And I created the agency '<Agency2>' with default attributes
And updated the following agency:
| Name      | Storage    |
| <Agency1> | <Storage1> |
| <Agency2> | <Storage2> |
And created users with following fields:
| Agency   | Email     | Role         |Access|
| <Agency1>|<User1>    | agency.admin|streamlined_library|
| <Agency2>|<User2>    | agency.user|streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners '<Agency2>' to agency '<Agency1>' on partners page
When I login with details of '<User1>'
And create '<CollectionName>' category
And upload following assetsNEWLIB:
| Name                 |
| /files/logo1.gif    |
And wait while transcoding is finished in collection '<CollectionName>'NEWLIB
And add users '<User2>' to category '<CollectionName>' with role 'library.user' by users details
And go to user '<User2>' details page
And edit for user '<User2>' agency role 'agency.user'
And login with details of '<User2>'
And go to the Library page for collection '<CollectionName>'NEWLIB
Then I 'should' see assets 'logo1.gif' in the collection '<CollectionName>'NEWLIB
When I go to  library page for collection '<CollectionName>'NEWLIB
And I upload following assets into following agenciesNEWLIB:
| Name                | AgencyName   |
| /files/_file1.gif   |<Agency1>     |
And wait while transcoding is finished in collection '<CollectionName>'NEWLIB
And go to the Library page for collection '<CollectionName>'NEWLIB
Then I 'should' see assets '_file1.gif' in the collection '<CollectionName>'NEWLIB

Examples:
|Storage1|Storage2| Agency1                 | Agency2              |User1               |User2                 |CollectionName        |
|S3      |        |UFS3BTABAV_S3BU6         |UFS3BTABAV_AdgateBU2  |UFS3BTABAV_S3_U9    |UFS3BTABAV_Adgate_U6  |UFS3BTABAV_S3col1     |
|        | S3     |UFS3BTABAV_AdgateBU3     |UFS3BTABAV_S3BU7	   |UFS3BTABAV_Adgate_U7|UFS3BTABAV_S3_U10     |UFS3BTABAV_Adgatecol1 |


Scenario: User present in Multiple BUs with different storages and Project and folder creation upload in multiple BU
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And updated the following agency:
| Name      | Storage |
| <Agency1> | <Storage1> |
| <Agency2> | <Storage2> |
And created users with following fields:
| Agency   | Email     | Role         |
| <Agency1>|<User1>    | agency.admin|
| <Agency2>|<User2>    | agency.user|
And added existing user '<User2>' to agency '<Agency1>' with role 'agency.user'
And logged in with details of '<User2>'
And created following projects:
| Name           | Business Unit   |
| <ProjectName>  | <Agency1>       |
And created '<FolderName>' folder for project '<ProjectName>'
And uploaded '/files/Fish2-Ad.mov' file into '<FolderName>' folder for '<ProjectName>' project
And waited while preview is available in folder '<FolderName>' on project '<ProjectName>' files page
When login with details of '<User1>'
And I go to project '<ProjectName>' overview page
And open file 'Fish2-Ad.mov' on project '<ProjectName>' overview page
Then I should see file 'Fish2-Ad.mov' info page in project '<ProjectName>' folder '<FolderName>'
When I upload into project '<ProjectName>' following revisions:
| FileName           | Path            | MasterFileName |
| /files/Fish Ad.mov | <FolderName>    | Fish2-Ad.mov   |
And wait while preview is available in folder '<FolderName>' on project '<ProjectName>' files page
And I go to file 'Fish2-Ad.mov' version history page in folder '<FolderName>' project '<ProjectName>'
Then I 'should' see revision '2' on file 'Fish2-Ad.mov' version history page in folder '<FolderName>' project '<ProjectName>' marked as Current
When upload '/files/image10.jpg' file into '<FolderName>' folder for '<ProjectName>' project
And wait while preview is available in folder '<FolderName>' on project '<ProjectName>' files page
Then I should see files 'image10.jpg' inside '<FolderName>' folder for '<ProjectName>' project
When I create '/NewF3' folder for project '<ProjectName>'
And upload '/files/image9.jpg' file into '/NewF3' folder for '<ProjectName>' project
Then I should see files 'image9.jpg' inside '/NewF3' folder for '<ProjectName>' project

Examples:
|Storage1|Storage2| Agency1             | Agency2             |User1               |User2                     |ProjectName      |FolderName|
|S3      |        |UFS3BTABAV_S3BU8     |UFS3BTABAV_AdgateBU4 |UFS3BTABAV_S3_U11   |UFS3BTABAV_Adg_MultiU1    |UFS3BTABAV_Adg_P4|/UFS3BTABAV_Adg_F4|
|        | S3     |UFS3BTABAV_AdgateBU5 |UFS3BTABAV_S3BU9     |UFS3BTABAV_Adgate_U8| UFS3BTABAV_S3_MultiU1    |UFS3BTABAV_S3_P2  |/UFS3BTABAV_S3_F2    |


Scenario: Check that user in Multiple BUs (of different storages) can upload assets to multiple BUs
Meta:@gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created the agency '<Agency3>' with default attributes
And updated the following agency:
| Name      | Storage    |
| <Agency1> | <Storage1> |
| <Agency2> | <Storage2> |
| <Agency3> | <Storage1> |
And created users with following fields:
| Email         | Role         | Agency    |Access|
| <User1>       | agency.user  | <Agency1> |streamlined_library|
| <User2>       | agency.admin | <Agency2> |streamlined_library|
| <User3>       | agency.admin | <Agency3> |streamlined_library|
And added existing user '<User1>' to agency '<Agency2>' with role 'agency.user'
And added existing user '<User1>' to agency '<Agency3>' with role 'agency.user'
When login with details of '<User1>'
And I upload following assets into following agenciesNEWLIB:
| Name                | AgencyName   |
| /files/image10.jpg  |<Agency2>     |
| /files/Fish2-Ad.mov |<Agency3>     |
And login with details of '<User2>'
When I go to  library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'image10.jpg' in the collection 'Everything'NEWLIB
Then I 'should not' see assets 'Fish2-Ad.mov' in the collection 'Everything'NEWLIB
And login with details of '<User3>'
When I go to  library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish2-Ad.mov' in the collection 'Everything'NEWLIB
Then I 'should not' see assets 'image10.jpg' in the collection 'Everything'NEWLIB


Examples:
|Storage1|Storage2| Agency1             | Agency2             | Agency3              |User1                    |User2              | User3           |
|S3      |        |UFS3BTABAV_S3BU10    |UFS3BTABAV_AdgateBU6 |UFS3BTABAV_S3BU11     | UFS3BTABAV_S3_MultiU2  |UF3BTABAV_Adgate_U9 |UFS3BTABAV_S3_U12|
|        | S3     |UFS3BTABAV_AdgateBU7 |UFS3BTABAV_S3BU12    |UFS3BTABAV_AdgateBU8  | UFS3BTABAV_Adg_MultiU2 |UFS3BTABAV_S3_U13   |UFS3BTABAV_Adgate_U10|

