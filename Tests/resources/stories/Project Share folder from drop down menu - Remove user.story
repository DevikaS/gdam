!--NGN-1920
Feature:          Project Share folder from drop down menu - Remove user
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing folder

Scenario: Check that user can be removed from Add users tab of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR_SFR1' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email       | Telephone   | Role       |
| first1    | last1    | aaaaaa_sfr1 | 80501554825 | guest.user |
| first2    | last2    | bbbbbb_sfr1 | 80501554825 | guest.user |
And I created 'SFRP1_1' project
And created '/SFRF1_1' folder for project 'SFRP1_1'
And I am on project 'SFRP1_1' folder '/SFRF1_1' page
When I open Share window from popup menu for folder '/SFRF1_1' on project 'SFRP1_1'
And fill Share window of project folder for following users:
| User        | Role    | ExpiredDate | ShouldAccess |
| aaaaaa_sfr1 | PR_SFR1 |             | should not   |
| bbbbbb_sfr1 | PR_SFR1 |             | should not   |
And I remove user 'aaaaaa_sfr1' from users tab on Share window
Then I should see on selected 'Add users' tab on Share window the following users in current order :
| Email       | Role    | ExpiredDate | ShouldAccess |
| bbbbbb_sfr1 | PR_SFR1 |             | should not   |


Scenario: Check that user can be removed from Users already on this folder of Share pop-up
Meta: @skip
      @gdam
Given I created 'PR_SFR2' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email       | Telephone   | Role       |
| first1    | last1    | aaaaaa_sfr2 | 80501554825 | guest.user |
| first2    | last2    | bbbbbb_sfr2 | 80501554825 | guest.user |
And I created 'SFRP2_2' project
And created '/SFRF2_2' folder for project 'SFRP2_2'
And I am on project 'SFRP2_2' folder '/SFRF2_2' page
When I open Share window from popup menu for folder '/SFRF2_2' on project 'SFRP2_2'
And fill Share window of project folder for following users:
| User        | Role    | ExpiredDate | ShouldAccess |
| aaaaaa_sfr2 | PR_SFR2 |             | should not   |
| bbbbbb_sfr2 | PR_SFR2 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And I remove user 'aaaaaa_sfr2' from users tab on Share window
And go to Users already on this folder tab after 'Save' changes on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role          | ExpiredDate | ShouldAccess |
| AgencyAdmin | project.admin |             | should       |
| bbbbbb_sfr2 | PR_SFR2       |             | should not   |