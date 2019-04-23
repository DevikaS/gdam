!--NGN-1704 NGN-4689
Feature:          Agency Admin - People - Users list
Narrative:
In order to
As a              AgencyAdmin
I want to         Check users list

Scenario: Check that 'Next page' is active if there are more than 7 users
Meta:@gdam
     @projects
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| <AdminEmail> | agency.admin | <AgencyName> |
And created '<UserCount>' users with email pattern '<UsersEmailPattern>' for agency '<AgencyName>'
And logged in with details of '<AdminEmail>'
When I go to User list page
Then I '<Condition>' see active 'Next page' button on Users page

Examples:
| AdminEmail    | UsersEmailPattern | UserCount | AgencyName    | Condition  |
| U_AAPUL_S01_1 | GU_AAPUL_S01_1    | 0         | A_AAPUL_S01_1 | should not |
| U_AAPUL_S01_2 | GU_AAPUL_S01_2    | 6         | A_AAPUL_S01_2 | should not |
| U_AAPUL_S01_3 | GU_AAPUL_S01_3    | 7         | A_AAPUL_S01_3 | should     |


Scenario: Check that 'Next page' button correctly works on Users page
Meta:@gdam
     @projects
Given I created the agency 'A_AAPUL_S02' with default attributes
And created users with following fields:
| FirstName  | LastName  | Email       | Role         | AgencyUnique |
| FirstName0 | LastName0 | U_AAPUL_S02 | agency.admin | A_AAPUL_S02  |
And created '7' users with email pattern 'GU_AAPUL_S02' for agency 'A_AAPUL_S02'
And I logged in with details of 'U_AAPUL_S02'
When I go to page '2' of User list page
Then I 'should' see user 'GU_AAPUL_S02_7' on opened users list
And 'should' see opened page '2' of Users list page
And 'should not' see active 'Next page' button on Users page


Scenario: Check that 'Previous page' is active if user isn't on 'Page 1' page of Users list
Meta:@gdam
     @projects
Given I created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| <AdminEmail> | agency.admin | <AgencyName> |
And created '<UserCount>' users with email pattern '<UsersEmailPattern>' for agency '<AgencyName>'
And logged in with details of '<AdminEmail>'
When I go to page '<PageNumber>' of User list page
Then I '<Condition>' see active 'Previous page' button on Users page

Examples:
| AdminEmail    | UsersEmailPattern | UserCount | PageNumber | AgencyName    | Condition  |
| U_AAPUL_S03_1 | GU_AAPUL_S03_1    | 0         | 1          | A_AAPUL_S03_1 | should not |
| U_AAPUL_S03_2 | GU_AAPUL_S03_2    | 7         | 2          | A_AAPUL_S03_2 | should     |
| U_AAPUL_S03_3 | GU_AAPUL_S03_3    | 14        | 3          | A_AAPUL_S03_3 | should     |


Scenario: Check that 'Previous page' button correctly works on Users page
Meta:@gdam
     @projects
Given I created the agency 'A_AAPUL_S04' with default attributes
And created users with following fields:
| FirstName  | LastName  | Email       | Role         | AgencyUnique |
| FirstName0 | LastName0 | U_AAPUL_S04 | agency.admin | A_AAPUL_S04  |
And created '7' users with email pattern 'GU_AAPUL_S04' for agency 'A_AAPUL_S04'
And logged in with details of 'U_AAPUL_S04'
When I go to page '2' of User list page
And click element 'PreviousButton' on page 'Users'
Then I 'should' see user 'U_AAPUL_S04,GU_AAPUL_S04_1,GU_AAPUL_S04_2,GU_AAPUL_S04_3,GU_AAPUL_S04_4,GU_AAPUL_S04_5,GU_AAPUL_S04_6' on opened users list
And 'should' see opened page '1' of Users list page
And 'should not' see active 'Previous page' button on Users page


Scenario: Check that per 7 users are displayed on page
Meta:@gdam
     @projects
Given I created the agency 'A_AAPUL_S05' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_AAPUL_S05 | agency.admin | A_AAPUL_S05  |
And created '10' users with email pattern 'GU_AAPUL_S05' for agency 'A_AAPUL_S05'
And I logged in with details of 'U_AAPUL_S05'
When I go to User list page
Then I 'should' see user count '7' on Users page


Scenario: Check that user added via Address Book doesn't appears in Users list
Meta:@gdam
     @projects
Given I am on Address Book page
And added user 'A_AAPUL_S06' to Address book
When I go to User list page
Then I 'should not' see user with email 'A_AAPUL_S06' on Users list page


Scenario: Check that Unit of logged user is displayed on Users page
Meta:@gdam
     @projects
When I go to User list page
Then I 'should' see item 'DefaultAgency' in agencies list on Users page


Scenario: Check that 'Select All' correctly works
Meta:@gdam
     @projects
When I go to User list page
And click element 'SelectAll' on page 'Users'
Then I 'should' see all users are selected on Users list page


Scenario: Check that after clicking on 'Add Users to this Unit' user is redirected to User Settings page
Meta:@gdam
     @projects
When I go to User list page
And click element 'AddUsersToThisUnitLink' on page 'Users'
Then I should be on create user page