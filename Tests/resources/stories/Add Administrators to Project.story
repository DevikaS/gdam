!--NGN-42
Feature:          Add Administrators to Project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Adding Administrators to Project

Scenario: add project owner by project owner
Meta:@gdam
     @projects
Given I created users with following fields:
| Email | Role       |
| AAU1  | guest.user |
And added user 'AAU1' into address book
And created 'AAP1' project
And I am on project 'AAP1' settings page
When I edit the following fields for 'AAP1' project:
| Name | Administrators |
| AAP1 | AAU1           |
And click on element 'SaveButton'
Then I should see user 'AAU1' has role 'Project Admin' on project 'AAP1' team page
When I login with details of 'AAU1'
And go to Project list page
Then I should see 'AAP1' project in project list


Scenario: add single owner during project creation
Meta:@gdam
     @projects
Given I created users with following fields:
| Email | Role       |
| AAU3  | guest.user |
And I am on Create New Project page
When I fill the following fields for project:
| Name | Administrators |
| AAP3 | AAU3           |
And click on element 'SaveButton'
Then I should see user 'AAU3' has role 'Project Admin' on project 'AAP3' team page
When I login with details of 'AAU3'
And go to Project list page
Then I should see 'AAP3' project in project list


Scenario: verify that project owner inherits all folders and all files
Meta: @qagdamsmoke
      @uatgdamsmoke
	    @livegdamsmoke
	    @gdam
	    @projects
Given I created users with following fields:
| Email | Role       |
| AAU4  | guest.user |
And the following projects were created:
| Name | Administrators |
| AAP4 | AAU4           |
And created '/AAF4' folder for project 'AAP4'
And uploaded '/files/atCalcImage.jpg' file into '/AAF4' folder for 'AAP4' project
And I logged in with details of 'AAU4'
When I open project 'AAP4' files page
Then I 'should' see '/AAF4' folder in 'AAP4' project
And I 'should' see 'atCalcImage.jpg' file inside '/AAF4' folder for 'AAP4' project


Scenario: add several owners
Meta: @gdam
      @projects
Given I created users with following fields:
| Email  | Role       |
| AAU5_1 | guest.user |
| AAU5_2 | guest.user |
| AAU5_3 | guest.user |
And added user 'AAU5_1' into address book
And added user 'AAU5_2' into address book
And added user 'AAU5_3' into address book
And created 'AAP5' project
And I am on project 'AAP5' settings page
When I edit the following fields for 'AAP5' project:
| Name | Administrators       |
| AAP5 | AAU5_1,AAU5_2,AAU5_3 |
And click on element 'SaveButton'
Then I should see user 'AAU5_1' has role 'Project Admin' on project 'AAP5' team page
And should see user 'AAU5_2' has role 'Project Admin' on project 'AAP5' team page
And should see user 'AAU5_3' has role 'Project Admin' on project 'AAP5' team page


Scenario: delete owner
Meta: @gdam
      @projects
Given I created users with following fields:
| Email  | Role       |
| AAU6_1 | guest.user |
| AAU6_2 | guest.user |
And the following projects were created:
| Name | Administrators |
| AAP6 | AAU6_1,AAU6_2  |
And I am on project 'AAP6' settings page
When I remove administrator 'AAU6_2' from project 'AAP6'
And click on element 'SaveButton'
Then I 'should not' see user 'AAU6_2' name in teams of project 'AAP6'
When I login with details of 'AAU6_2'
And go to Project list page
Then I shouldn't see 'AAP6' project in project list


Scenario: Check that Remove link isn't active if only one project administrator is setup
Meta: @gdam
      @projects
Given I created 'AAU7' User
And created following projects:
| Name          | Administrators |
| <ProjectName> | <Admins>       |
When I open project '<ProjectName>' settings page
Then I '<Should>' see delete link for users '<Admins>' on project '<ProjectName>' settings page

Examples:
| ProjectName | Admins | Should     |
| AAP7_1      |        | should not |
| AAP7_2      | AAU7   | should     |


Scenario: Check that user from Address Book can be specified as project owner
Meta: @gdam
      @projects
