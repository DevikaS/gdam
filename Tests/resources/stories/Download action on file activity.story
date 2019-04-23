!--NGN-2474 NGN-4069
Feature:          Download action on file activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check download action on file activity log

Scenario: Check that download action is displayed on Activity tab within project (file activity page)
Meta:@gdam
@projects
Given I created 'P_DAFA_S01' project
And created '/F01' folder for project 'P_DAFA_S01'
And uploaded '/files/New Text Document.txt' file into '/F01' folder for 'P_DAFA_S01' project
And waited while transcoding is finished in folder '/F01' on project 'P_DAFA_S01' files page
When I downloaded file '/files/New Text Document.txt' on folder '/F01' project 'P_DAFA_S01' file info page
And wait for '5' seconds
Then I 'should' see on Activity tab for file 'New Text Document.txt' in folder '/F01' project 'P_DAFA_S01' following recent user's activity :
| User        | Logo  | ActivityType    | ActivityMessage        |
| AgencyAdmin | EMPTY | file_downloaded | downloaded file master |


Scenario: Check that download action is displayed on Recent user's activity within project (project team page)
Meta:@gdam
@projects
Given I created 'P_DAFA_S02' project
And created '/F02' folder for project 'P_DAFA_S02'
And uploaded '/files/New Text Document.txt' file into '/F02' folder for 'P_DAFA_S02' project
And waited while transcoding is finished in folder '/F02' on project 'P_DAFA_S02' files page
When I downloaded file '/files/New Text Document.txt' on folder '/F02' project 'P_DAFA_S02' file info page
And wait for '3' seconds
And go to project 'P_DAFA_S02' teams page
And refresh the page
Then I 'should' see activity for user 'AgencyAdmin' on project team page with message 'downloaded file master' and value '/P_DAFA_S02/F02/New Text Document.txt'


Scenario: Check that download action is displayed on Recent user's activity within project (project overview page)
Meta:@gdam
@projects
Given I created 'P_DAFA_S03' project
And created '/F03' folder for project 'P_DAFA_S03'
And uploaded '/files/New Text Document.txt' file into '/F03' folder for 'P_DAFA_S03' project
And waited while transcoding is finished in folder '/F03' on project 'P_DAFA_S03' files page
When I downloaded file '/files/New Text Document.txt' on folder '/F03' project 'P_DAFA_S03' file info page
And wait for '10' seconds
Then I 'should' see activity where user 'AgencyAdmin' download file master '/P_DAFA_S03/F03/New Text Document.txt' in project 'P_DAFA_S03' on Project Overview page


Scenario: Check that download action is displayed on Activity tab within template
Meta:@gdam
     @skip
!-- NGN-10204
Given I created 'T_DAFA_S04' template
And created '/F04' folder for template 'T_DAFA_S04'
And uploaded '/files/New Text Document.txt' file into '/F04' folder for 'T_DAFA_S04' template
And waited while transcoding is finished in folder '/F04' on template 'T_DAFA_S04' files page
When I downloaded file '/files/New Text Document.txt' on folder '/F04' template 'T_DAFA_S04' file info page
Then I 'should' see activity for user 'AgencyAdmin' on file 'New Text Document.txt' activity tab in template 'T_DAFA_S04' folder '/F04' page with message 'downloaded file master' and value 'New Text Document.txt'
When I go to template 'T_DAFA_S04' teams page
Then I 'should' see activity for user 'AgencyAdmin' on template team page with message 'downloaded file master' and value '/F04/New Text Document.txt'


Scenario: Check that click on username should redirect to teams page
Meta:@gdam
@projects
Given I created 'P_DAFA_S08' project
And created '/F08' folder for project 'P_DAFA_S08'
And uploaded '/files/New Text Document.txt' file into '/F08' folder for 'P_DAFA_S08' project
And waited while transcoding is finished in folder '/F08' on project 'P_DAFA_S08' files page
When I downloaded file '/files/New Text Document.txt' on folder '/F08' project 'P_DAFA_S08' file info page
And click on user name 'AgencyAdmin' in Activity tab on open uploaded file '/files/New Text Document.txt' in folder '/F08' project 'P_DAFA_S08'
Then I should see project team page 'team'


