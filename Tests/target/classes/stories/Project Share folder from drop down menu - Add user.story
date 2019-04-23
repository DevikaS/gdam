!--NGN-1920
Feature:          Project Share folder from drop down menu - Add user
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing folder

Scenario: Check that user with 'Access to subfolders' gets permissions to subfolders
Meta: @skip
      @gdam
Given I created 'projectRole1' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email          | Telephone   | Role       |
| UserFN    | UserLN   | agencytestuser | 80501554825 | guest.user |
And created 'PSP11' project
And created '/PSF11/PSFSub1' folder for project 'PSP11'
And I am on project 'PSP11' folder '/PSF11' page
When I open Share window from popup menu for folder '/PSF11' on project 'PSP11'
And fill Share popup of project folder for user 'agencytestuser' with role 'projectRole1' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
Given I logged in with details of 'agencytestuser'
And I am on project 'PSP11' folder '/PSF11' page
Then I should see following folders in 'PSP11' project:
| folder         |
| /PSF11         |
| /PSF11/PSFSub1 |


Scenario: Check that only project roles (w/o project.owner too) are available on Share pop-up
Meta: @skip
      @gdam
Given I created 'PSP22' project
And created '/PSF22' folder for project 'PSP22'
And created following roles:
| RoleName | Group   |
| Test1    | project |
| Test2    | project |
| Test3    | library |
| Test4    | library |
| Test5    | global  |
| Test6    | global  |
And I am on project 'PSP22' folder '/PSF22' page
When I open Share window from popup menu for folder '/PSF22' on project 'PSP22'
And fill Share popup of project folder for user 'EAUDR_2' with role '<Role>' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Title' on page 'ShareWindow'
Then I '<Should>' see red inputs on page

Examples:
| Role  | Should     |
| Test1 | should not |
| Test3 | should     |
| Test5 | should     |


Scenario: Check that user is autocompleted on Share pop-up
Meta: @skip
      @gdam
Given I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| UserFN    | UserLN   | agencytest2user | 80501554825 | guest.user |
And I created 'PSP33' project
And created '/PSF33' folder for project 'PSP33'
And I am on project 'PSP33' folder '/PSF33' page
When I open Share window from popup menu for folder '/PSF33' on project 'PSP33'
And fill Share popup of project folder by following user 'agencytest2user'
Then 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'


Scenario: Check that user can be selected from pop-up on Share pop-up
Meta: @skip
      @gdam
Given I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| UserFN    | UserLN   | agencytest3user | 80501554825 | guest.user |
And I created 'PSP44' project
And created '/PSF44' folder for project 'PSP44'
And I am on project 'PSP44' folder '/PSF44' page
When I open Share window from popup menu for folder '/PSF44' on project 'PSP44'
And fill Share popup of project folder by following user 'agencytest3user'
And select user with name 'agencytest3user' in Share popup of project folder
Then I should see user with first name 'UserFN' last name 'UserLN' and email 'agencytest3user' in Share popup of project folder


Scenario: Check that several users can be added
Meta: @skip
      @gdam
Given I created 'projectRole2' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| User1FN   | User1LN  | agencytest4user | 80501554825 | guest.user |
| User2FN   | User2LN  | agencytest5user | 80501554825 | guest.user |
And I created 'PSP55' project
And created '/PSF55' folder for project 'PSP55'
And I am on project 'PSP55' folder '/PSF55' page
When I open Share window from popup menu for folder '/PSF55' on project 'PSP55'
And fill Share window of project folder for following users:
| User            | Role         | ExpiredDate | ShouldAccess |
| agencytest4user | projectRole2 | 12.12.2020  | should not   |
| agencytest5user | projectRole2 | 12.12.2020  | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email           | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin     | project.admin |             | should       |
| agencytest4user | projectRole2  | 12.12.2020  | should not   |
| agencytest5user | projectRole2  | 12.12.2020  | should not   |


Scenario: Check that easy share users can be added
Meta: @skip
      @gdam
Given I created 'projectRole3' role in 'project' group for advertiser 'DefaultAgency'
And I created 'PSP66' project
And created '/PSF66' folder for project 'PSP66'
And I am on project 'PSP66' folder '/PSF66' page
When I open Share window from popup menu for folder '/PSF66' on project 'PSP66'
And fill Share window of project folder for following users:
| User          | Role         | ExpiredDate | ShouldAccess |
| easysharepsd1 | projectRole3 | 12.12.2020  | should not   |
| easysharepsd2 | projectRole3 | 12.12.2020  | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email         | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin   | project.admin |             | should       |
| easysharepsd1 | projectRole3  | 12.12.2020  | should not   |
| easysharepsd2 | projectRole3  | 12.12.2020  | should not   |


Scenario: Check that 'Add' button isn't active without specifying required data
Meta: @skip
      @gdam
