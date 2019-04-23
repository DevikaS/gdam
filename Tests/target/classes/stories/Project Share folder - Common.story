!--NGN-278
Feature:          Project Share folder - Common
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing folder

Scenario: Check that count next to 'Add users' is increased after adding new user
Meta:@gdam
@projects
Given I created 'PR6' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email               | Telephone   | Role       |
| UserFN    | UserLN   | agencyPSFC1testuser | 80501554825 | guest.user |
And I created 'PSP6' project
And created '/PSF6' folder for project 'PSP6'
When go to project 'PSP6' folder 'root' page
And select folder '/PSF6' on project files page
And open Share window using 'Share' button for current on opened files page
Then I should see count '0' next following tab 'Add users' on Share window
When I fill Share popup of project folder by following user 'agencyPSFC1testuser'
And fill Share popup of project folder by following role 'PR6'
And click element 'AddMore' on page 'ShareWindow'
Then I should see count '1' next following tab 'Add users' on Share window


Scenario: Check that count next to 'Add users' is decreased after removing user
Meta:@gdam
@projects
Given I created 'PR7' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email               | Telephone   | Role        |
| UserFN    | UserLN   | agencyPSFC2testuser | 80501554825 | guest.user  |
And I created 'PSP7' project
And created '/PSF7' folder for project 'PSP7'
And opened share popup in project 'PSP7' for folder '/PSF7' from root project
When I fill Share window of project folder for following users:
| User                | Role | ExpiredDate | ShouldAccess |
| agencyPSFC2testuser | PR7  |             | should not   |
Then I should see count '1' next following tab 'Add users' on Share window
When I remove user 'agencyPSFC2testuser' from users tab on Share window
Then I should see count '0' next following tab 'Add users' on Share window


Scenario: Check that count next to 'Users already on this folder' is increased after adding new user
Meta:@gdam
@projects
Given I created 'PR8' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email               | Telephone   | Role        |
| UserFN    | UserLN   | agencyPSFC3testuser | 80501554825 | guest.user  |
And I created 'PSP8' project
And created '/PSF8' folder for project 'PSP8'
When go to project 'PSP8' folder 'root' page
And select folder '/PSF8' on project files page
And open Share window using 'Share' button for current on opened files page
Then I should see count '1' next following tab 'Users already on this folder' on Share window
When I fill Share window of project folder for following users:
| User                | Role | ExpiredDate | ShouldAccess |
| agencyPSFC3testuser | PR8  |             | should not   |
And click element 'Add' on page 'ShareWindow'
And click element 'Share' on page 'FilesPage'
Then I should see count '2' next following tab 'Users already on this folder' on Share window


Scenario: Check that count next to 'Users already on this folder' is decreased after removing user
Meta:@gdam
@projects
Given I created 'PR9' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email               | Telephone   | Role       |
| UserFN    | UserLN   | agencyPSFC4testuser | 80501554825 | guest.user |
And I created 'PSP9' project
And created '/PSF9' folder for project 'PSP9'
When go to project 'PSP9' folder 'root' page
And select folder '/PSF9' on project files page
And open Share window using 'Share' button for current on opened files page
And I fill Share window of project folder for following users:
| User                | Role | ExpiredDate | ShouldAccess |
| agencyPSFC4testuser | PR9  |             | should not   |
And click element 'Add' on page 'ShareWindow'
And click element 'Share' on page 'FilesPage'
Then I should see count '2' next following tab 'Users already on this folder' on Share window
When I click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
And I remove user 'agencyPSFC4testuser' from users tab on Share window
And I click 'OK' on the alert
And wait for '1' seconds
Then I should see count '1' next following tab 'Users already on this folder' on Share window



Scenario: Check that changed data is correctly displayed
!--FAB-436
Meta:@gdam
     @bug
     @projects
