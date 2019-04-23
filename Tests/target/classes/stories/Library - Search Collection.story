Feature:          Library - Search Collection
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Searching of Collections on the Collection Page

Lifecycle:
Before:
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov |
| /files/test.mp3            |
| /files/test.ogg            |
And created following collectionsNEWLIB:
| Name          | MediaType | AssetName    |
| C_AASC_S01_1  | video     | Fish1-Ad.mov |
| C_AASC_S01_2  | audio     | test.mp3     |



Scenario: check that new collections are created under My Assets and My Assets can be set as Home Collection
Meta:@gdam
@library
!--QA-1000
!--QA-1031
Given I created the agency 'A_NCMA_S01_1' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access               |
| U_NCMA_S01_1 | agency.admin | A_NCMA_S01_1 | streamlined_library  |
And logged in with details of 'U_NCMA_S01_1'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
And created following collectionsNEWLIB:
| Name          | MediaType | AssetName    | ParentCategory   |
| C_NCMA_S01_1  | video     | Fish1-Ad.mov | My Assets        |
| C_NCMA_S01_2  | audio     | test.mp3     |  My Assets        |
When I go to the collections page
And I 'set' the collection My Assets as home collection on collections page
When I go to the collections page
Then I 'should' see on the library page sub collections 'C_NCMA_S01_1,C_NCMA_S01_2' under parent collection 'My Assets'NEWLIB
When I go to  library pageNEWLIB
And I click Collection Tab on library page
Then I 'should' see collection 'Collections>My Assets' in breadcrum on collections pageNEWLIB

Scenario: check that breadcrum is displayed correctly on clicking the collection in collection tree and you can edit the collection name
Meta:@gdam
@library
!--QA-993
Given I created the agency 'A_BDEC_S01_1' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access               |
| U_BDEC_S01_1 | agency.admin | A_BDEC_S01_1 | streamlined_library  |
And logged in with details of 'U_BDEC_S01_1'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
And created following collectionsNEWLIB:
| Name          | MediaType | AssetName    |
| C_BDEC_S01_1  | video     | Fish1-Ad.mov |
| C_BDEC_S01_2  | audio     | test.mp3     |
When I go to the collections page
Then I 'should' see on the library page parent collections 'My Collections,My Assets'NEWLIB
Then I 'should' see on the library page collections 'C_BDEC_S01_1,C_BDEC_S01_2'NEWLIB
When click 'C_BDEC_S01_1' in collection tree
Then I 'should' see collection  'Collections>C_BDEC_S01_1' in breadcrum on collections pageNEWLIB
When I edit the collection 'C_BDEC_S01_1' to new name 'C_BDEC' in collections details page
Then I 'should' see collection  'Collections>C_BDEC' in breadcrum on collections details pageNEWLIB


Scenario: check that you can search for a Collection by a partial match
Meta:@gdam
@library
When I go to the collections page
And I search the collection 'C_AASC_S01' on collections page
Then I 'should' see on the library page collections 'C_AASC_S01_1,C_AASC_S01_2'NEWLIB
When I search the collection 'C_AB' on collections page
Then I 'should not' see on the library page collections 'C_AASC_S01_1,C_AASC_S01_2'NEWLIB
And should see on the library page collections message 'No matches found'


Scenario: check that assets are displayed according to which collection in selected on the Collection page
Meta:@gdam
@library
When I go to the collections page
And I search the collection 'C_AASC_S01_1' on collections page
And I click the collection 'C_AASC_S01_1' on collections page
And wait for '1' seconds
Then 'should' see assets with titles 'Fish1-Ad.mov' in the collection page
When I search the collection 'C_AASC_S01_2' on collections page
And I click the collection 'C_AASC_S01_2' on collections page
And wait for '1' seconds
Then 'should' see assets with titles 'test.mp3,test.ogg' in the collection page

