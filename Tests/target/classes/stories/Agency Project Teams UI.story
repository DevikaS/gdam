!--NGN-4779 NGN-981
Feature:          Agency Project Teams UI
Narrative:
In order to
As a              AgencyAdmin
I want to         Check UI behavior of Agency Project Teams

Scenario: Check that just created Agency Project Team can be visible for another agency admin
!-- FAB-781 5.7Bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role         |
| <AdminEmail> | DefaultAgency | agency.admin |
| <UserEmail>  | DefaultAgency | agency.user  |
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with role '<ProjectRole>' on Users list page
And login with details of '<AdminEmail>'
And I go to User list page
Then I 'should' see user '<UserEmail>' in project team '<ProjectTeamName>' with role '<ProjectRole>'

Examples:
| AdminEmail  | UserEmail   | ProjectRole  | ProjectTeamName |
| A_APT_S03_1 | U_APT_S03_1 | Project User | PT_APT_S03      |


Scenario: Check that just created Agency Project Team can be visible for all users in current agency
Meta: @skip
      @gdam
Given I created users with following fields:
| Email            | Agency        | Role       |
| <viewerUserMail> | DefaultAgency | <userRole> |
And I created '<projectName>' project
And I added users '<viewerUserMail>' to project '<projectName>' team with role '<ProjectRole>' expired '11.11.2014'
When I add '<viewerUserMail>' users to '<ProjectTeamName>' project team with role '<ProjectRole>' on Users list page
And login with details of '<viewerUserMail>'
And I open [Add Agency Team] pop up for project '<projectName>'
Then I should see that '<ProjectTeamName>' agency team is available in [Select Agency Project Team] drop down

Examples:
| viewerUserMail | ProjectRole   | ProjectTeamName | projectName | userRole    |
| A_APT_S04_1    | project.admin | PT_APT_S04_1    | P_APT_S04_1 | guest.user  |
| A_APT_S04_2    | project.admin | PT_APT_S04_2    | P_APT_S04_2 | agency.user |


Scenario: Check that just created Agency Project Team can be editable by another Agency Admin
!--FAB-781 5.7bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role         |
| <UserEmail2> | DefaultAgency | agency.user  |
| <UserEmail1> | DefaultAgency | agency.user  |
| <AdminEmail> | DefaultAgency | agency.admin |
When I add '<UserEmail1>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And login with details of '<AdminEmail>'
And I add '<UserEmail2>' users to '<ProjectTeamName>' project team with default role '<ProjectRole2>' on Users list page
Then I 'should' see user '<UserEmail2>' in project team '<ProjectTeamName>' with role '<ProjectRole2>'
And I 'should' see user '<UserEmail1>' in project team '<ProjectTeamName>' with role '<ProjectRole>'

Examples:
| AdminEmail  | UserEmail1  | UserEmail2  | ProjectRole  | ProjectRole2        | ProjectTeamName |
| A_APT_S05_1 | U_APT_S05_1 | U_APT_S05_2 | Project User | Project Contributor | PT_APT_S05      |



Scenario: Check that after re-adding user to agency team with new role,in UI should be displayed old role
!-- FAB-781 5.7Bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role         |
| U_APT_S08_1  | DefaultAgency | agency.user  |
When I add 'U_APT_S08_1' users to 'PT_APT_S08_1' project team with default role 'Project User' on Users list page
And I add 'U_APT_S08_1' users to 'PT_APT_S08_1' project team with default role 'Project Contributor' on Users list page
Then I 'should' see user 'U_APT_S08_1' in project team 'PT_APT_S08_1' with role 'Project User'


Scenario: Check that several Users can be added to Agency Project Team
!--FAB-781 5.7bug
Meta:@gdam
Given I created users with following fields:
| Email        | Agency        | Role         |
| <UserEmail1> | DefaultAgency | agency.user  |
| <UserEmail2> | DefaultAgency | agency.user  |
| <UserEmail3> | DefaultAgency | agency.user  |
When I add '<Users>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
Then I 'should' see user '<UserEmail1>' in project team '<ProjectTeamName>' with role '<ProjectRole>'
And I 'should' see user '<UserEmail2>' in project team '<ProjectTeamName>' with role '<ProjectRole>'
And I 'should' see user '<UserEmail3>' in project team '<ProjectTeamName>' with role '<ProjectRole>'

