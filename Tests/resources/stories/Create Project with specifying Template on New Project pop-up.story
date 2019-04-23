!--NGN-121 NGN-426 NGN-37
Feature:          Create Project with specifying Template on New Project pop-up
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creating of a new Project from Template

Scenario: Check that data of template is correctly displayed on New Project pop-up in case to set Template in Template field
Meta:@gdam
	  @projects
Given I created users with following fields:
| Email    |
| CPSTU1_1 |
| CPSTU1_2 |
And the following templates were created:
| Name   | Media Type | Administrators                | Logo |
| CPSTT1 | Digital    | AgencyAdmin,CPSTU1_1,CPSTU1_2 | GIF  |
And I am on Create New Project page
And I specifyed template name 'CPSTT1' on Create New Project popup
Then I should see the following data for project with specified template name on Create New Project popup:
| Media Type | Administrators                | Include Folders | Include Team | Include Files |
| Digital    | AgencyAdmin,CPSTU1_1,CPSTU1_2 | true            | true         | false         |


Scenario: Check that look-up of template correctly works on New Project pop-up
Meta:@gdam
	  @projects
Given the following templates were created:
| Name                         |
| third test template CPST2_1  |
| third template CPST2_3       |
| Nødhjælp1 CPST2_6            |
| third test template2 CPST2_9 |
And I am on Create New Project page
And I typed template name '<TemplateName>' on Create New Project popup
Then I 'should' see element 'AutoCompletePopUp' on page 'CreateNewProjectPopUp'
And should see in autocomplete popup following search template results '<Result>'

Examples:
| TemplateName        | Result                                                                          |
| third               | third test template CPST2_1,third template CPST2_3,third test template2 CPST2_9 |
| Nødhjælp1           | Nødhjælp1 CPST2_6                                                               |


Scenario: Check that changing of specific template correctly works on Create Project From Template pop-up
Meta:@gdam
	  @projects
Given I created users with following fields:
| Email    |
| CPSTU3_1 |
| CPSTU3_2 |
And the following templates were created:
| Name   | Media Type | Administrators                | Logo |
| CPSTT3 | Digital    | AgencyAdmin,CPSTU3_1,CPSTU3_2 | GIF  |
| CPSTT4 | Broadcast  | AgencyAdmin,CPSTU3_1,CPSTU3_2 | PNG  |
And I am on Create New Project page
And I specifyed template name 'CPSTT3' on Create New Project popup
When I specify template name 'CPSTT4' on Create New Project popup
Then I should see the following data for project with specified template name on Create New Project popup:
| Media Type | Administrators                | Include Folders | Include Team | Include Files |
| Broadcast  | AgencyAdmin,CPSTU3_1,CPSTU3_2 | true            | true         | false         |