!--NGN-1731
Feature:          Sharing Presentation
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing of presentation on different users

Scenario: Check that agency user recieves proper email after sharing
Meta: @qagdamsmoke
	  @livegdamsmoke
	  @gdam
	  @gdamemails
	  @gdamcrossbrowser
Given I created following reels:
| Name     | Description |
| P_SP_S01 | D1          |
And created users with following fields:
| Email    | Role        |
| U_SP_S01 | agency.user |
And on user 'U_SP_S01' Notifications Settings page
And set notification 'Presentation Shared' into state 'on' for current user
And saved current user notifications setting
When I share presentation 'P_SP_S01' to user 'U_SP_S01' with personal message 'I reel you!'
Then I 'should' see email notification for 'Shared presentation' with field to 'U_SP_S01' and subject 'has been shared with' contains following attributes:
| Agency        | Message     | PresentationName |
| DefaultAgency | I reel you! | P_SP_S01         |


Scenario: Check that easyshare user receives proper email after sharing
Meta: @skip
      @gdam
      @gdamemails
Given I created following reels:
| Name     | Description |
| P_SP_S02 | DDD         |
When I go to the presentations assets page 'P_SP_S02'
And send presentation 'P_SP_S02' to user 'ESU_SP_S02' with personal message 'I reel you!'
Then I 'should' see email notification for 'Shared presentation' with field to 'ESU_SP_S02' and subject 'has been shared with you' contains following attributes:
| Agency        | Message     | PresentationName |
| DefaultAgency | I reel you! | P_SP_S02         |



Scenario: Check sharing presentation for easyshare user
!--affected by NGN-3791
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @skip
Given I uploaded following assets:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
And created following reels:
| Name     |
| P_SP_S04 |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
And add asset 'Fish Ad.mov,13DV-CAPITAL-10.mpg,128_shortname.jpg' into existing presentation 'P_SP_S04'
And share presentation 'P_SP_S04' to user 'ESU_SP_S04' with personal message 'I reel you and you too'
And logout from account
And open link from letter with subject 'P_SP_S04' for presentation
And refresh the page
Then I should see for user 'AgencyAdmin' following assets for presentation 'P_SP_S04' on the preview page:
| Name                | Should |
| Fish Ad.mov         | should |
| 13DV-CAPITAL-10.mpg | should |
| 128_shortname.jpg   | should |
And should see that player in the playing state on the presentation 'P_SP_S04' preview page for all assets


Scenario: Check sharing several presentations for agency user of current agency
Meta:  @skip
       @gdam
Given I uploaded following assets:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
| /files/example.psd         |
| /files/example2.indd       |
| /files/logo1.gif           |
| /files/logo2.png           |
| /files/logo4.bmp           |
| /images/big.logo.png       |
| /images/branding_logo.png  |
And created following reels:
| Name       |
| P_SP_S05_1 |
| P_SP_S05_2 |
| P_SP_S05_3 |
| P_SP_S05_4 |
| P_SP_S05_5 |
And created users with following fields:
| Email    | Role        |
| U_SP_S05 | agency.user |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
| example.psd         |
| example2.indd       |
| logo1.gif           |
| logo2.png           |
| logo4.bmp           |
| big.logo.png        |
| branding_logo.png   |
And add following assets into following existing presentations:
| Asset                           | Presentation | Description |
| Fish Ad.mov,13DV-CAPITAL-10.mpg | P_SP_S05_1   | D1          |
| example.psd,example2.indd       | P_SP_S05_2   | D2          |
| logo1.gif,logo2.png             | P_SP_S05_3   | D3          |
| logo4.bmp,128_shortname.jpg     | P_SP_S05_4   | D4          |
| big.logo.png,branding_logo.png  | P_SP_S05_5   | D5          |
And send following presentations next to users:
| Presentation | User     | Message |
| P_SP_S05_1   | U_SP_S05 | M1      |
| P_SP_S05_2   | U_SP_S05 | M2      |
| P_SP_S05_3   | U_SP_S05 | M3      |
| P_SP_S05_4   | U_SP_S05 | M4      |
And logout from account
And open link from letter with subject 'P_SP_S05_2' for presentation
And fill fields login 'U_SP_S05' and password 'abcdefghA1' and then login to system
Then I should see for user 'AgencyAdmin' following assets for presentation 'P_SP_S05_2' on the preview page:
| Name          | Should |
| example.psd   | should |
| example2.indd | should |
And in left bot corner drop down menu with the following presentations
| Reel            |
| ReelForSharing1 |
| ReelForSharing2 |
| ReelForSharing3 |
| ReelForSharing4 |
And following presentation should include the following assets
| Reel            | Assets                 |
| ReelForSharing1 | \test1.mov;\test5.mov; |
| ReelForSharing2 | \test2.mp3;\test6.mp3; |
| ReelForSharing3 | \test3.xls;\test7.mp3; |
| ReelForSharing4 | \test4.png;\test8.mp3; |