Examples:
| UserEmail1  | UserEmail2    | UserEmail3    | ProjectRole         | ProjectTeamName | Users                                   |
| U_APT_S09_1 | U_APT_S09_1_1 | U_APT_S09_1_2 | Project User        | PT_APT_S09_1    | U_APT_S09_1,U_APT_S09_1_1,U_APT_S09_1_2 |


Scenario: Check that User can be added to several Agency Project Teams with different roles
!--FAB-781  5.7bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role         |
| <UserEmail> | DefaultAgency | agency.user  |
When I add '<UserEmail>' users to '<ProjectTeamName1>' project team with default role '<ProjectRole1>' on Users list page
And I add '<UserEmail>' users to '<ProjectTeamName2>' project team with default role '<ProjectRole2>' on Users list page
Then I 'should' see user '<UserEmail>' in project team '<ProjectTeamName1>' with role '<ProjectRole1>'
And I 'should' see user '<UserEmail>' in project team '<ProjectTeamName2>' with role '<ProjectRole2>'

Examples:
| UserEmail   | ProjectRole1     | ProjectRole2      | ProjectTeamName1 | ProjectTeamName2 |
| U_APT_S10_1 | Project User     | Project Observer  | PT_APT_S10_1_1   | PT_APT_S10_1_2   |
| U_APT_S10_2 | Project Observer | Project Observer  | PT_APT_S10_2_1   | PT_APT_S10_2_2   |


Scenario: Check that 'Select all' checkbox works correctly
Meta:@gdam
     @projects
Given I created users with following fields:
| Email         | Agency        | Role         |
| U_APT_S12_1_1 | DefaultAgency | agency.user  |
| U_APT_S12_1_2 | DefaultAgency | agency.user  |
| U_APT_S12_1_3 | DefaultAgency | agency.user  |
When I add '<Users>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And I check 'Select All' checkbox on Users List page
Then I should see all visible users are selected

Examples:
| ProjectRole  | ProjectTeamName | Users                                     |
| Project User | PT_APT_S12_1    | U_APT_S12_1_1,U_APT_S12_1_2,U_APT_S12_1_3 |

Scenario: Check that Agency Project Team can be deleted
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And I delete agency project team '<ProjectTeamName>'
Then I 'should not' see '<ProjectTeamName>' 'project' team on Users list page

Examples:
| ProjectRole  | ProjectTeamName | UserEmail     |
| Project User | PT_APT_S14_1    | U_APT_S14_1_1 |


Scenario: Check that new Agency Project Team with name of just deleted one can be created and will be different
!--FAB-781  5.7bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
When I add '<UserEmail1>' users to '<ProjectTeamName>' project team with default role '<ProjectRole1>' on Users list page
And I delete agency project team '<ProjectTeamName>'
And I add '<UserEmail2>' users to '<ProjectTeamName>' project team with default role '<ProjectRole2>' on Users list page
Then I 'should' see user '<UserEmail2>' in project team '<ProjectTeamName>' with role '<ProjectRole2>'

Examples:
| UserEmail1    | UserEmail2    | ProjectRole1 | ProjectRole2        | ProjectTeamName |
| U_APT_S15_1_1 | U_APT_S15_1_2 | Project User | Project Contributor | PT_APT_S15_1    |


Scenario: Check that User can be removed from Agency Project Team
!--FAB-781  5.7bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
When I add '<Users>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And I remove users '<UserEmail1>' from 'project' team '<ProjectTeamName>'
Then I 'should' see user '<UserEmail2>' in project team '<ProjectTeamName>' with role '<ProjectRole>'
And I 'should not' see user '<UserEmail1>' in project team '<ProjectTeamName>' with role '<ProjectRole>'

