!--NGN-32 NGN-1343
Feature:          Template Teams - Permissions changes
Narrative:
In order to
As a              AgencyAdmin
I want to         Check permissions changes for Template Teams

Scenario: Check that folder hierarchy is updated in Add member > User pop-up
Meta:@gdam
@projects
Given I created 'T_TTPC_S01' template
And created '/F1' folder for template 'T_TTPC_S01'
When I go to template 'T_TTPC_S01' teams page
And I refresh the page
And click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I should see following folders in add user to template 'T_TTPC_S01' team popup:
| folder |
| /F1    |
When I go to template 'T_TTPC_S01' files page
And refresh the page
And create '/F1/F2' folder in 'T_TTPC_S01' template
And create '/F3' folder in 'T_TTPC_S01' template
And go to template 'T_TTPC_S01' teams page
And I refresh the page
And click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
Then I should see following folders in add user to template 'T_TTPC_S01' team popup:
| folder |
| /F1/F2 |
| /F3    |


Scenario: Check that user is removed from Teams when Expiration date is passed
!--FAB-473
Meta:@gdam
     @bug
     @projects
Given I created 'T_TTPC_S02' template
And created '/F1' folder for template 'T_TTPC_S02'
And created users with following fields:
| Email      | Role       |
| U_TTPC_S02 | guest.user |
And created 'R_TTPC_S02' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_TTPC_S02' to template 'T_TTPC_S02' team folders '/F1' with role 'R_TTPC_S02' expired '11.11.2011'
When I wait for '60' seconds
And go to template 'T_TTPC_S02' teams page
Then I 'should not' see user 'U_TTPC_S02' name in teams of template 'T_TTPC_S02'


Scenario: Check that team template users are removed from Teams when 'Expiration Date' date is passed for Templates
!--FAB-473
Meta:@gdam
     @bug
     @projects
Given I created 'T_TTPC_S03' template
And created '/F1' folder for template 'T_TTPC_S03'
And created users with following fields:
| Email        | Role       |
| U_TTPC_S03_1 | guest.user |
| U_TTPC_S03_2 | guest.user |
| U_TTPC_S03_3 | guest.user |
And added following users to address book:
| UserName     |
| U_TTPC_S03_1 |
| U_TTPC_S03_2 |
| U_TTPC_S03_3 |
And created 'R_TTPC_S03' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'TT_TTPC_S03':
| UserName     |
| U_TTPC_S03_1 |
| U_TTPC_S03_2 |
| U_TTPC_S03_3 |
And added team template 'TT_TTPC_S03' to template 'T_TTPC_S03' team folders '/F1' with role 'R_TTPC_S03' expired '11.11.2011'
When I wait for '60' seconds
And go to template 'T_TTPC_S03' teams page
Then I 'should not' see following users on template 'T_TTPC_S03' team page:
| UserName     |
| U_TTPC_S03_1 |
| U_TTPC_S03_2 |
| U_TTPC_S03_3 |


Scenario: Check if access is removed from all folders, user should not be displayed on Team page anymore
Meta:@gdam
@projects
!--NGN-2149
Given I created 'T_TTPC_S04' template
And created '/F1' folder for template 'T_TTPC_S04'
And created users with following fields:
| Email      | Role       |
| U_TTPC_S04 | guest.user |
And created 'R_TTPC_S04' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_TTPC_S04' to template 'T_TTPC_S04' team folders '/F1' with role 'R_TTPC_S04' expired '12.12.2021'
When I go to template 'T_TTPC_S04' teams page
And open user 'U_TTPC_S04' permissions on template 'T_TTPC_S04' team page
And toggle folder '/F1' in manage permissions popup of template 'T_TTPC_S04' team for user 'U_TTPC_S04'
And remove 'R_TTPC_S04' role on permissions popup of project team tab
And click element 'SaveButton' on page 'AddTeamUserPopUp'
And refresh the page
Then I 'should not' see user 'U_TTPC_S04' name in teams of template 'T_TTPC_S04'


