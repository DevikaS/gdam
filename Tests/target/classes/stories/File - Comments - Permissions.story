!--NGN-783 NGN-2420
Feature:          File - Comments - Permissions
Narrative:
In order to
As a              AgencyAdmin
I want to         Check file commenting due to permissions

Scenario: Check that visibility of comments depends on 'view comment' permissions
Meta:@gdam
@projects
Given I created '<ProjectName>' project
And I created in '<ProjectName>' project next folders:
| folder       |
| /F_FCPS_S1_1 |
And I uploaded into project '<ProjectName>' following files:
| FileName          | Path         |
| /files/filetext.txt | /F_FCPS_S1_1 |
And waited while transcoding is finished in folder '/F_FCPS_S1_1' on project '<ProjectName>' files page
And I am on the file comments page project '<ProjectName>' and folder '/F_FCPS_S1_1' and file 'filetext.txt'
And I added comment 'It is my point of view' into current file
And I created users with following fields:
| Email      | Logo | Role       |
| UFCGS_S5_1 | JPEG | guest.user |
| UFCGS_S5_2 | JPEG | guest.user |
And I created '<Role>' role with '<Permission>' permissions in 'project' group for advertiser 'DefaultAgency'
And I added users '<User>' to project '<ProjectName>' team folders '/F_FCPS_S1_1' with role '<Role>' expired '12.12.2021' and 'should' access to subfolders
When I login with details of '<User>'
Then I '<Should>' see tab 'Comments' for file 'filetext.txt' in the folder '/F_FCPS_S1_1' on the project '<ProjectName>'

Examples:
| User       | Role        | ProjectName | Permission                                         | Should     |
| UFCGS_S5_1 | R_FCPS_S1_1 | P_FCPS_S1_1 | folder.read,element.read,project.read              | should not |
| UFCGS_S5_2 | R_FCPS_S1_2 | P_FCPS_S1_2 | folder.read,element.read,project.read,comment.read | should     |


Scenario: Check that ability to remove comments depends on 'delete comment' permissions
Meta:@gdam
@projects
Given I created users with following fields:
| Email      |
| UFCGS_S2_0 |
And I logged in with details of 'UFCGS_S2_0'
Given I created '<ProjectName>' project
And I created in '<ProjectName>' project next folders:
| folder       |
| /F_FCPS_S2_1 |
And I uploaded into project '<ProjectName>' following files:
| FileName           | Path         |
| /files/filetext.txt  | /F_FCPS_S2_1 |
And waited while transcoding is finished in folder '/F_FCPS_S2_1' on project '<ProjectName>' files page
And I am on the file comments page project '<ProjectName>' and folder '/F_FCPS_S2_1' and file 'filetext.txt'
And I added comment 'It is my point of view' into current file
And I created users with following fields:
| Email      | Logo | Role       |
| UFCGS_S2_1 | JPEG | guest.user |
| UFCGS_S2_2 | JPEG | guest.user |
And I created '<Role>' role with '<Permission>' permissions in 'project' group for advertiser 'DefaultAgency'
And I added users '<User>' to project '<ProjectName>' team folders '/F_FCPS_S2_1' with role '<Role>' expired '12.12.2021' and 'should' access to subfolders
When I login with details of '<User>'
And I go to the file comments page project '<ProjectName>' and folder '/F_FCPS_S2_1' and file 'filetext.txt'
Then I should see following comments for current file:
| Name                   | Email      |
| It is my point of view | UFCGS_S2_0 |
And I '<Should>' see remove link for file comment 'It is my point of view' for file 'filetext.txt' in project '<ProjectName>' and folder '/F_FCPS_S2_1'
And I 'should not' see reply link for file comment 'It is my point of view' for file 'filetext.txt' in project '<ProjectName>' and folder '/F_FCPS_S2_1'
And I 'should not' see comment textarea on current file comment page

