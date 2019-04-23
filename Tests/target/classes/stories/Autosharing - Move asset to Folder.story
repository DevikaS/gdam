Feature:          Autosharing - Move asset to Folder
Narrative:
In order to
As a              AgencyAdmin
I want to         Check ability to move autoshared asset to folder


Scenario: Check proper displaying folder hierarchy on 'Add Asset to Project' popup for autoshared asset
Meta:@gdam
     @library
Given I created the agency 'A_AMATF_S01_1' with default attributes
And created the agency 'A_AMATF_S01_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_AMATF_S01_2 | new-library-dev-version |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AMATF_S01 | agency.admin | A_AMATF_S01_1 |streamlined_library,library,folders|
| AU2_AMATF_S01 | agency.admin | A_AMATF_S01_2 |streamlined_library,library,folders|
| TU_AMATF_S01  | agency.admin | A_AMATF_S01_2 |streamlined_library,library,folders|
And logged in with details of 'AU1_AMATF_S01'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AMATF_S01' category
And added agency 'A_AMATF_S01_2' to category 'C1_AMATF_S01' on Asset Categories and Permissions page
And logged in with details of 'AU2_AMATF_S01'
When I accept all assets on Shared Collection 'C1_AMATF_S01' from agency 'A_AMATF_S01_1' pageNEWLIB
And create 'LR_AMATF_S01' role in 'library' group for advertiser 'A_AMATF_S01_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create 'C2_AMATF_S01' category
And add users 'TU_AMATF_S01' to category 'C2_AMATF_S01' with role 'LR_AMATF_S01' by users details
And login with details of 'TU_AMATF_S01'
And create 'P_AMATF_S01' project
And create in 'P_AMATF_S01' project next folders:
| folder                                       |
| /F_AMATF_S01_3/SF_AMATF_S01_2/SF_AMATF_S01_1 |
When I go to the Library page for collection 'C2_AMATF_S01'NEWLIB
Then I should see folder 'SF_AMATF_S01_1' under 'F_AMATF_S01_3/SF_AMATF_S01_2/SF_AMATF_S01_1' of project 'P_AMATF_S01' on Add Asset to Project popup while adding asset 'Fish1-Ad.mov' from collection 'C2_AMATF_S01' pageNEWLIB


Scenario: Check that autoshared asset can be added only into Project (not template)
Meta:@gdam
     @library
Given I created the agency 'A_AMATF_S03_1' with default attributes
And created the agency 'A_AMATF_S03_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_AMATF_S03_2 | new-library-dev-version |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AMATF_S03 | agency.admin | A_AMATF_S03_1 |streamlined_library,library,folders|
| AU2_AMATF_S03 | agency.admin | A_AMATF_S03_2 |streamlined_library,library,folders|
| <TestedUser>  | agency.admin | A_AMATF_S03_2 |streamlined_library,library,folders|
And logged in with details of 'AU1_AMATF_S03'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AMATF_S03' category
And added agency 'A_AMATF_S03_2' to category 'C1_AMATF_S03' on Asset Categories and Permissions page
And logged in with details of 'AU2_AMATF_S03'
When I go to the Shared Collection 'C1_AMATF_S03' from agency 'A_AMATF_S03_1' pageNEWLIB
And I select asset '<AssetName>' for collection 'C1_AMATF_S01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_AMATF_S03' role in 'library' group for advertiser 'A_AMATF_S03_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create 'C2_AMATF_S03' category
And add users '<TestedUser>' to category 'C2_AMATF_S03' with role 'LR_AMATF_S03' by users details
And login with details of '<TestedUser>'
And create '<ProjectName>' project
And create '/F_AMATF_S03' folder for project '<ProjectName>'
And create '<TemplateName>' template
And create '/F_AMATF_S03' folder for template '<TemplateName>'
When I go to the Library page for collection 'C2_AMATF_S03'NEWLIB
Then I '<Condition>' see projects '<SearchCriteria>' are available for selecting on Add Asset to Project popup while adding asset '<AssetName>' from collection 'C2_AMATF_S03' pageNEWLIB

Examples:
| TestedUser     | ProjectName   | TemplateName  | SearchCriteria | Condition  | FilePath            | AssetName    |
| TU_AMATF_S03_2 | P_AMATF_S03_2 | T_AMATF_S03_2 | T_AMATF_S03_2  | should not | /files/Fish1-Ad.mov | Fish1-Ad.mov |
| TU_AMATF_S03_1 | P_AMATF_S03_1 | T_AMATF_S03_1 | P_AMATF_S03_1  | should     | /files/Fish2-Ad.mov | Fish2-Ad.mov |




Scenario: Check that after adding autoshared asset into project it remains in Library
Meta:@gdam
     @library