Examples:
| UserEmail1    | UserEmail2    | ProjectRole  | ProjectTeamName | Users                       |
| U_APT_S16_1_1 | U_APT_S16_1_2 | Project User | PT_APT_S16_1    | U_APT_S16_1_1,U_APT_S16_1_2 |


Scenario: Check that if delete last user from Agency Project Team team should not be deleted
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And I remove users '<UserEmail>' from 'project' team '<ProjectTeamName>'
Then I 'should' see '<ProjectTeamName>' 'project' team on Users list page
When I select agency project team '<ProjectTeamName>'
Then I should see users count is '0' in this agency project team

Examples:
| UserEmail     | ProjectRole  | ProjectTeamName |
| U_APT_S17_1_1 | Project User | PT_APT_S17_1    |


Scenario: Check that just removed User from Agency Project Team can be added again the same and different roles
!--FAB-781  5.7bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole1>' on Users list page
And I remove users '<UserEmail>' from 'project' team '<ProjectTeamName>'
And I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole2>' on Users list page
Then I 'should' see user '<UserEmail>' in project team '<ProjectTeamName>' with role '<ProjectRole2>'

Examples:
| UserEmail   | ProjectRole1     | ProjectRole2     | ProjectTeamName |
| U_APT_S18_1 | Project User     | Project Observer | PT_APT_S18_1    |


Scenario: Check that 'Users details' of Agency Project Team user contains all projects User has access
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole1>' on Users list page
And create '/F_APT19' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT19' page
And I open Share window from popup menu for folder '/F_APT19' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And fill Share popup of project folder by following role 'Project Contributor'
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And click element 'Add' on page 'ShareWindow'
And I go to User list page
And I open '<UserEmail>' user menu
Then I should see the following projects on Projects tab for opened user details on Users list page:
| ProjectName   | Condition |
| <projectName> | should    |

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S19_1 | PT_APT_S19_1    | Project User | P_APT_S19_1 |

Scenario: Check that changing Agency Project Teams don't affect created projects
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail1>' users to '<ProjectTeamName>' project team with default role '<ProjectRole1>' on Users list page
And create '/F_APT20' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT20' page
And I open Share window from popup menu for folder '/F_APT20' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And fill Share popup of project folder by following role 'Project User'
And click element 'Add' on page 'ShareWindow'
And I remove users '<UserEmail1>' from 'project' team '<ProjectTeamName>'
And I add '<UserEmail1>' users to '<ProjectTeamName>' project team with default role '<ProjectRole2>' on Users list page
And I add '<UserEmail2>' users to '<ProjectTeamName>' project team with default role '<ProjectRole2>' on Users list page
Then I 'should' see user '<UserEmail1>' name in teams of project '<projectName>'
And should see user '<UserEmail1>' has role '<ProjectRole1>' on project '<projectName>' team page
And I 'should not' see user '<UserEmail2>' name in teams of project '<projectName>'

Examples:
| UserEmail1  | UserEmail2  | ProjectTeamName | ProjectRole1 | ProjectRole2     | projectName |
| U_APT_S20_1 | U_APT_S20_2 | PT_APT_S20_1    | Project User | Project Observer | P_APT_S20_1 |


Scenario: Check that removing Agency Project Teams don't affect created projects
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT21' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT21' page
And I open Share window from popup menu for folder '/F_APT21' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And fill Share popup of project folder by following role '<ProjectRole>'
And click element 'Add' on page 'ShareWindow'
And I delete agency project team '<ProjectTeamName>'
Then I 'should' see user '<UserEmail>' name in teams of project '<projectName>'
And should see user '<UserEmail>' has role '<ProjectRole>' on project '<projectName>' team page

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S21_1 | PT_APT_S21_1    | Project User | P_APT_S21_1 |


Scenario: Check that newly created project roles available while creation Agency Project Team
Meta:@gdam
     @projects
