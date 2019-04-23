Feature:          Project Owner can select and delete several users from Project Team
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that project owner can see activity when user accepts TnC

Scenario: check that project owner can remove several selected users with different project roles from Project Team (Projects)
Meta:@gdam
@projects
Given I created users with following fields:
| Email               | Role         |
| U_POCSADSUFPT_S1_1  | agency.user  |
| U_POCSADSUFPT_S1_2  | agency.admin |
| U_POCSADSUFPT_S1_3  | guest.user   |
And created 'P_POCSADSUFPT_S1' project
And created '/F_POCSADSUFPT_S1' folder for project 'P_POCSADSUFPT_S1'
And created 'R_POCSADSUFPT_S1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_POCSADSUFPT_S1_1' to project 'P_POCSADSUFPT_S1' team folders '/F_POCSADSUFPT_S1' with role 'R_POCSADSUFPT_S1' expired '12.12.2021'
And added users 'U_POCSADSUFPT_S1_2' to project 'P_POCSADSUFPT_S1' team folders '/F_POCSADSUFPT_S1' with role 'project.user' expired '12.12.2021'
And added users 'U_POCSADSUFPT_S1_3' to project 'P_POCSADSUFPT_S1' team folders '/F_POCSADSUFPT_S1' with role 'project.observer' expired '12.12.2021'
And I am on project 'P_POCSADSUFPT_S1' teams page
When I select user 'U_POCSADSUFPT_S1_1' on project 'P_POCSADSUFPT_S1' team page
When I select user 'U_POCSADSUFPT_S1_2' on project 'P_POCSADSUFPT_S1' team page
When I select user 'U_POCSADSUFPT_S1_3' on project 'P_POCSADSUFPT_S1' team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I should see users count '1' on project 'P_POCSADSUFPT_S1' team
And I 'should not' see user 'U_POCSADSUFPT_S1_1' name in teams of project 'P_POCSADSUFPT_S1'
And I 'should not' see user 'U_POCSADSUFPT_S1_2' name in teams of project 'P_POCSADSUFPT_S1'
And I 'should not' see user 'U_POCSADSUFPT_S1_3' name in teams of project 'P_POCSADSUFPT_S1'

Scenario: check that project owner can remove several selected users with different project roles from Project Team (Templates)
Meta:@gdam
@projects
Given I created users with following fields:
| Email               | Role         |
| U_POCSADSUFPT_S2_1  | agency.user  |
| U_POCSADSUFPT_S2_2  | agency.admin |
| U_POCSADSUFPT_S2_3  | guest.user   |
And created 'P_POCSADSUFPT_S2' template
And created '/F_POCSADSUFPT_S2' folder for template 'P_POCSADSUFPT_S2'
And created 'R_POCSADSUFPT_S2' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_POCSADSUFPT_S2_1' to template 'P_POCSADSUFPT_S2' team folders '/F_POCSADSUFPT_S2' with role 'R_POCSADSUFPT_S2' expired '12.12.2021'
And added users 'U_POCSADSUFPT_S2_2' to template 'P_POCSADSUFPT_S2' team folders '/F_POCSADSUFPT_S2' with role 'project.user' expired '12.12.2021'
And added users 'U_POCSADSUFPT_S2_3' to template 'P_POCSADSUFPT_S2' team folders '/F_POCSADSUFPT_S2' with role 'project.observer' expired '12.12.2021'
And I am on template 'P_POCSADSUFPT_S2' teams page
When I select user 'U_POCSADSUFPT_S2_1' on template 'P_POCSADSUFPT_S2' team page
When I select user 'U_POCSADSUFPT_S2_2' on template 'P_POCSADSUFPT_S2' team page
When I select user 'U_POCSADSUFPT_S2_3' on template 'P_POCSADSUFPT_S2' team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I should see users count '1' on template 'P_POCSADSUFPT_S2' team
And I 'should not' see user 'U_POCSADSUFPT_S2_1' name in teams of template 'P_POCSADSUFPT_S2'
And I 'should not' see user 'U_POCSADSUFPT_S2_2' name in teams of template 'P_POCSADSUFPT_S2'
And I 'should not' see user 'U_POCSADSUFPT_S2_3' name in teams of template 'P_POCSADSUFPT_S2'


