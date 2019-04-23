!--NGN-16213-
Feature:             Global Admin defines Applications available to BU
Narrative:
In order to
As a                 AgencyAdmin
I want to            Check user of the BU can access Applications that is made available for him

Scenario: Check that if a user has no access to Projects Module,If someone invites them into Project, they can see Project by direct link
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_GADAVTBUA_1' with default attributes
And created the agency 'A_GADAVTBUA_2' with default attributes
And created users with following fields:
| Email           | Role            | Agency         | Password     |
| U_GACHPMBU_3    | agency.admin    | A_GADAVTBUA_1  | TestPassw0rd |
And created users with following fields:
| Email           | Role         | Agency         |
| U_GACHPMBU_4    | agency.admin | A_GADAVTBUA_2  |
When I update the following agency over core:
| Name            | Enable Projects Module |
| A_GADAVTBUA_1   | should not             |
And I update the following agency over core:
| Name            | Enable Projects Module |
| A_GADAVTBUA_2   | should                 |
When I login with details of 'U_GACHPMBU_4'
And create 'P_GACHR1BU_1' role in 'project' group for advertiser 'A_GADAVTBUA_2' with following permissions:
| Permission              |
| element.read            |
| element.write           |
| element.send_to_library |
| folder.read             |
And create 'P_GACHPMBU_1' project
And publish the project 'P_GACHPMBU_1'
And create '/P_GACHFBU_1' folder for project 'P_GACHPMBU_1'
And added users 'U_GACHPMBU_3' to project 'P_GACHPMBU_1' team folders '/P_GACHFBU_1' with role 'P_GACHR1BU_1' expired '12.12.2022' and 'should' access to subfolders
And upload '/files/_file1.gif' file into '/P_GACHFBU_1' folder for 'P_GACHPMBU_1' project
And wait while transcoding is finished in folder '/P_GACHFBU_1' on project 'P_GACHPMBU_1' files page
And logout from account
And open link from email when user 'U_GACHPMBU_3' received email with next subject 'Folders have been shared with'
And fill fields login 'U_GACHPMBU_3' and password 'TestPassw0rd' and then login to system
Then I 'should' see file '_file1.gif' on project files page and files count are '1'

Scenario: Check that if global admin  hides 'Project' access for BU,Users from this BU should not see Projects Options in user deatils page , Project menu in Navigation link,Approvals and LAtest Files Widgets on Dashboard,Retrieve from Projects option in New Order form
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the agency '<Name>' with default attributes
And I logged in as 'GlobalAdmin'
And created users with following fields:
| Email   | Role         | Access   | Agency |
| <User1> | agency.admin | <Access> | <Name> |
| <User2> | agency.user  | <Access> | <Name> |
When I update the following agency over core:
| Name   | Enable Projects Module |
| <Name> | <State>                |
And login with details of '<User1>'
Then I '<Condition>' see the 'Projects' link in the navigation menu
And '<Condition>' see section 'approvals' on Dashboard page
And '<Condition>' see section 'files in your projects' on Dashboard page
And '<Condition>' see section 'my projects' on Dashboard page
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| <ClockNo>    |
And open order item with following clock number '<ClockNo>'
Then '<Condition>' see 'Retrieve from Projects' button for order item at Add media to your order form
And go to user '<User2>' details page
Then I '<Condition>' see '<Application>' application access checkbox on user '<User2>' details page

Examples:
| Name          | State       |  Condition | Application| ClockNo    | Access                                                   | User1         | User2         |
| A_GADATPMBUA_1| should      | should     | folders    | OGACHPMBU_1| folders,approvals,dashboard,annotations,library,ordering | U_GADATPMBUU_1| U_GADATPMBUU_2|
| A_GADATPMBUA_2| should not  | should not | folders    | OGACHPMBU_2| approvals,dashboard,annotations,library,ordering         | U_GADATPMBUU_3| U_GADATPMBUU_4|

