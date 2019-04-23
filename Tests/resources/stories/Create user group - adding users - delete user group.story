!--NGN-46 NGN-197 NGN-286
Feature:          Create user group - adding users - delete user group
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creation of user group, adding users into user groups, deletion user groups

Scenario: Check that group created when user added into unexisting library team
Meta:@gdam
	  @library
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
When I add '<UserEmail>' users to '<LibraryTeamName>' library team on Users list page
Then I 'should' see '<LibraryTeamName>' 'library' team on Users list page

Examples:
| UserEmail  | LibraryTeamName             |
| U_UG_S01_2 | LT_UG_S01_GroupWithLongName |


Scenario: Check that group created when user added into unexisting project team
Meta:@gdam
	  @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And created '<ProjectRole>' role with 'project.read' permissions in 'project' group for advertiser 'DefaultAgency'
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with role '<ProjectRole>' on Users list page
Then I 'should' see '<ProjectTeamName>' 'project' team on Users list page

Examples:
| UserEmail  | ProjectRole | ProjectTeamName             |
| U_UG_S02_2 | PR_UG_S02_2 | PT_UG_S02_GroupWithLongName |