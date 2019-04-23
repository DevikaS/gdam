Feature:          Presentation - Asset tab
Narrative:
In order to
As a              AgencyAdmin
I want to         Check features of Presentation Asset tab

Meta:
@component presentation


Scenario: Check that counter of assets is working correctly
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov'NEWLIB
And I am on Library page for collection 'Everything'NEWLIB
When I add assets 'Fish Ad.mov' to new presentation 'PATC' from collection 'Everything' pageNEWLIB
And go to the presentations assets page 'PATC'
Then I 'should' see opened tab 'Assets' on 'PATC' presentation page
And I 'should' see selected assets counter '0'


Scenario: Check that after deselect asset, counter of selected asset is updating
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
| /files/Fish-Ad.mov  |
| /files/Fish2-Ad.mov |
| /files/Fish5-Ad.mov |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov'NEWLIB
And I am on Library page for collection 'Everything'NEWLIB
When I add assets 'Fish Ad.mov,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov' to new presentation 'PATDA' from collection 'Everything' pageNEWLIB
And go to the presentations assets page 'PATDA'
And I 'select' asset 'Fish Ad,Fish-Ad,Fish2-Ad,Fish5-Ad' in the current presentation page
Then I 'should' see selected assets counter '4'
When I 'deselect' asset 'Fish Ad,Fish-Ad' in the current presentation page
Then I 'should' see selected assets counter '2'


Scenario: Check numbering (order) of assets
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
| /files/Fish-Ad.mov  |
| /files/Fish2-Ad.mov |
| /files/Fish5-Ad.mov |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov'NEWLIB
And I am on Library page for collection 'Everything'NEWLIB
When I add assets 'Fish Ad.mov,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov' to new presentation 'PATN' from collection 'Everything' pageNEWLIB
And go to the presentations assets page 'PATN'
Then I 'should' see the folloving assets ordering:
| AssetsName | Number |
| Fish Ad    | 1      |
| Fish-Ad    | 2      |
| Fish2-Ad   | 3      |
| Fish5-Ad   | 4      |


Scenario: Check select all function
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
| /files/Fish-Ad.mov  |
| /files/Fish2-Ad.mov |
| /files/Fish5-Ad.mov |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov'NEWLIB
And I am on Library page for collection 'Everything'NEWLIB
When I add assets 'Fish Ad.mov,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov' to new presentation 'PATSAA' from collection 'Everything' pageNEWLIB
And go to the presentations assets page 'PATSAA'
And I click 'Select all' checkbox on asset presentation page
Then I 'should' see selected assets counter '4'
And All assets 'should' be selected on asset presentation page


Scenario: Check remove function
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
| /files/Fish-Ad.mov  |
| /files/Fish2-Ad.mov |
| /files/Fish5-Ad.mov |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov'NEWLIB
And I am on Library page for collection 'Everything'NEWLIB
When I add assets 'Fish Ad.mov,Fish-Ad.mov,Fish2-Ad.mov,Fish5-Ad.mov' to new presentation 'PATR' from collection 'Everything' pageNEWLIB
And go to the presentations assets page 'PATR'
And I delete asset 'Fish Ad,Fish-Ad' from current presentation page
Then I 'should not' see asset 'Fish Ad.mov,Fish-Ad.mov' in the current presentation
And I 'should' see asset 'Fish2-Ad.mov,Fish5-Ad.mov' in the current presentation


Scenario: Check that open file link redirects to asset details
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish Ad.mov'NEWLIB
And I am on Library page for collection 'Everything'NEWLIB
When I add assets 'Fish Ad.mov' to new presentation 'PATAI' from collection 'Everything' pageNEWLIB
And go to the presentations assets page 'PATAI'
And I click 'Open File' link on asset 'Fish Ad.mov'
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue  |
| Title     | Fish Ad.mov |


Scenario: Check asset info from drop down menu
Meta:@gdam
@library
!--NGN-16381---will retrun incorrect value when BST
Given I created following reels:
| Name              |
| PATIM1 |
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
When I add asset 'Fish1-Ad.mov' into existing presentation 'PATIM1' from collection 'Everything'NEWLIB
And go to the presentations assets page 'PATIM1'
Then I 'should' see following data for asset 'Fish1-Ad.mov' on info drop down menu:
| FieldName   | FieldValue       |
| Duration    | 6s 33ms          |
| Size        | 383.5 KB         |
| Uploaded at | UploadedDateTime |
| Uploaded by | AgencyAdmin      |



Scenario: Check that after delete asset, it should not be visible on reel share page
Meta:@gdam
@library
Given I created users with following fields:
| Email | Role        | Access                        | Agency        |
| AU    | agency.user | folders,streamlined_library,library,presentations | AnotherAgency |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
| /files/Fish4-Ad.mov |
And waited while preview is visible on library page for collection 'Everything' for assets 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov,Fish4-Ad.mov'NEWLIB
And I am on Library page for collection 'Everything'NEWLIB
When I add assets 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov,Fish4-Ad.mov' to new presentation 'PATSR' from collection 'Everything' pageNEWLIB
And go to the presentations assets page 'PATSR'
And I send presentation 'PATSR' to user 'AU' with personal message 'Message'
And I delete asset 'Fish1-Ad.mov' from 'PATSR' presentation
And I login with details of 'AU'
And I open link from letter with subject 'PATSR' for presentation
Then I should see for user 'AgencyAdmin' following assets for presentation 'PATSR' on the preview page:
| Name         | Should     |
| Fish1-Ad.mov | Should not |
| Fish2-Ad.mov | Should     |
| Fish3-Ad.mov | Should     |
| Fish4-Ad.mov | Should     |
