!--NGN-5155
Feature:          A5 Dashboard projects and files
Narrative:
In order to
As a              AgencyAdmin
I want to         Check expand menu for Dashboard

Meta: @component dashboard

Scenario: check 'Approvals' section collapsing
Meta:@approvals
     @gdam
Given I created the agency 'A_A5DPL_S01' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S01 | agency.admin | A_A5DPL_S01  |
And logged in with details of 'U_A5DPL_S01'
When I go to Dashboard page
And minimize 'Approvals' section on Dashboard page
Then I 'should' see collapsed section 'Approvals' on Dashboard page
And 'should' see link 'View files for approval' for collapsed section 'Approvals' on Dashboard page


Scenario: check 'Approvals' section expanding
Meta:@approvals
     @gdam
Given I created the agency 'A_A5DPL_S02' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S02 | agency.admin | A_A5DPL_S02  |
And logged in with details of 'U_A5DPL_S02'
When I go to Dashboard page
When I maximize 'Approvals' section on Dashboard page
Then I 'should' see expanded section 'Approvals' on Dashboard page
And 'should' see text 'You have no approvals' for expanded section 'Approvals' on Dashboard page


Scenario: check that link 'View files for approval' expand 'Approvals' section
Meta:@approvals
     @gdam
Given I created the agency 'A_A5DPL_S03' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S03 | agency.admin | A_A5DPL_S03  |
And logged in with details of 'U_A5DPL_S03'
When I go to Dashboard page
And minimize 'Approvals' section on Dashboard page
And click link 'View files for approval' in 'Approvals' section on Dashboard page
Then I 'should' see expanded section 'Approvals' on Dashboard page
And 'should' see text 'You have no approvals' for expanded section 'Approvals' on Dashboard page


Scenario: check 'Files in your projects' section collapsing
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S04' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S04 | agency.admin | A_A5DPL_S04  |
And logged in with details of 'U_A5DPL_S04'
When I go to Dashboard page
And minimize 'Files in your projects' section on Dashboard page
Then I 'should' see collapsed section 'Files in your projects' on Dashboard page
And 'should' see link 'View latest files in your projects' for collapsed section 'Files in your projects' on Dashboard page


Scenario: check 'Files in your projects' section expanding
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S05' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S05 | agency.admin | A_A5DPL_S05  |
And logged in with details of 'U_A5DPL_S05'
When I go to Dashboard page
When I maximize 'Files in your projects' section on Dashboard page
Then I 'should' see expanded section 'Files in your projects' on Dashboard page
And 'should' see text 'You have no project files' for expanded section 'Files in your projects' on Dashboard page


Scenario: check that link 'View latest files in your projects' expand 'Files in your projects' section
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S06' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S06 | agency.admin | A_A5DPL_S06  |
And logged in with details of 'U_A5DPL_S06'
When I go to Dashboard page
And minimize 'Files in your projects' section on Dashboard page
And click link 'View latest files in your projects' in 'Files in your projects' section on Dashboard page
Then I 'should' see expanded section 'Files in your projects' on Dashboard page
And 'should' see text 'You have no project files' for expanded section 'Files in your projects' on Dashboard page


Scenario: check 'My Projects' section collapsing
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S07' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S07 | agency.admin | A_A5DPL_S07  |
And logged in with details of 'U_A5DPL_S07'
When I go to Dashboard page
And minimize 'My Projects' section on Dashboard page
Then I 'should' see collapsed section 'My Projects' on Dashboard page
And 'should' see link 'View your latest projects' for collapsed section 'My Projects' on Dashboard page


Scenario: check 'My Projects' section expanding
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S08' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S08 | agency.admin | A_A5DPL_S08  |
And logged in with details of 'U_A5DPL_S08'
When I go to Dashboard page
When I maximize 'My Projects' section on Dashboard page
Then I 'should' see expanded section 'My Projects' on Dashboard page
And 'should' see text 'You have no projects' for expanded section 'My Projects' on Dashboard page


Scenario: check that link 'View your latest projects' expand 'My Projects' section
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S09' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S09 | agency.admin | A_A5DPL_S09  |
And logged in with details of 'U_A5DPL_S09'
When I go to Dashboard page
And minimize 'My Projects' section on Dashboard page
And click link 'View your latest projects' in 'My Projects' section on Dashboard page
Then I 'should' see expanded section 'My Projects' on Dashboard page
And 'should' see text 'You have no projects' for expanded section 'My Projects' on Dashboard page


Scenario: check 'Recent Activity' section collapsing
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S10' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S10 | agency.admin | A_A5DPL_S10  |
And logged in with details of 'U_A5DPL_S10'
When I go to Dashboard page
And minimize 'Recent Activity' section on Dashboard page
Then I 'should' see collapsed section 'Recent Activity' on Dashboard page
And 'should' see link 'View your latest activity' for collapsed section 'Recent Activity' on Dashboard page


Scenario: check 'Recent Activity' section expanding
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S11' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S11 | agency.admin | A_A5DPL_S11  |
And logged in with details of 'U_A5DPL_S11'
When I go to Dashboard page
When I maximize 'Recent Activity' section on Dashboard page
Then I 'should' see expanded section 'Recent Activity' on Dashboard page
And 'should' see text 'You have no activities' for expanded section 'Recent Activity' on Dashboard page


