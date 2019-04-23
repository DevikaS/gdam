!--NGN-1920
Feature:          Project Share folder from drop down menu - Common
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing folder

Scenario: Check that Share window can be opened from dropdown menu
Meta:@gdam
@projects
Given I created 'P_PSFFDDM_S01' project
And created '/F_PSFFDDM_S01' folder for project 'P_PSFFDDM_S01'
When I open Share window from popup menu for folder '/F_PSFFDDM_S01' on project 'P_PSFFDDM_S01'
Then I should see count '0' next following tab 'Add users' on Share window


Scenario: Check that count next to 'Add users' is increased after adding new user
Meta: @skip
      @gdam
Given I created 'PR6_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email               | Telephone   | Role       |
| UserFN    | UserLN   | agencyPSFC1testuser | 80501554825 | guest.user |
And I created 'PSP6_1' project
And created '/PSF6_1' folder for project 'PSP6_1'
And I am on project 'PSP6_1' folder '/PSF6_1' page
When I open Share window from popup menu for folder '/PSF6_1' on project 'PSP6_1'
Then I should see count '0' next following tab 'Add users' on Share window
When I fill Share popup of project folder by following user 'agencyPSFC1testuser'
And fill Share popup of project folder by following role 'PR6_1'
And click element 'AddMore' on page 'ShareWindow'
Then I should see count '1' next following tab 'Add users' on Share window


Scenario: Check that count next to 'Add users' is decreased after removing user
Meta: @skip
      @gdam
Given I created 'PR7_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email                | Telephone   | Role       |
| UserFN    | UserLN   | agencyPSFC2testuser1 | 80501554825 | guest.user |
And I created 'PSP7_1' project
And created '/PSF7_1' folder for project 'PSP7_1'
And I am on project 'PSP7_1' folder '/PSF7_1' page
When I open Share window from popup menu for folder '/PSF7_1' on project 'PSP7_1'
And I fill Share window of project folder for following users:
| User                 | Role  | ExpiredDate | ShouldAccess |
| agencyPSFC2testuser1 | PR7_1 |             | should not   |
Then I should see count '1' next following tab 'Add users' on Share window
When I remove user 'agencyPSFC2testuser1' from users tab on Share window
Then I should see count '0' next following tab 'Add users' on Share window


Scenario: Check that count next to 'Users already on this folder' is increased after adding new user
Meta: @skip
      @gdam
Given I created 'PR8_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email               | Telephone   | Role       |
| UserFN    | UserLN   | agencyPSFC3testuser | 80501554825 | guest.user |
And I created 'PSP8_1' project
And created '/PSF8_1' folder for project 'PSP8_1'
And I am on project 'PSP8_1' folder '/PSF8_1' page
When I open Share window from popup menu for folder '/PSF8_1' on project 'PSP8_1'
Then I should see count '1' next following tab 'Users already on this folder' on Share window
When I fill Share window of project folder for following users:
| User                | Role  | ExpiredDate | ShouldAccess |
| agencyPSFC3testuser | PR8_1 |             | should not   |
And click element 'Add' on page 'ShareWindow'
And click element 'Share' on page 'FilesPage'
Then I should see count '2' next following tab 'Users already on this folder' on Share window


Scenario: Check that count next to 'Users already on this folder' is decreased after removing user
Meta: @skip
      @gdam
Given I created 'PR9_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email               | Telephone   | Role       |
| UserFN    | UserLN   | agencyPSFC4testuser | 80501554825 | guest.user |
And I created 'PSP9_1' project
And created '/PSF9_1' folder for project 'PSP9_1'
And I am on project 'PSP9_1' folder '/PSF9_1' page
When I open Share window from popup menu for folder '/PSF9_1' on project 'PSP9_1'
And I fill Share window of project folder for following users:
| User                | Role  | ExpiredDate | ShouldAccess |
| agencyPSFC4testuser | PR9_1 |             | should not   |
And click element 'Add' on page 'ShareWindow'
And click element 'Share' on page 'FilesPage'
Then I should see count '2' next following tab 'Users already on this folder' on Share window
When I click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
And I remove user 'agencyPSFC4testuser' from users tab on Share window
Then I should see count '1' next following tab 'Users already on this folder' on Share window


Scenario: Check that changed data is correctly displayed
Meta: @skip
      @gdam
