!--NGN-121 NGN-426 NGN-37
Feature:          Create Project from Template via Template List
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creating of a new Project from Template

Scenario: Inheriting metadata from template
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
	  @gdamcrossbrowser
Given I created users with following fields:
| Email      | Role        | Agency        |
| U_CPFT_S01 | agency.user | DefaultAgency |
And logged in with details of 'U_CPFT_S01'
And the following templates were created:
| Name       | Media Type |
| T_CPFT_S01 | Digital    |
And I am on Dashboard page
When I go to template list page
And click use template button next to template 'T_CPFT_S01' on opened templates list page
And wait for '10' seconds
Then I should see the following data for project from template:
| Advertiser    | Media Type |
| DefaultAgency | Digital    |


Scenario: Successfully change data in Project that was created from template
Meta:@gdam
	  @projects
Given I created 'CPT1' template
When I use 'CPT1' template
And fill the following fields for project from template:
| Name | Media Type |
| CPP2 | Print      |
And I click on element 'SaveButton'
And I open project 'CPP2' settings page
And edit the following fields for 'CPP2' project:
| Name   | Job Number | Media Type | Start date | End date   |
| CPP2_1 | 666        | Print      | [Tomorrow] | 11.11.2015 |
And I click on element 'SaveButton' without delay
Then I should see message warning 'Changes saved successfully'
And Project 'CPP2_1' should include the following fields:
| Name   | Job Number | Media Type | Start date | End date   |
| CPP2_1 | 666        | Print      | [Tomorrow] | 11.11.2015 |


Scenario: Creating a new Project from template including folders from the template
Meta:@gdam
	 @projects
!--NGN-1895
Given I created 'CPT5' template
And created in 'CPT5' template next folders:
| folder |
| /CNF5  |
When I use 'CPT5' template
And fill the following fields for project from template:
| Name          |
| <ProjectName> |
And I '<Check>' include 'Folders' for project
And I click on element 'SaveButton'
Then I '<Should>' see '/CNF5' folder in '<ProjectName>' project

Examples:
| ProjectName | Check   | Should     |
| CPP5_1      | check   | should     |
| CPP5_2      | uncheck | should not |


Scenario: Creating a new Project from template including files from the template
Meta:@gdam
	 @projects
!-- NGN-1900
Given I created 'CPT6' template
And created '/test1' folder for template 'CPT6'
And uploaded '/files/image10.jpg' file into '/test1' folder for 'CPT6' template
When I use 'CPT6' template
And fill the following fields for project from template:
| Name          |
| <ProjectName> |
And I '<Check>' include 'Files' for project
And I click on element 'SaveButton'
Then I '<Should>' see 'image10.jpg' file inside '/test1' folder for '<ProjectName>' project

Examples:
| ProjectName | Check   | Should     |
| CPP6_1      | check   | should     |
| CPP6_2      | uncheck | should not |


Scenario: Creating a new Project from template including only users from the template
Meta:@gdam
	  @projects
!--NGN-1907
!-- QAB-969 - Rob Lee has confirmed that project owners are not copied to project when 'Include Team' is unchecked
Given I created users with following fields:
| Email | Role       |
| CPU7  | guest.user |
And the following templates were created:
| Name | Administrators |
| CPT7 | CPU7           |
When I use 'CPT7' template
And fill the following fields for project from template:
| Name          |
| <ProjectName> |
And I '<Check>' include 'Teams' for project
And I 'uncheck' include 'Folders' for project
And I click on element 'SaveButton'
Then I '<Should>' see following users on project '<ProjectName>' team page:
| UserName |
| CPU7     |

Examples:
| ProjectName | Check   | Should     |
| CPP7_1      | check   | should     |
| CPP7_2      | uncheck | should     |


Scenario: Creating a new Project from template including users and including folders from the template
Meta:@gdam
	  @projects
Given I created users with following fields:
| Email | Role       |
| CPU8  | guest.user |
And I created 'CPT8' template
And created '/CPTF1' folder for template 'CPT8'
And created 'CPR8' role in 'project' group for advertiser 'DefaultAgency'
And added users 'CPU8' to template 'CPT8' team folders '/CPTF1' with role 'CPR8' expired '12.12.2021'
When I use 'CPT8' template
And fill the following fields for project from template:
| Name          | Job Number | Start Date | End Date   |
| <ProjectName> | 777        | [Today]    | 12.12.2016 |
And I '<Check>' include 'Folders' for project
And I '<Check>' include 'Teams' for project
And I click on element 'SaveButton' without delay
Then I 'should' see warning message 'Changes saved successfully' on page
And I '<Should>' see following users on project '<ProjectName>' team page:
| UserName    |
| CPU8        |
And '<Should>' see '/CPTF1' folder in '<ProjectName>' project

