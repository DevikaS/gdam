!--NGN-11682
Feature:          User can see link to Work Request in Asset Details in Library
BookNarrative:
In order to
As a              AgencyAdmin
I want to         User can see link to Work Request in Asset Details in Library


Scenario: check that when Asset is added to Adaptation Project user should track Link to this project in Asset tab: Related Projects
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name              |
| /files/image9.jpg |
When I wait while transcoding is finished in collection 'Everything'NEWLIB
And create 'P_UCSLTWRIADIL_S01' project
And create '/F_UCSLTWRIADIL_S01' folder for project 'P_UCSLTWRIADIL_S01'
And add following asset 'image9.jpg' of collection 'Everything' to project 'P_UCSLTWRIADIL_S01' folder '/F_UCSLTWRIADIL_S01'
And I go to asset 'image9.jpg' related projects info page in Library for collection 'Everything' NEWLIB
Then 'should' see following originated project name 'P_UCSLTWRIADIL_S01' on assets related projects info page in Library NEWLIB


Scenario: check that when Asset is added to Adaptation Work Request user should track Link to this work request in Asset tab: Related Projects
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name              |
| /files/image9.jpg |
When I wait while transcoding is finished in collection 'Everything'NEWLIB
And create 'WR_UCSLTWRIADIL_S02' work request
And create '/F_UCSLTWRIADIL_S02' folder for work request 'WR_UCSLTWRIADIL_S02'
And add following asset 'image9.jpg' of collection 'Everything' to work request 'WR_UCSLTWRIADIL_S02' folder '/F_UCSLTWRIADIL_S02'
And I go to asset 'image9.jpg' related projects info page in Library for collection 'Everything' NEWLIB
Then 'should' see following originated work request name 'WR_UCSLTWRIADIL_S02' on assets related projects info page in Library NEWLIB


Scenario: check that links are absent when projects was removed
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role          | Access   |
| UCSLTWRIADIL_U1 | agency.admin | streamlined_library,folders,adkits  |
And logged in with details of 'UCSLTWRIADIL_U1'
And I uploaded following assetsNEWLIB:
| Name              |
| /files/image9.jpg |
And waited while preview is visible on library page for collection 'Everything' for assets 'image9.jpg'NEWLIB
When create 'P_UCSLTWRIADIL_S03' project
And create '/F_UCSLTWRIADIL_S03' folder for project 'P_UCSLTWRIADIL_S03'
And add following asset 'image9.jpg' of collection 'Everything' to project 'P_UCSLTWRIADIL_S03' folder '/F_UCSLTWRIADIL_S03'
And delete 'P_UCSLTWRIADIL_S03' project
And go to the Library page for collection 'Everything'NEWLIB
And go to asset 'image9.jpg' related projects info page in Library for collection 'Everything' NEWLIB
Then I should see a message 'No related projects' on assets related projects info page in Library NEWLIB


Scenario: check that links are absent when work request was removed
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role          | Access   |
| UCSLTWRIADIL_U2 | agency.admin | streamlined_library,folders,adkits  |
And logged in with details of 'UCSLTWRIADIL_U2'
And I uploaded following assetsNEWLIB:
| Name              |
| /files/image9.jpg |
And waited while preview is visible on library page for collection 'Everything' for assets 'image9.jpg'NEWLIB
When create 'WR_UCSLTWRIADIL_S04' work request
And create '/F_UCSLTWRIADIL_S04' folder for work request 'WR_UCSLTWRIADIL_S04'
And add following asset 'image9.jpg' of collection 'Everything' to work request 'WR_UCSLTWRIADIL_S04' folder '/F_UCSLTWRIADIL_S04'
And delete 'WR_UCSLTWRIADIL_S04' work request
And go to the Library page for collection 'Everything'NEWLIB
And go to asset 'image9.jpg' related projects info page in Library for collection 'Everything' NEWLIB
Then I should see a message 'No related projects' on assets related projects info page in Library NEWLIB



Scenario: check that permissions on each project in the list and display only those projects where user has access
Meta:@gdam
@library
Given I created users with following fields:
| Email             | Role        |Access|
| UCSLTWRIADIL_S3_1 | agency.user |folders,streamlined_library|
When I login with details of 'UCSLTWRIADIL_S3_1'
And upload following assetsNEWLIB:
| Name              |
| /files/image9.jpg |
And create 'P_UCSLTWRIADIL_S3_1' project
And create '/F_UCSLTWRIADIL_S3_1' folder for project 'P_UCSLTWRIADIL_S3_1'
And add following asset 'image9.jpg' of collection 'My Assets' to project 'P_UCSLTWRIADIL_S3_1' folder '/F_UCSLTWRIADIL_S3_1'NEWLIB
And login with details of 'AgencyAdmin'
And create 'P_UCSLTWRIADIL_S3_2' project
And create '/F_UCSLTWRIADIL_S3_2' folder for project 'P_UCSLTWRIADIL_S3_2'
And add following asset 'image9.jpg' of collection 'Everything' to project 'P_UCSLTWRIADIL_S3_2' folder '/F_UCSLTWRIADIL_S3_2'NEWLIB
And login with details of 'UCSLTWRIADIL_S3_1'
And I go to asset 'image9.jpg' related projects info page in Library for collection 'My Assets' NEWLIB
Then 'should' see following originated project name 'P_UCSLTWRIADIL_S3_1' on assets related projects info page in Library NEWLIB
And 'should not' see following originated project name 'P_UCSLTWRIADIL_S3_2' on assets related projects info page in Library NEWLIB

