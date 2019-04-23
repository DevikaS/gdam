!--NGN-1052 NGN-4827
Feature:          Library - Delete assets
Narrative:
In order to
As a              AgencyAdmin
I want to         Check asset delete and restore in Library



Scenario: Check that user with 'library admin' role can delete asset
Meta:@gdam
@library
Given I created the agency 'A_LDA_S27' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |Access            |
| U_LDA_S26_1 | agency.admin | A_LDA_S27    |streamlined_library  |
| U_LDA_S26_2 | agency.user  | A_LDA_S27    |streamlined_library  |
And logged in with details of 'U_LDA_S26_1'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created following categories:
| Name      | MediaType |
| C_LDA_S26 | video     |
And added users 'U_LDA_S26_2' for category 'C_LDA_S26' with role 'library.admin'
When I login with details of 'U_LDA_S26_2'
And go to Library page for collection 'C_LDA_S26'NEWLIB
And wait for '2' seconds
And remove asset 'Fish Ad.mov' from 'C_LDA_S26' collection
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'C_LDA_S26'NEWLIB


Scenario: Check that asset can be removed from collection
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
When upload file '/files/128_shortname.jpg' into my libraryNEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And I select asset '128_shortname.jpg' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_LAATC_S03' from collection 'Everything'NEWLIB
And I select asset '128_shortname.jpg' in the 'C_LAATC_S03'  library pageNEWLIB
And I remove asset in 'C_LAATC_S03' library page
Then I 'should not' see assets '128_shortname.jpg' in the collection 'C_LAATC_S03'NEWLIB



Scenario: Check that cancel works in remove from collection popup
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
When upload file '/files/128_shortname.jpg' into my libraryNEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And I select asset '128_shortname.jpg' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_CRFC_S01' from collection 'Everything'NEWLIB
And I select asset '128_shortname.jpg' in the 'C_CRFC_S01'  library pageNEWLIB
And I  cancel asset from 'C_CRFC_S01' library page
Then I 'should' see assets '128_shortname.jpg' in the collection 'C_CRFC_S01'NEWLIB


Scenario: Check that deleted asset not appears in filter results
Meta:@gdam
@library
Given I created the agency 'A_LDA_S25' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |Access            |
| U_LDA_S25 | agency.admin | A_LDA_S25    |streamlined_library  |
And logged in with details of 'U_LDA_S25'
When upload file '/files/128_shortname.jpg' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to the Library page for collection 'My Assets'NEWLIB
And remove asset '128_shortname.jpg' from 'My Assets' collection
And I click on filter link for collection 'My Assets'
And I switch 'on' media type filter 'image' on filter page
Then I 'should not' see assets '128_shortname.jpg' in the collection 'My Assets'NEWLIB


Scenario: Check that guest and agency users is able to remove own assets from 'My assets' collection
Meta:@gdam
@library
Given I created the agency 'A_LDA_S17' with default attributes
And created users with following fields:
| Email     | Role        | AgencyUnique |Access               |
| U_LDA_S17 | agency.user | A_LDA_S17    |streamlined_library  |
And logged in with details of 'U_LDA_S17'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And removed asset 'Fish Ad.mov' from 'My Assets' collection
And waited for '5' seconds
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'My Assets'NEWLIB

Scenario: Check that Agency Admin can remove asset from library and the asset no longer exists in library
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
 /files/Fish1-Ad.mov         |
| /files/test.mp3            |
| /files/128_shortname.jpg   |
| /files/video10s.avi        |
And I am on the Library page for collection 'Everything'NEWLIB
And selected asset '<Assets>' in the 'Everything' library pageNEWLIB
And I removed asset in 'Everything' library page
Then I 'should not' see assets '<Assets>' in the collection 'Everything'NEWLIB
And I 'should' see assets '<AssetsInclude>' in the collection 'Everything'NEWLIB

Examples:
|Assets            | AssetsInclude                                |
|Fish1-Ad.mov      |  test.mp3,128_shortname.jpg,video10s.avi     |