Scenario: Check that if global admin  hides 'WorkRequest' access for BU,Users from this BU does not have Work Requests Options in user details page and Work Request menu in Navigation link
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the agency '<Name>' with default attributes
And created users with following fields:
| Email   | Role         | Agency | Access   |
| <User1> | agency.admin | <Name> | <Access> |
| <User2> | agency.user  | <Name> | <Access> |
When I update the following agency over core:
| Name   | Enable Work Requests Feature |
| <Name> | <state>                      |
And login with details of '<User1>'
And go to Project list page
Then I '<Condition>' see 'Work Requests' tab on project list page
And go to user '<User2>' details page
Then I '<Condition>' see '<Application>' application access checkbox on user '<User2>' details page

Examples:
| Name            | state       |  Condition   | Application      | User1        | User2        | Access                                                          |
| A_GADATWRMBUA_1 | should      |  should      | adkits           | U_GACHWRBU_1 | U_GACHWRBU_2 | folders,adkits,library,ordering,approvals,annotations,dashboard |
| A_GADATWRMBUA_2 | should not  |  should not  | adkits           | U_GACHWRBU_3 | U_GACHWRBU_4 | folders,library,ordering,approvals,annotations,dashboard        |


Scenario: Check that if global admin has 'Library' access for BU,Users from this BU see have Library Option in User Details page,Presentations and Latest Library Uploads widgets on Dashboard,Library menu in navigation link
 Meta:@gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency '<Name>' with default attributes
And created users with following fields:
| Email   | Role         | Agency |
| <User1> | agency.admin | <Name> |
| <User2> | agency.user  | <Name> |
When I update the following agency over core:
| Name     | Enable Library Module  |
| <Name>   | <state>                |
And I login with details of '<User1>'
Then I '<Condition>' see section 'latest library uploads' on Dashboard page
And '<Condition>' see section 'presentations' on Dashboard page
And '<Condition>' see the 'Library' link in the navigation menu
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| <ClockNo>    |
And open order item with following clock number '<ClockNo>'
Then I 'should' see 'Retrieve from Library' button for order item at Add media to your order form
And go to user '<User2>' details page
Then I '<Condition>' see '<Application>' application access checkbox on user '<User2>' details page

Examples:
| Name         | state      |  Condition | Application| ClockNo     | User1       | User2        |
| A_GACHLMBU_1 |should      | should     | library    | OGACHLMBU_1 | U_GACHLMBU_1| U_GACHLMBU_2 |


Scenario: Check that if global admin  hides 'Library' access for BU,Users from this BU notsee have Library Option in User Details page,Presentations and Latest Library Uploads widgets on Dashboard,Library menu in navigation link
Meta:@gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency '<Name>' with default attributes
And created users with following fields:
| Email   | Role         | Agency | Access   |
| <User2> | agency.user  | <Name> | <Access> |
When I update the following agency over core:
| Name     | Enable Library Module  |
| <Name>   | <state>                |
And I login with details of '<User1>'
Then I '<Condition>' see section 'latest library uploads' on Dashboard page
And '<Condition>' see section 'presentations' on Dashboard page
And '<Condition>' see the 'Library' link in the navigation menu
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| <ClockNo>    |
And open order item with following clock number '<ClockNo>'
Then I 'should' see 'Retrieve from Library' button for order item at Add media to your order form
And go to user '<User2>' details page
Then I '<Condition>' see '<Application>' application access checkbox on user '<User2>' details page

Examples:
| Name         | state      |  Condition | Application| ClockNo     | User1       | User2        | Access                                                                       |
| A_GACHLMBU_2 |should not  | should not | library    | OGACHLMBU_2 | U_GACHLMBU_3| U_GACHLMBU_4 | folders,ordering,dashboard,approvals,annotations,adkits                      |

Scenario: Check that if a user hide/unhide access to Library Module, user of this bu should see/not see Send to Library button in Projects,Add from library from project Files and file info page
Meta:@bug
     @gdam
     @projects
!--FAB-460--example 2 will fail
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_GACHLMBU_6' with default attributes
And created users with following fields:
| Email           | Role            | Agency        |
| U_GACHLMBU_6    | agency.admin    | A_GACHLMBU_6  |
When I update the following agency over core:
| Name           | Enable Library Module  |
| A_GACHLMBU_6   | <state>                |
When I login with details of 'U_GACHLMBU_6'
And create '<ProjectName>' project
And create '<FolderName>' folder for project '<ProjectName>'
And upload '/files/image9.jpg' file into '<FolderName>' folder for '<ProjectName>' project
And wait while transcoding is finished on project '<ProjectName>' in folder '<FolderName>' for 'image9.jpg' file
Then '<Condition>' see element 'AddFromLibrary' on page 'FilesPage'
And I go to file '/files/image9.jpg' info page in folder '<FolderName>' project '<ProjectName>'
And click element 'MoreButton' on page 'FilesPage'
Then '<Condition>' see element 'SendToLibrary' on page 'FilesPage'


