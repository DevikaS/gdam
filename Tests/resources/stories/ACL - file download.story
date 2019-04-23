!--NGN-3227
Feature:          ACL - file download
Narrative:
In order to
As a              AgencyAdmin
I want to         Check ACL in downloading file

Scenario: Check that 'file.download' permission is available only for project roles
Meta: @skip
      @gdam
Given I created '<Role>' role in '<RoleType>' group for advertiser 'DefaultAgency'
And I logged in as 'GlobalAdmin'
And I opened role '<Role>' page with parent 'DefaultAgency'
Then I should see role '<Role>' that '<Should>' contains following permissions 'file.download' available for selecting

Examples:
| Role      | RoleType | Should     |
| ACLFDR1_1 | global   | should not |
| ACLFDR1_2 | project  | should     |


Scenario: Check that 'file.download' permission is selected by default for project admin
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I opened role 'project.admin' page with parent 'DefaultAgency'
Then I should see role 'project.admin' that 'should' contains following selected permissions 'file.download'


Scenario: Check that downloading original file depends on 'file.download' permission on file details within project for shared users from current agency
Meta:@projects
     @gdam
Given I created '<Role>' role with '<Permissions>' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role         | Agency       |
| <email> | <globalRole> | <agencyName> |
And I created 'ACLFDP3' project
And created '/ACLFDF3' folder for project 'ACLFDP3'
And uploaded '/files/_file1.gif' file into '/ACLFDF3' folder for 'ACLFDP3' project
And waited while transcoding is finished in folder '/ACLFDF3' on project 'ACLFDP3' files page
And fill Share popup by users '<email>' in project 'ACLFDP3' folders '/ACLFDF3' with role '<Role>' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
And I am on file '/files/_file1.gif' info page in folder '/ACLFDF3' project 'ACLFDP3'
Then I '<Should>' see Download Original button on file '/files/_file1.gif' info page in folder '/ACLFDF3' project 'ACLFDP3'
And '<Should>' see Download master using nVerge button on file '/files/_file1.gif' info page in folder '/ACLFDF3' project 'ACLFDP3'

Examples:
| email     | globalRole   | agencyName    | Role      | Permissions                                         | Should     |
| ACLFDU3_1 | agency.admin | DefaultAgency | ACLFDR3_1 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU3_2 | agency.admin | DefaultAgency | ACLFDR3_2 | folder.read,element.read,project.read               | should     |
| ACLFDU3_3 | agency.user  | DefaultAgency | ACLFDR3_3 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU3_4 | agency.user  | DefaultAgency | ACLFDR3_4 | folder.read,element.read,project.read               | should not |
| ACLFDU3_5 | guest.user   | DefaultAgency | ACLFDR3_5 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU3_6 | guest.user   | DefaultAgency | ACLFDR3_6 | folder.read,element.read,project.read               | should not |


Scenario: Check that downloading original file depends on 'file.download' permission on file details within project for shared users from another agency
Meta:@projects
     @gdam
Given I created '<Role>' role with '<Permissions>' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role         | Agency       |
| <email> | <globalRole> | <agencyName> |
And added user '<email>' into address book
And I created 'ACLFDP4' project
And created '/ACLFDF4' folder for project 'ACLFDP4'
And uploaded '/files/_file1.gif' file into '/ACLFDF4' folder for 'ACLFDP4' project
And waited while transcoding is finished in folder '/ACLFDF4' on project 'ACLFDP4' files page
And fill Share popup by users '<email>' in project 'ACLFDP4' folders '/ACLFDF4' with role '<Role>' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
And I am on file '/files/_file1.gif' info page in folder '/ACLFDF4' project 'ACLFDP4'
Then I '<Should>' see Download Original button on file '/files/_file1.gif' info page in folder '/ACLFDF4' project 'ACLFDP4'
And '<Should>' see Download master using nVerge button on file '/files/_file1.gif' info page in folder '/ACLFDF4' project 'ACLFDP4'

