!--NGN-4729 NGN-2298
Feature:          Unshare or delete category to agency
Narrative:
In order to
As a              AgencyAdmin
I want to         Check unsharing or deleting shared category

Scenario: Check that Removing agency from category correctly works
Meta:@gdam
@library
Given I created following categories:
| Name       | Advertiser    |
| C_UDSC_S01 | DefaultAgency |
When I shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_UDSC_S01   | AnotherAgency |
And go to administration area collections page
And remove agency 'AnotherAgency' for category 'C_UDSC_S01'
Then I 'should not' see agency 'AnotherAgency' in the agencies list for current category
And 'should' see selected 'C_UDSC_S01' at LHS on Asset Categories and Permissions page


Scenario: Check that assets from unshared category are available for agency which it was shared
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S02_1 | agency.admin | A_UDSC_1 |streamlined_library|
| U_UDSC_S02_2 | agency.admin | A_UDSC_2 |streamlined_library|
And logged in with details of 'U_UDSC_S02_1'
And created 'C_UDSC_S02_1' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName |
| C_UDSC_S02_1 | A_UDSC_2   |
And logged in with details of 'U_UDSC_S02_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_UDSC_S02_1' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UDSC_S02_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'C_UDSC_S02_2' category
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB
When go to the Library page for collection 'C_UDSC_S02_2'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'C_UDSC_S02_2'NEWLIB
When I login with details of 'U_UDSC_S02_1'
And go to administration area collections page
And remove agency 'A_UDSC_2' for category 'C_UDSC_S02_1'
And login with details of 'U_UDSC_S02_2'
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB
When go to the Library page for collection 'C_UDSC_S02_2'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'C_UDSC_S02_2'NEWLIB



Scenario: Check that assets from deleted category are available for agency which it was shared
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S03_1 | agency.admin | A_UDSC_1 |streamlined_library|
| U_UDSC_S03_2 | agency.admin | A_UDSC_2 |streamlined_library|
And logged in with details of 'U_UDSC_S03_1'
And created 'C_UDSC_S03_1' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName |
| C_UDSC_S03_1 | A_UDSC_2   |
And logged in with details of 'U_UDSC_S03_2'
When I go to the collections page
And I go to the Shared Collection 'C_UDSC_S03_1' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UDSC_S03_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'C_UDSC_S03_2' category
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB
When go to the Library page for collection 'C_UDSC_S03_2'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'C_UDSC_S03_2'NEWLIB
When I login with details of 'U_UDSC_S03_1'
And remove category 'C_UDSC_S03_1' from Collection page in admin area
And login with details of 'U_UDSC_S03_2'
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB
When go to the Library page for collection 'C_UDSC_S03_2'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'C_UDSC_S03_2'NEWLIB


Scenario: Check that assets from unshared category can be found using global search in agency which it was shared
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S04_1 | agency.admin | A_UDSC_1 |streamlined_library,dashboard|
| U_UDSC_S04_2 | agency.admin | A_UDSC_2 |streamlined_library,dashboard|
And logged in with details of 'U_UDSC_S04_1'
And created 'C_UDSC_S04' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName |
| C_UDSC_S04   | A_UDSC_2   |
And logged in with details of 'U_UDSC_S04_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_UDSC_S04' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_UDSC_S04' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I login with details of 'U_UDSC_S04_1'
And remove agency 'A_UDSC_2' for category 'C_UDSC_S04'
And login with details of 'U_UDSC_S04_2'
And I go to Dashboard page
And search by text 'mov'
Then I 'should' see search object 'Fish1-Ad' with type 'Assets' after wrap according to search 'Fish' with 'Name' type
And 'should' see search object 'Fish2-Ad' with type 'Assets' after wrap according to search 'Fish' with 'Name' type



