!--NGN-2101
Feature:          Notifications on UI
Narrative:
In order to
As a              AgencyAdmin
I want to         Check shared folders Notifications

Scenario: check counter notifications in header
Meta: @skip
      @gdam
Given I created 'NUR2' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role       |
| <email> | guest.user |
And created 'NUP2' project
And created in 'NUP2' project next folders:
| folder  |
| /NUF2_1 |
| /NUF2_2 |
| /NUF2_3 |
| /NUF2_4 |
| /NUF2_5 |
And fill Share popup by users '<email>' in project 'NUP2' for following folders '<Folders>' with role 'NUR2' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
Then I should see next counter '<Counter>' notifications
When I click element 'Notifications' on page 'Dashboard'
Then I should see in notifications dropdown next counter '<CountInDropDown>' notifications

Examples:
| email | Folders                                 | Counter | CountInDropDown |
| NUU1  | /NUF2_1,/NUF2_2,/NUF2_3,/NUF2_4,/NUF2_5 | 5       | 5               |
| NUU3  | /NUF2_1,/NUF2_2                         | 2       | 2               |


Scenario: check changes counter notifications in header
Meta: @skip
      @gdam
Given I created 'NUR3' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role       |
| <email> | guest.user |
And created 'NUP3' project
And created in 'NUP3' project next folders:
| folder  |
| /NUF3_1 |
| /NUF3_2 |
| /NUF3_3 |
| /NUF3_4 |
| /NUF3_5 |
And fill Share popup by users '<email>' in project 'NUP3' for following folders '<Folders>' with role 'NUR3' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
Then I should see next counter '<Counter>' notifications
When I click on notifications menu in header on Project list page
And click on share folder link '<Folder>' for project 'NUP3' in notifications dropdown
Then I 'should' see '<Folder>' folder in 'NUP3' project
And should see next counter '<NewCounter>' notifications

Examples:
| email  | Folders                                 | Counter | NewCounter | Folder  |
| NUU3_1 | /NUF3_1,/NUF3_2,/NUF3_3,/NUF3_4,/NUF3_5 | 5       | 4          | /NUF3_1 |
| NUU3_2 | /NUF3_1,/NUF3_2,/NUF3_3                 | 3       | 2          | /NUF3_2 |


Scenario: check counter on notification page
!--NGN-2965 , NGN-2354
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created 'NUR4' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email | Role       |
| NUU4  | guest.user |
And created 'NUP4' project
And created in 'NUP4' project next folders:
| folder  |
| /NUF4_1 |
| /NUF4_2 |
| /NUF4_3 |
| /NUF4_4 |
And fill Share popup by users 'NUU4' in project 'NUP4' for following folders '/NUF4_1,/NUF4_2,/NUF4_3,/NUF4_4' with role 'NUR4' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'NUU4'
And waited for '5' seconds
And I am on notifications page
Then I should see next count '4' notifications items on Notifications page
And should see on period tab 'Today' notifications info for following folders '/NUF4_1,/NUF4_2,/NUF4_3,/NUF4_4' shared one by one by user 'AgencyAdmin'
And should see next counter '4' all notifications on Notifications page
And should see next sub counter '4' notifications on Notifications page

Scenario: check changes counter on notification page
!--NGN-2965 , NGN-2354
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created 'NUR5' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email | Role       |
| NUU5  | guest.user |
And created 'NUP5' project
And created in 'NUP5' project next folders:
| folder  |
| /NUF5_1 |
| /NUF5_2 |
| /NUF5_3 |
| /NUF5_4 |
| /NUF5_5 |
And fill Share popup by users 'NUU5' in project 'NUP5' for following folders '/NUF5_1,/NUF5_2,/NUF5_3,/NUF5_4' with role 'NUR5' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'NUU5'
And waited for '5' seconds
And I am on notifications page
Then I should see next count '4' notifications items on Notifications page
And should see on period tab 'Today' notifications info for following folders '/NUF5_1,/NUF5_2,/NUF5_3,/NUF5_4' shared one by one by user 'AgencyAdmin'
And should see next counter '4' all notifications on Notifications page
And should see next sub counter '4' notifications on Notifications page
When I am login as 'AgencyAdmin'
And filling Share popup by users 'NUU5' in project 'NUP5' for following folders 'NUF5_5' with role 'NUR5' expired '12.12.2022' and 'should' access to subfolders
And login with details of 'NUU5'
And go on notifications page
Then I should see next count '5' notifications items on Notifications page
And I should see on period tab 'Today' notifications info for following folders '/NUF5_1,/NUF5_2,/NUF5_3,/NUF5_4,/NUF5_5' shared one by one by user 'AgencyAdmin'
And should see next counter '5' all notifications on Notifications page
And should see next sub counter '5' notifications on Notifications page


Scenario: check that notifications messages are displayed for added team users in project
Meta: @skip
      @gdam
Given I created 'NUR6' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role       |
| <email> | guest.user |
And created 'NUP6' project
And created in 'NUP6' project next folders:
| folder  |
| /NUF6_1 |
| /NUF6_2 |
And added users '<email>' to project 'NUP6' team folders '<Folders>' with role 'NUR6' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
Then I should see message warning '<message>'

Examples:
| email  | Folders         | message                             |
| NUU6_1 | /NUF6_1,/NUF6_2 | You have 2 new unread notifications |
| NUU6_2 | /NUF6_1         | You have 1 new unread notifications |


