Feature:          Move Presentations into top level menu
Narrative:
In order to
As a              AgencyAdmin
I want to         check that Presentations is moved into top level menu


Scenario: Check that Presentations module appears on top menu for admin and non admin users and redirects the user to all presentations page when it is clicked
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| MPTM_S01 | agency.admin |streamlined_library,library,presentations|
| MPTM_S02 | agency.user |streamlined_library,library,presentations|
And logged in with details of 'MPTM_S01'
When I click on 'Presentations' on top menu
Then I 'should' be on 'Presentations' PageNEWLIB
When I login with details of 'MPTM_S02'
And I click on 'Presentations' on top menu
Then I 'should' be on 'Presentations' PageNEWLIB

Scenario: Check that Presentations module do not appear on top menu when a user do not have permission to presentations
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| MPTM_S03 | agency.admin |streamlined_library,library|
And logged in with details of 'MPTM_S03'
Then I 'should not' see 'Presentations' on top menu

Scenario: Check that Tasks menu appears on top menu when tasks moduled is enabled at BU and user level
Meta:@gdam
@library
Given I created the following agency:
| Name    | A4User        | Application Access     |
| MPTM_A1 | DefaultA4User | streamlined_library,tasks   |
And created users with following fields:
| Email   | Role         | AgencyUnique |  Access      |
| MPTM_S04 | agency.admin | MPTM_A1      | streamlined_library,tasks |
And logged in with details of 'MPTM_S04'
When go to the Library page for collection 'Everything'NEWLIB
When I click on 'Tasks' on top menu
Then I 'should' see the page navigated to 'axiom-sky.adstream.com/jobs'