Scenario: Check sharing several presentations for agency user from another agency
Meta:
@skip
@gdam
Given I uploaded following assets:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
| /files/example.psd         |
| /files/example2.indd       |
| /files/logo1.gif           |
| /files/logo2.png           |
| /files/logo4.bmp           |
| /images/big.logo.png       |
| /images/branding_logo.png  |
And created following reels:
| Name       |
| P_SP_S06_1 |
| P_SP_S06_2 |
| P_SP_S06_3 |
| P_SP_S06_4 |
| P_SP_S06_5 |
And created users with following fields:
| Email    | Role        | Agency        |
| U_SP_S06 | agency.user | AnotherAgency |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
| example.psd         |
| example2.indd       |
| logo1.gif           |
| logo2.png           |
| logo4.bmp           |
| big.logo.png        |
| branding_logo.png   |
And add following assets into following existing presentations:
| Asset                           | Presentation | Description |
| Fish Ad.mov,13DV-CAPITAL-10.mpg | P_SP_S06_1   | D1          |
| example.psd,example2.indd       | P_SP_S06_2   | D2          |
| logo1.gif,logo2.png             | P_SP_S06_3   | D3          |
| logo4.bmp,128_shortname.jpg     | P_SP_S06_4   | D4          |
| big.logo.png,branding_logo.png  | P_SP_S06_5   | D5          |
And send following presentations next to users:
| Presentation | User     | Message |
| P_SP_S06_1   | U_SP_S06 | M1      |
| P_SP_S06_2   | U_SP_S06 | M2      |
| P_SP_S06_3   | U_SP_S06 | M3      |
| P_SP_S06_4   | U_SP_S06 | M4      |
And logout from account
And open link from letter with subject 'P_SP_S06_3' for presentation
And fill fields login 'U_SP_S06' and password 'abcdefghA1' and then login to system
Then I should see for user 'AgencyAdmin' following assets for presentation 'P_SP_S06_2' on the preview page:
| Name      | Should |
| logo1.gif | should |
| logo2.png | should |
And in left bot corner drop down menu with the following presentations
| Reel         |
| ReelSharing1 |
| ReelSharing2 |
| ReelSharing3 |
| ReelSharing4 |
And following presentation should include the following assets
| Reel         | Assets                 |
| ReelSharing1 | \test1.mov;\test5.mov; |
| ReelSharing2 | \test2.mp3;\test6.mp3; |
| ReelSharing3 | \test3.xls;\test7.mp3; |
| ReelSharing4 | \test4.png;\test8.mp3; |