Scenario: check that collection search results are retained on navigating to Asset Info page
Meta:@gdam
@library
When I go to the collections page
And I search the collection 'C_AASC_S01_1' on collections page
And I click the collection 'C_AASC_S01_1' on collections page
And I go to asset 'Fish1-Ad.mov' page from 'C_AASC_S01_1' in collection page
And click back to library Button on asset info page
And I click the collection 'C_AASC_S01_1' on collections page
Then 'should' see assets with titles 'Fish1-Ad.mov' in the collection page



Scenario: check that once the search is cleared all the collections are listed once again
Meta:@gdam
@library
When I go to the collections page
And I search the collection 'C_AASC_S01_1' on collections page
Then I 'should' see on the library page collections 'C_AASC_S01_1'NEWLIB
When I clear the search criteria in collection page
Then I 'should' see on the library page sub collections 'C_AASC_S01_1,C_AASC_S01_2' under agency 'DefaultAgency'NEWLIB


Scenario: Check that collections are listed based upon permission collection filter read
Meta:@gdam
@library
Given I created the agency 'A_AASC_S01_1' with default attributes
And created the agency 'A_AASC_S01_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access             |
| U_ACTA_S08_1 | agency.admin | A_AASC_S01_1 |streamlined_library |
| U_ACTA_S08_2 | agency.admin | A_AASC_S01_2 |streamlined_library |
| <UserEmail>  | <GlobalRole> | A_AASC_S01_2 |streamlined_library |
| <Usermail2>  | <GlobalRole> | A_AASC_S01_2 |streamlined_library |
And logged in with details of 'U_ACTA_S08_1'
And created following categories:
| Name         | MediaType |
| C_ACTA_S08_1 | video     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'Everything'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName   |
| C_ACTA_S08_1 | A_AASC_S01_2 |
And logged in with details of 'U_ACTA_S08_2'
And accepted all assets on Shared Collection 'C_ACTA_S08_1' from agency 'A_AASC_S01_1' pageNEWLIB
And created 'LR_ACTA_S01' role with 'file.download' permissions in 'global' group for advertiser 'A_AASC_S01_2'
And created 'LR_ACTA_S02' role with 'asset_filter_category.read,asset.read' permissions in 'global' group for advertiser 'A_AASC_S01_2'
And created following categories:
| Name         | MediaType |
| C_ACTA_S08_2 | video     |
And added next users for following categories:
| CategoryName | UserName    | RoleName    |
| C_ACTA_S08_2 | <UserEmail> | LR_ACTA_S01 |
| C_ACTA_S08_2 | <Usermail2> | LR_ACTA_S02 |
When login with details of '<UserEmail>'
And I go to the collections page
And I search the collection 'C_ACTA_S08_2' on collections page
Then I 'should not' see on the library page collections 'C_ACTA_S08_2'NEWLIB
When login with details of '<Usermail2>'
And I go to the collections page
And I search the collection 'C_ACTA_S08_2' on collections page
Then I 'should' see on the library page collections 'C_ACTA_S08_2'NEWLIB


Examples:
| UserEmail     | GlobalRole  | Usermail2      |
| TU_ACTA_S08_1 | agency.user |  TU_ACTA_S08_2 |

Scenario: check that breadcrum is displayed correctly on clicking the collection in collection tree
Meta:@gdam
@library
Given I created the agency 'A_BDC_S01_1' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access               |
| U_BDC_S01_1 | agency.admin | A_BDC_S01_1 | streamlined_library  |
And logged in with details of 'U_BDC_S01_1'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
And created following collectionsNEWLIB:
| Name          | MediaType | AssetName    |
| C_BDC_S01_1  | video     | Fish1-Ad.mov |
| C_BDC_S01_2  | audio     | test.mp3     |
When I go to the collections page
Then I 'should' see on the library page parent collections 'My Collections,My Assets'NEWLIB
Then I 'should' see on the library page sub collections 'C_BDC_S01_1,C_BDC_S01_2' under agency 'A_BDC_S01_1'NEWLIB
When I search the collection 'C_BDC_S01_1' on collections page
And I click the collection 'C_BDC_S01_1' on collections page
Then I 'should' see collection  'Collections>C_BDC_S01_1' in breadcrum on collections page


