!--NGN-7672
Feature:          Rewrite Approvals - Approvals page
Narrative:
In order to
As a              AgencyAdmin
I want to         Check functionality of Approvals page

Scenario: Check that approver see shared approval on 'Received' tab on Approvals page
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S01 | DefaultAgency |
And created  'P_RAAP_S01' project
And created '/F_RAAP_S01' folder for project 'P_RAAP_S01'
And uploaded '/images/logo.png' file into '/F_RAAP_S01' folder for 'P_RAAP_S01' project
And waited while preview is available in folder '/F_RAAP_S01' on project 'P_RAAP_S01' files page
And added approval stage on file 'logo.png' approvals page in folder '/F_RAAP_S01' project 'P_RAAP_S01':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S01 | U_RAAP_S01 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_RAAP_S01'
And go to project 'P_RAAP_S01' approvals received page
Then I 'should' see following approvals on opened project approvals page:
| FileName | Status  |
| logo.png | Pending |


Scenario: Check that approval owner sees his approvals on 'Submitted' tab on Approvals page
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S02 | DefaultAgency |
And created  'P_RAAP_S02' project
And created '/F_RAAP_S02' folder for project 'P_RAAP_S02'
And uploaded '/images/logo.png' file into '/F_RAAP_S02' folder for 'P_RAAP_S02' project
And waited while preview is available in folder '/F_RAAP_S02' on project 'P_RAAP_S02' files page
And added approval stage on file 'logo.png' approvals page in folder '/F_RAAP_S02' project 'P_RAAP_S02':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S02 | U_RAAP_S02 | 01/05/2023 12:15 | test description | true    |
When I go to project 'P_RAAP_S02' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName | Status  |
| logo.png | Pending |


Scenario: Check that not started approval stages appear under 'Not Started' tab on Approvals page
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S03 | DefaultAgency |
And added user 'U_RAAP_S03' into address book
And created  'P_RAAP_S03' project
And created '/F_RAAP_S03' folder for project 'P_RAAP_S03'
And uploaded '/images/logo.png' file into '/F_RAAP_S03' folder for 'P_RAAP_S03' project
And waited while preview is available in folder '/F_RAAP_S03' on project 'P_RAAP_S03' files page
And on file 'logo.png' approvals page in folder '/F_RAAP_S03' project 'P_RAAP_S03'
And clicked Send for Approval button in More dropdown on file approvals page
And filled approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers  | Deadline         | Description      |
| AS_RAAP_S03 | U_RAAP_S03 | 01/05/2023 12:15 | test description |
And clicked 'save and close' element on opened Add a new Stage popup
When I go to project 'P_RAAP_S03' approvals not started page
Then I 'should' see following approvals on opened project approvals page:
| FileName |
| logo.png |


Scenario: Check that approved stage doesn't appear for approver on 'Received' tab
Meta: @skip
      @gdam
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S04 | DefaultAgency |
And created  'P_RAAP_S04' project
And created '/F_RAAP_S04' folder for project 'P_RAAP_S04'
And uploaded '/images/logo.png' file into '/F_RAAP_S04' folder for 'P_RAAP_S04' project
And waited while preview is available in folder '/F_RAAP_S04' on project 'P_RAAP_S04' files page
And added approval stage on file 'logo.png' approvals page in folder '/F_RAAP_S04' project 'P_RAAP_S04':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S04 | U_RAAP_S04 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_RAAP_S04'
And go to Dashboard page
And click file 'logo.png' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test comment' on opened file info page
And go to project 'P_RAAP_S04' approvals received page
Then I 'should not' see following approvals on opened project approvals page:
| FileName |
| logo.png |


Scenario: Check that approvals can be filtered by media type
Meta: @gdam
	  @approvals
!--FAB-824 (Bug)
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S05 | DefaultAgency |
And created  '<ProjectName>' project
And created '/F_RAAP_S05' folder for project '<ProjectName>'
And uploaded into project '<ProjectName>' following files:
| FileName            | Path        |
| /files/Fish Ad.mov  | /F_RAAP_S05 |
| /files/test.mp3     | /F_RAAP_S05 |
| /files/GWGTest2.pdf | /F_RAAP_S05 |
| /files/logo1.gif    | /F_RAAP_S05 |
| /files/logo2.png    | /F_RAAP_S05 |
And waited while preview is available in folder '/F_RAAP_S05' on project '<ProjectName>' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAAP_S05' project '<ProjectName>':
| Name          | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S05_1 | U_RAAP_S05 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'test.mp3' approvals page in folder '/F_RAAP_S05' project '<ProjectName>':
| Name          | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S05_2 | U_RAAP_S05 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'GWGTest2.pdf' approvals page in folder '/F_RAAP_S05' project '<ProjectName>':
| Name          | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S05_3 | U_RAAP_S05 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'logo1.gif' approvals page in folder '/F_RAAP_S05' project '<ProjectName>':
| Name          | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S05_4 | U_RAAP_S05 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'logo2.png' approvals page in folder '/F_RAAP_S05' project '<ProjectName>':
| Name          | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S05_5 | U_RAAP_S05 | 01/05/2023 12:15 | test description | true    |
When I go to project '<ProjectName>' approvals submitted page
And select mediatype '<MediaType>' on opened project approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName      | Status  |
| <VisibleFile> | Pending |
Then I 'should not' see file names '<NotVisibleFiles>' on opened project approvals page

