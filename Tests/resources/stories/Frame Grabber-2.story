!--QA-358
Feature:             Automating--Framegrabber
Narrative:
In order to
As a                 AgencyAdmin
I want to            Check user of the BU can access Frame Grabber functionality that is made available for him


Scenario: Check that timecode format of frame grabber is of correct format for mov file format under Projects
Meta:@gdam
@projects
!-- QA-1215
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_FRGRB_1' with default attributes
And updated the following agency:
| Name      | Storage | Enable Frame Grabber Module |
| A_FRGRB_1 | S3      | should                      |
And created users with following fields:
| Email       | Role            | Agency    |
| U_FRGRB_1   | agency.admin    | A_FRGRB_1 |
And I logged in with details of 'U_FRGRB_1'
And I set 'on' 'frame_grabber' application checkbox on user 'U_FRGRB_1' details page
And I created 'P_FRGRB_1' project
And created '/F1' folder for project 'P_FRGRB_1'
And uploaded into project 'P_FRGRB_1' following files:
| FileName             | Path  |
| /files/Fish1-Ad.mov  | /F1   |
And waited while preview is available in folder '/F1' on project 'P_FRGRB_1' files page
When I open frames page in project 'P_FRGRB_1' folder '/F1' of file 'Fish1-Ad.mov'
And I grab '1' frame from played clip on opened frames page
Then I 'should' be able to validate grabbed frames '1' Timecode on opened frames page


Scenario: Check that timecode format of frame grabber is of correct format for mpg file format under Projects
Meta:@gdam
@projects
!-- QA-1215
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_FRGRB_2' with default attributes
And updated the following agency:
| Name      | Storage | Enable Frame Grabber Module |
| A_FRGRB_2 | S3      | should                      |
And created users with following fields:
| Email       | Role            | Agency    |
| U_FRGRB_2   | agency.admin    | A_FRGRB_2 |
And I logged in with details of 'U_FRGRB_2'
And I set 'on' 'frame_grabber' application checkbox on user 'U_FRGRB_2' details page
And I created 'P_FRGRB_2' project
And created '/F1' folder for project 'P_FRGRB_2'
And uploaded into project 'P_FRGRB_2' following files:
| FileName             | Path  |
| /files/Fish1-Ad.mpg  | /F1   |
And waited while preview is available in folder '/F1' on project 'P_FRGRB_2' files page
When I open frames page in project 'P_FRGRB_2' folder '/F1' of file 'Fish1-Ad.mpg'
And I grab '1' frame from played clip on opened frames page
Then I 'should' be able to validate grabbed frames '1' Timecode on opened frames page


Scenario: Check that timecode format of frame grabber is of correct format for wmv file format under Projects
Meta:@gdam
@projects
!-- QA-1215
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_FRGRB_3' with default attributes
And updated the following agency:
| Name      | Storage | Enable Frame Grabber Module |
| A_FRGRB_3 | S3      | should                      |
And created users with following fields:
| Email       | Role            | Agency    |
| U_FRGRB_3   | agency.admin    | A_FRGRB_3 |
And I logged in with details of 'U_FRGRB_3'
And I set 'on' 'frame_grabber' application checkbox on user 'U_FRGRB_3' details page
And I created 'P_FRGRB_3' project
And created '/F1' folder for project 'P_FRGRB_3'
And uploaded into project 'P_FRGRB_3' following files:
| FileName             | Path  |
| /files/Fish1-Ad.wmv  | /F1   |
And waited while preview is available in folder '/F1' on project 'P_FRGRB_3' files page
When I open frames page in project 'P_FRGRB_3' folder '/F1' of file 'Fish1-Ad.wmv'
And I grab '1' frame from played clip on opened frames page
Then I 'should' be able to validate grabbed frames '1' Timecode on opened frames page


Scenario: Check that timecode format of frame grabber is of correct format for mp4 file format under Projects
Meta:@gdam
@projects
!-- QA-1215
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_FRGRB_4' with default attributes
And updated the following agency:
| Name      | Storage | Enable Frame Grabber Module |
| A_FRGRB_4 | S3      | should                      |
And created users with following fields:
| Email       | Role            | Agency    |
| U_FRGRB_4   | agency.admin    | A_FRGRB_4 |
And I logged in with details of 'U_FRGRB_4'
And I set 'on' 'frame_grabber' application checkbox on user 'U_FRGRB_4' details page
And I created 'P_FRGRB_4' project
And created '/F1' folder for project 'P_FRGRB_4'
And uploaded into project 'P_FRGRB_4' following files:
| FileName             | Path  |
| /files/Fish1-Ad.mp4  | /F1   |
And waited while preview is available in folder '/F1' on project 'P_FRGRB_4' files page
When I open frames page in project 'P_FRGRB_4' folder '/F1' of file 'Fish1-Ad.mp4'
And I grab '1' frame from played clip on opened frames page
Then I 'should' be able to validate grabbed frames '1' Timecode on opened frames page


