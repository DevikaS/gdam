!--NGN-11676
Feature:          As Agency Admin I should see all activities on the Project and Dashboard within Agency objects
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that As Agency Admin I should see all activities on the Project and Dashboard within Agency objects


Scenario: Agency Admin participiting in project as ordinary user can see activities from objects shared with him if his role allows view of activity
Meta:@gdam
      @projects
Given I created the agency 'A_AAISSAAOTPADWAO_S01' with default attributes
And created the agency 'A_AAISSAAOTPADWAO_S02' with default attributes
And created users with following fields:
| Email                   | Role         | Agency                |
| E_AAISSAAOTPADWAO_S01_1 | agency.admin | A_AAISSAAOTPADWAO_S01 |
| E_AAISSAAOTPADWAO_S01_2 | agency.admin | A_AAISSAAOTPADWAO_S02 |
When I login with details of 'E_AAISSAAOTPADWAO_S01_1'
And I create 'P_AAISSAAOTPADWAO_S01' project
And create '/folder' folder for project 'P_AAISSAAOTPADWAO_S01'
And upload '/files/atCalcImage.jpg' file into '/folder' folder for 'P_AAISSAAOTPADWAO_S01' project
And wait while transcoding is finished in folder '/folder' on project 'P_AAISSAAOTPADWAO_S01' files page
And attach new file '/images/logo.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_AAISSAAOTPADWAO_S01' project
And wait for '2' seconds
And go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_AAISSAAOTPADWAO_S01' tab attachments files
And delete attached file 'logo.jpg' on info page in tab attachments files
And edit the following fields for 'P_AAISSAAOTPADWAO_S01' project:
| Name                       | Administrators          |
| P_EDIT_AAISSAAOTPADWAO_S01 | E_AAISSAAOTPADWAO_S01_2 |
And click Save button on project popup
And wait for '2' seconds
And login with details of 'E_AAISSAAOTPADWAO_S01_2'
And go to project 'P_EDIT_AAISSAAOTPADWAO_S01' overview page
Then I 'should' see activity where user 'E_AAISSAAOTPADWAO_S01_1' create project 'P_AAISSAAOTPADWAO_S01' on Project Overview page
And 'should' see activity where user 'E_AAISSAAOTPADWAO_S01_1' update project 'P_EDIT_AAISSAAOTPADWAO_S01' on Project Overview page
Then 'should' see following activities in 'Recent Activity' section on Project Overview page:
| UserName                | Message                                             | Value                                                                 |
| E_AAISSAAOTPADWAO_S01_1 | deleted attachment(s) logo.jpg from atCalcImage.jpg | /P_AAISSAAOTPADWAO_S01/folder/atCalcImage.jpg                         |
| E_AAISSAAOTPADWAO_S01_1 | uploaded attachment(s) logo.jpg to atCalcImage.jpg  | /P_AAISSAAOTPADWAO_S01/folder/atCalcImage.jpg                         |
| E_AAISSAAOTPADWAO_S01_1 | created folder                                      | folder                                                                |
| E_AAISSAAOTPADWAO_S01_1 | uploaded 1 files atCalcImage.jpg                    | P_AAISSAAOTPADWAO_S01/P_AAISSAAOTPADWAO_S01/folder/atCalcImage.jpg    |