Scenario: Check if access is removed from all folders, users from team template should not be displayed on Team page anymore
Meta:@gdam
@projects
!--NGN-2149
Given I created 'T_TTPC_S05' template
And created in 'T_TTPC_S05' template next folders:
| folder |
| /F1    |
| /F2    |
And created users with following fields:
| Email        | Role       |
| U_TTPC_S05_1 | guest.user |
| U_TTPC_S05_2 | guest.user |
And added following users to address book:
| UserName     |
| U_TTPC_S05_1 |
| U_TTPC_S05_2 |
And created 'R_TTPC_S05' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'TT_TTPC_S05':
| UserName     |
| U_TTPC_S05_1 |
| U_TTPC_S05_2 |
And added team template 'TT_TTPC_S05' to template 'T_TTPC_S05' team folders '/F1,/F2' with role 'R_TTPC_S05' expired '12.12.2021'
When I go to template 'T_TTPC_S05' teams page
And open user 'U_TTPC_S05_1' permissions on template 'T_TTPC_S05' team page
And toggle folder '/F1' in manage permissions popup of template 'T_TTPC_S05' team for user 'U_TTPC_S05_1'
And remove 'R_TTPC_S05' role on permissions popup of project team tab
And toggle folder '/F2' in manage permissions popup of template 'T_TTPC_S05' team for user 'U_TTPC_S05_1'
And remove 'R_TTPC_S05' role on permissions popup of project team tab
And click Save button on permissions popup of project team tab
And open user 'U_TTPC_S05_2' permissions on template 'T_TTPC_S05' team page
And toggle folder '/F1' in manage permissions popup of template 'T_TTPC_S05' team for user 'U_TTPC_S05_2'
And remove 'R_TTPC_S05' role on permissions popup of project team tab
And toggle folder '/F2' in manage permissions popup of template 'T_TTPC_S05' team for user 'U_TTPC_S05_2'
And remove 'R_TTPC_S05' role on permissions popup of project team tab
And click Save button on permissions popup of project team tab
And refresh the page
Then I 'should not' see following users on template 'T_TTPC_S05' team page:
| UserName     |
| U_TTPC_S05_1 |
| U_TTPC_S05_2 |


Scenario: Check re-add user to several folders with another permission
!--FAB-780 5.7.0_bug
Meta:@gdam
@projects
Given I created 'T_TTPC_S06' template
And created in 'T_TTPC_S06' template next folders:
| folder |
| /F1/F2 |
| /F3    |
And created users with following fields:
| Email      | Role       |
| U_TTPC_S06 | guest.user |
And created following roles:
| RoleName   | Group   |
| R_TTPC_S61 | project |
| R_TTPC_S62 | project |
| R_TTPC_S63 | project |
And added users 'U_TTPC_S06' to template 'T_TTPC_S06' team folders '/F1' with role 'R_TTPC_S61' expired '12.12.2021'
And added users 'U_TTPC_S06' to template 'T_TTPC_S06' team folders '/F1/F2' with role 'R_TTPC_S62' expired '12.12.2021'
And added users 'U_TTPC_S06' to template 'T_TTPC_S06' team folders '/F1/F2' with role 'R_TTPC_S63' expired '12.12.2021'
When I go to template 'T_TTPC_S06' teams page
Then I should see user 'U_TTPC_S06' has role 'R_TTPC_S61,R_TTPC_S62,R_TTPC_S63' on template 'T_TTPC_S06' team page


Scenario: Check re-add user to folders with same permission
!--FAB-780 5.7.0_bug
Meta:@gdam
@projects
Given I created 'T_TTPC_S07' template
And created in 'T_TTPC_S07' template next folders:
| folder |
| /F1    |
| /F2    |
And created users with following fields:
| Email      | Role       |
| U_TTPC_S07 | guest.user |
And created 'R_TTPC_S07' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_TTPC_S07' to template 'T_TTPC_S07' team folders '/F1,/F2' with role 'R_TTPC_S07' expired '12.12.2021'
When I go to template 'T_TTPC_S07' teams page
And add user 'U_TTPC_S07' into template 'T_TTPC_S07' team with role 'R_TTPC_S07' expired '12.12.2021' for following folders on popup:
| Folder |
| /F1    |
| /F2    |
Then I should see user 'U_TTPC_S07' has role 'R_TTPC_S07' on template 'T_TTPC_S07' team page