Examples:
|state     |Condition    | ProjectName | FolderName |
|should    |should       | P_GACHLMBU_3|/P_GACHFBU_3|
|should not|should not   | P_GACHLMBU_4|/P_GACHFBU_4|

Scenario: Check that If other BU shares category to that user - user cannot see it
Meta:@gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_GACHLMBU_21' with default attributes
And I created the agency 'A_GACHLMBU_31' with default attributes
And created users with following fields:
| Email            | Role            | Agency         |
| U_GACHLMBU_21    | agency.admin    | A_GACHLMBU_21  |
And created users with following fields:
| Email            | Role         | Agency         |
| U_GACHLMBU_31    | agency.admin | A_GACHLMBU_31  |
When I update the following agency over core:
| Name            | Enable Library Module  |
| A_GACHLMBU_21   | should not             |
And I update the following agency over core:
| Name            | Enable Library Module  |
| A_GACHLMBU_31   | should                 |
And I login with details of 'U_GACHLMBU_31'
And create 'P_GACHR1BU_31' role in 'library' group for advertiser 'A_GACHLMBU_31'
And create following categories:
| Name          |
| C_GACHLMBU_11 |
And added next users for following categories:
| CategoryName  | UserName      | RoleName      |
| C_GACHLMBU_11 | U_GACHLMBU_21 | P_GACHR1BU_31 |
And I login with details of 'U_GACHLMBU_21'
Then I 'should' see an access denied message on Categories page


Scenario: Check that If other BU shares Presentation to that user - user can see it as usual, by following link in the email.
Meta:@gdam
     @gdamemails
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_GACHPREBU_2' with default attributes
And I created the agency 'A_GACHPREBU_3' with default attributes
And created users with following fields:
| Email            | Role            | Agency         | Password     |
| U_GACHPREBU_3    | agency.admin    | A_GACHPREBU_2  | TestPassw0rd |
And created users with following fields:
| Email            | Role         | Agency         |
| U_GACHPREBU_4    | agency.admin | A_GACHPREBU_3  |
When I update the following agency over core:
| Name            | Enable Presentations Feature  |
| A_GACHPREBU_2   | should not                    |
And I update the following agency over core:
| Name            |  Enable Presentations Feature |
| A_GACHPREBU_3   | should                        |
And I login with details of 'U_GACHPREBU_4'
And create following reels:
| Name       | Description |
| PRE_GACP_1 | D1          |
And share presentation 'PRE_GACP_1' to user 'U_GACHPREBU_3' with personal message 'I reel you!'
Then I 'should' see email notification for 'Shared presentation' with field to 'U_GACHPREBU_3' and subject 'has been shared with' contains following attributes:
| Agency        | Message     | PresentationName |
| A_GACHPREBU_3 | I reel you! | PRE_GACP_1       |

Scenario: Check that if a BU has no access to Annotations Module,Users from this BU cannot see Annotate button on Files in Projects created in this BU
Meta:@gdam
@projects
Given I created the agency 'A_GACHANMBU_4' with default attributes
And I logged in as 'GlobalAdmin'
And updated agency 'A_GACHANMBU_4' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Enable Annotations Feature                      | false              |
And created users with following fields:
| Email            | Role            | Agency         |
| U_GACHANMBU_5    | agency.admin    | A_GACHANMBU_4  |
When I login with details of 'U_GACHANMBU_5'
And create 'P_GACHAMBU_2' project
And create '/P_GACHFBU_8' folder for project 'P_GACHAMBU_2'
And upload '/files/Fish1-Ad.mov' file into '/P_GACHFBU_8' folder for 'P_GACHAMBU_2' project
And wait while transcoding is finished on project 'P_GACHAMBU_2' in folder '/P_GACHFBU_8' for 'Fish1-Ad.mov' file
And go to file '/files/Fish1-Ad.mov' info page in folder '/P_GACHFBU_8' project 'P_GACHAMBU_2'
Then I 'should not' see Annotate button on file info page