Examples:
| ProjectName | Check   | Should     |
| CPP8_1      | check   | should     |
| CPP8_2      | uncheck | should not |


Scenario: Check that team settings correctly transferred in case creating a new Project from template including teams and including folders from the template
Meta:@gdam
	  @projects
Given I created users with following fields:
| Email | Role       |
| CPU9  | guest.user |
And I created 'CPT9' template
And created '/CPTF1' folder for template 'CPT9'
And created 'CPR9' role in 'project' group for advertiser 'DefaultAgency'
And added users 'CPU9' to template 'CPT9' team folders '/CPTF1' with role 'CPR9' expired '12.12.2021'
When I use 'CPT9' template
And fill the following fields for project from template:
| Name | Job Number | Start Date | End Date   |
| CPP9 | 777        | [Today]    | 12.12.2016 |
And I 'check' include 'Folders' for project
And I 'check' include 'Teams' for project
And I click on element 'SaveButton'
And I go to project 'CPP9' teams page
And I open user 'CPU9' permissions on project 'CPP9' team page
Then I should see following role settings for folders in manage permissions popup of project 'CPP9' team for user 'CPU9':
| Folder | Role | Expiration |
| /CPTF1 | CPR9 | 12.12.2021 |


Scenario: Successfully creating a new Project from template inheriting logo from the template
Meta:@gdam
	  @projects
Given I created 'CPT10' template with 'MandatoryFields' and 'GIF' logo
When I use 'CPT10' template
And fill the following fields for project from template:
| Name  | Job Number | Start date | End date   |
| CPP10 | 777        | [Today]    | 12.12.2016 |
And click on element 'SaveButton'
Then I should see message warning 'Changes saved successfully'
And 'CPP10' project should include 'MandatoryFields' and 'GIF' logo


Scenario: Creating a Project from template with empty mandatory fields
Meta:@gdam
	  @projects
Given I created 'CPT13' template
When I use 'CPT13' template
Then I should see element 'SaveButton' on page 'BasePage' in following state 'disabled'


Scenario: Check that 'include files' cannot be selected without selections 'include folders'
Meta:@gdam
	  @projects
!-- NGN-1898
Given created 'CPT14' template
When I use 'CPT14' template
And I 'uncheck' include 'Folders' for project
Then I should see element 'IncludeFiles' on page 'ProjectsCreateFromTemplate' in following state 'disabled'


Scenario: Check that 'include folders' is selected by default
Meta:@gdam
	  @projects
!-- NGN-1921
Given created 'CPT15' template
When I use 'CPT15' template
Then I should see element 'IncludeFolders' on page 'ProjectsCreateFromTemplate' in following state 'selected'


Scenario: Check of Project name uniqueness after creating from template
Meta:@gdam
	  @projects
Given created 'CPT19' template
When I use 'CPT19' template
And fill the following fields for project from template:
| Name          | Job Number  |
| <ProjectName> | <JobNumber> |
And I click on element 'SaveButton' without delay
Then I should see message warning '<Message>' for project '<ProjectName>'

Examples:
| ProjectName | JobNumber   | Message                                               |
| Wickedsick  | 88888-wtf   | Changes saved successfully                            |
| Wickedsick  |             | Changes saved successfully                            |
| wickedsick  | 88888-wtf   | Project with such name and job number already exists. |



Scenario: Check that template is displayed on Create Project from Template in case to use template
Meta:@gdam
	  @projects
Given created 'CPT20' template
When I use 'CPT20' template
Then I should see the following data for project from template:
| Template |
| CPT20    |


Scenario: Check that changing of template correctly works on Create Project From Template pop-up
Meta:@gdam
	  @projects
Given the following templates were created:
| Name    | Advertiser    | Product/Brand  | Campaign        | Media Type |
| CPT21_1 | DefaultAgency | DefaultProduct | DefaultCampaign | Digital    |
| CPT21_2 | DefaultAgency | AnotherProduct | AnotherCampaign | Broadcast  |
When I use 'CPT21_1' template
And fill the following fields for project from template:
| Template  |
| CPT21_2   |
Then I should see the following data for project from template:
| Product/Brand  | Campaign        | Media Type |
| AnotherProduct | AnotherCampaign | Broadcast  |