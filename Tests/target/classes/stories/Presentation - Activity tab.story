!--NGN-1719
Feature:          Presentation - Activity tab
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Activity tab for presentation

Meta:
@component presentation

Scenario: Check that name of presentation appears on Activity tab
Meta:@gdam
@library
When I create following reels:
| Name      | Description |
| P_PAT_S01 | description |
And go to the presentation activity page 'P_PAT_S01'
Then I 'should' see presentation name 'P_PAT_S01' on presentations activity tab


Scenario: Check that name of presentation is change after update
Meta:@gdam
@library
Given I created following reels:
| Name        | Description |
| P_PAT_S02_1 | description |
When I change presentation name from 'P_PAT_S02_1' to 'P_PAT_S02_2'
And I save settings for current presentation
Then I 'should' see presentation name 'P_PAT_S02_2' on presentations activity tab



Scenario: Check 'Date created' field value
Meta:@gdam
@library
When I create following reels:
| Name      | Description |
| P_PAT_S08 | description |
Then I 'should' see 'DateCreated' is 'CurrentDate' on presentation 'P_PAT_S08' activity tab


Scenario: Check 'Last modified' field value after making some changes
Meta:@gdam
@library
When I create following reels:
| Name        | Description |
| P_PAT_S09_1 | description |
Then I 'should' see Last modified equals to Date created on presentation 'P_PAT_S09_1' activity tab
When I change presentation name from 'P_PAT_S09_1' to 'P_PAT_S09_2'
And I save settings for current presentation
Then I 'should' see 'LastModified' is 'LastModifiedDate' on presentation 'P_PAT_S09_2' activity tab


Scenario: Check 'No.Downloads' and 'No.Views' field is update after downloading from public url page
Meta: @skip
      @gdam
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'
And added asset 'Fish Ad.mov' into new presentation 'P_PAT_S12' with description 'description'
When I share presentation by public link on presentation 'P_PAT_S12' settings page
And switch 'on' Allow presentation download checkbox with selecting option 'Originals + Proxys' for presentation 'P_PAT_S12'
And go to the shared presentation 'P_PAT_S12' preview page
And wait for '5' seconds
And click element 'DownloadLink' on page 'PresentationPreview'
And click element 'OriginalFilesButton' on page 'PresentationPreview'
And wait for '5' seconds
And go to the presentation activity page 'P_PAT_S12'
And refresh the page
Then I 'should' see No. Views '1' on presentation 'P_PAT_S12' activity tab
Then I 'should' see No. Downloads '1' on presentation 'P_PAT_S12' activity tab


Scenario: Check 'No.Downloads' and 'No.Views' fields is update after downloading by easyshare user
Meta: @skip
      @gdam
!--NGN-3791
Given I uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'
And added asset 'Fish Ad.mov' into new presentation 'P_PAT_S13' with description 'description'
When I send presentation 'P_PAT_S13' by public link to user 'U_PAT_S13_NA' with personal message 'Hello U_PAT_S13_NA' with option 'Original + Proxy'
And I logout from account
And open link from email when user 'U_PAT_S13_NA' received email with next subject 'has shared presentation with you'
And I wait for '5' seconds
And click element 'DownloadLink' on page 'PresentationPreview'
And click element 'OriginalFilesButton' on page 'PresentationPreview'
And I login as 'AgencyAdmin'
And go to the presentation activity page 'P_PAT_S13'
And refresh the page
Then I 'should' see No. Views '1' on presentation 'P_PAT_S13' activity tab
Then I 'should' see No. Downloads '1' on presentation 'P_PAT_S13' activity tab


Scenario: Check 'No.Downloads' and 'No.Views' field is update after downloading by agency user
Meta: @skip
      @gdam
Given I created users with following fields:
| Email     | Role        | Access          | Agency        |
| U_PAT_S14 | agency.user | folders,library | AnotherAgency |
And uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'
And added asset 'Fish Ad.mov' into new presentation 'P_PAT_S14' with description 'description'
When I share presentation by public link on presentation 'P_PAT_S14' settings page
And switch 'on' Allow presentation download checkbox with selecting option 'Originals + Proxys' for presentation 'P_PAT_S14'
And send presentation 'P_PAT_S14' to user 'U_PAT_S14' with personal message 'Hello U_PAT_S14'
And I login with details of 'U_PAT_S14'
And open link from email when user 'U_PAT_S14' received email with next subject 'has shared presentation with you'
And I wait for '5' seconds
And click element 'DownloadLink' on page 'PresentationPreview'
And click element 'OriginalFilesButton' on page 'PresentationPreview'
And I login as 'AgencyAdmin'
And go to the presentation activity page 'P_PAT_S14'
Then I 'should' see No. Views '1' on presentation 'P_PAT_S14' activity tab
Then I 'should' see No. Downloads '1' on presentation 'P_PAT_S14' activity tab



Scenario: check 'No.Views' field for all users
!--NGN-3791
Meta: @skip
      @gdam
