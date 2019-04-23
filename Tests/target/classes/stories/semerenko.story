NGN-118
Feature:	Create Project
Narrative:
In order to  
As a	             AgencyAdmin
I want to	 Check creation of a new Project

Scenario: Creating a new project with extended examples strange
Meta: @gdam
@projects
!-- NGN-1636
Given I am on Create New Project page
When I fill the following fields for project:
| Name                                           |
| Högdahl Català Česky Kööpenhaminassa Nødhjælp3 |
And click Save button on project popup
And go to project list page
Then I should see message warning 'Changes saved successfully'
And I should see 'Högdahl Català Česky Kööpenhaminassb Nødhjælp3' project in project list

Scenario: Creating a new project with extended examples bad
Meta: @gdam
@projects
!-- NGN-1636
Given I am on Create New Project page
When I fill the following fields for project:
| Name                                           |
| Högdahl Català Česky Kööpenhaminassa Nødhjælp1 |
And click Save button on project popup
And go to project list page
Then I should see message warning 'Changes saved successfully'
And I should see 'Högdahl Català Česky Kööpenhaminassa Nødhjæld1' project in project list

Scenario: Creating a new project with extended examples good
Meta: @gdam
@projects
!-- NGN-1636
Given I am on Create New Project page
When I fill the following fields for project:
| Name                                           |
| Högdahl Català Česky Kööpenhaminassa Nødhjælp2 |
And click Save button on project popup
And go to project list page
Then I should see message warning 'Changes saved successfully'
And I should see 'Högdahl Català Česky Kööpenhaminassa Nødhjælp2' project in project list