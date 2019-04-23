!-- NGN-1723
Feature:          Presentation Layout tab
Narrative:
In order to
As a              AgencyAdmin
I want to         Check layout tab for presentation

Meta:
@component presentation

Scenario: Check default values of Layout tab page (first time open)
Meta:@gdam
@library
Given I am on the all presentations page
And I created new presentation 'Reel_PLTS2_1' with description 'Check Save button' through UI
When I go to the presentation 'Reel_PLTS2_1' layout page
Then I should see Layout tab for current presentation with the following settings:
| Element       | State        |
| RB_classic    | selected     |
| RB_slider     | not selected |
| CB_Advertiser | not checked  |
| CB_Brand      | not checked  |
| CB_Campaign   | not checked  |
| CB_Product    | not checked  |
| CB_Title      | not checked  |


Scenario: Successfully changing layout
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
And I created following reels:
| Name              |
| Reel_PresLayout_1 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
And I added asset 'Fish Ad.mov,13DV-CAPITAL-10.mpg,128_shortname.jpg' into existing presentation 'Reel_PresLayout_1' from collection 'Everything'NEWLIB
When I go to the presentation 'Reel_PresLayout_1' layout page
And I set following reel view for current presentation '<Element>'
And I save current presentation layout
And I go to preview presentation 'Reel_PresLayout_1' page
Then I should see on the presentation 'Reel_PresLayout_1' preview page following assets:
| Name                | Should |
| Fish Ad.mov         | should |
| 13DV-CAPITAL-10.mpg | should |
| 128_shortname.jpg   | should |
And I should see assets on the preview presentation page with following style '<Element>'

Examples:
| Element    |
| horizontal |
| grid       |
| slider     |


Scenario: Unsuccessfully changing layout (without saving changes)
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
And I created following reels:
| Name              |
| Reel_PresLayout_2 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
And I added asset 'Fish Ad.mov,13DV-CAPITAL-10.mpg,128_shortname.jpg' into existing presentation 'Reel_PresLayout_2' from collection 'Everything'NEWLIB
When I go to the presentation 'Reel_PresLayout_2' layout page
And I set following reel view for current presentation 'grid'
And I save current presentation layout
And I go to the presentation 'Reel_PresLayout_2' layout page
And I set following reel view for current presentation 'slider'
And I go to preview presentation 'Reel_PresLayout_2' page
Then I should see on the presentation 'Reel_PresLayout_2' preview page following assets:
| Name                | Should |
| Fish Ad.mov         | should |
| 13DV-CAPITAL-10.mpg | should |
| 128_shortname.jpg   | should |
And I should see assets on the preview presentation page with following style 'grid'



Scenario: Successfully changing layout for shared reel via public url
Meta: @gdam
      @library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
And I created following reels:
| Name              |
| Reel_PresLayout_6 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
And I added asset 'Fish Ad.mov,13DV-CAPITAL-10.mpg,128_shortname.jpg' into existing presentation 'Reel_PresLayout_6' from collection 'Everything'NEWLIB
When I go to the presentation 'Reel_PresLayout_6' layout page
And I set following reel view for current presentation '<Element>'
And I save current presentation layout
And click activate public share button for presentation 'Reel_PresLayout_6'
And go to the presentation 'Reel_PresLayout_6' preview page
Then I should see following assets for presentation 'Reel_PresLayout_6' on the preview page:
| Name                | Should |
| Fish Ad.mov         | should |
| 13DV-CAPITAL-10.mpg | should |
| 128_shortname.jpg   | should |
And I should see assets on the preview presentation page with following style '<Element>'

Examples:
| Element    |
| horizontal |
| grid       |
| slider     |


Scenario: Successfully changing layout for shared reel to easyshare user
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
And I created following reels:
| Name       |
| <ReelName> |
And I am on the Library page for collection 'My Assets'
And I waited while preview is visible on library page for collection 'My Assets' for assets:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
And I added asset 'Fish Ad.mov,13DV-CAPITAL-10.mpg,128_shortname.jpg' into existing presentation '<ReelName>'
When I go to the presentation '<ReelName>' layout page
And I set following reel view for current presentation '<Element>'
And I save current presentation layout
And I send presentation '<ReelName>' to user '<UserName>' with personal message 'Message'
And I logout from account
And I open link from letter with subject '<ReelName>' for presentation
Then I should see for user 'AgencyAdmin' following assets for presentation '<ReelName>' on the preview page:
| Name                | Should |
| Fish Ad.mov         | should |
| 13DV-CAPITAL-10.mpg | should |
| 128_shortname.jpg   | should |
And I should see assets on the preview presentation page with following style '<Element>'

Examples:
| Element    | ReelName            | UserName |
| horizontal | Reel_PresLayout_7_1 | es_S7_1  |
| grid       | Reel_PresLayout_7_2 | es_S7_2  |
| slider     | Reel_PresLayout_7_3 | es_S7_3  |


Scenario: Successfully changing layout for shared reel to agency user
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Access                        | Agency        |
| <UserName> | agency.user | folders,streamlined_library,presentations | AnotherAgency |
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
| /files/13DV-CAPITAL-10.mpg |
| /files/128_shortname.jpg   |
And I created following reels:
| Name       |
| <ReelName> |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
| 13DV-CAPITAL-10.mpg |
| 128_shortname.jpg   |
And I added asset 'Fish Ad.mov,13DV-CAPITAL-10.mpg,128_shortname.jpg' into existing presentation '<ReelName>' from collection 'Everything'NEWLIB
When I go to the presentation '<ReelName>' layout page
And I set following reel view for current presentation '<Element>'
And I save current presentation layout
And I send presentation '<ReelName>' to user '<UserName>' with personal message 'message'
And I login with details of '<UserName>'
And I open link from letter with subject '<ReelName>' for presentation
Then I should see for user 'AgencyAdmin' following assets for presentation '<ReelName>' on the preview page:
| Name                | Should |
| Fish Ad.mov         | should |
| 13DV-CAPITAL-10.mpg | should |
| 128_shortname.jpg   | should |
And I should see assets on the preview presentation page with following style '<Element>'

Examples:
| Element    | ReelName            | UserName  |
| horizontal | Reel_PresLayout_9_1 | U_PLTS9_1 |
| grid       | Reel_PresLayout_9_2 | U_PLTS9_2 |
| slider     | Reel_PresLayout_9_3 | U_PLTS9_3 |