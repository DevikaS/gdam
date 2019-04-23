!--NGN-180
Feature:          Address Book - Team Templates
Narrative:
In order to
As a              AgencyAdmin
I want to         Check user's address book - team templates

Scenario: Create a new template
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I created users with following fields:
| Email |
| UTT41 |
And added following users to address book:
| UserName |
| UTT41    |
And created 'PRTT4' role in 'project' group for advertiser 'DefaultAgency'
And I am on Address Book page
And I clicked Add to team template for users:
| UserName |
| UTT41    |
When I create team template with name 'NewTT4'
Then I 'should' see 'NewTT4' in the Team Templates list


Scenario: Checking via team template that user is added into team template
Meta:@gdam
     @projects
Given I created users with following fields:
| Email |
| UTTA1 |
| UTTA2 |
| UTTA3 |
| UTTA4 |
And added following users to address book:
| UserName |
| UTTA1    |
| UTTA2    |
| UTTA3    |
| UTTA4    |
And created '<Role>' role in 'project' group for advertiser 'DefaultAgency'
And added '<users>' to team template '<teamTemplate>'
And I am on Address Book page
When I select team template '<teamTemplate>' on Address book page
Then I '<should>' see that user '<users>' is in the team template '<teamTemplate>'

Examples:
| users             | teamTemplate | Role   | should |
| UTTA1,UTTA2,UTTA3 | 1TTemplate1  | PRTTA1 | should |


Scenario: Checking via user details that user is added into team template
Meta:@skip
     @gdam
!--NGN-16445-As Maria said this has never worked. Please remove this test.
Given I created users with following fields:
| Email |
| UTTB1 |
And added following users to address book:
| UserName |
| UTTB1    |
And created '<Role>' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template '<teamTemplate>':
| UserName |
| UTTB1    |
And I am on Address Book page
When I select user link 'UTTB1' on Address Book
Then I '<should>' see team template '<teamTemplate>' and role '<Role>' as team template (role) under Templates Information on User details

Examples:
| userName | teamTemplate | Role   | should |
| UTTB1    | ttAddU1      | PRTTB1 | should |


Scenario: Checking that user can be removed from team template via user details
Meta:@skip
     @gdam
!--NGN-16445-As Maria said this has never worked. Please remove this test.
Given I created users with following fields:
| Email |
| UTTC1 |
And added following users to address book:
| UserName |
| UTTC1    |
And created '<Role>' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template '<teamTemplate>':
| UserName |
| UTTC1    |
And I am on Address Book page
And I selected user link 'UTTC1' on Address Book
When I click remove link next to team template '<teamTemplate>'
Then I 'should not' see team template '<teamTemplate>' and role '<Role>' as team template (role) under Templates Information on User details
And I 'should' see user email: 'UTTC1'

Examples:
| userName | teamTemplate | Role   | should |
| UTTC1    | ttRemoveU1   | PRTTC1 | should |


Scenario: Empty team template isn't displayed in Team Templates
Meta:@gdam
      @projects
Given I created users with following fields:
| Email |
| UTTD1 |
And added following users to address book:
| UserName |
| UTTD1    |
And created '<Role>' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template '<teamTemplate>':
| UserName |
| UTTD1    |
And I am on Address Book page
And I selected user link 'UTTD1' on Address Book
When I click remove link next to team template '<teamTemplate>'
Then I 'should not' see '<teamTemplate>' in the Team Templates list

Examples:
| userName | teamTemplate | Role   | should |
| UTTD1    | ttEmpty1     | PRTTD1 | should |


Scenario: User role in the template can be changed
Meta:@skip
     @gdam
!--As Maria said this is old functionality no need to test it
Given I created users with following fields:
| Email |
| UTTE1 |
And added following users to address book:
| UserName |
| UTTE1    |
And created 'PRTTE1' role in 'project' group for advertiser 'DefaultAgency'
And created 'PRTTE1c' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'ttChRole1':
| UserName |
| UTTE1    |
And I am on Address Book page
And I selected team template 'ttChRole1' on Address book page
And I clicked Add to team template for users:
| UserName |
| UTTE1    |
When I edit team template with name 'ttChRole1'
Then I 'should' see that user 'UTTE1' is in the team template 'ttChRole1' count '1'


Scenario: Removing user from team template will not affect projects where this template has been applied earlier
Meta:@gdam
      @projects
Given I created 'PSP1' project
And created '/PSF1' folder for project 'PSP1'
And created 'PRTTF1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email |
| UTTF1 |
And added following users to address book:
| UserName |
| UTTF1    |
And added following users to team template 'TTR1':
| UserName |
| UTTF1    |
And I added team template 'TTR1' to project 'PSP1' team folders '/PSF1' with role 'PRTTF1' expired '12.12.2021'
And I am on Address Book page
And I selected user link 'UTTF1' on Address Book
When I click remove link next to team template 'TTR1'
And go to project 'PSP1' teams page
Then I should see 'UTTF1' user name and 'PRTTF1' role in teams of 'PSP1' project