Given I created following roles:
| RoleName | Group   |
| PR10     | project |
| PR11     | project |
And created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| UserFN1   | UserLN1  | aaaaaaaa2 | 80501554825 | guest.user |
| UserFN2   | UserLN2  | bbbbbbbb2 | 80501554825 | guest.user |
And I created 'PSP10' project
And created '/PSF10' folder for project 'PSP10'
When I open share popup in project 'PSP10' for folder 'PSF10' from root project
And fill Share window of project folder for following users:
| User      | Role | ExpiredDate | ShouldAccess |
| aaaaaaaa2 | PR10 |             | should not   |
| bbbbbbbb2 | PR10 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And change data on Users already on this folder tab on following:
| User      | Role | ExpiredDate | ShouldAccess |
| bbbbbbbb2 | PR11 | 11.11.2018  | should       |
And go to Users already on this folder tab after 'Save' changes on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role  | ExpiredDate | ShouldAccess |
| AgencyAdmin |       |             | should       |
| aaaaaaaa2   | PR10  |             | should not   |
| bbbbbbbb2   | PR11  | 11.11.2018  | should       |


Scenario: Check that users whom folder has been shared are displayed on 'Users already on this user'
Meta:@gdam
@projects
Given I created 'PR12' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaaa3 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb3 | 80501554825 | guest.user |
And I created 'PSP11' project
And created '/PSF11' folder for project 'PSP11'
When go to project 'PSP11' folder 'root' page
And select folder '/PSF11' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share window of project folder for following users:
| User      | Role | ExpiredDate | ShouldAccess |
| aaaaaaaa3 | PR12 |             | should not   |
| bbbbbbbb3 | PR12 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role | ExpiredDate | ShouldAccess |
| AgencyAdmin |      |             | should       |
| aaaaaaaa3   | PR12 |             | should not   |
| bbbbbbbb3   | PR12 |             | should not   |


Scenario: Check that six users are divided into 2 pages on Add users tab of Share pop-up
Meta:@gdam
@projects
Given I created 'PR13' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaab4 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb4 | 80501554825 | guest.user |
| first3    | last3    | cccccccc4 | 80501554825 | guest.user |
| first4    | last4    | dddddddd4 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee4 | 80501554825 | guest.user |
| first6    | last6    | ffffffff4 | 80501554825 | guest.user |
| first7    | last7    | gggggggg4 | 80501554825 | guest.user |
| first8    | last8    | hhhhhhhh4 | 80501554825 | guest.user |
| first9    | last9    | iiiiiiii4 | 80501554825 | guest.user |
| first91   | last91   | jjjjjjjj4 | 80501554825 | guest.user |
| first92   | last92   | kkkkkkkk4 | 80501554825 | guest.user |
And I created 'PSP12' project
And created '/PSF12' folder for project 'PSP12'
When go to project 'PSP12' folder 'root' page
And select folder '/PSF12' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share window of project folder for following users:
| User      | Role | ExpiredDate | ShouldAccess |
| aaaaaaab4 | PR13 |             | should not   |
| bbbbbbbb4 | PR13 |             | should not   |
| cccccccc4 | PR13 |             | should not   |
| dddddddd4 | PR13 |             | should not   |
| eeeeeeee4 | PR13 |             | should not   |
| ffffffff4 | PR13 |             | should not   |
| gggggggg4 | PR13 |             | should not   |
| hhhhhhhh4 | PR13 |             | should not   |
| iiiiiiii4 | PR13 |             | should not   |
| jjjjjjjj4 | PR13 |             | should not   |
| kkkkkkkk4 | PR13 |             | should not   |
Then I should see '2' page on 'Add users' tab on Share window
And should see '1' page is selected on users tab on Share window
And I should see on selected 'Add users' tab on Share window the following users in current order :
| Email     | Role | ExpiredDate | ShouldAccess |
| kkkkkkkk4 | PR13 |             | should not   |
| jjjjjjjj4 | PR13 |             | should not   |
| iiiiiiii4 | PR13 |             | should not   |
| hhhhhhhh4 | PR13 |             | should not   |
| gggggggg4 | PR13 |             | should not   |
| ffffffff4 | PR13 |             | should not   |
| eeeeeeee4 | PR13 |             | should not   |
| dddddddd4 | PR13 |             | should not   |
| cccccccc4 | PR13 |             | should not   |
| bbbbbbbb4 | PR13 |             | should not   |



