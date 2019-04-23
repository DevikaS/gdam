!-- NGN-11157
Feature:          As a User I should see presentation activities on Dashboard
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check activity on Dashboard for presentation



Scenario: Check presentation created and updated and deleted activity on Dashboard
Meta: @bug
      @gdam
      @library
!--FAB-471
Given I created the agency 'A_AAUISSPAOD_S01' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |
| E_AAUISSPAOD_S01 | agency.admin | A_AAUISSPAOD_S01 |
When I login with details of 'E_AAUISSPAOD_S01'
And upload following assets:
| Name                |
| /files/Fish1-Ad.mov |
And go to Library page for collection 'Everything'
And add asset 'Fish1-Ad.mov' into new presentation 'P_AAUISSPAOD_S01' with description 'description'
And go to the all presentations page
And delete presentation 'P_AAUISSPAOD_S01'
And go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName         | Message              | Value            |
| E_AAUISSPAOD_S01 | updated presentation | P_AAUISSPAOD_S01 |
| E_AAUISSPAOD_S01 | deleted presentation | P_AAUISSPAOD_S01 |
| E_AAUISSPAOD_S01 | created presentation | P_AAUISSPAOD_S01 |



Scenario: Check that download master and proxy from presentation created activity for asset
Meta:@gdam
     @library
Given I created the agency 'A_AAUISSPAOD_S01' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |Access|
| E_AAUISSPAOD_S01 | agency.admin | A_AAUISSPAOD_S01 |streamlined_library,presentations,dashboard|
When I login with details of 'E_AAUISSPAOD_S01'
And upload following assetsNEWLIB:
| Name              |
| /files/_file1.gif |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to Library page for collection 'My Assets'NEWLIB
And I add assets '_file1.gif' to new presentation 'P_AAUISSPAOD_S01' from collection 'My Assets' pageNEWLIB
And go to preview presentation 'P_AAUISSPAOD_S01' page
And click 'original' button on presentation preview page popup
And click 'proxy' button on presentation preview page popup
And go to asset '_file1.gif' activity page in Library for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should' see the following activities on asset '_file1.gif' activity page for collection 'My Assets'NEWLIB:
| UserName         | Message                                   | Value            |
| E_AAUISSPAOD_S01 | Downloaded from Presentation by           |                  |
| E_AAUISSPAOD_S01 | Preview downloaded from Presentation by   |                  |
When I go to Dashboard page
And I refresh the page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName         | Message                 | Value                              |
| E_AAUISSPAOD_S01 | downloaded presentation | P_AAUISSPAOD_S01                   |