Scenario: Check that after click on username, current user is selected on the teams page
!--As per QA-678 Modified test
Meta:@gdam
@projects
Given I created 'P_DAFA_S09' project
And created '/F09' folder for project 'P_DAFA_S09'
And uploaded '/files/New Text Document.txt' file into '/F09' folder for 'P_DAFA_S09' project
And waited while transcoding is finished in folder '/F09' on project 'P_DAFA_S09' files page
When I downloaded file '/files/New Text Document.txt' on folder '/F09' project 'P_DAFA_S09' file info page
And click on user name 'AgencyAdmin' in Activity tab on open uploaded file '/files/New Text Document.txt' in folder '/F09' project 'P_DAFA_S09'
Then I 'should not' see selected user 'AgencyAdmin' into project 'P_DAFA_S09' team page


Scenario: Check that download file activity is displayed for project owner from current agency
!--NGN-2788
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName  | Email        | Role         | Logo |
| AdminFN10 | AdminLN10 | U_DAFA_S10_1 | agency.admin | GIF  |
| UserFN10  | UserLN10  | U_DAFA_S10_2 | agency.user  | PNG  |
And I logged in with details of 'U_DAFA_S10_1'
And created 'P_DAFA_S10' project
And created '/F10' folder for project 'P_DAFA_S10'
And uploaded '/files/New Text Document.txt' file into '/F10' folder for 'P_DAFA_S10' project
And waited while transcoding is finished in folder '/F10' on project 'P_DAFA_S10' files page
When I downloaded file '/files/New Text Document.txt' on folder '/F10' project 'P_DAFA_S10' file info page
And I add user 'U_DAFA_S10_2' to Address book
And open project 'P_DAFA_S10' settings page
And edit the following fields for 'P_DAFA_S10' project:
| Name       | Administrators |
| P_DAFA_S10 | U_DAFA_S10_2   |
And click on element 'SaveButton'
And login with details of 'U_DAFA_S10_2'
And go to project 'P_DAFA_S10' folder '/F10' page
And go to file '/files/New Text Document.txt' info page in folder '/F10' project 'P_DAFA_S10'
Then I 'should' see activity for user 'U_DAFA_S10_1' on file 'New Text Document.txt' activity tab in project 'P_DAFA_S10' folder '/F10' page with message 'downloaded file master' and value ''


Scenario: Check that download file activity is displayed for project owner from another agency
!--NGN-2788
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName  | Email        | Role         | Logo | Agency        |
| AdminFN11 | AdminLN11 | U_DAFA_S11_1 | agency.admin | GIF  | ##            |
| UserFN11  | UserLN11  | U_DAFA_S11_2 | agency.user  | PNG  | AnotherAgency |
And I logged in with details of 'U_DAFA_S11_1'
And added user 'U_DAFA_S11_2' into address book
And created 'P_DAFA_S11' project
And created '/F11' folder for project 'P_DAFA_S11'
And uploaded '/files/New Text Document.txt' file into '/F11' folder for 'P_DAFA_S11' project
And waited while transcoding is finished in folder '/F11' on project 'P_DAFA_S11' files page
When I downloaded file '/files/New Text Document.txt' on folder '/F11' project 'P_DAFA_S11' file info page
And open project 'P_DAFA_S11' settings page
And edit the following fields for 'P_DAFA_S11' project:
| Name       | Administrators |
| P_DAFA_S11 | U_DAFA_S11_2   |
And click on element 'SaveButton'
And login with details of 'U_DAFA_S11_2'
And go to project 'P_DAFA_S11' folder '/F11' page
And go to file '/files/New Text Document.txt' info page in folder '/F11' project 'P_DAFA_S11'
Then I 'should' see activity for user 'U_DAFA_S11_1' on file 'New Text Document.txt' activity tab in project 'P_DAFA_S11' folder '/F11' page with message 'downloaded file master' and value ''


