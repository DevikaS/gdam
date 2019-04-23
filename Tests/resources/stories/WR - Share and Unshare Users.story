Feature:          WR Share and Unshare Users
Narrative:
In order to
As a              AgencyAdmin
I want to         check WR Share and Unshare Users

Scenario: Check WR Publish activities and WR sharing email notifications to Users
Meta:@bug
     @gdam
     @projects
!-- QA-752 ,QAB-927,QAB-928
!-- All scenarios in this story are not fully tested due to QAB-927 and QAB-928, need to test once bugs are fixed
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_WRSUU_1' with default attributes
And created users with following fields:
| Email       | Role            | Agency    |
| U_WRSUU_1   | agency.admin    | A_WRSUU_1 |
| U_WRSUU_2   | agency.admin    | A_WRSUU_1 |
| U_WRSUU_3   | agency.user     | A_WRSUU_1 |
And I logged in with details of 'U_WRSUU_2'
And set following notification settings for user:
| UserEmail | SettingName             | SettingState |
| U_WRSUU_2 | pojectPublished         | on           |
| U_WRSUU_2 | projectShared           | on           |
| U_WRSUU_2 | projectSharedWithUsers  | on           |
And I logged in with details of 'U_WRSUU_3'
And set following notification settings for user:
| UserEmail | SettingName             | SettingState |
| U_WRSUU_3 | pojectPublished         | on           |
| U_WRSUU_3 | projectShared           | on           |
| U_WRSUU_3 | projectSharedWithUsers  | on           |
And I logged in with details of 'U_WRSUU_1'
And set following notification settings for user:
| UserEmail | SettingName             | SettingState |
| U_WRSUU_1 | pojectPublished         | on           |
| U_WRSUU_1 | projectShared           | on           |
| U_WRSUU_1 | projectSharedWithUsers  | on           |
And created new work request with following fields:
| FieldName  | FieldValue      |
| Name       | WR_WRSUU_S01    |
| Media type | Other           |
| Start date | 29.09.2018      |
| End date   | 07.09.2022      |
And set following notification settings for work request 'WR_WRSUU_S09':
| FieldName                 | State |
| Project Published         | On    |
| Project Shared            | On    |
| Project Shared With Users | On    |
When edit the following fields for 'WR_WRSUU_S01' work request:
| Name         | Administrators |
| WR_WRSUU_S01 | U_WRSUU_2      |
And click Save button on opened Edit Work Request popup
When click publish button on work request 'WR_WRSUU_S01' Overview page
And create '/PSF101' folder for work request 'WR_WRSUU_S01'
And add users 'U_WRSUU_3' to work request 'WR_WRSUU_S01' team folders '/PSF101' with role 'Project Contributor' expired '12.12.2021'
Then I 'should' see email with subject 'has shared project' sent to 'U_WRSUU_2'
And I 'should' see email with subject 'Folders have been shared with you' sent to 'U_WRSUU_3'
When I go to work request 'WR_WRSUU_S01' teams page
And refresh the page without delay
Then I 'should' see activity for user 'U_WRSUU_1' of publish work request 'WR_WRSUU_S01' on work request Team Page
And 'should' see activity where user 'U_WRSUU_1' shared folder 'PSF101' to user 'U_WRSUU_3' on work request Team Page
When I go to work request 'WR_WRSUU_S01' overview page
Then I 'should' see activity for user 'U_WRSUU_1' of publish work request 'WR_WRSUU_S01' on work request Overview page
And I 'should' see activity where user 'U_WRSUU_1' shared folder 'PSF101' to user 'U_WRSUU_3' on work request Overview page
When go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName   | Message                      | Value        |
| U_WRSUU_1  | published project            | WR_WRSUU_S01 |
And I 'should' see activity where user 'U_WRSUU_1' shared folder 'PSF101' to user 'U_WRSUU_3' on Dashboard Page
When I login with details of 'U_WRSUU_2'
And I go to work request 'WR_WRSUU_S01' teams page
And refresh the page without delay
Then I 'should' see activity for user 'U_WRSUU_1' of publish work request 'WR_WRSUU_S01' on work request Team Page
And 'should' see activity where user 'U_WRSUU_1' shared folder 'PSF101' to user 'U_WRSUU_3' on work request Team Page
When I go to work request 'WR_WRSUU_S01' overview page
Then I 'should' see activity for user 'U_WRSUU_1' of publish work request 'WR_WRSUU_S01' on work request Overview page
And I 'should' see activity where user 'U_WRSUU_1' shared folder 'PSF101' to user 'U_WRSUU_3' on work request Overview page
When go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName   | Message                      | Value        |
| U_WRSUU_1  | published project            | WR_WRSUU_S01 |
And I 'should' see activity where user 'U_WRSUU_1' shared folder 'PSF101' to user 'U_WRSUU_3' on Dashboard Page



