!--QA-358
Feature:             Automating--Framegrabber
Narrative:
In order to
As a                 AgencyAdmin
I want to            Check user of the BU can access Frame Grabber functionality that is made available for him

Scenario: Check that if global admin  hides/unhides 'Frame Grabber' access for BU,Users from this BU should not see Frames tab in asset info page - Postive case
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the agency 'AUTOFRAMGRANB_A_1' with default attributes
And created users with following fields:
| Email              | Role         | Agency            |
| UAUTOFRAMGRANB_U_1 | agency.admin | AUTOFRAMGRANB_A_1 |
When I update the following agency over core:
| Name              | Enable Frame Grabber Module |
| AUTOFRAMGRANB_A_1 | <state>                     |
And I logout from account
And login with details of 'UAUTOFRAMGRANB_U_1'
And I set '<condition>' '<Application>' application checkbox on user 'UAUTOFRAMGRANB_U_1' details page
And I created '<ProjectName>' projects
And create '<FolderNmae>' folder for project '<ProjectName>'
And upload '/files/Fish1-Ad.mov' file into '<FolderNmae>' folder for '<ProjectName>' project
And wait while preview is available in folder '<FolderNmae>' on project '<ProjectName>' files page
And go to file '/files/Fish1-Ad.mov' info page in folder '<FolderNmae>' project '<ProjectName>'
Then I '<state>' see active 'Frames' tab on file '/files/Fish1-Ad.mov' info page in folder '<FolderNmae>' project '<ProjectName>'


Examples:
| state       | condition  | Application   | ProjectName        | FolderNmae         |
| should      | on         | frame_grabber |P_AUTOFRAMGRANB_P_1 |/P_AUTOFRAMGRANB_F_1|


Scenario: Check that if global admin  hides/unhides 'Frame Grabber' access for BU,Users from this BU should not see Frames tab in asset info page - Negative case
Meta:@gdam
@projects
Given I logged in as 'GlobalAdmin'
And I created the agency 'AUTOFRAMGRANB_A_1' with default attributes
And created users with following fields:
| Email              | Role         | Agency            |
| UAUTOFRAMGRANB_U_1 | agency.admin | AUTOFRAMGRANB_A_1 |
When I update the following agency over core:
| Name              | Enable Frame Grabber Module |
| AUTOFRAMGRANB_A_1 | <state>                     |
And I logout from account
And login with details of 'UAUTOFRAMGRANB_U_1'
Then I 'should not' see 'frame_grabber' application access checkbox on user 'UAUTOFRAMGRANB_U_1' details page
When I created '<ProjectName>' projects
And create '<FolderNmae>' folder for project '<ProjectName>'
And upload '/files/Fish1-Ad.mov' file into '<FolderNmae>' folder for '<ProjectName>' project
And wait while preview is available in folder '<FolderNmae>' on project '<ProjectName>' files page
And go to file '/files/Fish1-Ad.mov' info page in folder '<FolderNmae>' project '<ProjectName>'
Then I '<state>' see active 'Frames' tab on file '/files/Fish1-Ad.mov' info page in folder '<FolderNmae>' project '<ProjectName>'


Examples:
| state       | condition  | Application   | ProjectName        | FolderNmae         |
| should not  | off        | frame_grabber |P_AUTOFRAMGRANB_P_2 |/P_AUTOFRAMGRANB_F_2|