Scenario: Check that download file activity displays correct user name if file has been downloaded by user whom folder has been shared
!--NGN-4004
Meta:@gdam
@projects
Given I created 'R_DAFA_S12' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
Given I created users with following fields:
| Email        | Role        |
| U_DAFA_S12_1 | agency.user |
| U_DAFA_S12_2 | agency.user |
And logged in with details of 'U_DAFA_S12_1'
And created 'P_DAFA_S12' project
And created '/F12' folder for project 'P_DAFA_S12'
And uploaded '/files/New Text Document.txt' file into '/F12' folder for 'P_DAFA_S12' project
And I am on file '/files/New Text Document.txt' info page in folder '/F12' project 'P_DAFA_S12'
And waited while transcoding is finished in folder '/F12' on project 'P_DAFA_S12' files page
And I am on project 'P_DAFA_S12' teams page
And added user 'U_DAFA_S12_2' into project 'P_DAFA_S12' team with role 'R_DAFA_S12' expired '12.12.2021' for folder on popup '/F12'
When I login with details of 'U_DAFA_S12_2'
And go to file '/files/New Text Document.txt' info page in folder '/F12' project 'P_DAFA_S12'
And downloaded file '/files/New Text Document.txt' on folder '/F12' project 'P_DAFA_S12' file info page
And wait for '10' seconds
And login with details of 'U_DAFA_S12_1'
And go to file '/files/New Text Document.txt' info page in folder '/F12' project 'P_DAFA_S12'
Then I 'should' see on Activity tab for file 'New Text Document.txt' in folder '/F12' project 'P_DAFA_S12' following recent user's activity :
| User         | Logo  | ActivityType    | ActivityMessage        |
| U_DAFA_S12_2 | EMPTY | file_downloaded | downloaded file master |

Scenario: Check size of downloaded master file is correct against what is dispalyed on page
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created 'ATP_Master_001' project
And created '/ATP_FL_001' folder for project 'ATP_Master_001'
When I upload '/files/Fish1-Ad.mov' file into '/ATP_FL_001' folder for 'ATP_Master_001' project
And wait while transcoding is finished in folder '/ATP_FL_001' on project 'ATP_Master_001' files page
Then I 'should' see Download Original button on file '/files/Fish1-Ad.mov' info page in folder '/ATP_FL_001' project 'ATP_Master_001'
And on download size of 'original' file 'Fish1-Ad.mov' on folder '/ATP_FL_001' project 'ATP_Master_001' file info page matches size of 'rev-1-Fish1-Ad_master.mov'

Scenario: Check size of downloaded proxy file is correct against what is dispalyed on page
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I created 'ATP_Master_002' project
And created '/ATP_FL_002' folder for project 'ATP_Master_002'
And uploaded '/files/Fish1-Ad.mov' file into '/ATP_FL_002' folder for 'ATP_Master_002' project
And waited while preview is available in folder 'ATP_FL_002' on project 'ATP_Master_002' files page
Then I 'should' see Download proxy button on file '/files/Fish1-Ad.mov' info page in folder '/ATP_FL_002' project 'ATP_Master_002'
And on download size of 'preview' file 'Fish1-Ad.mov' on folder '/ATP_FL_002' project 'ATP_Master_002' file info page matches size of 'rev-1-Fish1-Ad_proxy.mp4'



Scenario: check that user is able to download masters of several files in folder as a single zip
Meta:@gdam
@projects
Given I created the agency 'ATP_AG1' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_ATP_01   | agency.admin | ATP_AG1      |
And logged in with details of 'U_ATP_01'
And I created 'ZIPP1' project
And created '/ZIPF1' folder for project 'ZIPP1'
And uploaded into project 'ZIPP1' following files:
| FileName              | Path   |
| /files/Fish1-Ad.mov   | /ZIPF1 |
| /files/Fish2-Ad.mov   | /ZIPF1 |
| /files/Fish3-Ad.mov   | /ZIPF1 |
And I am on project 'ZIPP1' folder '/ZIPF1' page
And waited while preview is available in folder '/ZIPF1' on project 'ZIPP1' files page
And I clicked element 'SelectAll' on page 'FilesPage'
And clicked Download button on project files page
When I select checkbox 'master' and click download
Then 'master' files 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov' on folder '/ZIPF1' project 'ZIPP1' is downloaded as 'master.zip'

Scenario: check that user is able to download proxies of several files in folder as a single zip
Meta:@gdam
@projects
Given I created the agency 'ATP_AG2' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_ATP_02   | agency.admin | ATP_AG2      |
And logged in with details of 'U_ATP_02'
Given I created 'ZIPP2' project
And created '/ZIPF2' folder for project 'ZIPP2'
And uploaded into project 'ZIPP2' following files:
| FileName              | Path   |
| /files/Fish1-Ad.mov   | /ZIPF2 |
| /files/Fish2-Ad.mov   | /ZIPF2 |
| /files/Fish3-Ad.mov   | /ZIPF2 |
And I am on project 'ZIPP2' folder '/ZIPF2' page
And waited while preview is available in folder '/ZIPF2' on project 'ZIPP2' files page
And I clicked element 'SelectAll' on page 'FilesPage'
And clicked Download button on project files page
When I select checkbox 'proxy' and click download
Then 'proxy' files 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov' on folder '/ZIPF2' project 'ZIPP2' is downloaded as 'proxy.zip'


