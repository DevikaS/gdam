!--NGN-11696
Feature:          User can see Activity about Related Files or Assets on Dashboard
Narrative:
In order to
As a              AgencyAdmin
I want to         User can see Activity about Related Files or Assets on Dashboard


Scenario: Check that link to related file works fine from dashboard
!--05/10 - Confirmed with Maria that this activity neednt be shown on Dashboard--but needs to only show on File activities
Meta: @skip
      @gdam
Given I created the agency 'A_UCSAARFRAOD_1' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique    |
| U_UCSAARFRAOD_S01 | agency.admin | A_UCSAARFRAOD_1 |
When I login with details of 'U_UCSAARFRAOD_S01'
And create 'P_UCSAARFRAOD_1' project
And create '/F_UCSAARFRAOD_1' folder for project 'P_UCSAARFRAOD_1'
And upload into project 'P_UCSAARFRAOD_1' following files:
| FileName             | Path             |
| /images/logo.gif     | /F_UCSAARFRAOD_1 |
| /images/logo.png     | /F_UCSAARFRAOD_1 |
And upload following assets:
| Name                |
| /files/logo1.gif    |
| /images/SB_Logo.png |
And wait while transcoding is finished in folder '/F_UCSAARFRAOD_1' on project 'P_UCSAARFRAOD_1' files page
And go to file 'logo.gif' in '/F_UCSAARFRAOD_1' in project 'P_UCSAARFRAOD_1' on related files page
And type related file 'logo*' on related files page on pop-up
And select and save following related files 'logo.png' on related file pop-up
And go to asset 'SB_Logo.png' info page in Library for collection 'My Assets' on related assets page
And type related asset 'logo1.gif' on related assets page on pop-up
And select following related files 'logo1.gif' on related asset pop-up
And wait for '3' seconds
And go to Dashboard page
And click file 'logo.png' link in 'added related files(s)' activity in My Recent Activity section on Dashboard page
Then I 'should' be on the file info page


Scenario: Check that link to related assets works fine from dashboard
!--05/10 - Confirmed with Maria that this activity neednt be shown on Dashboard--but needs to only show on File activities
Meta: @skip
      @gdam
Given I created the agency 'A_UCSAARFRAOD_1' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique    |
| U_UCSAARFRAOD_S02 | agency.admin | A_UCSAARFRAOD_1 |
When I login with details of 'U_UCSAARFRAOD_S02'
And upload following assets:
| Name                |
| /files/logo1.gif    |
| /images/SB_Logo.png |
And wait while transcoding is finished in collection 'My Assets'
And go to asset 'SB_Logo.png' info page in Library for collection 'My Assets' on related assets page
And type related asset 'logo1.gif' on related assets page on pop-up
And select following related files 'logo1.gif' on related asset pop-up
And wait for '3' seconds
And go to Dashboard page
And click file 'logo1.gif' link in 'added related files(s)' activity in My Recent Activity section on Dashboard page
Then I 'should' be on the file info page


Scenario: Check that activity about adding 10 assets to 1 is displayed proper on dashboard
!--05/10 - Confirmed with Maria that this activity neednt be shown on Dashboard--but needs to only show on File activities
Meta: @skip
      @gdam
Given I created the agency 'A_UCSAARFRAOD_1' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique |
| U_UCSAARFRAOD_S03 | agency.admin | A_UCSAARFRAOD_1 |
When I login with details of 'U_UCSAARFRAOD_S03'
And upload following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
| /files/Fish3-Ad.mov  |
| /files/Fish4-Ad.mov  |
| /files/Fish5-Ad.mov  |
| /files/Fish6-Ad.mov  |
| /files/Fish7-Ad.mov  |
| /files/Fish8-Ad.mov  |
| /files/Fish9-Ad.mov  |
| /files/Fish10-Ad.mov |
| /files/Fish11-Ad.mov |
| /files/Fish12-Ad.mov |
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets' on related assets page
And type related asset '.mov' on related assets page on pop-up
And select following related files 'Fish2-Ad.mov,Fish3-Ad.mov,Fish4-Ad.mov,Fish5-Ad.mov,Fish6-Ad.mov,Fish7-Ad.mov,Fish8-Ad.mov,Fish9-Ad.mov,Fish10-Ad.mov,Fish11-Ad.mov,Fish12-Ad.mov' on related asset pop-up
And wait for '3' seconds
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName          | Message                | Value                                                                                                                                                                       |
| U_UCSAARFRAOD_S03 | added related files(s) | Fish1-Ad.mov to Fish2-Ad.mov, Fish3-Ad.mov, Fish4-Ad.mov, Fish5-Ad.mov, Fish6-Ad.mov, Fish7-Ad.mov, Fish8-Ad.mov, Fish9-Ad.mov, Fish10-Ad.mov, Fish11-Ad.mov, Fish12-Ad.mov |


Scenario: Check that activity about removing related files is displayed proper on dashboard
!--05/10 - Confirmed with Maria that this activity neednt be shown on Dashboard--but needs to only show on File activities
Meta: @skip
      @gdam
Given I created the agency 'A_UCSAARFRAOD_1' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique    |
| U_UCSAARFRAOD_S04 | agency.admin | A_UCSAARFRAOD_1 |
And logged in with details of 'U_UCSAARFRAOD_S04'
And created 'P_UCSAARFRAOD_1' project
And created '/folder' folder for project 'P_UCSAARFRAOD_1'
And uploaded into project 'P_UCSAARFRAOD_1' following files:
| FileName          | Path    |
| /images/logo.gif  | /folder |
| /images/logo.jpg  | /folder |
And waited while transcoding is finished in folder '/folder' on project 'P_UCSAARFRAOD_1' files page
And opened file 'logo.gif' in '/folder' in project 'P_UCSAARFRAOD_1' on related files page
And typed related file 'logo.jpg' on related files page on pop-up
And selected and save following related files 'logo.jpg' on related file pop-up
When I delete following files 'logo.jpg' on related files page
And wait for '3' seconds
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName          | Message                 | Value                  |
| U_UCSAARFRAOD_S04 | deleted related file(s) | logo.gif from logo.jpg |


Scenario: Check that activity about removing related assets is displayed proper on dashboard
!--05/10 - Confirmed with Maria that this activity neednt be shown on Dashboard--but needs to only show on File activities
Meta: @skip
      @gdam
Given I created the agency 'A_UCSAARFRAOD_1' with default attributes
And created users with following fields:
| Email             | Role         | AgencyUnique    |
| U_UCSAARFRAOD_S05 | agency.admin | A_UCSAARFRAOD_1 |
And logged in with details of 'U_UCSAARFRAOD_S05'
Given I uploaded following assets:
| Name                     |
| /files/128_shortname.jpg |
| /files/120.600.gif       |
And waited while transcoding is finished in collection 'Everything'
And on asset '128_shortname.jpg' info page in Library for collection 'Everything' on related assets page
And typed related asset '120.600.gif' on related assets page on pop-up
And selected following related files '120.600.gif' on related asset pop-up
When I delete following files '120.600.gif' on related assets page
And wait for '3' seconds
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName          | Message                 | Value                              |
| U_UCSAARFRAOD_S05 | deleted related file(s) | 128_shortname.jpg from 120.600.gif |