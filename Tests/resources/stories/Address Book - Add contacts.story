!--NGN-180
Feature:          Address Book - Add contacts
Narrative:
In order to
As a              AgencyAdmin
I want to         check user's address book - contacts addition

Scenario: Add to contacts - add user by selecting user from list to contact list
Meta: @gdam
      @projects
Given I created 'ADNewUser3' User
And I am on add contact popup page
When I select user with name 'ADNewUser3' in AddUsersPopUp
And click element 'AddButton' on page 'AddressBookAddUsersPopUp'
Then I 'should' see user 'ADNewUser3' in Address Book


Scenario: Check that user from another agency can be added by typing email
Meta: @gdam
      @projects
Given I created 'ADNewUser6' User with 'MandatoryFieldsAnotherAgency'
When I add user 'ADNewUser6' to Address book
Then I 'should' see user 'ADNewUser6' in Address Book


Scenario: Check email validation for easyshare user
Meta: @gdam
      @projects
Given I am on add contact popup page
When I fill fields on page 'AddressBookAddUsersPopUp' in the following values:
| value  | field        |
| @ds.ru | EmailEditBox |
Then I should see text on page contains 'nothing found'


Scenario: Check that Email should be displayed in add contacts pop-up after changing it in users' profile
Meta: @gdam
      @projects
Given I created 'ADNewUser9' User with 'MandatoryFields'
And I am on user 'ADNewUser9' details page
When I edit user 'ADNewUser9' with following fields:
| Email         |
| ADNewUser9New |
And I go on Address Book page
When I add users 'ADNewUser9New' to Address book
And I select 'ADNewUser9New' on Address Book
Then I 'should' see user 'ADNewUser9New' in Address Book