Scenario: check that user is able to download both masters and proxies of several files in folder as zip
Meta:@gdam
@projects
Given I created the agency 'ATP_AG3' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_ATP_03   | agency.admin | ATP_AG3      |
And logged in with details of 'U_ATP_03'
Given I created 'ZIPP3' project
And created '/ZIPF3' folder for project 'ZIPP3'
And uploaded into project 'ZIPP3' following files:
| FileName              | Path   |
| /files/Fish1-Ad.mov   | /ZIPF3 |
| /files/Fish2-Ad.mov   | /ZIPF3 |
| /files/Fish3-Ad.mov   | /ZIPF3 |
And I am on project 'ZIPP3' folder '/ZIPF3' page
And waited while preview is available in folder '/ZIPF3' on project 'ZIPP3' files page
And I clicked element 'SelectAll' on page 'FilesPage'
And clicked Download button on project files page
When I select checkbox 'master,proxy' and click download
Then 'master,proxy' files 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov' on folder '/ZIPF3' project 'ZIPP3' is downloaded as 'master_proxy.zip'

Scenario: Check that user with permissions only to download masters is not able to download proxies
Meta:@gdam
@projects
Given I created the agency 'A_ZIPP_1' with default attributes
And created 'R_ZIPP_1_without_proxy' role in 'project' group for advertiser 'A_ZIPP_1' with following permissions:
| Permission                 |
| adkit.read                 |
| adkit_template.read        |
| attached_file.create       |
| attached_file.delete       |
| attached_file.read         |
| comment.create             |
| comment.read               |
| element.create             |
| element.read               |
| element.usage_rights.read  |
| file.download              |
| folder.create              |
| folder.read                |
| project.read               |
| project_template.read      |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_ZIP_S04_1 | agency.admin | A_ZIPP_1     |
| U_ZIP_S04_2 | agency.user  | A_ZIPP_1     |
And logged in with details of 'U_ZIP_S04_1'
And created 'P_ZIP_7' project
And created '/F_ZIP_7_1' folder for project 'P_ZIP_7'
And uploaded into project 'P_ZIP_7' following files:
| FileName              | Path       |
| /files/Fish1-Ad.mov   | /F_ZIP_7_1 |
| /files/Fish2-Ad.mov   | /F_ZIP_7_1 |
| /files/Fish3-Ad.mov   | /F_ZIP_7_1 |
And waited while transcoding is finished in folder '/F_ZIP_7_1' on project 'P_ZIP_7' files page
When I add users 'U_ZIP_S04_2' to project 'P_ZIP_7' team folders '/F_ZIP_7_1' with role 'R_ZIPP_1_without_proxy' expired '10.10.2020'
And login with details of 'U_ZIP_S04_2'
And I go to project 'P_ZIP_7' folder '/F_ZIP_7_1' page
And I click element 'SelectAll' on page 'FilesPage'
And click Download button on project files page
Then I 'should' see checkbox 'master' is visible on opened pop-up of download File
And I 'should not' see checkbox 'proxy' is visible on opened pop-up of download File
When I select checkbox 'master' and click download
Then 'master' files 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov' on folder '/F_ZIP_7_1' project 'P_ZIP_7' is downloaded as 'master.zip'

