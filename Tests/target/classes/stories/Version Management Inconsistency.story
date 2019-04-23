!--NGN-5184 NGN-4138
Feature:          Version Management Inconsistency
Narrative:
In order to
As a              AgencyAdmin
I want to         Check version management

Scenario: Check that 'Upload new version' button is available for all file types
Meta:@gdam
@projects
Given I created 'P_VMI_S1' project
And created '/F_VMI_S1' folder for project 'P_VMI_S1'
And I uploaded into project 'P_VMI_S1' following files:
| FileName | Path      |
| <File>   | /F_VMI_S1 |
And I waited while transcoding is finished in folder '/F_VMI_S1' on project 'P_VMI_S1' files page
Then I 'should' see Upload new version button on file '<File>' info page in folder '/F_VMI_S1' project 'P_VMI_S1'

Examples:
| File               |
| /files/Fish-Ad.mov |
| /files/shortname.wav  |
| /files/logo3.jpg   |



Scenario: Check that after upload new revision, all versions appear in version tab
Meta:@gdam
@projects
Given I created 'P_VMI_S2' project
And created '/F_VMI_S2' folder for project 'P_VMI_S2'
And I uploaded into project 'P_VMI_S2' following files:
| FileName            | Path      |
| /files/Fish2-Ad.mov | /F_VMI_S2 |
And I uploaded into project 'P_VMI_S2' following revisions:
| FileName           | Path      | MasterFileName |
| /files/Fish Ad.mov | /F_VMI_S2 | Fish2-Ad.mov   |
And waited while preview is available in folder '/F_VMI_S2' on project 'P_VMI_S2' files page
And I am on file 'Fish2-Ad.mov' version history page in folder '/F_VMI_S2' project 'P_VMI_S2'
Then I 'should' see revision '2' on file 'Fish2-Ad.mov' version history page in folder '/F_VMI_S2' project 'P_VMI_S2' marked as Current
And I 'should not' see revision '1' on file 'Fish2-Ad.mov' version history page in folder '/F_VMI_S2' project 'P_VMI_S2' marked as Current


Scenario: Check that filename is not changed after upload new revision
Meta:@gdam
@projects
Given I created 'P_VMI_S3' project
And created '/F_VMI_S3' folder for project 'P_VMI_S3'
And I uploaded into project 'P_VMI_S3' following files:
| FileName            | Path      |
| /files/Fish2-Ad.mov | /F_VMI_S3 |
And I uploaded into project 'P_VMI_S3' following revisions:
| FileName                   | Path      | MasterFileName |
| /files/13DV-CAPITAL-10.mpg | /F_VMI_S3 | Fish2-Ad.mov   |
And waited while preview is available in folder '/F_VMI_S3' on project 'P_VMI_S3' files page
When I go to file 'Fish2-Ad.mov' info page in folder '/F_VMI_S3' project 'P_VMI_S3'
Then I 'should' see following 'custom metadata' fields on opened file info page:
| FieldName | FieldValue   |
| Title     | Fish2-Ad.mov |

Scenario: Check that 'Upload new version using SendPlus' button is available for all file types
Meta:@gdam
@projects
Given I created 'P_VMI_S1' project
And created '/F_VMI_S1' folder for project 'P_VMI_S1'
And I uploaded into project 'P_VMI_S1' following files:
| FileName | Path      |
| <File>   | /F_VMI_S1 |
And I waited while transcoding is finished in folder '/F_VMI_S1' on project 'P_VMI_S1' files page
Then I 'should' see '<Button>' button on upload dropdown on file '<File>' info page in folder '/F_VMI_S1' project 'P_VMI_S1'

Examples:
| File               |Button|
| /files/Fish-Ad.mov |Upload new version using SendPlus|
| /files/shortname.wav  |Upload new version using SendPlus|
| /files/logo3.jpg   |Upload new version using SendPlus|

Scenario: Check that after upload new revision, new proxy should be transcoded and become default
Meta:
@skip
@gdam
Given I created 'P_VMI_S4' project
And created '/F_VMI_S4' folder for project 'P_VMI_S4'
And I uploaded into project 'P_VMI_S4' following files:
| FileName            | Path      |
| /files/Fish2-Ad.mov | /F_VMI_S4 |
And I uploaded into project 'P_VMI_S4' following revisions:
| FileName                   | Path      | MasterFileName |
| /files/13DV-CAPITAL-10.mpg | /F_VMI_S4 | Fish2-Ad.mov   |
And waited while preview is available in folder '/F_VMI_S4' on project 'P_VMI_S4' files page
Then I should see proxy for <New_revision> file