Given I created 'AAU8' User
And added user 'AAU8' into address book
And created 'AAP8' project
And I am on project 'AAP8' settings page
When I edit the following fields for 'AAP8' project:
| Name | Administrators |
| AAP8 | AAU8           |
Then I 'should' see administrator 'AAU8' on project 'AAP8' settings tab


Scenario: Check that another agency user from Address Book can be specified as project owner
Meta: @gdam
      @projects
Given I logged in as 'AnotherAgencyAdmin'
And I created users with following fields:
| Agency        | Email |
| AnotherAgency | AAU9  |
And I logged in as 'AgencyAdmin'
And added user 'AAU9' into address book
And created 'AAP9' project
And I am on project 'AAP9' settings page
When I edit the following fields for 'AAP9' project:
| Name | Administrators |
| AAP9 | AAU9           |
Then I 'should' see administrator 'AAU9' on project 'AAP9' settings tab


Scenario: Check that easy share user from Address Book can be specified as project owner
Meta: @gdam
      @projects
Given I added user 'AAU10' into address book
And created 'AAP10' project
And I am on project 'AAP10' settings page
When I edit the following fields for 'AAP10' project:
| Name  | Administrators |
| AAP10 | AAU10          |
Then I 'should' see administrator 'AAU10' on project 'AAP10' settings tab


Scenario: Check setting up project owner user removed from Address Book
Meta: @gdam
      @projects
Given I created 'AAU11' User
And added user 'AAU11' into address book
And created 'AAP11' project
And removed user 'AAU11' from address book
And I am on project 'AAP11' settings page
When I edit the following fields for 'AAP11' project:
| Name  | Administrators |
| AAP11 | AAU11          |
Then I 'should' see administrator 'AAU11' on project 'AAP11' settings tab


Scenario: Check setting up project owner another agency user removed from Address Book
Meta: @gdam
     @projects
Given I logged in as 'AnotherAgencyAdmin'
And I created users with following fields:
| Agency        | Email |
| AnotherAgency | AAU12 |
And I logged in as 'AgencyAdmin'
And added user 'AAU12' into address book
And created 'AAP12' project
And removed user 'AAU12' from address book
And I am on project 'AAP12' settings page
When I edit the following fields for 'AAP12' project:
| Name  | Administrators |
| AAP12 | AAU12          |
Then I 'should' see administrator 'AAU12' on project 'AAP12' settings tab


Scenario: Check that removing user from Address Book doesn't affect project owner added before
Meta: @gdam
      @projects
Given I created 'AAU14' User
And added user 'AAU14' into address book
And created following projects:
| Name  | Administrators |
| AAP14 | AAU14          |
And removed user 'AAU14' from address book
When I open project 'AAP14' settings page
Then I 'should' see administrator 'AAU14' on project 'AAP14' settings tab


Scenario: Check that removing another agency user from Address Book doesn't affect project owner added before
Meta: @gdam
      @projects
Given I logged in as 'AnotherAgencyAdmin'
And I created users with following fields:
| Agency        | Email |
| AnotherAgency | AAU15 |
And I logged in as 'AgencyAdmin'
And added user 'AAU15' into address book
And created following projects:
| Name  | Administrators |
| AAP15 | AAU15          |
And removed user 'AAU15' from address book
When I open project 'AAP15' settings page
Then I 'should' see administrator 'AAU15' on project 'AAP15' settings tab


Scenario: Check setting up project owner easy share user removed from Address Book 2
Meta: @gdam
      @projects
Given I added user 'AAU16' into address book
And created following projects:
| Name  | Administrators |
| AAP16 | AAU16          |
And removed user 'AAU16' from address book
When I open project 'AAP16' settings page
Then I 'should' see administrator 'AAU16' on project 'AAP16' settings tab


Scenario: Check that project creator automatically added as Project Administrator during project creation
Meta: @gdam
      @projects
Given I am on Create New Project page
Then I 'should' see administrator 'AgencyAdmin' on create new project page


Scenario: Check that project creator added as Project Administrator after project creation
Meta: @gdam
      @projects
Given I am on Create New Project page
When I create 'AAP17' project with 'MandatoryFields'
And open project 'AAP17' settings page
Then I 'should' see administrator 'AgencyAdmin' on project 'AAP17' settings tab