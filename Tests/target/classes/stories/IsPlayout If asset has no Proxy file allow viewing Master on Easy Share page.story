!--NGN-11637
Feature:          IsPlayout If asset has no Proxy file allow viewing Master on Easy Share page
Narrative:
In order to
As a              AgencyAdmin
I want to         Check IsPlayout If asset has no Proxy file allow viewing Master on Easy Share page




Scenario: Check that shared file without proxy could be playable (easyshare user/agency user)
Meta:@gdam
@projects
Given I created the agency 'A_IPIAHNPFAVMOESP_2_01' with default attributes
And created users with following fields:
| Email                  | Role         | Agency                 |
| U_IPIAHNPFAVMOESP_2_01 | agency.admin | A_IPIAHNPFAVMOESP_2_01 |
| U_IPIAHNPFAVMOESP_2_02 | agency.user  | A_IPIAHNPFAVMOESP_2_01 |
And set playout for following agency 'A_IPIAHNPFAVMOESP_2_01'
And logged in with details of 'U_IPIAHNPFAVMOESP_2_01'
And created 'P_IPIAHNPFAVMOESP_2' project
And created '/F_IPIAHNPFAVMOESP_2' folder for project 'P_IPIAHNPFAVMOESP_2'
And uploaded '/files/voiceclip.mp4' file into '/F_IPIAHNPFAVMOESP_2' folder for 'P_IPIAHNPFAVMOESP_2' project
And waited while transcoding is finished in folder '/F_IPIAHNPFAVMOESP_2' on project 'P_IPIAHNPFAVMOESP_2' files page
When I share each folder from project 'P_IPIAHNPFAVMOESP_2' to user 'U_IPIAHNPFAVMOESP_2_02' with role 'project.user' expired date '12.12.2022'
And login with details of 'U_IPIAHNPFAVMOESP_2_02'
And go to file 'voiceclip.mp4' info page in folder '/F_IPIAHNPFAVMOESP_2' project 'P_IPIAHNPFAVMOESP_2'
Then I 'should not' see Download proxy button on opened file info page
And 'should' see playable preview on file info page


Scenario: Check that shared asset without proxy could be playable (easyshare user/agency user)
Meta:@gdam
@gdamemails
Given I created the agency 'A_IPIAHNPFAVMOESP_1_01' with default attributes
And created users with following fields:
| Email                  | Role         | Agency                 |Access|
| U_IPIAHNPFAVMOESP_1_01 | agency.admin | A_IPIAHNPFAVMOESP_1_01 |streamlined_library,library|
| U_IPIAHNPFAVMOESP_1_02 | agency.user  | A_IPIAHNPFAVMOESP_1_01 |streamlined_library,library|
And set playout for following agency 'A_IPIAHNPFAVMOESP_1_01'
And logged in with details of 'U_IPIAHNPFAVMOESP_1_01'
And set following notification settings for users:
| UserEmail              | SettingName   | SettingState |
| U_IPIAHNPFAVMOESP_1_02 | Assets Shared | on          |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/voiceclip.mp4 |
And waited while preview is visible on library page for collection 'Everything' for asset 'voiceclip.mp4'NEWLIB
And added secure share for asset 'voiceclip.mp4' from collection 'Everything' to following users:
| ExpireDate | UserEmails             | Message |
| 12.12.2021 | U_IPIAHNPFAVMOESP_1_02 | hi dude |
When I wait for '5' seconds
And login with details of 'U_IPIAHNPFAVMOESP_1_02'
And open link from email when user 'U_IPIAHNPFAVMOESP_1_02' received email with next subject 'has been shared with'
Then 'should' see playable preview on asset info page

Scenario: Check that shared presentation that include files without proxy could be playable (agency user)
Meta:@gdam
@gdamemails
Given I created the agency 'A_IPIAHNPFAVMOESP_3_01' with default attributes
And created users with following fields:
| Email                  | Role         | Agency                 |Access|
| U_IPIAHNPFAVMOESP_3_01 | agency.admin | A_IPIAHNPFAVMOESP_3_01 |streamlined_library,presentations|
| U_IPIAHNPFAVMOESP_3_02 | agency.user  | A_IPIAHNPFAVMOESP_3_01 |streamlined_library,presentations|
And set playout for following agency 'A_IPIAHNPFAVMOESP_3_01'
And logged in with details of 'U_IPIAHNPFAVMOESP_3_01'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/voiceclip.mp4 |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'voiceclip.mp4'NEWLIB
And I add assets 'voiceclip.mp4' to new presentation 'P_IPIAHNPFAVMOESP_3_01' from collection 'Everything' pageNEWLIB
When I send presentation 'P_IPIAHNPFAVMOESP_3_01' to user 'U_IPIAHNPFAVMOESP_3_02' with personal message 'Hello U_IPIAHNPFAVMOESP_3_01_1'
And wait for '5' seconds
And open link from letter with subject 'P_IPIAHNPFAVMOESP_3_01' for presentation
Then I 'should' see playable preview on presentation preview page