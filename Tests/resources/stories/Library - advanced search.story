!--NGN-897
Feature:          Library - advanced search
Narrative:
In order to
As a              AgencyAdmin
I want to         Check library advanced search filters



Scenario: when 'asset_filter_collection.create' permission is disabled, advanced search in library should be hidden
Meta:@gdam
@library
Given I created '<GlobalRole>' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| enum.read    |
| role.read    |
| user.read    |
| asset.create |
| <Permission> |
And created users with following fields:
| Email       | Role         |
| <UserEmail> | <GlobalRole> |
And logged in with details of '<UserEmail>'
When I go to the library page
Then I '<Condition>' see advanced search panel on the library page

Examples:
| UserEmail   | GlobalRole  | Permission                     | Condition  |
| U_LAS_S02_1 | R_LAS_S02_1 | asset_filter_collection.create | should     |
| U_LAS_S02_2 | R_LAS_S02_2 |                                | should not |


Scenario: correct selection of newly created collection from the collections list
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @library
Given I created users with following fields:
| Email     | Role         |Access|
| U_LAS_S04 | agency.admin |streamlined_library|
And logged in with details of 'U_LAS_S04'
And created following collections:
| Name        | MediaType | MediaSubType |
| C_LAS_S04_1 | image     | print        |
| C_LAS_S04_2 | video     |              |
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And uploaded file '/files/image11.jpg' into my libraryNEWLIB
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And uploaded file '/files/Fish-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish5-Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'image10.jpg,image11.jpg,128_shortname.jpg,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov'NEWLIB
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name              | SubType |
| image10.jpg       | Print   |
| image11.jpg       | Print   |
| 128_shortname.jpg | Print   |
And go to the Library page for collection 'C_LAS_S04_1'NEWLIB
Then I 'should' see assets 'image10.jpg,image11.jpg,128_shortname.jpg' in the collection 'C_LAS_S04_1'NEWLIB
And 'should not' see assets 'Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov' in the collection 'C_LAS_S04_1'NEWLIB
When go to the Library page for collection 'C_LAS_S04_2'NEWLIB
Then I 'should' see assets 'Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov' in the collection 'C_LAS_S04_2'NEWLIB
And 'should not' see assets 'image10.jpg,image11.jpg,128_shortname.jpg' in the collection 'C_LAS_S04_2'NEWLIB



Scenario: check additional Media sub-types for video
Meta:@gdam
@library
Given I created the agency '<Agency>' with default attributes
And I created 'testrole' role with 'asset.create,asset.write,dictionary.add_on_the_fly,asset_filter_collection.create,asset_filter_category.create' permissions in 'project' group for advertiser '<Agency>'
And created users with following fields:
| Email     | Role         | Agency    |Access|
| U_LAS_S05 | testrole     | <Agency> |streamlined_library|
And logged in with details of 'U_LAS_S05'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue      |
| Account Director   | Test Account   |
| Copywriter         | Hankey      |
| Screen             | Spot            |
| Clock number             | Clk87            |
And 'save' asset 'Fish2-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName          | FieldValue        |
| Account Director   | Test Acc        |
| Copywriter         | Hankey        |
| Screen             | Trailer           |
| Clock number             | Clk878            |
And go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I select 'Business Unit' with value '<Agency>' as filter collection 'My Assets'NEWLIB
And I switch 'on' media type filter 'VIDEO' on filter page
And add additional filter as filter collection:
|Additional Field            | value                     |
| Account Director           |       <AccountDirector>          |
And I add assets to 'sub' collection '<CollectionName>' from collection 'My Assets'NEWLIB
Then I 'should' see assets '<AssetName>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<AssetsCount>' in '<CollectionName>' NEWLIB
Examples:
| CollectionName | AccountDirector          | AssetName                 | AssetsCount           |Agency           |
| C_LAS_S05_1    | Test Account             | Fish1-Ad.mov              | 1                     |  A_LAS_S05_1    |


Scenario: Check that Agency Producer, Country of Broadcast, JCN Number, RACC Approval fields are available only for audio media type
Meta:@gdam
@library
Given I am on the library page for collection 'Everything'NEWLIB
And I have refreshed the page
When I switch on media type filter '<Filter>' from collection 'Everything'NEWLIB
Then I '<Condition>' see following metadata keys in the 'Add more fields' drop-down menu for filter '<Filter>' from current collection filter pageNEWLIB:
| FieldName      | FieldValue                     |
| Add more fields | Agency Producer,Country of Broadcast,JCN Number,RACC Approval|
Examples:
| Filter   | Condition  |
| audio    | should     |
| video    | should not |
| print    | should not |