Scenario: check that user can remove collection from the Collection Details page
Meta:@gdam
@library
Given I created the agency 'A_CRMCD_S01_1' with default attributes
And created users with following fields:
| Email         | Role          | Agency        | Access               |
| U_CRMCD_S01_1 | agency.admin  | A_CRMCD_S01_1 | streamlined_library  |
And logged in with details of 'U_CRMCD_S01_1'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add asset to 'new' collection 'C_CRMCD_S01_1' from collection 'Everything' under Agency 'A_CRMCD_S01_1'NEWLIB
And I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add asset to 'new' collection 'C_CRMCD_S02_1' from collection 'Everything' under Agency 'A_CRMCD_S01_1'NEWLIB
And I go to the collections page
And I 'set' the collection 'C_CRMCD_S01_1' as home collection on collections page
And I go to  collection details page for collection 'C_CRMCD_S02_1'
And remove the collection in collection details page
And I wait for '3' seconds
Then I 'should' see collection 'Collections>C_CRMCD_S01_1' in breadcrum on collections pageNEWLIB


Scenario: check that user can remove collection from the Collection page
Meta:@gdam
@library
!--QA-997
!--QA-1033
Given I created the agency 'A_CRMCP_S01_1' with default attributes
And created users with following fields:
| Email         | Role          | Agency        | Access               |
| U_CRMCP_S01_1 | agency.admin  | A_CRMCP_S01_1 | streamlined_library  |
And logged in with details of 'U_CRMCP_S01_1'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add asset to 'new' collection 'C_RCFCP_S01_1' from collection 'Everything' under Agency 'A_CRMCP_S01_1'NEWLIB
And I click Collection Tab on collection details page
And I remove the collection 'C_RCFCP_S01_1' in collection page
Then I 'should not' see on the library page sub collections 'C_RCFCP_S01_1' under agency 'A_CRMCP_S01_1'NEWLIB

Scenario: check that user can cancel while removing the collection and the collection won't get removed
Meta:@gdam
@library
!--QA-997
Given I created the agency 'A_RCFCP_S01_1' with default attributes
And created users with following fields:
| Email         | Role          | Agency        | Access               |
| U_RCFCP_S01_1 | agency.admin  | A_RCFCP_S01_1 | streamlined_library  |
And logged in with details of 'U_RCFCP_S01_1'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov'NEWLIB
When I go to the library page for collection 'Everything'NEWLIB
And I refresh the page
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add asset to 'new' collection 'C_RCFCP_S01_1' from collection 'Everything' under Agency 'A_RCFCP_S01_1'NEWLIB
And I click Collection Tab on collection details page
And I cancel removing collection 'C_RCFCP_S01_1'
Then I 'should' see on the library page sub collections 'C_RCFCP_S01_1' under agency 'A_RCFCP_S01_1'NEWLIB


Scenario: check that collections can be set and Unset as Home Collection
Meta:@gdam
@library
!--QA-1033
!--QA-1035
!--QA-996
Given I created the agency 'A_CSUHC_S01_1' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access               |
| U_CSUHC_S01_1 | agency.admin | A_CSUHC_S01_1 | streamlined_library  |
And logged in with details of 'U_CSUHC_S01_1'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
And created following collectionsNEWLIB:
| Name          | MediaType | AssetName    |
| C_CSUHC_S01_1  | video     | Fish1-Ad.mov |
| C_CSUHC_S01_2  | audio     | test.mp3     |
When I go to the collections page
And I 'set' the collection 'C_CSUHC_S01_1' as home collection on collections page
And I wait for '1' seconds
And I click library asset Tab on collection page
And I wait for '2' seconds
And I click Collection Tab on library page
And wait for '5' seconds
Then I 'should' see collection 'Collections>C_CSUHC_S01_1' in breadcrum on collections pageNEWLIB
When I 'unset' the collection 'C_CSUHC_S01_1' as home collection on collections details page
And I wait for '1' seconds
When I go to the collections page
And I refresh the page
Then I 'should' see on the collections page for 'C_CSUHC_S01_1':
|Menu                    |
|REMOVE COLLECTION       |
|SET AS COLLECTION HOME  |


