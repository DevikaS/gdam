Feature:          Autosharing - add asset into presentation
Narrative:
In order to
As a              AgencyAdmin
I want to         Check ability to add autoshared asset to presenation

Scenario: Check that autoshared asset can be added to a new presentation
Meta:@gdam
     @library
Given I created the agency 'A_AAATP_S01_1' with default attributes
And created the agency 'A_AAATP_S01_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AAATP_S01 | agency.admin | A_AAATP_S01_1 |streamlined_library,presentations|
| AU2_AAATP_S01 | agency.admin | A_AAATP_S01_2 |streamlined_library,presentations|
| TU_AAATP_S01  | agency.admin | A_AAATP_S01_2 |streamlined_library,presentations|
And logged in with details of 'AU1_AAATP_S01'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AAATP_S01' category
And added agency 'A_AAATP_S01_2' to category 'C1_AAATP_S01' on Asset Categories and Permissions page
And logged in with details of 'AU2_AAATP_S01'
When I go to the collections page
And I go to the Shared Collection 'C1_AAATP_S01' from agency 'A_AAATP_S01_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_AAATP_S01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_AAATP_S01' role in 'library' group for advertiser 'A_AAATP_S01_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create 'C2_AAATP_S01' category
And add users 'TU_AAATP_S01' to category 'C2_AAATP_S01' with role 'LR_AAATP_S01' by users details
And I login with details of 'TU_AAATP_S01'
And go to the library page for collection 'C2_AAATP_S01'NEWLIB
And I add assets 'Fish1-Ad.mov' to new presentation 'P_AAATP_S01' from collection 'C2_AAATP_S01' pageNEWLIB
And go to the presentations assets page 'P_AAATP_S01'
Then I 'should' see presentation 'P_AAATP_S01' on the page
And 'should' see asset 'Fish1-Ad.mov' in the current presentation
And should see '1' assets in the current presentation


Scenario: Check that already existent autoshared asset in presentation can be added to this presentation again
Meta:@gdam
     @library
Given I created the agency 'A_AAATP_S02_1' with default attributes
And created the agency 'A_AAATP_S02_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AAATP_S02 | agency.admin | A_AAATP_S02_1 |streamlined_library,presentations|
| AU2_AAATP_S02 | agency.admin | A_AAATP_S02_2 |streamlined_library,presentations|
| TU_AAATP_S02  | agency.admin | A_AAATP_S02_2 |streamlined_library,presentations|
And logged in with details of 'AU1_AAATP_S02'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AAATP_S02' category
And added agency 'A_AAATP_S02_2' to category 'C1_AAATP_S02' on Asset Categories and Permissions page
And logged in with details of 'AU2_AAATP_S02'
When I go to the collections page
And I go to the Shared Collection 'C1_AAATP_S02' from agency 'A_AAATP_S02_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_AAATP_S02' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_AAATP_S02' role in 'library' group for advertiser 'A_AAATP_S02_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create 'C2_AAATP_S02' category
And add users 'TU_AAATP_S02' to category 'C2_AAATP_S02' with role 'LR_AAATP_S02' by users details
When I login with details of 'TU_AAATP_S02'
And go to the library page for collection 'C2_AAATP_S02'NEWLIB
And I add assets 'Fish1-Ad.mov' to new presentation 'P_AAATP_S02' from collection 'C2_AAATP_S02' pageNEWLIB
And go to the library page for collection 'C2_AAATP_S02'NEWLIB
And I add assets 'Fish1-Ad.mov' to existing presentations 'P_AAATP_S02' from collection 'C2_AAATP_S02' pageNEWLIB
And go to the presentations assets page 'P_AAATP_S02'
Then I should see count '2' assets 'Fish1-Ad.mov' in the current presentation


Scenario: Check that several autoshared assets can be added to a new presentation
Meta:@gdam
     @library