Examples:
| ProjectName  | VisibleFile  | MediaType | NotVisibleFiles                              |
| P_RAAP_S05_1 | Fish Ad.mov  | Video     | test.mp3,GWGTest2.pdf,logo1.gif,logo2.png    |
| P_RAAP_S05_2 | test.mp3     | Audio     | Fish Ad.mov,GWGTest2.pdf,logo1.gif,logo2.png |
| P_RAAP_S05_3 | GWGTest2.pdf | Document  | Fish Ad.mov,test.mp3,logo1.gif,logo2.png     |
| P_RAAP_S05_4 | logo1.gif    | Digital   | Fish Ad.mov,test.mp3,GWGTest2.pdf,logo2.png  |
| P_RAAP_S05_5 | logo2.png    | Image     | Fish Ad.mov,test.mp3,GWGTest2.pdf,logo1.gif  |


Scenario: Check that approvals can be filtered by client (advertiser for project) (tested both Received and Submitted tab)
Meta: @gdam
	  @approvals
!--NGN-7382
Given I created the agency 'A_RAAP_S06' with default attributes
And created users with following fields:
| Email        | Role         | Agency     |
| U_RAAP_S06_1 | agency.admin | A_RAAP_S06 |
| U_RAAP_S06_2 | agency.admin | A_RAAP_S06 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_RAAP_S06':
| Advertiser    |
| AR RAAP S06 1 |
| AR RAAP S06 2 |
When I login with details of 'U_RAAP_S06_1'
And wait for '5' seconds
And add user 'U_RAAP_S06_2' to Address book
And create new project with following fields:
| FieldName  | FieldValue    |
| Name       | P_RAAP_S06_1  |
| Media type | Broadcast     |
| Advertiser | AR RAAP S06 1 |
| Start date | Today         |
| End date   | Tomorrow      |
And publish the project 'P_RAAP_S06_1'
And create new project with following fields:
| FieldName  | FieldValue    |
| Name       | P_RAAP_S06_2  |
| Media type | Broadcast     |
| Advertiser | AR RAAP S06 2 |
| Start date | Today         |
| End date   | Tomorrow      |
And publish the project 'P_RAAP_S06_2'
And create '/F_RAAP_S06' folder for project 'P_RAAP_S06_1'
And create '/F_RAAP_S06' folder for project 'P_RAAP_S06_2'
And upload '/files/image10.jpg' file into '/F_RAAP_S06' folder for 'P_RAAP_S06_1' project
And upload '/files/image11.jpg' file into '/F_RAAP_S06' folder for 'P_RAAP_S06_2' project
And wait while preview is available in folder '/F_RAAP_S06' on project 'P_RAAP_S06_1' files page
And wait while preview is available in folder '/F_RAAP_S06' on project 'P_RAAP_S06_2' files page
And go to project 'P_RAAP_S06_1' folder '/F_RAAP_S06' page
And create approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S06' project 'P_RAAP_S06_1':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_RAAP_S06_1 | U_RAAP_S06_2 | 01/05/2023 12:15 | test description | true    |
And refresh the page
And go to project 'P_RAAP_S06_2' folder '/F_RAAP_S06' page
And create approval stage on file 'image11.jpg' approvals page in folder '/F_RAAP_S06' project 'P_RAAP_S06_2':
| Name          | Approvers    | Deadline         | Description      | Started |
| AS_RAAP_S06_2 | U_RAAP_S06_2 | 01/05/2023 12:15 | test description | true    |
And refresh the page
And go to projects approvals submitted page
And select client 'AR RAAP S06 1' on opened project approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status  |
| image10.jpg | Pending |
When I select client 'AR RAAP S06 2' on opened project approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status  |
| image11.jpg | Pending |

Scenario: Check that approvals can be filtered by status
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S07 | DefaultAgency |
And created  'P_RAAP_S07' project
And created '/F_RAAP_S07' folder for project 'P_RAAP_S07'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S07' folder for 'P_RAAP_S07' project
And uploaded '/files/image11.jpg' file into '/F_RAAP_S07' folder for 'P_RAAP_S07' project
And waited while preview is available in folder '/F_RAAP_S07' on project 'P_RAAP_S07' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S07' project 'P_RAAP_S07':
| Name          | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S07_1 | U_RAAP_S07 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'image11.jpg' approvals page in folder '/F_RAAP_S07' project 'P_RAAP_S07':
| Name          | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S07_2 | U_RAAP_S07 | 01/05/2023 12:15 | test description | true    |
When I 'uncheck' auto close checkbox on file 'image11.jpg' approvals page in folder '/F_RAAP_S07' in project 'P_RAAP_S07'
And approve stage section 'AS_RAAP_S07_2' on opened file approvals page
And go to project 'P_RAAP_S07' approvals submitted page
And refresh the page without delay
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status   |
| image10.jpg | Pending  |
| image11.jpg | Approved |
When I select approval status 'Approved' on opened project approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status   |
| image11.jpg | Approved |
Then I 'should not' see following approvals on opened project approvals page:
| FileName    | Status  |
| image10.jpg | Pending |

Scenario: Check filter by date range
Meta: @gdam
	  @approvals
!--NGN-7584
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S08 | DefaultAgency |
And created  'P_RAAP_S08' project
And created '/F_RAAP_S08' folder for project 'P_RAAP_S08'
And uploaded '/images/logo.png' file into '/F_RAAP_S08' folder for 'P_RAAP_S08' project
And waited while preview is available in folder '/F_RAAP_S08' on project 'P_RAAP_S08' files page
And added approval stage on file 'logo.png' approvals page in folder '/F_RAAP_S08' project 'P_RAAP_S08':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S08 | U_RAAP_S08 | 01/05/2023 12:15 | test description | true    |
When I go to project 'P_RAAP_S08' approvals submitted page
And select Date range for 'Sent Date' from '01/05/2002' to '01/05/2020' on opened project approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName | Status  |
| logo.png | Pending |


Scenario: Check info on page after apply template for stage
Meta: @gdam
	  @approvals
