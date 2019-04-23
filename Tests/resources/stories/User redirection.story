!--NGN-2521
Feature:          User redirection
Narrative:
In order to
As a              AgencyAdmin
I want to         Check user redirection

Scenario: check redirect for received email with notification link to shared folder from project
Meta: @gdam
@gdamemails
Given I created 'PR_UR_S01' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email      | Role        | Password   |
| U_UR_S01_1 | agency.user | abcdefghA1 |
And created 'P_UR_S01' project
And created in 'P_UR_S01' project next folders:
| folder      |
| /F_UR_S01_1 |
| /F_UR_S01_2 |
And added users 'U_UR_S01_1' to project 'P_UR_S01' team folders '/F_UR_S01_1' with role 'PR_UR_S01' expired '12.12.2022' and 'should' access to subfolders
And waited for '10' seconds
When I logout from account
And open link from email with subject 'Folders have been shared with' which user 'U_UR_S01_1' received
And fill fields login 'U_UR_S01_1' and password 'abcdefghA1' and then login to system
Then I 'should' be on the project files page