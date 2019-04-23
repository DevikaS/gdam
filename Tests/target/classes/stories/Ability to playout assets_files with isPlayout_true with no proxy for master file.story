!--NGN-11659
Feature:          Ability to playout assets_files with isPlayout_true with no proxy for master file
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Ability to playout assets_files with isPlayout_true with no proxy for master file


Scenario: Successfully creating a new Project(mandatory fields only)
Meta: @skip
      @gdam
!-- repetetion
Given I am on Dashboard page
When I create new project with following fields:
| FieldName  | FieldValue |
| Name       | CP1        |
| Media type | Broadcast  |
| Start Date | Today      |
| End Date   | Tomorrow   |
Then I should see 'CP1' project in project list


Scenario: Successfully creating a new Project(all fields)
Meta: @skip
      @gdam
!-- repetetion
Given I am on Project list page
When I create 'superNew2' project with 'AllFilledFields'
Then I should see message warning 'Changes saved successfully'
And 'superNew2' project should include 'AllFilledFields'

Scenario: Check that file isPlayout - true could be played and doesn't have proxy
!--07/10: Invalid as per maria "please remove this scenario"
Meta: @skip
      @gdam
Given I created the agency 'A_ATPAFWIPTWNPFMF_S01' with default attributes
And created users with following fields:
| Email                 | Role         | Agency                |
| U_ATPAFWIPTWNPFMF_S01 | agency.admin | A_ATPAFWIPTWNPFMF_S01 |
When I set playout for following agency 'A_ATPAFWIPTWNPFMF_S01'
And I login with details of 'U_ATPAFWIPTWNPFMF_S01'
And upload following assets:
| Name                 |
| /files/voiceclip.mp4 |
And wait while transcoding is finished in collection 'Everything'
And go to asset 'voiceclip.mp4' info page in Library for collection 'Everything'
Then I 'should not' see 'download proxy' button on opened asset info page
Then 'should' see playable preview on asset info page


Scenario: Check that shared asset isPlayout - true (with permissions download.proxy and download master) could be palyable
!--07/10: Invalid as per maria "please remove this scenario"
Meta: @skip
      @gdam
Given I created the agency 'A_ATPAFWIPTWNPFMF_S02_1' with default attributes
And created the agency 'A_ATPAFWIPTWNPFMF_S02_2' with default attributes
And created users with following fields:
| Email                   | Role         | Agency                  |
| U_ATPAFWIPTWNPFMF_S02_1 | agency.admin | A_ATPAFWIPTWNPFMF_S02_1 |
| U_ATPAFWIPTWNPFMF_S02_2 | agency.admin | A_ATPAFWIPTWNPFMF_S02_2 |
And logged in with details of 'U_ATPAFWIPTWNPFMF_S02_2'
And set playout for following agency 'A_ATPAFWIPTWNPFMF_S02_2'
And logged in with details of 'U_ATPAFWIPTWNPFMF_S02_1'
And uploaded file '/files/voiceclip.mp4' into my library
And created 'C_ATPAFWIPTWNPFMF_S02_1' category
And shared next agencies for following categories:
| CategoryName            | AgencyName              |
| C_ATPAFWIPTWNPFMF_S02_1 | A_ATPAFWIPTWNPFMF_S02_2 |
When I login with details of 'U_ATPAFWIPTWNPFMF_S02_2'
And accept all assets on Shared Collection 'C_ATPAFWIPTWNPFMF_S02_1' from agency 'A_ATPAFWIPTWNPFMF_S02_1' page
And go to asset 'voiceclip.mp4' info page in Library for collection 'Everything'
Then I 'should not' see 'download proxy' button on opened asset info page
Then 'should' see playable preview on asset info page