!--NGN-7399
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S09 | DefaultAgency |
And added user 'U_RAAP_S09' into address book
And created 'P_RAAP_S09' project
And created '/F_RAAP_S09' folder for project 'P_RAAP_S09'
And uploaded '/files/Fish Ad.mov' file into '/F_RAAP_S09' folder for 'P_RAAP_S09' project
And uploaded '/files/Fish1-Ad.mov' file into '/F_RAAP_S09' folder for 'P_RAAP_S09' project
And waited while preview is available in folder '/F_RAAP_S09' on project 'P_RAAP_S09' files page
And on file 'Fish Ad.mov' info page in folder '/F_RAAP_S09' project 'P_RAAP_S09' tab approvals
And clicked Submit for approval on opened approvals page
And filled approval stage on opened Add a new Stage popup with following information:
| Name        | Approvers  | Description      |
| AS_RAAP_S09 | U_RAAP_S09 | test description |
And clicked 'Save and close' element on opened Add a new Stage popup
And saved approval as template 'AT_RAAP_S09' on opened approvals page
And I am on project 'P_RAAP_S09' overview page
And on file 'Fish1-Ad.mov' info page in folder '/F_RAAP_S09' project 'P_RAAP_S09' tab approvals
And applied approval template 'AT_RAAP_S09' on opened approvals page
When I click start approval
And go to project 'P_RAAP_S09' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status  |
| Fish1-Ad.mov | Pending |

Scenario: Check that project admin can see all approvals within project with ticked 'All user approvals' checkbox (tab Submitted)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email         | Role        | Access            |
| UC_RAAP_S10_1 | agency.user | folders,approvals |
| UA_RAAP_S10_1 | agency.user | folders,approvals |
And created 'P_RAAP_S10_1' project
And created '/F_RAAP_S10' folder for project 'P_RAAP_S10_1'
And fill Share popup by users 'UC_RAAP_S10_1' in project 'P_RAAP_S10_1' folders '/F_RAAP_S10' with role 'project.contributor' expired '10.10.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_RAAP_S10' folder for 'P_RAAP_S10_1' project
And uploaded '/files/Fish2-Ad.mov' file into '/F_RAAP_S10' folder for 'P_RAAP_S10_1' project
And waited while preview is available in folder '/F_RAAP_S10' on project 'P_RAAP_S10_1' files page
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_RAAP_S10' project 'P_RAAP_S10_1':
| Name           | Approvers     | Deadline         | Description      | Started |
| AS1_RAAP_S10_1 | UA_RAAP_S10_1 | 01/05/2023 12:15 | test description | true    |
And logged in with details of 'UC_RAAP_S10_1'
And added approval stage on file 'Fish2-Ad.mov' approvals page in folder '/F_RAAP_S10' project 'P_RAAP_S10_1':
| Name           | Approvers     | Deadline         | Description      | Started |
| AS2_RAAP_S10_1 | UA_RAAP_S10_1 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'AgencyAdmin'
And go to project 'P_RAAP_S10_1' approvals submitted page
And check 'All user approvals' checkbox in Approval Status area on opened project approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName     |
| Fish1-Ad.mov |
| Fish2-Ad.mov |


Scenario: Check that project admin can see all approvals within project with ticked 'All user approvals' checkbox (tab Not started)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email         | Role        | Access            |
| UC_RAAP_S10_2 | agency.user | folders,approvals |
| UA_RAAP_S10_2 | agency.user | folders,approvals |
And created 'P_RAAP_S10_2' project
And created '/F_RAAP_S10' folder for project 'P_RAAP_S10_2'
And fill Share popup by users 'UC_RAAP_S10_2' in project 'P_RAAP_S10_2' folders '/F_RAAP_S10' with role 'project.contributor' expired '10.10.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_RAAP_S10' folder for 'P_RAAP_S10_2' project
And uploaded '/files/Fish2-Ad.mov' file into '/F_RAAP_S10' folder for 'P_RAAP_S10_2' project
And waited while preview is available in folder '/F_RAAP_S10' on project 'P_RAAP_S10_2' files page
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_RAAP_S10' project 'P_RAAP_S10_2':
| Name           | Approvers     | Deadline         | Description      | Started |
| AS1_RAAP_S10_2 | UA_RAAP_S10_2 | 01/05/2023 12:15 | test description | false   |
And logged in with details of 'UC_RAAP_S10_2'
And added approval stage on file 'Fish2-Ad.mov' approvals page in folder '/F_RAAP_S10' project 'P_RAAP_S10_2':
| Name           | Approvers     | Deadline         | Description      | Started |
| AS2_RAAP_S10_2 | UA_RAAP_S10_2 | 01/05/2023 12:15 | test description | false   |
When I login with details of 'AgencyAdmin'
And go to project 'P_RAAP_S10_2' approvals not started page
And check 'All user approvals' checkbox in Approval Status area on opened project approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName     |
| Fish1-Ad.mov |
| Fish2-Ad.mov |


Scenario: Check that approval owner sees his approval stage name on 'Submitted' tab on Approvals page
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S11 | DefaultAgency |
And created  'P_RAAP_S11' project
And created '/F_RAAP_S11' folder for project 'P_RAAP_S11'
And uploaded '/images/logo.png' file into '/F_RAAP_S11' folder for 'P_RAAP_S11' project
And waited while preview is available in folder '/F_RAAP_S11' on project 'P_RAAP_S11' files page
And added approval stage on file 'logo.png' approvals page in folder '/F_RAAP_S11' project 'P_RAAP_S11':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S11 | U_RAAP_S11 | 01/05/2023 12:15 | test description | true    |
When I go to project 'P_RAAP_S11' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName | Status  | ApprovalStage |
| logo.png | Pending | AS_RAAP_S11   |