Given I created following roles:
| RoleName     | Group   | Agency        |
| CustomRole22 | project | DefaultAgency |
And I created users with following fields:
| Email       | Agency        |
| U_APT_S22_1 | DefaultAgency |
When I add user 'U_APT_S22_1' to 'PT_APT_S22_1' project team with role 'CustomRole22' on Users list page
Then I 'should' see user 'U_APT_S22_1' in project team 'PT_APT_S22_1' with role 'CustomRole22'

Scenario: Check that modifying project's team doesn't affect Agency Project Team
!--FAB-781  5.7bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail1>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
When I add '<UserEmail2>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT23' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT23' page
And I open Share window from popup menu for folder '/F_APT23' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And fill Share popup of project folder by following role 'Project Contributor'
And click element 'Add' on page 'ShareWindow'
And I remove user '<UserEmail1>' from project '<projectName>' team page
And I go to User list page
Then I 'should' see user '<UserEmail1>' in project team '<ProjectTeamName>' with role '<ProjectRole>'
And I 'should' see user '<UserEmail2>' in project team '<ProjectTeamName>' with role '<ProjectRole>'

Examples:
| UserEmail1  | UserEmail2  | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S23_1 | U_APT_S23_2 | PT_APT_S23_1    | Project User | P_APT_S23_1 |

Scenario: Check that changing permissions in project not affect Agency Project Team
!--FAB-781 bug
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail1>' users to '<ProjectTeamName>' project team with default role '<ProjectRole1>' on Users list page
And add '<UserEmail2>' users to '<ProjectTeamName>' project team with default role '<ProjectRole2>' on Users list page
And create '/F_APT24' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT24' page
And I open Share window from popup menu for folder '/F_APT24' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And fill Share popup of project folder by following role 'Project Contributor'
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And click element 'Add' on page 'ShareWindow'
And refresh the page
And assign role 'Project Observer' in user '<UserEmail1>' permissions popup for folder '/F_APT24' on project '<projectName>' team
And go to User list page
Then I 'should' see user '<UserEmail1>' in project team '<ProjectTeamName>' with role '<ProjectRole1>'
And I 'should' see user '<UserEmail2>' in project team '<ProjectTeamName>' with role '<ProjectRole2>'

Examples:
| UserEmail1  | UserEmail2  | ProjectTeamName | ProjectRole1 | ProjectRole2     | projectName |
| U_APT_S24_1 | U_APT_S24_2 | PT_APT_S24_1    | Project User | Project Observer | P_APT_S24_1 |


Scenario: Check that adding Agency Project Team to project will cause adding all teams of users
Meta: @gdam
      @projects
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail1>' users to '<ProjectTeamName1>' project team with default role '<ProjectRole>' on Users list page
And I add '<UserEmail1>' users to '<ProjectTeamName2>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT25' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT25' page
And I open Share window from popup menu for folder '/F_APT25' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName1>' with expiration date ''
And select team template with name '<ProjectTeamName1>' in Share popup of project folder
And fill Share popup of project folder by following role 'Project Contributor'
And click element 'Add' on page 'ShareWindow'
Then I 'should' see project team '<ProjectTeamName1>' in agency project teams list for project '<projectName>'
And I 'should not' see project team '<ProjectTeamName2>' in agency project teams list for project '<projectName>'

Examples:
| UserEmail1  | UserEmail2  | ProjectTeamName1 | ProjectTeamName2 | ProjectRole  | projectName |
| U_APT_S25_1 | U_APT_S25_2 | PT_APT_S25_1     | PT_APT_S25_2     | Project User | P_APT_S25_1 |


Scenario: Check that 'manage role permissions' for user added to project via Agency Project Team works for roles
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT26' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT26' page
And I open Share window from popup menu for folder '/F_APT26' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And fill Share popup of project folder by following role '<ProjectRole1>'
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And click element 'Add' on page 'ShareWindow'
And I change role to '<ProjectRole2>' from agency project team '<ProjectTeamName>' in user '<UserEmail>' permissions popup for folder '/F_APT26' on project '<projectName>' team
Then I should see user '<UserEmail>' has role '<ExpectedRole>' on project '<projectName>' team page