Given I created the agency 'A_AAATP_S03_1' with default attributes
And created the agency 'A_AAATP_S03_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AAATP_S03 | agency.admin | A_AAATP_S03_1 |streamlined_library,presentations|
| AU2_AAATP_S03 | agency.admin | A_AAATP_S03_2 |streamlined_library,presentations|
| TU_AAATP_S03  | agency.admin | A_AAATP_S03_2 |streamlined_library,presentations|
And logged in with details of 'AU1_AAATP_S03'
And uploaded following files into my libraryNEWLIB:
| Name               |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AAATP_S03' category
And added agency 'A_AAATP_S03_2' to category 'C1_AAATP_S03' on Asset Categories and Permissions page
And logged in with details of 'AU2_AAATP_S03'
When I go to the collections page
And I go to the Shared Collection 'C1_AAATP_S03' from agency 'A_AAATP_S03_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C1_AAATP_S03' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_AAATP_S03' role in 'library' group for advertiser 'A_AAATP_S03_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create  'C2_AAATP_S03' category
And add users 'TU_AAATP_S03' to category 'C2_AAATP_S03' with role 'LR_AAATP_S03' by users details
And I login with details of 'TU_AAATP_S03'
And go to the library page for collection 'C2_AAATP_S03'NEWLIB
And I add assets 'Fish1-Ad.mov,Fish2-Ad.mov' to new presentation 'P_AAATP_S03' from collection 'C2_AAATP_S03' pageNEWLIB
And go to the presentations assets page 'P_AAATP_S03'
Then I 'should' see presentation 'P_AAATP_S03' on the page
And 'should' see asset 'Fish1-Ad.mov,Fish2-Ad.mov' in the current presentation
And should see '2' assets in the current presentation


Scenario: Check that autoshared asset can be added to Existing presentation
Meta:@gdam
     @library
Given I created the agency 'A_AAATP_S04_1' with default attributes
And created the agency 'A_AAATP_S04_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AAATP_S04 | agency.admin | A_AAATP_S04_1 |streamlined_library,presentations|
| AU2_AAATP_S04 | agency.admin | A_AAATP_S04_2 |streamlined_library,presentations|
| TU_AAATP_S04  | agency.admin | A_AAATP_S04_2 |streamlined_library,presentations|
And logged in with details of 'AU1_AAATP_S04'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AAATP_S04' category
And added agency 'A_AAATP_S04_2' to category 'C1_AAATP_S04' on Asset Categories and Permissions page
And logged in with details of 'AU2_AAATP_S04'
When I go to the collections page
And I go to the Shared Collection 'C1_AAATP_S04' from agency 'A_AAATP_S04_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_AAATP_S04' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_AAATP_S04' role in 'library' group for advertiser 'A_AAATP_S04_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create 'C2_AAATP_S04' category
And add users 'TU_AAATP_S04' to category 'C2_AAATP_S04' with role 'LR_AAATP_S04' by users details
When I login with details of 'TU_AAATP_S04'
And create following reels:
| Name        | Description |
| P_AAATP_S04 | description |
And go to the library page for collection 'C2_AAATP_S04'NEWLIB
And I add assets 'Fish1-Ad.mov' to existing presentations 'P_AAATP_S04' from collection 'C2_AAATP_S04' pageNEWLIB
And go to the presentations assets page 'P_AAATP_S04'
Then I 'should' see presentation 'P_AAATP_S04' on the page
And 'should' see asset 'Fish1-Ad.mov' in the current presentation
And should see '1' assets in the current presentation


Scenario: Check that several autoshared assets can be added to several existent presentations
Meta:@gdam
     @library