Scenario: Check that assets from deleted category can be found using global search in agency which it was shared
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S05_1 | agency.admin | A_UDSC_1 |streamlined_library,dashboard|
| U_UDSC_S05_2 | agency.admin | A_UDSC_2 |streamlined_library,dashboard|
And logged in with details of 'U_UDSC_S05_1'
And created 'C_UDSC_S05' category
And uploaded file '/files/Fish3-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish4-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName |
| C_UDSC_S05   | A_UDSC_2   |
And logged in with details of 'U_UDSC_S05_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_UDSC_S05' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish3-Ad.mov,Fish4-Ad.mov' for collection 'C_UDSC_S05' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I login with details of 'U_UDSC_S05_1'
And remove category 'C_UDSC_S05' from Collection page in admin area
And login with details of 'U_UDSC_S05_2'
And I go to Dashboard page
And search by text 'mov'
Then I 'should' see search object 'Fish3-Ad' with type 'Assets' after wrap according to search 'Fish' with 'Name' type
And 'should' see search object 'Fish4-Ad' with type 'Assets' after wrap according to search 'Fish' with 'Name' type



Scenario: Check that assets from unshared category can be found using global search by assigned user in agency which it was shared
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S12_1 | agency.admin | A_UDSC_1 |streamlined_library,dashboard|
| U_UDSC_S12_2 | agency.admin | A_UDSC_2 |streamlined_library,dashboard|
| U_UDSC_S12_3 | guest.user   | A_UDSC_2 |streamlined_library,dashboard|
And created 'LR_USDSC_S12' role with 'asset_filter_category.read,asset.read' permissions in 'library' group for advertiser 'A_UDSC_2'
And logged in with details of 'U_UDSC_S12_1'
And created 'C_UDSC_S12_1' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_UDSC_S12_1 | A_UDSC_2 |
And logged in with details of 'U_UDSC_S12_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_UDSC_S12_1' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_UDSC_S12_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'C_UDSC_S12_2' category
And upload file '/files/Fish3-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I add users 'U_UDSC_S12_3' for category 'C_UDSC_S12_2' with role 'LR_USDSC_S12'
And login with details of 'U_UDSC_S12_1'
And remove agency 'A_UDSC_2' for category 'C_UDSC_S12_1'
And login with details of 'U_UDSC_S12_3'
And I go to Dashboard page
And search by text 'mov'
Then I 'should' see search object 'Fish1-Ad' with type 'Assets' after wrap according to search 'Fish' with 'Name' type
And 'should' see search object 'Fish2-Ad' with type 'Assets' after wrap according to search 'Fish' with 'Name' type
And 'should' see search object 'Fish3-Ad' with type 'Assets' after wrap according to search 'Fish' with 'Name' type


Scenario: Check that assets from deleted category can be found using global search by assigned user in agency which it was shared
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S13_1 | agency.admin | A_UDSC_1 |streamlined_library,dashboard|
| U_UDSC_S13_2 | agency.admin | A_UDSC_2 |streamlined_library,dashboard|
| U_UDSC_S13_3 | guest.user   | A_UDSC_2 |streamlined_library,dashboard|
And created 'LR_USDSC_S13' role with 'asset_filter_category.read,asset.read' permissions in 'library' group for advertiser 'A_UDSC_2'
And logged in with details of 'U_UDSC_S13_1'
And created 'C_UDSC_S13_1' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| C_UDSC_S13_1 | A_UDSC_2 |
And logged in with details of 'U_UDSC_S13_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_UDSC_S13_1' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_UDSC_S13_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create 'C_UDSC_S13_2' category
And upload file '/files/Fish3-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I add users 'U_UDSC_S13_3' for category 'C_UDSC_S13_2' with role 'LR_USDSC_S13'
And login with details of 'U_UDSC_S13_1'
And I go to administration area collections page
And remove category 'C_UDSC_S13_1' from Collection page in admin area
And login with details of 'U_UDSC_S13_3'
And I go to Dashboard page
And search by text 'mov'
Then I 'should' see search object 'Fish1-Ad.mov' with type 'Assets' after wrap according to search 'mov' with 'Name' type
And 'should' see search object 'Fish2-Ad.mov' with type 'Assets' after wrap according to search 'mov' with 'Name' type
And 'should' see search object 'Fish3-Ad.mov' with type 'Assets' after wrap according to search 'mov' with 'Name' type


