!--NGN-10398
!--NGN-10399
Feature:          Activity on Dashboard about TnC add information about Project and other Activity pages
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Activity on Dashboard about TNC add information about Project other Activity pages

Scenario: Check that link to project work in T&C activity (Edit Project and add Activity)
Meta:@gdam
     @projects
Given I created the agency 'ADATCADDIAP_A1' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| ADADDIAP_EATC1 | agency.admin | ADATCADDIAP_A1 |
And logged in with details of 'ADADDIAP_EATC1'
And I am on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When save current terms and conditions on opened T&C page
And login with details of 'ADADDIAP_EATC1'
And accept agency Terms and Conditions
And create new project with following fields:
| FieldName          | FieldValue       |
| Name               | ADADDIAP_EATC_P1 |
| Media type         | Broadcast        |
| Start date         | Today            |
| End date           | Tomorrow         |
| Terms & Conditions | test             |
And wait for '3' seconds
And refresh the page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName       | Message                            | Value                |
| ADADDIAP_EATC1 | created project                    | ADADDIAP_EATC_P1     |
| ADADDIAP_EATC1 | created project Terms & Conditions | Terms and Conditions |


Scenario: Check that link to project work in T&C activity about accepting it by share user
Meta:@gdam
     @projects
Given I created the agency 'ADATCADDIAP_A2' with default attributes
And created users with following fields:
| Email               | Role         | Agency         |
| ADATCADDIAP_EATC2_1 | agency.admin | ADATCADDIAP_A2 |
| ADATCADDIAP_EATC2_3 | agency.user  | ADATCADDIAP_A2 |
And logged in with details of 'ADATCADDIAP_EATC2_1'
And added user 'ADATCADDIAP_EATC2_3' to Address book
And I am on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue |
| Name               | Project1   |
| Media type         | Broadcast  |
| Start date         | Today      |
| End date           | Tomorrow   |
| Terms & Conditions | test       |
And accept agency Terms and Conditions
And I edit the following fields for 'Project1' project:
| Name     | Administrators      |
| Project1 | ADATCADDIAP_EATC2_3 |
And click on element 'SaveButton'
And login with details of 'ADATCADDIAP_EATC2_3'
And go to project list page
And I click by project name 'Project1'
And accept agency Terms and Conditions
And login with details of 'ADATCADDIAP_EATC2_1'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName            | Message                             | Value                |
| ADATCADDIAP_EATC2_3 | accepted project Terms & Conditions | Terms and Conditions |


Scenario: Check that if project created with T&C,this is logged in activity (Project Overview)
Meta:@gdam
     @projects
Given I created the agency 'ADATCADDIAP_A4' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| ADATCADDIAP_E4 | agency.admin | ADATCADDIAP_A4 |
And logged in with details of 'ADATCADDIAP_E4'
And I am on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When create new project with following fields:
| FieldName          | FieldValue       |
| Name               | ADADDIAP_EATC_P4 |
| Media type         | Broadcast        |
| Start date         | Today            |
| End date           | Tomorrow         |
| Terms & Conditions | test             |
And refresh the page
And accept agency Terms and Conditions
And wait for '10' seconds
And refresh the page
Then I 'should' see following activities in 'Recent Activity' section on Project Overview page:
| UserName       | Message                                                  | Value            |
| ADATCADDIAP_E4 | created project                                          | ADADDIAP_EATC_P4 |
| ADATCADDIAP_E4 | created project Terms & Conditions Terms and Conditions  |                  |
| ADATCADDIAP_E4 | accepted project Terms & Conditions Terms and Conditions |                  |


Scenario: Check that if in project added T&C ,this is logged in activity (added in edit mode) (Project Teams)
Meta:@gdam
     @projects
Given I created the agency 'ADATCADDIAP_A5' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| ADATCADDIAP_E5 | agency.admin | ADATCADDIAP_A5 |
And logged in with details of 'ADATCADDIAP_E5'
And I am on the T&C page
And enabled current terms and conditions for projects on opened T&C page
When login with details of 'ADATCADDIAP_E5'
And create new project with following fields:
| FieldName          | FieldValue       |
| Name               | ADADDIAP_EATC_P5 |
| Media type         | Broadcast        |
| Start date         | Today            |
| End date           | Tomorrow         |
| Terms & Conditions | test             |
And accept agency Terms and Conditions
And edit following Terms And Condition to 'test 2' on project 'ADADDIAP_EATC_P5'
And click on element 'SaveButton'
And login with details of 'ADATCADDIAP_E5'
And go to project list page
And click by project name 'ADADDIAP_EATC_P5'
And accept agency Terms and Conditions
And go to project 'ADADDIAP_EATC_P5' teams page
And wait for '3' seconds
And refresh the page
Then I 'should' see following activities in 'Recent Activity' section on Project Team page:
| UserName       | Message                             | Value                |
| ADATCADDIAP_E5 | created project                     | ADADDIAP_EATC_P5     |
| ADATCADDIAP_E5 | created project Terms & Conditions  | Terms and Conditions |
| ADATCADDIAP_E5 | accepted project Terms & Conditions | Terms and Conditions |
| ADATCADDIAP_E5 | updated project                     | ADADDIAP_EATC_P5     |
| ADATCADDIAP_E5 | updated project Terms & Conditions  | Terms and Conditions |
| ADATCADDIAP_E5 | accepted project Terms & Conditions | Terms and Conditions |