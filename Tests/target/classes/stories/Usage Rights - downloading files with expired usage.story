!--NGN-9762 NGN-10134
Feature:          Usage Rights - downloading files with expired usage
Narrative:
In order to
As a              AgencyAdmin
I want to         Check ability to download files with expired usage

Scenario: Check that on asset details page with expired usage rights download buttons from top/bottom of page is disabled (Download via nVerge and additional formats also if it possible)
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| U_URDFWEU_S01 | agency.admin |streamlined_library|
And logged in with details of 'U_URDFWEU_S01'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should not' see 'download' button on opened asset info pageNEWLIB



Scenario: Check that download buttons is absent in asset with expired usage rights in pivate share (all butons,include top download button)
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email           | Role         |Access|
| U_URDFWEU_S02_1 | agency.admin |streamlined_library|
| U_URDFWEU_S02_2 | agency.user  |streamlined_library|
And logged in with details of 'U_URDFWEU_S02_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add secure share for asset 'Fish1-Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails      | DownloadProxy | DownloadOriginal |
| U_URDFWEU_S02_2 | true          | true             |
And add Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And login with details of 'U_URDFWEU_S02_2'
And open link from email when user 'U_URDFWEU_S02_2' received email with next subject 'has been shared'
Then I 'should not' see Download original button on opened asset preview page
And 'should not' see Download proxy button on opened asset preview page

Scenario: Check that download buttons is absent in asset with expired usage after share category to another BU and user not asset owner (all butons,include top download button)
Meta:@gdam
@library
Given I created the agency 'A_URDFWEU_S03_1' with default attributes
And created the agency 'A_URDFWEU_S03_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_URDFWEU_S03_1 | agency.admin | A_URDFWEU_S03_1 |streamlined_library|
| U_URDFWEU_S03_2 | agency.admin | A_URDFWEU_S03_2 |streamlined_library|
| U_URDFWEU_S03_3 | agency.admin | A_URDFWEU_S03_2 |streamlined_library|
And logged in with details of 'U_URDFWEU_S03_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_URDFWEU_S03_1' category
And I added Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And added agency 'A_URDFWEU_S03_2' to category 'C_URDFWEU_S03_1' on Asset Categories and Permissions page
And logged in with details of 'U_URDFWEU_S03_2'
When I go to the collections page
And I go to the Shared Collection 'C_URDFWEU_S03_1' from agency 'A_URDFWEU_S03_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_URDFWEU_S03_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I logout from account
And I login with details of 'U_URDFWEU_S03_3'
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should not' see 'download' button on opened asset info pageNEWLIB

Scenario: Check that download buttons is absent in asset with expired usage after move to project (all butons,include top download button)
Meta:@gdam
@projects
!--NGN-8362
Given I created users with following fields:
| Email          | Role         |Access|
| AU_URDFWEU_S04 | agency.admin |streamlined_library,folders|
| U_URDFWEU_S04  | agency.user  |streamlined_library,folders|
And logged in with details of 'AU_URDFWEU_S04'
And created 'P_URDFWEU_S04' project
And created '/F_URDFWEU_S04' folder for project 'P_URDFWEU_S04'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And add following asset 'Fish1-Ad.mov' of collection 'My Assets' to project 'P_URDFWEU_S04' folder '/F_URDFWEU_S04'NEWLIB
And filling Share popup by users 'U_URDFWEU_S04' in project 'P_URDFWEU_S04' folders '/F_URDFWEU_S04' with role 'project.user' expired '12.12.2020' and 'should' access to subfolders
And login with details of 'U_URDFWEU_S04'
And go to file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S04' project 'P_URDFWEU_S04'
Then I 'should not' see Download button in the top menu of file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S04' for project 'P_URDFWEU_S04'
And 'should not' see Download proxy button on file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S04' project 'P_URDFWEU_S04'
And 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S04' project 'P_URDFWEU_S04'
And 'should not' see Download master using nVerge button on file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S04' project 'P_URDFWEU_S04'