Scenario: Check sharing several presentations for easyshares user
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
| /files/example.psd         |
| /files/example2.indd       |
| /files/logo1.gif           |
| /files/logo2.png           |
| /files/logo4.bmp           |
| /images/big.logo.png       |
| /images/branding_logo.png  |
And created following reels:
| Name       |
| P_SP_S07_1 |
| P_SP_S07_2 |
| P_SP_S07_3 |
| P_SP_S07_4 |
| P_SP_S07_5 |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
| example.psd         |
| example2.indd       |
| logo1.gif           |
| logo2.png           |
| logo4.bmp           |
| big.logo.png        |
| branding_logo.png   |
And add following assets into following existing presentations:
| Asset                           | Presentation | Description |
| Fish Ad.mov,13DV-CAPITAL-10.mpg | P_SP_S07_1   | D1          |
| example.psd,example2.indd       | P_SP_S07_2   | D2          |
| logo1.gif,logo2.png             | P_SP_S07_3   | D3          |
| logo4.bmp,128_shortname.jpg     | P_SP_S07_4   | D4          |
| big.logo.png,branding_logo.png  | P_SP_S07_5   | D5          |
And send following presentations next to users:
| Presentation | User       | Message |
| P_SP_S07_1   | ESU_SP_S07 | M1      |
| P_SP_S07_2   | ESU_SP_S07 | M2      |
| P_SP_S07_3   | ESU_SP_S07 | M3      |
| P_SP_S07_4   | ESU_SP_S07 | M4      |
And logout from account
And open link from letter with subject 'P_SP_S07_3' for presentation
Then I should see for user 'AgencyAdmin' following assets for presentation 'P_SP_S07_3' on the preview page:
| Name      | Should |
| logo1.gif | should |
| logo2.png | should |
And in left bot corner drop down menu with the following presentations
| Reel     |
| ReelESU1 |
| ReelESU2 |
| ReelESU3 |
| ReelESU4 |
And following presentation should include the following assets
| Reel     | Assets                 |
| ReelESU1 | \test1.mov;\test5.mov; |
| ReelESU2 | \test2.mp3;\test6.mp3; |
| ReelESU3 | \test3.xls;\test7.mp3; |
| ReelESU4 | \test4.png;\test8.mp3; |






Scenario: Check that reel after sharing on easyshare user can be expired
Meta: @skip
      @gdam
!--we can no longer put expiration date in past--confirmed with Maria
!--affected by NGN-3791
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And created following reels:
| Name     | Description |
| P_SP_S11 | Blablabla   |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name        |
| Fish Ad.mov |
And add asset 'Fish Ad.mov' into existing presentation 'P_SP_S11'
And send presentation 'P_SP_S11' to user 'ESU_SP_S11' with personal message 'I reel you!'
And go to the presentation 'P_SP_S11' popup on tab 'Secure share'
And set 'Secure share' experation date '01.01.2012' for current presentation on opened popup
And go to the presentation 'P_SP_S11' settings page
And save settings for current presentation
And logout from account
And open link from letter with subject 'P_SP_S11' for presentation
And refresh the page
Then I should see text on page contains 'Sorry, this does not appear to be a valid presentation'


Scenario: Check that reel after sharing on agency user can be expired
Meta: @skip
      @gdam
!--we can no longer put expiration date in past--confirmed with Maria
Given I created users with following fields:
| Email    | Role        | Password   |
| U_SP_S12 | agency.user | abcdefghA1 |
And uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And created following reels:
| Name     | Description |
| P_SP_S12 | Blablabla   |
When I go to the Library page for collection 'Everything'
And wait while preview is visible on library page for collection 'Everything' for assets:
| Name        |
| Fish Ad.mov |
And add asset 'Fish Ad.mov' into existing presentation 'P_SP_S12'
And send presentation 'P_SP_S12' to user 'U_SP_S12' with personal message 'I reel you!'
And go to the presentation 'P_SP_S12' settings page
And go to the presentation 'P_SP_S12' popup on tab 'Secure share'
And set 'Secure share' experation date '01.01.2012' for current presentation on opened popup
And go to the presentation 'P_SP_S12' settings page
And save settings for current presentation
And logout from account
And wait for '60' seconds
And open link from letter with subject 'P_SP_S12' for presentation
And fill fields login 'U_SP_S12' and password 'abcdefghA1' and then login to system
Then I should see text on page contains 'Sorry, this does not appear to be a valid presentation'


Scenario: Check sharing presentation for agency user
Meta: @gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
And created users with following fields:
| Email    | Role        | Password   |
| U_SP_S03 | agency.user | abcdefghA1 |
And created following reels:
| Name     |
| P_SP_S03 |
When I go to the Library page for collection 'Everything'NEWLIB
And wait while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
And I add assets 'Fish Ad.mov,13DV-CAPITAL-10.mpg,128_shortname.jpg' to existing presentations 'P_SP_S03' from collection 'Everything' pageNEWLIB
And share presentation 'P_SP_S03' to user 'U_SP_S03' with personal message 'I reel you and you too'
And logout from account
And open link from letter with subject 'P_SP_S03' for presentation
And fill fields login 'U_SP_S03' and password 'abcdefghA1' and then login to system
Then I should see for user 'AgencyAdmin' following assets for presentation 'P_SP_S03' on the preview page:
| Name                | Should |
| Fish Ad.mov         | should |
| 13DV-CAPITAL-10.mpg | should |
| 128_shortname.jpg   | should |
And should see that player in the playing state on the presentation 'P_SP_S03' preview page for all assets