Scenario: Check that user with permissions only to download proxies is not able to download masters
Meta:@gdam
@projects
Given I created the agency 'A_ZIPP_2' with default attributes
And created 'R_ZIPP_2_without_master' role in 'project' group for advertiser 'A_ZIPP_2' with following permissions:
| Permission                 |
| adkit.read                 |
| adkit_template.read        |
| attached_file.create       |
| attached_file.delete       |
| attached_file.read         |
| comment.create             |
| comment.read               |
| element.create             |
| element.read               |
| element.usage_rights.read  |
| folder.create              |
| folder.read                |
| project.read               |
| project_template.read      |
| proxy.download             |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_ZIP_S05_1 | agency.admin | A_ZIPP_2     |
| U_ZIP_S05_2 | agency.user  | A_ZIPP_2     |
And logged in with details of 'U_ZIP_S05_1'
And created 'P_ZIP_8' project
And created '/F_ZIP_8_1' folder for project 'P_ZIP_8'
And uploaded into project 'P_ZIP_8' following files:
| FileName              | Path       |
| /files/Fish1-Ad.mov   | /F_ZIP_8_1 |
| /files/Fish2-Ad.mov   | /F_ZIP_8_1 |
| /files/Fish3-Ad.mov   | /F_ZIP_8_1 |
And waited while transcoding is finished in folder '/F_ZIP_8_1' on project 'P_ZIP_8' files page
When I add users 'U_ZIP_S05_2' to project 'P_ZIP_8' team folders '/F_ZIP_8_1' with role 'R_ZIPP_2_without_master' expired '10.10.2020'
And login with details of 'U_ZIP_S05_2'
And I go to project 'P_ZIP_8' folder '/F_ZIP_8_1' page
And I click element 'SelectAll' on page 'FilesPage'
And click Download button on project files page
Then I 'should' see checkbox 'proxy' is visible on opened pop-up of download File
And I 'should not' see checkbox 'master' is visible on opened pop-up of download File
When I select checkbox 'proxy' and click download
Then 'proxy' files 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov' on folder '/F_ZIP_8_1' project 'P_ZIP_8' is downloaded as 'proxy.zip'



Scenario: Check user from a bu should not be able to view/download assets added in partner bu unless that agrncy is added to that category
Meta:@gdam
@library
Given I created the following agency:
| Name        | Storage                  |
| ZIPBU_Z1_1N | 568cec9de4b0ebf465310e1f |
| ZIPBU_Z1_2N | 5891c9c8e4b0fd25c99f77b4 |
And created users with following fields:
| Email        | Role         | AgencyUnique  |Access|
| U_ZIP_S07_1N | agency.admin | ZIPBU_Z1_1N   |streamlined_library|
| U_ZIP_S07_2N | agency.admin | ZIPBU_Z1_2N   |streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners 'ZIPBU_Z1_2N' to agency 'ZIPBU_Z1_1N' on partners page
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ZIPBU_Z1_1N':
| Advertiser |
| ZIPP_A2    |
And I logged in with details of 'U_ZIP_S07_1N'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And on asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Advertiser | ZIPP_A2    |
| Clock number | ZIPP_Clk1    |
And created 'ZIP_C2' category
And added agency 'ZIPBU_Z1_2N' to category 'ZIP_C2' on Asset Categories and Permissions page
And added into category 'ZIP_C2' following metadata:
| FilterName | FilterValue |
| Advertiser | ZIPP_A2     |
And logged in with details of 'U_ZIP_S07_2N'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'ZIP_C2' from agency 'ZIPBU_Z1_1N' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'ZIP_C2' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And wait while transcoding is finished in collection 'Everything'NEWLIB
Then I am able to downloaded asset 'Fish1-Ad.mov' as 'master,proxy' from collection 'Everything'
And I am able to downloaded asset 'Fish2-Ad.mov' as 'master,proxy' from collection 'Everything'
And I am able to downloaded asset 'Fish3-Ad.mov' as 'master,proxy' from collection 'Everything'
When I logout from account
And login with details of 'U_ZIP_S07_1N'
And go to the Library page for collection 'My Assets'NEWLIB
Then I 'should not' see assets 'Fish2-Ad.mov' in the collection 'My Assets'NEWLIB