Given I created the agency 'A_AMATF_S02_1' with default attributes
And created the agency 'A_AMATF_S02_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_AMATF_S02_2 | new-library-dev-version |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AMATF_S02 | agency.admin | A_AMATF_S02_1 |streamlined_library,library,folders|
| AU2_AMATF_S02 | agency.admin | A_AMATF_S02_2 |streamlined_library,library,folders|
| TU_AMATF_S02  | agency.admin | A_AMATF_S02_2 |streamlined_library,library,folders|
And logged in with details of 'AU1_AMATF_S02'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AMATF_S02' category
And added agency 'A_AMATF_S02_2' to category 'C1_AMATF_S02' on Asset Categories and Permissions page
And logged in with details of 'AU2_AMATF_S02'
When I go to the collections page
And I wait for '2' seconds
And I click shared collection 'C1_AMATF_S02' on the collection page for Agency 'A_AMATF_S02_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_AMATF_S02' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I create 'LR_AMATF_S02' role in 'library' group for advertiser 'A_AMATF_S02_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And I create 'C2_AMATF_S02' category
And I add users 'TU_AMATF_S02' to category 'C2_AMATF_S02' with role 'LR_AMATF_S02' by users details
And login with details of 'TU_AMATF_S02'
And I create 'P_AMATF_S02' project
And I create '/F_AMATF_S02' folder for project 'P_AMATF_S02'
And I go to the Library page for collection 'C2_AMATF_S02'NEWLIB
And I add following asset 'Fish1-Ad.mov' of collection 'C2_AMATF_S02' to project 'P_AMATF_S02' folder '/F_AMATF_S02'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'C2_AMATF_S02'NEWLIB
And 'should' see file 'Fish1-Ad.mov' on project 'P_AMATF_S02' folder '/F_AMATF_S02' files page

Scenario: Check that deletion autoshared asset in Library doesn't delete it from project
Meta:@gdam
     @library
Given I created the agency 'A_AMATF_S04_1' with default attributes
And created the agency 'A_AMATF_S04_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_AMATF_S04_2 | new-library-dev-version |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AMATF_S04 | agency.admin | A_AMATF_S04_1 |streamlined_library,library,folders|
| AU2_AMATF_S04 | agency.admin | A_AMATF_S04_2 |streamlined_library,library,folders|
| TU_AMATF_S04  | agency.admin | A_AMATF_S04_2 |streamlined_library,library,folders|
And logged in with details of 'AU1_AMATF_S04'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AMATF_S04' category
And added agency 'A_AMATF_S04_2' to category 'C1_AMATF_S04' on Asset Categories and Permissions page
And logged in with details of 'AU2_AMATF_S04'
When I go to the collections page
And I wait for '2' seconds
And I click shared collection 'C1_AMATF_S04' on the collection page for Agency 'A_AMATF_S04_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_AMATF_S04' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I create 'LR_AMATF_S04' role in 'library' group for advertiser 'A_AMATF_S04_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.delete               |
And create 'C2_AMATF_S04' category
And add users 'TU_AMATF_S04' to category 'C2_AMATF_S04' with role 'LR_AMATF_S04' by users details
And login with details of 'TU_AMATF_S04'
And create 'P_AMATF_S04' project
And create '/F_AMATF_S04' folder for project 'P_AMATF_S04'
And I go to the Library page for collection 'C2_AMATF_S04'NEWLIB
And I add following asset 'Fish1-Ad.mov' of collection 'C2_AMATF_S04' to project 'P_AMATF_S04' folder '/F_AMATF_S04'NEWLIB
And delete asset 'Fish1-Ad.mov' from collection 'C2_AMATF_S04' in LibraryNEWLIB
Then I 'should' see file 'Fish1-Ad.mov' on project 'P_AMATF_S04' folder '/F_AMATF_S04' files page
When I go to the Library page for collection 'C2_AMATF_S04'NEWLIB
Then 'should not' see assets 'Fish1-Ad.mov' in the collection 'C2_AMATF_S04'NEWLIB


Scenario: Check that autoshared asset can be added to folder where the same file is already exist
Meta:@gdam
     @library
Given I created the agency 'A_AMATF_S05_1' with default attributes
And created the agency 'A_AMATF_S05_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_AMATF_S05_2 | new-library-dev-version |
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AMATF_S05 | agency.admin | A_AMATF_S05_1 |streamlined_library,library,folders|
| AU2_AMATF_S05 | agency.admin | A_AMATF_S05_2 |streamlined_library,library,folders|
| TU_AMATF_S05  | agency.admin | A_AMATF_S05_2 |streamlined_library,library,folders|
And logged in with details of 'AU1_AMATF_S05'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AMATF_S05' category
And added agency 'A_AMATF_S05_2' to category 'C1_AMATF_S05' on Asset Categories and Permissions page
And logged in with details of 'AU2_AMATF_S05'
When I go to the collections page
And I wait for '2' seconds
And I click shared collection 'C1_AMATF_S05' on the collection page for Agency 'A_AMATF_S05_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_AMATF_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_AMATF_S05' role in 'library' group for advertiser 'A_AMATF_S05_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create 'C2_AMATF_S05' category
And add users 'TU_AMATF_S05' to category 'C2_AMATF_S05' with role 'LR_AMATF_S05' by users details
And login with details of 'TU_AMATF_S05'
And create 'P_AMATF_S05' project
And create '/F_AMATF_S05' folder for project 'P_AMATF_S05'
And upload '/files/Fish1-Ad.mov' file into '/F_AMATF_S05' folder for 'P_AMATF_S05' project
And wait while transcoding is finished in folder '/F_AMATF_S05' on project 'P_AMATF_S05' files page
And I go to the Library page for collection 'C2_AMATF_S05'NEWLIB
And I add following asset 'Fish1-Ad.mov' of collection 'C2_AMATF_S05' to project 'P_AMATF_S05' folder '/F_AMATF_S05'NEWLIB
And go to project 'P_AMATF_S05' folder '/F_AMATF_S05' page
Then I 'should' see files 'Fish1-Ad.mov,Fish1-Ad.mov' on project 'P_AMATF_S05' folder '/F_AMATF_S05' files page