Scenario: Check of availability asset in presentation from unshared category
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S06_1 | agency.admin | A_UDSC_1 |streamlined_library|
| U_UDSC_S06_2 | agency.admin | A_UDSC_2 |streamlined_library,presentations|
And logged in with details of 'U_UDSC_S06_1'
And created 'C_UDSC_S06' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName |
| C_UDSC_S06   | A_UDSC_2   |
And logged in with details of 'U_UDSC_S06_2'
When I go to the collections page
And I go to the Shared Collection 'C_UDSC_S06' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UDSC_S06' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
When I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I add assets 'Fish1-Ad.mov' to new presentation 'P_UDSC_S06' from collection 'Everything' pageNEWLIB
And login with details of 'U_UDSC_S06_1'
And remove agency 'A_UDSC_2' for category 'C_UDSC_S06'
And login with details of 'U_UDSC_S06_2'
Then I 'should' see assets 'Fish1-Ad.mov' in presentation 'P_UDSC_S06'



Scenario: Check of availability asset in presentation from deleted category
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S07_1 | agency.admin | A_UDSC_1 |streamlined_library|
| U_UDSC_S07_2 | agency.admin | A_UDSC_2 |streamlined_library,presentations|
And logged in with details of 'U_UDSC_S07_1'
And created 'C_UDSC_S07' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName |
| C_UDSC_S07   | A_UDSC_2   |
And logged in with details of 'U_UDSC_S07_2'
When I go to the collections page
And I go to the Shared Collection 'C_UDSC_S07' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UDSC_S07' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I add assets 'Fish1-Ad.mov' to new presentation 'P_UDSC_S07' from collection 'Everything' pageNEWLIB
And login with details of 'U_UDSC_S07_1'
And go to administration area collections page
And remove category 'C_UDSC_S07' from Collection page in admin area
And login with details of 'U_UDSC_S07_2'
And go to the presentations assets page 'P_UDSC_S07'
Then I 'should' see asset 'Fish1-Ad.mov' in the current presentation


Scenario: Check that user can open asset in presentation from unshared category
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S08_1 | agency.admin | A_UDSC_1 |streamlined_library|
| U_UDSC_S08_2 | agency.admin | A_UDSC_2 |streamlined_library,presentations|
And logged in with details of 'U_UDSC_S08_1'
And created 'C_UDSC_S08' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName |
| C_UDSC_S08   | A_UDSC_2   |
And logged in with details of 'U_UDSC_S08_2'
When I go to the collections page
And I go to the Shared Collection 'C_UDSC_S08' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UDSC_S08' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I add assets 'Fish1-Ad.mov' to new presentation 'P_UDSC_S08' from collection 'Everything' pageNEWLIB
And login with details of 'U_UDSC_S08_1'
And remove agency 'A_UDSC_2' for category 'C_UDSC_S08'
And login with details of 'U_UDSC_S08_2'
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' be on the asset info pageNEWLIB


Scenario: Check that user can open asset in presentation from deleted category
Meta:@gdam
@library
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S09_1 | agency.admin | A_UDSC_1 |streamlined_library|
| U_UDSC_S09_2 | agency.admin | A_UDSC_2 |streamlined_library,presentations|
And logged in with details of 'U_UDSC_S09_1'
And created 'C_UDSC_S09' category
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName |
| C_UDSC_S09   | A_UDSC_2   |
And logged in with details of 'U_UDSC_S09_2'
When I go to the collections page
And I go to the Shared Collection 'C_UDSC_S09' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UDSC_S09' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I add assets 'Fish1-Ad.mov' to new presentation 'P_UDSC_S09' from collection 'Everything' pageNEWLIB
And login with details of 'U_UDSC_S09_1'
And remove category 'C_UDSC_S09' from Collection page in admin area
And login with details of 'U_UDSC_S09_2'
And I go to asset 'Fish1-Ad.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' be on the asset info pageNEWLIB


