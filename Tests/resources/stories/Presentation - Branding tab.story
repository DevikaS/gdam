!--NGN-1721
Feature:          Presentation Branding tab
Narrative:
In order to
As a              AgencyAdmin
I want to         Check branding tab for presentation

Meta:
@component presentation

Scenario: Check default values for Branding tab of presentation
Meta:@gdam
@library
Given I am on the all presentations page
And I created following reels:
| Name              | Description |
| Reel_PBranding_S1 | DDD         |
When I go to the presentation 'Reel_PBranding_S1' branding page
Then I should see following elements on the current presentation branding tab:
| Element              | State          |
| Logo thumbnail       | false          |
| Logo filename        | false          |
| Light theme icon     | check false    |
| Dark theme icon      | check true     |
| Background thumbnail | false          |
| Background filename  | false          |
| Scale to fit screen  | selected true  |
| Tile                 | selected false |


Scenario: Thumbnail, filename for logo and background images after upload
Meta:@gdam
@library
Given I am on the all presentations page
And I created following reels:
| Name              | Description |
| Reel_PBranding_S4 | DDD         |
And I am on the presentation 'Reel_PBranding_S4' branding page
When I upload 'Logo' by file '/images/logo.jpg' on the current presentation branding page
And I upload 'Background' by file '/files/128_shortname.jpg' on the current presentation branding page
Then I 'should' see on the current presentation branding page uploaded 'Logo' according to file '/images/logo.jpg'
And I 'should' see on the current presentation branding page uploaded 'Background' according to file '/files/128_shortname.jpg'


Scenario: Checking 'Remove' notification
Meta:@gdam
@library
Given I am on the all presentations page
And I created following reels:
| Name              | Description |
| Reel_PBranding_S5 | DDD         |
And I am on the presentation 'Reel_PBranding_S5' branding page
And I uploaded '<Element>' by file '<FileName>' on the current presentation branding page
When I click remove '<Element>' on the current presentation branding page
Then I 'should' see element 'RemovePopUp' on page 'Presentations'
And I should see text on page contains '<Text>'

Examples:
| Element    | FileName                 | Text                                             |
| Logo       | /images/logo.jpg         | Are you sure you want to remove this logo?       |
| Background | /files/128_shortname.jpg | Are you sure you want to remove this background? |


Scenario: Unsuccessfully uploading logo for presentation
Meta:@gdam
@library
Given I am on the all presentations page
And I created following reels:
| Name              | Description |
| Reel_PBranding_S8 | DDD         |
And I am on the presentation 'Reel_PBranding_S8' branding page
When I upload 'Logo' by file '<FileName>' on the current presentation branding page
Then I should see alert text is '<Text>'

Examples:
| FileName         | Text                                                                   |
| /files/test5.rar | test5.rar has invalid extension. Only gif, jpg, jpeg, png are allowed. |


Scenario: Unsuccessfully uploading background with big size or incorrect extension
Meta:@gdam
@library
Given I am on the all presentations page
And I created following reels:
| Name               |
| Reel_PBranding_S11 |
And I am on the presentation 'Reel_PBranding_S11' branding page
When I upload 'Background' by file '<FileName>' on the current presentation branding page incorrect element
Then I should see message error '<Text>'

Examples:
| FileName                       | Text                                                                                 |
| /files/big_background.jpg      | big_background.jpg is too large, maximum file size is 4.0MB.                         |
| /files/Environmental Icons.eps | Environmental Icons.eps has invalid extension. Only gif, jpg, jpeg, png are allowed. |
| /files/example2.indd           | example2.indd has invalid extension. Only gif, jpg, jpeg, png are allowed.           |



Scenario: Check that successfully uploaded background and logo for presentation is visible after share via easyshare
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name               |
| Reel_PBranding_S11 |
And I am on the Library page for collection 'Everything'
And I waited while preview is visible on library page for collection 'Everything' for assets:
| Name        |
| Fish Ad.mov |
And I added asset 'Fish Ad.mov' into existing presentation 'Reel_PBranding_S11'
And I am on the presentation 'Reel_PBranding_S11' branding page
And I uploaded 'Background' by file '/files/128_shortname.jpg' on the current presentation branding page
And I uploaded 'Logo' by file '/images/branding_logo.png' on the current presentation branding page
And I selected background type '<Mode>' for current presentation
When I click element 'SaveButton' on page 'Presentations'
And I send presentation 'Reel_PBranding_S11' to user 'es_01' with personal message 'this is unique message'
And I logout from account
And I open link from letter with subject 'Reel_PBranding_S11' for presentation
Then I 'should' see background on the presentation preview page according to style '<Mode>'
And I 'should' see uploaded logo 'branding_logo.png' on the preview page for preview
And I 'should' see uploaded background '128_shortname.jpg' on the preview page for preview

