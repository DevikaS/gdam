!--NGN-9224
Feature:          User can remove pinned assets from collection
Narrative:
In order to
As a              AgencyAdmin
I want to         check that user can remove pinned assets from collection

Scenario: Check that original file won't be deleted after removing pinned child from collection
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| U_UCRPAFC_S01 | agency.admin |streamlined_library|
And logged in with details of 'U_UCRPAFC_S01'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And copy to 'C_UCRPAFC_S01'  from 'Everything' library page
And go to the Library page for collection 'C_UCRPAFC_S01'NEWLIB
And I remove asset 'Fish Ad.mov' within 'C_UCRPAFC_S01' collection
Then 'should not' see assets with titles 'Fish Ad.mov' in the collection 'C_UCRPAFC_S01'NEWLIB
When go to the Library page for collection 'My Assets'NEWLIB
Then 'should' see assets with titles 'Fish Ad.mov' in the collection 'My Assets'NEWLIB

Scenario: Check that pinned assets could be deleted from collection
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| U_UCRPAFC_S02 | agency.admin |streamlined_library,library|
And logged in with details of 'U_UCRPAFC_S02'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/GWGTest2.pdf' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_UCRPAFC_S02' from collection 'Everything'NEWLIB
And I switch 'on' media type filter 'print' for collection 'C_UCRPAFC_S02' on the page LibraryNEWLIB
And I wait for '5' seconds
And I select asset 'Fish Ad.mov,GWGTest2.pdf' from filter pageNEWLIB
And I remove all selected assets from filter pageNEWLIB
Then I 'should not' see assets 'Fish Ad.mov' in the filter pageNEWLIB
And I 'should' see assets 'GWGTest2.pdf' in the filter pageNEWLIB


Scenario: Check that not pinned assets couldn't be deleted
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| U_UCRPAFC_S03 | agency.admin |streamlined_library,library|
And logged in with details of 'U_UCRPAFC_S03'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And uploaded file '/files/GWGTest2.pdf' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_UCRPAFC_S03' from collection 'Everything'NEWLIB
And I switch 'on' media type filter 'print' for collection 'C_UCRPAFC_S03' on the page LibraryNEWLIB
And I wait for '5' seconds
And I click on Save Changes button on the collection filter page
And select asset 'GWGTest2.pdf' in the 'C_UCRPAFC_S03' library pageNEWLIB
Then I 'should not' see 'Remove From Collection' option in menu for collection 'C_UCRPAFC_S03'NEWLIB

Scenario: Check Remove assets confirmation dialog
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| U_UCRPAFC_S04 | agency.admin |streamlined_library,library|
And logged in with details of 'U_UCRPAFC_S04'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_UCRPAFC_S04' from collection 'Everything'NEWLIB
And select asset 'Fish Ad.mov' in the 'C_UCRPAFC_S04' library pageNEWLIB
Then I 'should' see 'Remove From Collection' confirmation popup for collection 'C_UCRPAFC_S04' on opened library page NEWLIB





Scenario: Check that removed assets isn't avalable in shared collection
!--Todo: will be removed(redundant)
Meta: @skip
      @gdam


