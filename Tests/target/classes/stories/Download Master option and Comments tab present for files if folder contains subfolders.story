!-- NGN-8253 NGN-8307
Feature:          Download Master option and Comments tab present for files if folder contains subfolders
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that Download Master option and Comments tab are presented on files if Folder contains subfolders

Scenario: Check that download buttons are displayed on file info page
Meta:@gdam
@projects
Given I created 'P_DACOFSF_S01' project
And created '/F01' folder for project 'P_DACOFSF_S01'
And created '/F01/F01_1' folder for project 'P_DACOFSF_S01'
And created '/F01/F01_2' folder for project 'P_DACOFSF_S01'
And uploaded '/files/Fish Ad.mov' file into '/F01' folder for 'P_DACOFSF_S01' project
And waited while preview is available in folder '/F01' on project 'P_DACOFSF_S01' files page
Then I 'should' see Download Original button on file 'Fish Ad.mov' info page in folder '/F01' project 'P_DACOFSF_S01'
And 'should' see Download proxy button on file 'Fish Ad.mov' info page in folder '/F01' project 'P_DACOFSF_S01'
And 'should' see Download master using nVerge button on file 'Fish Ad.mov' info page in folder '/F01' project 'P_DACOFSF_S01'


Scenario: Check that comments are displayed in correct format
Meta:@gdam
@projects
Given I created 'P_DACOFSF_S02' project
And created '/F01' folder for project 'P_DACOFSF_S02'
And created '/F01/F01_1' folder for project 'P_DACOFSF_S02'
And created '/F01/F01_2' folder for project 'P_DACOFSF_S02'
And uploaded '/files/Fish Ad.mov' file into '/F01' folder for 'P_DACOFSF_S02' project
And waited while transcoding is finished in folder '/F01' on project 'P_DACOFSF_S02' files page
When I go to the file comments page project 'P_DACOFSF_S02' and folder '/F01' and file 'Fish Ad.mov'
And add comment 'TC DACOFSF S02' into current file
Then I 'should' see comment 'TC DACOFSF S02' for current file


Scenario: Check that comments are displayed in correct format for project.contributor
Meta:@gdam
@projects
Given I created users with following fields:
| Email         | Role        | Agency        |
| U_DACOFSF_S03 | agency.user | DefaultAgency |
And created 'P_DACOFSF_S03' project
And created '/F01' folder for project 'P_DACOFSF_S03'
And created '/F01/F01_1' folder for project 'P_DACOFSF_S03'
And created '/F01/F01_2' folder for project 'P_DACOFSF_S03'
And uploaded '/files/Fish Ad.mov' file into '/F01' folder for 'P_DACOFSF_S03' project
And waited while transcoding is finished in folder '/F01' on project 'P_DACOFSF_S03' files page
And fill Share popup by users 'U_DACOFSF_S03' in project 'P_DACOFSF_S03' folders '/F01' with role 'project.contributor' expired '12.02.2021' and 'should' access to subfolders
When I login with details of 'U_DACOFSF_S03'
And go to the file comments page project 'P_DACOFSF_S03' and folder '/F01' and file 'Fish Ad.mov'
And add comment 'TC DACOFSF S03' into current file
Then I 'should' see comment 'TC DACOFSF S03' for current file