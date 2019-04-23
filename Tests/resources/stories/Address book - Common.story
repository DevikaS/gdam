!--NGN-180
Feature:          Address book - Common
Narrative:
In order to
As a              AgencyAdmin
I want to         Check user's address book

Scenario: Check that 'Select All' checkbox selects all contacts in Address Book
Meta:@bug
     @gdam
     @projects
!--FAB-453
Given I created users with following fields:
| Email              | Role         |
| AgencyAdminUser7   | agency.admin |
And added user 'AgencyAdminUser7' into address book
And I am on Address Book page
And I 'should not' see selected the following users on AddressBook
When I click element 'selectAll' on page 'AddressBook'
Then I 'should' see selected the following users on AddressBook


Scenario: Check confirmation in case to remove contact from Address Book
Meta: @gdam
      @projects
Given I created users with following fields:
| Email              | Role         |
| AgencyAdminUser1   | agency.admin |
| ANewUserForDelete1 | agency.user  |
And logged in with details of 'AgencyAdminUser1'
And added user 'ANewUserForDelete1' into address book
And I am on Address Book page
When I delete contact 'ANewUserForDelete1' 'confirm'
Then I 'should not' see User 'ANewUserForDelete1' on Address Book


Scenario: Check that new user can be created with same email of easyshare user that was added in Address Book
Meta: @gdam
      @projects
Given I added user 'Easyshare1' into address book
And I am on Create New User page
When I created user with following fields:
| FirstName | LastName   | Email      | Role        |
| Liona     | Panteleeva | Easyshare1 | agency.user |
And add user 'Easyshare1' to Address book
And I go on Address Book page
Then I see user in the user list with the following data:
| Name             | Email      | Result     |
| Liona Panteleeva |            | should     |


Scenario: Proper displaying of user logo in Add Contacts
Meta: @gdam
      @projects
Given I created users with following fields:
| Email     | Logo |
| logoEmail | JPEG |
When I go on Address Book page
And I click element 'AddContact' on page 'AddressBook'
And I type in element 'Email' on page 'AddressBook' email 'logoEmail'
Then I 'should' see 'logoEmail' in Add Contacts on AddressBook page with logo 'JPEG'


Scenario: Proper displaying of user logo and metadata in Address book list
Meta:@bug
     @gdam
     @projects
!--NGN-16380
Given I created users with following fields:
| Email | Role        | Logo | Agency        |
| ULM1  | agency.user | GIF  | AnotherAgency |
| ULM2  | agency.user | PNG  | DefaultAgency |
And I added user 'ULM1' into address book
And I added user 'ULM2' into address book
When I go on Address Book page
Then I see contact in the user list with the following data:
| Email | Logo | Company       | Result |
| ULM1  | GIF  | AnotherAgency | should |
| ULM2  | PNG  | DefaultAgency | should |


Scenario: User shouldn't have opportunity to add two users with same emails to address book
Meta: @gdam
      @projects
!--NGN-1282
Given I added user 'testDuplicate' into address book
When I go on Address Book page
Then on adding users 'testDuplicate' to Address book should see message 'Contact qatbabylonautotester.*testDuplicate.* already exists in addressbook'