Examples:
| UserEmail   | ProjectTeamName | ProjectRole1        | projectName | ProjectRole2     |ExpectedRole
| U_APT_S26_1B | PT_APT_S26_1B    | Project Contributor | P_APT_S26_1B | Project Observer |Project Contributor,Project Observer|

Scenario: Check that 'manage role permissions' for user added to project via Agency Project Team works for folder structure
Meta: @gdam
      @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| U_APT_S27_1A | DefaultAgency | agency.user |
And I created 'P_APT_S27_1A' project
And created in 'P_APT_S27_1A' project next folders:
| folder     |
| /F_APT27_1A |
| /F_APT27_2A |
When I add 'U_APT_S27_1A' users to 'PT_APT_S27_1A' project team with default role '<ProjectRole>' on Users list page
And go to project 'P_APT_S27_1A' folder '/F_APT27_1A' page
And I open Share window from popup menu for folder '/F_APT27_1A' on project 'P_APT_S27_1A'
And fill Share popup of project folder by following team 'PT_APT_S27_1A' with expiration date ''
And fill Share popup of project folder by following role 'Project Contributor'
And select team template with name 'PT_APT_S27_1A' in Share popup of project folder
And click element 'Add' on page 'ShareWindow'
And I open permissions from agency project team 'PT_APT_S27_1A' for user 'U_APT_S27_1A' in project 'P_APT_S27_1A'
And I select folder '/F_APT27_2A' on permissions pop up
And I select default role 'Project User' on permissions pop up
And click element 'Save' on page 'ManagePermissionsPopUp'
And login with details of 'U_APT_S27_1A'
And go to project 'P_APT_S27_1A' files page
Then I 'should' see following folders in 'P_APT_S27_1A' project:
| folder     |
| /F_APT27_1A |
| /F_APT27_2A |

Scenario: Check that remove user from Agency Project Team list of project removes also it from 'All users' list
!--COnfirmed with Maria that this a issue - New logged - FAB-461
Meta: @bug
      @gdam
      @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT28' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT28' page
And I open Share window from popup menu for folder '/F_APT28' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And click element 'Add' on page 'ShareWindow'
And fill Share popup of project folder by following role 'Project Contributor'
And I remove user '<UserEmail>' form project '<projectName>' team page when agency project team '<ProjectTeamName>' was selected
Then I 'should not' see user '<UserEmail>' name in teams of project '<projectName>'

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S28_1 | PT_APT_S28_1    | Project User | P_APT_S28_1 |


Scenario: Check that remove all users of Agency Project Team from 'All' list removes also Agency Project Team from project
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| U_APT_S29_1 | DefaultAgency | agency.user |
| U_APT_S29_2 | DefaultAgency | agency.user |
And created 'P_APT_S29_1' project
When I add 'U_APT_S29_1,U_APT_S29_2' users to 'PT_APT_S29_1' project team with default role 'Project User' on Users list page
And add 'U_APT_S29_1' users to 'PT_APT_S29_2' project team with default role 'Project User' on Users list page
And create '/F_APT29' folder for project 'P_APT_S29_1'
And go to project 'P_APT_S29_1' folder '/F_APT29' page
And open Share window from popup menu for folder '/F_APT29' on project 'P_APT_S29_1'
And fill Share window of project folder for following team templates :
| TeamTemplate |
| PT_APT_S29_1 |
And fill Share window of project folder for following team templates :
| TeamTemplate |
| PT_APT_S29_2 |
And fill Share popup of project folder by following role 'Project Contributor'
And click element 'Add' on page 'ShareWindow'
And go to project 'P_APT_S29_1' teams page
And wait for '6' seconds
And remove user 'U_APT_S29_1' from project 'P_APT_S29_1' team page
And remove user 'U_APT_S29_2' from project 'P_APT_S29_1' team page
And refresh the page
Then I 'should not' see user 'U_APT_S29_1' name in teams of project 'P_APT_S29_1'
And 'should not' see user 'U_APT_S29_2' name in teams of project 'P_APT_S29_1'
And 'should not' see project team 'PT_APT_S29_1' in agency project teams list for project 'P_APT_S29_1'
And 'should not' see project team 'PT_APT_S29_2' in agency project teams list for project 'P_APT_S29_1'