Scenario: Check that in file with uploaded version and with expired usage rights download button is disabled on version tab
Meta:@gdam
@projects
Given I created 'P_URDFWEU_S06' project
And created 'P_URDFWEU_U06' User
And created '/F_URDFWEU_S06' folder for project 'P_URDFWEU_S06'
And added users 'P_URDFWEU_U06' to project 'P_URDFWEU_S06' team folders '/F_URDFWEU_S06' with role 'project.contributor' expired '12.12.2021'
And uploaded '/files/Fish1-Ad.mov' file into '/F_URDFWEU_S06' folder for 'P_URDFWEU_S06' project
And waited while preview is available in folder '/F_URDFWEU_S06' on project 'P_URDFWEU_S06' files page
When I add 'General' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F_URDFWEU_S06' and project 'P_URDFWEU_S06' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And upload new file version '/files/Fish2-Ad.mov' for file 'Fish1-Ad.mov' into '/F_URDFWEU_S06' folder for 'P_URDFWEU_S06' project
And wait while preview is visible on project 'P_URDFWEU_S06' in folder '/F_URDFWEU_S06' for 'Fish1-Ad.mov' file revision '2'
And login with details of 'P_URDFWEU_U06'
Then I 'should not' see Download Original link for version '2' for file 'Fish1-Ad.mov' version history page in folder '/F_URDFWEU_S06' project 'P_URDFWEU_S06'
And 'should not' see Download Proxy link for version '2' for file 'Fish1-Ad.mov' version history page in folder '/F_URDFWEU_S06' project 'P_URDFWEU_S06'
And 'should not' see Download Original link for version '1' for file 'Fish1-Ad.mov' version history page in folder '/F_URDFWEU_S06' project 'P_URDFWEU_S06'
And 'should not' see Download Proxy link for version '1' for file 'Fish1-Ad.mov' version history page in folder '/F_URDFWEU_S06' project 'P_URDFWEU_S06'


Scenario: Check that if selected file with expired usage rights if folder than download button is enabled (download button from files list)
Meta:@gdam
@projects
!--NGN-9758
Given I created 'P_URDFWEU_S07' project
And created '/F_URDFWEU_S07' folder for project 'P_URDFWEU_S07'
And uploaded '/files/Fish1-Ad.mov' file into '/F_URDFWEU_S07' folder for 'P_URDFWEU_S07' project
And waited while transcoding is finished in folder '/F_URDFWEU_S07' on project 'P_URDFWEU_S07' files page
When I add 'General' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F_URDFWEU_S07' and project 'P_URDFWEU_S07' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
When I go to project 'P_URDFWEU_S07' folder '/F_URDFWEU_S07' page
And select file 'Fish1-Ad.mov' on project files page
Then I 'should' see Download link next to original file 'Fish1-Ad.mov' and Download master using nVerge button on Download popup for project 'P_URDFWEU_S07' folder '/F_URDFWEU_S07'


Scenario: Check that download buttons is absent in file with expired usage rights in public share (all butons,include top download button)
Meta:@gdam
@projects
Given I created users with following fields:
| Email         | Role        |
| U_URDFWEU_S08 | agency.user |
And created 'P_URDFWEU_S08' project
And created '/F_URDFWEU_S08' folder for project 'P_URDFWEU_S08'
And uploaded '/files/Fish1-Ad.mov' file into '/F_URDFWEU_S08' folder for 'P_URDFWEU_S08' project
And waited while preview is available in folder '/F_URDFWEU_S08' on project 'P_URDFWEU_S08' files page
When I send public link of file 'Fish1-Ad.mov' from folder '/F_URDFWEU_S08' and project 'P_URDFWEU_S08' to following users:
| ExpireDate | UserEmails    | Message | DownloadProxy |
| 12.12.21   | U_URDFWEU_S08 | hi dude | true          |
And add 'General' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F_URDFWEU_S08' and project 'P_URDFWEU_S08' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And login with details of 'U_URDFWEU_S08'
And open link from email when user 'U_URDFWEU_S08' received email with next subject 'shared file with you'
Then I 'should not' see element 'DownloadProxy' on page 'PublicFilePreview'


Scenario: Check that download buttons is absent in file with expired usage after share folder (all butons,include top download button)
Meta:@gdam
@projects
Given I created 'PR_URDFWEU_S09' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| project.read               |
| project_template.read      |
| folder.read                |
| element.read               |
| element.usage_rights.read  |
| file.download              |
| proxy.download             |
And created users with following fields:
| Email         | Role        |
| U_URDFWEU_S09 | agency.user |
And created 'P_URDFWEU_S09' project
And created '/F_URDFWEU_S09' folder for project 'P_URDFWEU_S09'
And uploaded '/files/Fish1-Ad.mov' file into '/F_URDFWEU_S09' folder for 'P_URDFWEU_S09' project
And waited while preview is available in folder '/F_URDFWEU_S09' on project 'P_URDFWEU_S09' files page
And fill Share popup by users 'U_URDFWEU_S09' in project 'P_URDFWEU_S09' folders '/F_URDFWEU_S09' with role 'PR_URDFWEU_S09' expired '12.02.2021' and 'should' access to subfolders
When I add 'General' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F_URDFWEU_S09' and project 'P_URDFWEU_S09' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And login with details of 'U_URDFWEU_S09'
Then I 'should not' see Download button in the top menu of file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S09' for project 'P_URDFWEU_S09'
And 'should not' see Download proxy button on file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S09' project 'P_URDFWEU_S09'
And 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S09' project 'P_URDFWEU_S09'
And 'should not' see Download master using nVerge button on file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S09' project 'P_URDFWEU_S09'