Scenario: Easyshare user should be added to address book
Meta: @gdam
@library
!--affected by NGN-3275
Given I created following reels:
| Name     | Description |
| P_SP_S08 | DDD         |
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I add assets 'Fish Ad.mov' to existing presentations 'P_SP_S08' from collection 'Everything' pageNEWLIB
When I send presentation 'P_SP_S08' to user 'es_U_SP_S08' with personal message 'message'
And I go on Address Book page
Then I 'should' see easyshare users 'es_U_SP_S08' on the Address Book page


Scenario: Check that shared presentation should be available only for owner and agency admin user
Meta: @gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And created following reels:
| Name     | Description |
| P_SP_S09 | DDD         |
And created users with following fields:
| Email    |
| U_SP_S09 |
When I go to the Library page for collection 'Everything'NEWLIB
And wait while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I add assets 'Fish Ad.mov' to existing presentations 'P_SP_S09' from collection 'Everything' pageNEWLIB
And go to the presentations assets page 'P_SP_S09'
And send presentation 'P_SP_S09' to user 'U_SP_S09' with personal message 'message'
And login with details of 'U_SP_S09'
And go to the presentations assets page
Then I 'should' see presentation 'P_SP_S09' on the page
And 'should' see assets 'Fish Ad.mov' in presentation 'P_SP_S09'
And should count '1' thumbnails in the current presentation


Scenario: Check that shared presentation shouldn't be visible for another user from agency
Meta: @gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And created following reels:
| Name     | Description |
| P_SP_S10 | DDD         |
And created users with following fields:
| Email    | Role        |
| U_SP_S10 | agency.user |
When I go to the Library page for collection 'Everything'NEWLIB
And wait while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
When I add asset 'Fish Ad.mov' into existing presentation 'P_SP_S10' from collection 'Everything'NEWLIB
And go to the presentations assets page 'P_SP_S10'
And send presentation 'P_SP_S10' to user 'U_SP_S10' with personal message 'message'
And login with details of 'U_SP_S10'
And go to the presentations assets page
Then I 'should not' see presentation 'P_SP_S10' on the page

Scenario: Check that reel isn't available via easyshare url after deleting
Meta: @gdam
@library
!--affected by NGN-3791
Given I am on the all presentations page
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And created following reels:
| Name     |
| P_SP_S13 |
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
When I go to the Library page for collection 'Everything'NEWLIB
And I add asset 'Fish Ad.mov' into existing presentation 'P_SP_S13' from collection 'Everything'NEWLIB
And send presentation 'P_SP_S13' to user 'ESU_SP_S13' with personal message 'I reel you!'
And go to the all presentations page
And delete presentation 'P_SP_S13'
And logout from account
And open link from email when user 'ESU_SP_S13' received email with next subject 'You are invited to Adbank'
And fill registration form with following fields:
| FirstName     | LastName      | Password   | ConfirmPassword |
| ESU_SP_S13_FN | ESU_SP_S13_LN | abcdefghA1 | abcdefghA1      |
And click element 'SaveButton' on page 'Registration'
Then I should see text on page contains 'Sorry, this does not appear to be a valid presentation'


Scenario: Check that reel after deleting isn't available for shared agency user
Meta: @gdam
@library
Given I created users with following fields:
| Email    | Agency        | Role        | Password   |
| U_SP_S14 | AnotherAgency | agency.user | abcdefghA1 |
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And created following reels:
| Name     |
| P_SP_S14 |
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
When I go to the Library page for collection 'Everything'NEWLIB
And I add asset 'Fish Ad.mov' into existing presentation 'P_SP_S14' from collection 'Everything'NEWLIB
And send presentation 'P_SP_S14' to user 'U_SP_S14' with personal message 'I reel you!'
And go to the all presentations page
And delete presentation 'P_SP_S14'
And logout from account
And fill fields login 'U_SP_S14' and password 'abcdefghA1' and then login to system
And I wait for '7' seconds
And open link from letter with subject 'P_SP_S14' for presentation
Then I should see text on page contains 'Sorry, this does not appear to be a valid presentation'