Scenario: Check email notifications and activity feeds when new WR admin added after WR is published
Meta:@bug
     @gdam
     @projects
!-- QA-752 ,QAB-927
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_WRSUU_2' with default attributes
And created users with following fields:
| Email       | Role            | Agency    |
| U_WRSUU_4   | agency.admin    | A_WRSUU_2 |
| U_WRSUU_5   | agency.admin    | A_WRSUU_2 |
And I logged in with details of 'U_WRSUU_5'
And set following notification settings for user:
| UserEmail | SettingName    | SettingState |
| U_WRSUU_5 | projectShared  | on           |
And I logged in with details of 'U_WRSUU_4'
And set following notification settings for user:
| UserEmail | SettingName     | SettingState |
| U_WRSUU_4 | projectShared   | on           |
And created new work request with following fields:
| FieldName  | FieldValue      |
| Name       | WR_WRSUU_S02    |
| Media type | Other           |
| Start date | 29.09.2018      |
| End date   | 07.09.2022      |
When click publish button on work request 'WR_WRSUU_S02' Overview page
And edit the following fields for 'WR_WRSUU_S02' work request:
| Name         | Administrators  |
| WR_WRSUU_S02 | U_WRSUU_5       |
And click Save button on opened Edit Work Request popup
Then I 'should' see email with subject 'has shared project' sent to 'U_WRSUU_5'
When I go to work request 'WR_WRSUU_S02' teams page
And refresh the page without delay
Then I 'should' see activity where user 'U_WRSUU_4' shared work request 'WR_WRSUU_S02' to user 'U_WRSUU_5' on work request Team page
When I go to work request 'WR_CWRFLA_S08' overview page
Then I 'should' see activity where user 'U_WRSUU_4' shared work request 'WR_WRSUU_S02' to user 'U_WRSUU_5' on work request Overview page
When go to Dashboard page
Then I 'should' see activity where user 'U_WRSUU_4' shared project 'WR_WRSUU_S02' to user 'U_WRSUU_5' on Dashboard


Scenario: Check WR Unshare activities and notifications generated for removed WR admin
Meta:@bug
     @gdam
     @projects
!-- QA-752 ,QAB-927
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_WRSUU_3' with default attributes
And created users with following fields:
| Email       | Role            | Agency    |
| U_WRSUU_6   | agency.admin    | A_WRSUU_3 |
| U_WRSUU_7   | agency.admin    | A_WRSUU_3 |
And I logged in with details of 'U_WRSUU_7'
And set following notification settings for user:
| UserEmail | SettingName       | SettingState |
| U_WRSUU_7 | projectUnshared   | on           |
And I logged in with details of 'U_WRSUU_6'
And set following notification settings for user:
| UserEmail | SettingName       | SettingState |
| U_WRSUU_6 | projectUnshared   | on           |
And created new work request with following fields:
| FieldName  | FieldValue      |
| Name       | WR_WRSUU_S03    |
| Media type | Other           |
| Start date | 29.09.2018      |
| End date   | 07.09.2022      |
And set following notification settings for work request 'WR_WRSUU_S03':
| FieldName               | State |
| Project Owner Removed   | On    |
When edit the following fields for 'WR_WRSUU_S03' work request:
| Name         | Administrators  |
| WR_WRSUU_S03 | U_WRSUU_7       |
And click Save button on opened Edit Work Request popup
When click publish button on work request 'WR_WRSUU_S03' Overview page
And I remove administrator 'U_WRSUU_7' from work request 'WR_WRSUU_S03'
And click Save button on opened Edit Work Request popup
Then I 'should' see email notification for 'Project owner removed' with field to 'U_WRSUU_7' and subject 'has been removed from owners of' contains following attributes:
| Agency    | ProjectName  | UserName  |
| A_WRSUU_3 | WR_WRSUU_S03 | U_WRSUU_6 |
When I go to work request 'WR_CWRFLA_S08' overview page
Then I 'should' see activity for user 'U_WRSUU_6' of publish work request 'WR_WRSUU_S03' on work request Overview page
And I 'should' see activity where user 'U_WRSUU_6' has removed user 'U_WRSUU_7' from work request 'WR_WRSUU_S03' on work request Overview page
When I go to work request 'WR_CWRFLA_S08' teams page
And refresh the page without delay
Then I 'should' see activity where user 'U_WRSUU_6' has removed user 'U_WRSUU_7' from work request 'WR_WRSUU_S03' on work request Team Page
When go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName   | Message                      | Value        |
| U_WRSUU_7  | has been removed from project| WR_WRSUU_S03 |
| U_WRSUU_7  | published project            | WR_WRSUU_S03 |