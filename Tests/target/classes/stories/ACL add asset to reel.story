!-- NGN-2388 NGN-3524
Feature:          ACL add asset to reel
Narrative:
In order to
As a              AgencyAdmin
I want to         Check add asset to reel permision

Scenario: Check that agency user with 'Add asset to reel' permission is able to add asset to new presentation
Meta:@library
     @gdam
Given I created 'ACLAARR1' role with 'asset.add_to_presentation,asset.write' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email    | Role        |Access|
| ACLAARU1 | agency.user |streamlined_library,presentations|
And I created following categories:
| Name     | Advertiser    | Product        | Campaign        |
| ACLAARC1 | DefaultAgency | DefaultProduct | DefaultCampaign |
And created following projects:
| Name     | Advertiser    | Product/Brand  | Campaign        |
| ACLAARP1 | DefaultAgency | DefaultProduct | DefaultCampaign |
And created '/ACLAARF1' folder for project 'ACLAARP1'
And I uploaded into project 'ACLAARP1' following files:
| FileName                 | Path      |
| /files/128_shortname.jpg | /ACLAARF1 |
And waited while preview is available in folder '/ACLAARF1' on project 'ACLAARP1' files page
And I moved following files into library:
| ProjectName | Path      | FileName          |
| ACLAARP1    | /ACLAARF1 | 128_shortname.jpg |
When I added next users for following categories:
| CategoryName | UserName | RoleName  |
| ACLAARC1     | ACLAARU1 | ACLAARR1  |
And login with details of 'ACLAARU1'
And I go to library page for collection 'ACLAARC1'NEWLIB
And I add assets '128_shortname.jpg' to new presentation 'ACLAARPRSN1' from collection 'ACLAARC1' pageNEWLIB
Then I 'should' see assets '128_shortname.jpg' in presentation 'ACLAARPRSN1'



Scenario: Check that agency user with 'Add asset to reel' permission is able to add asset to an existing presentation
Meta:@library
     @gdam
Given I created 'ACLAARR2' role with 'asset.add_to_presentation,asset.write' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email    | Role        |Access|
| ACLAARU2 | agency.user |streamlined_library,presentations|
And I created following categories:
| Name     | Advertiser    | Product        | Campaign        |
| ACLAARC2 | DefaultAgency | DefaultProduct | DefaultCampaign |
And created following projects:
| Name     | Advertiser    | Product/Brand  | Campaign        |
| ACLAARP2 | DefaultAgency | DefaultProduct | DefaultCampaign |
And created '/ACLAARF2' folder for project 'ACLAARP2'
And I uploaded into project 'ACLAARP2' following files:
| FileName                 | Path      |
| /files/128_shortname.jpg | /ACLAARF2 |
| /files/logo1.gif         | /ACLAARF2 |
| /files/logo2.png         | /ACLAARF2 |
And waited while preview is available in folder '/ACLAARF2' on project 'ACLAARP2' files page
And I moved following files into library:
| ProjectName | Path      | FileName          |
| ACLAARP2    | /ACLAARF2 | 128_shortname.jpg |
| ACLAARP2    | /ACLAARF2 | logo1.gif         |
| ACLAARP2    | /ACLAARF2 | logo2.png         |
When I added next users for following categories:
| CategoryName | UserName | RoleName  |
| ACLAARC2     | ACLAARU2 | ACLAARR2  |
And login with details of 'ACLAARU2'
And create following reels:
| Name        | Description |
| ACLAARPRSN2 | description |
And upload file '/files/logo3.jpg' into libraryNEWLIB
And I go to library page for collection 'My Assets'NEWLIB
And wait while preview is visible on library page for collection 'My Assets' for asset 'logo3.jpg'NEWLIB
And I add assets 'logo3.jpg' to existing presentations 'ACLAARPRSN2' from collection 'My Assets' pageNEWLIB
And I go to library page for collection 'ACLAARC2'NEWLIB
And I add assets '128_shortname.jpg,logo1.gif,logo2.png' to existing presentations 'ACLAARPRSN2' from collection 'ACLAARC2' pageNEWLIB
Then I 'should' see assets '128_shortname.jpg,logo1.gif,logo2.png,logo3.jpg' in presentation 'ACLAARPRSN2'


Scenario: Check that agency user without 'Add asset to reel' permission isn't able to add asset to presentation
Meta:@library
     @gdam
     @uitobe
!--can't be done until UIR-793 is fixed or QA-785 is fixed
Given I created 'ACLAARR3' role with 'asset.read' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email    | Role        |
| ACLAARU3 | agency.user |
And I created following categories:
| Name     | Advertiser    | Product        | Campaign        |
| ACLAARC3 | DefaultAgency | DefaultProduct | DefaultCampaign |
And created following projects:
| Name     | Advertiser    | Product/Brand  | Campaign        |
| ACLAARP3 | DefaultAgency | DefaultProduct | DefaultCampaign |
And created '/ACLAARF3' folder for project 'ACLAARP3'
And I uploaded into project 'ACLAARP3' following files:
| FileName         | Path      |
| /files/logo1.gif | /ACLAARF3 |
And waited while preview is available in folder '/ACLAARF3' on project 'ACLAARP3' files page
And I moved following files into library:
| ProjectName | Path      | FileName  |
| ACLAARP3    | /ACLAARF3 | logo1.gif |
When I added next users for following categories:
| CategoryName | UserName | RoleName |
| ACLAARC3     | ACLAARU3 | ACLAARR3 |
And login with details of 'ACLAARU3'
And I go to library page for collection 'ACLAARC3'
Then I 'should' see add to presentation drop-down menu buttons disabled on library page


Scenario: Check that after enabled 'Add asset to reel' permission in currently shared category user get ability to add asset to reel
Meta:@library
     @gdam
Given I created 'ACLAARR4' role with 'asset.read,asset.write' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email    | Role        |Access|
| ACLAARU4 | agency.user |streamlined_library,presentations|
And I created following categories:
| Name     | Advertiser    | Product        | Campaign        |
| ACLAARC4 | DefaultAgency | DefaultProduct | DefaultCampaign |
And created following projects:
| Name     | Advertiser    | Product/Brand  | Campaign        |
| ACLAARP4 | DefaultAgency | DefaultProduct | DefaultCampaign |
And created '/ACLAARF4' folder for project 'ACLAARP4'
And I uploaded into project 'ACLAARP4' following files:
| FileName         | Path      |
| /files/logo2.png | /ACLAARF4 |
And waited while preview is available in folder '/ACLAARF4' on project 'ACLAARP4' files page
And I moved following files into library:
| ProjectName | Path      | FileName  |
| ACLAARP4    | /ACLAARF4 | logo2.png |
When I added next users for following categories:
| CategoryName | UserName | RoleName |
| ACLAARC4     | ACLAARU4 | ACLAARR4 |
And I login as 'GlobalAdmin'
And open role 'ACLAARR4' page with parent 'DefaultAgency'
And change role permissions to 'asset.add_to_presentation,asset.write'
And click Save button on role 'ACLAARR4' page
And login with details of 'ACLAARU4'
And I go to library page for collection 'ACLAARC4'NEWLIB
And I add assets 'logo2.png' to new presentation 'ACLAARPRSN4' from collection 'ACLAARC4' pageNEWLIB
Then I 'should' see assets 'logo2.png' in presentation 'ACLAARPRSN4'


