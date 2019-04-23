!--NGN-1709
Feature:          Presentation - add asset to New Presentation
Narrative:
In order to
As a              AgencyAdmin
I want to         Check  ability to add asset to New Presenation

Meta:
@component presentation


Scenario: Check mandatory field on new presentation pop-up and creating new reel without asset (from presentation page)
Meta:@gdam
@library
Given I am on the presentations assets page
When I create new presentation with name '<PresentationName>' and description '<Description>' from presentation page
Then I '<ShouldRed>' see red inputs on page
And I '<Should>' see presentation '<PresentationName>' on the page

Examples:
| PresentationName | Description | ShouldRed  | Should     |
| Reel_PAANPS_S6_1 | 123         | should not | should     |
| Reel_PAANPS_S6_2 |             | should not | should     |
|                  | 123         | should     | should not |


Scenario: Check creating new presentation with specific symbols
Meta:@gdam
@library
Given I am on the presentations assets page
When I create new presentation with name '<PresentationName>' and description '' from presentation page
Then I 'should' see presentation '<PresentationName>' on the page

Examples:
| PresentationName                                          |
| abcdefghijklmnoprqtsuvwyxz1234567890-=/*-+\\~!@#\$%^&*()_ |


Scenario: Check that asset can be added to a new presentation (File from project)
Meta:@gdam
@library
Given I created 'P_PAAtoNPS_S1' project
And created '/F_PAAtoNPS_S1' folder for project 'P_PAAtoNPS_S1'
And I uploaded into project 'P_PAAtoNPS_S1' following files:
| FileName                 | Path           |
| /files/128_shortname.jpg | /F_PAAtoNPS_S1 |
And I waited while preview is available in folder '/F_PAAtoNPS_S1' on project 'P_PAAtoNPS_S1' files page
And I moved following files into library:
| ProjectName   | Path           | FileName          |
| P_PAAtoNPS_S1 | /F_PAAtoNPS_S1 | 128_shortname.jpg |
When I go to the library page for collection 'My Assets'NEWLIB
And I add assets '128_shortname.jpg' to new presentation 'Reel_PAAtoNPS_S1' from collection 'My Assets' pageNEWLIB
And I go to the presentations assets page 'Reel_PAAtoNPS_S1'
Then I 'should' see presentation 'Reel_PAAtoNPS_S1' on the page
And I 'should' see asset '128_shortname.jpg' in the current presentation
And I should count '1' thumbnails in the current presentation


Scenario: Check that asset can be added to a new presentation (File that uploaded to library)
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/128_shortname.jpg |
And I am on Library page for collection 'Everything'NEWLIB
And I waited while preview is visible on library page for collection 'Everything' for asset '128_shortname.jpg'NEWLIB
When I add assets '128_shortname.jpg' to new presentation 'Reel_PAAtoNPS_S2' from collection 'My Assets' pageNEWLIB
When I go to the presentations assets page 'Reel_PAAtoNPS_S2'
Then I 'should' see presentation 'Reel_PAAtoNPS_S2' on the page
And I 'should' see asset '128_shortname.jpg' in the current presentation
And I should count '1' thumbnails in the current presentation



Scenario: Check that several assets can be added to a new presentation
Meta:@gdam
@library
Given I created 'P_PAAtoNPS_S4' project
And created '/F_PAAtoNPS_S4' folder for project 'P_PAAtoNPS_S4'
And I uploaded into project 'P_PAAtoNPS_S4' following files:
| FileName             | Path           |
| /images/logo.gif     | /F_PAAtoNPS_S4 |
| /files/example.psd   | /F_PAAtoNPS_S4 |
| /files/example2.indd | /F_PAAtoNPS_S4 |
And I waited while preview is available in folder '/F_PAAtoNPS_S4' on project 'P_PAAtoNPS_S4' files page
And I moved following files into library:
| ProjectName   | Path           | FileName      | SubType |
| P_PAAtoNPS_S4 | /F_PAAtoNPS_S4 | logo.gif      |         |
| P_PAAtoNPS_S4 | /F_PAAtoNPS_S4 | example.psd   |         |
| P_PAAtoNPS_S4 | /F_PAAtoNPS_S4 | example2.indd |         |
When I go to the library page for collection 'My Assets'NEWLIB
When I add assets 'logo.gif,example.psd,example2.indd' to new presentation 'Reel_PAAtoNPS_S4' from collection 'My Assets' pageNEWLIB
And I go to the presentations assets page 'Reel_PAAtoNPS_S4'
Then I 'should' see presentation 'Reel_PAAtoNPS_S4' on the page
And I 'should' see asset 'logo.gif,example.psd,example2.indd' in the current presentation
And I should count '3' thumbnails in the current presentation


Scenario: Check that already existent asset in presentation can be added to this presentation again
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/128_shortname.jpg |
And I am on Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And I have refreshed the page
And I add assets '128_shortname.jpg' to new presentation 'Reel_PAAtoNPS_S3' from collection 'Everything' pageNEWLIB
And I am on Library page for collection 'Everything'NEWLIB
And I have refreshed the page
And I add assets '128_shortname.jpg' to existing presentations 'Reel_PAAtoNPS_S3' from collection 'Everything' pageNEWLIB
When I go to the presentations assets page 'Reel_PAAtoNPS_S3'
Then I should see count '2' assets '128_shortname.jpg' in the current presentation
