!--NGN-4895 NGN-2142
Feature:          Notifications - filter by date
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Notifications page

Scenario: check that user have ability to delete notification on notification page
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created 'P_NFD1' project
And created users with following fields:
| Email   | Role       |
| U_NFD_1 | guest.user |
And created '/NFD1' folder for project 'P_NFD1'
And created 'R_NFD_1' role in 'project' group for advertiser 'DefaultAgency'
And fill Share popup by users 'U_NFD_1' in project 'P_NFD1' folders '/NFD1' with role 'R_NFD_1' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'U_NFD_1'
When I remove notification about user 'admin agency' 'shared the folder' '/NFD1' on notifications page
And refresh the page
Then I should see next count '0' notifications items on Notifications page


Scenario: check that user have ability to delete notification on notification page with Select All
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email   | Agency        | Role        |
| U_NFD_2 | DefaultAgency | agency.user |
And the following projects were created:
| Name     |
| P_NFD2_1 |
And created in 'P_NFD2_1' project next folders:
| folder  |
| /NFD2_1 |
| /NFD2_2 |
| /NFD2_3 |
| /NFD2_4 |
And created 'R_NFD_2' role in 'project' group for advertiser 'DefaultAgency'
And I fill Share popup by users 'U_NFD_2' in project 'P_NFD2_1' for following folders '/NFD2_1,/NFD2_2,/NFD2_3,/NFD2_4' with role 'R_NFD_2' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'U_NFD_2'
When I go on notifications page
And I check 'SelectAll' checkbox
And I press 'Remove' button
And refresh the page
Then I should see next count '0' notifications items on Notifications page


Scenario: check that user have ability to search Notifications with 'This Week' position of filter
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created users with following fields:
| Email   | Agency        | Role        |
| U_NFD_5 | DefaultAgency | agency.user |
And the following projects were created:
| Name     |
| P_NFD5_1 |
And created in 'P_NFD5_1' project next folders:
| folder  |
| /NFD5_1 |
| /NFD5_2 |
| /NFD5_3 |
| /NFD5_4 |
| /NFD5_5 |
And created 'R_NFD_5' role in 'project' group for advertiser 'DefaultAgency'
And I fill Share popup by users 'U_NFD_5' in project 'P_NFD5_1' for following folders '/NFD5_1,/NFD5_2,/NFD5_3,/NFD5_4,/NFD5_5' with role 'R_NFD_5' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'U_NFD_5'
When I select filter 'This Week' on notifications page
Then I should see filter 'This Week' is selected
And I should see next count '5' notifications items on Notifications page


Scenario: check that user have ability to search Notifications with 'This Month' position of filter
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created users with following fields:
| Email   | Agency        | Role        |
| U_NFD_6 | DefaultAgency | agency.user |
And the following projects were created:
| Name     |
| P_NFD6_1 |
And created in 'P_NFD6_1' project next folders:
| folder  |
| /NFD6_1 |
| /NFD6_2 |
| /NFD6_3 |
| /NFD6_4 |
| /NFD6_5 |
And created 'R_NFD_6' role in 'project' group for advertiser 'DefaultAgency'
And I fill Share popup by users 'U_NFD_6' in project 'P_NFD6_1' for following folders '/NFD6_1,/NFD6_2,/NFD6_3,/NFD6_4,/NFD6_5' with role 'R_NFD_6' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'U_NFD_6'
When I select filter 'This Month' on notifications page
Then I should see filter 'This Month' is selected
And I should see next count '5' notifications items on Notifications page


Scenario: check that user have ability to search Notifications with 'Older' position of filter
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created users with following fields:
| Email   | Agency        | Role        |
| U_NFD_7 | DefaultAgency | agency.user |
And the following projects were created:
| Name     |
| P_NFD7_1 |
And created in 'P_NFD7_1' project next folders:
| folder  |
| /NFD7_1 |
| /NFD7_2 |
| /NFD7_3 |
| /NFD7_4 |
| /NFD7_5 |
And created 'R_NFD_7' role in 'project' group for advertiser 'DefaultAgency'
And I fill Share popup by users 'U_NFD_7' in project 'P_NFD7_1' for following folders '/NFD7_1,/NFD7_2,/NFD7_3,/NFD7_4,/NFD7_5' with role 'R_NFD_7' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'U_NFD_7'
When I select filter 'Older' on notifications page
Then I should see filter 'Older' is selected
And I should see next count '5' notifications items on Notifications page


Scenario: check zero notification status on Notification page
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email   | Agency        | Role        |
| U_NFD_9 | DefaultAgency | agency.user |
And I logged in with details of 'U_NFD_9'
When I go on notifications page
Then I should see next count '0' notifications items on Notifications page
And should see next counter '0' all notifications on Notifications page
And should see next sub counter '0' notifications on Notifications page