Examples:
| email     | globalRole   | agencyName    | Role      | Permissions                                         | Should     |
| ACLFDU4_1 | agency.admin | AnotherAgency | ACLFDR4_1 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU4_2 | agency.admin | AnotherAgency | ACLFDR4_2 | folder.read,element.read,project.read               | should not |
| ACLFDU4_3 | agency.user  | AnotherAgency | ACLFDR4_3 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU4_4 | agency.user  | AnotherAgency | ACLFDR4_4 | folder.read,element.read,project.read               | should not |
| ACLFDU4_5 | guest.user   | AnotherAgency | ACLFDR4_5 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU4_6 | guest.user   | AnotherAgency | ACLFDR4_6 | folder.read,element.read,project.read               | should not |


Scenario: Check that downloading original file depends on 'file.download' permission in folder within project for shared users from current agency
Meta:@projects
     @gdam
Given I created '<Role>' role with '<Permissions>' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role         | Agency       |
| <email> | <globalRole> | <agencyName> |
And I created 'ACLFDP5' project
And created '/ACLFDF5' folder for project 'ACLFDP5'
And uploaded '/files/_file1.gif' file into '/ACLFDF5' folder for 'ACLFDP5' project
And waited while transcoding is finished in folder '/ACLFDF5' on project 'ACLFDP5' files page
And fill Share popup by users '<email>' in project 'ACLFDP5' folders '/ACLFDF5' with role '<Role>' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
And I am on project 'ACLFDP5' folder '/ACLFDF5' page
When I select file '_file1.gif' on project files page
Then I '<Should>' see Download link next to original file '_file1.gif' and Download master using nVerge button on Download popup for project 'ACLFDP5' folder '/ACLFDF5'

Examples:
| email     | globalRole   | agencyName    | Role      | Permissions                                         | Should     |
| ACLFDU5_1 | agency.admin | DefaultAgency | ACLFDR5_1 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU5_2 | agency.admin | DefaultAgency | ACLFDR5_2 | folder.read,element.read,project.read               | should     |
| ACLFDU5_3 | agency.user  | DefaultAgency | ACLFDR5_3 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU5_4 | agency.user  | DefaultAgency | ACLFDR5_4 | folder.read,element.read,project.read               | should not |
| ACLFDU5_5 | guest.user   | DefaultAgency | ACLFDR5_5 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU5_6 | guest.user   | DefaultAgency | ACLFDR5_6 | folder.read,element.read,project.read               | should not |


Scenario: Check that downloading original file depends on 'file.download' permission in folder within project for shared users from another agency
Meta:@projects
     @gdam
Given I created '<Role>' role with '<Permissions>' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role         | Agency       |
| <email> | <globalRole> | <agencyName> |
And added user '<email>' into address book
And I created 'ACLFDP6' project
And created '/ACLFDF6' folder for project 'ACLFDP6'
And uploaded '/files/_file1.gif' file into '/ACLFDF6' folder for 'ACLFDP6' project
And waited while transcoding is finished in folder '/ACLFDF6' on project 'ACLFDP6' files page
And fill Share popup by users '<email>' in project 'ACLFDP6' folders '/ACLFDF6' with role '<Role>' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
And I am on project 'ACLFDP6' folder '/ACLFDF6' page
When I select file '_file1.gif' on project files page
Then I '<Should>' see Download link next to original file '_file1.gif' and Download master using nVerge button on Download popup for project 'ACLFDP6' folder '/ACLFDF6'

Examples:
| email     | globalRole   | agencyName    | Role      | Permissions                                         | Should     |
| ACLFDU6_1 | agency.admin | AnotherAgency | ACLFDR6_1 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU6_2 | agency.admin | AnotherAgency | ACLFDR6_2 | folder.read,element.read,project.read               | should not |
| ACLFDU6_3 | agency.user  | AnotherAgency | ACLFDR6_3 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU6_4 | agency.user  | AnotherAgency | ACLFDR6_4 | folder.read,element.read,project.read               | should not |
| ACLFDU6_5 | guest.user   | AnotherAgency | ACLFDR6_5 | folder.read,element.read,project.read,file.download | should     |
| ACLFDU6_6 | guest.user   | AnotherAgency | ACLFDR6_6 | folder.read,element.read,project.read               | should not |