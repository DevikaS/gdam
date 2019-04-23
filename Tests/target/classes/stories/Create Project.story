!--NGN-118
Feature:          Create Project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creation of a new Project

Scenario: Successfully creating a new Project(mandatory fields only)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I am on Dashboard page
When I create new project with following fields:
| FieldName  | FieldValue |
| Name       | CP1        |
| Media type | Broadcast  |
| Start date | Today      |
| End date   | Tomorrow   |
Then I should see 'CP1' project in project list


Scenario: Successfully creating a new Project(all fields)
Meta:@gdam
	  @projects
Given I am on Project list page
When I create new project 'superNew2' with 'AllFilledFields'
Then I should see message warning 'Changes saved successfully'
And 'superNew2' project should include 'AllFilledFields'


Scenario: Creating a new project with extended examples
Meta:@gdam
	  @projects
!--NGN-1636
Given I am on Create New Project page
When I fill the following fields for project:
| Name           |
| <Project Name> |
And click Save button on project popup
Then I should see '<Project Name>' project in project list

Examples:
| Project Name                                           |
| Nødhjælp                                               |
| abcdefghijklmnoprqtsuvwyxz1234567890-=*-+~!@#\$%^&*()_ |


Scenario: Unsuccessfully creating a Project with empty mandatory fields
Meta:@gdam
	  @projects
Given I am on Create New Project page
Then I 'should not' see active Save button


Scenario: Newly created project should apppears first in list
Meta:@gdam
	  @projects
!--NGN-818
Given I am on Create New Project page
When I create 'superNew5' project
Then I should see that 'superNew5' project first in project list


Scenario: After creating new project user should be redirected to the Project Overview tab of the newly created project.
Meta:@gdam
	  @projects
!--NGN-1156
Given I am on Create New Project page
When I create 'superNew6' project
Then I should see project 'superNew6' overview page


Scenario: Check of Project name uniqueness positive
Meta:@gdam
	  @projects
Given I am on Create New Project page
When I fill the following fields for project:
| Name           | Job Number  |
| <Project Name> | <JobNumber> |
And click Save button on project popup
Then I should see '<Project Name>' project in project list

Examples:
| Project Name  | JobNumber  |
| Wickedsick2   | 888888-wtf |
| Wickedsick2   | 818888     |
| Godlike       | 818888     |


Scenario: Check that uploaded logo should displayed in project list positive
Meta:@gdam
	  @projects
Given I am on Create New Project page
When I create '<ProjectName>' project with 'MandatoryFields' and '<Logo>' logo
And go to project list page
Then I should see project '<ProjectName>' with logo '<Logo>' in project list

Examples:
| ProjectName | Logo |
| cp1         | PNG  |
| cp2         | GIF  |
| cp3         | JPG  |
| cp4         | JPEG |