Scenario: Check that changing page by clicking on page number correctly works on Add users tab of Share pop-up
Meta:@gdam
@projects
Given I created 'PR14' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaab5 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb5 | 80501554825 | guest.user |
| first3    | last3    | cccccccc5 | 80501554825 | guest.user |
| first4    | last4    | dddddddd5 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee5 | 80501554825 | guest.user |
| first6    | last6    | ffffffff5 | 80501554825 | guest.user |
| first7    | last7    | gggggggg5 | 80501554825 | guest.user |
| first8    | last8    | hhhhhhhh5 | 80501554825 | guest.user |
| first9    | last9    | iiiiiiii5 | 80501554825 | guest.user |
| first91   | last91   | jjjjjjjj5 | 80501554825 | guest.user |
| first92   | last92   | kkkkkkkk5 | 80501554825 | guest.user |
And I created 'PSP13' project
And created '/PSF13' folder for project 'PSP13'
When I open share popup in project 'PSP13' for folder '/PSF13' from root project
And fill Share window of project folder for following users:
| User      | Role | ExpiredDate | ShouldAccess |
| aaaaaaab5 | PR14 |             | should not   |
| bbbbbbbb5 | PR14 |             | should not   |
| cccccccc5 | PR14 |             | should not   |
| dddddddd5 | PR14 |             | should not   |
| eeeeeeee5 | PR14 |             | should not   |
| ffffffff5 | PR14 |             | should not   |
| gggggggg5 | PR14 |             | should not   |
| hhhhhhhh5 | PR14 |             | should not   |
| iiiiiiii5 | PR14 |             | should not   |
| jjjjjjjj5 | PR14 |             | should not   |
| kkkkkkkk5 | PR14 |             | should not   |
And I go to '2' page on users tab on Share window
Then I should see '2' page is selected on users tab on Share window
And I should see on selected 'Add users' tab on Share window the following users in current order :
| Email     | Role | ExpiredDate | ShouldAccess |
| aaaaaaab5 | PR14 |             | should not   |



Scenario: Check that changing page by clicking Next correctly works on Add users tab of Share pop-up
Meta:@gdam
@projects
Given I created 'PR15' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaaa6 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb6 | 80501554825 | guest.user |
| first3    | last3    | cccccccc6 | 80501554825 | guest.user |
| first4    | last4    | dddddddd6 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee6 | 80501554825 | guest.user |
| first6    | last6    | ffffffff6 | 80501554825 | guest.user |
| first7    | last7    | gggggggg6 | 80501554825 | guest.user |
| first8    | last8    | hhhhhhhh6 | 80501554825 | guest.user |
| first9    | last9    | iiiiiiii6 | 80501554825 | guest.user |
| first91   | last91   | jjjjjjjj6 | 80501554825 | guest.user |
| first92   | last92   | kkkkkkkk6 | 80501554825 | guest.user |
And I created 'PSP14' project
And created '/PSF14' folder for project 'PSP14'
When I open share popup in project 'PSP14' for folder 'PSF14' from root project
And fill Share window of project folder for following users:
| User      | Role | ExpiredDate | ShouldAccess |
| aaaaaaaa6 | PR15 |             | should not   |
| bbbbbbbb6 | PR15 |             | should not   |
| cccccccc6 | PR15 |             | should not   |
| dddddddd6 | PR15 |             | should not   |
| eeeeeeee6 | PR15 |             | should not   |
| ffffffff6 | PR15 |             | should not   |
| gggggggg6 | PR15 |             | should not   |
| hhhhhhhh6 | PR15 |             | should not   |
| iiiiiiii6 | PR15 |             | should not   |
| jjjjjjjj6 | PR15 |             | should not   |
| kkkkkkkk6 | PR15 |             | should not   |
And I click element 'Next' on page 'ShareWindow'
Then I should see '2' page is selected on users tab on Share window
And I should see on selected 'Add users' tab on Share window the following users in current order :
| Email     | Role | ExpiredDate | ShouldAccess |
| aaaaaaaa6 | PR15 |             | should not   |

