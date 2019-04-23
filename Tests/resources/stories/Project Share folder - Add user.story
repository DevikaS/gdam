!-- NGN-278 NGN-1239 NGN-1306 NGN-1249 NGN-1429 NGN-1361 NGN-2026
Feature:          Project Share folder - Add user
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing folder

Scenario: Check that user with 'Access to subfolders' gets permissions to subfolders
Meta:@gdam
@projects
Given I created 'PSFR1' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role        |
| UserFN    | UserLN   | agencytestuser  | 80501554825 | guest.user  |
And created 'PSP101' project
And created '/PSF101/PSFSub1' folder for project 'PSP101'
And I am on project 'PSP101' folder '/PSF101' page
When go to project 'PSP101' folder 'root' page
And select folder '/PSF101' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'agencytestuser' with role 'PSFR1' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Given I logged in with details of 'agencytestuser'
And I am on project 'PSP101' folder '/PSF101' page
Then I should see following folders in 'PSP101' project:
| folder          |
| /PSF101         |
| /PSF101/PSFSub1 |


Scenario: Check that only project roles (w/o project.owner too) are available on Share pop-up
Meta:@gdam
@projects
Given I created 'PSP201' project
And created '/PSF201' folder for project 'PSP201'
And created following roles:
| RoleName | Group   |
| Test1    | project |
| Test2    | project |
| Test3    | library |
| Test4    | library |
| Test5    | global  |
| Test6    | global  |
And I am on project 'PSP201' folder '/PSF201' page
When go to project 'PSP201' folder 'root' page
And select folder '/PSF201' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'EAUR_2' with role '<Role>' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Title' on page 'ShareWindow'
Then I '<Should>' see red inputs on page

Examples:
| Role  | Should     |
| Test1 | should not |
| Test3 | should     |
| Test5 | should     |


Scenario: Check that user is autocompleted on Share pop-up
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| UserFN    | UserLN   | agencytest2user | 80501554825 | guest.user |
And I created 'PSP301' project
And created '/PSF301' folder for project 'PSP301'
And I am on project 'PSP301' folder '/PSF301' page
When go to project 'PSP301' folder 'root' page
And select folder '/PSF301' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder by following user 'agencytest2user'
Then 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'


Scenario: Check that user can be selected from pop-up on Share pop-up
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| UserFN    | UserLN   | agencytest3user | 80501554825 | guest.user |
And I created 'PSP401' project
And created '/PSF401' folder for project 'PSP401'
And I am on project 'PSP401' folder '/PSF401' page
When go to project 'PSP401' folder 'root' page
And select folder '/PSF401' on project files page
And open Share window using 'Share' button for current on opened files page
When I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder by following user 'agencytest3user'
Then I 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'
When select user with name 'agencytest3user' in Share popup of project folder
Then I should see user with first name 'UserFN' last name 'UserLN' and email 'agencytest3user' in Share popup of project folder


Scenario: Check that several users can be added
Meta:@gdam
@projects
Given I created 'PSFR2' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| User1FN   | User1LN  | agencytest4user | 80501554825 | guest.user |
| User2FN   | User2LN  | agencytest5user | 80501554825 | guest.user |
And I created 'PSP501' project
And created '/PSF501' folder for project 'PSP501'
When I open share popup in project 'PSP501' for folder '/PSF501' from root project
And fill Share window of project folder for following users:
| User            | Role  | ExpiredDate | ShouldAccess |
| agencytest4user | PSFR2 | 12.12.2020  | should not   |
| agencytest5user | PSFR2 | 12.12.2020  | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email           | Role  | ExpiredDate | ShouldAccess |
| AgencyAdmin     |       |             | should       |
| agencytest4user | PSFR2 | 12.12.2020  | should not   |
| agencytest5user | PSFR2 | 12.12.2020  | should not   |


Scenario: Check that easy share users can be added
Meta:@gdam
@projects
Given I created 'PSFR3' role in 'project' group for advertiser 'DefaultAgency'
And I created 'PSP601' project
And created '/PSF601' folder for project 'PSP601'
When I open share popup in project 'PSP601' for folder '/PSF601' from root project
And fill Share window of project folder for following users:
| User         | Role  | ExpiredDate | ShouldAccess |
| easyshareps1 | PSFR3 | 12.12.2020  | should not   |
| easyshareps2 | PSFR3 | 12.12.2020  | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email        | Role  | ExpiredDate | ShouldAccess |
| AgencyAdmin  |       |             | should       |
| easyshareps1 | PSFR3 | 12.12.2020  | should not   |
| easyshareps2 | PSFR3 | 12.12.2020  | should not   |


Scenario: Check that 'Add' button isn't active without specifying required data
Meta:@gdam
@projects
Given I created 'PSFR4' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| UserFN    | UserLN   | agencytest4user | 80501554825 | guest.user |
And created 'PSP701' project
And created '/PSF701' folder for project 'PSP701'
And I am on project 'PSP701' folder '/PSF701' page
When go to project 'PSP701' folder 'root' page
And select folder '/PSF701' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user '<User>' with role '<Role>' expired '12.12.2020' and 'should' check access to subfolders
Then I '<Should>' see red inputs on page
And I should see element 'Add' on page 'ShareWindow' in following state '<State>'

Examples:
| User       | Role  | Should     | State    |
|            | PSFR4 | should     | disabled |
| easyshare3 |       | should     | disabled |
| easyshare3 | PSFR4 | should not | enabled  |