Scenario:Check that if a BU has no access to Annotation Module,Users from this BU CAN see Annotate button on Files in Projects created in other BU, if that BU has Annotations
Meta:@gdam
@projects
Given I created the agency 'A_GACHANBU_10' with default attributes
And created the agency 'A_GACHANBU_11' with default attributes
And I logged in as 'GlobalAdmin'
And updated agency 'A_GACHANBU_10' with following fields on agency overview page:
| FieldName                                | FieldValue         |
| Enable Approvals Feature                 | false              |
And updated agency 'A_GACHANBU_11' with following fields on agency overview page:
| FieldName                                | FieldValue         |
| Enable Approvals Feature                 | true               |
And created users with following fields:
| Email          | Role            | Agency        |
| U_GACHAFBU_4_D | agency.admin    | A_GACHANBU_11 |
And created users with following fields:
| Email          | Role            | Agency        | Password      |
| U_GACHAFBU_3_D | agency.admin    | A_GACHANBU_10 |  TestPassw0rd |
And logged in with details of 'U_GACHAFBU_4_D'
When I create 'P_GACHR1BU_2' role in 'project' group for advertiser 'A_GACHANBU_11' with following permissions:
| Permission              |
| element.read            |
| element.write           |
| element.send_to_library |
| folder.read             |
And create 'P_GACHAMBU_2' project
And publish the project 'P_GACHAMBU_2'
And create '/P_GACHFBU_2' folder for project 'P_GACHAMBU_2'
And added users 'U_GACHAFBU_3_D' to project 'P_GACHAMBU_2' team folders '/P_GACHFBU_2' with role 'P_GACHR1BU_2' expired '12.12.2022' and 'should' access to subfolders
And upload '/files/_file1.gif' file into '/P_GACHFBU_2' folder for 'P_GACHAMBU_2' project
And wait while transcoding is finished in folder '/P_GACHFBU_2' on project 'P_GACHAMBU_2' files page
And I logout from account
And open link from email when user 'U_GACHAFBU_3_D' received email with next subject 'Folders have been shared with'
And fill fields login 'U_GACHAFBU_3_D' and password 'TestPassw0rd' and then login to system
And go to file '_file1.gif' info page in folder '/P_GACHFBU_2' project 'P_GACHAMBU_2'
Then I '<Condition>' see Annotate button on file info page

Examples:
|Condition|
|should   |

Scenario: Check that if a BU has no access to Approvals Module, Users of this BU cannot see Approvals widgets on Dashboard
Meta:@gdam
@approvals
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_GACHAMBU_2A' with default attributes
And created the agency 'A_GACHAMBU_3' with default attributes
And created users with following fields:
| Email           | Role            | Agency        | Password     | Access                                                               |
| U_GACHAMBU_2    | agency.admin    | A_GACHAMBU_2A  | TestPassw0rd | folders,adkits,dashboard,library,ordering,annotations,presentations  |
And created users with following fields:
| Email           | Role         | Agency        | Access                                                            |
| U_GACHAMBU_3    | agency.admin | A_GACHAMBU_3  | folders,adkits,dashboard,library,ordering,approvals,presentations |
When I update the following agency over core:
| Name            |  Enable Approvals Feature   |
| A_GACHAMBU_2A    | should not                  |
And I update the following agency over core:
| Name            |  Enable Approvals Feature   |
| A_GACHAMBU_3    | should                      |
When I login with details of 'U_GACHAMBU_3'
And create 'P_GACHLMBU_2' project
And publish the project 'P_GACHLMBU_2'
And create '/P_GACHFBU_2' folder for project 'P_GACHLMBU_2'
And upload '/files/_file1.gif' file into '/P_GACHFBU_2' folder for 'P_GACHLMBU_2' project
And wait while transcoding is finished in folder '/P_GACHFBU_2' on project 'P_GACHLMBU_2' files page
And add approval stage on file '_file1.gif' approvals page in folder '/P_GACHFBU_2' project 'P_GACHLMBU_2':
| Name            | Approvers    | Deadline         | Reminder         | Started |
| AS_GACHAFBU_S08 | U_GACHAMBU_2 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
And I logout from account
And login as user with name 'U_GACHAMBU_2' and password 'TestPassw0rd'
Then I 'should not' see section 'Approvals' on Dashboard page