Scenario: Check that changing page by clicking Previous correctly works on Add users tab of Share pop-up
Meta:@gdam
@projects
Given I created 'PR16' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaaa7 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb7 | 80501554825 | guest.user |
| first3    | last3    | cccccccc7 | 80501554825 | guest.user |
| first4    | last4    | dddddddd7 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee7 | 80501554825 | guest.user |
| first6    | last6    | ffffffff7 | 80501554825 | guest.user |
| first7    | last7    | gggggggg7 | 80501554825 | guest.user |
| first8    | last8    | hhhhhhhh7 | 80501554825 | guest.user |
| first9    | last9    | iiiiiiii7 | 80501554825 | guest.user |
| first91   | last91   | jjjjjjjj7 | 80501554825 | guest.user |
| first92   | last92   | kkkkkkkk7 | 80501554825 | guest.user |
And I created 'PSP15' project
And created '/PSF15' folder for project 'PSP15'
When I open share popup in project 'PSP15' for folder '/PSF15' from root project
And fill Share window of project folder for following users:
| User      | Role | ExpiredDate | ShouldAccess |
| aaaaaaaa7 | PR16 |             | should not   |
| bbbbbbbb7 | PR16 |             | should not   |
| cccccccc7 | PR16 |             | should not   |
| dddddddd7 | PR16 |             | should not   |
| eeeeeeee7 | PR16 |             | should not   |
| ffffffff7 | PR16 |             | should not   |
| gggggggg7 | PR16 |             | should not   |
| hhhhhhhh7 | PR16 |             | should not   |
| iiiiiiii7 | PR16 |             | should not   |
| jjjjjjjj7 | PR16 |             | should not   |
| kkkkkkkk7 | PR16 |             | should not   |
And click element 'Next' on page 'ShareWindow'
Then I should see '2' page is selected on users tab on Share window
When I click element 'Previous' on page 'ShareWindow'
Then I should see '1' page is selected on users tab on Share window
And I should see on selected 'Add users' tab on Share window the following users in current order :
| Email     | Role | ExpiredDate | ShouldAccess |
| kkkkkkkk7 | PR16 |             | should not   |
| jjjjjjjj7 | PR16 |             | should not   |
| iiiiiiii7 | PR16 |             | should not   |
| hhhhhhhh7 | PR16 |             | should not   |
| gggggggg7 | PR16 |             | should not   |
| ffffffff7 | PR16 |             | should not   |
| eeeeeeee7 | PR16 |             | should not   |
| dddddddd7 | PR16 |             | should not   |
| cccccccc7 | PR16 |             | should not   |
| bbbbbbbb7 | PR16 |             | should not   |


