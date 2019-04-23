!--NGN-1261 NGN-2047
!--Note: Indexes are generated every 5 minutes in elastic search
Feature:          Template Team - Activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check template team activity

Scenario: Check that 'create the template' is displayed on Recent Activity in template team
Meta:@gdam
@projects
Given I created 'U_TTA_S07' User
And logged in with details of 'U_TTA_S07'
And created 'T_TTA_S07' template
When I login as 'AgencyAdmin'
And go to template 'T_TTA_S07' teams page
Then I 'should' see activity for user 'U_TTA_S07' on template team page with message 'created the template' and value 'T_TTA_S07'


Scenario: Check that 'updated the template' is displayed on Recent Activity in template team
Meta:@gdam
@projects
Given I created 'U_TTA_S08' User
And logged in with details of 'U_TTA_S08'
And created 'T_TTA_S08' template
And I am on template 'T_TTA_S08' settings page
When I edit the following fields for 'T_TTA_S08' template:
| Name      | Job Number | Media Type |
| T_TTA_S08 | JN_TTA_S08 | Digital    |
And click on element 'SaveButton'
And I login as 'AgencyAdmin'
And go to template 'T_TTA_S08' teams page
Then I 'should' see activity for user 'U_TTA_S08' on template team page with message 'updated the template' and value 'T_TTA_S08'


Scenario: Check that 'file played' is displayed on Recent Activity in template team
Meta: @gdam
      @projects
Given I created 'U_TTA_S12' User
And logged in with details of 'U_TTA_S12'
And created 'T_TTA_S12' template
And created '/F_S12' folder for template 'T_TTA_S12'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/F_S12' folder for 'T_TTA_S12' template
And I am on file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F_S12' template 'T_TTA_S12'
When I wait while proxy is visible on file info page
And play clip on file '13DV-CAPITAL-10.mpg' info page in folder '/F_S12' template 'T_TTA_S12'
And wait for '1' seconds
And I login as 'AgencyAdmin'
And go to template 'T_TTA_S12' teams page
Then I 'should' see activity for user 'U_TTA_S12' on template team page with message 'played file' and value '/F_S12/13DV-CAPITAL-10.mpg'


Scenario: Check that activity correct works in case to create template from project
Meta:@gdam
@projects
!--NGN-2219
Given I created 'U_TTA_S14' User
And logged in with details of 'U_TTA_S14'
And created 'P_TTA_S14' project
And I am on project 'P_TTA_S14' overview page
And clicked create template from project for project 'P_TTA_S14'
When I specify template name 'T_TTA_S14' on create template page
And click on element 'SaveButton'
And I go to template 'T_TTA_S14' teams page
Then I 'should' see activity for user 'U_TTA_S14' on template team page with message 'clone the template' and value 'T_TTA_S14'