!--NGN-11670
Feature:          Some activities should be added for relevant objects on dashboard
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Some activities should be added for relevant objects on dashboard


Scenario: Check that when user comments file corresponding activity is displayed on Dashboard
Meta: @skip
      @gdam
!--01/10 - confirmed with Maria - "well what's the value of showing them on Dahsboard if they belong in the context of a project"
Given created users with following fields:
| Email            | Role         |
| E_SASBAFROOD_S01 | agency.admin |
When I login with details of 'E_SASBAFROOD_S01'
And create 'P_SASBAFROOD_S01' project
And create '/F_SASBAFROOD_S01' folder for project 'P_SASBAFROOD_S01'
And upload '/files/120.600.gif' file into '/F_SASBAFROOD_S01' folder for 'P_SASBAFROOD_S01' project
And wait while transcoding is finished in folder '/F_SASBAFROOD_S01' on project 'P_SASBAFROOD_S01' files page
And add comment 'test comment' on file '120.600.gif' comments page on folder '/F_SASBAFROOD_S01' in project 'P_SASBAFROOD_S01'
And wait for '5' seconds
And go to Dashboard page
Then 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName         | Message                            | Value       |
| E_SASBAFROOD_S01 | commented on file - "test comment" | 120.600.gif |


Scenario: Check that when user moved folder corresponding activity is displayed on Dashboard
Meta:@gdam
@projects
Given created users with following fields:
| Email            | Role         |
| E_SASBAFROOD_S01 | agency.admin |
When I login with details of 'E_SASBAFROOD_S01'
And create 'P_SASBAFROOD_S02_1' project
And create '/F_SASBAFROOD_S02_1' folder for project 'P_SASBAFROOD_S02_1'
And upload '/files/120.600.gif' file into '/F_SASBAFROOD_S02_1' folder for 'P_SASBAFROOD_S02_1' project
And create 'P_SASBAFROOD_S02_2' project
And create '/F_SASBAFROOD_S02_2' folder for project 'P_SASBAFROOD_S02_2'
And move folder 'F_SASBAFROOD_S02_1' from project 'P_SASBAFROOD_S02_1' into folder 'F_SASBAFROOD_S02_2' in project 'P_SASBAFROOD_S02_2' with 'update' metadata
And wait for '3' seconds
And go to Dashboard page
Then I 'should' see activity: 'E_SASBAFROOD_S01' moved folder from 'P_SASBAFROOD_S02_1/P_SASBAFROOD_S02_1' to 'P_SASBAFROOD_S02_2/P_SASBAFROOD_S02_2/F_SASBAFROOD_S02_2' and value 'F_SASBAFROOD_S02_1' on Dashboard


Scenario: Check that when user shares file via public share corresponding activity is displayed on Dashboard
Meta:@gdam
@projects
Given created users with following fields:
| Email            | Role         |
| E_SASBAFROOD_S01 | agency.admin |
And logged in with details of 'E_SASBAFROOD_S01'
And created 'P_SASBAFROOD_S03' project
And created '/F_SASBAFROOD_S03' folder for project 'P_SASBAFROOD_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_SASBAFROOD_S03' folder for 'P_SASBAFROOD_S03' project
And waited while preview is available in folder '/F_SASBAFROOD_S03' on project 'P_SASBAFROOD_S03' files page
When I 'activate' public url for file 'Fish Ad.mov' in folder '/F_SASBAFROOD_S03' and project 'P_SASBAFROOD_S03'
And wait for '3' seconds
And go to Dashboard page
Then 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName         | Message                      | Value       |
| E_SASBAFROOD_S01 | created public link for file | Fish Ad.mov |


Scenario: Check that when user shares asset via public share corresponding activity is displayed on Dashboard
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role         |Access|
| U_SASBAFROOD_1 | agency.admin |streamlined_library,dashboard|
| U_SASBAFROOD_2 | agency.user  |streamlined_library,dashboard|
And logged in with details of 'U_SASBAFROOD_1'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added secure share for asset 'Fish1-Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails     | ExpireDate |
| U_SASBAFROOD_2 | 12.12.2021 |
And waited for '3' seconds
When I go to Dashboard page
And refresh the page
Then 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName       | Message                          | Value        |
| U_SASBAFROOD_1 | has shared Fish1-Ad.mov to U_SASBAFROOD_2 | Fish1-Ad.mov |