Given I created users with following fields:
| Email       | Role         | Access          | Agency        |
| U_PAT_S16_1 | agency.user  | folders,library | AnotherAgency |
| U_PAT_S16_2 | agency.user  | folders,library | DefaultAgency |
| U_PAT_S16_3 | agency.admin | folders,library | AnotherAgency |
And uploaded following assets:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'
And added asset 'Fish Ad.mov' into new presentation 'P_PAT_S16' with description 'description'
When I share presentation by public link on presentation 'P_PAT_S16' settings page
And send presentation 'P_PAT_S16' to user 'U_PAT_S16_1' with personal message 'Hello U_PAT_S16_1'
And I login with details of 'U_PAT_S16_1'
And open link from email when user 'U_PAT_S16_1' received email with next subject 'has shared presentation with you'
And I login as 'AgencyAdmin'
And send presentation 'P_PAT_S16' to user 'U_PAT_S16_2' with personal message 'Hello U_PAT_S16_2'
And I login with details of 'U_PAT_S16_2'
And open link from email when user 'U_PAT_S16_2' received email with next subject 'has shared presentation with you'
And I login as 'AgencyAdmin'
And send presentation 'P_PAT_S16' to user 'U_PAT_S16_3' with personal message 'Hello U_PAT_S16_3'
And I login with details of 'U_PAT_S16_3'
And open link from email when user 'U_PAT_S16_3' received email with next subject 'has shared presentation with you'
And I login as 'AgencyAdmin'
And send presentation 'P_PAT_S16' to user 'U_PAT_S16_NA' with personal message 'Hello U_PAT_S16_NA'
And I logout from account
And open link from email when user 'U_PAT_S16_NA' received email with next subject 'has shared presentation with you'
And I login as 'AgencyAdmin'
And go to the presentation activity page 'P_PAT_S16'
Then I 'should' see No. Views '4' on presentation 'P_PAT_S16' activity tab


Scenario: Check correctness value of 'No. Asset' field
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I add assets 'Fish Ad.mov' to new presentation 'P_PAT_S04' from collection 'Everything' pageNEWLIB
Then I 'should' see No. Assets '1' on presentation 'P_PAT_S04' activity tab


Scenario: Changing 'No. Asset' value after changing asset quantity
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I add assets 'Fish Ad.mov' to new presentation 'P_PAT_S05' from collection 'Everything' pageNEWLIB
Then I 'should' see No. Assets '1' on presentation 'P_PAT_S05' activity tab
When I go to Library page for collection 'Everything'NEWLIB
And I add assets 'Fish Ad.mov' to existing presentations 'P_PAT_S05' from collection 'Everything' pageNEWLIB
And wait for '5' seconds
Then I 'should' see No. Assets '2' on presentation 'P_PAT_S05' activity tab


Scenario: Check, that 'Total Duration' value is calculated correctly
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
| /files/Fish-Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
| Fish-Ad.mov |
And I add assets 'Fish Ad.mov,Fish-Ad.mov' to new presentation 'P_PAT_S06' from collection 'Everything' pageNEWLIB
Then I 'should' see Total Duration '00:00:12' on presentation 'P_PAT_S06' activity tab

Scenario: Check that 'Total Duration' of presentation is updates after adding new asset and removing asset
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And created following reels:
| Name     | Description |
| P_PAT_S07 | DDD         |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name         |
| Fish1-Ad.mov |
| Fish2-Ad.mov |
| Fish3-Ad.mov |
When I add asset 'Fish1-Ad.mov,Fish2-Ad.mov' into existing presentation 'P_PAT_S07' from collection 'Everything'NEWLIB
Then I 'should' see Total Duration '00:00:12' on presentation 'P_PAT_S07' activity tab
When I go to  Library page for collection 'Everything'NEWLIB
And I add asset 'Fish3-Ad.mov' into existing presentation 'P_PAT_S07' from collection 'My Assets'NEWLIB
And go to the presentation activity page 'P_PAT_S07'
Then I 'should' see Total Duration '00:00:18' on presentation 'P_PAT_S07' activity tab
When I delete asset 'Fish1-Ad' from 'P_PAT_S07' presentation
Then I 'should' see Total Duration '00:00:12' on presentation 'P_PAT_S07' activity tab

Scenario: Check 'Emails Sent' field
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Access          | Agency        |
| U_PAT_S15_1 | agency.user  | folders,library,streamlined_library,presentations | AnotherAgency |
| U_PAT_S15_2 | agency.user  | folders,library,streamlined_library,presentations | DefaultAgency |
| U_PAT_S15_3 | agency.admin | folders,library,streamlined_library,presentations | AnotherAgency |
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I add assets 'Fish Ad.mov' to new presentation 'P_PAT_S15' from collection 'Everything' pageNEWLIB
When I send presentation 'P_PAT_S15' to user 'U_PAT_S15_1' with personal message 'Hello U_PAT_S15_1' and without download permission
And send presentation 'P_PAT_S15' to user 'U_PAT_S15_2' with personal message 'Hello U_PAT_S15_2' and without download permission
And send presentation 'P_PAT_S15' to user 'U_PAT_S15_3' with personal message 'Hello U_PAT_S15_3' and without download permission
And send presentation 'P_PAT_S15' to user 'U_PAT_S15_NA' with personal message 'Hello U_PAT_S15_NA' and without download permission
And wait for '5' seconds
And go to the presentation activity page 'P_PAT_S15'
And refresh the page
Then I 'should' see Emails Sent '4' on presentation 'P_PAT_S15' activity tab