Scenario: Check that user can be added to several team templates
Meta:@bug
     @gdam
     @projects
!--NGN-16380
Given I created users with following fields:
| Email |
| UTTH1 |
| UTTH2 |
And added following users to address book:
| UserName |
| UTTH1    |
| UTTH2    |
And created 'PRTTH1' role in 'project' group for advertiser 'DefaultAgency'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| UTTH1    | STT1         |
| UTTH1    | STT2         |
And I am on Address Book page
And I selected 'UTTH2' on Address Book
And I clicked Add to team template for users:
| UserName |
| UTTH2    |
When I add user into few team templates:
| TeamTemplate |
| STT1         |
| STT2         |
And I select user link 'UTTH2' on Address Book
Then I 'should' see team template (role) under Templates Information on User details with next fields:
| UserName | TeamTemplate | Role   | should |
| UTTH2    | STT1         | PRTTH1 | should |
| UTTH2    | STT2         | PRTTH1 | should |


Scenario: Check that contact is removed from all team templates in case to remove contact from Address Book
Meta:@skip
     @gdam
!--NGN-16445
Given I created users with following fields:
| Email |
| UTTI1 |
| UTTI2 |
And added following users to address book:
| UserName |
| UTTI1    |
| UTTI2    |
And created 'PRTTI1' role in 'project' group for advertiser 'DefaultAgency'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| UTTI1    | ArSTT1       |
| UTTI2    | ArSTT1       |
And I am on Address Book page
When I delete contact 'UTTI2' 'confirm'
And I select team template 'ArSTT1' on Address book page
Then I 'should' see that user 'UTTI1' is in the team template 'ArSTT1' count '1'
Then I 'should not' see that user 'UTTI2' is in the team template 'ArSTT1' count '1'


Scenario: Check that user cannot create team template with the same name
Meta:@skip
     @gdam
!--NGN-16445
Given I created users with following fields:
| Email |
| UTTJ1 |
| UTTJ2 |
| UTTJ3 |
| UTTJ4 |
And added following users to address book:
| UserName |
| UTTJ1    |
| UTTJ2    |
| UTTJ3    |
| UTTJ4    |
And created 'PRTTJ1' role in 'project' group for advertiser 'DefaultAgency'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| UTTJ1    | ttExistName1 |
And I am on Address Book page
When I select 'UTTJ2' on Address Book
And I click Add to team template for users 'UTTJ2'
And I fill team templates 'ttExistName1' as 'new'
And I click add button on the Add users team template popup
And I select team template 'ttExistName1' on Address book page
Then I 'should' see that user 'UTTJ1,UTTJ2' is in the team template 'ttExistName1'


Scenario: Check that user can rename name of team template if template name already exist
Meta:@skip
     @gdam
!--As Maria said this is old functionality no need to test it
Given I created users with following fields:
| Email |
| UTTL1 |
| UTTL2 |
And added following users to address book:
| UserName |
| UTTL1    |
| UTTL2    |
And created 'PRTTL1' role in 'project' group for advertiser 'DefaultAgency'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| UTTL1    | ttRename1    |
And I am on Address Book page
And I selected 'UTTL2' on Address Book
And I clicked Add to team template for users 'UTTL2'
And I filled team templates 'ttRename1' as 'new'
And I clicked add button on the Add users team template popup
And I clicked Rename Current link
And I filled team templates 'ttRename1new' as 'new'
And I clicked add button on the Add users team template popup
When I select team template 'ttRename1' on Address book page
Then I 'should not' see that user 'UTTL2' is in the team template 'ttRename1' count '1'
When I select team template 'ttRename1new' on Address book page
Then I 'should' see that user 'UTTL2' is in the team template 'ttRename1new' count '1'


Scenario: Check that list of team templates created by current user isn't available for others
Meta:@gdam
     @projects
Given I created users with following fields:
| Email | Agency        |
| UL1   | AnotherAgency |
| UL2   | DefaultAgency |
| UTTM1 | DefaultAgency |
And added following users to address book:
| UserName |
| UTTM1    |
And created 'PRTTM1' role in 'project' group for advertiser 'DefaultAgency'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| UTTM1    | ttAnotherU1  |
| UTTM1    | ttAnotherU2  |
| UTTM1    | ttAnotherU3  |
And I logged in with details of '<UserName>'
When I go on Address Book page
Then I '<Should>' see team templates '<TeamTemplates>'

