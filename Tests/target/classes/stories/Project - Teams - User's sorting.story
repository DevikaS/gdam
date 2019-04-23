!--NGN-32
Feature:          Project - Teams - User's sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Project - Teams - User's sorting

Meta:
@component project

Scenario: Check sorting by Name
Meta:@gdam
@projects
Given I created 'PTUSP1' project
And created '/F1' folder for project 'PTUSP1'
And created users with following fields:
| FirstName  | LastName  | Email    | Role       |
| firstname1 | lastname1 | PTUSU1_1 | guest.user |
| firstname2 | lastname2 | PTUSU1_2 | guest.user |
| aa         | bb        | PTUSU1_3 | guest.user |
And created 'PTUSR1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTUSU1_1,PTUSU1_2,PTUSU1_3' to project 'PTUSP1' team folders '/F1' with role 'PTUSR1' expired '12.12.2021'
And I am on project 'PTUSP1' teams page
When I click element 'SortByName' on page 'TeamsPage'
Then I should see users sorted by 'name' ordered 'descending' on project 'PTUSP1' teams page


Scenario: Check that users on project team are sorted by Name by default
Meta:@gdam
@projects
Given I created 'PTUSP2' project
And created '/F2' folder for project 'PTUSP2'
And created users with following fields:
| FirstName  | LastName  | Email    | Role       |
| firstname1 | lastname1 | PTUSU2_1 | guest.user |
| firstname2 | lastname2 | PTUSU2_2 | guest.user |
| aa         | bb        | PTUSU2_3 | guest.user |
And created 'PTUSR2' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTUSU2_1,PTUSU2_2,PTUSU2_3' to project 'PTUSP2' team folders '/F2' with role 'PTUSR2' expired '12.12.2021'
And I am on project 'PTUSP2' teams page
Then I should see users sorted by 'name' ordered 'ascending' on project 'PTUSP2' teams page


Scenario: Check sorting by Company
Meta:@gdam
@projects
Given I created 'PTUSP3' project
And created '/F3' folder for project 'PTUSP3'
And created users with following fields:
| FirstName  | LastName  | Agency        | Email    | Role       |
| firstname1 | lastname1 | DefaultAgency | PTUSU3_1 | guest.user |
| firstname2 | lastname2 | AnotherAgency | PTUSU3_2 | guest.user |
| aa         | bb        | AdpathAgency  | PTUSU3_3 | guest.user |
And added following users to address book:
| UserName |
| PTUSU3_2 |
| PTUSU3_3 |
And created 'PTUSR3' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTUSU3_1,PTUSU3_2,PTUSU3_3' to project 'PTUSP3' team folders '/F3' with role 'PTUSR3' expired '12.12.2021'
And I am on project 'PTUSP3' teams page
When I click element 'SortByCompany' on page 'TeamsPage'
Then I should see users sorted by 'company' ordered 'ascending' on project 'PTUSP3' teams page