Scenario: Check that all users added to project by adding Agency Project Team appears in 'All' section
Meta:@gdam
     @projects
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UsersEmails>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT28' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT28' page
And I open Share window from popup menu for folder '/F_APT28' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And fill Share popup of project folder by following role 'Project Contributor'
And click element 'Add' on page 'ShareWindow'
Then I 'should' see user '<UserEmail1>' name in teams of project '<projectName>'
And I 'should' see user '<UserEmail2>' name in teams of project '<projectName>'

Examples:
| UserEmail1  | UserEmail2  | ProjectTeamName | ProjectRole  | projectName | UsersEmails             |
| U_APT_S30_1 | U_APT_S30_2 | PT_APT_S30_1    | Project User | P_APT_S30_1 | U_APT_S30_1,U_APT_S30_2 |


Scenario: Check that several Agency Project Teams can be added to project
Meta:@gdam
     @projects
!--scenario will pass once FAB-591 is fixed
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail1>' users to '<ProjectTeamName1>' project team with default role '<ProjectRole>' on Users list page
And I add '<UserEmail2>' users to '<ProjectTeamName2>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT31' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT31' page
And I open Share window from popup menu for folder '/F_APT31' on project '<projectName>'
And I fill Share window of project folder for following team templates :
| TeamTemplate |
| PT_APT_S31_1 |
And I fill Share window of project folder for following team templates :
| TeamTemplate |
| PT_APT_S31_2 |
And click element 'Add' on page 'ShareWindow'
Then I 'should' see project team '<ProjectTeamName1>' in agency project teams list for project '<projectName>'
And I 'should' see project team '<ProjectTeamName2>' in agency project teams list for project '<projectName>'

Examples:
| UserEmail1  | UserEmail2  | ProjectTeamName1 | ProjectTeamName2 | ProjectRole  | projectName |
| U_APT_S31_1 | U_APT_S31_2 | PT_APT_S31_1     | PT_APT_S31_2     | Project User | P_APT_S31_1 |

Scenario: Check that Agency Project Team can be added from Team tab
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT34' folder for project '<projectName>'
And I add agency project team '<ProjectTeamName>' for folder 'F_APT34' in the project '<projectName>'
Then I 'should' see project team '<ProjectTeamName>' in agency project teams list for this project
And I 'should' see user '<UserEmail>' name in teams of project '<projectName>'

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S34_1 | PT_APT_S34_1    | Project User | P_APT_S34_1 |


Scenario: Check that Agency Project Team can be added from folder's 'Share' popup
Meta: @gdam
      @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT35' folder for project '<projectName>'
And I open Share window from popup menu for folder '/F_APT35' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And fill Share popup of project folder by following role 'Project Contributor'
And click element 'Add' on page 'ShareWindow'
Then I 'should' see project team '<ProjectTeamName>' in agency project teams list for project '<projectName>'
And I 'should' see user '<UserEmail>' name in teams of project '<projectName>'

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S35_1 | PT_APT_S35_1    | Project User | P_APT_S35_1 |


Scenario: Check that Agency Project Team can be added using 'Share' button
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT36' folder for project '<projectName>'
And go to project '<projectName>' folder 'root' page
And select folder '/F_APT36' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And fill Share popup of project folder by following role 'Project Contributor'
And click element 'Add' on page 'ShareWindow'
Then I 'should' see project team '<ProjectTeamName>' in agency project teams list for project '<projectName>'
And I 'should' see user '<UserEmail>' name in teams of project '<projectName>'

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S36_1 | PT_APT_S36_1    | Project User | P_APT_S36_1 |


Scenario: Check that Agency Project Team can be removed from 'Team' tab
Meta: @gdam
     @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT37' folder for project '<projectName>'
