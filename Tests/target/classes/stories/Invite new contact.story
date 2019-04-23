!--NGN-2625 NGN-1877
Feature:          Invite new contact
Narrative:
In order to
As a              AgencyAdmin
I want to         Check inviting a new contact

Scenario: Check that 'Invite' button is available in Address Book only for users with global role included 'Invite User'
Meta:@gdam
@projects
Given I created '<RoleName>' role with '<Permissions>' permissions in 'global' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email      | Role       |
| <UserName> | <RoleName> |
And I logged in with details of '<UserName>'
And waited for '2' seconds
When I go on Address Book page
Then I '<Should>' see invite button on the Address book page

Examples:
| UserName    | Permissions | Should     | RoleName  |
| U_INCS_S1_1 | user.invite | should     | RG_INCS_S1|
| U_INCS_S1_2 |             | should not | RG_INCS_S2 |


Scenario: Check that invited users appears in Users list on Address Book
Meta:@gdam
@projects
Given I am on Address Book page
And I clicked invite button on the Address book page
And I typed 'esu_INCS_S5' user email on Invite user popup
When I click 'invite' invite user
Then I 'should' see user 'esu_INCS_S5' in Address Book


Scenario: Check correct format of entered email on Invite user pop-up
Meta:@gdam
@projects
Given I am on Address Book page
And I clicked invite button on the Address book page
When I type '<Value>' text on Invite user popup
Then I '<ShouldButton>' see that invite button is disabled on add user popup
And I '<ShouldValue>' see value '<Value>' on the invite users popup

Examples:
| Value             | ShouldButton | ShouldValue |
| @ds.ru            | should       | should not  |
| test@adstream.com | should not   | should      |


Scenario: Check that several users can be invited
Meta:@gdam
@projects
Given I am on Address Book page
And I clicked invite button on the Address book page
And I added following users to invite list:
| Email         |
| esu_INCS_S8_1 |
| esu_INCS_S8_2 |
| esu_INCS_S8_3 |
| esu_INCS_S8_4 |
| esu_INCS_S8_5 |
When I click 'invite' invite user
Then I should see next users in Address book:
| Email         | Should |
| esu_INCS_S8_1 | should |
| esu_INCS_S8_2 | should |
| esu_INCS_S8_3 | should |
| esu_INCS_S8_4 | should |
| esu_INCS_S8_5 | should |


Scenario: checking that after entering first name and last name and clicking accept - invited user receives email with new password
Meta: @skip
      @gdam
      @gdamemails
Given I am on Address Book page
And I clicked invite button on the Address book page
And I typed 'S17_A' user email on Invite user popup
And I clicked 'invite' invite user
And I logout from account
When I open link from email when user 'S17_A' received email with next subject 'You are invited to Adbank'
And I accept new user with first name 'Lizavetin' and last name 'Kaalesinda'
Then I 'should' see email notification for 'New login details' with field to 'S17_A' and subject 'Your new Adbank login details' contains following attributes:
| Agency        | UserName1 |
| DefaultAgency | S17_A     |


Scenario: check that user created via invitation can be logged into A5 and has all specified data (API Call)
Meta:@gdam
     @gdamemails
Given I am on Dashboard page
And invited user 'esu_S12'
And I logout from account
When I open link from email when user 'esu_S12' received email with next subject 'You are invited'
And I accept new user with first name 'Abdurahman' and last name 'Zirdanovich'
Then I 'should' see Projects page
And I should see element 'MainMenu' with text 'Abdurahman Zirdanovich' on page 'BasePage'
When I login with details of 'AgencyAdmin'
And go to Dashboard page
And go to user 'esu_S12' details page
Then I should see on user details page fields with following values:
| element   | value       |
| FirstName | Abdurahman  |
| LastName  | Zirdanovich |
| Role      | guest.user  |

Scenario: check that user created via invitation can be logged into A5 and has all specified data (from UI)
Meta: @qagdamsmoke
	  @livegdamsmoke
      @gdam
      @gdamemails
Given I am on Users list page
And I clicked invite button on the Users page
And I typed 'esu_S12_1' user email on Invite user popup in Users page
And I clicked 'invite' invite user in users page
And I logout from account
When I open link from invitation email to user 'esu_S12_1'
And I accept new user with first name 'Abdurahman' and last name 'Zirdanovich'
Then I 'should' see Projects page
And I should see element 'MainMenu' with text 'Abdurahman Zirdanovich' on page 'BasePage'
When I login with details of 'AgencyAdmin'
And go to Dashboard page
And go to user 'esu_S12_1' details page
Then I should see on user details page fields with following values:
| element   | value       |
| FirstName | Abdurahman  |
| LastName  | Zirdanovich |
| Role      | guest.user  |