Scenario: Check that if global admin unhides 'Frame Grabber' access for BU,Users from this BU should be able to Grab frames from Projects, once saved and also can be removed
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I logged in as 'GlobalAdmin'
And I updated the following agency over core:
| Name          | Enable Frame Grabber Module |
| DefaultAgency | should                      |
And I created users with following fields:
| Email              | Role         |Agency       |
| UAUTOFRAMGRANB_U_2 | agency.admin |DefaultAgency|
And logged in with details of 'UAUTOFRAMGRANB_U_2'
And I set 'on' 'frame_grabber' application checkbox on user 'UAUTOFRAMGRANB_U_2' details page
And created 'P_AUTOFRAMGRANB_P_3' project with 'AllFilledFields' with Delay
And created '/P_AUTOFRAMGRANB_F_3' folder for project 'P_AUTOFRAMGRANB_P_3'
And uploaded into project 'P_AUTOFRAMGRANB_P_3' following files:
| FileName                  | Path                 |
| /files/Fish1-Ad.mov       | /P_AUTOFRAMGRANB_F_3 |
And waited while preview is available in folder '/P_AUTOFRAMGRANB_F_3' on project 'P_AUTOFRAMGRANB_P_3' files page
When I open frames page in project 'P_AUTOFRAMGRANB_P_3' folder '/P_AUTOFRAMGRANB_F_3' of file 'Fish1-Ad.mov'
And I grab '2' frame from played clip on opened frames page
Then I 'should' be able to see grabbed frames '2' on opened frames page
And I 'should' be able to see grabbed frames preview on opened frames page
And wait for '2' seconds
And I remove frame from played clip on opened frames page
Then I 'should' be able to see grabbed frames '1' on opened frames page


Scenario: Check that if global admin unhides 'Frame Grabber' access for BU,Users from this BU should be able to Grab frames from Library, once saved and also can be removed
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @uitobe
Given I logged in as 'GlobalAdmin'
And I updated the following agency over core:
| Name          | Enable Frame Grabber Module |
| DefaultAgency | should                      |
And I created users with following fields:
| Email              | Role         |Agency       |
| UAUTOFRAMGRANB_U_3 | agency.admin |DefaultAgency|
And logged in with details of 'UAUTOFRAMGRANB_U_3'
And I set 'on' 'frame_grabber' application checkbox on user 'UAUTOFRAMGRANB_U_3' details page
And uploaded asset '/files/Fish1-Ad.mov' into library
And waited while preview is available in collection 'My Assets'
When I go to  asset 'Fish1-Ad.mov' frames page in Library for collection 'My Assets'
And I grab '2' frame from played clip on opened frames page from Library
Then I 'should' be able to see grabbed frames '2' on opened frames page from Library
And I 'should' be able to see grabbed frames preview on opened frames page from Library
And wait for '2' seconds
And I remove frame from played clip on opened frames page from Library
Then I 'should' be able to see grabbed frames '1' on opened frames page

Scenario: Check that user can select and remove multiple grabbed frames from projects at a time
Meta: @qagdamsmoke
      @gdam
      @projects
      !--QA-725
Given I logged in as 'GlobalAdmin'
And I updated the following agency over core:
| Name          | Enable Frame Grabber Module | Storage |
| DefaultAgency | should                      | S3      |
And I created users with following fields:
| Email              | Role         |Agency       |
| UAUTOFRAMGRANB_U_4 | agency.admin |DefaultAgency|
And logged in with details of 'UAUTOFRAMGRANB_U_4'
And I set 'on' 'frame_grabber' application checkbox on user 'UAUTOFRAMGRANB_U_4' details page
And created 'P_AUTOFRAMGRANB_P_4' project with 'AllFilledFields' with Delay
And created '/P_AUTOFRAMGRANB_F_4' folder for project 'P_AUTOFRAMGRANB_P_4'
And uploaded into project 'P_AUTOFRAMGRANB_P_4' following files:
| FileName                  | Path                 |
| /files/Fish1-Ad.mov       | /P_AUTOFRAMGRANB_F_4 |
And waited while preview is available in folder '/P_AUTOFRAMGRANB_F_4' on project 'P_AUTOFRAMGRANB_P_4' files page
When I open frames page in project 'P_AUTOFRAMGRANB_P_4' folder '/P_AUTOFRAMGRANB_F_4' of file 'Fish1-Ad.mov'
And I grab '3' frame from played clip on opened frames page
Then I 'should' be able to see grabbed frames '3' on opened frames page
And I 'should' be able to see grabbed frames preview on opened frames page
And wait for '2' seconds
When I select all grabbed frames checkbox
And I remove multiple frames from played clip on opened frames page
Then I 'should' be able to see grabbed frames '0' on opened frames page

Scenario: Check that user can select and remove multiple grabbed frames from library at a time
Meta: @qagdamsmoke
      @gdam
      @uitobe
      !--QA-725
