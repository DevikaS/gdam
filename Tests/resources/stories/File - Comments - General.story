!--NGN-2421 NGN-783
Feature:          File - Comments - General
Narrative:
In order to
As a              AgencyAdmin
I want to         Check file commenting

Scenario: Check that comments are displayed in correct format
Meta:@gdam
@projects
Given I created 'P_FCGS_S1_1' project
And I created in 'P_FCGS_S1_1' project next folders:
| folder       |
| /F_FCGS_S1_1 |
And I uploaded into project 'P_FCGS_S1_1' following files:
| FileName          | Path         |
| /files/filetext.txt | /F_FCGS_S1_1 |
And waited while transcoding is finished in folder '/F_FCGS_S1_1' on project 'P_FCGS_S1_1' files page
And I am on the file comments page project 'P_FCGS_S1_1' and folder '/F_FCGS_S1_1' and file 'filetext.txt'
When I add comment 'It is my point of view' into current file
Then I 'should' see comment 'It is my point of view' for current file


Scenario: Check that comments are sorted by date
Meta:@gdam
@projects
Given I created 'P_FCGS_S2_1' project
And I created in 'P_FCGS_S2_1' project next folders:
| folder       |
| /F_FCGS_S2_1 |
And I uploaded into project 'P_FCGS_S2_1' following files:
| FileName          | Path         |
| /files/filetext.txt | /F_FCGS_S2_1 |
And waited while transcoding is finished in folder '/F_FCGS_S2_1' on project 'P_FCGS_S2_1' files page
And I am on the file comments page project 'P_FCGS_S2_1' and folder '/F_FCGS_S2_1' and file 'filetext.txt'
When I add following comments into current file:
| Name             | Sleep |
| Z First Comment  | 1000  |
| B Second Comment | 1000  |
| E Third Comment  | 1000  |
Then I should see following comments for current file:
| Name             |
| Z First Comment  |
| B Second Comment |
| E Third Comment  |


Scenario: Check that replying working
Meta:@gdam
@projects
Given I created 'P_FCGS_S3_1' project
And I created in 'P_FCGS_S3_1' project next folders:
| folder       |
| /F_FCGS_S3_1 |
And I uploaded into project 'P_FCGS_S3_1' following files:
| FileName          | Path         |
| /files/filetext.txt | /F_FCGS_S3_1 |
And waited while transcoding is finished in folder '/F_FCGS_S3_1' on project 'P_FCGS_S3_1' files page
And I am on the file comments page project 'P_FCGS_S3_1' and folder '/F_FCGS_S3_1' and file 'filetext.txt'
When I add comment 'Parent comment' into current file
And I replay 'Replay text' on comment 'Parent comment' for file 'filetext.txt' in project 'P_FCGS_S3_1' and folder '/F_FCGS_S3_1'
Then I should see following comments for current file:
| Name           |
| Parent comment |
| Replay text    |
And I 'should' see following child comments for current file:
| UserName    | Name        |
| AgencyAdmin | Replay text |


Scenario: Check that comment can be removed
!--NGN-2421
Meta:@gdam
@projects
Given I created 'P_FCGS_S4_1' project
And I created in 'P_FCGS_S4_1' project next folders:
| folder       |
| /F_FCGS_S4_1 |
And I uploaded into project 'P_FCGS_S4_1' following files:
| FileName          | Path         |
| /files/filetext.txt | /F_FCGS_S4_1 |
And waited while transcoding is finished in folder '/F_FCGS_S4_1' on project 'P_FCGS_S4_1' files page
And I am on the file comments page project 'P_FCGS_S4_1' and folder '/F_FCGS_S4_1' and file 'filetext.txt'
And I added comment 'Comment for remove' into current file
When I remove comment 'Comment for remove' for file 'filetext.txt' in project 'P_FCGS_S4_1' and folder '/F_FCGS_S4_1'
Then There are not any comments on the comments page for current file


Scenario: Check that comments are threaded
Meta:@gdam
@projects
Given I created users with following fields:
| Email      | Logo |
| UFCGS_S5_1 | JPEG |
| UFCGS_S5_2 | JPEG |
And I logged in with details of 'UFCGS_S5_1'
And I created 'P_FCGS_S5_1' project
And I created in 'P_FCGS_S5_1' project next folders:
| folder       |
| /F_FCGS_S5_1 |
And I uploaded into project 'P_FCGS_S5_1' following files:
| FileName          | Path         |
| /files/filetext.txt | /F_FCGS_S5_1 |
And waited while transcoding is finished in folder '/F_FCGS_S5_1' on project 'P_FCGS_S5_1' files page
And I am on the file comments page project 'P_FCGS_S5_1' and folder '/F_FCGS_S5_1' and file 'filetext.txt'
And I added comment 'Users1 comment - first' into current file
And I created 'R_FCGS_S5_1' role with 'comment.create,comment.delete,comment.read,folder.share,folder.read,element.read,folder.create,element.create,project.read,project.settings.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I added users 'UFCGS_S5_2' to project 'P_FCGS_S5_1' team folders '/F_FCGS_S5_1' with role 'R_FCGS_S5_1' expired '12.12.2021' and 'should' access to subfolders
And I logged in with details of 'UFCGS_S5_2'
When I go to the file comments page project 'P_FCGS_S5_1' and folder '/F_FCGS_S5_1' and file 'filetext.txt'
Then I should see following comments for current file:
| Name                   | Email      |
| Users1 comment - first | UFCGS_S5_1 |
When I add comment 'Users2 second - comment' into current file
And I login with details of 'UFCGS_S5_1'
And I go to the file comments page project 'P_FCGS_S5_1' and folder '/F_FCGS_S5_1' and file 'filetext.txt'
Then I should see following comments for current file:
| Name                    | Email      | Logo |
| Users1 comment - first  | UFCGS_S5_1 | JPEG |
| Users2 second - comment | UFCGS_S5_2 | JPEG |


Scenario: Check that comment can be added for uploading file
Meta: @gdam
      @projects
Given I created 'P_FCGS_S10_1' project
And I created in 'P_FCGS_S10_1' project next folders:
| folder        |
| /F_FCGS_S10_1 |
And created file '/temp/100mb.file' with length '104857600' bytes
And I uploaded into project 'P_FCGS_S10_1' following files:
| FileName         | Path          |
| /temp/100mb.file | /F_FCGS_S10_1 |
And I am on the file comments page project 'P_FCGS_S10_1' and folder '/F_FCGS_S10_1' and file '100mb.file'
And I added comment 'Big file - big comment' into current file
When I refresh the page
Then I 'should' see comment 'Big file - big comment' for current file