Scenario: Check that assets from unshared category can be found using advanced search in agency which it was shared(with media sub type)
Meta:@gdam
@library
!--In new lib,Filter wont be applicable for pinned assets.This is As Designed
Given I created the agency 'A_UDSC_1' with default attributes
And created the agency 'A_UDSC_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S10_1 | agency.admin | A_UDSC_1 |streamlined_library|
| U_UDSC_S10_2 | agency.admin | A_UDSC_2 |streamlined_library|
And logged in with details of 'U_UDSC_S10_1'
And created '<CategoryName>' category
And uploaded following files into my libraryNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/GWGTest2.pdf |
| /files/logo2.png    |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets':
| Name         | SubType      |
| Fish1-Ad.mov | Rushes |
And go to asset 'logo2.png' info page in Library for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets':
| Name         | SubType      |
| logo2.png | Print |
And shared next agencies for following categories:
| CategoryName   | AgencyName |
| <CategoryName> | A_UDSC_2   |
And login with details of 'U_UDSC_S10_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection '<CategoryName>' from agency 'A_UDSC_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov,GWGTest2.pdf,logo2.png' for collection '<CategoryName>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And login with details of 'U_UDSC_S10_1'
And remove agency 'A_UDSC_2' for category '<CategoryName>'
And login with details of 'U_UDSC_S10_2'
And go to the library page for collection 'Everything'NEWLIB
When I select asset 'Fish1-Ad.mov,Fish2-Ad.mov,GWGTest2.pdf,logo2.png' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
And I switch on media type filter '<MediaType>' from collection '<CollectionName>'NEWLIB
When I select mediaSubType '<MediaSubType>' of '<MediaType>' for collection '<CollectionName>' on the page LibraryNEWLIB
When I click on Save Changes button on the collection filter page
Then I 'should' see assets '<AssetsInclude>' in the collection '<CollectionName>'NEWLIB
And I 'should' see assets '<AssetsExclude>' in the collection '<CollectionName>'NEWLIB
Examples:
| MediaType   | MediaSubType | CategoryName | CollectionName |AssetsInclude|AssetsExclude|
| video       | Rushes       |  C_UDSC_S10_3 | C_UDSC_S10_3   |Fish1-Ad.mov|Fish2-Ad.mov,GWGTest2.pdf,logo2.png|



Scenario: Check that assets from unshared category can be found using advanced search in agency which it was shared(without media sub type)
Meta:@gdam
@library
!--In new lib,Filter wont be applicable for pinned assets collection
Given I created the agency 'A_UDSC_11' with default attributes
And created the agency 'A_UDSC_12' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S10_1 | agency.admin | A_UDSC_11 |streamlined_library|
| U_UDSC_S10_2 | agency.admin | A_UDSC_12 |streamlined_library|
And logged in with details of 'U_UDSC_S10_1'
And created '<CategoryName>' category
And uploaded following files into my libraryNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/GWGTest2.pdf |
| /files/logo2.png    |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | SubType      |
| Fish1-Ad.mov | Rushes |
And go to asset 'logo2.png' info page in Library for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | SubType      |
| logo2.png | Print |
And shared next agencies for following categories:
| CategoryName   | AgencyName |
| <CategoryName> | A_UDSC_12   |
And login with details of 'U_UDSC_S10_2'
When I go to the collections page
And accept all assets on Shared Collection '<CategoryName>' from agency 'A_UDSC_11' pageNEWLIB
And login with details of 'U_UDSC_S10_1'
And remove agency 'A_UDSC_12' for category '<CategoryName>'
And login with details of 'U_UDSC_S10_2'
And go to the library page for collection 'Everything'NEWLIB
When I select asset 'Fish1-Ad.mov,Fish2-Ad.mov,GWGTest2.pdf,logo2.png' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
And I switch on media type filter '<MediaType>' from collection '<CollectionName>'NEWLIB
When I select mediaSubType '<MediaSubType>' of '<MediaType>' for collection '<CollectionName>' on the page LibraryNEWLIB
When I click on Save Changes button on the collection filter page
And go to the library page for collection '<CollectionName>'NEWLIB
Then I 'should' see assets '<AssetsExclude>' in the collection '<CollectionName>'NEWLIB
And I 'should' see assets '<AssetsInclude>' in the collection '<CollectionName>'NEWLIB
Examples:
| MediaType   | MediaSubType |  CategoryName | CollectionName |AssetsInclude|AssetsExclude|
| video       |              |  C_UDSC_S10_11 | C_UDSC_S10_11 |Fish1-Ad.mov,Fish2-Ad.mov|GWGTest2.pdf,logo2.png|

