!--NGN-616
Feature:          Project Share folder - Agency view
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Share folder - Agency view

Scenario: Check that user whom folder has been shared goes to shared folder using link from email
Meta:@gdam
@projects
Given I created users with following fields:
| Email    | Role       | Agency        |
| Ann_S1_1 | guest.user | DefaultAgency |
| Ann_S1_2 | guest.user | DefaultAgency |
And I created following projects:
| Name        | Advertiser    |
| P_SFAV_S1_1 | DefaultAgency |
| P_SFAV_S1_2 | AnotherAgency |
And created '/F_SFAV_S1_1' folder for project 'P_SFAV_S1_1'
And created '/F_SFAV_S1_2' folder for project 'P_SFAV_S1_2'
And fill Share popup by users 'Ann_S1_1' in project 'P_SFAV_S1_1' folders '/F_SFAV_S1_1' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
And fill Share popup by users 'Ann_S1_2' in project 'P_SFAV_S1_2' folders '/F_SFAV_S1_2' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
When I open link from email when user 'Ann_S1_1' received email with next subject 'Folders have been shared with'
And login with details of 'Ann_S1_1'
Then I 'should' see '/F_SFAV_S1_1' folder in 'P_SFAV_S1_1' project
When I open link from email when user 'Ann_S1_2' received email with next subject 'Folders have been shared with'
And login with details of 'Ann_S1_2'
Then I 'should' see '/F_SFAV_S1_2' folder in 'P_SFAV_S1_2' project


Scenario: Check availability of project that includes shared folder for user whom this folder has been shared
Meta:@gdam
@projects
Given I created users with following fields:
| Email  | Role       | Agency        |
| Ann_S2 | guest.user | DefaultAgency |
And I created following projects:
| Name        | Advertiser    |
| P_SFAV_S2_1 | DefaultAgency |
| P_SFAV_S2_2 | AnotherAgency |
| P_SFAV_S2_3 | DefaultAgency |
| P_SFAV_S2_4 | AnotherAgency |
And created '/F_SFAV_S2_1' folder for project 'P_SFAV_S2_1'
And created '/F_SFAV_S2_2' folder for project 'P_SFAV_S2_2'
And fill Share popup by users 'Ann_S2' in project 'P_SFAV_S2_1' folders '/F_SFAV_S2_1' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
And fill Share popup by users 'Ann_S2' in project 'P_SFAV_S2_2' folders '/F_SFAV_S2_2' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
When I login with details of 'Ann_S2'
And I go to Project list page
Then I 'should' see only project 'P_SFAV_S2_1,P_SFAV_S2_2' in project list


Scenario: Check that only shared folder is available for user whom this folder has been shared
Meta:@gdam
@projects
Given I created users with following fields:
| Email  | Role       | Agency        |
| Ann_S3 | guest.user | DefaultAgency |
And I created following projects:
| Name        | Advertiser    |
| P_SFAV_S3_1 | DefaultAgency |
| P_SFAV_S3_2 | AnotherAgency |
And created '<Folder>' folder for project 'P_SFAV_S3_1'
And created '<Folder>' folder for project 'P_SFAV_S3_2'
And fill Share popup by users 'Ann_S3' in project 'P_SFAV_S3_1' folders '<Folder>' with role 'project.user' expired '12.12.2022' and 'should not' access to subfolders
And fill Share popup by users 'Ann_S3' in project 'P_SFAV_S3_2' folders '<Folder>' with role 'project.user' expired '12.12.2022' and 'should not' access to subfolders
When login with details of 'Ann_S3'
And I go to project 'P_SFAV_S3_1' overview page
Then I 'should' see '<SharedFolder>' folder in 'P_SFAV_S3_1' project
When I go to project 'P_SFAV_S3_2' overview page
Then I 'should' see '<SharedFolder>' folder in 'P_SFAV_S3_2' project

