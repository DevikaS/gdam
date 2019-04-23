!--NGN-278
Feature:          Project Share folder - Add team template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing folder

Scenario: Check that users of Team Template are added in case to add Team Template on Share pop-up
Meta:@gdam
@projects
Given I created 'PR_PSFATT1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email  | Telephone   | Role       |
| first1    | last1    | share1 | 80501554825 | guest.user |
| first2    | last2    | share2 | 80501554825 | guest.user |
And added users 'share1,share2' to Address book
And I created 'PSFATT1' project
And created '/PSFATTF1' folder for project 'PSFATT1'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| share1   | 1ttat1       |
| share2   | 1ttat1       |
When go to project 'PSFATT1' folder 'root' page
And select folder '/PSFATTF1' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share window of project folder for following team templates :
| TeamTemplate | Role       |
| 1ttat1       | PR_PSFATT1 |
Then I should see on selected 'Add users' tab on Share window the following users in current order :
| Email  | Role           | ExpiredDate | ShouldAccess |
| share1 | PR_PSFATT1     |             | should not   |
| share2 | PR_PSFATT1     |             | should not   |


Scenario: Check that team template is autocompleted on Share pop-up
Meta:@gdam
@projects
Given I created 'PR_PSFATT2' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email  | Telephone   | Role       |
| first1    | last1    | share3 | 80501554825 | guest.user |
And added user 'share3' into address book
And I created 'PSFATT2' project
And created '/PSFATTF2' folder for project 'PSFATT2'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| share3   | 1tt1         |
When go to project 'PSFATT2' folder 'root' page
And select folder '/PSFATTF2' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share popup of project folder by following team '1tt1' with expiration date ''
Then 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'
And should see team template '1tt1' on '1' position in autocomplete popup on Share window


Scenario: Check that 'Add' button isn't active without specifying required data
Meta:@gdam
@projects
Given I created 'PR_PSFATT3' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email  | Telephone   | Role       |
| first1    | last1    | share4 | 80501554825 | guest.user |
And added user 'share4' into address book
And I created 'PSFATT3' project
And created '/PSFATTF3' folder for project 'PSFATT3'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| share4   | 1tt1         |
When go to project 'PSFATT3' folder 'root' page
And select folder '/PSFATTF3' on project files page
And open Share window using 'Share' button for current on opened files page
When I click element 'Share' on page 'FilesPage'
And fill Share popup of project folder by following team '<TeamTemplate>' with expiration date ''
And select team template with name '<TeamTemplate>' in Share popup of project folder
Then I should see element 'Add' on page 'ShareWindow' in following state '<State>'

Examples:
| TeamTemplate | State    |
|              | disabled |
| 1tt1         | enabled  |


Scenario: Check that passed date isn't accessible in Expiration date field
Meta:@gdam
@projects
Given I created 'PR_PSFATT4' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email  | Telephone   | Role       |
| first1    | last1    | share5 | 80501554825 | guest.user |
And added user 'share5' into address book
And I created 'PSFATT4' project
And created '/PSFATTF4' folder for project 'PSFATT4'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| share5   | 1tt1         |
When go to project 'PSFATT4' folder 'root' page
And select folder '/PSFATTF4' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share popup of project folder by following team '1tt1' with expiration date '01.01.2010'
And click element 'AddUsers' on page 'ShareWindow'
Then I 'should' see red inputs on page