!--NGN-562 NGN-4247
Feature:          Library - Categories
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Library Categories


Scenario: Check that user have access to category when admin shared him to it
Meta:@gdam
      @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @library
	  @gdamcrossbrowser
Given I created users with following fields:
| Email      | Role        |Access|
| U_LCS_S2_1 | agency.user |streamlined_library|
And I created 'R_LCS_S2' role in 'library' group for advertiser 'DefaultAgency'
And I created following categories:
| Name         |
| AFC_LCS_S2_1 |
And I logged in with details of 'U_LCS_S2_1'
And I am on the Library page for collection 'My Assets'NEWLIB
When I go to the collections page
Then I 'should' see list of collections 'My Assets' on the collection pageNEWLIB
And I 'should not' see list of collections 'AFC_LCS_S2_1' on the collection pageNEWLIB
When I login as 'AgencyAdmin'
And I added next users for following categories:
| CategoryName | UserName   | RoleName |
| AFC_LCS_S2_1 | U_LCS_S2_1 | R_LCS_S2 |
And login with details of 'U_LCS_S2_1'
And I go to the Library page for collection 'My Assets'NEWLIB
And I go to the collections page
Then I 'should' see list of collections 'My Assets,AFC_LCS_S2_1' on the collection pageNEWLIB


Scenario: Check that renamed collection saves all filters
Meta:@gdam
@library
Given uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
And I switch 'on' media type filter '<Filter>' for collection '<CollectionName>' on the page LibraryNEWLIB
And I click on Save Changes button on the collection filter page
And I rename library collection '<CollectionName>' to '<RenamedCollectionName>' on collections details page
And I click on filter link on Collection details for collection '<RenamedCollectionName>'NEWLIB
Then I should see following 'MediaType' filter state for  '<RenamedCollectionName>' collectionNEWLIB:
| Filter  | State |
| <Filter>   | on  |
Examples:
| CollectionName | RenamedCollectionName | Filter   |
| C_LC_S7_1      | RC_LC_S7_1            | image    |
| C_LC_S7_2      | RC_LC_S7_2            | audio    |
| C_LC_S7_3      | RC_LC_S7_3            | video    |
| C_LC_S7_4      | RC_LC_S7_4            | print    |
| C_LC_S7_5      | RC_LC_S7_5            | digital  |
| C_LC_S7_6      | RC_LC_S7_6            | document |


Scenario: check ability to remove collection
Meta:@gdam
@library
Given I created following collections:
| Name         | ParentCategory |
| AFC_LCS_S6_1 | Everything     |
| AFC_LCS_S6_2 | Everything     |
| AFC_LCS_S6_3 | Everything     |
When I delete the collection 'AFC_LCS_S6_2' on collection details pageNEWLIB
And I delete the collection 'AFC_LCS_S6_3' on collection details pageNEWLIB
Then I 'should not' see list of collections 'AFC_LCS_S6_2,AFC_LCS_S6_3' on the collection pageNEWLIB


Scenario: Check that user from another agency doesn't see categories
Meta:@gdam
@library
Given I created users with following fields:
| Email   | Agency        | Role        |Access|
| U_LC_S9 | AnotherAgency | agency.user |streamlined_library,library|
And created following categories:
| Name    |
| C_LC_S9 |
When I login with details of 'U_LC_S9'
And I go to the collections page
Then I 'should not' see list of collections 'C_LC_S9' on the collection pageNEWLIB


Scenario: Check that user have access to category when admin added him to it
Meta:@gdam
@library
Given I created users with following fields:
| Email    |Access|
| U_LC_S10 |streamlined_library,library|
And created 'R_LC_S10' role in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name     |
| C_LC_S10 |
When I go to administration area collections page
And add users 'U_LC_S10' for category 'C_LC_S10' with role 'R_LC_S10'
And login with details of 'U_LC_S10'
And I go to the collections page
Then I 'should' see list of collections 'C_LC_S10' on the collection pageNEWLIB


Scenario: Check that user haven't access to category when admin deleted him from this category
Meta:@gdam
@library
Given I created users with following fields:
| Email    | Role       |Access|
| U_LC_S11 | agency.user |streamlined_library,library|
And created 'R_LC_S11' role in 'library' group for advertiser 'DefaultAgency'
And created following categories:
| Name     |
| C_LC_S11 |
When I go to administration area collections page
And add users 'U_LC_S11' for category 'C_LC_S11' with role 'R_LC_S11'
And remove users 'U_LC_S11' for category 'C_LC_S11'
And login with details of 'U_LC_S11'
And I go to the collections page
Then I 'should not' see list of collections 'C_LC_S11' on the collection pageNEWLIB


Scenario: Check that collection cannot be created with identical names
!--FAB-657
Meta:@gdam
     @bug
     @library
Given I created following collections:
| Name     |
| C_LC_S12 |
And I uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
Then I 'should' see warning message 'A collection with this name already exists' while adding assets to 'new' collection 'C_LC_S12' from collection 'Everything' NEWLIB


