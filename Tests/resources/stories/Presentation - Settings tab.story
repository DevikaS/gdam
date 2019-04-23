!-- NGN-1725
Feature:          Presentation: Settings tab
Narrative:
In order to
As a              AgencyAdmin
I want to         Check features of Presentation Settings tab

Meta:
@component presentation

Scenario: Check that name of presentation and description appears on Settings tab
Meta:@gdam
@library
Given I created following reels:
| Name      | Description      |
| P_PST_S03 | test description |
When I go to the presentation 'P_PST_S03' settings page
Then I 'should' see following data on presentation settings page:
| Name      | Description      |
| P_PST_S03 | test description |


Scenario: Check that name and description is changed after edit
Meta:@gdam
@library
Given I created following reels:
| Name               | Description      |
| <PresentationName> | test description |
When I change presentation name from '<PresentationName>' to '<NewPresentationName>'
And change presentation description to 'updated description' for current presentation
And click element '<Element>' on page 'PresentationSettings'
And switch presentation tab to 'Presentation Settings'
Then I 'should' see presentation name '<ExpectedPresentationName>' on presentation settings page
And 'should' see presentation description '<ExpectedDescription>' on presentation settings page

Examples:
| Element    | PresentationName | NewPresentationName | ExpectedPresentationName | ExpectedDescription |
| SaveButton | P_PST_S04_1      | NP_PST_S04_1        | NP_PST_S04_1             | updated description |


Scenario: Check that reel name is changed in all places after edit
Meta:@gdam
@library
Given I created following reels:
| Name        |
| P_PST_S06_3 |
And I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I added asset 'Fish Ad.mov' into existing presentation 'P_PST_S06_3' from collection 'Everything'NEWLIB
And changed presentation name from 'P_PST_S06_3' to 'P_PST_S06_4'
And saved settings for current presentation
When I go to the all presentations page
And refresh the page
Then I 'should' see the following presentations in presentations menu and list:
| Name        |
| P_PST_S06_4 |
When I go to the presentation activity page 'P_PST_S06_4'
Then I 'should' see presentation name 'P_PST_S06_4' on presentations activity tab
When I go to preview presentation 'P_PST_S06_4' page
Then I 'should' see presentation name 'P_PST_S06_4' for current preview


Scenario: Check that reel name is changed in email
Meta:@gdam
@gdamemails
Given I created following reels:
| Name        |
| P_PST_S06_1 |
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I added asset 'Fish Ad.mov' into existing presentation 'P_PST_S06_1' from collection 'Everything'NEWLIB
And created 'U_PST_S06_NA' User
And changed presentation name from 'P_PST_S06_1' to 'P_PST_S06_2'
And saved settings for current presentation
When I send presentation 'P_PST_S06_2' to user 'U_PST_S06_NA' with personal message 'Hello U_PST_S06_NA'
Then I 'should' see that user 'U_PST_S06_NA' has received email with presentation name in subject 'P_PST_S06_2'



Scenario: Check 'If assets have no duration display for' field for presentation preview page
Meta:@gdam
@library
Given I created following reels:
| Name        |
| <PresentationName> |
And I uploaded following assetsNEWLIB:
| Name             |
| /files/logo1.gif |
| /files/logo2.png |
And I am on Library page for collection 'My Assets'NEWLIB
And waited while preview is visible on library page for collection 'My Assets' for asset 'logo1.gif'NEWLIB
And waited while preview is visible on library page for collection 'My Assets' for asset 'logo2.png'NEWLIB
And I added asset 'logo1.gif,logo2.png' into existing presentation '<PresentationName>' from collection 'My Assets'NEWLIB
When I go to the presentation '<PresentationName>' settings page
And fill field 'If assets have no duration display for' with value '<Value>' on presentation settings page
And save settings for current presentation
And go to preview presentation '<PresentationName>' page
Then I 'should' see following assets with duration on presentation preview page:
| Name      | Duration           |
| logo1.gif | <ExpectedDuration> |
| logo2.png | <ExpectedDuration> |

Examples:
| Value | ExpectedDuration | PresentationName |
| 1     | 1                | P_PST_S07_4      |
| 0     | 5                | P_PST_S07_3      |
| 99999 | 99999            | P_PST_S07_2      |
| abcde | 5                | P_PST_S07_5      |

Scenario: Check 'If assets have no duration display for' on preview page after sharing
Meta:@gdam
@library
Given I created following reels:
| Name        |
| <PresentationName> |
And I created users with following fields:
| Email      | Role       |
| <UserName> | <UserRole> |
And I uploaded following assetsNEWLIB:
| Name             |
| /files/logo1.gif |
| /files/logo2.png |
And I am on Library page for collection 'My Assets'NEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'logo1.gif,logo2.png'NEWLIB
And I added asset 'logo1.gif,logo2.png' into existing presentation '<PresentationName>' from collection 'My Assets'NEWLIB
When I go to the presentation '<PresentationName>' settings page
And fill field 'If assets have no duration display for' with value '10' on presentation settings page
And save settings for current presentation
And send presentation '<PresentationName>' to user '<UserName>' with personal message 'Hi'
And login with details of '<UserName>'
And open link from letter with subject '<PresentationName>' for presentation
Then I 'should' see for user 'AgencyAdmin' following assets with duration on presentation preview page:
| Name      | Duration |
| logo1.gif | 10       |
| logo2.png | 10       |