Given I created following roles:
| RoleName | Group   |
| PR10_1   | project |
| PR11_1   | project |
And created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| UserFN1   | UserLN1  | aaaaaaaa2 | 80501554825 | guest.user |
| UserFN2   | UserLN2  | bbbbbbbb2 | 80501554825 | guest.user |
And I created 'PSP10_1' project
And created '/PSF10_1' folder for project 'PSP10_1'
And I am on project 'PSP10_1' folder '/PSF10_1' page
When I open Share window from popup menu for folder '/PSF10_1' on project 'PSP10_1'
And fill Share window of project folder for following users:
| User      | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa2 | PR10_1 |             | should not   |
| bbbbbbbb2 | PR10_1 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And change data on Users already on this folder tab on following:
| User      | Role   | ExpiredDate | ShouldAccess |
| bbbbbbbb2 | PR11_1 | 11.11.2018  | should       |
And go to Users already on this folder tab after 'Save' changes on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin | project.admin |             | should       |
| aaaaaaaa2   | PR10_1        |             | should not   |
| bbbbbbbb2   | PR11_1        | 11.11.2018  | should       |


Scenario: Check that users whom folder has been shared are displayed on 'Users already on this user'
Meta: @skip
      @gdam
Given I created 'PR12_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaaa3 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb3 | 80501554825 | guest.user |
And I created 'PSP11_1' project
And created '/PSF11_1' folder for project 'PSP11_1'
And I am on project 'PSP11_1' folder '/PSF11_1' page
When I open Share window from popup menu for folder '/PSF11_1' on project 'PSP11_1'
And fill Share window of project folder for following users:
| User      | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa3 | PR12_1 |             | should not   |
| bbbbbbbb3 | PR12_1 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin | project.admin |             | should       |
| aaaaaaaa3   | PR12_1        |             | should not   |
| bbbbbbbb3   | PR12_1        |             | should not   |


Scenario: Check that six users are divided into 2 pages on Add users tab of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR13_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa41 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb41 | 80501554825 | guest.user |
| first3    | last3    | cccccccc41 | 80501554825 | guest.user |
| first4    | last4    | dddddddd41 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee41 | 80501554825 | guest.user |
| first6    | last6    | ffffffff41 | 80501554825 | guest.user |
And I created 'PSP12_1' project
And created '/PSF12_1' folder for project 'PSP12_1'
And I am on project 'PSP12_1' folder '/PSF12_1' page
When I open Share window from popup menu for folder '/PSF12_1' on project 'PSP12_1'
And fill Share window of project folder for following users:
| User       | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa41 | PR13_1 |             | should not   |
| bbbbbbbb41 | PR13_1 |             | should not   |
| cccccccc41 | PR13_1 |             | should not   |
| dddddddd41 | PR13_1 |             | should not   |
| eeeeeeee41 | PR13_1 |             | should not   |
| ffffffff41 | PR13_1 |             | should not   |
Then I should see '2' page on 'Add users' tab on Share window
And should see '1' page is selected on users tab on Share window
And I should see on selected 'Add users' tab on Share window the following users in current order :
| Email      | Role   | ExpiredDate | ShouldAccess |
| ffffffff41 | PR13_1 |             | should not   |
| eeeeeeee41 | PR13_1 |             | should not   |
| dddddddd41 | PR13_1 |             | should not   |
| cccccccc41 | PR13_1 |             | should not   |
| bbbbbbbb41 | PR13_1 |             | should not   |


Scenario: Check that changing page by clicking on page number correctly works on Add users tab of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR14_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa51 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb51 | 80501554825 | guest.user |
| first3    | last3    | cccccccc51 | 80501554825 | guest.user |
| first4    | last4    | dddddddd51 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee51 | 80501554825 | guest.user |
| first6    | last6    | ffffffff51 | 80501554825 | guest.user |
And I created 'PSP13_1' project
And created '/PSF13_1' folder for project 'PSP13_1'
And I am on project 'PSP13_1' folder '/PSF13_1' page
When I open Share window from popup menu for folder '/PSF13_1' on project 'PSP13_1'
And fill Share window of project folder for following users:
| User       | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa51 | PR14_1 |             | should not   |
| bbbbbbbb51 | PR14_1 |             | should not   |
| cccccccc51 | PR14_1 |             | should not   |
| dddddddd51 | PR14_1 |             | should not   |
| eeeeeeee51 | PR14_1 |             | should not   |
| ffffffff51 | PR14_1 |             | should not   |
And I go to '2' page on users tab on Share window
Then I should see '2' page is selected on users tab on Share window
And I should see on selected 'Add users' tab on Share window the following users in current order :
| Email      | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa51 | PR14_1 |             | should not   |