Scenario: check that Assets can be Removed from the Collection only and the asset doesn't get deleted from the Library
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish1-Ad.mov,test.mp3' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'С_ACTC_S01' from collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov,test.mp3' in the collection 'С_ACTC_S01'NEWLIB
When I remove asset 'test.mp3' within 'С_ACTC_S01' collection
Then I 'should not' see assets 'test.mp3' in the collection 'С_ACTC_S01'NEWLIB
When I go to  library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'test.mp3' in the collection 'Everything'NEWLIB

Scenario: Check that asset can be remved from collection
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
When upload file '/files/128_shortname.jpg' into my libraryNEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And I refresh the page
And I select asset '128_shortname.jpg' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_LAATC_S03' from collection 'Everything'NEWLIB
And I wait for '2' seconds
And go to the Library page for collection 'C_LAATC_S03'NEWLIB
And I refresh the page
And I select asset '128_shortname.jpg' in the 'C_LAATC_S03'  library pageNEWLIB
And I remove asset in 'C_LAATC_S03' library page
Then I 'should not' see assets '128_shortname.jpg' in the collection 'C_LAATC_S03'NEWLIB


Scenario: Check that user with asset.delete permission can delete asset from category in library
Meta:@gdam
@library
Given I created the agency 'A_LDA_S01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| AU_LDA_S01 | agency.admin | A_LDA_S01    |streamlined_library,library|
And logged in with details of 'AU_LDA_S01'
And created 'R_LDA_S01' role with 'asset.delete,asset.create' permissions in 'library' group for advertiser 'A_LDA_S01'
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_LDA_S01 | agency.user  | A_LDA_S01    |streamlined_library,library|
And created following categories:
| Name      |
| C_LDA_S01 |
And I am on administration area collections page
And added users 'U_LDA_S01' for category 'C_LDA_S01' with role 'R_LDA_S01'
And logged in with details of 'U_LDA_S01'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I am on the library page for collection 'C_LDA_S01'NEWLIB
When I remove asset 'Fish Ad.mov' from 'C_LDA_S01' collection
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'C_LDA_S01'NEWLIB

Scenario: Check that user with asset.delete permission can delete asset from collection in library
Meta:@gdam
@library
Given I created the agency 'A_LDA_S02' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| AU_LDA_S02 | agency.admin | A_LDA_S02    |streamlined_library,library|
And logged in with details of 'AU_LDA_S02'
Given I created 'R_LDA_S02' role in 'global' group for advertiser 'A_LDA_S02' with following permissions:
| Permission                     |
| asset.delete                   |
| asset.create                   |
| asset_filter_collection.create |
And created users with following fields:
| Email      | Role        | AgencyUnique |Access|
| U_LDA_S02  | R_LDA_S02   | A_LDA_S02    |streamlined_library,library|
And logged in with details of 'U_LDA_S02'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
When I switch 'on' media type filter 'video' for collection 'My Assets' on the page LibraryNEWLIB
And I select asset 'Fish Ad.mov' from filter pageNEWLIB
And I click on 'sub' option on the collection filter page
And I type collection name 'C_LDA_S02' and save on opened 'sub' collection popup from filter pageNEWLIB
And I wait for '5' seconds
And I remove asset 'Fish Ad.mov' from 'C_LDA_S02' collection
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'C_LDA_S02'NEWLIB

Scenario: Check that user with asset.delete permission can delete asset from filter results
Meta:@gdam
@library
Given I created the agency 'A_LDA_S03' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| AU_LDA_S03 | agency.admin | A_LDA_S03    |streamlined_library,library|
And logged in with details of 'AU_LDA_S03'
And created 'R_LDA_S03' role with 'asset.create,asset_filter_collection.create' permissions in 'global' group for advertiser 'A_LDA_S03'
And created users with following fields:
| Email      | Role      | AgencyUnique |Access|
| U_LDA_S03  | R_LDA_S03 | A_LDA_S03    |streamlined_library,library|
And logged in with details of 'U_LDA_S03'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I switched 'on' media type filter 'video' for collection 'My Assets' on the page LibraryNEWLIB
And I selected asset 'Fish Ad.mov' from filter pageNEWLIB
When I remove asset 'Fish Ad.mov' from filter pageNEWLIB
Then I 'should not' see assets 'Fish Ad.mov' in the filter pageNEWLIB