Scenario: Check that you can not create category with existing name
Meta:@gdam
@library
Given I created the agency 'A_LPTG_S2' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| U_LPTG_2 | agency.admin | A_LPTG_S2    |streamlined_library,library|
And logged in with details of 'U_LPTG_2'
And I uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_LPTG_1' from collection 'Everything'NEWLIB
And I wait for '3' seconds
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
Then I 'should' see warning message 'A collection with this name already exists' while adding assets to 'new' collection 'C_LPTG_1' from collection 'Everything' NEWLIB

Scenario: Check that you can create category with existing name on another level
Meta:@gdam
@library
Given I created the agency 'A_LPTG_S2' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| U_LPTG_2 | agency.admin | A_LPTG_S2    |streamlined_library,library|
And logged in with details of 'U_LPTG_2'
And I uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And on administration area collections page
And created 'C_LPTG_3' category
And I am on the Library page for collection 'C_LPTG_3'NEWLIB
When I switch 'on' media type filter 'video' for collection 'C_LPTG_3' on the page LibraryNEWLIB
And I select asset 'Fish Ad.mov' from filter pageNEWLIB
Then I 'should' see warning message 'New sub-collection created' while adding assets to 'sub' collection 'C_LPTG_3' from collection filter pageNEWLIB

Scenario: Check that user from another agency doesn't see assets in his category(Everything, My assets, custom category)
Meta:@gdam
@library
Given I created the agency 'A_LC_S13' with default attributes
And created users with following fields:
| Email       | Role       | AgencyUnique |Access|
| <UserEmail> | <UserRole> | A_LC_S13     |streamlined_library,library|
And created following categories:
| Name           |
| <CategoryName> |
And I am on collection '<CategoryName>' on administration area collections page
And switched 'on' media type filter '<Filter>' on administration area collections page
And clicked element 'SaveButton' on page 'AssetCategory'
And uploaded asset '<File>' into libraryNEWLIB
And I am on the Library page for collection '<CategoryName>'NEWLIB
And waited while transcoding is finished in collection '<CategoryName>'NEWLIB
When I login with details of '<UserEmail>'
Then I 'should not' see assets '<Asset>' in the collection '<CategoryType>'NEWLIB

Examples:
| CategoryName | UserEmail   | UserRole     | Filter   | Asset                | File                        |CategoryType|
| C_LC_S13_01  | U_LC_S13_01 | agency.admin | image    | logo3.jpg            | /files/logo3.jpg            |Everything|
| C_LC_S13_02  | U_LC_S13_02 | agency.admin | audio    | audio02.mp3          | /files/audio02.mp3          |Everything|
| C_LC_S13_03  | U_LC_S13_03 | agency.admin | video    | Fish Ad.mov          | /files/Fish Ad.mov          |Everything|
| C_LC_S13_04  | U_LC_S13_04 | agency.admin | print    | GWGTestfile064v3.pdf | /files/GWGTestfile064v3.pdf |Everything|
| C_LC_S13_05  | U_LC_S13_05 | agency.admin | digital  | index.html           | /files/index.html           |Everything|
| C_LC_S13_06  | U_LC_S13_06 | agency.admin | document | BDDStandards.doc     | /files/BDDStandards.doc     |Everything|
| C_LC_S13_07  | U_LC_S13_07 | agency.user  | image    | logo3.jpg            | /files/logo3.jpg            |My Assets|
| C_LC_S13_08  | U_LC_S13_08 | agency.user  | audio    | audio02.mp3          | /files/audio02.mp3          |My Assets|
| C_LC_S13_09  | U_LC_S13_09 | agency.user  | video    | Fish Ad.mov          | /files/Fish Ad.mov          |My Assets|
| C_LC_S13_10  | U_LC_S13_10 | agency.user  | print    | GWGTestfile064v3.pdf | /files/GWGTestfile064v3.pdf |My Assets|
| C_LC_S13_11  | U_LC_S13_11 | agency.user  | digital  | index.html           | /files/index.html           |My Assets|
| C_LC_S13_12  | U_LC_S13_12 | agency.user  | document | BDDStandards.doc     | /files/BDDStandards.doc     |My Assets|

Scenario: Check that user see suggestion when enter collection name
Meta: @skip
      @gdam



Scenario: Check that user can search collection by name (new search field)
!--NGN-9311
Meta: @skip
      @gdam
Given I created following collections:
| Name     | ParentCategory |
| C_LC_S15 |                |
| C_LC_S16 |                |
| C_LC_S17 | C_LC_S15       |
When I enter '<SearchText>' in search box
Then I 'should' be on collec
Examples:
| SearchText | Collection |
| C_LC_S15   |  C_LC_S15  |
| C_LC_S17   |  C_LC_S17  |



Scenario: Check that user can find shared by another BU collection
Meta: @skip
      @gdam



Scenario: Check search by second word in collection's name
!-- NGN-13036
Meta: @skip
      @gdam