Scenario: Check that approval owner sees 'Cancelled + Closed' in Approval status column
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S12 | DefaultAgency |
And created  'P_RAAP_S12' project
And created '/F_RAAP_S12' folder for project 'P_RAAP_S12'
And uploaded '/images/logo.png' file into '/F_RAAP_S12' folder for 'P_RAAP_S12' project
And waited while preview is available in folder '/F_RAAP_S12' on project 'P_RAAP_S12' files page
And added approval stage on file 'logo.png' approvals page in folder '/F_RAAP_S12' project 'P_RAAP_S12':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S12 | U_RAAP_S12 | 01/05/2023 12:15 | test description | true    |
When I go to file 'logo.png' approvals page in folder '/F_RAAP_S12' project 'P_RAAP_S12'
And cancel approval on opened file approvals page
And go to project 'P_RAAP_S12' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName | Status             | ApprovalStage |
| logo.png | Cancelled + Closed | AS_RAAP_S12   |


Scenario: Check that approval owner sees ' + Closed' in Approval status column (Close from file details page)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       |
| <UserEmail> |
And created '<ProjectName>' project
And created '/F_RAAP_S13' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_RAAP_S13' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S13' on project '<ProjectName>' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S13' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started | Started |
| AS_RAAP_S13 | <UserEmail> | 01/05/2023 12:15 | test description | true    | true    |
When I 'uncheck' auto close checkbox on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S13' in project '<ProjectName>'
And filling Share popup by users '<UserEmail>' in project '<ProjectName>' folders '/F_RAAP_S13' with role 'project.user' expired '12.12.2020' and 'should' access to subfolders
And login with details of '<UserEmail>'
And go to Dashboard page
And click file '128_shortname.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And '<Action>' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And go to file '128_shortname.jpg' approvals page in folder '/F_RAAP_S13' project '<ProjectName>'
And close approval on opened file approvals page
And go to project '<ProjectName>' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status           | ApprovalStage |
| 128_shortname.jpg | <ApprovalStatus> | AS_RAAP_S13   |

Examples:
| UserEmail    | ProjectName  | Action  | ApprovalStatus    |
| U_RAAP_S13_1 | P_RAAP_S13_1 | Approve | Approved + Closed |
| U_RAAP_S13_2 | P_RAAP_S13_2 | Reject  | Rejected + Closed |


Scenario: Check that approval owner sees '+Closed' in Approval status column (Close from Approvals page)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       |
| <UserEmail> |
And created '<ProjectName>' project
And created '/F_RAAP_S14' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_RAAP_S14' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S14' on project '<ProjectName>' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S14' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S14 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
When I go to project '<ProjectName>' approvals submitted page
And select approval by file name '128_shortname.jpg' from folder '/F_RAAP_S14' and project '<ProjectName>' on opened approvals page
And '<Action>' selected approvals on opened approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status           | ApprovalStage |
| 128_shortname.jpg | <ApprovalStatus> | AS_RAAP_S14   |

Examples:
| UserEmail    | ProjectName  | Action  | ApprovalStatus    |
| U_RAAP_S14_1 | P_RAAP_S14_1 | Approve | Approved + Closed |
| U_RAAP_S14_2 | P_RAAP_S14_2 | Reject  | Rejected + Closed |


Scenario: Check that Approvals status is approved if stage is approved
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      |
| U_RAAP_S15 |
And created 'P_RAAP_S15' project
And created '/F_RAAP_S15' folder for project 'P_RAAP_S15'
And uploaded '/files/128_shortname.jpg' file into '/F_RAAP_S15' folder for 'P_RAAP_S15' project
And waited while preview is available in folder '/F_RAAP_S15' on project 'P_RAAP_S15' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S15' project 'P_RAAP_S15':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S15 | U_RAAP_S15 | 01/05/2023 12:15 | test description | true    |
When I 'uncheck' auto close checkbox on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S15' in project 'P_RAAP_S15'
And go to project 'P_RAAP_S15' folder '/F_RAAP_S15' page
When I 'approve' stage 'AS_RAAP_S15' with comment 'test comment' on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S15' project 'P_RAAP_S15'
And go to project 'P_RAAP_S15' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status   | ApprovalStage |
| 128_shortname.jpg | Approved | AS_RAAP_S15   |


Scenario: Check that Approvals status is rejected if stage is rejected (reject stage by owner)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      |
| U_RAAP_S16 |
And created 'P_RAAP_S16' project
And created '/F_RAAP_S16' folder for project 'P_RAAP_S16'
And uploaded '/files/128_shortname.jpg' file into '/F_RAAP_S16' folder for 'P_RAAP_S16' project
And waited while preview is available in folder '/F_RAAP_S16' on project 'P_RAAP_S16' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S16' project 'P_RAAP_S16':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S16 | U_RAAP_S16 | 01/05/2023 12:15 | test description | true    |
When I 'reject' stage 'AS_RAAP_S16' with comment 'test comment' on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S16' project 'P_RAAP_S16'
And go to project 'P_RAAP_S16' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status   | ApprovalStage |
| 128_shortname.jpg | Rejected | AS_RAAP_S16   |


Scenario: Check that Approval status is rejected if stage is rejected (after approver feedback)
Meta: @gdam
	  @approvals