Examples:
| First_revision | New_revision |
| 'BED.mp4'      | 'Fish_Ad.mov'|


Scenario: Check that after upload new revision,new version should be available for download on 'Version history' tab
Meta:@gdam
@projects
Given I created 'P_VMI_S5' project
And created '/F_VMI_S5' folder for project 'P_VMI_S5'
And I uploaded into project 'P_VMI_S5' following files:
| FileName            | Path      |
| /files/Fish2-Ad.mov | /F_VMI_S5 |
And I uploaded into project 'P_VMI_S5' following revisions:
| FileName                   | Path      | MasterFileName |
| /files/13DV-CAPITAL-10.mpg | /F_VMI_S5 | Fish2-Ad.mov   |
And waited while preview is available in folder '/F_VMI_S5' on project 'P_VMI_S5' files page
Then I 'should' see Download Original link for version '2' for file 'Fish2-Ad.mov' version history page in folder '/F_VMI_S5' project 'P_VMI_S5'
And I 'should' see Download Proxy link for version '2' for file 'Fish2-Ad.mov' version history page in folder '/F_VMI_S5' project 'P_VMI_S5'


Scenario: Check that if file has more than 1 revision, should appears drop down control to switch between revisions in the top right panel
Meta:@gdam
@projects
Given I created 'P_VMI_S6' project
And created '/F_VMI_S6' folder for project 'P_VMI_S6'
And I uploaded into project 'P_VMI_S6' following files:
| FileName         | Path      |
| /images/logo.bmp | /F_VMI_S6 |
And I uploaded into project 'P_VMI_S6' following revisions:
| FileName               | Path      | MasterFileName |
| /files/atCalcImage.jpg | /F_VMI_S6 | logo.bmp       |
And waited while preview is available in folder '/F_VMI_S6' on project 'P_VMI_S6' files page
When I go to file 'logo.bmp' info page in folder '/F_VMI_S6' project 'P_VMI_S6'
Then I 'should' see next values 'Version 2,Version 1,Upload new version,Upload new version using SendPlus' in Select Version drop down list


Scenario: Check that for any revision should be able to view preview that related to this revision
Meta:@gdam
@projects
Given I created 'P_VMI_S7' project
And created '/F_VMI_S7' folder for project 'P_VMI_S7'
And I uploaded into project 'P_VMI_S7' following files:
| FileName         | Path      |
| /images/logo.bmp | /F_VMI_S7 |
And waited while preview is available in folder '/F_VMI_S7' on project 'P_VMI_S7' files page
And I uploaded into project 'P_VMI_S7' following revisions:
| FileName               | Path      | MasterFileName |
| /files/atCalcImage.jpg | /F_VMI_S7 | logo.bmp       |
And waited while preview is available in folder '/F_VMI_S7' on project 'P_VMI_S7' files page
And I am on file 'logo.bmp' version history page in folder '/F_VMI_S7' project 'P_VMI_S7'
When I select revision 'Version 1' from Version drop down list
Then I should see preview for revision '1' on file 'logo.bmp' version history page in folder '/F_VMI_S7' project 'P_VMI_S7'
When I select revision 'Version 2' from Version drop down list
Then I should see preview for revision '2' on file 'logo.bmp' version history page in folder '/F_VMI_S7' project 'P_VMI_S7'


