!--NGN-1743
Feature:          Presentation list
Narrative:
In order to
As a              AgencyAdmin
I want to         Check presentation list

Meta:
@component presentation

Scenario: Check that created presentations is displayed in lists
Meta:@gdam
@library
Given I created following reels:
| Name       | Description |
| P_PL_S01_1 | description |
| P_PL_S01_2 | description |
And I am on the all presentations page
Then I 'should' see the following presentations in presentations menu and list:
| Name       |
| P_PL_S01_1 |
| P_PL_S01_2 |


Scenario: Check that presentation can be deleted from presentation list
Meta:@gdam
@library
Given I created following reels:
| Name     | Description |
| P_PL_S02 | description |
And I am on the all presentations page
Then I 'should' see the following presentations in presentations menu and list:
| Name     |
| P_PL_S02 |
When I delete presentation 'P_PL_S02'
Then I 'should not' see the following presentations in presentations menu and list:
| Name     |
| P_PL_S02 |


Scenario: Check that several presentations can be deleted from presentation list
Meta:@gdam
@library
Given I created following reels:
| Name       | Description |
| P_PL_S03_1 | description |
| P_PL_S03_2 | description |
| P_PL_S03_9 | description |
And I am on the all presentations page
And I waited for '2' seconds
Then I 'should' see the following presentations in presentations 'list':
| Name       |
| P_PL_S03_1 |
| P_PL_S03_2 |
| P_PL_S03_9 |
When I delete the following presentations:
| Name       |
| P_PL_S03_1 |
| P_PL_S03_2 |
| P_PL_S03_9 |
Then I 'should not' see the following presentations in presentations 'list':
| Name       |
| P_PL_S03_1 |
| P_PL_S03_2 |
| P_PL_S03_9 |


Scenario: Check select all/unselect all function
Meta:@gdam
@library
Given I created following reels:
| Name       | Description |
| P_PL_S04_1 | description |
| P_PL_S04_2 | description |
| P_PL_S04_3 | description |
And I am on the all presentations page
When I click element 'SelectAll' on page 'Presentations'
Then I 'should' see selected all presentations in the list
When I click element 'SelectAll' on page 'Presentations'
Then I 'should' see deselected all presentations in the list



Scenario: Check that Duration Views is increased after viewing reel by public user
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
When I go to library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'
And add asset 'Fish Ad.mov' into new presentation 'P_PL_S08' with description 'description'
And share presentation by public link on presentation 'P_PL_S08' settings page
And logout from account
And go to the shared presentation 'P_PL_S08' preview page
And login with details of 'AgencyAdmin'
And go to the all presentations page
Then I 'should' see the following information for 'P_PL_S08' presentation on presentation list:
| Cell  | Value |
| Views | 1     |


Scenario: Check that Duration Views is increased after viewing reel by agency user
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
When I go to library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'
And add asset 'Fish Ad.mov' into new presentation '<PresentationName>' with description 'description'
And share presentation by public link on presentation '<PresentationName>' settings page
And logout from account
And login with details of '<UserType>'
And go to the shared presentation '<PresentationName>' preview page
And login with details of 'AgencyAdmin'
And go to the all presentations page
Then I 'should' see the following information for '<PresentationName>' presentation on presentation list:
| Cell  | Value |
| Views | 1     |

Examples:
| UserType   | PresentationName |
| AgencyUser | P_PL_S09_1       |


Scenario: Check that 'Views' column displays correct value
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I am on the Library page for collection 'Everything'
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'
And added asset 'Fish Ad.mov' into new presentation 'P_PL_S13' with description 'description'
When I go to preview presentation 'P_PL_S13' page
And play presentation on presentation preview page
And go to the all presentations page
Then I 'should' see the following information for 'P_PL_S13' presentation on presentation list:
| Cell  | Value |
| Views | 1     |


Scenario: Check that value for 'Views' column is increased after viewing by share user
Meta: @skip
      @gdam
Given I created users with following fields:
| Email    | Role        |
| U_PL_S14 | agency.user |
And uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I am on the Library page for collection 'Everything'
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'
And added asset 'Fish Ad.mov' into new presentation 'P_PL_S14' with description 'description'
When I go to preview presentation 'P_PL_S14' page
And play presentation on presentation preview page
And send presentation 'P_PL_S14' to user 'U_PL_S14' with personal message 'Hello U_PL_S14'
And login with details of 'U_PL_S14'
And open link from letter with subject 'P_PL_S14' for presentation
And play presentation on presentation preview page
And login with details of 'AgencyAdmin'
And go to the all presentations page
Then I 'should' see the following information for 'P_PL_S14' presentation on presentation list:
| Cell  | Value |
| Views | 2     |


Scenario: Check that presentation logo is depends of first transcoded asset in presentation
Meta:@gdam
@library
Given I created following reels:
| Name     | Description |
| P_PL_P01 | description |
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
When I go to the all presentations page
And I wait for '2' seconds
Then I 'should' see default logo for presentation 'P_PL_P01' on all presentation page
When I go to the Library page for collection 'Everything'NEWLIB
And wait while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
When I add asset 'Fish Ad.mov' into existing presentation 'P_PL_P01' from collection 'Everything'NEWLIB
And go to the all presentations page
And I refresh the page
Then I 'should' see presentation 'P_PL_P01' logo is asset 'Fish Ad.mov' for user 'AgencyAdmin'


Scenario: Check that Duration column is increased after adding new assets to reel
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
| /files/Fish-Ad.mov |
And I created following reels:
| Name     | Description |
| P_PL_S06 | description |
And I am on Library page for collection 'Everything'NEWLIB
When I wait while previews is visible on library page for collection 'Everything' for the following assetsNEWLIB:
| Name        |
| Fish Ad.mov |
| Fish-Ad.mov |
When I add asset 'Fish Ad.mov' into existing presentation 'P_PL_S06' from collection 'Everything'NEWLIB
And wait for '5' seconds
And go to the all presentations page
Then I 'should' see the following information for 'P_PL_S06' presentation on presentation list:
| Cell     | Value    |
| Duration | 00:00:06 |
When I go to library page for collection 'Everything'NEWLIB
And I add asset 'Fish-Ad.mov' into existing presentation 'P_PL_S06' from collection 'Everything'NEWLIB
And wait for '5' seconds
And go to the all presentations page
Then I 'should' see the following information for 'P_PL_S06' presentation on presentation list:
| Cell     | Value    |
| Duration | 00:00:12 |


Scenario: Check that Duration column is decreased after removing asset from reel
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
| /files/Fish-Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
When I wait while previews is visible on library page for collection 'Everything' for the following assetsNEWLIB:
| Name        |
| Fish Ad.mov |
| Fish-Ad.mov |
And I add assets 'Fish Ad.mov,Fish-Ad.mov' to new presentation 'P_PL_S07' from collection 'Everything' pageNEWLIB
And go to the all presentations page
Then I 'should' see the following information for 'P_PL_S07' presentation on presentation list:
| Cell     | Value    |
| Duration | 00:00:12 |
When I delete asset 'Fish-Ad' from 'P_PL_S07' presentation
And wait for '10' seconds
And go to the all presentations page
Then I 'should' see the following information for 'P_PL_S07' presentation on presentation list:
| Cell     | Value    |
| Duration | 00:00:06 |