Scenario: check that project owner can remove several selected users with different project roles from Project Team (Work Requests)
Meta:@gdam
@projects
Given I created users with following fields:
| Email               | Role         |
| U_POCSADSUFPT_S3_1  | agency.user  |
| U_POCSADSUFPT_S3_2  | agency.admin |
| U_POCSADSUFPT_S3_3  | guest.user   |
And created 'P_POCSADSUFPT_S3' work request
And created '/F_POCSADSUFPT_S3' folder for work request 'P_POCSADSUFPT_S3'
And created 'R_POCSADSUFPT_S3' role in 'project' group for advertiser 'DefaultAgency'
And added users 'U_POCSADSUFPT_S3_1' to project 'P_POCSADSUFPT_S3' team folders '/F_POCSADSUFPT_S3' with role 'R_POCSADSUFPT_S3' expired '12.12.2021'
And added users 'U_POCSADSUFPT_S3_2' to project 'P_POCSADSUFPT_S3' team folders '/F_POCSADSUFPT_S3' with role 'project.user' expired '12.12.2021'
And added users 'U_POCSADSUFPT_S3_3' to project 'P_POCSADSUFPT_S3' team folders '/F_POCSADSUFPT_S3' with role 'project.observer' expired '12.12.2021'
And I am on project 'P_POCSADSUFPT_S3' teams page
When I select user 'U_POCSADSUFPT_S3_1' on project 'P_POCSADSUFPT_S3' team page
When I select user 'U_POCSADSUFPT_S3_2' on project 'P_POCSADSUFPT_S3' team page
When I select user 'U_POCSADSUFPT_S3_3' on project 'P_POCSADSUFPT_S3' team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I should see users count '1' on project 'P_POCSADSUFPT_S3' team
And I 'should not' see user 'U_POCSADSUFPT_S3_1' name in teams of project 'P_POCSADSUFPT_S3'
And I 'should not' see user 'U_POCSADSUFPT_S3_2' name in teams of project 'P_POCSADSUFPT_S3'
And I 'should not' see user 'U_POCSADSUFPT_S3_3' name in teams of project 'P_POCSADSUFPT_S3'


Scenario: Check that project owner can remove several selected users from  public project team on team tab (Projects)
Meta:@gdam
@projects
Given I created users with following fields:
| Email               | Role         |
| U_POCSADSUFPT_S4_1  | agency.user  |
| U_POCSADSUFPT_S4_2  | agency.admin |
| U_POCSADSUFPT_S4_3  | guest.user   |
| U_POCSADSUFPT_S4_4  | guest.user   |
| U_POCSADSUFPT_S4_5  | guest.user   |
And created 'P_POCSADSUFPT_S4' project
And created '/F_POCSADSUFPT_S4' folder for project 'P_POCSADSUFPT_S4'
And created 'R_POCSADSUFPT_S4' role in 'project' group for advertiser 'DefaultAgency'
And I created agency project team 'APT_POCSADSUFPT_S4' with following data:
| UserName           | Role                |
| U_POCSADSUFPT_S4_1 | project.observer    |
| U_POCSADSUFPT_S4_2 | project.contributor |
| U_POCSADSUFPT_S4_3 | project.contributor |
| U_POCSADSUFPT_S4_4 | project.user        |
| U_POCSADSUFPT_S4_5 | project.user        |
And I added agency project team 'APT_POCSADSUFPT_S4' into project 'P_POCSADSUFPT_S4'
And I am on project 'P_POCSADSUFPT_S4' teams page
When I select agency project team 'APT_POCSADSUFPT_S4' on project's team page
And I select user 'U_POCSADSUFPT_S4_1' on project 'P_POCSADSUFPT_S4' for current team page
And I select user 'U_POCSADSUFPT_S4_2' on project 'P_POCSADSUFPT_S4' for current team page
And I select user 'U_POCSADSUFPT_S4_3' on project 'P_POCSADSUFPT_S4' for current team page
And I select user 'U_POCSADSUFPT_S4_4' on project 'P_POCSADSUFPT_S4' for current team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I should see users count '2' on project 'P_POCSADSUFPT_S4' team
When I select agency project team 'APT_POCSADSUFPT_S4' on project's team page
Then I 'should not' see user 'U_POCSADSUFPT_S4_1' name for team 'APT_POCSADSUFPT_S4' in teams of project 'P_POCSADSUFPT_S4'
And I 'should not' see user 'U_POCSADSUFPT_S4_2' name for team 'APT_POCSADSUFPT_S4' in teams of project 'P_POCSADSUFPT_S4'
And I 'should not' see user 'U_POCSADSUFPT_S4_3' name for team 'APT_POCSADSUFPT_S4' in teams of project 'P_POCSADSUFPT_S4'
And I 'should not' see user 'U_POCSADSUFPT_S4_4' name for team 'APT_POCSADSUFPT_S4' in teams of project 'P_POCSADSUFPT_S4'


