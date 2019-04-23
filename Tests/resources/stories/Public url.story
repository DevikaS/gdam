!--NGN-2269
Feature:          Public url
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check sharing of presentation via creating public url

Scenario: Check that domain url such as current domain name
Meta:@gdam
@library
Given I created following reels:
| Name     | Description |
| P_PU_S01 | Dreams      |
When I click activate public share button for presentation 'P_PU_S01'
Then I 'should' see correctly generated url for presentation 'P_PU_S01' in public url section



Scenario: Ck that reel isn't available via public url after deleting
Meta:
@skip
@gdam
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name        |
| Fish Ad.mov |
And add asset 'Fish Ad.mov' into new presentation 'P_PU_S11' with description 'desc'
And click activate public share button for presentation 'P_PU_S11'
And go to the presentation 'P_PU_S11' settings page
And save settings for current presentation
And logout from account
And go to the presentation 'P_PU_S11' preview page
Then I 'should' see for user 'AgencyAdmin' presentation name 'P_PU_S11' for current preview
And should see count '1' of assets on the current preview page
And should see for user 'AgencyAdmin' following assets for presentation 'P_PU_S11' on the preview page:
| Name        | Should |
| Fish Ad.mov | should |
And should see for user 'AgencyAdmin' that player in the playing state on the presentation 'P_PU_S11' preview page for all assets


Scenario: Check that reel via public url can be expired
Meta: @skip
      @gdam
!--we can no longer put expiration date in past--confirmed with Maria
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And created following reels:
| Name     | Description |
| P_PU_S12 | Blablabla   |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name        |
| Fish Ad.mov |
And add asset 'Fish Ad.mov' into existing presentation 'P_PU_S12'
And click activate public share button for presentation 'P_PU_S12'
And set 'Public share' experation date '01.01.2012' for current presentation on opened popup
And go to the presentation 'P_PU_S12' settings page
And save settings for current presentation
And wait for '60' seconds
And logout from account
Then I 'should' see warning message 'Sorry, this does not appear to be a valid presentation' on presentation 'P_PU_S12' preview page


Scenario: Check that reel isn't available via public url after deleting
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name        |
| Fish Ad.mov |
And add asset 'Fish Ad.mov' into new presentation 'P_PU_S13' with description 'desc'
And click activate public share button for presentation 'P_PU_S13'
And go to the presentation 'P_PU_S13' settings page
And save settings for current presentation
And go to the all presentations page
And delete presentation 'P_PU_S13'
Then I 'should' see warning message 'Sorry, this does not appear to be a valid presentation' on presentation 'P_PU_S13' preview page


Scenario: Check that reel after activate public url is visible for all by public url link
Meta: @gdam
@library
Given I created users with following fields:
| Email    | Role         |Access|
| U_PU_S08 | agency.admin |streamlined_library,presentations|
And logged in with details of 'U_PU_S08'
And uploaded following files into my libraryNEWLIB:
| Name               |
| /files/Fish Ad.mov |
| /files/test.mp3    |
| /files/logo2.png   |
And waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
| logo2.png   |
And I have refreshed the page
And I add assets 'Fish Ad.mov,logo2.png,test.mp3' to new presentation 'P_PU_S08' from collection 'My Assets' pageNEWLIB
When I click activate public share button for presentation 'P_PU_S08'
And go to the presentation 'P_PU_S08' settings page
And save settings for current presentation
And logout from account
And go to the presentation 'P_PU_S08' view page by public url
Then I 'should' see for user 'AgencyAdmin' presentation name 'P_PU_S08' for current preview
And should see count '3' of assets on the current preview page
And should see for user plan 'AgencyAdmin' following assets uploaded by user 'U_PU_S08' into collection 'My Assets' on the opened presentation preview page:
| Name        | Should |
| Fish Ad.mov | should |
| logo2.png   | should |
And should see count '1' of standard audio thumbnails
And should see for user 'AgencyAdmin' that player in the playing state on the presentation 'P_PU_S08' preview page for all assets

Scenario: Check that public url is successfully is opened for agency user that has already opened session
Meta: @gdam
@library
Given I created users with following fields:
| Email      | Role         |Access|
| U_PU_S09_1 | agency.admin |streamlined_library,presentations|
| U_PU_S09_2 | agency.user  |streamlined_library,presentations|
And logged in with details of 'U_PU_S09_1'
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
| /files/test.mp3    |
| /files/logo2.png   |
And waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name         |
| Fish Ad.mov  |
| logo2.png    |
And I have refreshed the page
And I add assets 'Fish Ad.mov,logo2.png,test.mp3' to new presentation 'P_PU_S09' from collection 'My Assets' pageNEWLIB
When I click activate public share button for presentation 'P_PU_S09'
And go to the presentation 'P_PU_S09' settings page
And save settings for current presentation
And login with details of 'U_PU_S09_2'
And go to the presentation 'P_PU_S09' view page by public url
Then I 'should' see for user 'AgencyAdmin' presentation name 'P_PU_S09' for current preview
And should see count '3' of assets on the current preview page
And should see for user plan 'AgencyAdmin' following assets uploaded by user 'U_PU_S09_1' into collection 'My Assets' on the opened presentation preview page:
| Name        | Should |
| Fish Ad.mov | should |
| logo2.png   | should |
And should see count '1' of standard audio thumbnails
And should see for user 'AgencyAdmin' that player in the playing state on the presentation 'P_PU_S09' preview page for all assets

Scenario: Check that current session of user isn't changed after open public url
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And created users with following fields:
| Email    | Role        |Access|
| U_PU_S10 | agency.user |streamlined_library,presentations,folders|
When I go to the Library page for collection 'Everything'NEWLIB
And wait while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I add assets 'Fish Ad.mov' to new presentation 'P_PU_S10' from collection 'Everything' pageNEWLIB
And click activate public share button for presentation 'P_PU_S10'
And go to the presentation 'P_PU_S10' settings page
And save settings for current presentation
And login with details of 'U_PU_S10'
And go to the presentation 'P_PU_S10' view page by public url
And go to Project list page
Then I should see that user 'U_PU_S10' is logged now