Scenario: Check that six users are divided into 2 pages on Users already on this folder tab of Share pop-up
Meta:@gdam
@projects
Given I created 'PR17' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaab8 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb8 | 80501554825 | guest.user |
| first3    | last3    | cccccccc8 | 80501554825 | guest.user |
| first4    | last4    | dddddddd8 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee8 | 80501554825 | guest.user |
| first6    | last6    | ffffffff8 | 80501554825 | guest.user |
| first7    | last7    | gggggggg8 | 80501554825 | guest.user |
| first8    | last8    | hhhhhhhh8 | 80501554825 | guest.user |
| first9    | last9    | iiiiiiii8 | 80501554825 | guest.user |
| first1K   | last1K   | jjjjjjjj8 | 80501554825 | guest.user |
| first1A   | last1A   | kkkkkkkk8 | 80501554825 | guest.user |
And I created 'PSP16' project
And created '/PSF16' folder for project 'PSP16'
When go to project 'PSP16' folder 'root' page
And select folder '/PSF16' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share window of project folder for following users:
| User      | Role | ExpiredDate | ShouldAccess |
| aaaaaaab8 | PR17 |             | should not   |
| bbbbbbbb8 | PR17 |             | should not   |
| cccccccc8 | PR17 |             | should not   |
| dddddddd8 | PR17 |             | should not   |
| eeeeeeee8 | PR17 |             | should not   |
| ffffffff8 | PR17 |             | should not   |
| gggggggg8 | PR17 |             | should not   |
| hhhhhhhh8 | PR17 |             | should not   |
| iiiiiiii8 | PR17 |             | should not   |
| jjjjjjjj8 | PR17 |             | should not   |
| kkkkkkkk8 | PR17 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see '2' page on 'Users already on this folder' tab on Share window
And should see '1' page is selected on users tab on Share window
And I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role  | ExpiredDate | ShouldAccess |
| AgencyAdmin |       |             | should       |
| aaaaaaab8   | PR17  |             | should not   |
| kkkkkkkk8   | PR17  |             | should not   |
| jjjjjjjj8   | PR17  |             | should not   |
| bbbbbbbb8   | PR17  |             | should not   |
| cccccccc8   | PR17  |             | should not   |
| dddddddd8   | PR17  |             | should not   |
| eeeeeeee8   | PR17  |             | should not   |
| ffffffff8   | PR17  |             | should not   |
| gggggggg8   | PR17  |             | should not   |



Scenario: Check that changing page by clicking on page number correctly works on Users already on this folder of Share pop-up
Meta:@gdam
@projects
Given I created 'PR18' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaaa9 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb9 | 80501554825 | guest.user |
| first3    | last3    | cccccccc9 | 80501554825 | guest.user |
| first4    | last4    | dddddddd9 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee9 | 80501554825 | guest.user |
| first6    | last6    | ffffffff9 | 80501554825 | guest.user |
| first7    | last7    | gggggggg9 | 80501554825 | guest.user |
| first8    | last8    | hhhhhhhh9 | 80501554825 | guest.user |
| first9    | last9    | iiiiiiii9 | 80501554825 | guest.user |
| first91   | last91   | jjjjjjjj9 | 80501554825 | guest.user |
| first92   | last92   | kkkkkkkk9 | 80501554825 | guest.user |
And I created 'PSP17' project
And created '/PSF17' folder for project 'PSP17'
When I open share popup in project 'PSP17' for folder '/PSF17' from root project
And fill Share window of project folder for following users:
| User      | Role | ExpiredDate | ShouldAccess |
| aaaaaaaa9 | PR18 |             | should not   |
| bbbbbbbb9 | PR18 |             | should not   |
| cccccccc9 | PR18 |             | should not   |
| dddddddd9 | PR18 |             | should not   |
| eeeeeeee9 | PR18 |             | should not   |
| ffffffff9 | PR18 |             | should not   |
| gggggggg9 | PR18 |             | should not   |
| hhhhhhhh9 | PR18 |             | should not   |
| iiiiiiii9 | PR18 |             | should not   |
| jjjjjjjj9 | PR18 |             | should not   |
| kkkkkkkk9 | PR18 |             | should not   |
And wait for '3' seconds
And go to Users already on this folder tab after 'Add' filled users on Share window
And wait for '5' seconds
And I go to '2' page on users tab on Share window
And wait for '1' seconds
Then I should see '2' page is selected on users tab on Share window
And I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email     | Role | ExpiredDate | ShouldAccess |
| jjjjjjjj9 | PR18 |             | should not   |
| kkkkkkkk9 | PR18 |             | should not   |