Examples:
| User       | Role        | ProjectName | Permission                                                        | Should     |
| UFCGS_S2_1 | R_FCPS_S2_1 | P_FCPS_S2_1 | folder.read,element.read,project.read,comment.read                | should not |
| UFCGS_S2_2 | R_FCPS_S2_2 | P_FCPS_S2_2 | folder.read,element.read,project.read,comment.read,comment.delete | should     |


Scenario: Check that ability to create comments depends on 'create comment' permissions
Meta:@gdam
@projects
Given I created users with following fields:
| Email      |
| UFCGS_S3_0 |
And I logged in with details of 'UFCGS_S3_0'
And I created '<ProjectName>' project
And created '/F_FCPS_S3_1' folder for project '<ProjectName>'
And I uploaded into project '<ProjectName>' following files:
| FileName          | Path         |
| /files/filetext.txt | /F_FCPS_S3_1 |
And waited while transcoding is finished in folder '/F_FCPS_S3_1' on project '<ProjectName>' files page
And I am on the file comments page project '<ProjectName>' and folder '/F_FCPS_S3_1' and file 'filetext.txt'
And I added comment 'It is my point of view' into current file
And I created users with following fields:
| Email      | Logo | Role       |
| UFCGS_S3_1 | JPEG | guest.user |
| UFCGS_S3_2 | JPEG | guest.user |
And I created '<Role>' role with '<Permission>' permissions in 'project' group for advertiser 'DefaultAgency'
And I added users '<User>' to project '<ProjectName>' team folders '/F_FCPS_S3_1' with role '<Role>' expired '12.12.2021' and 'should' access to subfolders
When I login with details of '<User>'
And I go to the file comments page project '<ProjectName>' and folder '/F_FCPS_S3_1' and file 'filetext.txt'
Then I should see following comments for current file:
| Name                   | Email      |
| It is my point of view | UFCGS_S3_0 |
And I 'should not' see remove link for file comment 'It is my point of view' for file 'filetext.txt' in project '<ProjectName>' and folder '/F_FCPS_S3_1'
And I '<Should>' see reply link for file comment 'It is my point of view' for file 'filetext.txt' in project '<ProjectName>' and folder '/F_FCPS_S3_1'
And I '<Should>' see comment textarea on current file comment page

Examples:
| User       | Role        | ProjectName | Permission                                                        | Should     |
| UFCGS_S3_1 | R_FCPS_S3_1 | P_FCPS_S3_1 | folder.read,element.read,project.read,comment.read                | should not |
| UFCGS_S3_2 | R_FCPS_S3_2 | P_FCPS_S3_2 | folder.read,element.read,project.read,comment.read,comment.create | should     |


Scenario: Check that project owner has all permissions concerned with comment by default
Meta:@gdam
@projects
Given I created 'P_FCPS_S4_1' project
And I created in 'P_FCPS_S4_1' project next folders:
| folder       |
| /F_FCPS_S4_1 |
And I uploaded into project 'P_FCPS_S4_1' following files:
| FileName          | Path         |
| /files/filetext.txt | /F_FCPS_S4_1 |
And waited while transcoding is finished in folder '/F_FCPS_S4_1' on project 'P_FCPS_S4_1' files page
And I am on the file comments page project 'P_FCPS_S4_1' and folder '/F_FCPS_S4_1' and file 'filetext.txt'
And I added comment 'It is my point of view' into current file
When I go to the file comments page project 'P_FCPS_S4_1' and folder '/F_FCPS_S4_1' and file 'filetext.txt'
Then I should see following comments for current file:
| Name                   |
| It is my point of view |
And I 'should' see remove link for file comment 'It is my point of view' for file 'filetext.txt' in project 'P_FCPS_S4_1' and folder '/F_FCPS_S4_1'
And I 'should' see reply link for file comment 'It is my point of view' for file 'filetext.txt' in project 'P_FCPS_S4_1' and folder '/F_FCPS_S4_1'
And I 'should' see comment textarea on current file comment page