Examples:
| Mode                |
| Scale to fit screen |
| Tile                |


Scenario: Checking work of Color Scheme option after sharing on easyshareuser
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name               |
| Reel_PBranding_S14 |
And I am on the Library page for collection 'Everything'
And I waited while preview is visible on library page for collection 'Everything' for assets:
| Name        |
| Fish Ad.mov |
And I added asset 'Fish Ad.mov' into existing presentation 'Reel_PBranding_S14'
And I am on the presentation 'Reel_PBranding_S14' branding page
When I click element '<Element>' on page 'Presentations'
And I click element 'SaveButton' on page 'Presentations'
When I send presentation 'Reel_PBranding_S14' to user 'esS14_' with personal message 'Message'
And I logout from account
And I open link from letter with subject 'Reel_PBranding_S14' for presentation
Then I should see current presentation preview page with scheme '<Scheme>'
And I should see following assets for presentation 'Reel_PBranding_S14' on the preview page:
| Name        | Should |
| Fish Ad.mov | should |

Examples:
| Element     | Scheme |
| LightTheme  | light  |
| DarkTheme   | dark   |


Scenario: Checking work of Color Scheme option after sharing on agency user
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Agency        | Role        |Access|
| <UserName> | AnotherAgency | agency.user |streamlined_library|
And I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name       |
| <ReelName> |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I added asset 'Fish Ad.mov' into existing presentation '<ReelName>' from collection 'Everything'NEWLIB
And I am on the presentation '<ReelName>' branding page
When I click element '<Element>' on page 'Presentations'
And I click element 'SaveButton' on page 'Presentations'
And I send presentation '<ReelName>' to user '<UserName>' with personal message 'Message'
And I login with details of '<UserName>'
And I open link from letter with subject '<ReelName>' for presentation
Then I should see current presentation preview page with scheme '<Scheme>'

Examples:
| UserName  | ReelName             | Element     | Scheme |
| U_RB_15_1 | Reel_PBranding_S15_1 | LightTheme  | light  |
| U_RB_15_2 | Reel_PBranding_S15_2 | DarkTheme   | dark   |


Scenario: Check that logo and background are absent on 'Preview Presentation page' after remove
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
And I created following reels:
| Name              |
| Reel_PBranding_S6 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I add assets 'Fish Ad.mov' to existing presentations 'Reel_PBranding_S6' from collection 'Everything' pageNEWLIB
And I am on the presentation 'Reel_PBranding_S6' branding page
And I uploaded 'Logo' by file '/images/logo.jpg' on the current presentation branding page
And I uploaded 'Background' by file '/files/128_shortname.jpg' on the current presentation branding page
When I remove 'Logo' from the current presentation branding page
And I remove 'Background' from the current presentation branding page
And I save current presentation on the branding page
And I go to preview presentation 'Reel_PBranding_S6' page
Then I should see on the presentation 'Reel_PBranding_S6' oreview page count previews '1' of assets
And I 'should not' see 'Logo' on the current presentation preview page
And I 'should not' see 'Background' on the current presentation preview page

Scenario: Checking successfully uploading logo in presentation
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name              |
| Reel_PBranding_S7 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I add assets 'Fish Ad.mov' to existing presentations 'Reel_PBranding_S7' from collection 'Everything' pageNEWLIB
And I am on the presentation 'Reel_PBranding_S7' branding page
And I uploaded 'Logo' by file '<FileName>' on the current presentation branding page
When I save current presentation on the branding page
And I go to preview presentation 'Reel_PBranding_S7' page
Then I should see on the presentation 'Reel_PBranding_S7' preview page following assets:
| Name        | Should |
| Fish Ad.mov | should |
And I 'should' see uploaded logo '<FileName>' on the preview page for preview

Examples:
| FileName                  |
| /images/branding_logo.png |


