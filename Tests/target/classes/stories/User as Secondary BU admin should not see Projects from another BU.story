!-- NGN-11673
Feature:             Secondary BU admin should not see Projects from another BU
Narrative:
In order to
As a                 AgencyAdmin
I want to            Secondary BU admin should not see Projects from another BU


Scenario: check that Secondary BU admin can see only projects of current BU for whom user has access (via sharing) on the projects tab ( via users list)
Meta:@gdam
@projects
!-- NGN-14650: With current implementation, no project role as 'agency.admin'. so changed to 'project.observer'
Given I created the agency 'A_USBASPAB_S01_1' with default attributes
And I created the agency 'A_USBASPAB_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_USBASPAB_S01_1 | agency.admin | A_USBASPAB_S01_1 |
| U_USBASPAB_S01_2 | agency.admin | A_USBASPAB_S01_2 |
And added agencies 'A_USBASPAB_S01_2' as a partner to agency 'A_USBASPAB_S01_1'
And logged in with details of 'U_USBASPAB_S01_2'
And created following projects:
| Name             | Business Unit    |
| P_USBASPAB_S01_3 | A_USBASPAB_S01_2 |
| P_USBASPAB_S01_4 | A_USBASPAB_S01_2 |
And logged in with details of 'U_USBASPAB_S01_1'
And created 'C_USBASPAB_S01' category
And added users 'U_USBASPAB_S01_2' to category 'C_USBASPAB_S01' with role 'library.user' by users details
When create following projects:
| Name             | Business Unit    |
| P_USBASPAB_S01_1 | A_USBASPAB_S01_1 |
| P_USBASPAB_S01_2 | A_USBASPAB_S01_1 |
And I share each folder from project 'P_USBASPAB_S01_1' to user 'U_USBASPAB_S01_2' with role 'project.observer' expired date '12.12.2022'
And go to Users list page with selected user 'U_USBASPAB_S01_2'
Then I should see the following projects on Projects tab for opened user details on Users list page:
| ProjectName    | Condition    |
|P_USBASPAB_S01_1| should       |
|P_USBASPAB_S01_2| should not   |
|P_USBASPAB_S01_3| should not   |
|P_USBASPAB_S01_4| should not   |
When go to Users list page with selected user 'U_USBASPAB_S01_1'
Then I should see the following projects on Projects tab for opened user details on Users list page:
| ProjectName    | Condition    |
|P_USBASPAB_S01_1| should       |
|P_USBASPAB_S01_2| should       |
|P_USBASPAB_S01_3| should not   |
|P_USBASPAB_S01_4| should not   |


Scenario: check that Secondary BU admin can see only category of current BU to whom user has access (via sharing)
Meta:@gdam
@library
Given I created the agency 'A_USBASPAB_S01_1' with default attributes
And I created the agency 'A_USBASPAB_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_USBASPAB_S02_1 | agency.admin | A_USBASPAB_S01_1 |
| U_USBASPAB_S02_2 | agency.admin | A_USBASPAB_S01_2 |
And added agencies 'A_USBASPAB_S01_2' as a partner to agency 'A_USBASPAB_S01_1'
And logged in with details of 'U_USBASPAB_S02_2'
And I created 'C_USBASPAB_S02_3' category
And I created 'C_USBASPAB_S02_4' category
And logged in with details of 'U_USBASPAB_S02_1'
And I created 'C_USBASPAB_S02_1' category
And I created 'C_USBASPAB_S02_2' category
And added users 'U_USBASPAB_S02_2' to category 'C_USBASPAB_S02_2' with role 'library.user' by users details
When I go to user 'U_USBASPAB_S02_2' library page in administration area
Then I should see the following categories on category list on library tab for opened user details on users page:
| CategoryName     | Condition   |
| C_USBASPAB_S02_2 | should      |
| C_USBASPAB_S02_1 | should  not |
| C_USBASPAB_S02_3 | should  not |
| C_USBASPAB_S02_4 | should  not |
And I should see the following categories on category drop down on library tab for opened user details on users page:
| CategoryName     | Condition   |
| C_USBASPAB_S02_1 | should      |
| C_USBASPAB_S02_2 | should      |
| C_USBASPAB_S02_3 | should  not |
| C_USBASPAB_S02_4 | should  not |