!--NGN-10352
Given I created users with following fields:
| Email      |
| U_RAAP_S17 |
And created 'P_RAAP_S17' project
And created '/F_RAAP_S17' folder for project 'P_RAAP_S17'
And uploaded '/files/128_shortname.jpg' file into '/F_RAAP_S17' folder for 'P_RAAP_S17' project
And waited while preview is available in folder '/F_RAAP_S17' on project 'P_RAAP_S17' files page
And added approval stage on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S17' project 'P_RAAP_S17':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S17 | U_RAAP_S17 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_RAAP_S17'
And go to Dashboard page
And click file '128_shortname.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And 'reject' file with comment 'test comment' on opened file info page
And login with details of 'AgencyAdmin'
And go to project 'P_RAAP_S17' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status   | ApprovalStage |
| 128_shortname.jpg | Rejected | AS_RAAP_S17   |


Scenario: Check that status is taken from first stage in case of 2 stages
Meta: @bug
      @gdam
      	  @approvals
!--FAB-385-First and second scenario will fail
Given I created users with following fields:
| Email       |
| <UserEmail> |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_RAAP_S18' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_RAAP_S18' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S18' on project '<ProjectName>' files page
And created approval stage on file '128_shortname.jpg' approvals page in folder 'F_RAAP_S18' project '<ProjectName>':
| Name                      | Approvers   | Deadline         | Description      | Started |
| <FirstApprovalStageName>  | <UserEmail> | 01/05/2023 12:15 | test description | false   |
| <SecondApprovalStageName> | <UserEmail> | 01/05/2023 12:15 | test description | true    |
When I '<Action>' stage '<FirstApprovalStageName>' with comment 'test comment' on file '128_shortname.jpg' approvals page in folder '/F_RAAP_S18' project '<ProjectName>'
And go to project '<ProjectName>' approvals submitted page
Then I 'should' see following approvals on opened project approvals page:
| FileName          | Status           |
| 128_shortname.jpg | <ApprovalStatus> |

Examples:
| UserEmail    | ProjectName  | FirstApprovalStageName | SecondApprovalStageName | Action  | ApprovalStatus |
| U_RAAP_S18_1 | P_RAAP_S18_1 | AS1_RAAP_S18_1         | AS2_RAAP_S18_1          | approve | Approved       |
| U_RAAP_S18_2 | P_RAAP_S18_2 | AS1_RAAP_S18_2         | AS2_RAAP_S18_2          | reject  | Rejected       |


Scenario: Check that user can approve/reject several files from Received tab
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       | Role         |
| <UserEmail> | agency.admin |
And created '<ProjectName>' project
And created '/F_RAAP_S19' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S19' folder for '<ProjectName>' project
And uploaded '/files/image11.jpg' file into '/F_RAAP_S19' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S19' on project '<ProjectName>' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S19' project '<ProjectName>':
| Name          | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S19_1 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
When I 'uncheck' auto close checkbox on file 'image10.jpg' approvals page in folder '/F_RAAP_S19' in project '<ProjectName>'
And go to project '<ProjectName>' folder '/F_RAAP_S19' page
And add approval stage on file 'image11.jpg' approvals page in folder '/F_RAAP_S19' project '<ProjectName>':
| Name          | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S19_2 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
And 'uncheck' auto close checkbox on file 'image11.jpg' approvals page in folder '/F_RAAP_S19' in project '<ProjectName>'
And login with details of '<UserEmail>'
And go to project '<ProjectName>' approvals received page
And select approval by file name 'image10.jpg' from folder '/F_RAAP_S19' and project '<ProjectName>' on opened approvals page
And select approval by file name 'image11.jpg' from folder '/F_RAAP_S19' and project '<ProjectName>' on opened approvals page
And '<Action>' selected approvals on opened approvals page
And refresh the page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status           | ApprovalStage |
| image10.jpg | <ApprovalStatus> | AS_RAAP_S19_1 |
| image11.jpg | <ApprovalStatus> | AS_RAAP_S19_2 |

Examples:
| UserEmail    | ProjectName  | Action  | ApprovalStatus |
| U_RAAP_S19_1 | P_RAAP_S19_1 | approve | Approved       |
| U_RAAP_S19_2 | P_RAAP_S19_2 | reject  | Rejected       |


Scenario: Check that user can close several files on Submitted tab
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       |
| <UserEmail> |
And created '<ProjectName>' project
And created '/F_RAAP_S20' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S20' folder for '<ProjectName>' project
And uploaded '/files/image11.jpg' file into '/F_RAAP_S20' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S20' on project '<ProjectName>' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S20' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S20 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'image11.jpg' approvals page in folder '/F_RAAP_S20' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S20 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
When I go to project '<ProjectName>' approvals submitted page
And select approval by file name 'image10.jpg' from folder '/F_RAAP_S20' and project '<ProjectName>' on opened approvals page
And select approval by file name 'image11.jpg' from folder '/F_RAAP_S20' and project '<ProjectName>' on opened approvals page
And '<Action>' selected approvals on opened approvals page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status           | ApprovalStage |
| image10.jpg | <ApprovalStatus> | AS_RAAP_S20   |

Examples:
| UserEmail    | ProjectName  | Action  | ApprovalStatus    |
| U_RAAP_S20_1 | P_RAAP_S20_1 | Approve | Approved + Closed |
| U_RAAP_S20_2 | P_RAAP_S20_2 | Reject  | Rejected + Closed |


Scenario: Check changes on file details after multiply approvals (use Open selected button)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       |
| <UserEmail> |
And created '<ProjectName>' project
And created '/F_RAAP_S21' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S21' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S21' on project '<ProjectName>' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S21' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S21 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
When I go to project '<ProjectName>' approvals submitted page
And select approval by file name 'image10.jpg' from folder '/F_RAAP_S21' and project '<ProjectName>' on opened approvals page
And '<Action>' selected approvals on opened approvals page
And refresh the page
And select approval by file name 'image10.jpg' from folder '/F_RAAP_S21' and project '<ProjectName>' on opened approvals page
And click open selected button on approvals page
Then I 'should' see following approvers information in stage 'AS_RAAP_S21' on opened file approvals page:
| UserName    | Comment | Status   |
| <UserEmail> |         | <Status> |

