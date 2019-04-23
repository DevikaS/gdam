!--NGN-32 NGN-1343
Feature:          Template Teams - User's sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Template Teams - User's sorting

Scenario: Check sorting by Name
Meta:@gdam
@projects
Given I created 'TTUST1' template
And created '/TTUSF1' folder for template 'TTUST1'
And created users with following fields:
| FirstName  | LastName  | Email    | Role       |
| firstname1 | lastname1 | TTUSU1_1 | guest.user |
| firstname2 | lastname2 | TTUSU1_2 | guest.user |
| aa         | bb        | TTUSU1_3 | guest.user |
And created 'TTUSR1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'TTUSU1_1,TTUSU1_2,TTUSU1_3' to template 'TTUST1' team folders '/TTUSF1' with role 'TTUSR1' expired '12.12.2021'
And I am on template 'TTUST1' teams page
When I click element 'SortByName' on page 'TeamsPage'
Then I should see users sorted by 'name' ordered 'descending' on template 'TTUST1' teams page

Scenario: Check that users on template team are sorted by Name by default
Meta:@gdam
@projects
Given I created 'TTUST2' template
And created '/TTUSF2' folder for template 'TTUST2'
And created users with following fields:
| FirstName  | LastName  | Email    | Role       |
| firstname1 | lastname1 | TTUSU2_1 | guest.user |
| firstname2 | lastname2 | TTUSU2_2 | guest.user |
| aa         | bb        | TTUSU2_3 | guest.user |
And created 'TTUSR2' role in 'project' group for advertiser 'DefaultAgency'
And added users 'TTUSU2_1,TTUSU2_2,TTUSU2_3' to template 'TTUST2' team folders '/TTUSF2' with role 'TTUSR2' expired '12.12.2021'
And I am on template 'TTUST2' teams page
Then I should see users sorted by 'name' ordered 'ascending' on template 'TTUST2' teams page

Scenario: Check sorting by Company
Meta:@gdam
@projects
Given I created 'TTUST3' template
And created '/TTUSF3' folder for template 'TTUST3'
And created users with following fields:
| FirstName  | LastName  | Agency        | Email    | Role       |
| firstname1 | lastname1 | DefaultAgency | TTUSU3_1 | guest.user |
| firstname2 | lastname2 | AnotherAgency | TTUSU3_2 | guest.user |
| aa         | bb        | AdpathAgency  | TTUSU3_3 | guest.user |
And added following users to address book:
| UserName |
| TTUSU3_2 |
| TTUSU3_3 |
And created 'TTUSR3' role in 'project' group for advertiser 'DefaultAgency'
And added users 'TTUSU3_1,TTUSU3_2,TTUSU3_3' to template 'TTUST3' team folders '/TTUSF3' with role 'TTUSR3' expired '12.12.2021'
And I am on template 'TTUST3' teams page
When I click element 'SortByCompany' on page 'TeamsPage'
Then I should see users sorted by 'company' ordered 'ascending' on template 'TTUST3' teams page