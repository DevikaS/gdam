Feature:    Admin Collection Icon
Narrative:
In order to
As a              AgencyAdmin
I want to check that Admin Collection Icon is not shown for My Assets collection


Scenario: Check that Admin collection icon is not shown for My Assets collection
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| ACI_U01 | agency.admin |streamlined_library,library|
And logged in with details of 'ACI_U01'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to the collections page
Then I 'should not' see admin icon for collection 'My Assets'

Scenario: Check that collections under My Collections navigate to tree view by default
Meta:@gdam
@library
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'LAC_C01' from collection 'Everything'NEWLIB
And I go to the collections page
And I click on collection 'LAC_C01' under My Collections
Then I 'should' see the collection 'LAC_C01' navigates to 'tree view' by default

Scenario: Check that home collection navigates to tree view by default
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access            |
| U_LAATC_S011 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAATC_S011'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov'NEWLIB
And I have refreshed the page
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'LAC_C0310' from collection 'Everything'NEWLIB
And I go to the collections page
And I refresh the page
And I 'set' the collection 'LAC_C0310' as home collection on collections page
And I go to Library page for collection 'Everything'NEWLIB
When I go to the collections page
And I refresh the page
And I click on collection 'LAC_C0310' under My Collections
Then I 'should' see the collection 'LAC_C0310' navigates to 'tree view' by default


Scenario: Check that newly created collection navigates to collection info page
Meta:@gdam
@library
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov'NEWLIB
When I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'LAC_C02' from collection 'Everything'NEWLIB
Then I 'should' be on 'Collection Info' PageNEWLIB