Scenario: Check that download is possible more than one time
Meta:@gdam
@library
Given I created the following agency:
| Name       | Storage                   |
| ZIPBU_Z2_1 | 568cec9de4b0ebf465310e1f  |
| ZIPBU_Z2_2 | 5891c9c8e4b0fd25c99f77b4  |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| U_ZIP_S08_1 | agency.admin | ZIPBU_Z2_1   |streamlined_library|
| U_ZIP_S08_2 | agency.admin | ZIPBU_Z2_2   |streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners 'ZIPBU_Z2_2' to agency 'ZIPBU_Z2_1' on partners page
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ZIPBU_Z2_1':
| Advertiser |
| ZIPP_A3    |
And I logged in with details of 'U_ZIP_S08_1'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And on asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Advertiser | ZIPP_A3    |
And created 'ZIP_C3' category
And added agency 'ZIPBU_Z2_2' to category 'ZIP_C3' on Asset Categories and Permissions page
And added into category 'ZIP_C3' following metadata:
| FilterName | FilterValue |
| Advertiser | ZIPP_A3     |
And logged in with details of 'U_ZIP_S08_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'ZIP_C3' from agency 'ZIPBU_Z2_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'ZIP_C3' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload following assetsNEWLIB:
| Name                |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And wait while transcoding is finished in collection 'Everything'NEWLIB
Then I am able to downloaded asset 'Fish1-Ad.mov' as 'master,proxy' from collection 'Everything'
And I am able to downloaded asset 'Fish2-Ad.mov' as 'master,proxy' from collection 'Everything'
And I am able to downloaded asset 'Fish3-Ad.mov' as 'master,proxy' from collection 'Everything'
When I refresh the page
Then I am able to downloaded asset 'Fish1-Ad.mov' as 'master,proxy' from collection 'Everything'
And I am able to downloaded asset 'Fish2-Ad.mov' as 'master,proxy' from collection 'Everything'
And I am able to downloaded asset 'Fish3-Ad.mov' as 'master,proxy' from collection 'Everything'


Scenario: Check presence of incoming email with link for download for zip download
Meta:@skip
!--Not applicable for new lib
Given I created the following agency:
| Name      | Storage                |
| ZIPBU1    | 568cec9de4b0ebf465310e1f |
| ZIPBU2    | 568cf1fde4b0ebf465310e46  |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_ZIP_S06_1 | agency.admin | ZIPBU1       |
| U_ZIP_S06_2 | agency.admin | ZIPBU2       |
And logged in with details of 'GlobalAdmin'
And added following partners 'ZIPBU2' to agency 'ZIPBU1' on partners page
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ZIPBU1':
| Advertiser |
| ZIPP_A1    |
And I logged in with details of 'U_ZIP_S06_1'
And uploaded following assets:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName  | FieldValue |
| Advertiser | ZIPP_A1    |
And created 'ZIP_C1' category
And added agency 'ZIPBU2' to category 'ZIP_C1' on Asset Categories and Permissions page
And added into category 'ZIP_C1' following metadata:
| FilterName | FilterValue |
| Advertiser | ZIPP_A1     |
And logged in with details of 'U_ZIP_S06_2'
And accepted all assets on Shared Collection 'ZIP_C1' from agency 'ZIPBU1' page
And uploaded following assets:
| Name                |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And selected all assets on the library page
And I clicked Download button on library page
When I select checkbox 'master' and click download on library page download popup
Then I should see message success 'Your download link is being prepared. You will receive it shortly by email.'
And I 'should' see email with subject 'Your files are available for download' sent to 'U_ZIP_S06_2'


Scenario: Check ability to download zip if you do have a running sessions in Adbank with same user who downloaded(Log in should not be required)
Meta:@skip
!--Not applicable for new lib
Given I created the following agency:
| Name       | Storage                |
| ZIPBU_Z1_1 | 568cec9de4b0ebf465310e1f |
| ZIPBU_Z1_2 | 568cf1fde4b0ebf465310e46  |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_ZIP_S07_1 | agency.admin | ZIPBU_Z1_1   |
| U_ZIP_S07_2 | agency.admin | ZIPBU_Z1_2   |
And logged in with details of 'GlobalAdmin'
And added following partners 'ZIPBU_Z1_2' to agency 'ZIPBU_Z1_1' on partners page
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ZIPBU_Z1_1':
| Advertiser |
| ZIPP_A2    |
And I logged in with details of 'U_ZIP_S07_1'
And uploaded following assets:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName  | FieldValue |
| Advertiser | ZIPP_A2    |
And created 'ZIP_C2' category
And added agency 'ZIPBU_Z1_2' to category 'ZIP_C2' on Asset Categories and Permissions page
And added into category 'ZIP_C2' following metadata:
| FilterName | FilterValue |
| Advertiser | ZIPP_A2     |
And logged in with details of 'U_ZIP_S07_2'
And accepted all assets on Shared Collection 'ZIP_C2' from agency 'ZIPBU_Z1_1' page
And uploaded following assets:
| Name                |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And selected all assets on the library page
And I clicked Download button on library page
When I select checkbox 'master' and click download on library page download popup
Then I should see message success 'Your download link is being prepared. You will receive it shortly by email.'
When I open link from email when user 'U_ZIP_S07_2' received email with next subject 'Your files are available for download'
Then 'should not' see login page
And I should see text on page contains 'Download'