Scenario: Check that after search file on file details page with expired usage rights download buttons from top/bottom of page is disabled (Download via nVerge and additional formats also if it possible)
Meta:@gdam
@projects
Given I created the agency 'A_URDFWEU_S10' with default attributes
Given I created users with following fields:
| Email          | Role         | Agency        |
| AU_URDFWEU_S10 | agency.admin | A_URDFWEU_S10 |
| U_URDFWEU_S10  | agency.user  | A_URDFWEU_S10 |
And logged in with details of 'AU_URDFWEU_S10'
And created 'P_URDFWEU_S10' project
And created '/F_URDFWEU_S10' folder for project 'P_URDFWEU_S10'
And uploaded '/files/Fish1-Ad.mov' file into '/F_URDFWEU_S10' folder for 'P_URDFWEU_S10' project
And waited while preview is available in folder '/F_URDFWEU_S10' on project 'P_URDFWEU_S10' files page
And fill Share popup by users 'U_URDFWEU_S10' in project 'P_URDFWEU_S10' folders '/F_URDFWEU_S10' with role 'project.user' expired '12.12.2020' and 'should' access to subfolders
When I add 'General' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F_URDFWEU_S10' and project 'P_URDFWEU_S10' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And login with details of 'U_URDFWEU_S10'
And search by text 'Fish1-Ad.mov'
And click file 'Fish1-Ad.mov' link on search results popup
Then I 'should not' see Download button in the top menu of opened file info page
And 'should not' see Download proxy button on opened file info page
And 'should not' see Download Original button on opened file info page
And 'should not' see Download master using nVerge button on opened file info page



Scenario: Check that user can see download master button in shared project in file with expired usage rights (element.master.expired.usage_rights.download enabled)
Meta:@gdam
@projects
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| project.read               |
| project_template.read      |
| folder.read                |
| element.read               |
| element.usage_rights.read  |
| file.download              |
| proxy.download             |
| <Permissions>              |
And created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And created 'P_URDFWEU_S12' project
And created '/F_URDFWEU_S12' folder for project 'P_URDFWEU_S12'
And uploaded '/files/128_shortname.jpg' file into '/F_URDFWEU_S12' folder for 'P_URDFWEU_S12' project
And waited while preview is available in folder '/F_URDFWEU_S12' on project 'P_URDFWEU_S12' files page
And fill Share popup by users '<UserEmail>' in project 'P_URDFWEU_S12' folders '/F_URDFWEU_S12' with role '<ProjectRole>' expired '12.02.2021' and 'should' access to subfolders
When I add 'General' usage rule with following fields on file '128_shortname.jpg' and folder '/F_URDFWEU_S12' and project 'P_URDFWEU_S12' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And login with details of '<UserEmail>'
And go to project 'P_URDFWEU_S12' folder '/F_URDFWEU_S12' page
And select file '128_shortname.jpg' on project files page
Then I '<Condition>' see Download link for 'original' type on Download popup for project 'P_URDFWEU_S12' folder '/F_URDFWEU_S12'
And '<Condition>' see Download link for 'original' type on Download popup on file '128_shortname.jpg' info page for project 'P_URDFWEU_S12' folder '/F_URDFWEU_S12'
When I refresh the page
Then I '<Condition>' see Download Original button on file '128_shortname.jpg' info page in folder '/F_URDFWEU_S12' project 'P_URDFWEU_S12'

Examples:
| UserEmail       | ProjectRole      | Permissions                                  | Condition  |
| U_URDFWEU_S12_1 | PR_URDFWEU_S12_1 | element.master.expired.usage_rights.download | should     |
| U_URDFWEU_S12_2 | PR_URDFWEU_S12_2 | element.proxy.expired.usage_rights.download  | should not |


