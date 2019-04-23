Feature:          User is taken to top of the list while paginating
Narrative:
In order to
As a              AgencyAdmin
I want to         Check taht user is taken to top of the list while paginating


Scenario: Check that user is taken to top of the list while paginating to previous and next in grid view on library assets page
Meta:@gdam
@library
Given I created the agency 'NBP_A1' with default attributes
And created users with following fields:
| Email             | Role        | AgencyUnique      |Access|
| NBP_U1 | agency.admin | NBP_A1 |streamlined_library,library|
And logged in with details of 'NBP_U1'
When I upload file '/files/logo1.gif' '25' times to libraryNEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
And I refresh the page
And I wait for '10' seconds
And I save Next pagination button position on collection 'Everything' page
And I set pagination '20' in collection 'Everything' pageNEWLIB
And I wait for '5' seconds
And I click 'Next' button on collection 'Everything' pageNEWLIB
And I wait for '5' seconds
And I click 'Previous' button on collection 'Everything' pageNEWLIB
And I wait for '15' seconds
Then I 'should' see Next pagination button on same position on collection 'Everything' page


Scenario: Check that user is taken to top of the list while paginating to previous and next grid view on collection details page
Meta:@gdam
@library
Given I created the agency 'NBP_A2' with default attributes
And created users with following fields:
| Email             | Role        | AgencyUnique      |Access|
| NBP_U2 | agency.user | NBP_A2 |streamlined_library,library|
And logged in with details of 'NBP_U2'
When I upload file '/files/logo1.gif' '25' times to libraryNEWLIB
And go to the Library page for collection 'My Assets'NEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I refresh the page
And I wait for '10' seconds
And I save Next pagination button position on collection 'My Assets' page
And I set pagination '20' in collection 'My Assets' pageNEWLIB
And I wait for '5' seconds
And I click 'Next' button on collection 'My Assets' pageNEWLIB
And I wait for '15' seconds
And I click 'Previous' button on collection 'My Assets' pageNEWLIB
And I wait for '15' seconds
Then I 'should' see Next pagination button on same position on collection 'My Assets' page

Scenario: Check that scroll position is not persist in collection details page when user navigatees to different page
Meta:@gdam
@library
Given I created the agency 'NBP_A3' with default attributes
And created users with following fields:
| Email             | Role        | AgencyUnique      |Access|
| NBP_U3 | agency.user | NBP_A3 |streamlined_library,library|
And logged in with details of 'NBP_U3'
When I upload file '/files/logo1.gif' '15' times to libraryNEWLIB
And I am on the library assets page
And I wait for '10' seconds
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to the Library page for collection 'My Assets'NEWLIB
And I wait for '5' seconds
And I save Next pagination button position on collection 'My Assets' page
And I scroll down to footer '3' times on collection details pageNEWLIB
And I wait for '3' seconds
And I am on the library assets page
And go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see Next pagination button on same position on collection 'My Assets' page

Scenario: Check that user is taken to top of the list while paginating to previous and next in list view on library assets page
Meta:@gdam
@library
Scenario: Check that user is taken to top of the list while paginating to previous and next in list view on library assets page
Given I created the agency 'NBP_A4' with default attributes
And created users with following fields:
| Email             | Role        | AgencyUnique      |Access|
| NBP_U4 | agency.admin | NBP_A4 |streamlined_library,library|
And logged in with details of 'NBP_U4'
When I upload file '/files/logo1.gif' '25' times to libraryNEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
And I refresh the page
And I wait for '10' seconds
And I switch to 'list' view from the collection 'Everything' pageNEWLIB
And I wait for '10' seconds
And I save Next pagination button position on collection 'Everything' page
And I click 'Next' button on collection 'Everything' pageNEWLIB
And I wait for '5' seconds
And I click 'Previous' button on collection 'Everything' pageNEWLIB
And I wait for '15' seconds
Then I 'should' see Next pagination button on same position on collection 'Everything' page

Scenario: Check that user is taken to top of the list while paginating to previous and next in list view on collection details page
Meta:@gdam
@library
Given I created the agency 'NBP_A5' with default attributes
And created users with following fields:
| Email             | Role        | AgencyUnique      |Access|
| NBP_U5 | agency.user | NBP_A5 |streamlined_library,library|
And logged in with details of 'NBP_U5'
When I upload file '/files/logo1.gif' '25' times to libraryNEWLIB
And go to the Library page for collection 'My Assets'NEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I refresh the page
And I wait for '10' seconds
And I switch to 'list' view from the collection 'My Assets' pageNEWLIB
And I wait for '10' seconds
And I save Next pagination button position on collection 'My Assets' page
And I click 'Next' button on collection 'My Assets' pageNEWLIB
And I wait for '5' seconds
And I click 'Previous' button on collection 'My Assets' pageNEWLIB
And I wait for '15' seconds
Then I 'should' see Next pagination button on same position on collection 'My Assets' page
