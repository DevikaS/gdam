!-- NGN-11886
Feature:          BU admin hides unused Roles
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check hiding roles for BU


Scenario: Check that if role is hidden It becomes hidden in BU Admin > Roles tab
Meta:@gdam
     @globaladmin
Given I created '<RoleName>' role in 'global' group for advertiser 'DefaultAgency'
And I am on roles page
When I click role '<RoleName>' on roles list
And click element 'HideRoleCheckbox' on page 'Roles'
And set show hidden roles checkbox to state '<ShowHidden>' on current role page
Then I '<Should>' see '<RoleName>' role on BU admin roles page

Examples:
| RoleName | ShowHidden | Should     |
| Buahurr1 | off        | should not |
| Buahurr2 | on         | should     |


Scenario: Check that if user hide default global/project/libary role, it won't be hidden for another BU
Meta:@gdam
     @globaladmin
Given I created the agency 'BUAHURA3' with default attributes
And created users with following fields:
| Email    | Role         | Agency   |
| BUAHURU3 | agency.admin | BUAHURA3 |
And logged in with details of 'BUAHURU3'
And I am on roles page
When I click role 'Agency admin' on roles list
And click element 'HideRoleCheckbox' on page 'Roles'
And login with details of 'AgencyAdmin'
And go to roles page
And set show hidden roles checkbox to state 'off' on current role page
Then I 'should' see 'Agency admin' role on BU admin roles page


Scenario: Check that if custom global role was hidden, it won't be displayed on user create user page
Meta:@gdam
     @globaladmin
Given I created 'BUAHURR4' role in 'global' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR4' to state 'on'
And I am on Create New User page
And filled following fields on user opened details page:
| Role     |
| BUAHURR4 |
Then I 'should' see red inputs on page


Scenario: Check that if custom global role was hidden, it won't be displayed on user edit user page
Meta:@gdam
     @globaladmin
Given I created 'BUAHURR5' role in 'global' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR5' to state 'on'
And created users with following fields:
| Email    | Role        |
| BUAHURU5 | agency.user |
And I am on user 'BUAHURU5' details page
And I filled following fields on user 'BUAHURU5' details page:
| Role     |
| BUAHURR5 |
Then I 'should' see red inputs on page


Scenario: Check that user could be created with unhidden role
Meta:@gdam
     @globaladmin
Given I created 'BUAHURR6' role in 'global' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR6' to state 'on'
And set hide status for role 'BUAHURR6' to state 'off'
And I am on Create New User page
When create user with following fields:
| Email    | Role     |
| BUAHURU6 | BUAHURR6 |
Then I 'should' see 'BUAHURU6' in User list

Scenario: Check that if custom project role was hidden, it won't be displayed on project team page Add User popup
Meta:@gdam
     @projects
Given I created 'BUAHURR7' role in 'project' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR7' to state 'on'
And created users with following fields:
| Email    | Role        |
| BUAHURU7 | agency.user |
And created 'BUAHURP7' project
And created '/BUAHURF7' folder for project 'BUAHURP7'
And I am on project 'BUAHURP7' teams page
And clicked element 'AddMemberButton' on page 'TeamsPage'
And clicked element 'AddMemberUserItem' on page 'TeamsPage'
Then I 'should not' see role 'BUAHURR7' in roles list of add user to project 'BUAHURP7' team popup


Scenario: Check that if custom project role was hidden, it won't be displayed on project team page manage permissions popup
Meta:@gdam
     @projects
Given I created 'BUAHURR8' role in 'project' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR8' to state 'on'
And created users with following fields:
| Email    | Role        |
| BUAHURU8 | agency.user |
And created 'BUAHURP8' project
And created '/BUAHURF8' folder for project 'BUAHURP8'
And added users 'BUAHURU8' to project 'BUAHURP8' team folders '/BUAHURF8' with role 'project.user' expired '12.12.2021'
When I open user 'BUAHURU8' permissions on project 'BUAHURP8' team page
Then I 'should not' see the role 'BUAHURR8' in the role list


Scenario: Check that if custom project role was hidden, it won't be displayed on user share folder popup
Meta:@gdam
     @projects
Given I created 'BUAHURR9' role in 'project' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR9' to state 'on'
And created users with following fields:
| Email    | Role        |
| BUAHURU9 | agency.user |
And created 'BUAHURP9' project
And created '/BUAHURF9' folder for project 'BUAHURP9'
And opened share popup in project 'BUAHURP9' for folder 'BUAHURF9' from root project
When I fill Share popup of project folder by following user 'BUAHURU9'
And I fill Share popup of project folder by following role 'BUAHURR9'
Then I 'should' see red inputs on page


Scenario: Check that if custom library role was hidden, it won't be displayed on BU Admin > Collections add user popup
Meta: @bug
      @gdam
      @library
!--FAB-469
Given I created 'BUAHURR10' role in 'library' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR10' to state 'on'
And created users with following fields:
| Email     | Role        |
| BUAHURU10 | agency.user |
And created 'BUAHURC10' category
And on collection 'BUAHURC10' on administration area collections page
Then I 'should not' see the following roles for category 'BUAHURC10' in dropdown box of 'Limit User' popup:
| RoleName  |
| BUAHURR10 |


Scenario: Check that if custom library role was hidden, it won't be displayed on BU Admin > Collections add user/team pages
Meta:@gdam
     @library
Given I created 'BUAHURR11' role in 'library' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR11' to state 'on'
And created users with following fields:
| Email     | Role        |
| BUAHURU11 | agency.user |
And created 'BUAHURC11' category
And on collection 'BUAHURC11' on administration area collections page


Scenario: Check that project could be shared with unhidden project role
Meta:@gdam
     @projects
Given I created 'BUAHURR12' role in 'project' group for advertiser 'DefaultAgency'
And set hide status for role 'BUAHURR12' to state 'on'
And set hide status for role 'BUAHURR12' to state 'off'
And created users with following fields:
| Email    | Role        |
| BUAHURU12 | agency.user |
And created 'BUAHURP12' project
And created '/BUAHURF12' folder for project 'BUAHURP12'
And I am on project 'BUAHURP12' teams page
When I add user 'BUAHURU12' into project 'BUAHURP12' team with role 'BUAHURR12' expired '12.12.2021' for folder on popup '/BUAHURF12'
And login with details of 'BUAHURU12'
Then I 'should' see project 'BUAHURP12' on project list page