!--NGN-1334
Feature:          Project Teams - Relations with Project Owner (NGN-1020)
Narrative:
In order to
As a              AgencyAdmin
I want to         Check  Project:Team

Scenario: User should appears on team page after adding last as owner
Meta:@gdam
@projects
Given I created 'PTRU1' User
And added user 'PTRU1' to Address book
And created 'PTRP1' project
When I edit the following fields for 'PTRP1' project:
| Name  | Administrators |
| PTRP1 | PTRU1          |
And click on element 'SaveButton'
And I go to project 'PTRP1' teams page
Then I 'should' see user 'PTRU1' name in teams of project 'PTRP1'


Scenario: User should dissapears from team page after removing last from owners
Meta:@gdam
@projects
Given I created following users:
| User Name |
| PTRU2_1   |
| PTRU2_2   |
And the following projects were created:
| Name  | Administrators  |
| PTRP2 | PTRU2_1,PTRU2_2 |
When I remove administrator 'PTRU2_2' from project 'PTRP2'
And click on element 'SaveButton'
And I go to project 'PTRP2' teams page
Then I 'should not' see user 'PTRU2_2' name in teams of project 'PTRP2'


Scenario: User should dissapears from settings tab after changeng permissions from team tab
Meta:@skip
     @gdam
!--NGN-16619
Given I created following users:
| User Name |
| PTRU3_1   |
| PTRU3_2   |
And created 'PTRR3' role in 'project' group for advertiser 'DefaultAgency'
And the following projects were created:
| Name  | Administrators  |
| PTRP3 | PTRU3_1,PTRU3_2 |
And I am on project 'PTRP3' teams page
When I open user 'PTRU3_2' permissions on project 'PTRP3' team page
And select role 'PTRR3' in user 'PTRU3_2' permissions popup for project 'PTRP3' team
And click element 'AddButton' on page 'AddTeamUserPopUp'
And I refresh the page
And I open project 'PTRP3' settings page
Then I 'should not' see administrator 'PTRU3_2' on project 'PTRP3' settings tab