Scenario: Check that if a BU has no access to Approvals Module,If someone shares file for Approval for users in this BU - they can see approval as usual
Meta:@gdam
@approvals
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_GACHAMBU_14' with default attributes
And I created the agency 'A_GACHAMBU_5' with default attributes
And created users with following fields:
| Email           | Role            | Agency        |
| U_GACHAMBU_9    | agency.admin    | A_GACHAMBU_5  |
And created users with following fields:
| Email            | Role            | Agency        |
| U_GACHAMBU_10    | agency.admin    | A_GACHAMBU_14 |
When I update the following agency over core:
| Name           | Enable Approvals Feature   |
| A_GACHAMBU_5   | should                     |
And I update the following agency over core:
| Name            | Enable Approvals Feature   |
| A_GACHAMBU_14   | should not                 |
And I login with details of 'U_GACHAMBU_9'
And create 'P_GACHAMBU_8' project
And create '/P_GACHFBU_8' folder for project 'P_GACHAMBU_8'
And upload '/files/Fish1-Ad.mov' file into '/P_GACHFBU_8' folder for 'P_GACHAMBU_8' project
And wait while transcoding is finished in folder '/P_GACHFBU_8' on project 'P_GACHAMBU_8' files page
And add approval stage on file 'Fish1-Ad.mov' approvals page in folder '/P_GACHFBU_8' project 'P_GACHAMBU_8':
| Name            | Approvers     | Deadline         | Reminder         | Started |
| AS_GACHAFBU_S18 | U_GACHAMBU_10 | 01/05/2023 12:15 | 01/05/2023 08:00 | true    |
And I login with details of 'U_GACHAMBU_10'
And open link from email when user 'U_GACHAMBU_10' received email with next subject 'has requested your approval'
Then I 'should' see approval stages with the following information:
| Name            | Status  | Reminder        | Deadline         |
| AS_GACHAFBU_S18 | pending | 5/1/23, 8:00 AM | 5/1/23, 12:15 PM |

Scenario: Check that if a user has access to Approval Feature, can see Send For Approval button in Projects,Approvals tab in Projects,Approvals tab on Files in Projects
Meta:@gdam
@approvals
Given I logged in as 'GlobalAdmin'
And I created the agency '<Name>' with default attributes
And created users with following fields:
| Email      | Role            | Agency        |
| <User1>    | agency.admin    | <Name>        |
When I update the following agency over core:
| Name      |  Enable Approvals Feature   |
| <Name>    | <state>                     |
And I login with details of '<User1>'
And create '<ProjectName>' project
And create '<FolderName>' folder for project '<ProjectName>'
And upload '/files/Fish1-Ad.mov' file into '<FolderName>' folder for '<ProjectName>' project
And wait while transcoding is finished on project '<ProjectName>' in folder '<FolderName>' for 'Fish1-Ad.mov' file
And go to file '/files/Fish1-Ad.mov' info page in folder '<FolderName>' project '<ProjectName>'
And click element 'MoreButton' on page 'FilesPage'
Then '<Condition>' see element 'SendForApproval' on page 'FilesPage'
Then '<Condition>' see element 'ApprovalsTab' on page 'FileInfoPage'
And go to Project list page
Then I '<Condition>' see 'Approvals' tab on project list page

Examples:
|Name        | state      |Condition     |ProjectName  |FolderName  | User1       |
|A_GACHAMBU_1| should     |should        |P_GACHAMBU_7 |/P_GACHFBU_7| U_GACHAMBU_1|