Given I created the agency 'A_AAATP_S05_1' with default attributes
And created the agency 'A_AAATP_S05_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AAATP_S05 | agency.admin | A_AAATP_S05_1 |streamlined_library,presentations|
| AU2_AAATP_S05 | agency.admin | A_AAATP_S05_2 |streamlined_library,presentations|
| TU_AAATP_S05  | agency.admin | A_AAATP_S05_2 |streamlined_library,presentations|
And logged in with details of 'AU1_AAATP_S05'
And uploaded following files into my libraryNEWLIB:
| Name               |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AAATP_S05' category
And added agency 'A_AAATP_S05_2' to category 'C1_AAATP_S05' on Asset Categories and Permissions page
And logged in with details of 'AU2_AAATP_S05'
When I go to the collections page
And I go to the Shared Collection 'C1_AAATP_S05' from agency 'A_AAATP_S05_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C1_AAATP_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_AAATP_S05' role in 'library' group for advertiser 'A_AAATP_S05_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
And create 'C2_AAATP_S05' category
And add users 'TU_AAATP_S05' to category 'C2_AAATP_S05' with role 'LR_AAATP_S05' by users details
When I login with details of 'TU_AAATP_S05'
And create following reels:
| Name          | Description |
| P_AAATP_S05_1 | description |
| P_AAATP_S05_2 | description |
And go to the library page for collection 'C2_AAATP_S05'NEWLIB
And I add assets 'Fish1-Ad.mov,Fish2-Ad.mov' to existing presentations 'P_AAATP_S05_1' from collection 'C2_AAATP_S05' pageNEWLIB
And go to the library page for collection 'C2_AAATP_S05'NEWLIB
And I add assets 'Fish1-Ad.mov,Fish2-Ad.mov' to existing presentations 'P_AAATP_S05_2' from collection 'C2_AAATP_S05' pageNEWLIB
And go to the presentations assets page 'P_AAATP_S05_1'
Then I 'should' see asset 'Fish1-Ad.mov,Fish2-Ad.mov' in the current presentation
And should see '2' assets in the current presentation
When I go to the presentations assets page 'P_AAATP_S05_2'
Then I 'should' see asset 'Fish1-Ad.mov,Fish2-Ad.mov' in the current presentation
And should see '2' assets in the current presentation


Scenario: Check availability of autoshared asset in reel if this asset was deleted from category
Meta:@gdam
     @library
Given I created the agency 'A_AAATP_S06_1' with default attributes
And created the agency 'A_AAATP_S06_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| AU1_AAATP_S06 | agency.admin | A_AAATP_S06_1 |streamlined_library,presentations|
| AU2_AAATP_S06 | agency.admin | A_AAATP_S06_2 |streamlined_library,presentations|
| TU_AAATP_S06  | agency.admin | A_AAATP_S06_2 |streamlined_library,presentations|
And logged in with details of 'AU1_AAATP_S06'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C1_AAATP_S06' category
And added agency 'A_AAATP_S06_2' to category 'C1_AAATP_S06' on Asset Categories and Permissions page
And logged in with details of 'AU2_AAATP_S06'
When I go to the collections page
And I go to the Shared Collection 'C1_AAATP_S06' from agency 'A_AAATP_S06_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C1_AAATP_S06' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'LR_AAATP_S06' role in 'library' group for advertiser 'A_AAATP_S06_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.delete               |
And create 'C2_AAATP_S06' category
And add users 'TU_AAATP_S06' to category 'C2_AAATP_S06' with role 'LR_AAATP_S06' by users details
When I login with details of 'TU_AAATP_S06'
And go to the library page for collection 'C2_AAATP_S06'NEWLIB
And I add assets 'Fish1-Ad.mov' to new presentation 'P_AAATP_S06' from collection 'C2_AAATP_S06' pageNEWLIB
And remove asset 'Fish1-Ad.mov' from 'C2_AAATP_S06' collection
And go to the presentations assets page 'P_AAATP_S06'
Then I 'should' see asset 'Fish1-Ad.mov' in the current presentation
And should see '1' assets in the current presentation
When go to the library page for collection 'C2_AAATP_S06'NEWLIB
Then 'should not' see assets 'Fish1-Ad.mov' in the collection 'C2_AAATP_S06'NEWLIB