Examples:
| Folder                   | SharedFolder |
| /F_SFAV_S3_1             | /F_SFAV_S3_1 |
| /F_SFAV_S3_1/F_SFAV_S3_2 | /F_SFAV_S3_2 |


Scenario: Check that files within shared folder are available for user whom this folder has been shared
Meta:@gdam
@projects
Given I created users with following fields:
| Email  | Role       | Agency        |
| Ann_S4 | guest.user | DefaultAgency |
And I created following projects:
| Name        | Advertiser    |
| P_SFAV_S4_1 | DefaultAgency |
| P_SFAV_S4_2 | AnotherAgency |
And created '/F_SFAV_S4_1' folder for project 'P_SFAV_S4_1'
And created '/F_SFAV_S4_2' folder for project 'P_SFAV_S4_2'
And I uploaded into project 'P_SFAV_S4_1' following files:
| FileName           | Path         |
| /files/audio01.mp3 | /F_SFAV_S4_1 |
| /images/logo.gif   | /F_SFAV_S4_1 |
And I uploaded into project 'P_SFAV_S4_2' following files:
| FileName               | Path         |
| /files/atCalcVideo.mov | /F_SFAV_S4_2 |
| /images/logo.png       | /F_SFAV_S4_2 |
And fill Share popup by users 'Ann_S4' in project 'P_SFAV_S4_1' folders '/F_SFAV_S4_1' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
And fill Share popup by users 'Ann_S4' in project 'P_SFAV_S4_2' folders '/F_SFAV_S4_2' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
When login with details of 'Ann_S4'
And I go to project 'P_SFAV_S4_1' files page
Then I should see following files inside '/F_SFAV_S4_1' folder for 'P_SFAV_S4_1' project:
| FileName    |
| audio01.mp3 |
| logo.gif    |
When I go to project 'P_SFAV_S4_2' files page
Then I should see following files inside '/F_SFAV_S4_2' folder for 'P_SFAV_S4_2' project:
| FileName        |
| atCalcVideo.mov |
| logo.png        |


Scenario: Check that files within shared folder are available for user whom this folder has been shared using link from email
Meta:@gdam
@projects
Given I created users with following fields:
| Email    | Role       | Agency        |
| Ann_S5_1 | guest.user | DefaultAgency |
| Ann_S5_2 | guest.user | DefaultAgency |
And I created following projects:
| Name        | Advertiser    |
| P_SFAV_S5_1 | DefaultAgency |
| P_SFAV_S5_2 | AnotherAgency |
And created '/F_SFAV_S5_1' folder for project 'P_SFAV_S5_1'
And created '/F_SFAV_S5_2' folder for project 'P_SFAV_S5_2'
And I uploaded into project 'P_SFAV_S5_1' following files:
| FileName           | Path         |
| /files/audio01.mp3 | /F_SFAV_S5_1 |
| /images/logo.gif   | /F_SFAV_S5_1 |
And I uploaded into project 'P_SFAV_S5_2' following files:
| FileName           | Path         |
| /files/audio01.mp3 | /F_SFAV_S5_2 |
| /images/logo.gif   | /F_SFAV_S5_2 |
And fill Share popup by users 'Ann_S5_1' in project 'P_SFAV_S5_1' folders '/F_SFAV_S5_1' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
And fill Share popup by users 'Ann_S5_2' in project 'P_SFAV_S5_2' folders '/F_SFAV_S5_2' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
When I login with details of 'Ann_S5_1'
And open link from email when user 'Ann_S5_1' received email with next subject 'Folders have been shared with'
Then I should see following files inside '/F_SFAV_S5_1' folder for 'P_SFAV_S5_1' project:
| FileName    |
| audio01.mp3 |
| logo.gif    |
When I login with details of 'Ann_S5_2'
And open link from email when user 'Ann_S5_2' received email with next subject 'Folders have been shared with'
Then I should see following files inside '/F_SFAV_S5_2' folder for 'P_SFAV_S5_2' project:
| FileName    |
| audio01.mp3 |
| logo.gif    |