Scenario: Check ability to download zip if you do have a running sessions in Adbank with Different user who downloaded(Log in should not be required)
Meta:@skip
!--Not applicable for new lib
Given I created the following agency:
| Name        | Storage                  |
| ZIPBU_Z1_1N | 568cec9de4b0ebf465310e1f |
| ZIPBU_Z1_2N | 568cf1fde4b0ebf465310e46 |
And created users with following fields:
| Email        | Role         | AgencyUnique  |
| U_ZIP_S07_1N | agency.admin | ZIPBU_Z1_1N   |
| U_ZIP_S07_2N | agency.admin | ZIPBU_Z1_2N   |
And logged in with details of 'GlobalAdmin'
And added following partners 'ZIPBU_Z1_2N' to agency 'ZIPBU_Z1_1N' on partners page
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ZIPBU_Z1_1N':
| Advertiser |
| ZIPP_A2    |
And I logged in with details of 'U_ZIP_S07_1N'
And uploaded following assets:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName  | FieldValue |
| Advertiser | ZIPP_A2    |
And created 'ZIP_C2' category
And added agency 'ZIPBU_Z1_2N' to category 'ZIP_C2' on Asset Categories and Permissions page
And added into category 'ZIP_C2' following metadata:
| FilterName | FilterValue |
| Advertiser | ZIPP_A2     |
And logged in with details of 'U_ZIP_S07_2N'
And accepted all assets on Shared Collection 'ZIP_C2' from agency 'ZIPBU_Z1_1N' page
And uploaded following assets:
| Name                |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And selected all assets on the library page
And I clicked Download button on library page
When I select checkbox 'master' and click download on library page download popup
Then I should see message success 'Your download link is being prepared. You will receive it shortly by email.'
When I logout from account
And login with details of 'U_ZIP_S07_1N'
When I open link from email when user 'U_ZIP_S07_2N' received email with next subject 'Your files are available for download'
Then 'should not' see login page
And I should see text on page contains 'has no permission to download ZIP bundleId'


Scenario: Check that link in email can be used more then one time for download with no running session(logged out--ask to login)
Meta:@skip
!--Not applicable for new lib
Given I created the following agency:
| Name       | Storage                |
| ZIPBU_Z2_1 | 568cec9de4b0ebf465310e1f |
| ZIPBU_Z2_2 | 568cf1fde4b0ebf465310e46  |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_ZIP_S08_1 | agency.admin | ZIPBU_Z2_1   |
| U_ZIP_S08_2 | agency.admin | ZIPBU_Z2_2   |
And logged in with details of 'GlobalAdmin'
And added following partners 'ZIPBU_Z2_2' to agency 'ZIPBU_Z2_1' on partners page
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ZIPBU_Z2_1':
| Advertiser |
| ZIPP_A3    |
And I logged in with details of 'U_ZIP_S08_1'
And uploaded following assets:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And on asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
And 'save' asset info by following information on opened asset info page:
| FieldName  | FieldValue |
| Advertiser | ZIPP_A3    |
And created 'ZIP_C3' category
And added agency 'ZIPBU_Z2_2' to category 'ZIP_C3' on Asset Categories and Permissions page
And added into category 'ZIP_C3' following metadata:
| FilterName | FilterValue |
| Advertiser | ZIPP_A3     |
And logged in with details of 'U_ZIP_S08_2'
And accepted all assets on Shared Collection 'ZIP_C3' from agency 'ZIPBU_Z2_1' page
And uploaded following assets:
| Name                |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'
And selected all assets on the library page
And I clicked Download button on library page
When I select checkbox 'master' and click download on library page download popup
And I logout from account
And I open link from email when user 'U_ZIP_S08_2' received email with next subject 'Your files are available for download'
And login to system as user with name 'U_ZIP_S08_2' and password 'abcdefghA1'
Then I should see text on page contains 'Download'
When I logout from account
And I open link from email when user 'U_ZIP_S08_2' received email with next subject 'Your files are available for download'
And login to system as user with name 'U_ZIP_S08_2' and password 'abcdefghA1'
Then I should see text on page contains 'Download'