Scenario: Check that for any revision should be able to view comments that related to this revision
Meta:@gdam
@projects
Given I created 'P_VMI_S8' project
And created '/F_VMI_S8' folder for project 'P_VMI_S8'
And I uploaded into project 'P_VMI_S8' following files:
| FileName               | Path      |
| /files/atCalcImage.jpg | /F_VMI_S8 |
And waited while preview is available in folder '/F_VMI_S8' on project 'P_VMI_S8' files page
And I am on the file comments page project 'P_VMI_S8' and folder '/F_VMI_S8' and file 'atCalcImage.jpg'
And I added comment '<First_revision_comment>' into current file
And I uploaded into project 'P_VMI_S8' following revisions:
| FileName         | Path      | MasterFileName  |
| /images/logo.bmp | /F_VMI_S8 | atCalcImage.jpg |
And waited while preview is available in folder '/F_VMI_S8' on project 'P_VMI_S8' files page
And I am on the file comments page project 'P_VMI_S8' and folder '/F_VMI_S8' and file 'atCalcImage.jpg'
And I added comment '<Second_revision_comment>' into current file
When I select revision 'Version 1' from Version drop down list
Then I should see following comments for current file:
| Name                     |
| <First_revision_comment> |
When I select revision 'Version 2' from Version drop down list
Then I should see following comments for current file:
| Name                      |
| <Second_revision_comment> |

Examples:
| First_revision_comment | Second_revision_comment |
| First revision comment | Second revision comment |


Scenario: Check that for any revision should be able to view approvals that related to this revision
Meta: @skip
      @gdam
Given I created users with following fields:
| Email        | Agency        |
| AppVMI_S10_1 | DefaultAgency |
| AppVMI_S10_2 | DefaultAgency |
And I created 'P_VMI_S10' project
And uploaded '/files/atCalcImage.jpg' file into '/P_VMI_S10' folder for 'P_VMI_S10' project
And waited while transcoding is finished in folder '/P_VMI_S10' on project 'P_VMI_S10' files page
And I started approval for 'atCalcImage.jpg' file in folder '/P_VMI_S10' project 'P_VMI_S10' with '1' stages and the following users:
| Name         | Stage |
| AppVMI_S10_1 | 1     |
And I uploaded into project 'P_VMI_S10' following revisions:
| FileName         | Path       | MasterFileName  |
| /images/logo.bmp | /P_VMI_S10 | atCalcImage.jpg |
And waited while transcoding is finished in folder '/P_VMI_S10' on project 'P_VMI_S10' files page
And I started approval for 'atCalcImage.jpg' file in folder '/P_VMI_S10' project 'P_VMI_S10' with '1' stages and the following users:
| Name         | Stage |
| AppVMI_S10_2 | 1     |
When I select revision 'Version 1' from Version drop down list
Then I 'should' see the following users under relevant stage:
| Name         | Stage |
| AppVMI_S10_1 | 1     |
When I select revision 'Version 2' from Version drop down list
Then I 'should' see the following users under relevant stage:
| Name         | Stage |
| AppVMI_S10_2 | 1     |


Scenario: Check that after click on old version button in version history tab, should be playable old proxy
Meta:@gdam
@projects
Given I created 'P_VMI_S11' project
And created '/F_VMI_S11' folder for project 'P_VMI_S11'
And I uploaded into project 'P_VMI_S11' following files:
| FileName         | Path      |
| /images/logo.bmp | /F_VMI_S11 |
And I uploaded into project 'P_VMI_S11' following revisions:
| FileName               | Path      | MasterFileName |
| /files/atCalcImage.jpg | /F_VMI_S11 | logo.bmp       |
And waited while preview is available in folder '/F_VMI_S11' on project 'P_VMI_S11' files page
And I am on file 'logo.bmp' version history page in folder '/F_VMI_S11' project 'P_VMI_S11'
When I click on revision '1' from version history page
Then I should see preview for revision '1' on file 'logo.bmp' version history page in folder '/F_VMI_S11' project 'P_VMI_S11'


Scenario: Check that after upload new version, should be displayed proper date
Meta:
@skip
@gdam
Given I created 'PRJ_VM_12' project
And created '/F_VM_12' folder for 'PRJ_VM_12' project
And uploaded <First_revision> file into '/F_VM_12' folder
And waited while file would be uploaded At UploadedTimeV1 time
And uploaded new revision <New_revision> file for current file
And waited while file would be uploaded At UploadedTimeV2 time
When I open Activity on 'Overview' tab of 'PRJ_VM_12' project
Then I should see activity 'File <First_revision> uploaded at UploadedtimeV1'
And should see activity 'File <New_revision> uploaded at UploadedtimeV2'