Scenario: Check that if a user has no access to Approval Feature, do not see Send For Approval button in Projects,Approvals tab in Projects,Approvals tab on Files in Projects
Meta:@gdam
@approvals
Given I logged in as 'GlobalAdmin'
And I created the agency '<Name>' with default attributes
And created users with following fields:
| Email      | Role            | Agency        | Access   |
| <User1>    | agency.admin    | <Name>        | <Access> |
When I update the following agency over core:
| Name      |  Enable Approvals Feature   |
| <Name>    | <state>                     |
And I login with details of '<User1>'
And create '<ProjectName>' project
And create '<FolderName>' folder for project '<ProjectName>'
And upload '/files/Fish1-Ad.mov' file into '<FolderName>' folder for '<ProjectName>' project
And wait while transcoding is finished on project '<ProjectName>' in folder '<FolderName>' for 'Fish1-Ad.mov' file
And go to file '/files/Fish1-Ad.mov' info page in folder '<FolderName>' project '<ProjectName>'
And click element 'MoreButton' on page 'FilesPage'
Then '<Condition>' see element 'SendForApproval' on page 'FilesPage'
Then '<Condition>' see element 'ApprovalsTab' on page 'FileInfoPage'
And go to Project list page
Then I '<Condition>' see 'Approvals' tab on project list page

Examples:
|Name        | state      |Condition     |ProjectName  |FolderName  | User1       | Access                                                         |
|A_GACHAMBU_2| should not |should not    |P_GACHAMBU_9 |/P_GACHFBU_9| U_GACHAMBU_2| folders,adkits,dashboard,library,ordering,annotations          |

Scenario:Check that if a BU has no access to Approvals Module,Users from this BU CAN see Approvals tab in Projects, Approvals tab on Files,Send for Approval option in Project > Folder created in other BU, if that BU has Approvals
Meta:@gdam
@approvals
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_GACHAFBU_10' with default attributes
And created the agency 'A_GACHAFBU_11' with default attributes
And created users with following fields:
| Email          | Role            | Agency       |
| U_GACHAFBU_4_G | agency.admin    | A_GACHAFBU_11 |
And created users with following fields:
| Email          | Role            | Agency        | Password      |
| U_GACHAFBU_3_G | agency.admin    | A_GACHAFBU_10 |  TestPassw0rd |
When I update the following agency over core:
| Name            |  Enable Approvals Feature   |
| A_GACHAFBU_10   | should not                  |
When I update the following agency over core:
| Name            |  Enable Approvals Feature   |
| A_GACHAFBU_11   | should                      |
When I login with details of 'U_GACHAFBU_4_G'
And create 'P_GACHR1BU_3' role in 'project' group for advertiser 'A_GACHAFBU_11'  with following permissions:
| Permission              |
| element.read            |
| element.write           |
| element.send_to_library |
| folder.read             |
| approval.admin          |
And create 'P_GACHAMBU_12' project
And publish the project 'P_GACHAMBU_12'
And create '/P_GACHFBU_5' folder for project 'P_GACHAMBU_12'
And added users 'U_GACHAFBU_3_G' to project 'P_GACHAMBU_12' team folders '/P_GACHFBU_5' with role 'P_GACHR1BU_3' expired '12.12.2022' and 'should' access to subfolders
And upload '/files/_file1.gif' file into '/P_GACHFBU_5' folder for 'P_GACHAMBU_12' project
And wait while transcoding is finished in folder '/P_GACHFBU_5' on project 'P_GACHAMBU_12' files page
And logout from account
And open link from email when user 'U_GACHAFBU_3_G' received email with next subject 'Folders have been shared with'
And fill fields login 'U_GACHAFBU_3_G' and password 'TestPassw0rd' and then login to system
Then I 'should' see element 'ApprovalsTab' on page 'ProjectsOverview'
And I go to file '/files/_file1.gif' info page in folder '/P_GACHFBU_5' project 'P_GACHAMBU_12'
Then 'should' see element 'ApprovalsTab' on page 'FileInfoPage'
And click element 'MoreButton' on page 'FilesPage'
Then I 'should' see element 'SendForApproval' on page 'FilesPage'


Scenario: Check that if a user has no access to Work Request Module, do not see Add to Work Request button in Library page and Library Asset Info page
!--UIR-778
Meta:@bug
     @gdam
     @library