Scenario: Check that changing page by clicking Next correctly works on Users already on this folder of Share pop-up
Meta:@gdam
@projects
Given I created 'PR19' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa10 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb10 | 80501554825 | guest.user |
| first3    | last3    | cccccccc10 | 80501554825 | guest.user |
| first4    | last4    | dddddddd10 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee10 | 80501554825 | guest.user |
| first6    | last6    | ffffffff10 | 80501554825 | guest.user |
| first7    | last7    | gggggggg10 | 80501554825 | guest.user |
| first8    | last8    | hhhhhhhh10 | 80501554825 | guest.user |
| first9    | last9    | iiiiiiii10 | 80501554825 | guest.user |
| first10   | first10  | jjjjjjjj10 | 80501554825 | guest.user |
| first11   | first11  | kkkkkkkk10 | 80501554825 | guest.user |
And I created 'PSP18' project
And created '/PSF18' folder for project 'PSP18'
When I open share popup in project 'PSP18' for folder '/PSF18' from root project
And fill Share window of project folder for following users:
| User       | Role | ExpiredDate | ShouldAccess |
| aaaaaaaa10 | PR19 |             | should not   |
| bbbbbbbb10 | PR19 |             | should not   |
| cccccccc10 | PR19 |             | should not   |
| dddddddd10 | PR19 |             | should not   |
| eeeeeeee10 | PR19 |             | should not   |
| ffffffff10 | PR19 |             | should not   |
| gggggggg10 | PR19 |             | should not   |
| hhhhhhhh10 | PR19 |             | should not   |
| iiiiiiii10 | PR19 |             | should not   |
| jjjjjjjj10 | PR19 |             | should not   |
| kkkkkkkk10 | PR19 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And I click on 'Next' on Share window
Then I should see '2' page is selected on users tab on Share window
And I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email      | Role | ExpiredDate | ShouldAccess |
| hhhhhhhh10 | PR19 |             | should not   |
| iiiiiiii10 | PR19 |             | should not   |


Scenario: Check that changing page by clicking Previous correctly works on Users already on this folder of Share pop-up
Meta:@gdam
@projects
Given I created 'PR20' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first1    | last1    | aaaaaaaa11 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb11 | 80501554825 | guest.user |
| first3    | last3    | cccccccc11 | 80501554825 | guest.user |
| first4    | last4    | dddddddd11 | 80501554825 | guest.user |
| first5    | last5    | eeeeeeee11 | 80501554825 | guest.user |
| first6    | last6    | ffffffff11 | 80501554825 | guest.user |
| first7    | last7    | gggggggg11 | 80501554825 | guest.user |
| first8    | last8    | hhhhhhhh11 | 80501554825 | guest.user |
| first9    | last9    | iiiiiiii11 | 80501554825 | guest.user |
| first30   | last30   | jjjjjjjj11 | 80501554825 | guest.user |
| first41   | last41   | kkkkkkkk11 | 80501554825 | guest.user |
And I created 'PSP19' project
And created '/PSF19' folder for project 'PSP19'
When I open share popup in project 'PSP19' for folder '/PSF19' from root project
And fill Share window of project folder for following users:
| User       | Role | ExpiredDate | ShouldAccess |
| aaaaaaaa11 | PR20 |             | should not   |
| bbbbbbbb11 | PR20 |             | should not   |
| cccccccc11 | PR20 |             | should not   |
| dddddddd11 | PR20 |             | should not   |
| eeeeeeee11 | PR20 |             | should not   |
| ffffffff11 | PR20 |             | should not   |
| gggggggg11 | PR20 |             | should not   |
| hhhhhhhh11 | PR20 |             | should not   |
| iiiiiiii11 | PR20 |             | should not   |
| jjjjjjjj11 | PR20 |             | should not   |
| kkkkkkkk11 | PR20 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And I click on 'Next' on Share window
Then I should see '2' page is selected on users tab on Share window
When I click on 'Previous' on Share window
Then I should see '1' page is selected on users tab on Share window
And I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role | ExpiredDate | ShouldAccess |
| AgencyAdmin |      |             | should       |
| aaaaaaaa11  | PR20 |             | should not   |
| bbbbbbbb11  | PR20 |             | should not   |
| cccccccc11  | PR20 |             | should not   |
| jjjjjjjj11  | PR20 |             | should not   |
| dddddddd11  | PR20 |             | should not   |
| kkkkkkkk11  | PR20 |             | should not   |
| eeeeeeee11  | PR20 |             | should not   |
| ffffffff11  | PR20 |             | should not   |
| gggggggg11  | PR20 |             | should not   |