Scenario: Check that assets from deleted category can be found using advanced search in agency which it was shared(without media sub type)
Meta:@gdam
@library
!--In new lib, filter wont be applicable for pinned assets
Given I created the agency 'A_UDSC_3' with default attributes
And created the agency 'A_UDSC_4' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S11_1 | agency.admin | A_UDSC_3 |streamlined_library|
| U_UDSC_S11_2 | agency.admin | A_UDSC_4 |streamlined_library|
And logged in with details of 'U_UDSC_S11_1'
And created '<CategoryName>' category
And uploaded following files into my libraryNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/GWGTest2.pdf |
| /files/logo2.png    |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets':
| Name         | SubType      |
| Fish1-Ad.mov | Rushes |
And go to asset 'logo2.png' info page in Library for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets':
| Name         | SubType      |
| logo2.png | Print |
And shared next agencies for following categories:
| CategoryName   | AgencyName |
| <CategoryName> | A_UDSC_4   |
And login with details of 'U_UDSC_S11_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection '<CategoryName>' from agency 'A_UDSC_3' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov,GWGTest2.pdf,logo2.png' for collection '<CategoryName>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And login with details of 'U_UDSC_S11_1'
And remove category '<CategoryName>' from Collection page in admin area
And login with details of 'U_UDSC_S11_2'
And go to the library page for collection 'Everything'NEWLIB
When I select asset 'Fish1-Ad.mov,Fish2-Ad.mov,GWGTest2.pdf,logo2.png' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
And I switch on media type filter '<MediaType>' from collection '<CollectionName>'NEWLIB
When I select mediaSubType '<MediaSubType>' of '<MediaType>' for collection '<CollectionName>' on the page LibraryNEWLIB
When I click on Save Changes button on the collection filter page
Then I 'should' see assets '<AssetsInclude>' in the collection '<CollectionName>'NEWLIB
And I 'should' see assets '<AssetsExclude>' in the collection '<CollectionName>'NEWLIB

Examples:
| MediaType   | MediaSubType |  CategoryName | CollectionName |AssetsInclude|AssetsExclude|
| print       |              |  C_UDSC_S11_2 | C_UDSC_S11_2   |GWGTest2.pdf|Fish1-Ad.mov,Fish2-Ad.mov,logo2.png|




Scenario: Check that assets from deleted category can be found using advanced search in agency which it was shared(with media sub type)
Meta:@gdam
@library
!--In new lib,Filter wont be applicable for pinned assets.This is As Designed
Given I created the agency 'A_UDSC_31_1' with default attributes
And created the agency 'A_UDSC_41_1' with default attributes
And created users with following fields:
| Email        | Role         | Agency   |Access|
| U_UDSC_S11_11 | agency.admin | A_UDSC_31_1 |streamlined_library|
| U_UDSC_S11_21 | agency.admin | A_UDSC_41_1 |streamlined_library|
And logged in with details of 'U_UDSC_S11_11'
And created '<CategoryName>' category
And uploaded following files into my libraryNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/GWGTest2.pdf |
| /files/logo2.png    |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets':
| Name         | SubType      |
| Fish1-Ad.mov | Rushes |
And go to asset 'logo2.png' info page in Library for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets':
| Name         | SubType      |
| logo2.png | Print |
And shared next agencies for following categories:
| CategoryName   | AgencyName |
| <CategoryName> | A_UDSC_41_1   |
And login with details of 'U_UDSC_S11_21'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection '<CategoryName>' from agency 'A_UDSC_31_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov,GWGTest2.pdf,logo2.png' for collection '<CategoryName>' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And login with details of 'U_UDSC_S11_11'
And remove category '<CategoryName>' from Collection page in admin area
And login with details of 'U_UDSC_S11_21'
And go to the library page for collection 'Everything'NEWLIB
When I select asset 'Fish1-Ad.mov,Fish2-Ad.mov,GWGTest2.pdf,logo2.png' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
And I switch on media type filter '<MediaType>' from collection '<CollectionName>'NEWLIB
When I select mediaSubType '<MediaSubType>' of '<MediaType>' for collection '<CollectionName>' on the page LibraryNEWLIB
When I click on Save Changes button on the collection filter page
Then I 'should' see assets '<AssetsInclude>' in the collection '<CollectionName>'NEWLIB
And I 'should' see assets '<AssetsExclude>' in the collection '<CollectionName>'NEWLIB

Examples:
| MediaType   | MediaSubType |CategoryName | CollectionName |AssetsInclude|AssetsExclude|
| video       | Rushes       | C_UDSC_S11_3 | C_UDSC_S11_3   |Fish1-Ad.mov|GWGTest2.pdf,Fish2-Ad.mov,logo2.png|





