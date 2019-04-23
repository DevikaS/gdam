Feature:          Collections is hierarchicaly
Narrative:
In order to
As a              AgencyAdmin
I want to check that child collections is hierarchical and based on parent collections


Scenario:  check that is possible to use same Filter in Child as it is used in Parent
!-- NGN-8319 Hierarchical Collection: it should be possible to use same Filter in Child as it is used in Parent
Meta:@gdam
      @library
Given I created following categories:
| Name          | MediaType |
| CCAA_Nøæ"&_C1 | video     |
And I am on collection 'CCAA_Nøæ"&_C1' on administration area collections page
When I create collection 'CCAA_Nøæ"&_C1_S1' based on collection 'CCAA_Nøæ"&_C1' on administration area with following metadata:
| key | value |
And I go to collection 'CCAA_Nøæ"&_C1_S1' on administration area collections page
Then I should see collection 'CCAA_Nøæ"&_C1_S1' is child of collection 'CCAA_Nøæ"&_C1' on administration area collections page
And I should see media type filter 'video' is in state 'on' on administration area collection page



Scenario: check that delete collection is not appear
!-- NGN-8298 Library collection: after deleting collection is still appear
Meta:@gdam
      @library
Given I created 'CCAA_C2' category
And I created child category 'CCAA_C2_S1' of category 'CCAA_C2'
And I am on collection 'CCAA_C2_S1' on administration area collections page
When I click element 'DeleteButton' on page 'Categories'
And click element 'Delete' on page 'DeletePopUp'
Then I should see following collections on administration area collections page:
| CategoryName | Should     |
| CCAA_C2      | should     |
| CCAA_C2_S1   | should not |


Scenario: check sharing parents collection to internal user
Meta:@gdam
      @library
Given I created users with following fields:
| Email       | Role        |Access|
| <UserEmail> | agency.user |streamlined_library,library|
And I created '<ParentCategory>' category
And I created child category '<ChildCategory>' of category '<ParentCategory>'
And added users '<UserEmail>' for category '<SharedCategory>' with role 'library.user'
When I login with details of '<UserEmail>'
And I go to the collections page
Then I '<APCVisibilityCondition>' see series of sub collections '<ParentCategory>' under agency 'DefaultAgency'NEWLIB
Then I '<ACCVisibilityCondition>' see series of sub collections '<ChildCategory>' under agency 'DefaultAgency'NEWLIB

Examples:
| UserEmail    | ParentCategory | ChildCategory | SharedCategory | APCVisibilityCondition | ACCVisibilityCondition |
| U_CCAA_S01_2 | PC_CCAA_S01_2  | CC_CCAA_S01_2 | CC_CCAA_S01_2  | should not             | should                 |
| U_CCAA_S01_1 | PC_CCAA_S01_1  | CC_CCAA_S01_1 | PC_CCAA_S01_1  | should                 | should                 |

Scenario: Check that shared asset is available in shared collection on base of category
Meta:@gdam
      @library
Given I created the agency 'CCAA_1' with default attributes
And created the agency 'CCAA_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| CCAA_2 | new-library-dev-version |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| CCAA_U1 | agency.admin | CCAA_1 |streamlined_library,library|
| CCAA_U2 | agency.admin | CCAA_2 |streamlined_library,library|
And logged in with details of 'CCAA_U1'
And created following categories:
| Name    | MediaType | MediaSubType  |
| CCAA_C3 | video     | Cinema Master |
And uploaded file '/files/Fish6-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name         | SubType       |
| Fish6-Ad.mov | Cinema Master |
And shared next agencies for following categories:
| CategoryName | AgencyName    |
| CCAA_C3      | CCAA_2 |
And logged in with details of 'CCAA_U2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'CCAA_C3' from agency 'CCAA_1' pageNEWLIB
And I select asset 'Fish6-Ad.mov' for collection 'CCAA_C3' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create following categories:
| Name      | MediaType | MediaSubType  |
| CCAA_C3_1 | video     | Cinema Master |
And I go to the collections page
And I go to the library page for collection 'CCAA_C3_1'NEWLIB
Then I 'should' see assets with titles 'Fish6-Ad.mov' in the collection 'CCAA_C3_1'NEWLIB

Scenario: check that if child was shared without parent, filters in present
Meta:@gdam
      @library
Given I created users with following fields:
| Email   | Role        |Access|
| CCAA_U4 | agency.user |streamlined_library,library|
And created following categories:
| Name    | MediaType |
| CCAA_C4 | video     |
And I created child category 'CCAA_C4_S4' of category 'CCAA_C4'
And added users 'CCAA_U4' for category 'CCAA_C4_S4' with role 'library.user'
When I login with details of 'CCAA_U4'
And I go to  Library page for collection 'CCAA_C4_S4'NEWLIB
And I click on filter link on Collection details for collection 'CCAA_C4_S4'NEWLIB
Then I should see following filter state for collection 'CCAA_C4_S4' NEWLIB:
| Filter | State |
| video  | on    |