Scenario: Check that user with asset.delete permission can delete asset from asset details
Meta:@gdam
@library
Given I created the agency 'A_LDA_S04' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| AU_LDA_S04 | agency.admin | A_LDA_S04    |streamlined_library,library|
And logged in with details of 'AU_LDA_S04'
And created 'R_LDA_S04' role with 'asset.delete,asset.create' permissions in 'global' group for advertiser 'A_LDA_S04'
And created users with following fields:
| Email      | Role      | AgencyUnique |Access|
| U_LDA_S04  | R_LDA_S04 | A_LDA_S04    |streamlined_library,library|
And logged in with details of 'U_LDA_S04'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
When I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I delete the asset from asset info pageNEWLIB
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'My Assets'NEWLIB


Scenario: Check that user without asset.delete permission can delete asset in library
Meta:@gdam
@library
Given I created the agency 'A_LDA_S05' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| AU_LDA_S05 | agency.admin | A_LDA_S05    |streamlined_library,library|
And logged in with details of 'AU_LDA_S05'
And created 'R_LDA_S05' role with 'asset.create' permissions in 'global' group for advertiser 'A_LDA_S05'
And created users with following fields:
| Email      | Role      | AgencyUnique |Access|
| U_LDA_S05  | R_LDA_S05 | A_LDA_S05    |streamlined_library,library|
And logged in with details of 'U_LDA_S05'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I selected asset 'Fish Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I 'should' see remove asset confirmation popup for collection 'My Assets' on opened library page NEWLIB


Scenario: Check that user without asset.delete permission can delete asset from asset details
Meta:@gdam
@library
Given I created the agency 'A_LDA_S06' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| AU_LDA_S06 | agency.admin | A_LDA_S06    |streamlined_library,library|
And logged in with details of 'AU_LDA_S06'
And created 'R_LDA_S06' role with 'asset.create' permissions in 'global' group for advertiser 'A_LDA_S06'
And created users with following fields:
| Email      | Role      | AgencyUnique |Access|
| U_LDA_S06  | R_LDA_S06 | A_LDA_S06    |streamlined_library,library|
And logged in with details of 'U_LDA_S06'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see remove asset confirmation popup on asset info page NEWLIB


Scenario: Check that Asset added to several collections and categories after removing not appears in all
Meta:@gdam
@library
Given I created the agency 'A_LDA_S24' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_LDA_S24 | agency.admin | A_LDA_S24    |streamlined_library,library|
And logged in with details of 'U_LDA_S24'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov'NEWLIB
And created following categories:
| Name        |
| C_LDA_S24_1 |
And I am on the Library page for collection 'Everything'NEWLIB
And I selected asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I added assets to 'new' collection 'C_LDA_S24_2' from collection 'Everything'NEWLIB
When I go to the Library page for collection 'Everything'NEWLIB
And I remove asset 'Fish Ad.mov' from 'Everything' collection
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'Everything'NEWLIB
When I go to the Library page for collection 'C_LDA_S24_2'NEWLIB
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'C_LDA_S24_2'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the Library page for collection 'C_LDA_S24_1'NEWLIB
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'C_LDA_S24_1'NEWLIB

Scenario: Check that deleted asset cannot be searched in library global search
Meta:@gdam
@library
Given I created the agency 'A_LDA_S08' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| AU_LDA_S08 | agency.admin | A_LDA_S08    |streamlined_library|
And logged in with details of 'AU_LDA_S08'
And created 'R_LDA_S08' role with 'asset.delete,asset.create' permissions in 'global' group for advertiser 'A_LDA_S08'
And created users with following fields:
| Email      | Role      | AgencyUnique |Access|
| U_LDA_S08  | R_LDA_S08 | A_LDA_S08    |streamlined_library|
And logged in with details of 'U_LDA_S08'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
And I remove asset 'Fish Ad.mov' from 'My Assets' collection
When I enter input 'Fish Ad' on global search pageNEWLIB
Then I 'should not' see assets 'Fish Ad.mov' in the global search pageNEWLIB