Examples:
| UserName | TeamTemplates                       | Should     |
| UL1      | ttAnotherU1,ttAnotherU2,ttAnotherU3 | should not |


Scenario: Delete of several users from Team Templates
Meta:@gdam
     @projects
Given I created users with following fields:
| Email |
| UTTN1 |
| UTTN2 |
| UTTN3 |
| UTTN4 |
And added following users to address book:
| UserName |
| UTTN1    |
| UTTN2    |
| UTTN3    |
| UTTN4    |
And created 'PRTTN1' role in 'project' group for advertiser 'DefaultAgency'
And I added users to team template with the following fields:
| UserName | TeamTemplate  |
| UTTN1    | ttDeleteFewU1 |
| UTTN2    | ttDeleteFewU1 |
| UTTN3    | ttDeleteFewU1 |
| UTTN4    | ttDeleteFewU1 |
And I am on Address Book page
And I selected team template 'ttDeleteFewU1' on Address book page
When I select users on Address book:
| UserName |
| UTTN2    |
| UTTN3    |
| UTTN4    |
And click remove button on Adressbook page
Then I see users in the user's list with next rules:
| UserName | Should     |
| UTTN1    | should     |
| UTTN2    | should not |
| UTTN3    | should not |
| UTTN4    | should not |



Scenario: Adding of several users in existing Team Templates
Meta:@gdam
     @projects
Given I created users with following fields:
| Email |
| UTTO1 |
| UTTO2 |
| UTTO3 |
| UTTO4 |
| UTTO5 |
And added following users to address book:
| UserName |
| UTTO1    |
| UTTO2    |
| UTTO3    |
| UTTO4    |
| UTTO5    |
And created 'PRTTO1' role in 'project' group for advertiser 'DefaultAgency'
And I added user '<UserName>' to team template '<TeamTemplate>'
And I am on Address Book page
When I click Add to team template for users '<AdditionUsersName>'
And I fill team templates '<TeamTemplate>' as 'exist'
And I click add button on the Add users team template popup
And I select team template '<TeamTemplate>' on Address book page
Then I 'should' see users '<AdditionUsersName>' in list

Examples:
| UserName | TeamTemplate | Role   | AdditionUsersName       |
| UTTO5    | AbSTT1       | PRTTO1 | UTTO1,UTTO2,UTTO3,UTTO4 |

Scenario: Check that list of team templates is available in Project Teams tab for current user
Meta:@gdam
     @projects
Given I created 'PTTP1' project
And created '/PTTF1' folder for project 'PTTP1'
And I created users with following fields:
| Email |
| UTTP1 |
And added following users to address book:
| UserName |
| UTTP1    |
And created 'PRTTP1' role in 'project' group for advertiser 'DefaultAgency'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| UTTP1    | Btt1         |
| UTTP1    | Btt2         |
| UTTP1    | Btt3         |
And I am on project 'PTTP1' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberTeamTemplateItem' on page 'TeamsPage'
And I start type team templates 'B' name for project 'PTTP1'
Then I should see team templates in accordance with template 'B' for project 'PTTP1'


Scenario: Displaying of user contact details in selected team template
Meta:@gdam
     @projects
Given I created users with following fields:
| Email |
| UTTQ1 |
And added following users to address book:
| UserName |
| UTTQ1    |
And created 'PRTTQ1' role in 'project' group for advertiser 'DefaultAgency'
And I added user 'UTTQ1' to team template 'ZTT1'
And I am on Address Book page
And I selected team template 'ZTT1' on Address book page
When I click on user link 'UTTQ1' on Address Book
Then I 'should' see user email: 'UTTQ1'


Scenario: Display in user contact details only those templates in which user was added
Meta:@bug
     @gdam
     @projects
!--NGN-16380
Given I created users with following fields:
| Email |
| UTTR1 |
| UTTR2 |
And added following users to address book:
| UserName |
| UTTR1    |
| UTTR2    |
And created 'PRTTR1' role in 'project' group for advertiser 'DefaultAgency'
And I added user 'UTTR1' to team template 'ZTT1'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| UTTR1    | XZZ1         |
| UTTR1    | XZZ2         |
| UTTR1    | XZZ3         |
| UTTR1    | XZZ4         |
| UTTR1    | XZZ5         |
And I am on Address Book page
And I selected 'UTTR2' on Address Book
When I click Add to team template for users 'UTTR2'
And I fill team templates 'XZZ1,XZZ2,XZZ3' as 'exist'
And I click add button on the Add users team template popup
And I select user link 'UTTR2' on Address book
Then I 'should' see team template 'XZZ1,XZZ2,XZZ3' and role 'PRTTR1' as team template (role) under Templates Information on User details
And I 'should not' see team template 'XZZ4,XZZ5' and role 'PRTTR1' as team template (role) under Templates Information on User details