Scenario: Checking work of Color Scheme option
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name              |
| Reel_PBranding_S9 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I add assets 'Fish Ad.mov' to existing presentations 'Reel_PBranding_S9' from collection 'Everything' pageNEWLIB
And I am on the presentation 'Reel_PBranding_S9' branding page
When I click element '<Element>' on page 'Presentations'
And I click element 'SaveButton' on page 'Presentations'
And I go to preview presentation 'Reel_PBranding_S9' page
Then I should see current presentation preview page with scheme '<Scheme>'

Examples:
| Element     | Scheme |
| LightTheme  | light  |
| DarkTheme   | dark   |

Scenario: Successfully uploaded background for presentation
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name               |
| Reel_PBranding_S10 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I add assets 'Fish Ad.mov' to existing presentations 'Reel_PBranding_S10' from collection 'Everything' pageNEWLIB
And I am on the presentation 'Reel_PBranding_S10' branding page
When I upload 'Background' by file '/files/128_shortname.jpg' on the current presentation branding page
And I select background type '<Mode>' for current presentation
And I click element 'SaveButton' on page 'Presentations'
And I go to preview presentation 'Reel_PBranding_S10' page
Then I 'should' see background on the presentation preview page according to style '<Mode>'

Examples:
| Mode                |
| scale to fit screen |
| Tile                |

Scenario: Check that successfully uploaded background and logo for presentation is visible after share via public url
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name               |
| Reel_PBranding_S11 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I add assets 'Fish Ad.mov' to existing presentations 'Reel_PBranding_S11' from collection 'Everything' pageNEWLIB
And I am on the presentation 'Reel_PBranding_S11' branding page
And I uploaded 'Background' by file '/files/128_shortname.jpg' on the current presentation branding page
And I uploaded 'Logo' by file '/images/branding_logo.png' on the current presentation branding page
And I selected background type '<Mode>' for current presentation
When I click element 'SaveButton' on page 'Presentations'
And click activate public share button for presentation 'Reel_PBranding_S11'
And go to the presentation 'Reel_PBranding_S11' settings page
And save settings for current presentation
And go to the presentation 'Reel_PBranding_S11' preview page
Then I 'should' see background on the presentation preview page according to style '<Mode>'
And I 'should' see uploaded logo '128_shortname.jpg' on the preview page for preview

Examples:
| Mode                |
| Scale to fit screen |
| Tile                |


Scenario: Check that successfully uploaded background and logo for presentation is visible after share to agency user
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Agency        | Role        |Access|
| <UserName> | AnotherAgency | agency.user |streamlined_library|
And I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name       |
| <ReelName> |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I add assets 'Fish Ad.mov' to existing presentations '<ReelName>' from collection 'Everything' pageNEWLIB
And I am on the presentation '<ReelName>' branding page
And I uploaded 'Background' by file '/files/128_shortname.jpg' on the current presentation branding page
And I uploaded 'Logo' by file '/images/branding_logo.png' on the current presentation branding page
And I selected background type '<Mode>' for current presentation
When I click element 'SaveButton' on page 'Presentations'
And I send presentation '<ReelName>' to user '<UserName>' with personal message 'Message'
And I login with details of '<UserName>'
And I open link from letter with subject '<ReelName>' for presentation
Then I 'should' see background on the presentation preview page according to style '<Mode>'
And I 'should' see uploaded logo 'branding_logo.png' on the preview page for preview
And I 'should' see uploaded background '128_shortname.jpg' on the preview page for preview

Examples:
| UserName  | ReelName             | Mode                |
| U_RB_12_1 | Reel_PBranding_S12_1 | Scale to fit screen |
| U_RB_12_2 | Reel_PBranding_S12_2 | Tile                |

Scenario: Checking work of Color Scheme option after sharing via public url
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name               |
| Reel_PBranding_S13 |
And I am on the Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
And I add assets 'Fish Ad.mov' to existing presentations 'Reel_PBranding_S13' from collection 'Everything' pageNEWLIB
And I am on the presentation 'Reel_PBranding_S13' branding page
When I click element '<Element>' on page 'Presentations'
And I click element 'SaveButton' on page 'Presentations'
And click activate public share button for presentation 'Reel_PBranding_S13'
And go to the presentation 'Reel_PBranding_S13' preview page
Then I should see current presentation preview page with scheme '<Scheme>'
And I should see following assets for presentation 'Reel_PBranding_S13' on the preview page:
| Name        | Should |
| Fish Ad.mov | should |

Examples:
| Element     | Scheme |
| LightTheme  | light  |
| DarkTheme   | dark   |



