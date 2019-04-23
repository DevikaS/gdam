!--NGN-1920
Feature:    Share folder from drop down menu
Narrative:
In order to
As a                 AgencyAdmin
I want to     Check sharing folder

Scenario: Check that users of Team Template are added in case to add Team Template on Share pop-up (sharing from drop down menu)
Meta:@gdam
     @skip
Given I created 'PR_PSFATT1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email  | Telephone   | Role        |
| first1    | last1    | share1 | 80501554825 | guest.user  |
| first2    | last2    | share2 | 80501554825 | guest.user  |
And I created 'PSFATT1_1' project
And created '/PSFATTF1_1' folder for project 'PSFATT1_1'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| share1   | 1tt1_1       |
| share2   | 1tt1_1       |
And I am on project 'PSFATT1_1' folder '/PSFATTF1_1' page
When I open Share window from popup menu for folder '/PSFATTF1_1' on project 'PSFATT1_1'
And fill Share window of project folder for following team templates :
| TeamTemplate |
| 1tt1_1         |
Then I should see on selected 'Add users' tab on Share window the following users in current order :
| Email  | Role       | ExpiredDate | ShouldAccess |
| share1 | PR_PSFATT1 |             | should not   |
| share2 | PR_PSFATT1 |             | should not   |


Scenario: Check that team template is autocompleted on Share pop-up (sharing from drop down menu)
Meta: @skip
      @gdam
Given I created 'PR_PSFATT2' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email  | Telephone   | Role        |
| first1    | last1    | share3 | 80501554825 | guest.user  |
And I created 'PSFATT2_1' project
And created '/PSFATTF2_1' folder for project 'PSFATT2_1'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| share3   | 1tt1_2       |
And I am on project 'PSFATT2_1' folder '/PSFATTF2_1' page
When I open Share window from popup menu for folder '/PSFATTF2_1' on project 'PSFATT2_1'
And fill Share popup of project folder by following team '1tt1_2' with expiration date ''
Then 'should' see element 'AutoCompletePopUp' on page 'ShareWindow'
And should see team template '1tt1_2' on '1' position in autocomplete popup on Share window


Scenario: Check that 'Add' button isn't active without specifying required data (sharing from drop down menu)
Meta: @skip
      @gdam
Given I created 'PR_PSFATT3' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email  | Telephone   | Role        |
| first1    | last1    | share4 | 80501554825 | guest.user  |
And I created 'PSFATT3_1' project
And created '/PSFATTF3_1' folder for project 'PSFATT3_1'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| share4   | 1tt1_3       |
And I am on project 'PSFATT3_1' folder '/PSFATTF3_1' page
When I open Share window from popup menu for folder '/PSFATTF3_1' on project 'PSFATT3_1'
And fill Share popup of project folder by following team '<TeamTemplate>' with expiration date ''
And select team template with name '<TeamTemplate>' in Share popup of project folder
Then I should see element 'Add' on page 'ShareWindow' in following state '<State>'

Examples:
| TeamTemplate | State    |
|              | disabled |
| 1tt1_3       | enabled  |


Scenario: Check that passed date isn't accessible in Expiration date field (sharing from drop down menu)
Meta: @skip
      @gdam
Given I created 'PR_PSFATT4' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email  | Telephone   | Role        |
| first1    | last1    | share5 | 80501554825 | guest.user  |
And I created 'PSFATT4_1' project
And created '/PSFATTF4_1' folder for project 'PSFATT4_1'
And I added users to team template with the following fields:
| UserName | TeamTemplate |
| share5   | 1tt1_4       |
And I am on project 'PSFATT4_1' folder '/PSFATTF4_1' page
When I open Share window from popup menu for folder '/PSFATTF4_1' on project 'PSFATT4_1'
And fill Share popup of project folder by following team '1tt1_4' with expiration date '01.01.2010'
And click element 'AddUsers' on page 'ShareWindow'
Then I 'should' see red inputs on page