Scenario: Check that project owner can remove several selected users from  public project team on team tab (Templates)
Meta:@gdam
@projects
Given I created users with following fields:
| Email               | Role         |
| U_POCSADSUFPT_S5_1  | agency.user  |
| U_POCSADSUFPT_S5_2  | agency.admin |
| U_POCSADSUFPT_S5_3  | guest.user   |
| U_POCSADSUFPT_S5_4  | guest.user   |
| U_POCSADSUFPT_S5_5  | guest.user   |
And created 'P_POCSADSUFPT_S5' template
And created '/F_POCSADSUFPT_S5' folder for template 'P_POCSADSUFPT_S5'
And created 'R_POCSADSUFPT_S5' role in 'project' group for advertiser 'DefaultAgency'
And I created agency project team 'APT_POCSADSUFPT_S5' with following data:
| UserName           | Role                |
| U_POCSADSUFPT_S5_1 | project.observer    |
| U_POCSADSUFPT_S5_2 | project.contributor |
| U_POCSADSUFPT_S5_3 | project.contributor |
| U_POCSADSUFPT_S5_4 | project.user        |
| U_POCSADSUFPT_S5_5 | project.user        |
And I added agency project team 'APT_POCSADSUFPT_S5' into template 'P_POCSADSUFPT_S5'
And I am on template 'P_POCSADSUFPT_S5' teams page
When I select agency project team 'APT_POCSADSUFPT_S5' on template's team page
And I wait for '2' seconds
And I select user 'U_POCSADSUFPT_S5_1' on template 'P_POCSADSUFPT_S5' for current team page
And I select user 'U_POCSADSUFPT_S5_2' on template 'P_POCSADSUFPT_S5' for current team page
And I select user 'U_POCSADSUFPT_S5_3' on template 'P_POCSADSUFPT_S5' for current team page
And I select user 'U_POCSADSUFPT_S5_4' on template 'P_POCSADSUFPT_S5' for current team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I should see users count '2' on template 'P_POCSADSUFPT_S5' team
When I select agency project team 'APT_POCSADSUFPT_S5' on project's team page
Then I 'should not' see user 'U_POCSADSUFPT_S5_1' name for team 'APT_POCSADSUFPT_S5' in teams of template 'P_POCSADSUFPT_S5'
And I 'should not' see user 'U_POCSADSUFPT_S5_2' name for team 'APT_POCSADSUFPT_S5' in teams of template 'P_POCSADSUFPT_S5'
And I 'should not' see user 'U_POCSADSUFPT_S5_3' name for team 'APT_POCSADSUFPT_S5' in teams of template 'P_POCSADSUFPT_S5'
And I 'should not' see user 'U_POCSADSUFPT_S5_4' name for team 'APT_POCSADSUFPT_S5' in teams of template 'P_POCSADSUFPT_S5'

Scenario: Check that project owner can remove several selected users from  public project team on team tab (Work requests)
Meta:@gdam
@projects
Given I created users with following fields:
| Email               | Role         |
| U_POCSADSUFPT_S6_1  | agency.user  |
| U_POCSADSUFPT_S6_2  | agency.admin |
| U_POCSADSUFPT_S6_3  | guest.user   |
| U_POCSADSUFPT_S6_4  | guest.user   |
| U_POCSADSUFPT_S6_5  | guest.user   |
And created 'P_POCSADSUFPT_S6' work request
And created '/F_POCSADSUFPT_S6' folder for work request 'P_POCSADSUFPT_S6'
And created 'R_POCSADSUFPT_S6' role in 'project' group for advertiser 'DefaultAgency'
And I created agency project team 'APT_POCSADSUFPT_S6' with following data:
| UserName           | Role                |
| U_POCSADSUFPT_S6_1 | project.observer    |
| U_POCSADSUFPT_S6_2 | project.contributor |
| U_POCSADSUFPT_S6_3 | project.contributor |
| U_POCSADSUFPT_S6_4 | project.user        |
| U_POCSADSUFPT_S6_5 | project.user        |
And I added agency project team 'APT_POCSADSUFPT_S6' into project 'P_POCSADSUFPT_S6'
And I am on project 'P_POCSADSUFPT_S6' teams page
When I select agency project team 'APT_POCSADSUFPT_S6' on project's team page
And I select user 'U_POCSADSUFPT_S6_1' on project 'P_POCSADSUFPT_S6' for current team page
And I select user 'U_POCSADSUFPT_S6_2' on project 'P_POCSADSUFPT_S6' for current team page
And I select user 'U_POCSADSUFPT_S6_3' on project 'P_POCSADSUFPT_S6' for current team page
And I select user 'U_POCSADSUFPT_S6_4' on project 'P_POCSADSUFPT_S6' for current team page
And click element 'RemoveButton' on page 'TeamsPage'
And click element 'YesButton' on page 'DeleteUserConfirmationPopUp'
Then I should see users count '2' on project 'P_POCSADSUFPT_S6' team
When I select agency project team 'APT_POCSADSUFPT_S6' on project's team page
Then I 'should not' see user 'U_POCSADSUFPT_S6_1' name for team 'APT_POCSADSUFPT_S6' in teams of project 'P_POCSADSUFPT_S6'
And I 'should not' see user 'U_POCSADSUFPT_S6_2' name for team 'APT_POCSADSUFPT_S6' in teams of project 'P_POCSADSUFPT_S6'
And I 'should not' see user 'U_POCSADSUFPT_S6_3' name for team 'APT_POCSADSUFPT_S6' in teams of project 'P_POCSADSUFPT_S6'
And I 'should not' see user 'U_POCSADSUFPT_S6_4' name for team 'APT_POCSADSUFPT_S6' in teams of project 'P_POCSADSUFPT_S6'
