!--NGN-5307
Feature:          Add new permission - Version History Read
Narrative:
In order to
As a              AgencyAdmin
I want to         Check add new permission Version History Read

Scenario: Check that permission 'element.version_history.read' selected by default for roles agency.admin, project.admin, project.contributor
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser 'DefaultAgency' on global roles page
And selected advertiser 'DefaultAgency' on global roles page
When open role '<RoleName>' page with parent 'DefaultAgency'
And refresh the page
Then I '<Condition>' see 'selected' permissions 'element.version_history.read' on opened global role page

Examples:
| RoleName            | Condition  |
| agency.admin        | should     |
| agency.user         | should not |
| guest.user          | should not |
| project.admin       | should     |
| project.contributor | should     |
| project.observer    | should not |
| approver            | should not |
| project.user        | should not |


Scenario: Check that permission element.version_history.read is available only forglobal and project roles
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
When I create '<RoleName>' role in '<RoleType>' group for organization 'DefaultAgency'
Then I '<Condition>' see 'available' permissions 'element.version_history.read' on opened global role page

Examples:
| RoleName       | RoleType | Condition  |
| R_ANPVHR_S02_1 | global   | should     |
| R_ANPVHR_S02_2 | project  | should     |
| R_ANPVHR_S02_3 | library  | should not |


Scenario: Check that Agency Admin of agency where project has been created by another user can see Version History tab and Upload new version button Project File view
Meta:@projects
     @gdam
Given logged in with details of 'AgencyUser'
And created 'P_ANPVHR_S03' project
And created '/F_ANPVHR_S03' folder for project 'P_ANPVHR_S03'
And uploaded '/images/logo.jpg' file into '/F_ANPVHR_S03' folder for 'P_ANPVHR_S03' project
When I login with details of 'AgencyAdmin'
Then I 'should' see active 'Version History' tab on file 'logo.jpg' info page in folder '/F_ANPVHR_S03' project 'P_ANPVHR_S03'
And 'should' see Upload new version button on file 'logo.jpg' info page in folder '/F_ANPVHR_S03' project 'P_ANPVHR_S03'


Scenario: Check that Agency Admin of agency where project has been created by another user can see drop down of file versions of the Project File view
Meta:@projects
     @gdam
Given logged in with details of 'AgencyUser'
And created 'P_ANPVHR_S04' project
And created '/F_ANPVHR_S04' folder for project 'P_ANPVHR_S04'
And uploaded '/images/logo.jpg' file into '/F_ANPVHR_S04' folder for 'P_ANPVHR_S04' project
And waited while transcoding is finished in folder '/F_ANPVHR_S04' on project 'P_ANPVHR_S04' files page
And uploaded new file version '/images/logo.jpg' for file 'logo.jpg' into '/F_ANPVHR_S04' folder for 'P_ANPVHR_S04' project
And waited while transcoding is finished in folder '/F_ANPVHR_S04' on project 'P_ANPVHR_S04' files page
When I login with details of 'AgencyAdmin'
Then I 'should' see file version drop down on file 'logo.jpg' info page in folder '/F_ANPVHR_S04' project 'P_ANPVHR_S04'


Scenario: Check that user can see Version History tab of file according to his element.version_history.read permission(Admin/Agency/Guest global user types)
Meta:@projects
     @gdam
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission            |
| element.read          |
| folder.read           |
| project.read          |
| project_template.read |
| <Permission>          |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created 'P_ANPVHR_S05' project
And created '/F_ANPVHR_S05' folder for project 'P_ANPVHR_S05'
And uploaded '/images/logo.jpg' file into '/F_ANPVHR_S05' folder for 'P_ANPVHR_S05' project
And waited while transcoding is finished in folder '/F_ANPVHR_S05' on project 'P_ANPVHR_S05' files page
And uploaded new file version '/images/logo.jpg' for file 'logo.jpg' into '/F_ANPVHR_S05' folder for 'P_ANPVHR_S05' project
And waited while transcoding is finished in folder '/F_ANPVHR_S05' on project 'P_ANPVHR_S05' files page
And fill Share popup by users '<UserEmail>' in project 'P_ANPVHR_S05' folders '/F_ANPVHR_S05' with role '<ProjectRole>' expired '12.02.2021' and 'should' access to subfolders
And logged in with details of '<UserEmail>'
Then I '<Condition>' see active 'Version History' tab on file 'logo.jpg' info page in folder '/F_ANPVHR_S05' project 'P_ANPVHR_S05'
And '<Condition>' see file version drop down on file 'logo.jpg' info page in folder '/F_ANPVHR_S05' project 'P_ANPVHR_S05'