Scenario: check that link 'View your latest activity' expand 'Recent Activity' section
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S12' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S12 | agency.admin | A_A5DPL_S12  |
And logged in with details of 'U_A5DPL_S12'
When I go to Dashboard page
And minimize 'Recent Activity' section on Dashboard page
And click link 'View your latest activity' in 'Recent Activity' section on Dashboard page
Then I 'should' see expanded section 'Recent Activity' on Dashboard page
And 'should' see text 'You have no activities' for expanded section 'Recent Activity' on Dashboard page


Scenario: check 'Presentations' section collapsing
Meta:@gdam
     @library
Given I created the agency 'A_A5DPL_S13' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S13 | agency.admin | A_A5DPL_S13  |
And logged in with details of 'U_A5DPL_S13'
When I go to Dashboard page
And minimize 'Presentations' section on Dashboard page
Then I 'should' see collapsed section 'Presentations' on Dashboard page
And 'should' see link 'View your latest presentations' for collapsed section 'Presentations' on Dashboard page


Scenario: check 'Presentations' section expanding
Meta:@gdam
     @library
Given I created the agency 'A_A5DPL_S14' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S14 | agency.admin | A_A5DPL_S14  |
And logged in with details of 'U_A5DPL_S14'
When I go to Dashboard page
When I maximize 'Presentations' section on Dashboard page
Then I 'should' see expanded section 'Presentations' on Dashboard page
And 'should' see text 'You have no presentations' for expanded section 'Presentations' on Dashboard page


Scenario: check that link 'View your latest presentations' expand 'Presentations' section
Meta:@gdam
     @library
Given I created the agency 'A_A5DPL_S15' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S15 | agency.admin | A_A5DPL_S15  |
And logged in with details of 'U_A5DPL_S15'
When I go to Dashboard page
And minimize 'Presentations' section on Dashboard page
And click link 'View your latest presentations' in 'Presentations' section on Dashboard page
Then I 'should' see expanded section 'Presentations' on Dashboard page
And 'should' see text 'You have no presentations' for expanded section 'Presentations' on Dashboard page


Scenario: check 'Latest Library Uploads' section collapsing
Meta:@library
     @gdam
Given I created the agency 'A_A5DPL_S16' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S16 | agency.admin | A_A5DPL_S16  |
And logged in with details of 'U_A5DPL_S16'
When I go to Dashboard page
And minimize 'Latest Library Uploads' section on Dashboard page
Then I 'should' see collapsed section 'Latest Library Uploads' on Dashboard page
And 'should' see link 'View latest files in your library' for collapsed section 'Latest Library Uploads' on Dashboard page


Scenario: check 'Latest Library Uploads' section expanding
Meta:@library
     @gdam
Given I created the agency 'A_A5DPL_S17' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S17 | agency.admin | A_A5DPL_S17  |
And logged in with details of 'U_A5DPL_S17'
When I go to Dashboard page
When I maximize 'Latest Library Uploads' section on Dashboard page
Then I 'should' see expanded section 'Latest Library Uploads' on Dashboard page
And 'should' see text 'You have no files in your library' for expanded section 'Latest Library Uploads' on Dashboard page


Scenario: check that link 'View latest files in your library' expand 'Latest Library Uploads' section
Meta:@library
     @gdam
Given I created the agency 'A_A5DPL_S18' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_A5DPL_S18 | agency.admin | A_A5DPL_S18  |
And logged in with details of 'U_A5DPL_S18'
When I go to Dashboard page
And minimize 'Latest Library Uploads' section on Dashboard page
And click link 'View latest files in your library' in 'Latest Library Uploads' section on Dashboard page
Then I 'should' see expanded section 'Latest Library Uploads' on Dashboard page
And 'should' see text 'You have no files in your library' for expanded section 'Latest Library Uploads' on Dashboard page


Scenario: Check that uploaded file could be opened from dashboard 'Files in your projects' section
Meta:@projects
     @gdam
Given I created the agency 'A_A5DPL_S19' with default attributes
And created users with following fields:
| Email       | Role         | Agency      |
| U_A5DPL_S19 | agency.admin | A_A5DPL_S19 |
And logged in with details of 'U_A5DPL_S19'
And created 'P_A5DPL_S19' project
And created '/F_A5DPL_S19' folder for project 'P_A5DPL_S19'
And uploaded '/files/128_shortname.jpg' file into '/F_A5DPL_S19' folder for 'P_A5DPL_S19' project
When I go to Dashboard page
And click asset '128_shortname.jpg' thumbnail in 'Files in your projects' section on Dashboard page
Then I 'should' be on the file info page


Scenario: Check that file could be opened from 'My Recent Activity' section via 'commented on file'
Meta:@skip
     @gdam
!--Old functionality approved by Maria
Given I created the agency 'A_A5DPL_S20' with default attributes
And created users with following fields:
| Email       | Role         | Agency      |
| U_A5DPL_S20 | agency.admin | A_A5DPL_S20 |
And logged in with details of 'U_A5DPL_S20'
And created 'P_A5DPL_S20' project
And created '/F_A5DPL_S20' folder for project 'P_A5DPL_S20'
And uploaded '/files/128_shortname.jpg' file into '/F_A5DPL_S20' folder for 'P_A5DPL_S20' project
And on the file comments page project 'P_A5DPL_S20' and folder '/F_A5DPL_S20' and file '128_shortname.jpg'
And added comment 'it will be transcoded...' into current file
When I go to Dashboard page
And click file '128_shortname.jpg' link in 'commented on file' activity in My Recent Activity section on Dashboard page
Then I 'should' be on the file info page
