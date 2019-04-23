!--NGN-5154
Feature:          A5 Dashboard ACL
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 Dashboard ACL

Meta:
@component dashboard

Scenario: check that user can see uploaded files to own project on dashboard
Meta:@gdam
     @projects
Given I created users with following fields:
| Email          | Role         |
| <ProjectOwner> | <GlobalRole> |
| <ProjectUser>  | agency.user  |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/F_A5DACL_S01' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DACL_S01' folder for '<ProjectName>' project
And fill Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/F_A5DACL_S01' with role 'project.contributor' expired '12.02.2021' and 'should' access to subfolders
And logged in with details of '<ProjectUser>'
And uploaded '/files/Fish-Ad.mov' file into '/F_A5DACL_S01' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_A5DACL_S01' on project '<ProjectName>' files page
When I login with details of '<ProjectOwner>'
When I go to Dashboard page
And maximize 'Files in your projects' section on Dashboard page
And switch tab to '<TabName>' for section 'Files in your projects' on Dashboard page
Then I 'should' see 'Fish Ad.mov' file in 'Files in your projects' section on Dashboard page
Then '<Condition>' see 'Fish-Ad.mov' file in 'Files in your projects' section on Dashboard page

Examples:
| ProjectOwner    | ProjectUser     | GlobalRole   | ProjectName    | TabName             | Condition  |
| PO_A5DACL_S01_1 | PU_A5DACL_S01_1 | agency.admin | P_A5DACL_S01_1 | Latest files added  | should     |
| PO_A5DACL_S01_2 | PU_A5DACL_S01_2 | agency.admin | P_A5DACL_S01_2 | Latest added by you | should not |
| PO_A5DACL_S01_3 | PU_A5DACL_S01_3 | agency.user  | P_A5DACL_S01_3 | Latest files added  | should     |
| PO_A5DACL_S01_4 | PU_A5DACL_S01_4 | agency.user  | P_A5DACL_S01_4 | Latest added by you | should not |


Scenario: check that user cannot see uploaded files to not own project on dashboard
Meta:@gdam
     @projects
Given I created users with following fields:
| Email          | Role         |
| <ProjectOwner> | agency.user  |
| <ProjectUser>  | <GlobalRole> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/F_A5DACL_S02' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DACL_S02' folder for '<ProjectName>' project
And fill Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/F_A5DACL_S02' with role 'project.contributor' expired '12.02.2021' and 'should' access to subfolders
And logged in with details of '<ProjectUser>'
And uploaded '/files/Fish-Ad.mov' file into '/F_A5DACL_S02' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_A5DACL_S02' on project '<ProjectName>' files page
When I go to Dashboard page
And maximize 'Files in your projects' section on Dashboard page
And switch tab to '<TabName>' for section 'Files in your projects' on Dashboard page
Then I 'should not' see 'Fish Ad.mov,Fish-Ad.mov' file in 'Files in your projects' section on Dashboard page

Examples:
| ProjectOwner    | ProjectUser     | GlobalRole   | ProjectName    | TabName             |
| PO_A5DACL_S02_1 | PU_A5DACL_S02_1 | agency.admin | P_A5DACL_S02_1 | Latest files added  |
| PO_A5DACL_S02_2 | PU_A5DACL_S02_2 | agency.admin | P_A5DACL_S02_2 | Latest added by you |
| PO_A5DACL_S02_3 | PU_A5DACL_S02_3 | agency.user  | P_A5DACL_S02_3 | Latest files added  |
| PO_A5DACL_S02_4 | PU_A5DACL_S02_4 | agency.user  | P_A5DACL_S02_4 | Latest added by you |
| PO_A5DACL_S02_5 | PU_A5DACL_S02_5 | guest.user   | P_A5DACL_S02_5 | Latest files added  |
| PO_A5DACL_S02_6 | PU_A5DACL_S02_6 | guest.user   | P_A5DACL_S02_6 | Latest added by you |


Scenario: check that user can see activity for project folders and files, if he is project owner
Meta:@gdam
     @projects