Examples:
| UserEmail       | UserRole     | UserAgency    | ProjectRole    | Permission                   | Condition  |
| U_ANPVHR_S05_1  | agency.admin | DefaultAgency | R_ANPVHR_S05_1 | element.version_history.read | should     |
| U_ANPVHR_S05_2  | agency.user  | DefaultAgency | R_ANPVHR_S05_1 | element.version_history.read | should     |
| U_ANPVHR_S05_3  | guest.user   | DefaultAgency | R_ANPVHR_S05_1 | element.version_history.read | should     |
| U_ANPVHR_S05_4  | agency.admin | AnotherAgency | R_ANPVHR_S05_1 | element.version_history.read | should     |
| U_ANPVHR_S05_5  | agency.user  | AnotherAgency | R_ANPVHR_S05_1 | element.version_history.read | should     |
| U_ANPVHR_S05_6  | guest.user   | AnotherAgency | R_ANPVHR_S05_1 | element.version_history.read | should     |
| U_ANPVHR_S05_7  | agency.admin | DefaultAgency | R_ANPVHR_S05_2 |                              | should     |
| U_ANPVHR_S05_8  | agency.user  | DefaultAgency | R_ANPVHR_S05_2 |                              | should not |
| U_ANPVHR_S05_9  | guest.user   | DefaultAgency | R_ANPVHR_S05_2 |                              | should not |
| U_ANPVHR_S05_10 | agency.admin | AnotherAgency | R_ANPVHR_S05_2 |                              | should not |
| U_ANPVHR_S05_11 | agency.user  | AnotherAgency | R_ANPVHR_S05_2 |                              | should not |
| U_ANPVHR_S05_12 | guest.user   | AnotherAgency | R_ANPVHR_S05_2 |                              | should not |


Scenario: Check that comments for previous version of file isn't displayed for user whom folder with file has been shared without element.version_history.read permission(Admin/Agency/Guest global user types)
Meta:@projects
     @gdam
Given I created 'R_ANPVHR_S06' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                   |
| element.read                 |
| folder.read                  |
| project.read                 |
| project_template.read        |
| comment.read                 |
| element.version_history.read |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created 'P_ANPVHR_S06' project
And created '/F_ANPVHR_S06' folder for project 'P_ANPVHR_S06'
And uploaded '/images/logo.jpg' file into '/F_ANPVHR_S06' folder for 'P_ANPVHR_S06' project
And waited while transcoding is finished in folder '/F_ANPVHR_S06' on project 'P_ANPVHR_S06' files page
And added comment 'comment for first version' on file 'logo.jpg' comments page on folder '/F_ANPVHR_S06' in project 'P_ANPVHR_S06'
And uploaded new file version '/images/logo.jpg' for file 'logo.jpg' into '/F_ANPVHR_S06' folder for 'P_ANPVHR_S06' project
And waited while transcoding is finished in folder '/F_ANPVHR_S06' on project 'P_ANPVHR_S06' files page
And added comment 'comment for second version' on file 'logo.jpg' comments page on folder '/F_ANPVHR_S06' in project 'P_ANPVHR_S06'
And fill Share popup by users '<UserEmail>' in project 'P_ANPVHR_S06' folders '/F_ANPVHR_S06' with role 'R_ANPVHR_S06' expired '12.02.2021' and 'should' access to subfolders
And logged in with details of '<UserEmail>'
Then I 'should' see comment 'comment for second version' on file 'logo.jpg' comments page on folder '/F_ANPVHR_S06' in project 'P_ANPVHR_S06'
And 'should not' see comment 'comment for first version' on file 'logo.jpg' comments page on folder '/F_ANPVHR_S06' in project 'P_ANPVHR_S06'

Examples:
| UserEmail      | UserRole     | UserAgency    |
| U_ANPVHR_S06_1 | agency.user  | DefaultAgency |
| U_ANPVHR_S06_2 | guest.user   | DefaultAgency |
| U_ANPVHR_S06_3 | agency.admin | AnotherAgency |
| U_ANPVHR_S06_4 | agency.user  | AnotherAgency |
| U_ANPVHR_S06_5 | guest.user   | AnotherAgency |


Scenario: Check that activity for previous version of file isn't displayed for user whom folder with file has been shared without element.version_history.read permission(Admin/Agency/Guest global user types)
Meta:@projects
     @gdam
Given I created 'R_ANPVHR_S08' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission            |
| activity.read         |
| element.read          |
| folder.read           |
| project.read          |
| project_template.read |
| comment.read          |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created 'P_ANPVHR_S08' project
And created '/F_ANPVHR_S08' folder for project 'P_ANPVHR_S08'
And uploaded '/images/logo.jpg' file into '/F_ANPVHR_S08' folder for 'P_ANPVHR_S08' project
And waited while transcoding is finished in folder '/F_ANPVHR_S08' on project 'P_ANPVHR_S08' files page
And added comment 'comment for first version' on file 'logo.jpg' comments page on folder '/F_ANPVHR_S08' in project 'P_ANPVHR_S08'
And uploaded new file version '/images/logo.jpg' for file 'logo.jpg' into '/F_ANPVHR_S08' folder for 'P_ANPVHR_S08' project
And waited while transcoding is finished in folder '/F_ANPVHR_S08' on project 'P_ANPVHR_S08' files page
And added comment 'comment for second version' on file 'logo.jpg' comments page on folder '/F_ANPVHR_S08' in project 'P_ANPVHR_S08'
And fill Share popup by users '<UserEmail>' in project 'P_ANPVHR_S08' folders '/F_ANPVHR_S08' with role 'R_ANPVHR_S08' expired '12.02.2021' and 'should' access to subfolders
And logged in with details of '<UserEmail>'
Then I 'should not' see comment 'comment for first version' on file 'logo.jpg' comments page on folder '/F_ANPVHR_S08' in project 'P_ANPVHR_S08'
And I 'should' see comment 'comment for second version' on file 'logo.jpg' comments page on folder '/F_ANPVHR_S08' in project 'P_ANPVHR_S08'