Scenario: Check re-add team template to folders with same permission
!--FAB-780 5.7.0_bug
Meta:@gdam
@projects
Given I created 'T_TTPC_S08' template
And created in 'T_TTPC_S08' template next folders:
| folder |
| /F1    |
| /F2    |
And created users with following fields:
| Email        | Role       |
| U_TTPC_S08_1 | guest.user |
| U_TTPC_S08_2 | guest.user |
And added following users to address book:
| UserName     |
| U_TTPC_S08_1 |
| U_TTPC_S08_2 |
And created 'R_TTPC_S08' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'TT_TTPC_S08':
| UserName     |
| U_TTPC_S08_1 |
| U_TTPC_S08_2 |
And added team template 'TT_TTPC_S08' to template 'T_TTPC_S08' team folders '/F1,/F2' with role 'R_TTPC_S08' expired '12.12.2021'
When I go to template 'T_TTPC_S08' teams page
And add team template 'TT_TTPC_S08' into template 'T_TTPC_S08' team expired '12.12.2021' for following folders:
| Folder |  Role         |
| /F1    |R_TTPC_S08|
| /F2    |R_TTPC_S08|
Then I should see user 'U_TTPC_S08_1' has role 'R_TTPC_S08' on template 'T_TTPC_S08' team page
And should see user 'U_TTPC_S08_2' has role 'R_TTPC_S08' on template 'T_TTPC_S08' team page


Scenario: Check re-add user to several folders with another Expiration date date
!--NGN-1866
Meta: @skip
      @gdam
Given I created 'T_TTPC_S09' template
And created in 'T_TTPC_S09' template next folders:
| folder |
| /F1    |
| /F2    |
And created users with following fields:
| Email      | Role       |
| U_TTPC_S09 | guest.user |
And created 'R_TTPC_S09' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_TTPC_S09' to template 'T_TTPC_S09' team folders '/F1,/F2' with role 'R_TTPC_S09' expired '12.12.2022'
When I go to template 'T_TTPC_S09' teams page
And add user 'U_TTPC_S09' into template 'T_TTPC_S09' team with role 'R_TTPC_S09' expired '12.12.2030' for following folders:
| Folder |
| /F1    |
| /F2    |
And open user 'U_TTPC_S09' permissions on template 'T_TTPC_S09' team page
Then I should see following role settings for folders in manage permissions popup of template 'T_TTPC_S09' team for user 'U_TTPC_S09':
| Folder | Role       | Expiration |
| /F1    | R_TTPC_S09 | 12.12.2030 |
| /F2    | R_TTPC_S09 | 12.12.2030 |


Scenario: Check re-add team template user to several folders with another Expiration date
!--NGN-1866
Meta: @skip
      @gdam
Given I created 'T_TTPC_S10' template
And created in 'T_TTPC_S10' template next folders:
| folder |
| /F1    |
| /F2    |
And created users with following fields:
| Email        | Role       |
| U_TTPC_S10_1 | guest.user |
| U_TTPC_S10_2 | guest.user |
And added following users to address book:
| UserName     |
| U_TTPC_S10_1 |
| U_TTPC_S10_2 |
And created 'R_TTPC_S10' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'TT_TTPC_S10':
| UserName     |
| U_TTPC_S10_1 |
| U_TTPC_S10_2 |
And added team template 'TT_TTPC_S10' to template 'T_TTPC_S10' team folders '/F1,/F2' with role 'R_TTPC_S10' expired '12.12.2022'
When I go to template 'T_TTPC_S10' teams page
And add team template 'TT_TTPC_S10' into template 'T_TTPC_S10' team expired '12.12.2030' for following folders:
| Folder |
| /F1    |
| /F2    |
And open user 'U_TTPC_S10_1' permissions on template 'T_TTPC_S10' team page
Then I should see following role settings for folders in manage permissions popup of template 'T_TTPC_S10' team for user 'U_TTPC_S10_1':
| Folder | Role       | Expiration |
| /F1    | R_TTPC_S10 | 12.12.2030 |
| /F2    | R_TTPC_S10 | 12.12.2030 |


Scenario: Check add user to folders on one root with different permission
Meta:@gdam
@projects
Given I created 'T_TTPC_S11' template
And created in 'T_TTPC_S11' template next folders:
| folder |
| /F1/F2 |
| /F3    |
And created users with following fields:
| Email      | Role       |
| U_TTPC_S11 | guest.user |
And created following roles:
| RoleName     | Group   |
| R_TTPC_S11_1 | project |
| R_TTPC_S11_2 | project |
| R_TTPC_S11_3 | project |
And added users 'U_TTPC_S11' to template 'T_TTPC_S11' team folders '/F1' with role 'R_TTPC_S11_1' expired '12.12.2021'
And added users 'U_TTPC_S11' to template 'T_TTPC_S11' team folders '/F1/F2' with role 'R_TTPC_S11_2' expired '12.12.2021'
And added users 'U_TTPC_S11' to template 'T_TTPC_S11' team folders '/F3' with role 'R_TTPC_S11_3' expired '12.12.2021'
When I go to template 'T_TTPC_S11' teams page
And open user 'U_TTPC_S11' permissions on template 'T_TTPC_S11' team page
Then I should see following role settings for folders in manage permissions popup of template 'T_TTPC_S11' team for user 'U_TTPC_S11':
| Folder | Role         | Expiration |
| /F1    | R_TTPC_S11_1 | 12.12.2021 |
| /F1/F2 | R_TTPC_S11_2 | 12.12.2021 |
| /F3    | R_TTPC_S11_3 | 12.12.2021 |