Examples:
| UserEmail    | ProjectName  | Action  |Status  |
| U_RAAP_S21_1 | P_RAAP_S21_1 | Approve |Expired |
| U_RAAP_S21_2 | P_RAAP_S21_2 | Reject  |Expired |


Scenario: Check that approver can see Closed stage on Received tab (+Closed status)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       |
| <UserEmail> |
And created '<ProjectName>' project
And created '/F_RAAP_S22' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S22' folder for '<ProjectName>' project
And uploaded '/files/image11.jpg' file into '/F_RAAP_S22' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S22' on project '<ProjectName>' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S22' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S22 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
When I go to project '<ProjectName>' approvals submitted page
And select approval by file name 'image10.jpg' from folder '/F_RAAP_S22' and project '<ProjectName>' on opened approvals page
And '<Action>' selected approvals on opened approvals page
And login with details of '<UserEmail>'
When I go to project '<ProjectName>' approvals received page
And refresh the page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status           | ApprovalStage |
| image10.jpg | <ApprovalStatus> | AS_RAAP_S22   |

Examples:
| UserEmail    | ProjectName  | Action  | ApprovalStatus    |
| U_RAAP_S22_1 | P_RAAP_S22_1 | Approve | Approved + Closed |
| U_RAAP_S22_2 | P_RAAP_S22_2 | Reject  | Rejected + Closed |


Scenario: Check that Approve/Reject buttons are not active when nothing is selected  ('Received' tab)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      |
| U_RAAP_S23 |
And created 'P_RAAP_S23' project
And created '/F_RAAP_S23' folder for project 'P_RAAP_S23'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S23' folder for 'P_RAAP_S23' project
And waited while preview is available in folder '/F_RAAP_S23' on project 'P_RAAP_S23' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S23' project 'P_RAAP_S23':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S23 | U_RAAP_S23 | 01/05/2023 12:15 | test description | true    |
And logged in with details of 'U_RAAP_S23'
When I go to project 'P_RAAP_S23' approvals received page
And refresh the page
Then I 'should' see 'approve' button disabled on opened approvals page
And 'should' see 'reject' button disabled on opened approvals page


Scenario: Check that Approve/Reject buttons are not active when nothing is selected ('Submitted' tab)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      |
| U_RAAP_S24 |
And created 'P_RAAP_S24' project
And created '/F_RAAP_S24' folder for project 'P_RAAP_S24'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S24' folder for 'P_RAAP_S24' project
And waited while preview is available in folder '/F_RAAP_S24' on project 'P_RAAP_S24' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S24' project 'P_RAAP_S24':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S24 | U_RAAP_S24 | 01/05/2023 12:15 | test description | true    |
When I go to project 'P_RAAP_S24' approvals submitted page
And refresh the page
Then I 'should' see 'approve' button disabled on opened approvals page
And 'should' see 'reject' button disabled on opened approvals page


Scenario: Check that by default files approved by user should remain visible to user on Received tab with a status of their action (Approved / Rejected)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       |
| <UserEmail> |
And created '<ProjectName>' project
And created '/F_RAAP_S25' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S25' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S25' on project '<ProjectName>' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S25' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S25 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
When I 'uncheck' auto close checkbox on file 'image10.jpg' approvals page in folder '/F_RAAP_S25' in project '<ProjectName>'
And login with details of '<UserEmail>'
And go to file 'image10.jpg' approvals page in folder '/F_RAAP_S25' project '<ProjectName>'
And '<Action>' file with comment 'test comment' on opened file info page
And go to project '<ProjectName>' approvals received page
And refresh the page
And wait for '5' seconds
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status           | ApprovalStage |
| image10.jpg | <ApprovalStatus> | AS_RAAP_S25   |

Examples:
| UserEmail    | ProjectName  | Action  | ApprovalStatus |
| U_RAAP_S25_1 | P_RAAP_S25_1 | Approve | Approved       |


Scenario: Check that by default files approved by user should remain visible to user on Received tab with a status of their action (Pending)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      |
| U_RAAP_S26 |
And created 'P_RAAP_S26' project
And created '/F_RAAP_S26' folder for project 'P_RAAP_S26'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S26' folder for 'P_RAAP_S26' project
And waited while preview is available in folder '/F_RAAP_S26' on project 'P_RAAP_S26' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S26' project 'P_RAAP_S26':
| Name        | Approvers  | Deadline         | Description      | Started |
| AS_RAAP_S26 | U_RAAP_S26 | 01/05/2023 12:15 | test description | true    |
And logged in with details of 'U_RAAP_S26'
When I go to project 'P_RAAP_S26' approvals received page
Then I 'should' see following approvals on opened project approvals page:
| FileName    | Status  | ApprovalStage |
| image10.jpg | Pending | AS_RAAP_S26   |



Scenario: Check that files should be hidden if users un-ticks checkbox 'Include completed approvals'
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email       |
| <UserEmail> |
And created '<ProjectName>' project
And created '/F_RAAP_S27' folder for project '<ProjectName>'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S27' folder for '<ProjectName>' project
And waited while preview is available in folder '/F_RAAP_S27' on project '<ProjectName>' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S27' project '<ProjectName>':
| Name        | Approvers   | Deadline         | Description      | Started |
| AS_RAAP_S27 | <UserEmail> | 01/05/2023 12:15 | test description | true    |
When I go to project '<ProjectName>' approvals submitted page
And select approval by file name 'image10.jpg' from folder '/F_RAAP_S27' and project '<ProjectName>' on opened approvals page
And '<Action>' selected approvals on opened approvals page
And refresh the page
And uncheck 'Include completed approvals' checkbox in Approval Status area on opened project approvals page
Then I 'should not' see following approvals on opened project approvals page:
| FileName    | ApprovalStage |
| image10.jpg | AS_RAAP_S27   |

