!--NGN-8875
Feature:          Sharing Presentation to library team
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing of presentation on different library teams

Scenario: User can see Sent Presentation button has following down options 'Send to User' and 'Send to Team'
Meta:@gdam
@library
Given I created following reels:
| Name        |
| P_SPTLT_S01 |
When I click Send Presentation button on presentation 'P_SPTLT_S01' assets page
Then I 'should' see Send To User button on opened presentation page
Then I 'should' see Send To Library Team button on opened presentation page




Scenario: In the pop up that appears, user can type/look up Library Team name from the current agency
Meta:@gdam
@library
Given I created the agency 'A_SPTLT_S03' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| U_SPTLT_S03_1 | agency.admin | A_SPTLT_S03   |
| U_SPTLT_S03_2 | agency.user  | A_SPTLT_S03   |
| U_SPTLT_S03_3 | agency.user  | DefaultAgency |
And logged in with details of 'U_SPTLT_S03_1'
And added users 'U_SPTLT_S03_1,U_SPTLT_S03_2' to library team 'LT_SPTLT_S03_1'
And logged in with details of 'AgencyAdmin'
And added users 'U_SPTLT_S03_3' to library team 'LT_SPTLT_S03_2'
And created following reels:
| Name        |
| P_SPTLT_S03 |
And on the presentations assets page 'P_SPTLT_S03'
When I try to add library team 'LT_SPTLT_S03_1' on 'Send presentation' popup
Then I 'should not' see library team 'LT_SPTLT_S03_1' is available for selecting on Send presentation popup
When I refresh the page
When I try to add library team 'LT_SPTLT_S03_2' on 'Send presentation' popup
Then I 'should' see library team 'LT_SPTLT_S03_2' is available for selecting on Send presentation popup



Scenario: check ability to send presentation to library team
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I created users with following fields:
| Email       | Role        |
| U_SPTLT_S02 | agency.user |
And added users 'U_SPTLT_S02' to library team 'LT_SPTLT_S02'
And created following reels:
| Name        |
| P_SPTLT_S02 |
When I go to the Library page for collection 'Everything'NEWLIB
And wait while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I add assets 'Fish Ad.mov' to existing presentations 'P_SPTLT_S02' from collection 'Everything' pageNEWLIB
When I send presentation 'P_SPTLT_S02' to library team 'LT_SPTLT_S02' with personal message 'Hi guys!'
And login with details of 'U_SPTLT_S02'
And go to preview presentation 'P_SPTLT_S02' page under user 'AgencyAdmin'
Then I 'should' be on presentation preview page

Scenario: User can remove users from this list of necessary
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role        |
| U_SPTLT_S04 | agency.user |
And added users 'U_SPTLT_S04' to library team 'LT_SPTLT_S04'
And created following reels:
| Name        |
| P_SPTLT_S04 |
And uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I add assets 'Fish Ad.mov' to existing presentations 'P_SPTLT_S04' from collection 'Everything' pageNEWLIB
When I send presentation 'P_SPTLT_S04' to library team 'LT_SPTLT_S04' with personal message 'Hi guys!'
And delete share for 'U_SPTLT_S04' user from 'P_SPTLT_S04' presentation to Library team popup
And login with details of 'U_SPTLT_S04'
And go to preview presentation 'P_SPTLT_S04' page under user 'AgencyAdmin'
Then I 'should not' be on presentation preview page

Scenario: Removing user from send list does not remove it from the team
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role        |
| U_SPTLT_S05 | agency.user |
And added users 'U_SPTLT_S05' to library team 'LT_SPTLT_S05'
And created following reels:
| Name        |
| P_SPTLT_S05 |
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I add assets 'Fish Ad.mov' to existing presentations 'P_SPTLT_S05' from collection 'Everything' pageNEWLIB
When I send presentation 'P_SPTLT_S05' to library team 'LT_SPTLT_S05' with personal message 'Hi guys!'
And delete share for 'U_SPTLT_S05' user from 'P_SPTLT_S05' presentation to Library team popup
Then I 'should' see 'U_SPTLT_S05' user in 'LT_SPTLT_S05' users group


Scenario: After clicking Send button, notification about presentation share is sent to all selected users
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email         | Role        |
| U_SPTLT_S06_1 | agency.user |
| U_SPTLT_S06_2 | agency.user |
And added users 'U_SPTLT_S06_1,U_SPTLT_S06_2' to library team 'LT_SPTLT_S06'
And created following reels:
| Name        |
| P_SPTLT_S06 |
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I add assets 'Fish Ad.mov' to existing presentations 'P_SPTLT_S06' from collection 'Everything' pageNEWLIB
When I send presentation 'P_SPTLT_S06' to library team 'LT_SPTLT_S06' with personal message 'Hi guys!'
And wait for '5' seconds
Then I 'should' see email notification for 'Shared presentation' with field to 'U_SPTLT_S06_1' and subject 'has been shared with you' contains following attributes:
| Agency        | Message  | PresentationName | UserName    |
| DefaultAgency | Hi guys! | P_SPTLT_S06      | AgencyAdmin |
And 'should' see email notification for 'Shared presentation' with field to 'U_SPTLT_S06_2' and subject 'has been shared with you' contains following attributes:
| Agency        | Message  | PresentationName | UserName    |
| DefaultAgency | Hi guys! | P_SPTLT_S06      | AgencyAdmin |


Scenario: check email notifications - open link to shared reel
Meta:@gdam
@gdamemails
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I created users with following fields:
| Email       | Role        |
| U_SPTLT_S07 | agency.user |
And added users 'U_SPTLT_S07' to library team 'LT_SPTLT_S07'
And created following reels:
| Name        |
| P_SPTLT_S07 |
When I go to the Library page for collection 'Everything'NEWLIB
And wait while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I add asset 'Fish Ad.mov' into existing presentation 'P_SPTLT_S07' from collection 'Everything'NEWLIB
When I send presentation 'P_SPTLT_S07' to library team 'LT_SPTLT_S07' with personal message 'Hi guys!'
And login with details of 'U_SPTLT_S07'
And open link from email with shared presentation 'P_SPTLT_S07' which user 'U_SPTLT_S07' received
Then I 'should' be on presentation preview page

Scenario: check that email notifications are not send to Removing user from Library Team
Meta:@gdam
@gdamemails
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I created users with following fields:
| Email         | Role        |
| U_SPTLT_S08_1 | agency.user |
| U_SPTLT_S08_2 | agency.user |
And created following reels:
| Name        |
| P_SPTLT_S08 |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I added asset 'Fish Ad.mov' into existing presentation 'P_SPTLT_S08' from collection 'Everything'NEWLIB
And added users 'U_SPTLT_S08_1,U_SPTLT_S08_2' to library team 'LT_SPTLT_S08'
And removed users 'U_SPTLT_S08_2' from 'library' team 'LT_SPTLT_S08'
When I send presentation 'P_SPTLT_S08' to library team 'LT_SPTLT_S08' with personal message 'Hi guys!'
Then I 'should' see email notification for 'Shared presentation' with field to 'U_SPTLT_S08_1' and subject 'has been shared with you' contains following attributes:
| Agency        | Message  | PresentationName | UserName    |
| DefaultAgency | Hi guys! | P_SPTLT_S08      | AgencyAdmin |
And 'should not' see email notification for 'Shared presentation' with field to 'U_SPTLT_S08_2' and subject 'has been shared with you' contains following attributes:
| Agency        | Message  | PresentationName | UserName    |
| DefaultAgency | Hi guys! | P_SPTLT_S08      | AgencyAdmin |