Scenario: Check that changing page by clicking Next correctly works on Add users tab of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR15_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa61 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb61 | 80501554825 | guest.user |
| first3    | last3    | cccccccc61 | 80501554825 | guest.user |
| first4    | last4    | dddddddd61 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee61 | 80501554825 | guest.user |
| first6    | last6    | ffffffff61 | 80501554825 | guest.user |
And I created 'PSP14_1' project
And created '/PSF14_1' folder for project 'PSP14_1'
And I am on project 'PSP14_1' folder '/PSF14_1' page
When I open Share window from popup menu for folder '/PSF14_1' on project 'PSP14_1'
And fill Share window of project folder for following users:
| User       | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa61 | PR15_1 |             | should not   |
| bbbbbbbb61 | PR15_1 |             | should not   |
| cccccccc61 | PR15_1 |             | should not   |
| dddddddd61 | PR15_1 |             | should not   |
| eeeeeeee61 | PR15_1 |             | should not   |
| ffffffff61 | PR15_1 |             | should not   |
And I click element 'Next' on page 'ShareWindow'
Then I should see '2' page is selected on users tab on Share window
And I should see on selected 'Add users' tab on Share window the following users in current order :
| Email      | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa61 | PR15_1 |             | should not   |


Scenario: Check that changing page by clicking Previous correctly works on Add users tab of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR16_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa71 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb71 | 80501554825 | guest.user |
| first3    | last3    | cccccccc71 | 80501554825 | guest.user |
| first4    | last4    | dddddddd71 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee71 | 80501554825 | guest.user |
| first6    | last6    | ffffffff71 | 80501554825 | guest.user |
And I created 'PSP15_1' project
And created '/PSF15_1' folder for project 'PSP15_1'
And I am on project 'PSP15_1' folder '/PSF15_1' page
When I open Share window from popup menu for folder '/PSF15_1' on project 'PSP15_1'
And fill Share window of project folder for following users:
| User       | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa71 | PR16_1 |             | should not   |
| bbbbbbbb71 | PR16_1 |             | should not   |
| cccccccc71 | PR16_1 |             | should not   |
| dddddddd71 | PR16_1 |             | should not   |
| eeeeeeee71 | PR16_1 |             | should not   |
| ffffffff71 | PR16_1 |             | should not   |
And click element 'Next' on page 'ShareWindow'
Then I should see '2' page is selected on users tab on Share window
When I click element 'Previous' on page 'ShareWindow'
Then I should see '1' page is selected on users tab on Share window
And I should see on selected 'Add users' tab on Share window the following users in current order :
| Email      | Role   | ExpiredDate | ShouldAccess |
| ffffffff71 | PR16_1 |             | should not   |
| eeeeeeee71 | PR16_1 |             | should not   |
| dddddddd71 | PR16_1 |             | should not   |
| cccccccc71 | PR16_1 |             | should not   |
| bbbbbbbb71 | PR16_1 |             | should not   |


Scenario: Check that six users are divided into 2 pages on Users already on this folder tab of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR17_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa81 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb81 | 80501554825 | guest.user |
| first3    | last3    | cccccccc81 | 80501554825 | guest.user |
| first4    | last4    | dddddddd81 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee81 | 80501554825 | guest.user |
| first6    | last6    | ffffffff81 | 80501554825 | guest.user |
And I created 'PSP16_1' project
And created '/PSF16_1' folder for project 'PSP16_1'
And I am on project 'PSP16_1' folder '/PSF16_1' page
When I open Share window from popup menu for folder '/PSF16_1' on project 'PSP16_1'
And fill Share window of project folder for following users:
| User       | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa81 | PR17_1 |             | should not   |
| bbbbbbbb81 | PR17_1 |             | should not   |
| cccccccc81 | PR17_1 |             | should not   |
| dddddddd81 | PR17_1 |             | should not   |
| eeeeeeee81 | PR17_1 |             | should not   |
| ffffffff81 | PR17_1 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see '2' page on 'Users already on this folder' tab on Share window
And should see '1' page is selected on users tab on Share window
And I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin | project.admin |             | should       |
| aaaaaaaa81  | PR17_1        |             | should not   |
| bbbbbbbb81  | PR17_1        |             | should not   |
| cccccccc81  | PR17_1        |             | should not   |
| dddddddd81  | PR17_1        |             | should not   |