Examples:
| UserEmail    | ProjectName  | Action  |
| U_RAAP_S27_1 | P_RAAP_S27_1 | Approve |
| U_RAAP_S27_2 | P_RAAP_S27_2 | Reject  |


Scenario: Check stage counter in case of 1 approvals stage (Approvals - > Received tab)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Role        |Agency        |
| U_RAAP_S28 | agency.user |DefaultAgency |
And created  'P_RAAP_S28' project
And created '/F_RAAP_S28' folder for project 'P_RAAP_S28'
And uploaded '/images/logo.png' file into '/F_RAAP_S28' folder for 'P_RAAP_S28' project
And waited while preview is available in folder '/F_RAAP_S28' on project 'P_RAAP_S28' files page
And added approval stage on file 'logo.png' approvals page in folder '/F_RAAP_S28' project 'P_RAAP_S28':
| Name        | Approvers  | Deadline         | Description      |
| AS_RAAP_S28 | U_RAAP_S28 | 28/05/2023 12:15 | test description |
When I login with details of 'U_RAAP_S28'
And go to projects approvals received page
Then I 'should' see following count '1' of approvals on received page


Scenario: Check that you see advertiser only for created approval (Submitted tab)
Meta: @gdam
	  @approvals
Given I created the agency 'A_RAAP_S29' with default attributes
And created users with following fields:
| Email        | Role         | Agency     |
| U_RAAP_S29_1 | agency.admin | A_RAAP_S29 |
| U_RAAP_S29_2 | agency.user  | A_RAAP_S29 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_RAAP_S29':
| Advertiser    |
| AR_RAAP_S29_1 |
| AR_RAAP_S29_2 |
And logged in with details of 'U_RAAP_S29_1'
And created new project with following fields:
| FieldName  | FieldValue    |
| Name       | P_RAAP_S29    |
| Media type | Broadcast     |
| Advertiser | AR_RAAP_S29_1 |
| Start date | Today         |
| End date   | Tomorrow      |
And published the project 'P_RAAP_S29'
And created '/F_RAAP_S29' folder for project 'P_RAAP_S29'
And uploaded '/files/image10.jpg' file into '/F_RAAP_S29' folder for 'P_RAAP_S29' project
And waited while preview is available in folder '/F_RAAP_S29' on project 'P_RAAP_S29' files page
And added approval stage on file 'image10.jpg' approvals page in folder '/F_RAAP_S29' project 'P_RAAP_S29':
| Name        | Approvers    | Deadline         | Description      | Started |
| AS_RAAP_S29 | U_RAAP_S29_2 | 01/05/2023 12:15 | test description | true    |
When I go to projects approvals submitted page
Then I 'should' see 'AR_RAAP_S29_1' clients on opened projects approvals page
And 'should not' see 'AR_RAAP_S29_2' clients on opened projects approvals page


Scenario: Check that user sees in the client's list only advertiser of created approval (Received tab)
Meta: @gdam
	  @approvals
Given I created the agency 'A_RAAP_S30' with default attributes
And I created users with following fields:
| Email        | Role         | Agency     |
| U_RAAP_S30_1 | agency.admin | A_RAAP_S30 |
| U_RAAP_S30_2 | agency.user  | A_RAAP_S30 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_RAAP_S30':
| Advertiser    |
| AR_RAAP_S30_1 |
| AR_RAAP_S30_2 |
And logged in with details of 'U_RAAP_S30_1'
And created new project with following fields:
| FieldName  | FieldValue    |
| Name       | P_RAAP_S30    |
| Media type | Broadcast     |
| Advertiser | AR_RAAP_S30_2 |
| Start date | Today         |
| End date   | Tomorrow      |
And published the project 'P_RAAP_S30'
And created '/F_RAAP_S30' folder for project 'P_RAAP_S30'
And uploaded '/files/Fish Ad.mov' file into '/F_RAAP_S30' folder for 'P_RAAP_S30' project
And waited while preview is available in folder '/F_RAAP_S30' on project 'P_RAAP_S30' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAAP_S30' project 'P_RAAP_S30':
| Name        | Approvers    | Deadline         | Description      | Started |
| AS_RAAP_S30 | U_RAAP_S30_2 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_RAAP_S30_2'
And go to projects approvals received page
Then I 'should' see 'AR_RAAP_S30_2' clients on opened projects approvals page
And 'should not' see 'AR_RAAP_S30_1' clients on opened projects approvals page


Scenario: Check that you see advertiser of another BU in the list after creating approval (approver from another agency)
Meta: @gdam
	  @approvals
Given I created the agency 'A_RAAP_S31_1' with default attributes
And created the agency 'A_RAAP_S31_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_RAAP_S31_1 | agency.admin | A_RAAP_S31_1 |
| U_RAAP_S31_2 | agency.user  | A_RAAP_S31_2 |
And logged in with details of 'U_RAAP_S31_1'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_RAAP_S31_1':
| Advertiser    |
| AR_RAAP_S31_1 |
| AR_RAAP_S31_2 |
And created new project with following fields:
| FieldName  | FieldValue    |
| Name       | P_RAAP_S31    |
| Media type | Broadcast     |
| Advertiser | AR_RAAP_S31_2 |
| Start date | Today         |
| End date   | Tomorrow      |
And published the project 'P_RAAP_S31'
And created '/F_RAAP_S31' folder for project 'P_RAAP_S31'
And uploaded '/files/Fish Ad.mov' file into '/F_RAAP_S31' folder for 'P_RAAP_S31' project
And waited while preview is available in folder '/F_RAAP_S31' on project 'P_RAAP_S31' files page
And added approval stage on file 'Fish Ad.mov' approvals page in folder '/F_RAAP_S31' project 'P_RAAP_S31':
| Name        | Approvers    | Deadline         | Description      | Started |
| AS_RAAP_S31 | U_RAAP_S31_2 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_RAAP_S31_2'
And go to projects approvals received page
Then I 'should' see 'AR_RAAP_S31_2' clients on opened projects approvals page