Scenario: Check that 'Trash' in library accessible only as agency.admin user
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role       | Agency        |Access|
| <UserEmail> | <UserRole> | DefaultAgency |streamlined_library|
And logged in with details of '<UserEmail>'
When I go to the collections page
And I wait for '1' seconds
Then I '<Condition>' see trash on collection pageNEWLIB

Examples:
| UserEmail   | UserRole     | Condition  |
| U_LDA_S10_1 | agency.admin | should     |
| U_LDA_S10_2 | agency.user  | should not |



Scenario: Check that 'Trash' in library not accessible by user without trash.read permission
Meta:@gdam
@library
Given I created 'R_LDA_S11' role with 'asset_filter_category.read,asset.create' permissions in 'global' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email      | Role      | Access  | Agency        |Access|
| U_LDA_S11  | R_LDA_S11 | library | DefaultAgency |streamlined_library|
And logged in with details of 'U_LDA_S11'
When I go to the collections page
Then I 'should not' see trash on collection pageNEWLIB

Scenario: Check removing file with same name that already available in trash bin
Meta:@gdam
@library
Given I created the agency 'A_LDA_S18' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_LDA_S18 | agency.admin | A_LDA_S18    |streamlined_library|
And logged in with details of 'U_LDA_S18'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And selected asset 'Fish Ad.mov' in the 'My Assets' library pageNEWLIB
And I removed asset in 'My Assets' library page
And I am on the Library page for collection 'My Assets'NEWLIB
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And selected asset 'Fish Ad.mov' in the 'My Assets' library pageNEWLIB
And I removed asset in 'My Assets' library page
When I go to library trash pageNEWLIB
Then I 'should' see asset count '2' in the library trash pageNEWLIB


Scenario: Check upload asset to library with same name that already available in trash bin
Meta:@gdam
@library
Given I created the agency 'A_LDA_S19' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_LDA_S19 | agency.admin | A_LDA_S19 |streamlined_library|
And logged in with details of 'U_LDA_S19'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'Fish Ad.mov' in the 'My Assets' library pageNEWLIB
And I removed asset in 'My Assets' library page
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the collection 'My Assets'NEWLIB
When I go to library trash pageNEWLIB
Then I 'should' see assets with titles 'Fish Ad.mov' in the library trash pageNEWLIB


Scenario: Check that deleted asset cannot be edited
Meta:@gdam
@library
Given I created the agency 'A_LDA_S21' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_LDA_S21 | agency.admin | A_LDA_S21 |streamlined_library|
And logged in with details of 'U_LDA_S21'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And on the Library page for collection 'My Assets'NEWLIB
And selected asset 'Fish Ad.mov' in the 'My Assets' library pageNEWLIB
And I removed asset in 'My Assets' library page
When I go to library trash pageNEWLIB
And I click asset 'Fish Ad.mov' on library trash pageNEWLIB
Then I 'should not' see Edit link on opened asset info pageNEWLIB

Scenario: Check metadata of deleted asset
Meta:@gdam
@library
Given I created the agency 'A_LDA_S22' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_LDA_S22 | agency.admin | A_LDA_S22    |streamlined_library|
And logged in with details of 'U_LDA_S22'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
When I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue  |
| Title     | Fish Ad.mov |
When I go to the Library page for collection 'My Assets'NEWLIB
And select asset 'Fish Ad.mov' in the 'My Assets' library pageNEWLIB
And I remove asset in 'My Assets' library page
And I go to library trash pageNEWLIB
And I click asset 'Fish Ad.mov' on library trash pageNEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue  |
| Title     | Fish Ad.mov |


Scenario: Check playout of deleted asset
Meta:@gdam
     @bug
     @library
!--UIR-1028
Given I created the agency 'A_LDA_S23' with default attributes
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| U_LDA_S23 | agency.admin | A_LDA_S23    |streamlined_library|
And logged in with details of 'U_LDA_S23'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And waited while preview is visible on library page for collection 'My Assets' for asset 'Fish Ad.mov'NEWLIB
And selected asset 'Fish Ad.mov' in the 'My Assets' library pageNEWLIB
And I removed asset in 'My Assets' library page
And I am on library trash pageNEWLIB
When I click asset 'Fish Ad.mov' on library trash pageNEWLIB
Then I 'should' be able to play clip on opened asset info pageNEWLIB

