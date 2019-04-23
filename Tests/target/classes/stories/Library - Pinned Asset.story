Feature:          User can remove pinned assets from collection
Narrative:
In order to
As a              AgencyAdmin
I want to         check that user can remove pinned assets from collection


Scenario: Check that cancel on remove from collection pop up redirects the user to previous collection page
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| RFCP_S01 | agency.admin |streamlined_library,library|
And logged in with details of 'RFCP_S01'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'RFCP_C01' from collection 'Everything'NEWLIB
And select asset 'Fish Ad.mov' in the 'RFCP_C01' library pageNEWLIB
And I click 'cancel' on remove from collection popupNEWLIB
Then I 'should' see assets 'Fish Ad.mov' in the collection 'RFCP_C01'NEWLIB

Scenario: Check that confirmation message is displayed when asset is removed from remove from collection popup
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| RFCP_S02 | agency.admin |streamlined_library,library|
And logged in with details of 'RFCP_S02'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'RFCP_C02' from collection 'Everything'NEWLIB
And select asset 'Fish Ad.mov' in the 'RFCP_C02' library pageNEWLIB
Then I 'should' see a message 'File(s) removed from Collection' while removing the asset from remove from collection popupNEWLIB
And I 'should not' see assets 'Fish Ad.mov' in the collection 'RFCP_C02'NEWLIB