Scenario: Check that Location/Studio, Photographer, Retoucher, Shoot Date, Studio Name fields are available only for print media type
Meta:@gdam
@library
Given I am on the library page for collection 'Everything'NEWLIB
And I have refreshed the page
When I switch on media type filter '<Filter>' from collection 'Everything'NEWLIB
Then I '<Condition>' see following metadata keys in the '<FieldName>' drop-down menu for filter '<Filter>' from current collection filter pageNEWLIB:
| FieldName      | FieldValue                     |
| Add more fields | Location/Studio,Photographer,Retoucher,Shoot Date,Studio Name|
Examples:
| Filter   | Condition  |
| print    | should     |
| audio    | should not |
| video    | should not |


Scenario: Check that special fields are available only for video media type
Meta:@gdam
@library
Given I am on the library page for collection 'Everything'NEWLIB
And I have refreshed the page
When I switch on media type filter '<Filter>' from collection 'Everything'NEWLIB
Then I '<Condition>' see following metadata keys in the '<FieldName>' drop-down menu for filter '<Filter>' from current collection filter pageNEWLIB:
| FieldName      | FieldValue                     |
| Add more fields | 2D Artists,2D Lead Artists,2D Supervisor,3D Artists,3D Lead Artists,Agency Job reference,Agency TV Producer,Animation company,Animator,Assist,Colourist,Costume Designer,Director,Director of Photography,Edit Assistant,Edit company,Editor,Film Processing Lab,Head of TV,ID Film (ARPP Users only),Make up Artist,Matte Painting|
Examples:
| Filter   | Condition  |
| video    | should     |
| print    | should not |
| audio    | should not |



Scenario: Check that hidden fields are not available for advance search
Meta:@gdam
@library
Given I am on the library page for collection 'Everything'NEWLIB
When I switch on media type filter '<Filter>' from collection 'Everything'NEWLIB
Then I '<Condition>' see following metadata keys in the '<FieldName>' drop-down menu for filter '<Filter>' from current collection filter pageNEWLIB:
| FieldName      | FieldValue                     |
| Add more fields |Artist,Client,Client,Client supervisor,Designer,Director of advertising production,Executive producer,Film editor,Keywords,Lighting cameraman,Made by,Post house,Year,Sound designer,Volume,Writer,Written location|

Examples:
| Filter   |Condition  |
| audio    |should not |
| video    |should not |
| print    |should not |



Scenario: search for that asset which has been received through partner, but originally created in some other BU which is not partner of current BU
Meta:@gdam
@library
Given I created the agency 'A_LAS_S14_1' with default attributes
And created the agency 'A_LAS_S14_2' with default attributes
And created the agency 'A_LAS_S14_3' with default attributes
And created users with following fields:
| Email       | Role         | Agency      |Access|
| U_LAS_S14_1 | agency.admin | A_LAS_S14_1 |streamlined_library|
| U_LAS_S14_2 | agency.admin | A_LAS_S14_2 |streamlined_library|
| U_LAS_S14_3 | agency.admin | A_LAS_S14_3 |streamlined_library|
And logged in with details of 'U_LAS_S14_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_LAS_S14_1' category
And shared next agencies for following categories:
| CategoryName | AgencyName  |
| C_LAS_S14_1  | A_LAS_S14_2 |
And logged in with details of 'U_LAS_S14_2'
And I am on the collections page
When I go to the Shared Collection 'C_LAS_S14_1' from agency 'A_LAS_S14_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_LAS_S14_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And create 'C_LAS_S14_2' category
And shared next agencies for following categories:
| CategoryName | AgencyName  |
| C_LAS_S14_2  | A_LAS_S14_3 |
And login with details of 'U_LAS_S14_3'
And I go to the collections page
And I go to the Shared Collection 'C_LAS_S14_2' from agency 'A_LAS_S14_2' pageNEWLIB
And I select asset 'Fish2-Ad.mov' for collection 'C_LAS_S14_2' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish3-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to the library page for collection 'Everything'NEWLIB
And I click on filter link for collection 'Everything'
And I select 'Originator' with value 'A_LAS_S14_1' as filter collection 'Everything'NEWLIB
And I switch 'on' media type filter 'VIDEO' on filter page
And I add assets to 'new' collection 'C_LAS_S14_3' from collection 'Everything'NEWLIB
Then I 'should not' see assets 'Fish1-Ad.mov' in the collection 'C_LAS_S14_3'NEWLIB
And I 'should' see assets 'Fish2-Ad.mov,Fish3-Ad.mov' in the collection 'C_LAS_S14_3'NEWLIB


