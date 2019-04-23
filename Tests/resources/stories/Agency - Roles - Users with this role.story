!--NGN-621
Feature:          Agency - Roles - Users with this role
Narrative:
In order to
As a              AgencyAdmin
I want to         check that User list related to role is displayed

Scenario: check that a new user with role is displayed in related list
Meta: @gdam
     @globaladmin
!--QA-1166
Given I created users with following fields:
| Email      | Role       |
| <UserName> | <UserRole> |
When I go to roles page
Then I 'should' see user '<UserName>' in users list on role '<UserRole>' page

Examples:
| UserName | UserRole     |
| ARU1_1   | agency.admin |
| ARU1_2   | agency.user  |
| ARU1_3   | guest.user   |


Scenario: check that user after changing role(from people page) is displayed in related list
Meta: @gdam
     @globaladmin
!--QA-1166
Given I created users with following fields:
| Email      | Role       |
| <UserName> | <UserRole> |
And waited for '10' seconds
When I edit user '<UserName>' with following fields:
| Email      | Role      |
| <UserName> | <NewRole> |
And wait for '5' seconds
And I go to roles page
Then I 'should not' see user '<UserName>' in users list on role '<UserRole>' page
Then 'should' see user '<UserName>' in users list on role '<NewRole>' page

Examples:
| UserName | UserRole     | NewRole      |
| ARU2_1   | agency.admin | agency.user  |
| ARU2_2   | agency.user  | guest.user   |
| ARU2_3   | guest.user   | agency.admin |


Scenario: check ability to edit user details from Roles page
Meta: @gdam
      @globaladmin
!--QA-1166
Given I created users with following fields:
| Email | Role       |
| ARU3  | guest.user |
And I am on Roles page
When I click on user 'ARU3' logo in role 'guest.user' page
Then I should see user 'ARU3' details page


Scenario: check that user  displayed in projects roles
Meta: @gdam
      @bug
      @globaladmin
!--QA-1166 (Refer Note in ticket Description)
Given I created 'ARU4' User
And created following projects:
| Name | Administrators |
| ARP4 | ARU4           |
When I go to roles page
Then I 'should' see user 'ARU4' in users list on role 'project.admin' page


Scenario: check that user is not displayed in projects roles after delete from admin sections
Meta: @gdam
      @bug
      @projects
!--QA-1166 (Refer Note in ticket Description)
Given I created following users:
| User Name |
| ARU5_1    |
| ARU5_2    |
And created following projects:
| Name | Administrators |
| ARP5 | ARU5_1,ARU5_2  |
When I open project 'ARP5' settings page
And remove administrator 'ARU5_1' from project 'ARP5'
And click on element 'SaveButton'
And I go to roles page
Then I 'should not' see user 'ARU5_1' in users list on role 'project.admin' page


Scenario: check that user of project team displayed in projects roles list
Meta: @gdam
      @bug
      @globaladmin
!--QA-1166 (Refer Note in ticket Description)
Given I created 'ARP6' project
And created '/F6' folder for project 'ARP6'
And I created following users:
| User Name |
| ARU6_1    |
| ARU6_2    |
And added following users to address book:
| UserName |
| ARU6_1   |
| ARU6_2   |
And created 'ARR6' role in 'project' group for advertiser 'DefaultAgency'
And added following users to team template 'ARTT6':
| UserName |
| ARU6_1   |
| ARU6_2   |
And added team template 'ARTT6' to project 'ARP6' team folders '/F6' with role 'ARR6' expired '12.12.2021'
When I go to roles page
Then I 'should' see user 'ARU6_1' in users list on role 'ARR6' page
And 'should' see user 'ARU6_2' in users list on role 'ARR6' page


Scenario: check that user is not displayed in projects roles list after delete from project team
Meta: @gdam
      @bug
      @globaladmin
!--QA-1166 (Refer Note in ticket Description)
Given I created following users:
| User Name |
| ARU7_1    |
| ARU7_2    |
And created following projects:
| Name | Administrators |
| ARP7 | ARU7_1,ARU7_2  |
When I go to project 'ARP7' teams page
And remove user 'ARU7_1' from project 'ARP7' team page
And I go to roles page
Then I 'should not' see user 'ARU7_1' in users list on role 'project.admin' page


Scenario: Check that user from another BU shows in roles list page
Meta: @gdam
      @globaladmin
!--QA-1166
Given I created the agency 'ARBU1_1' with default attributes
And created the agency 'ARBU1_3' with default attributes
And created users with following fields:
| Email  | Role         | Agency  |
| ARU8_1 | agency.admin | ARBU1_1 |
| ARU8_2 | agency.admin | ARBU1_3 |
And logged in with details of 'ARU8_1'
And created 'ARP8' project
And created '/ARF8' folder for project 'ARP8'
And added users 'ARU8_2' to project 'ARP8' team folders '/ARF8' with role 'project.user' expired '12.02.2021'
When I go to roles page
Then I 'should' see user 'ARU8_2' in users list on role 'guest.user' page


Scenario: Check that partnered BU user also shows in roles list page
Meta: @gdam
      @globaladmin
!--QA-1166
Given I logged in as 'GlobalAdmin'
And I created the agency 'ARBU1_1' with default attributes
And created the agency 'ARBU1_2' with default attributes
And created users with following fields:
| Email  | Role         | Agency  |
| ARU9_1 | agency.admin | ARBU1_1 |
| ARU9_2 | agency.admin | ARBU1_2 |
And added following partners to agency 'ARBU1_1' on partners page:
| Name    |
| ARBU1_2 |
And logged in with details of 'ARU9_1'
And created 'ARP9' project
And created '/ARF9' folder for project 'ARP9'
And added users 'ARU9_2' to project 'ARP9' team folders '/ARF9' with role 'project.user' expired '12.02.2021'
When I go to roles page
Then I 'should' see user 'ARU9_2' in users list on role 'guest.user' page