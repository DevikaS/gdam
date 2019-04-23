!--NGN-210 NGN-1133
Feature:          My Profile - Preferences page
Narrative:
In order to
As a              AgencyAdmin
I want to         Check User Profile page

Scenario: User Profile/Preferences page
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email      | Role        | Unit      | Telephone     | MobileNumber  | SkypeNumber | GoogleTalkContact |
| UserFN    | UserLN   | agencyuser | agency.user | qa agency | +380971234567 | +380971234568 | skype       | google            |
And I logged in with details of 'agencyuser'
And I am on my profile page
Then I should see on my profile page fields with following values:
| element           | value         |
| FirstName         | UserFN        |
| LastName          | UserLN        |
| Email             | agencyuser    |
| Telephone         | +380971234567 |
| MobileNumber      | +380971234568 |
| SkypeNumber       | skype         |
| GoogleTalkContact | google        |


Scenario: check that role and access aren't appears for agency User
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email         | Role        |
| UserFN    | UserLN   | agencynewuser | agency.user |
And I logged in with details of 'agencynewuser'
And I am on my profile page
Then I 'should not' see following elements on page 'myprofile':
| element                     |
| Folders                     |
| Library                     |
| Ordering                    |
| ApplicationAccessCheckBoxes |
| UserRoleBox                 |


Scenario: check that Primary Email Address is readonly for agency User
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email          | Role        |
| UserFN    | UserLN   | agencynewuser2 | agency.user |
And I logged in with details of 'agencynewuser2'
And I am on my profile page
Then I should see email 'agencynewuser2' on my profile page
And Email is disabled on my profile page


Scenario: Successfully change data in profile
Meta:@gdam
@projects
Given I created users with following fields:
| Email  | Role         |
| MPPP_U | agency.admin |
And I logged in with details of 'MPPP_U'
And I am on my profile page
When I change fields on page 'myprofile' on following values:
| field     | value        |
| FirstName | AdminChanged |
| LastName  | testChanged  |
| Telephone | +3805555555  |
And click element 'Save' on page 'myprofile'
Then I should see element 'WarningMessage' with text 'User has been successfully saved' on page 'myprofile'
And should see fields on page 'myprofile' with following values:
| field     | value        |
| FirstName | AdminChanged |
| LastName  | testChanged  |
| Telephone | +3805555555  |


Scenario: Check mandatory fields
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email      | Role        |
| UserFN    | UserLN   | agencyuser | agency.user |
And I logged in with details of 'agencyuser'
And I am on my profile page
When I type in element '<field>' on page 'myprofile' text ''
Then I 'should' see element 'DisabledSaveButton' on page 'myprofile'
When I refresh the page
Then I should see fields on page 'myprofile' with following values:
| field     | value      |
| FirstName | UserFN     |
| LastName  | UserLN     |
| Email     | agencyuser |

Examples:
| field     |
| FirstName |
| LastName  |


Scenario: Successfully picture change
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email      | Role         |
| UserFN    | UserLN   | agencyuser | agency.admin |
And I logged in with details of 'agencyuser'
And I am on my profile page
When I upload logo '<Logo>' on user profile page
And click element 'Save' on page 'myprofile'
And refresh the page
Then I should see logo '<Logo>' on user profile page and on a header

Examples:
| Logo |
| PNG  |

Scenario: Unsuccessfully picture load
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email           | Role        |
| UserFN    | UserLN   | agencytest2user | agency.user |
And I logged in with details of 'agencytest2user'
And I am on my profile page
When I upload logo 'TXT' on user profile page
Then I should see  error message '\w*.txt has invalid extension. Only jpg, jpeg, png are allowed.'
And should see logo 'EMPTY' on user profile page and on a header