Scenario: After delete shared folder,share user should disappear from list
Meta:@gdam
@projects
!--NGN-1770
Given I created 'T_TTPC_S12' template
And created '/F1' folder for template 'T_TTPC_S12'
And created users with following fields:
| Email      | Role       |
| U_TTPC_S12 | guest.user |
And created 'R_TTPC_S12' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_TTPC_S12' to template 'T_TTPC_S12' team folders '/F1' with role 'R_TTPC_S12' expired '12.12.2021'
When I go to template 'T_TTPC_S12' files page
And delete folder '/F1' in template 'T_TTPC_S12'
And go to template 'T_TTPC_S12' teams page
Then I 'should not' see user 'U_TTPC_S12' name in teams of template 'T_TTPC_S12'


Scenario: After delete shared folder,share user from template should disappear from list
Meta:@gdam
@projects
!--NGN-1770
Given I created 'T_TTPC_S13' template
And created '/F1' folder for template 'T_TTPC_S13'
And created users with following fields:
| Email        | Role       |
| U_TTPC_S13_1 | guest.user |
| U_TTPC_S13_2 | guest.user |
And created 'R_TTPC_S13' role in 'project' group for advertiser 'DefaultAgency'
And added following users to address book:
| UserName     |
| U_TTPC_S13_1 |
| U_TTPC_S13_2 |
And added following users to team template 'TT_TTPC_S13':
| UserName     |
| U_TTPC_S13_1 |
| U_TTPC_S13_2 |
And added team template 'TT_TTPC_S13' to template 'T_TTPC_S13' team folders '/F1' with role 'R_TTPC_S13' expired '12.12.2021'
When I go to template 'T_TTPC_S13' files page
And delete folder '/F1' in template 'T_TTPC_S13'
And go to template 'T_TTPC_S13' teams page
Then I 'should not' see following users on template 'T_TTPC_S13' team page:
| UserName     |
| U_TTPC_S13_1 |
| U_TTPC_S13_2 |


Scenario: After rename shared folder,share user should stay in list
Meta:@gdam
@projects
Given I created 'T_TTPC_S14' template
And created '/F1' folder for template 'T_TTPC_S14'
And created users with following fields:
| Email      | Role       |
| U_TTPC_S14 | guest.user |
And created 'R_TTPC_S14' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_TTPC_S14' to template 'T_TTPC_S14' team folders '/F1' with role 'R_TTPC_S14' expired '12.12.2021'
When I go to template 'T_TTPC_S14' files page
And rename folder '/F1' to 'Fnew' in 'T_TTPC_S14' template
And go to template 'T_TTPC_S14' teams page
Then I 'should' see user 'U_TTPC_S14' name in teams of template 'T_TTPC_S14'


Scenario: After rename shared folder,share users from template should stay in list
Meta:@gdam
@projects
Given I created 'T_TTPC_S15' template
And created '/F1' folder for template 'T_TTPC_S15'
And created users with following fields:
| Email        | Role       |
| U_TTPC_S15_1 | guest.user |
| U_TTPC_S15_2 | guest.user |
And created 'R_TTPC_S15' role in 'project' group for advertiser 'DefaultAgency'
And added following users to address book:
| UserName     |
| U_TTPC_S15_1 |
| U_TTPC_S15_2 |
And added following users to team template 'TT_TTPC_S15':
| UserName     |
| U_TTPC_S15_1 |
| U_TTPC_S15_2 |
And added team template 'TT_TTPC_S15' to template 'T_TTPC_S15' team folders '/F1' with role 'R_TTPC_S15' expired '12.12.2021'
When I go to template 'T_TTPC_S15' files page
And rename folder '/F1' to 'Fnew' in 'T_TTPC_S15' template
And go to template 'T_TTPC_S15' teams page
Then I 'should' see following users on template 'T_TTPC_S15' team page:
| UserName     |
| U_TTPC_S15_1 |
| U_TTPC_S15_2 |