Scenario: Check that passed date isn't accessible in Expiration date field
Meta:@gdam
@projects
Given I created 'PSFR5' role in 'project' group for advertiser 'DefaultAgency'
And created 'PSP801' project
And created '/PSF801' folder for project 'PSP801'
And I am on project 'PSP801' folder '/PSF801' page
When go to project 'PSP801' folder 'root' page
And select folder '/PSF801' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder for user 'easyshare3' with role 'PSFR5' expired '01.01.2010' and 'should' check access to subfolders
And click element 'AddUsers' on page 'ShareWindow'
Then I 'should' see red inputs on page


Scenario: Check that for user from another agency folder can be shared
Meta:@gdam
@projects
Given I created 'PSFR6' role in 'project' group for advertiser 'DefaultAgency'
And created 'PSP901' project
And created '/PSF901' folder for project 'PSP901'
When I open share popup in project 'PSP901' for folder '/PSF901' from root project
And fill Share popup of project folder for user 'AnotherAgencyAdmin' with role 'PSFR6' expired '12.12.2020' and 'should' check access to subfolders
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email              | Role  | ExpiredDate | ShouldAccess |
| AgencyAdmin        |       |             | should       |
| AnotherAgencyAdmin | PSFR6 | 12.12.2020  | should       |


Scenario: Check that user can be added using first name on Share pop-up
Meta:@gdam
@projects
Given I created 'PSFR7' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName  | LastName   | Email           | Telephone   | Role        | Logo |
| UserFNtest | UserLNtest | agencytest6user | 80501554825 | guest.user  | JPEG |
And created 'PSP1001' project
And created '/PSF1001' folder for project 'PSP1001'
And I am on project 'PSP1001' folder '/PSF1001' page
When go to project 'PSP1001' folder 'root' page
And select folder '/PSF1001' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder by following user 'agencytest6user'
Then 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'
And should see logo 'JPEG' on '1' position in autocomplete popup on Share window
When select user with name 'agencytest6user' in Share popup of project folder
Then I should see user with first name 'UserFNtest' last name 'UserLNtest' and email 'agencytest6user' in Share popup of project folder


Scenario: Search user in look-up (space cannot be used as separator)
Meta:@gdam
@projects
Given I created 'PSFR8' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName   | LastName    | Email           | Telephone   | Role        | Logo |
| UserFNtest1 | UserLNtest2 | agencytest7user | 80501554825 | guest.user  | JPEG |
And created 'PSP1101' project
And created '/PSF1101' folder for project 'PSP1101'
And I am on project 'PSP1101' folder '/PSF1101' page
When go to project 'PSP1101' folder 'root' page
And select folder '/PSF1101' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And type on Share popup of project folder in Users box such first user name 'UserFNtest1' and last user name 'UserLNtest2'
Then 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'
And 'should' see such text 'UserFNtest1 UserLNtest2' in user name on '1' position in autocomplete popup on Share window


Scenario: The same user can be added for one folder many times with different roles
Meta:@gdam
@projects
Given I created following roles:
| RoleName      | Group   |
| projectRole9  | project |
| projectRole10 | project |
And created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| UserFN    | UserLN   | agencytest8user | 80501554825 | guest.user |
And created 'PSP1201' project
And created '/PSF1201' folder for project 'PSP1201'
When I open share popup in project 'PSP1201' for folder '/PSF1201' from root project
And fill Share window of project folder for following users:
| User            | Role          | ExpiredDate | ShouldAccess |
| agencytest8user | projectRole9  |             | should not   |
| agencytest8user | projectRole10 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following the same users with different roles :
| Email           | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin     |               |             | should       |
| agencytest8user | projectRole10 |             | should not   |
| agencytest8user | projectRole9  |             | should not   |


Scenario: Check that only email of easy share is displayed in pop-up in case to Share folder
Meta:@gdam
@projects
Given I created 'PSFR11' role in 'project' group for advertiser 'DefaultAgency'
And added user 'easyshare4' into address book
And created 'PSP1301' project
And created '/PSF1301' folder for project 'PSP1301'
And I am on project 'PSP1301' folder '/PSF1301' page
When go to project 'PSP1301' folder 'root' page
And select folder '/PSF1301' on project files page
And open Share window using 'Share' button for current on opened files page
And I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder by following user 'easyshare4'
Then I 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'
And should see user with email 'easyshare4' on '1' position in autocomplete popup on Share window
And 'should not' see such text 'undefined undefined' in user name on '1' position in autocomplete popup on Share window


Scenario: Check that share pop-up appears when you select share from folder drop-down menu
Meta:@gdam
@projects
Given I created 'PSFAU1' project
And created '/PSFAUF1' folder for project 'PSFAU1'
And I am on project 'PSFAU1' folder '/PSFAUF1' page
When I open Share window from popup menu for folder '/PSFAUF1' on project 'PSFAU1'
Then 'should' see element 'ShareWindow' on page 'FilesPage'


Scenario: Check that share pop-up should not appear when you select share from folder drop-down menu in Templates
Meta:@gdam
@projects
Given I created 'PSFAU2' template
And created '/PSFAUF2' folder for template 'PSFAU2'
And I am on template 'PSFAU2' folder '/PSFAUF2' page
When I open pop up menu of folder 'PSFAUF2' in template 'PSFAU2'
Then I 'should not' see in pop up menu for folder '/PSFAUF2' in template 'PSFAU2' following items :
| item  |
| Share |