Examples:
| PresentationName | UserName    | UserRole     |
| P_PST_S08_1      | P_PST_S08_1 | agency.admin |
| P_PST_S08_2      | P_PST_S08_2 | agency.user  |
| P_PST_S08_3      | P_PST_S08_3 | guest.user   |

Scenario: Check 'If assets have no duration display for' on preview page after sharing for easyshare user
Meta: @skip
      @gdam
!--NGN-2568
Given I uploaded following assets:
| Name             |
| /files/logo1.gif |
| /files/logo2.png |
And I am on Library page for collection 'My Assets'
And waited while preview is visible on library page for collection 'My Assets' for assets 'logo1.gif,logo2.png'
And added asset 'logo1.gif,logo2.png' into new presentation 'P_PST_S09' with description 'description'
When I go to the presentation 'P_PST_S09' settings page
And fill field 'If assets have no duration display for' with value '50' on presentation settings page
And save settings for current presentation
And send presentation 'P_PST_S09' to user 'U_PST_S09_NA' with personal message 'Hi'
And I logout from account
And open link from letter with subject 'P_PST_S09' for presentation
Then I 'should' see for user 'AgencyAdmin' following assets with duration on presentation preview page:
| Name      | Duration |
| logo1.gif | 50       |
| logo2.png | 50       |

Scenario: Check that 'If assets have no duration display for' value is changed on preview page after editing
Meta:@gdam
@library
Given I created following reels:
| Name        |
| P_PST_S10 |
And I uploaded following assetsNEWLIB:
| Name             |
| /files/logo1.gif |
| /files/logo2.png |
And I am on Library page for collection 'My Assets'NEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'logo1.gif,logo2.png'NEWLIB
And I added asset 'logo1.gif,logo2.png' into existing presentation 'P_PST_S10' from collection 'My Assets'NEWLIB
When I go to the presentation 'P_PST_S10' settings page
And fill field 'If assets have no duration display for' with value '10' on presentation settings page
And save settings for current presentation
And go to preview presentation 'P_PST_S10' page
Then I 'should' see following assets with duration on presentation preview page:
| Name      | Duration |
| logo1.gif | 10       |
| logo2.png | 10       |
When I go to the presentation 'P_PST_S10' settings page
And fill field 'If assets have no duration display for' with value '15' on presentation settings page
And save settings for current presentation
And go to preview presentation 'P_PST_S10' page
Then I 'should' see following assets with duration on presentation preview page:
| Name      | Duration |
| logo1.gif | 15       |
| logo2.png | 15       |


Scenario: Check User can auto play Presentations by default
Meta:@gdam
@library
!--NGN-16214
Given I created the agency 'PREATOPLY_A_1' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| PREATOPLY_U_1 | agency.admin | PREATOPLY_A_1 |streamlined_library,presentations|
When I login with details of 'PREATOPLY_U_1'
And upload following assetsNEWLIB:
| Name              |
| /files/_file1.gif |
| /files/Fish Ad.mov|
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to Library page for collection 'My Assets'NEWLIB
And I refresh the page
And I add assets '_file1.gif,Fish Ad.mov' to new presentation 'PREATOPLY_S01' from collection 'My Assets' pageNEWLIB
When I go to the presentation 'PREATOPLY_S01' settings page
Then I 'should' see autoplay '<state>' on presentation settings page
When I go to preview presentation 'PREATOPLY_S01' page
Then I '<condition>' see autoplayable preview on presentation preview page

Examples:
|condition|state|
|should   |true |


Scenario: Check User cannot auto play Presentations by setting auto play checkbox unchecked
Meta:@gdam
@library
!--NGN-16214
Given I created the agency 'PREATOPLY_A_2' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| PREATOPLY_U_2 | agency.admin | PREATOPLY_A_2 |streamlined_library,presentations|
When I login with details of 'PREATOPLY_U_2'
And upload following assetsNEWLIB:
| Name              |
| /files/_file1.gif |
| /files/Fish Ad.mov|
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to Library page for collection 'My Assets'NEWLIB
And I refresh the page
And I add assets '_file1.gif,Fish Ad.mov' to new presentation 'PREATOPLY_S02' from collection 'My Assets' pageNEWLIB
When I go to the presentation 'PREATOPLY_S02' settings page
When I '<action>' Autoplay option with value '<state>' on presentation settings page
Then I 'should' see autoplay '<state>' on presentation settings page
When I go to preview presentation 'PREATOPLY_S02' page
Then I '<condition>' see autoplayable preview on presentation preview page

Examples:
|action  |condition   |state |
|uncheck |should not  |false |
|check   |should      |true  |