Scenario: Check that timecode format of frame grabber is of correct format for mov file format under Library
Meta:@gdam
@uitobe
!-- QA-1215
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_FRGRB_5' with default attributes
And updated the following agency:
| Name      | Storage | Enable Frame Grabber Module |
| A_FRGRB_5 | S3      | should                      |
And created users with following fields:
| Email       | Role            | Agency    |
| U_WRSUU_5   | agency.admin    | A_FRGRB_5 |
And I logged in with details of 'U_WRSUU_5'
And I set 'on' 'frame_grabber' application checkbox on user 'U_WRSUU_5' details page
And uploaded asset '/files/Fish1-Ad.mov' into library
And waited while preview is available in collection 'My Assets'
When I go to  asset 'Fish1-Ad.mov' frames page in Library for collection 'My Assets'
And I grab '1' frame from played clip on opened frames page from Library
Then I 'should' be able to validate grabbed frames '1' Timecode on opened frames page from Library


Scenario: Check that timecode format of frame grabber is of correct format for wmv file format under Library
Meta:@gdam
@uitobe
!-- QA-1215
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_FRGRB_6' with default attributes
And updated the following agency:
| Name      | Storage | Enable Frame Grabber Module |
| A_FRGRB_6 | S3      | should                      |
And created users with following fields:
| Email       | Role            | Agency    |
| U_WRSUU_6   | agency.admin    | A_FRGRB_6 |
And I logged in with details of 'U_WRSUU_6'
And I set 'on' 'frame_grabber' application checkbox on user 'U_WRSUU_6' details page
And uploaded asset '/files/Fish1-Ad.wmv' into library
And waited while preview is available in collection 'My Assets'
When I go to  asset 'Fish1-Ad.wmv' frames page in Library for collection 'My Assets'
And I grab '1' frame from played clip on opened frames page from Library
Then I 'should' be able to validate grabbed frames '1' Timecode on opened frames page from Library


Scenario: Check that timecode format of frame grabber is of correct format for mp4 file format under Library
Meta:@gdam
@uitobe
!-- QA-1215
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_FRGRB_7' with default attributes
And updated the following agency:
| Name      | Storage | Enable Frame Grabber Module |
| A_FRGRB_7 | S3      | should                      |
And created users with following fields:
| Email       | Role            | Agency    |
| U_WRSUU_7   | agency.admin    | A_FRGRB_7 |
And I logged in with details of 'U_WRSUU_7'
And I set 'on' 'frame_grabber' application checkbox on user 'U_WRSUU_7' details page
And uploaded asset '/files/Fish1-Ad.mp4' into library
And waited while preview is available in collection 'My Assets'
When I go to  asset 'Fish1-Ad.mp4' frames page in Library for collection 'My Assets'
And I grab '1' frame from played clip on opened frames page from Library
Then I 'should' be able to validate grabbed frames '1' Timecode on opened frames page from Library


Scenario: Check that timecode format of frame grabber is of correct format for mpg file format under Library
Meta:@gdam
@uitobe
!-- QA-1215
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_FRGRB_8' with default attributes
And updated the following agency:
| Name      | Storage | Enable Frame Grabber Module |
| A_FRGRB_8 | S3      | should                      |
And created users with following fields:
| Email       | Role            | Agency    |
| U_WRSUU_8   | agency.admin    | A_FRGRB_8 |
And I logged in with details of 'U_WRSUU_8'
And I set 'on' 'frame_grabber' application checkbox on user 'U_WRSUU_8' details page
And uploaded asset '/files/Fish1-Ad.mpg' into library
And waited while preview is available in collection 'My Assets'
When I go to  asset 'Fish1-Ad.mpg' frames page in Library for collection 'My Assets'
And I grab '1' frame from played clip on opened frames page from Library
Then I 'should' be able to validate grabbed frames '1' Timecode on opened frames page from Library