Examples:
| UserEmail      | UserRole     | UserAgency    |
| U_ANPVHR_S08_1 | agency.user  | DefaultAgency |
| U_ANPVHR_S08_2 | guest.user   | DefaultAgency |
| U_ANPVHR_S08_3 | agency.admin | AnotherAgency |
| U_ANPVHR_S08_4 | agency.user  | AnotherAgency |
| U_ANPVHR_S08_5 | guest.user   | AnotherAgency |


Scenario: Check that in case to download file with versions by user whom folder with file has been shared without element.version_history.read permission only current version is downloaded
Meta:@projects
     @gdam
Given I created 'R_ANPVHR_S09' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission            |
| element.read          |
| folder.read           |
| project.read          |
| project_template.read |
| file.download         |
| proxy.download        |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created 'P_ANPVHR_S09' project
And created '/F_ANPVHR_S09' folder for project 'P_ANPVHR_S09'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPVHR_S09' folder for 'P_ANPVHR_S09' project
And waited while preview is available in folder '/F_ANPVHR_S09' on project 'P_ANPVHR_S09' files page
And uploaded new file version '/files/Fish-Ad.mov' for file 'Fish Ad.mov' into '/F_ANPVHR_S09' folder for 'P_ANPVHR_S09' project
And waited while preview is visible on project 'P_ANPVHR_S09' in folder '/F_ANPVHR_S09' for 'Fish Ad.mov' file
And fill Share popup by users '<UserEmail>' in project 'P_ANPVHR_S09' folders '/F_ANPVHR_S09' with role 'R_ANPVHR_S09' expired '12.02.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
Then I 'should' see download button 'Original' ready to download file on file 'Fish Ad.mov' info page in folder '/F_ANPVHR_S09' for project 'P_ANPVHR_S09'
Then I 'should' see download button 'Preview' ready to download file on file 'Fish Ad.mov' info page in folder '/F_ANPVHR_S09' for project 'P_ANPVHR_S09'

Examples:
| UserEmail      | UserRole     | UserAgency    |
| U_ANPVHR_S09_1 | agency.user  | DefaultAgency |
| U_ANPVHR_S09_2 | guest.user   | DefaultAgency |
| U_ANPVHR_S09_3 | agency.admin | AnotherAgency |
| U_ANPVHR_S09_4 | agency.user  | AnotherAgency |
| U_ANPVHR_S09_5 | guest.user   | AnotherAgency |


Scenario: Check availability of Version History tab and drop down on the Version button in the top right panel of the file details for user with 'Project Admin' project role
Meta:@projects
     @gdam
Given I created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created 'P_ANPVHR_S11' project
And created '/F_ANPVHR_S11' folder for project 'P_ANPVHR_S11'
And uploaded '/images/logo.jpg' file into '/F_ANPVHR_S11' folder for 'P_ANPVHR_S11' project
And waited while transcoding is finished in folder '/F_ANPVHR_S11' on project 'P_ANPVHR_S11' files page
And uploaded new file version '/images/logo.jpg' for file 'logo.jpg' into '/F_ANPVHR_S11' folder for 'P_ANPVHR_S11' project
And waited while transcoding is finished in folder '/F_ANPVHR_S11' on project 'P_ANPVHR_S11' files page
And added user '<UserEmail>' into address book
And I am on project 'P_ANPVHR_S11' settings page
And edited the following fields for 'P_ANPVHR_S11' project:
| Name         | Administrators |
| P_ANPVHR_S11 | <UserEmail>    |
And clicked on element 'SaveButton'
And waited for '3' seconds
And logged in with details of '<UserEmail>'
Then I 'should' see active 'Version History' tab on file 'logo.jpg' info page in folder '/F_ANPVHR_S11' project 'P_ANPVHR_S11'
And 'should' see file version drop down on file 'logo.jpg' info page in folder '/F_ANPVHR_S11' project 'P_ANPVHR_S11'

Examples:
| UserEmail       | UserRole     | UserAgency    |
| U_ANPVHR_S11_1  | agency.user  | DefaultAgency |
| U_ANPVHR_S11_2  | guest.user   | DefaultAgency |
| U_ANPVHR_S11_3  | agency.admin | AnotherAgency |
| U_ANPVHR_S11_4  | agency.user  | AnotherAgency |
| U_ANPVHR_S11_5  | guest.user   | AnotherAgency |