Given I logged in as 'GlobalAdmin'
And I updated the following agency over core:
| Name          | Enable Frame Grabber Module | Storage |
| DefaultAgency | should                      | S3      |
And I created users with following fields:
| Email              | Role         |Agency       |
| UAUTOFRAMGRANB_U_5 | agency.admin |DefaultAgency|
And logged in with details of 'UAUTOFRAMGRANB_U_5'
And I set 'on' 'frame_grabber' application checkbox on user 'UAUTOFRAMGRANB_U_5' details page
And uploaded asset '/files/Fish1-Ad.mov' into library
And waited while preview is available in collection 'My Assets'
When I go to  asset 'Fish1-Ad.mov' frames page in Library for collection 'My Assets'
And I grab '3' frame from played clip on opened frames page from Library
Then I 'should' be able to see grabbed frames '3' on opened frames page from Library
And I 'should' be able to see grabbed frames preview on opened frames page from Library
And wait for '2' seconds
When I select all grabbed frames checkbox
And I remove multiple frames from played clip on opened frames page
Then I 'should' be able to see grabbed frames '0' on opened frames page

Scenario: Check that user can select and download multiple grabbed frames from projects at a time
Meta: @qagdamsmoke
      @gdam
      @projects
      !--QA-725
Given I logged in as 'GlobalAdmin'
And I updated the following agency over core:
| Name          | Enable Frame Grabber Module | Storage |
| DefaultAgency | should                      | S3      |
And I created users with following fields:
| Email              | Role         |Agency       |
| UAUTOFRAMGRANB_U_6 | agency.admin |DefaultAgency|
And logged in with details of 'UAUTOFRAMGRANB_U_6'
And I set 'on' 'frame_grabber' application checkbox on user 'UAUTOFRAMGRANB_U_6' details page
And created 'P_AUTOFRAMGRANB_P_6' project with 'AllFilledFields' with Delay
And created '/P_AUTOFRAMGRANB_F_6' folder for project 'P_AUTOFRAMGRANB_P_6'
And uploaded into project 'P_AUTOFRAMGRANB_P_6' following files:
| FileName                  | Path                 |
| /files/Fish1-Ad.mov       | /P_AUTOFRAMGRANB_F_6 |
And waited while preview is available in folder '/P_AUTOFRAMGRANB_F_6' on project 'P_AUTOFRAMGRANB_P_6' files page
When I open frames page in project 'P_AUTOFRAMGRANB_P_6' folder '/P_AUTOFRAMGRANB_F_6' of file 'Fish1-Ad.mov'
And I grab '3' frame from played clip on opened frames page
And wait for '5' seconds
And I select all grabbed frames checkbox
And I click on download button
Then I download multiple frame grabbed 'master' file 'Fish1-Ad.mov' on folder '/P_AUTOFRAMGRANB_F_6' project 'P_AUTOFRAMGRANB_P_6' file

Scenario: Check that user can select and download multiple grabbed frames from library at a time
Meta: @qagdamsmoke
      @gdam
      @uitobe
      !--QA-725
Given I logged in as 'GlobalAdmin'
And I updated the following agency over core:
| Name          | Enable Frame Grabber Module | Storage |
| DefaultAgency | should                      | S3      |
And I created users with following fields:
| Email              | Role         |Agency       |
| UAUTOFRAMGRANB_U_7 | agency.admin |DefaultAgency|
And logged in with details of 'UAUTOFRAMGRANB_U_7'
And I set 'on' 'frame_grabber' application checkbox on user 'UAUTOFRAMGRANB_U_7' details page
And uploaded asset '/files/Fish1-Ad.mov' into library
And waited while preview is available in collection 'My Assets'
When I go to  asset 'Fish1-Ad.mov' frames page in Library for collection 'My Assets'
And I grab '3' frame from played clip on opened frames page from Library
And wait for '5' seconds
And I select all grabbed frames checkbox
And I click on download button
Then I download multiple frame grabbed 'master' file 'Fish1-Ad.mov' in collection 'My Assets' from Library