Scenario: shared assets by collections should be in search result
Meta:@gdam
@library
Given I created the agency 'A_LAS_S15_1' with default attributes
And created the agency 'A_LAS_S15_2' with default attributes
And created users with following fields:
| Email       | Role         | Agency      |Access|
| U_LAS_S15_1 | agency.admin | A_LAS_S15_1 |streamlined_library|
| U_LAS_S15_2 | agency.admin | A_LAS_S15_2 |streamlined_library|
And logged in with details of 'U_LAS_S15_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_LAS_S15_1' category
And shared next agencies for following categories:
| CategoryName | AgencyName  |
| C_LAS_S15_1  | A_LAS_S15_2 |
And logged in with details of 'U_LAS_S15_2'
And I am on the collections page
When I go to the Shared Collection 'C_LAS_S15_1' from agency 'A_LAS_S15_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_LAS_S15_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And upload file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to the library page for collection 'Everything'NEWLIB
And I click on filter link for collection 'Everything'
And I select 'Originator' with value 'A_LAS_S15_1' as filter collection 'Everything'NEWLIB
And I switch 'on' media type filter 'VIDEO' on filter page
And I add assets to 'new' collection 'C_LAS_S15_2' from collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish1-Ad.mov' in the collection 'C_LAS_S15_2'NEWLIB
And I 'should not' see assets 'Fish2-Ad.mov' in the collection 'C_LAS_S15_2'NEWLIB

Scenario: shared assets by public should not be in search results
Meta:@gdam
@library
Given I created the agency 'A_LAS_S16_1' with default attributes
And created the agency 'A_LAS_S16_2' with default attributes
And created users with following fields:
| Email       | Role         | Agency      |Access|
| U_LAS_S16_1 | agency.admin | A_LAS_S16_1 |streamlined_library|
| U_LAS_S16_2 | agency.admin | A_LAS_S16_2 |streamlined_library|
And logged in with details of 'U_LAS_S16_1'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I am on the library page for collection 'My Assets'NEWLIB
When I send public link of asset 'Fish1-Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails  | Message |
| U_LAS_S16_2 | hi dude |
And login with details of 'U_LAS_S16_2'
And I go to the library page for collection 'Everything'NEWLIB
And I click on filter link for collection 'Everything'
And I select 'Originator' with value 'A_LAS_S16_1' as filter collection 'Everything'NEWLIB
And I switch 'on' media type filter 'VIDEO' on filter page
And I add assets to 'new' collection 'C_LAS_S16' from collection 'Everything'NEWLIB
Then I 'should not' see assets 'Fish1-Ad.mov' in the collection 'C_LAS_S16'NEWLIB

Scenario: shared assets by secure should not be in search results
Meta:@gdam
@library
Given I created the agency 'A_LAS_S17_1' with default attributes
And created the agency 'A_LAS_S17_2' with default attributes
And created users with following fields:
| Email       | Role         | Agency      |Access|
| U_LAS_S17_1 | agency.admin | A_LAS_S17_1 |streamlined_library|
| U_LAS_S17_2 | agency.admin | A_LAS_S17_2 |streamlined_library|
And logged in with details of 'U_LAS_S17_1'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added secure share for asset 'Fish1-Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails  | ExpireDate |
| U_LAS_S17_2 | 12.12.2021 |
When I login with details of 'U_LAS_S17_2'
And I go to the library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I select 'Originator' with value 'A_LAS_S17_1' as filter collection 'My Assets'NEWLIB
And I switch 'on' media type filter 'VIDEO' on filter page
And I add assets to 'sub' collection 'C_LAS_S17' from collection 'My Assets'NEWLIB
Then I 'should not' see assets 'Fish1-Ad.mov' in the collection 'C_LAS_S17'NEWLIB


Scenario: Check creation collection based on 'Other' media filter
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And I am on  Library pageNEWLIB
And uploaded following assetsNEWLIB:
| Name               |
| /files/example.rar |
| /files/logo3.png   |
| /files/test6.jar   |
| /files/Fish Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'example.rar,logo3.png,test6.jar,Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_LAS_S18' from collection 'Everything'NEWLIB
When I switch on media type filter 'other' from collection 'C_LAS_S18'NEWLIB
Then I 'should' see assets 'example.rar,test6.jar' in the collection 'C_LAS_S18'NEWLIB