Scenario: check that click on link open shared folder
!--NGN-2427
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created 'NUR7' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email | Role       |
| NUU7  | guest.user |
And created 'NUP7' project
And created in 'NUP7' project next folders:
| folder |
| /NUF7  |
And fill Share popup by users 'NUU7' in project 'NUP7' for following folders '/NUF7' with role 'NUR7' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'NUU7'
When I click on notifications menu in header on Project list page
And click on share folder link '/NUF7' for project 'NUP7' in notifications dropdown
Then I 'should' see '/NUF7' folder in 'NUP7' project


Scenario: check that Show past notifications link open notifications page
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created 'NUR8' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email | Role       |
| NUU8  | guest.user |
And created 'NUP8' project
And created in 'NUP8' project next folders:
| folder  |
| /NUF8_1 |
| /NUF8_2 |
| /NUF8_3 |
| /NUF8_4 |
And fill Share popup by users 'NUU8' in project 'NUP8' for following folders '/NUF8_1,/NUF8_2,/NUF8_3,/NUF8_4' with role 'NUR8' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'NUU8'
When I click on notifications menu in header
And click element 'ShowPastNotificationsLink' on page 'Dashboard'
Then I should see page 'notifications'
And should see on period tab 'Today' notifications info for following folders '/NUF8_1,/NUF8_2,/NUF8_3,/NUF8_4' shared one by one by user 'AgencyAdmin'


Scenario: check that link from notifications page open shared folder
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created 'NUR9' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email | Role       |
| NUU9  | guest.user |
And created 'NUP9' project
And created in 'NUP9' project next folders:
| folder |
| /NUF9  |
And fill Share popup by users 'NUU9' in project 'NUP9' for following folders '/NUF9' with role 'NUR9' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'NUU9'
And I am on notifications page
When I click on share folder link '/NUF9' shared by user 'AgencyAdmin' on notifications page
Then I 'should' see '/NUF9' folder in 'NUP9' project


Scenario: check that notifications messages are displayed for easyshared users
Meta: @skip
      @gdam
Given I created 'NUR10' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role       |
| <email> | guest.user |
And created 'NUP10' project
And created in 'NUP10' project next folders:
| folder   |
| /NUF10_1 |
| /NUF10_2 |
And fill Share popup by users '<email>' in project 'NUP10' for following folders '<Folders>' with role 'NUR10' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
Then I should see message warning '<message>'

Examples:
| email   | Folders  | message                             |
| NUU10_1 | /NUF10_1 | You have 1 new unread notifications |
| NUU10_2 | /NUF10_2 | You have 1 new unread notifications |


Scenario: check that many shared folders links appear on notifications page
Meta:@gdam
     @skip
!--user Notification removed as part of TD-628 and FAB-791
Given I created 'NUR12' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email | Role       |
| NUU12 | guest.user |
And created 'NUP12' project
And created in 'NUP12' project next folders:
| folder   |
| /NUF12_1 |
| /NUF12_2 |
| /NUF12_3 |
| /NUF12_4 |
| /NUF12_5 |
And fill Share popup by users 'NUU12' in project 'NUP12' folders '/NUF12_1,/NUF12_2,/NUF12_3,/NUF12_4,/NUF12_5' with role 'NUR12' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'NUU12'
And waited for '2' seconds
And I am on notifications page
Then I should see next count '1' notifications items on Notifications page
And should see on period tab 'Today' following notifications info :
| User        | Folders                                      |
| AgencyAdmin | /NUF12_1,/NUF12_2,/NUF12_3,/NUF12_4,/NUF12_5 |


Scenario: check that user haven't notification about created project to yourself
Meta: @skip
      @gdam
Given I created users with following fields:
| Email | Role         |
| NUU13 | agency.admin |
And I logged in with details of 'NUU13'
And created 'NUP13' project
And I am on Project list page
And refreshed the page
Then I 'should not' see element 'NotificationsMessage' on page 'BasePage'
And should see next counter '0' notifications


Scenario: check that user haven't notification about created template to yourself
Meta: @skip
      @gdam
Given I created users with following fields:
| Email | Role         |
| NUU14 | agency.admin |
And I logged in with details of 'NUU14'
And created 'NUP14' template
And I am on Project list page
And refreshed the page
Then I 'should not' see element 'NotificationsMessage' on page 'BasePage'
And should see next counter '0' notifications


Scenario: check that user haven't notification about created project from template to yourself
!--NGN-2159
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email | Role         |
| NUU15 | agency.admin |
And I logged in with details of 'NUU15'
And the following templates were created:
| Name  | Advertiser    | Product/Brand  | Campaign        | Media Type |
| NUT15 | DefaultAgency | DefaultProduct | DefaultCampaign | Digital    |
When I use 'NUT15' template
And fill the following fields for project from template:
| Name  | Job Number | Start Date | End Date   |
| NUP15 | 15_1       | [Today]    | 12.12.2016 |
And I click on element 'SaveButton'
And refresh the page
Then I 'should not' see element 'NotificationsMessage' on page 'BasePage'

Scenario: delete shared folder
Meta: @skip
      @gdam
Given I created 'NUR16' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email | Role       |
| NUU16 | guest.user |
And created 'NUP16' project
And created in 'NUP16' project next folders:
| folder   |
| /NUF16_1 |
| /NUF16_2 |
| /NUF16_3 |
| /NUF16_4 |
And fill Share popup by users 'NUU16' in project 'NUP16' for following folders '/NUF16_1,/NUF16_2,/NUF16_3,/NUF16_4' with role 'NUR16' expired '12.12.2022' and 'should' access to subfolders
And deleted folder '/NUF16_1' in project 'NUP16'
And I logged in with details of 'NUU16'
Then I should see next counter '4' notifications
When I click element 'Notifications' on page 'Dashboard'
Then I should see in notifications dropdown next counter '4' notifications

