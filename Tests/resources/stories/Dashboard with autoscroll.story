!--NGN-5406 NGN-8059
Feature:          Dashboard with autoscroll
Narrative:
In order to
As a              AgencyAdmin
I want to         create new or debug existing stories

Scenario: Check scrolls down the page, next 10 items should be loaded
Meta:@gdam
     @projects
Given I created the agency 'A_DWA_S01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| AU_DWA_S01 | agency.admin | A_DWA_S01    |
| U_DWA_S01  | agency.user  | A_DWA_S01    |
And logged in with details of 'AU_DWA_S01'
And created 'P_DWA_S01' project
And created '20' folders for project 'P_DWA_S01' with name pattern 'F_DWA_S01'
And shared each folder from project 'P_DWA_S01' to user 'U_DWA_S01' with role 'project.user' expired date '12.12.2021'
And waited for '5' seconds
When I go to Dashboard page
And I scroll down to footer on opened Dashboard page
Then I should see count '24' of activity items on the Dashboard page


Scenario: Check 'go to top' counter
Meta:@gdam
     @projects
Given I created the agency 'A_DWA_S02' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| AU_DWA_S02 | agency.admin | A_DWA_S02    |
| U_DWA_S02  | agency.user  | A_DWA_S02    |
And logged in with details of 'AU_DWA_S02'
And created 'P_DWA_S02' project
And created '20' folders for project 'P_DWA_S02' with name pattern 'F_DWA_S02'
And shared each folder from project 'P_DWA_S02' to user 'U_DWA_S02' with role 'project.user' expired date '12.12.2021'
And waited for '5' seconds
When I go to Dashboard page
And scroll down to footer '2' times on opened Dashboard page
Then I 'should' see go to top counter with value '24 / 24' opened Dashboard page


Scenario: Check 'go to top' counter 2
Meta:@gdam
     @projects
Given I created the agency 'A_DWA_S03' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| AU_DWA_S03 | agency.admin | A_DWA_S03    |
| U_DWA_S03  | agency.user  | A_DWA_S03    |
And logged in with details of 'AU_DWA_S03'
And created 'P_DWA_S03' project
And created '20' folders for project 'P_DWA_S03' with name pattern 'F_DWA_S03'
And shared each folder from project 'P_DWA_S03' to user 'U_DWA_S03' with role 'project.user' expired date '12.12.2021'
And waited for '5' seconds
When I go to Dashboard page
And scroll down to footer '2' times on opened Dashboard page
And click go to top button on opened Dashboard page
Then I 'should' be on top of the Dashboard page