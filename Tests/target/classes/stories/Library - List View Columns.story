!--QA-924
Feature:          Library - List View Columns
Narrative:
In order to
As a              AgencyAdmin
I want to         Check adding assets to collection

!--QA-924
Scenario: Check that assets could be added to collection when in list View and see that asset data is correctly reflected in list View
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Access              |
| U_AATCL_S01 | agency.admin |streamlined_library  |
And logged in with details of 'U_AATCL_S01'
And uploaded file '/files/GWGTest2.pdf' into my libraryNEWLIB
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I click on list view Icon on 'Everything' page
Then I should see the following fields for 'Fish Ad.mov' in list view of 'Everything' page:
|Title       |File Size  | Originator      | File Type  |
|Fish Ad.mov |383.5KB    |A5testAdvertiser | MOV        |
When I 'deselect' column 'Status' in the list view on 'Everything' page
And wait for '2' seconds
And I select asset 'GWGTest2.pdf' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'C_AATCL_001' from collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'GWGTest2.pdf' in the collection 'C_AATCL_001'NEWLIB
And I 'should not' see assets with titles 'Fish Ad.mov' in the collection 'C_AATCL_001'NEWLIB
Then I should see the following fields for 'GWGTest2.pdf' in list view of 'C_AATCL_001' page:
|Title       |File Size  | Originator      | File Type  |
|GWGTest2.pdf |644.4KB    |A5testAdvertiser | PDF        |
And I 'should' see the list columns selected in 'C_AATCL_001' page:
|Title      |
|File Size  |
|Title      |
|File Type  |
|Originator |
|ID         |
|Last Updated |

Scenario: Check the default column list in List View in Everything
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I click on list view Icon on 'Everything' page
Then I 'should' see the list columns in 'Everything' page:
|Title      |
|Thumbnail  |
|Title      |
|File Size  |
|File Type  |
|Status     |
|Originator |
|ID         |
|Last Updated |
And I 'should' see the list columns selected in 'Everything' page:
|Title      |
|Title      |
|File Size  |
|File Type  |
|Status     |
|Originator |
|ID         |
|Last Updated |

Scenario: Check that selection of columns is maintained and list view is retained if you logout or move between collections or Library Assets
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I click on list view Icon on 'My Assets' page
Then I 'should' see the list columns in 'My Assets' page:
|Title      |
|Thumbnail  |
|Title      |
|File Size  |
|File Type  |
|Status     |
|Originator |
|ID         |
|Last Updated |
When I 'deselect' column 'File Type,Title' in the list view on 'My Assets' page
And I logout from account
And login with details of 'AgencyAdmin'
And I go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see the list columns in 'Everything' page:
|Title      |
|Thumbnail  |
|File Size  |
|Status     |
|Originator |
|ID         |
|Last Updated |
And I 'should' see the list columns selected in 'Everything' page:
|Title      |
|File Size  |
|Status     |
|Originator |
|ID         |
|Last Updated |
And I 'should not' see the list columns selected in 'Everything' page:
|Title      |
|Title      |
|File Type  |


Scenario: Check the you can select and deselect colums in the List view
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'deselect' column 'File Type,Title' in the list view on 'My Assets' page
Then I 'should not' see the list columns in 'My Assets' page:
|Title      |
|File Type  |
|Title      |
When I 'select' column 'File Type' in the list view on 'My Assets' page
Then I 'should' see the list columns in 'My Assets' page:
|Title      |
|File Type  |
And I 'should not' see the list columns in 'My Assets' page:
|Title      |
|Title      |
When I click reset to default in the list view on 'My Assets' page
Then I 'should' see the list columns in 'My Assets' page:
|Title      |
|Thumbnail  |
|Title      |
|File Size  |
|File Type  |
|Status     |
|Originator |
|ID         |
|Last Updated |