Scenario: Check that changing page by clicking on page number correctly works on Users already on this folder of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR18_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaaa9 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb9 | 80501554825 | guest.user |
| first3    | last3    | cccccccc9 | 80501554825 | guest.user |
| first4    | last4    | dddddddd9 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee9 | 80501554825 | guest.user |
| first6    | last6    | ffffffff9 | 80501554825 | guest.user |
And I created 'PSP17_1' project
And created '/PSF17_1' folder for project 'PSP17_1'
And I am on project 'PSP17_1' folder '/PSF17_1' page
When I open Share window from popup menu for folder '/PSF17_1' on project 'PSP17_1'
And fill Share window of project folder for following users:
| User      | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa9 | PR18_1 |             | should not   |
| bbbbbbbb9 | PR18_1 |             | should not   |
| cccccccc9 | PR18_1 |             | should not   |
| dddddddd9 | PR18_1 |             | should not   |
| eeeeeeee9 | PR18_1 |             | should not   |
| ffffffff9 | PR18_1 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And I go to '2' page on users tab on Share window
Then I should see '2' page is selected on users tab on Share window
And I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email     | Role   | ExpiredDate | ShouldAccess |
| eeeeeeee9 | PR18_1 |             | should not   |
| ffffffff9 | PR18_1 |             | should not   |


Scenario: Check that changing page by clicking Next correctly works on Users already on this folder of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR19_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa10 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb10 | 80501554825 | guest.user |
| first3    | last3    | cccccccc10 | 80501554825 | guest.user |
| first4    | last4    | dddddddd10 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee10 | 80501554825 | guest.user |
| first6    | last6    | ffffffff10 | 80501554825 | guest.user |
And I created 'PSP18_1' project
And created '/PSF18_1' folder for project 'PSP18_1'
And I am on project 'PSP18_1' folder '/PSF18_1' page
When I open Share window from popup menu for folder '/PSF18_1' on project 'PSP18_1'
And fill Share window of project folder for following users:
| User       | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa10 | PR19_1 |             | should not   |
| bbbbbbbb10 | PR19_1 |             | should not   |
| cccccccc10 | PR19_1 |             | should not   |
| dddddddd10 | PR19_1 |             | should not   |
| eeeeeeee10 | PR19_1 |             | should not   |
| ffffffff10 | PR19_1 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And I click element 'Next' on page 'ShareWindow'
Then I should see '2' page is selected on users tab on Share window
And I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email      | Role   | ExpiredDate | ShouldAccess |
| eeeeeeee10 | PR19_1 |             | should not   |
| ffffffff10 | PR19_1 |             | should not   |


Scenario: Check that changing page by clicking Previous correctly works on Users already on this folder of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR20_1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa11 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb11 | 80501554825 | guest.user |
| first3    | last3    | cccccccc11 | 80501554825 | guest.user |
| first4    | last4    | dddddddd11 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee11 | 80501554825 | guest.user |
| first6    | last6    | ffffffff11 | 80501554825 | guest.user |
And I created 'PSP19_1' project
And created '/PSF19_1' folder for project 'PSP19_1'
And I am on project 'PSP19_1' folder '/PSF19_1' page
When I open Share window from popup menu for folder '/PSF19_1' on project 'PSP19_1'
And fill Share window of project folder for following users:
| User       | Role   | ExpiredDate | ShouldAccess |
| aaaaaaaa11 | PR20_1 |             | should not   |
| bbbbbbbb11 | PR20_1 |             | should not   |
| cccccccc11 | PR20_1 |             | should not   |
| dddddddd11 | PR20_1 |             | should not   |
| eeeeeeee11 | PR20_1 |             | should not   |
| ffffffff11 | PR20_1 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And I click element 'Next' on page 'ShareWindow'
Then I should see '2' page is selected on users tab on Share window
When I click element 'Previous' on page 'ShareWindow'
Then I should see '1' page is selected on users tab on Share window
And I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin | project.admin |             | should       |
| aaaaaaaa11  | PR20_1        |             | should not   |
| bbbbbbbb11  | PR20_1        |             | should not   |
| cccccccc11  | PR20_1        |             | should not   |
| dddddddd11  | PR20_1        |             | should not   |