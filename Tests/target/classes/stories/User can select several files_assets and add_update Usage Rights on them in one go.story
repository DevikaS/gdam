Feature:          User can select several files/assets and add/update Usage Rights on them in one go
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that several files/assets and add/update Usage Rights works


Scenario: Check that if selected several files and half of them are without permission Edit Usage right, edit work but only for that files that with permission UR write
Meta:@projects
     @gdam
Given I created the following agency:
| Name         |
| A_LPTG_S07   |
| A_LPTG_S08   |
And created 'PR_MFTL_S05' role with 'folder.read,folder.delete,element.create,element.delete,element.read,element.write,element.usage_rights.write,element.usage_rights.read,project.read' permissions in 'project' group for advertiser 'A_LPTG_S07'
And created users with following fields:
| Email        | Role         | Agency     |
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |
| U_LPTG_S07_2 | agency.admin | A_LPTG_S08 |
And logged in with details of 'U_LPTG_S07_1'
And created 'P_LPTG_S01' project
And created '/F1' folder for project 'P_LPTG_S01'
And uploaded '/files/image10.jpg' file into '/F1' folder for 'P_LPTG_S01' project
And waited while transcoding is finished in folder '/F1' on project 'P_LPTG_S01' files page
And added users 'U_LPTG_S07_2' to project 'P_LPTG_S01' team folders '/F1' with role 'project.contributor' expired '12.12.2021'
And uploaded '/files/120.600.gif' file into '/F2' folder for 'P_LPTG_S01' project
And waited while transcoding is finished in folder '/F2' on project 'P_LPTG_S01' files page
And added users 'U_LPTG_S07_2' to project 'P_LPTG_S01' team folders '/F2' with role 'PR_MFTL_S05' expired '12.12.2021'
And am on Project list page
And logged in with details of 'U_LPTG_S07_2'
And am on Project list page
And on project 'P_LPTG_S01' folder '/F2' page
And selected file '120.600.gif' on project files page
And I clicked move button on project files page
When I select folder 'F1' on move/copy file popup
And click move button on move/copy files popup
And select file 'image10.jpg' on project files page
And select file '120.600.gif' on project files page
And I add Batch Usage Right 'Countries' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |
And wait for '2' seconds
Then I 'should' see 'Countries' usage rule with following fields on file '120.600.gif' and folder '/F1' and project 'P_LPTG_S01' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |
And I 'should not' see 'Countries' usage rule with following fields on file 'image10.jpg' and folder '/F1' and project 'P_LPTG_S01' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |


Scenario: Check that usage right could be added to batch with different media types (assets)
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |streamlined_library|
And logged in with details of 'U_LPTG_S07_1'
And I am on the Library page for collection 'My Assets'NEWLIB
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
When I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Voice-over Artist' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent   | AgentTel  | Email           | Union      | MoreInfo  |
| Ran  Marsh | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And I go to asset 'image10.jpg' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent   | AgentTel     | Email           | Union      | MoreInfo  |
| Ran Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When I go to asset 'Fish1-Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent   | AgentTel     | Email           | Union      | MoreInfo  |
| Ran Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When I go to asset 'audio01.mp3' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent   | AgentTel     | Email           | Union      | MoreInfo  |
| Ran Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |


Scenario: Check that Assets with added UR could be visible in advanced search by UR filters
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_3 | agency.admin | A_LPTG_S07 |streamlined_library|
And logged in with details of 'U_LPTG_S07_3'
And I am on the Library page for collection 'My Assets'NEWLIB
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
When I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Countries' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I click expand Usage rights on current filter page
And I select 'Usage country' with value 'Antarctica' as filter collection 'My Assets'NEWLIB
And I add assets to 'sub' collection 'C_LPTG_S07' from collection 'My Assets'NEWLIB
Then I 'should' see assets 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the collection 'C_LPTG_S07'NEWLIB
And I 'should' see asset count '3' in 'C_LPTG_S07' NEWLIB


Scenario: Check that to batch files could be added different UR types
Meta:@gdam
@projects
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |
And logged in with details of 'U_LPTG_S07_1'
And created 'P_LPTG_S01' project
And created '/F1' folder for project 'P_LPTG_S01'
And uploaded '/files/image10.jpg' file into '/F1' folder for 'P_LPTG_S01' project
And uploaded '/files/Fish1-Ad.mov' file into '/F1' folder for 'P_LPTG_S01' project
And uploaded '/files/audio01.mp3' file into '/F1' folder for 'P_LPTG_S01' project
And waited while preview is available in folder '/F1' on project 'P_LPTG_S01' files page
And selected files on project files page:
| FileName    |
| image10.jpg |
| Fish1-Ad.mov|
| audio01.mp3 |
When I add Batch Usage Right 'Visual Talent' with following fields on opened Edit Usage Rights pop-up from project folder page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And wait for '5' seconds
And select files on project files page:
| FileName    |
| image10.jpg |
| Fish1-Ad.mov|
| audio01.mp3 |
And I add Batch Usage Right 'Countries' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |
And wait for '5' seconds
And select files on project files page:
| FileName    |
| image10.jpg |
| Fish1-Ad.mov|
| audio01.mp3 |
And I add Batch Usage Right 'Media Types' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Type | Comment      |
| TV   | test comment |
And go to file 'audio01.mp3' usage rights page in folder '/F1' project 'P_LPTG_S01'
Then I 'should' see 'Media Types' usage rule with following fields on file 'audio01.mp3' and folder '/F1' and project 'P_LPTG_S01' Usage Rights page:
| Type | Comment      |
| TV   | test comment |
And I 'should' see 'Visual Talent' usage rule with following fields on file 'audio01.mp3' and folder '/F1' and project 'P_LPTG_S01' Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And I 'should' see 'Countries' usage rule with following fields on file 'audio01.mp3' and folder '/F1' and project 'P_LPTG_S01' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |



Scenario: Check that if selected assets without permission on usage rigth write,button Edit Usage right is inactive
Meta:@gdam
@library
Given I created the agency 'BULPTG_A1' with default attributes
And created the agency 'BULPTG_A2' with default attributes
And created 'without.URPermisions' role in 'library' group for advertiser 'BULPTG_A1' with following permissions:
| Permission                 |
| asset.read                 |
| asset.share                |
| asset_filter_category.read |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| ULPTG_E06_1 | agency.admin | BULPTG_A1    |streamlined_library|
| ULPTG_E06_2 | agency.admin | BULPTG_A2    |streamlined_library|
And logged in with details of 'GlobalAdmin'
And added following partners 'BULPTG_A1' to agency 'BULPTG_A2' on partners page
When I login with details of 'ULPTG_E06_1'
And create 'col6' category
And upload following assetsNEWLIB:
| Name        |
| /files/image10.jpg |
And go to the Library page for collection 'col6'NEWLIB
And wait while preview is available in collection 'col6'NEWLIB
And go to collection 'col6' on administration area collections page
And add users 'ULPTG_E06_2' to category 'col6' with role 'without.URPermisions' by users details
And login with details of 'ULPTG_E06_2'
And go to  library page for collection 'col6'NEWLIB
And select asset 'image10.jpg' in the 'col6' library pageNEWLIB
Then I 'should not' see 'Add Usage Rights' option in menu for collection 'col6'NEWLIB