Given I created the agency 'A_GADATWRMBUA_2' with default attributes
And created users with following fields:
| Email           | Role            | Agency           | Password     |Access|
| U_GADATWRMBU_2  | agency.admin    | A_GADATWRMBUA_2  | TestPassw0rd |streamlined_library,library,adkits,folders|
When I update the following agency over core:
| Name            | Enable Work Requests Feature |
| A_GADATWRMBUA_2 | <state>                      |
When I login as user with name 'U_GADATWRMBU_2' and password 'TestPassw0rd'
And upload file '/files/image10.jpg' into my library
And wait while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'image10.jpg' in the 'Everything'  library pageNEWLIB
Then I '<Condition>' see 'Add to Work Request' option in menu for collection 'Everything'NEWLIB
Examples:
|state     |Condition |
|should    |should    |
|should not|should not|


Scenario: Check that if a user has no access to Projects Module, do not see Add to Projects in Library Page
!--UIR-778
Meta:@gdam
     @bug
     @library
Given I created the agency 'A_GADATPMBUA_2' with default attributes
And created users with following fields:
| Email           | Role            | Agency          | Password     |Access|
| U_GACHPMBU_5    | agency.admin    | A_GADATPMBUA_2  | TestPassw0rd |streamlined_library,library,folders|
When I update the following agency over core:
| Name           | Enable Projects Module |
| A_GADATPMBUA_2 | <state>                |
When I login as user with name 'U_GACHPMBU_5' and password 'TestPassw0rd'
And upload file '/files/image10.jpg' into my libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I select asset 'image10.jpg' in the 'My Assets' library pageNEWLIB
Then I '<Condition>' see 'project' option in Copy To menu for collection 'My Assets'NEWLIB
Examples:
| state       |  Condition |
| should      |  should  |
| should not      |  should not  |

Scenario: Check that if a BU has no access to Presentation Module,Users from this BU cannot see Presentations widgets on Dashboard,Add to Presentation button in Library
!--UIR-778
Meta:@gdam
     @bug
     @library
Given I created the agency 'A_GADAPRBUA_1' with default attributes
And created users with following fields:
| Email           | Role            | Agency         | Password     |Access|
| U_GACHPRMBU_1   | agency.admin    | A_GADAPRBUA_1  | TestPassw0rd |streamlined_library,library,presentations,dashboard|
When I update the following agency over core:
| Name            |  Enable Presentations Feature |
| A_GADAPRBUA_1   | <state>                       |
When login as user with name 'U_GACHPRMBU_1' and password 'TestPassw0rd'
Then I '<Condition>' see section 'presentations' on Dashboard page
When uploaded asset '/files/New Text Document.txt' into libraryNEWLIB
And I select asset 'New Text Document.txt' in the 'My Assets' library pageNEWLIB
Then I '<Condition>' see 'presentation' option in Copy To menu for collection 'My Assets'NEWLIB
Examples:

| state    |Condition |
|should   |should   |
|should not   |should not   |
|should not   |should not   |


Scenario: Check that disabled modules at BU level should revoked from users
Meta:@gdam
@globaladmin
!-- QA-1182
Given I created the agency 'A_GACHAFBU_12' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_GACHAMBU_11 | agency.admin | A_GACHAFBU_12 |streamlined_library,ordering,dashboard|
When I login with details of 'U_GACHAMBU_11'
Then I 'should' able to see and access element 'Ordering' on page 'Dashboard'
Then I 'should' see the link 'Library' on landing page
When I login with details of 'GlobalAdmin'
And I update the following agency over core:
| Name            | Enable Library Module  | Enable Delivery Module |
| A_GACHAFBU_12   | should not             | should not             |
And I login with details of 'U_GACHAMBU_11'
Then I 'should not' able to see and access element 'Ordering' on page 'Dashboard'
Then I 'should not' see the link 'Library' on landing page


Scenario: Check that disabled modules at BU level should not displayed in the Startup Page dropdown box for user
Meta:@gdam
@globaladmin
!-- QA-1216
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_GACHAFBU_13' with default attributes
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_GACHAMBU_12 | agency.admin | A_GACHAFBU_13 | folders,streamlined_library,ordering,dashboard|
Then see following fields on profile setting page for user 'U_GACHAMBU_12' of agency 'A_GACHAFBU_13':
| Access                             | Start Up Page                      | Condition |
| Folders,Streamlined Library,Delivery,Dashboard | Project,Library,Delivery,Dashboard | should    |



