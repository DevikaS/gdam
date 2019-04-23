!--NGN-879
Feature:          Address book - Edit contact details
Narrative:
In order to
As a              AgencyAdmin
I want to         Check edit contact details

Scenario: Check that fields are enabled
Meta: @gdam
      @projects
Given I created 'ANewUser0' User
And added user 'ANewUser0' into address book
And I am on Address Book page
When I click on user link 'ANewUser0' on Address Book
And I click element 'EditButton' on page 'AddressBook'
Then I should see elements on page 'AddressBook' in the following state:
| element  | state   |
| position | enabled |
| office   | enabled |
| mobile   | enabled |
| fax      | enabled |


Scenario: Check that for easyshare users company is not present
Meta:@skip
     @gdam
!--NGN-16380
Given I added user 'AESUser0' into address book
And I am on Address Book page
When I click on user link 'AESUser0' on Address Book
And I click element 'EditButton' on page 'AddressBook'
Then I should see fields on page 'AddressBook' with following values:
| field   | value |
| company |       |


Scenario: Check that for easyshare users name is not present
Meta:@skip
     @gdam
!--NGN-16380
Given I added user 'AESUser1' into address book
And I am on Address Book page
When I click on user link 'AESUser1' on Address Book
And I click element 'EditButton' on page 'AddressBook'
Then I should see in the field users name on edit contact details email 'AESUser1'


Scenario: Check that company is taken from user's company
Meta: @gdam
      @projects
!--NGN-1112
Given I created 'ANewUser6' User
And added user 'ANewUser6' into address book
And I am on Address Book page
When I click on user link 'ANewUser6' on Address Book
And I click element 'EditButton' on page 'AddressBook'
Then I should see Company field with valid value on Address book page