Given I created 'projectRole4' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| UserFN    | UserLN   | agencytest4user | 80501554825 | guest.user |
And created 'PSP77' project
And created '/PSF77' folder for project 'PSP77'
And I am on project 'PSP77' folder '/PSF77' page
When I open Share window from popup menu for folder '/PSF77' on project 'PSP77'
And fill Share popup of project folder for user '<User>' with role '<Role>' expired '12.12.2020' and 'should' check access to subfolders
Then I '<Should>' see red inputs on page
And I should see element 'Add' on page 'ShareWindow' in following state '<State>'

Examples:
| User       | Role         | Should     | State    |
|            | projectRole4 | should     | disabled |
| easyshare3 |              | should     | disabled |
| easyshare3 | projectRole4 | should not | enabled  |


Scenario: Check that passed date isn't accessible in Expiration date field
Meta: @skip
      @gdam
Given I created 'projectRole5' role in 'project' group for advertiser 'DefaultAgency'
And created 'PSP88' project
And created '/PSF88' folder for project 'PSP88'
And I am on project 'PSP88' folder '/PSF88' page
When I open Share window from popup menu for folder '/PSF88' on project 'PSP88'
And fill Share popup of project folder for user 'easyshare3' with role 'projectRole5' expired '01.01.2010' and 'should' check access to subfolders
And click element 'AddUsers' on page 'ShareWindow'
Then I 'should' see red inputs on page


Scenario: Check that for user from another agency folder can be shared
Meta: @skip
      @gdam
Given I created 'projectRole6' role in 'project' group for advertiser 'DefaultAgency'
And created 'PSP99' project
And created '/PSF99' folder for project 'PSP99'
And I am on project 'PSP99' folder '/PSF99' page
When I open Share window from popup menu for folder '/PSF99' on project 'PSP99'
And fill Share popup of project folder for user 'AnotherAgencyAdmin' with role 'projectRole6' expired '12.12.2020' and 'should' check access to subfolders
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email              | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin        | project.admin |             | should       |
| AnotherAgencyAdmin | projectRole6  | 12.12.2020  | should       |


Scenario: Check that user can be added using first name on Share pop-up
Meta: @skip
      @gdam
Given I created 'projectRole7' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName  | LastName   | Email           | Telephone   | Role       | Logo |
| UserFNtest | UserLNtest | agencytest6user | 80501554825 | guest.user | JPEG |
And created 'PSP100' project
And created '/PSF100' folder for project 'PSP100'
And I am on project 'PSP100' folder '/PSF100' page
When I open Share window from popup menu for folder '/PSF100' on project 'PSP100'
And fill Share popup of project folder by following user 'agencytest6user'
Then I should see logo 'JPEG' on '1' position in autocomplete popup on Share window
When select user with name 'agencytest6user' in Share popup of project folder
Then I should see user with first name 'UserFNtest' last name 'UserLNtest' and email 'agencytest6user' in Share popup of project folder


Scenario: Search user in look-up (space cannot be used as separator)
Meta: @skip
      @gdam
Given I created 'projectRole8' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName   | LastName    | Email           | Telephone   | Role       | Logo |
| UserFNtest1 | UserLNtest2 | agencytest7user | 80501554825 | guest.user | JPEG |
And created 'PSP111' project
And created '/PSF111' folder for project 'PSP111'
And I am on project 'PSP111' folder '/PSF111' page
When I open Share window from popup menu for folder '/PSF111' on project 'PSP111'
And type on Share popup of project folder in Users box such first user name 'UserFNtest1' and last user name 'UserLNtest2'
Then 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'
And 'should' see such text 'UserFNtest1 UserLNtest2' in user name on '1' position in autocomplete popup on Share window


Scenario: The same user can be added for one folder many times with different roles
Meta: @skip
      @gdam
Given I created following roles:
| RoleName      | Group   |
| projectRole9  | project |
| projectRole10 | project |
And created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role       |
| UserFN    | UserLN   | agencytest8user | 80501554825 | guest.user |
And created 'PSP122' project
And created '/PSF122' folder for project 'PSP122'
And I am on project 'PSP122' folder '/PSF122' page
When I open Share window from popup menu for folder '/PSF122' on project 'PSP122'
And fill Share window of project folder for following users:
| User            | Role          | ExpiredDate | ShouldAccess |
| agencytest8user | projectRole9  |             | should not   |
| agencytest8user | projectRole10 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following the same users with different roles in current order :
| Email           | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin     | project.admin |             | should       |
| agencytest8user | projectRole10 |             | should not   |
| agencytest8user | projectRole9  |             | should not   |


Scenario: Check that only email of easy share is displayed in pop-up in case to Share folder
Meta: @skip
      @gdam
Given I created 'projectRole11' role in 'project' group for advertiser 'DefaultAgency'
And added user 'easyshare4' into address book
And created 'PSP133' project
And created '/PSF133' folder for project 'PSP133'
And I am on project 'PSP133' folder '/PSF133' page
When I open Share window from popup menu for folder '/PSF133' on project 'PSP133'
And fill Share popup of project folder by following user 'easyshare4'
Then I 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'
And should see user with email 'easyshare4' on '1' position in autocomplete popup on Share window
And 'should not' see such text 'undefined undefined' in user name on '1' position in autocomplete popup on Share window