Given I created users with following fields:
| Email           | Role         |
| PO_A5DACL_S03_1 | agency.admin |
| PO_A5DACL_S03_2 | agency.user  |
And logged in with details of 'PO_A5DACL_S03_1'
And created 'P_A5DACL_S03_1' project
And created '/F_A5DACL_S03' folder for project 'P_A5DACL_S03_1'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DACL_S03' folder for 'P_A5DACL_S03_1' project
And fill Share popup by users 'PO_A5DACL_S03_2' in project 'P_A5DACL_S03_1' folders '/F_A5DACL_S03' with role 'project.contributor' expired '12.02.2021' and 'should' access to subfolders
And logged in with details of 'PO_A5DACL_S03_2'
And uploaded '/files/Fish-Ad.mov' file into '/F_A5DACL_S03' folder for 'P_A5DACL_S03_1' project
And waited while transcoding is finished in folder '/F_A5DACL_S03' on project 'P_A5DACL_S03_1' files page
When I login with details of 'PO_A5DACL_S03_1'
And go to Dashboard page
And maximize 'Recent Activity' section on Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName        | Message                      | Value                                                  |
| PO_A5DACL_S03_1 | uploaded 1 files Fish Ad.mov | P_A5DACL_S03_1/P_A5DACL_S03_1/F_A5DACL_S03/Fish Ad.mov |
| PO_A5DACL_S03_2 | uploaded 1 files Fish-Ad.mov | P_A5DACL_S03_1/P_A5DACL_S03_1/F_A5DACL_S03/Fish-Ad.mov |


Scenario: check that user can see own projects on 'My Projects' section
Meta:@gdam
     @projects
Given I created users with following fields:
| Email          | Role         |
| <ProjectOwner> | <GlobalRole> |
And logged in with details of '<ProjectOwner>'
And created '<ProjectName>' project
And created '/F_A5DACL_S05' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DACL_S05' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_A5DACL_S05' on project '<ProjectName>' files page
When I go to Dashboard page
And maximize 'My Projects' section on Dashboard page
Then I 'should' see '<ProjectName>' project in 'My Projects' section on Dashboard page

Examples:
| ProjectOwner    | GlobalRole   | ProjectName    |
| PO_A5DACL_S05_1 | agency.admin | P_A5DACL_S05_1 |
| PO_A5DACL_S05_2 | agency.user  | P_A5DACL_S05_2 |


Scenario: check that user cannot see not own projects on 'My Projects' section
Meta:@gdam
     @projects
Given I created users with following fields:
| Email         | Role         |
| <ProjectUser> | <GlobalRole> |
And created '<ProjectName>' project
And created '/F_A5DACL_S06' folder for project '<ProjectName>'
And fill Share popup by users '<ProjectUser>' in project '<ProjectName>' folders '/F_A5DACL_S06' with role 'project.contributor' expired '12.02.2021' and 'should' access to subfolders
And logged in with details of '<ProjectUser>'
And uploaded '/files/Fish Ad.mov' file into '/F_A5DACL_S06' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_A5DACL_S06' on project '<ProjectName>' files page
When I go to Dashboard page
And maximize 'My Projects' section on Dashboard page
Then I 'should not' see '<ProjectName>' project in 'My Projects' section on Dashboard page

Examples:
| ProjectUser     | GlobalRole   | ProjectName    |
| PU_A5DACL_S06_1 | agency.admin | P_A5DACL_S06_1 |
| PU_A5DACL_S06_2 | agency.user  | P_A5DACL_S06_2 |
| PU_A5DACL_S06_3 | guest.user   | P_A5DACL_S06_3 |


Scenario: check that user cannot see not own presentations
Meta:@gdam
     @library
Given I created users with following fields:
| Email              | Role         |Access|
| <PresentationUser> | <GlobalRole> |streamlined_library|
And I created following reels:
| Name              |
| <PresentationName> |
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I added asset 'Fish Ad.mov' into existing presentation '<PresentationName>' from collection 'Everything'NEWLIB
And sent presentation '<PresentationName>' to user '<PresentationUser>' with personal message 'Hello PU_A5DACL_S07'
And logged in with details of '<PresentationUser>'
And opened link from letter with subject '<PresentationName>' for presentation
When I go to Dashboard page
And maximize 'Presentations' section on Dashboard page
Then I 'should not' see '<PresentationName>' presentation in 'Presentations' section on Dashboard page

