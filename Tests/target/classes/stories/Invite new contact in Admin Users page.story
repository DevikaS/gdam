Feature:          Invite new contact
Narrative:
In order to
As a              AgencyAdmin
I want to         Check inviting a new contact in users tab


Scenario: check that user created via invitation can be logged into A5 and has all specified data
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @gdamemails
      @gdamcrossbrowser
Given I am on Users list page
And I clicked invite button on the Users page
And I typed 'esu_S12' user email on Invite user popup in Users page
And I clicked 'invite' invite user in users page
And I logout from account
When I open link from email when user 'esu_S12' received email with next subject 'You are invited to Adbank'
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