Scenario: Check that user's sorting is saved after next open page (Approvals ->Received tab)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |
| U_RAAP_S35 | DefaultAgency |
And created  'P_ARAAP_S35' project
And created  'P_BRAAP_S35' project
And created  'P_CRAAP_S35' project
And created '/F_RAAP_S35' folder for project 'P_ARAAP_S35'
And created '/F_RAAP_S35' folder for project 'P_BRAAP_S35'
And created '/F_RAAP_S35' folder for project 'P_CRAAP_S35'
And uploaded '/files/boxed-split.avi' file into '/F_RAAP_S35' folder for 'P_ARAAP_S35' project
And uploaded '/files/logo3.jpg' file into '/F_RAAP_S35' folder for 'P_BRAAP_S35' project
And uploaded '/files/voiceclip.mp4' file into '/F_RAAP_S35' folder for 'P_CRAAP_S35' project
And waited while preview is available in folder '/F_RAAP_S35' on project 'P_ARAAP_S35' files page
And waited while preview is available in folder '/F_RAAP_S35' on project 'P_BRAAP_S35' files page
And waited while preview is available in folder '/F_RAAP_S35' on project 'P_CRAAP_S35' files page
And added approval stage on file 'boxed-split.avi' approvals page in folder '/F_RAAP_S35' project 'P_ARAAP_S35':
| Name           | Approvers  | Deadline         | Description      | Started |
| AS_ARAAP_S35_1 | U_RAAP_S35 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'logo3.jpg' approvals page in folder '/F_RAAP_S35' project 'P_BRAAP_S35':
| Name           | Approvers  | Deadline         | Description      | Started |
| AS_BRAAP_S34_1 | U_RAAP_S35 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'voiceclip.mp4' approvals page in folder '/F_RAAP_S35' project 'P_CRAAP_S35':
| Name           | Approvers  | Deadline         | Description      | Started |
| AS_CRAAP_S35_1 | U_RAAP_S35 | 01/05/2023 12:15 | test description | true    |
When I login with details of 'U_RAAP_S35'
And go to projects approvals received page
And sort approvals by field 'Project' by 'desc' on approvals opened received page
And go to projects approvals not started page
And go to projects approvals received page
Then I should see sorted approvals by field 'Project' by 'desc' on opened approvals received page
When I sort approvals by field 'FileName' by 'desc' on approvals opened received page
And go to projects approvals submitted page
And go to projects approvals received page
Then I should see sorted approvals by field 'FileName' by 'desc' on opened approvals received page


Scenario: Check that user's sorting is saved after switch between pages (Approvals -> Submitted tab)
Meta: @gdam
	  @approvals
Given I created users with following fields:
| Email      | Agency        |Access|
| U_RAAP_S34 | DefaultAgency |streamlined_library,library,adkits,folders,approvals,dashboard|
And created  'P_ARAAP_S34' project
And created  'P_BRAAP_S34' project
And created  'P_CRAAP_S34' project
And created '/F_RAAP_S34' folder for project 'P_ARAAP_S34'
And created '/F_RAAP_S34' folder for project 'P_BRAAP_S34'
And created '/F_RAAP_S34' folder for project 'P_CRAAP_S34'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/F_RAAP_S34' folder for 'P_ARAAP_S34' project
And uploaded '/files/Fish-Ad.mov' file into '/F_RAAP_S34' folder for 'P_BRAAP_S34' project
And uploaded '/files/video10s.avi' file into '/F_RAAP_S34' folder for 'P_CRAAP_S34' project
And waited while preview is available in folder '/F_RAAP_S34' on project 'P_ARAAP_S34' files page
And waited while preview is available in folder '/F_RAAP_S34' on project 'P_BRAAP_S34' files page
And waited while preview is available in folder '/F_RAAP_S34' on project 'P_CRAAP_S34' files page
And added approval stage on file '13DV-CAPITAL-10.mpg' approvals page in folder '/F_RAAP_S34' project 'P_ARAAP_S34':
| Name           | Approvers  | Deadline         | Description      | Started |
| AS_ARAAP_S34_1 | U_RAAP_S34 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'Fish-Ad.mov' approvals page in folder '/F_RAAP_S34' project 'P_BRAAP_S34':
| Name           | Approvers  | Deadline         | Description      | Started |
| AS_BRAAP_S34_1 | U_RAAP_S34 | 01/05/2023 12:15 | test description | true    |
And added approval stage on file 'video10s.avi' approvals page in folder '/F_RAAP_S34' project 'P_CRAAP_S34':
| Name           | Approvers  | Deadline         | Description      | Started |
| AS_CRAAP_S34_1 | U_RAAP_S34 | 01/05/2023 12:15 | test description | true    |
When I go to projects approvals submitted page
And sort approvals by field 'Project' by 'asc' on  opened approvals submitted page
And go to Dashboard page
And go to projects approvals submitted page
Then I should see sorted approvals by field 'Project' by 'asc' on opened approvals submitted page
When I sort approvals by field 'FileName' by 'asc' on opened approvals submitted page
And I go to the Library pageNEWLIB
And go to projects approvals submitted page
Then I should see sorted approvals by field 'FileName' by 'asc' on opened approvals submitted page


