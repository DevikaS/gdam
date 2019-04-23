Feature:    Project Search
Narrative:
In order to
As a              AgencyAdmin
I want to check that project query returns more relavant results

Scenario: Check that project query returns more relavent results
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/_file1.gif  |
And waited while preview is visible on library page for collection 'My Assets' for assets '_file1.gif'NEWLIB
And created 'UCAATP_P2' project
And created 'UC_P2' project
And created 'UCP2' project
And created 'UCAA P2' project
And created 'P2 UC' project
When I go to the library page for collection 'My Assets'NEWLIB
Then I 'should' see following search results for text 'UC' while adding asset '_file1.gif' from collection 'My Assets' pageNEWLIB:
|SearchResults|
|UCAATP_P2    |
|UCP2        |
|UCAA P2         |
|UC_P2      |
|P2 UC|
When I refresh the page
Then I 'should' see following search results for text 'P2' while adding asset '_file1.gif' from collection 'My Assets' pageNEWLIB:
|SearchResults|
|P2 UC         |
|UCAA P2      |

Scenario: Check the restrictions on keyword filter
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/_file1.gif  |
And waited while preview is visible on library page for collection 'My Assets' for assets '_file1.gif'NEWLIB
When I go to the library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I search by keyword 'file1,a.1,file£,fileβγδθπ,file漢字' on the current filter pageNEWLIB
And I wait for '3' seconds
Then I 'should' see the keyword 'file1,a.1,file£,fileβγδθπ,file漢字' accepted
When I clear the filter on library filter page
And I search by keyword 'file$,a.b' on the current filter pageNEWLIB
Then I 'should not' see the keyword 'file$,a.b' accepted
When I clear the filter on library filter page
When I search by keyword '#%&()*+-\/>?@[]^.`{:;_}|~' on the current filter pageNEWLIB
Then I 'should not' see the keyword '#%&()*+-\/>?@[]^.`{:;_}|~' accepted


Scenario: Check that toast message is displayed when single assset is addded to project
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov  |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And created 'LPS_P2' project
And created '/LPS_F2' folder for project 'LPS_P2'
When I go to the library page for collection 'My Assets'NEWLIB
And I add assets 'Fish Ad.mov' to project 'LPS_P2' and folder 'LPS_F2' from collection 'My Assets' pageNEWLIB
Then I 'should' see message 'Fish Ad.mov copied to   LPS_F2' while adding assets to project from collection 'My Assets' NEWLIB
And should see files 'Fish Ad.mov' inside '/LPS_F2' folder for 'LPS_P2' project



Scenario: Check that toast message is displayed when multiple assset is addded to project
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/_file1.gif  |
| /files/128_shortname.jpg  |
And waited while preview is visible on library page for collection 'My Assets' for assets '_file1.gif,128_shortname.jpg'NEWLIB
And created 'LPS_P1' project
And created '/LPS_F1' folder for project 'LPS_P1'
When I go to the library page for collection 'My Assets'NEWLIB
And I add assets '_file1.gif,128_shortname.jpg' to project 'LPS_P1' and folder 'LPS_F1' from collection 'My Assets' pageNEWLIB
Then I 'should' see message '2 asset(s) copied to   LPS_F1' while adding assets to project from collection 'My Assets' NEWLIB



Scenario: Check that cancel button closes the add to project po up
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/128_shortname.jpg  |
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg'NEWLIB
And created 'LPS_P3' project
And created '/LPS_F3' folder for project 'LPS_P3'
When I go to the library page for collection 'My Assets'NEWLIB
And I select asset '128_shortname.jpg' in the 'My Assets'  library pageNEWLIB
And I cancel Add to Project pop up from collection 'My Assets'NEWLIB
Then I 'should' see assets '128_shortname.jpg' in the collection 'My Assets'NEWLIB

Scenario: Check that add here button is disabled when there is no project selected
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/128_shortname.jpg  |
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg'NEWLIB
And created 'LPS_P4' project
And created '/LPS_F4' folder for project 'LPS_P4'
When I go to the library page for collection 'My Assets'NEWLIB
And I select asset '128_shortname.jpg' in the 'My Assets'  library pageNEWLIB
When I 'do not select' project 'LPS_P4' and folder 'LPS_F4' from collection 'My Assets' pageNEWLIB
Then I 'should not' see button 'Add here' enabled on add to project pop up from collection 'My Assets'NEWLIB


Scenario: Check that work requested is included in project serach in Add to project pop up
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/128_shortname.jpg  |
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg'NEWLIB
And created 'LPS_WR1' work request
And created '/LPS_WR_F1' folder for project 'LPS_WR1'
When I go to the library page for collection 'My Assets'NEWLIB
Then I 'should' see following search results for text 'LPS_WR1' while adding asset '128_shortname.jpg' from collection 'My Assets' pageNEWLIB:
|SearchResults|
|LPS_WR1   |


Scenario: Check that asset can be added to work request through Add to project pop up
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/128_shortname.jpg  |
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg'NEWLIB
And created 'LPS_WR2' work request
And created '/LPS_WR_F2' folder for project 'LPS_WR2'
When I go to the library page for collection 'My Assets'NEWLIB
And I add assets '128_shortname.jpg' to project 'LPS_WR2' and folder 'LPS_WR_F2' from collection 'My Assets' pageNEWLIB
Then should see files '128_shortname.jpg' inside '/LPS_WR_F2' folder for 'LPS_WR2' project

Scenario: Check that asset is added to project popup from asset info page
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/128_shortname.jpg  |
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg'NEWLIB
And created 'LPS_P5' project
And created '/LPS_F5' folder for project 'LPS_P5'
When go to asset '128_shortname.jpg' info page in Library for collection 'My Assets'NEWLIB
When I add asset to project 'LPS_P5' and folder 'LPS_F5' on opened asset info pageNEWLIB
Then should see files '128_shortname.jpg' inside '/LPS_F5' folder for 'LPS_P5' project

