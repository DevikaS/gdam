!--NGN-1808
Feature:          File Activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check activity for file


Scenario: Check that file activity display correct timestamp and user/file names
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName       | LastName    | Email  | Role         |
| !@#\$ő %^_+;,.1 | -\ÄöéÜæ œ/1 | FA_U_2 | agency.admin |
And logged in with details of 'FA_U_2'
And created 'FAP1' project
And created '/FAF1' folder for project 'FAP1'
And uploaded '/files/Fish Ad.mov' file into '/FAF1' folder for 'FAP1' project
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/FAF1' of project 'FAP1'
When I go to file '/files/Fish Ad.mov' info page in folder '/FAF1' project 'FAP1'
And go to project 'FAP1' overview page
Then I 'should' see on Activity tab for file '/files/Fish Ad.mov' in folder '/FAF1' project 'FAP1' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage  |
| FA_U_2 | EMPTY | created      | created file     |


Scenario: Check that file activity of share user from current agency is displayed correctly
Meta:@gdam
@projects
Given I created 'FAR1' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email |
| Test1     | Test2    | user8 |
And added following users to address book:
| UserName |
| user8    |
And I created 'FAP2' project
And created '/FAF2' folder for project 'FAP2'
And I am on project 'FAP2' teams page
When I add user 'user8' into project 'FAP2' team with role 'FAR1' expired '12.12.2021' for folder on popup '/FAF2'
And login with details of 'user8'
And upload '/files/GWGTestfile064v3.pdf' file into '/FAF2' folder for 'FAP2' project
And I am login as 'AgencyAdmin'
And go to file '/files/GWGTestfile064v3.pdf' info page in folder '/FAF2' project 'FAP2'
Then I 'should' see on Activity tab for file '/files/GWGTestfile064v3.pdf' in folder '/FAF2' project 'FAP2' following recent user's activity :
| User  | Logo  | ActivityType | ActivityMessage |
| user8 | EMPTY | created      | created file    |


Scenario: Check that file activity of share user from another agency is displayed correctly
Meta:@gdam
@projects
Given I created 'FAR2' role with 'folder.read,element.read,project.read,folder.create,element.create' permissions in 'project' group for advertiser 'DefaultAgency'
And added user 'AnotherAgencyAdmin' into address book
And I created 'FAP3' project
And created '/FAF3' folder for project 'FAP3'
And I am on project 'FAP3' teams page
When I add user 'AnotherAgencyAdmin' into project 'FAP3' team with role 'FAR2' expired '12.12.2021' for folder on popup '/FAF3'
And I login as 'AnotherAgencyAdmin'
And upload '/files/!@#$%^&()_+;,.Document.txt' file into '/FAF3' folder for 'FAP3' project
And wait while transcoding is finished in folder '/FAF3' on project 'FAP3' files page
And I am login as 'AgencyAdmin'
And go to file '/files/!@#$%^&()_+;,.Document.txt' info page in folder '/FAF3' project 'FAP3'
Then I 'should' see on Activity tab for file '/files/!@#$%^&()_+;,.Document.txt' in folder '/FAF3' project 'FAP3' following recent user's activity :
| User               | Logo  | ActivityType  | ActivityMessage |
| AnotherAgencyAdmin | EMPTY | file_uploaded | uploaded file   |


Scenario: Check that click on username should redirect to team page
!-- NGN-1285
!--As per QA-678 modified scenario slightly
Meta:@gdam
@projects
Given I created 'FAR3' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email |
| Test1     | Test2    | user9 |
And I created 'FAP4' project
And created '/FAF4' folder for project 'FAP4'
And I am on project 'FAP4' teams page
When I add user 'user9' into project 'FAP4' team with role 'FAR3' expired '12.12.2021' for folder on popup '/FAF4'
And login with details of 'user9'
And upload '/files/for_babylon43.7z' file into '/FAF4' folder for 'FAP4' project
And go to project 'FAP4' folder '/FAF4' page
And I am login as 'AgencyAdmin'
And go to project 'FAP4' folder '/FAF4' page
And go to file '/files/for_babylon43.7z' info page in folder '/FAF4' project 'FAP4'
And click on user name 'user9' in Activity tab on open uploaded file '/files/for_babylon43.7z' in folder '/FAF4' project 'FAP4'
Then I should see project team page 'team'


Scenario: Check that file activity display correct timestamp and user/file names (for teamplate)
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName       | LastName    | Email  | Role         |
| !@#\$ő %^_+;,.1 | -\ÄöéÜæ œ/1 | FA_U_1 | agency.admin |
And I logged in with details of 'FA_U_1'
And I created 'FAP5' template
And created '/FAF5' folder for template 'FAP5'
And uploaded '/files/Fish Ad.mov' file into '/FAF5' folder for 'FAP5' template
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/FAF5' of template 'FAP5'
When I go to template 'FAP5' folder '/FAF5' page
And I go to file '/files/Fish Ad.mov' info page in folder '/FAF5' template 'FAP5'
Then I 'should' see on Activity tab for file '/files/Fish Ad.mov' in folder '/FAF5' template 'FAP5' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage |
| FA_U_1 | EMPTY | created      | created file    |