Examples:
| PresentationUser | GlobalRole   | PresentationName |
| PU_A5DACL_S07_2  | agency.user  | P_A5DACL_S07_2   |
| PU_A5DACL_S07_3  | guest.user   | P_A5DACL_S07_3   |


Scenario: check 'Quick start' links availability for guest user
Meta:@gdam
Given I created users with following fields:
| Email       | Role       | Access       |
| <UserEmail> | <UserRole> | <UserAccess> |
And logged in with details of '<UserEmail>'
Then I 'should' see 'Quick start' links '<AvailableQuickStartLinks>'

Examples:
| UserEmail      | UserRole    | UserAccess                      | AvailableQuickStartLinks                                             |
| U_A5DACL_S09_1 | guest.user  | library,dashboard               | Search your library                                                  |
| U_A5DACL_S09_2 | guest.user  | folders,dashboard               |                                                                      |
| U_A5DACL_S09_3 | guest.user  | library,folders,dashboard       | Search your library                                                  |
| U_A5DACL_S09_4 | agency.user | library,presentations,dashboard | Search your library,Upload to your library,Create a new presentation |
| U_A5DACL_S09_5 | agency.user | folders,dashboard               | Start a new project                                                  |
| U_A5DACL_S09_6 | agency.user | library,folders,dashboard       | Start a new project,Search your library,Upload to your library       |


Scenario: check that user can see sections according to application access
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role       | Access       |
| <UserEmail> | <UserRole> | <UserAccess> |
And logged in with details of '<UserEmail>'
Then I 'should' see section '<VisibleSectionNames>' on Dashboard page
Then I 'should not' see section '<HiddenSectionNames>' on Dashboard page

Examples:
| UserEmail      | UserRole    | UserAccess                              | VisibleSectionNames                                                                     | HiddenSectionNames                             |
| U_A5DACL_S10_1 | guest.user  | library,presentations,dashboard         | Presentations,Recent Activity                                                           | Approvals,Files in your projects,My Projects   |
| U_A5DACL_S10_2 | guest.user  | folders,dashboard                       | Files in your projects,My Projects,Recent Activity                                      | Approvals,Presentations,Latest Library Uploads |
| U_A5DACL_S10_3 | guest.user  | library,folders,approvals,dashboard     | Approvals,Files in your projects,My Projects,Recent Activity                            |                                                |
| U_A5DACL_S10_4 | agency.user | library,dashboard                       | Latest Library Uploads,Recent Activity                                                  | Approvals,Files in your projects,My Projects   |
| U_A5DACL_S10_5 | agency.user | folders,approvals,dashboard             | Approvals,Files in your projects,My Projects,Recent Activity                            | Presentations,Latest Library Uploads           |
| U_A5DACL_S10_6 | agency.user | library,folders,presentations,dashboard | Files in your projects,Presentations,Latest Library Uploads,My Projects,Recent Activity | Approvals                                      |


Scenario: check that if library is disable for user then he cannot see activity log for library
Meta:@gdam
     @library
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email        | Role         | Access                    | AgencyUnique |
| <AdminEmail> | agency.admin | streamlined_library,library,folders,dashboard | <Agency>     |
| <UserEmail>  | <UserRole>   | streamlined_library,folders,dashboard         | <Agency>     |
And logged in with details of '<AdminEmail>'
And uploaded following assetsNEWLIB:
| Name             |
| /files/Fish Ad.mov |
| /files/Fish-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And logged in with details of '<UserEmail>'
When I go to Dashboard page
Then I 'should not' see following activities in 'Recent Activity' section on Dashboard page:
| UserName     | Message            | Value       |
| <AdminEmail> | uploaded the asset | Fish Ad.mov |
| <AdminEmail> | uploaded the asset | Fish-Ad.mov |

Examples:
| AdminEmail      | UserEmail      | UserRole    | Agency         |
| AU_A5DACL_S11_1 | U_A5DACL_S11_1 | guest.user  | A_A5DACL_S11_1 |
| AU_A5DACL_S11_2 | U_A5DACL_S11_2 | agency.user | A_A5DACL_S11_2 |