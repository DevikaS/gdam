!--NGN-11672
Feature:          Check activity about added related files and assets should be displayed on Dashboard
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that activity about added related files and assets should be displayed on Dashboard


Scenario: Check that activity about added related files and assets should be displayed on Dashboard (files)
Meta:@gdam
     @projects
Given I created users with following fields:
| Email              | Role         |
| U_AAARFAASBDOD_S01 | agency.admin |
| <Users>            | agency.user  |
When I login with details of 'U_AAARFAASBDOD_S01'
And create '<ProjectName>' project
And publish the project '<ProjectName>'
And create '/folder' folder for project '<ProjectName>'
And add users '<Users>' to project '<ProjectName>' team folders '/folder' with role 'project.contributor' expired '10.10.2020'
And upload into project '<ProjectName>' following files:
| FileName             | Path    |
| /images/logo.gif     | /folder |
| /images/logo.png     | /folder |
And wait while transcoding is finished in folder '/folder' on project '<ProjectName>' files page
And go to file 'logo.gif' in '/folder' in project '<ProjectName>' on related files page
And type related file 'logo.png' on related files page on pop-up
And select and save following related files 'logo.png' on related file pop-up
And login with details of '<Users>'
And refresh the page
Then 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName           | Message                | Value                |
| U_AAARFAASBDOD_S01 | added related files(s) | logo.gif to logo.png |

Examples:
| Users                | ProjectRole         | ProjectName      |
| U_AAARFAASBDOD_S01_2 | project.contributor | P_AAARFAASBDOD_2 |


Scenario: Check that activity about added related files and assets should be displayed on Dashboard (assets)
Meta:@uitobe
     @library
Given I created users with following fields:
| Email              | Role          |
| U_AAARFAASBDOD_S01 | agency.admin  |
| <Users>            | <ProjectRole> |
When I login with details of '<Users>'
And upload following assets:
| Name              |
| /files/logo1.gif  |
| /files/_file1.gif |
And wait while transcoding is finished in collection 'My Assets'
And go to asset 'logo1.gif' info page in Library for collection 'My Assets' on related assets page
And type related asset '_file1.gif' on related assets page on pop-up
And select following related files '_file1.gif' on related asset pop-up
And wait for '3' seconds
And go to Dashboard page
Then 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName | Message                | Value                   |
| <Users>  | added related files(s) | logo1.gif to _file1.gif |

Examples:
| Users                | ProjectRole   |
| U_AAARFAASBDOD_S02_2 | guest.user    |
| U_AAARFAASBDOD_S02_3 | agency.user   |