And go to project '<projectName>' folder 'root' page
And select folder '/F_APT37' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And fill Share popup of project folder by following role 'Project Contributor'
And click element 'Add' on page 'ShareWindow'
And I remove user '<UserEmail>' form project '<projectName>' team page when agency project team '<ProjectTeamName>' was selected
Then I 'should not' see user '<UserEmail>' name in teams of project '<projectName>'

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S37_1 | PT_APT_S37_1    | Project User | P_APT_S37_1 |


Scenario: Check that Agency Project Team can be removed using 'Share' button
!--COnfirmed with Maria that this a issue - New logged - FAB-461
Meta: @bug
      @gdam
           @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT38' folder for project '<projectName>'
And go to project '<projectName>' folder 'root' page
And select folder '/F_APT38' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And I click element 'Add' on page 'ShareWindow'
And go to project '<projectName>' folder 'root' page
And open Share window using 'Share' button for current on opened files page
And I click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
And I remove user '<UserEmail>' from users tab on Share window
And I click 'OK' on the alert
Then I 'should not' see user '<UserEmail>' name in teams of project '<projectName>'

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S38_1 | PT_APT_S38_1    | Project User | P_APT_S38_1 |


Scenario: Check that Agency Project Team can be removed from folder's 'Share'
!--COnfirmed with Maria that this a issue - New logged - FAB-461
Meta: @bug
      @gdam
      @projects
Given I created users with following fields:
| Email       | Agency        | Role        |
| <UserEmail> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail>' users to '<ProjectTeamName>' project team with default role '<ProjectRole>' on Users list page
And create '/F_APT39' folder for project '<projectName>'
And go to project '<projectName>' folder 'root' page
And select folder '/F_APT39' on project files page
And open Share window using 'Share' button for current on opened files page
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And I click element 'Add' on page 'ShareWindow'
And I open Share window from popup menu for folder '/F_APT39' on project '<projectName>'
And I click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
And I remove user '<UserEmail>' from users tab on Share window
And I click 'OK' on the alert
Then I 'should not' see user '<UserEmail>' name in teams of project '<projectName>'

Examples:
| UserEmail   | ProjectTeamName | ProjectRole  | projectName |
| U_APT_S39_1 | PT_APT_S39_1    | Project User | P_APT_S39_1 |

Scenario: Check that changing permissions in project not affect Agency Project Team
!--FAB-781 bug
Meta: @gdam
      @projects
Given I created users with following fields:
| Email        | Agency        | Role        |
| <UserEmail1> | DefaultAgency | agency.user |
| <UserEmail2> | DefaultAgency | agency.user |
And I created '<projectName>' project
When I add '<UserEmail1>' users to '<ProjectTeamName>' project team with default role '<ProjectRole1>' on Users list page
And add '<UserEmail2>' users to '<ProjectTeamName>' project team with default role '<ProjectRole2>' on Users list page
And create '/F_APT24' folder for project '<projectName>'
And go to project '<projectName>' folder '/F_APT24' page
And I open Share window from popup menu for folder '/F_APT24' on project '<projectName>'
And fill Share popup of project folder by following team '<ProjectTeamName>' with expiration date ''
And fill Share popup of project folder by following role 'Project Contributor'
And select team template with name '<ProjectTeamName>' in Share popup of project folder
And click element 'Add' on page 'ShareWindow'
And refresh the page
And assign role 'Project Observer' in user '<UserEmail1>' permissions popup for folder '/F_APT24' on project '<projectName>' team
And go to User list page
Then I 'should' see user '<UserEmail1>' in project team '<ProjectTeamName>' with role '<ProjectRole1>'
And I 'should' see user '<UserEmail2>' in project team '<ProjectTeamName>' with role '<ProjectRole2>'


Examples:
|UserEmail1	|UserEmail2	|ProjectTeamName	|ProjectRole1	|ProjectRole2	|projectName	|
|U_APT_S24_1	|U_APT_S24_2	|PT_APT_S24_1	|Project User	|Project Observer	|P_APT_S24_1	|