Scenario: Check that after upload new revision, by another agency user, user data is correctly displayed
Meta:@gdam
@projects
Given I created users with following fields:
| Email     | Role       | Agency        |
| Boris_S13 | guest.user | AnotherAgency |
And I created following projects:
| Name      | Advertiser    |
| P_VMI_S13 | DefaultAgency |
And created '/F_VMI_S13' folder for project 'P_VMI_S13'
And I uploaded into project 'P_VMI_S13' following files:
| FileName               | Path       |
| /files/atCalcImage.jpg | /F_VMI_S13 |
And waited while preview is available in folder '/F_VMI_S13' on project 'P_VMI_S13' files page
And fill Share popup by users 'Boris_S13' in project 'P_VMI_S13' folders '/F_VMI_S13' with role 'project.contributor' expired '12.12.2022' and 'should' access to subfolders
And logged in with details of 'Boris_S13'
And I uploaded into project 'P_VMI_S13' following revisions:
| FileName         | Path       | MasterFileName  |
| /images/logo.bmp | /F_VMI_S13 | atCalcImage.jpg |
And waited while preview is available in folder '/F_VMI_S13' on project 'P_VMI_S13' files page
Then I should see the following details on file 'atCalcImage.jpg' version history page in folder '/F_VMI_S13' project 'P_VMI_S13':
| Revision | Name        | Agency        |
| 1        | AgencyAdmin | DefaultAgency |
| 2        | Boris_S13   | AnotherAgency |


Scenario: Check that after upload new revision, by another agency user, proxy is played correctly
Meta:@gdam
@projects
Given I created users with following fields:
| Email     | Role       | Agency        |
| U_VMI_S14 | guest.user | AnotherAgency |
And I created following projects:
| Name      | Advertiser    |
| P_VMI_S14 | DefaultAgency |
And created '/F_VMI_S14' folder for project 'P_VMI_S14'
And uploaded '/files/atCalcImage.jpg' file into '/F_VMI_S14' folder for 'P_VMI_S14' project
And waited while preview is available in folder '/F_VMI_S14' on project 'P_VMI_S14' files page
And fill Share popup by users 'U_VMI_S14' in project 'P_VMI_S14' folders '/F_VMI_S14' with role 'project.contributor' expired '12.12.2022' and 'should' access to subfolders
When I login with details of 'U_VMI_S14'
And upload new file version '/images/logo.bmp' for file 'atCalcImage.jpg' into '/F_VMI_S14' folder for 'P_VMI_S14' project
And wait while preview is visible on project 'P_VMI_S14' in folder '/F_VMI_S14' for 'atCalcImage.jpg' file revision '2'
Then I should see preview for revision '2' on file 'atCalcImage.jpg' version history page in folder '/F_VMI_S14' project 'P_VMI_S14' on opening


Scenario: Check that thumbnail of latest version of file appears on 'Files' tab
Meta:@gdam
@projects
Given I created 'P_VMI_S15' project
And created '/F_VMI_S15' folder for project 'P_VMI_S15'
And I uploaded into project 'P_VMI_S15' following files:
| FileName           | Path       |
| /files/Fish Ad.mov | /F_VMI_S15 |
And waited while preview is available in folder '/F_VMI_S15' on project 'P_VMI_S15' files page
And I uploaded into project 'P_VMI_S15' following revisions:
| FileName               | Path       | MasterFileName |
| /files/atCalcImage.jpg | /F_VMI_S15 | Fish Ad.mov    |
And waited while preview is available in folder '/F_VMI_S15' on project 'P_VMI_S15' files page
Then I should see thumbnail for revision '2' for file 'Fish Ad.mov' inside '/F_VMI_S15' folder for 'P_VMI_S15' project


Scenario: Check that all versions of file appears on 'Overview' tab of project
Meta:@gdam
@projects
Given I created 'P_VMI_S16' project
And created '/F_VMI_S16' folder for project 'P_VMI_S16'
And I uploaded into project 'P_VMI_S16' following files:
| FileName           | Path       |
| /files/Fish Ad.mov | /F_VMI_S16 |
And I uploaded into project 'P_VMI_S16' following revisions:
| FileName            | Path       | MasterFileName |
| /files/Fish2-Ad.mov | /F_VMI_S16 | Fish Ad.mov    |
And waited while preview is available in folder '/F_VMI_S16' on project 'P_VMI_S16' files page
When I go to project 'P_VMI_S16' overview page
Then I should see following files on project 'P_VMI_S16' overview page:
| FileName    | FilesCount |
| Fish Ad.mov | 2          |