Scenario: Check that user can see download proxy and additional transcodings buttons in share project in file with expired usage rights (element.proxy.expired.usage_rights.download enabled)
Meta:@gdam
@projects
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| project.read               |
| project_template.read      |
| folder.read                |
| element.read               |
| element.usage_rights.read  |
| file.download              |
| proxy.download             |
| <Permissions>              |
And created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And created 'P_URDFWEU_S13' project
And created '/F_URDFWEU_S13' folder for project 'P_URDFWEU_S13'
And uploaded '/files/128_shortname.jpg' file into '/F_URDFWEU_S13' folder for 'P_URDFWEU_S13' project
And waited while preview is available in folder '/F_URDFWEU_S13' on project 'P_URDFWEU_S13' files page
And fill Share popup by users '<UserEmail>' in project 'P_URDFWEU_S13' folders '/F_URDFWEU_S13' with role '<ProjectRole>' expired '12.02.2021' and 'should' access to subfolders
When I add 'General' usage rule with following fields on file '128_shortname.jpg' and folder '/F_URDFWEU_S13' and project 'P_URDFWEU_S13' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And login with details of '<UserEmail>'
And go to project 'P_URDFWEU_S13' folder '/F_URDFWEU_S13' page
And select file '128_shortname.jpg' on project files page
Then I '<Condition>' see Download link for 'preview' type on Download popup for project 'P_URDFWEU_S13' folder '/F_URDFWEU_S13'
And '<Condition>' see Download proxy button on file '128_shortname.jpg' info page in folder '/F_URDFWEU_S13' project 'P_URDFWEU_S13'
And '<Condition>' see Download link for 'preview' type on Download popup on file '128_shortname.jpg' info page for project 'P_URDFWEU_S13' folder '/F_URDFWEU_S13'

Examples:
| UserEmail       | ProjectRole      | Permissions                                  | Condition  |
| U_URDFWEU_S13_1 | PR_URDFWEU_S13_1 | element.proxy.expired.usage_rights.download  | should     |
| U_URDFWEU_S13_2 | PR_URDFWEU_S13_2 | element.master.expired.usage_rights.download | should not |


Scenario: Check that user can see download master button in share collection in asset with expired usage rights (asset.master.expired.usage_rights.download enabled)
Meta:@gdam
@library
Given I created '<LibraryRole>' role in 'library' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.usage_rights.read    |
| file.download              |
| proxy.download             |
| <Permissions>              |
And created users with following fields:
| Email          | Role         |Access|
| AU_URDFWEU_S14 | agency.admin |streamlined_library|
| <UserEmail>    | agency.user  |streamlined_library|
And logged in with details of 'AU_URDFWEU_S14'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_URDFWEU_S14' category
And added users '<UserEmail>' for category 'C_URDFWEU_S14' with role '<LibraryRole>'
When I add Usage Right 'General' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And login with details of '<UserEmail>'
And I go to asset '128_shortname.jpg' info page in Library for collection 'C_URDFWEU_S14'NEWLIB
Then I '<Condition1>' see 'download original' button on opened asset info pageNEWLIB
And I '<Condition2>' see 'download sendplus' button on opened asset info pageNEWLIB

Examples:
| UserEmail       | LibraryRole      | Permissions                                | Condition1  |Condition2|
| U_URDFWEU_S14_1 | LR_URDFWEU_S14_1 | asset.master.expired.usage_rights.download | should     |should|
| U_URDFWEU_S14_2 | LR_URDFWEU_S14_2 | asset.proxy.expired.usage_rights.download  | should not |should|





Scenario: Check that download buttons is absent in file with expired usage after move to library (all butons,include top download button)
Meta:@gdam
Given I created 'P_URDFWEU_S11' project
And created '/F_URDFWEU_S11' folder for project 'P_URDFWEU_S11'
And uploaded '/files/Fish1-Ad.mov' file into '/F_URDFWEU_S11' folder for 'P_URDFWEU_S11' project
And waited while transcoding is finished in folder '/F_URDFWEU_S11' on project 'P_URDFWEU_S11' files page
When I add 'General' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F_URDFWEU_S11' and project 'P_URDFWEU_S11' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2002 | Yesterday      |
And go to file 'Fish1-Ad.mov' info page in folder '/F_URDFWEU_S11' project 'P_URDFWEU_S11'
And send file 'Fish1-Ad.mov' on project 'P_URDFWEU_S11' folder '/F_URDFWEU_S11' page to Library
And wait for '3' seconds
And fill following data on add file to library page:
| Title          | Clock number |
| AT_URDFWEU.S11 | testcn       |
And click Save button on Add file to new library page
And go to asset 'AT_URDFWEU.S11' info page in Library for collection 'My Assets'NEWLIB
Then I 'should not' see 'download' button on opened asset info pageNEWLIB
