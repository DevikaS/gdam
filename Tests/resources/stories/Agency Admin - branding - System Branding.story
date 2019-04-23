!--NGN-1420
Feature:          Agency Admin - branding - System Branding
Narrative:
In order to
As a              AgencyAdmin
I want to         Check System Branding

Scenario: Check default values for Branding tab
Meta:@gdam
     @projects
Given I am on Users list page
When I click element 'Branding' on page 'Users'
Then I should see following elements on the system branding page:
| Element               | State  |
| BackgroundColorInput  | should |
| BackgroundColorButton | should |
| Logo                  | should |
| Browse                | should |
| Save                  | should |


Scenario: logo and header images are appear at header after upload
Meta:@gdam
     @projects
Given I am on the system branding page
When I upload logo '/images/SB_Logo.png' on system branding page
Then I 'should not' see that logo on the system branding page is default
And I 'should not' see that header logo is default


Scenario: Unsuccessfully uploading logo for branding
Meta:@gdam
     @projects
Given I am on the system branding page
When I upload logo '/files/GWGTestfile064v3.pdf' on system branding page
Then I should see alert text is 'GWGTestfile064v3.pdf has invalid extension. Only gif, jpg, jpeg, png are allowed.'


Scenario: Check successful remove logo
Meta:@gdam
     @projects
Given I am on the system branding page
And I uploaded logo '/images/SB_Logo.png' on system branding page
And I clicked save on the system branding page
And waited for '2' seconds
When I 'confirm' remove logo from the system branding page
Then I should see text on page contains 'Logo has been successfully removed'
And I 'should' see that header logo is default


Scenario: check that branding logo and color appear at adbank
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
	  @gdamcrossbrowser
Given I uploaded logo '/images/SB_Logo.png' and color '#5a3c5a' on system branding page
And refreshed the page
Then I 'should not' see that header logo is default
And I 'should' see that header has next color '90, 60, 90'


Scenario: check that branding logo and color appear for agency user
Meta:@gdam
     @projects
Given I created users with following fields:
| Email     | Role        |
| U_SysB_S1 | agency.user |
And I uploaded logo '/images/SB_Logo.png' and color '#799baa' on system branding page
When I login with details of 'U_SysB_S1'
Then I 'should not' see that header logo is default
And I 'should' see that header has next color 'rgb(121, 155, 170)'


Scenario: check that changes branding logo and color appear only for current agency
Meta:@gdam
     @projects
Given I am on the system branding page
And I uploaded logo '/images/SB_Logo.png' on system branding page
When I select color '#2211a5' on system branding page
And I login as 'AdpathAgencyAdmin'
Then I 'should' see that header logo is default


Scenario: check that on easyshare page branding is displaying as per settings of agency who shared the file
Meta:@gdam
     @gdamemails
Given I created the agency 'A_AABSB_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| AU_AABSB_S01 | agency.admin | A_AABSB_S01 |streamlined_library|
And logged in with details of 'AU_AABSB_S01'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails    | Message |
| 12.12.21   | NAU_AABSB_S01 | hi dude |
And logout from account
And open link from email when user 'NAU_AABSB_S01' received email with next subject 'shared file with you'
Then I 'should' see that header logo is default
And I 'should' see that header with background color 'rgb(0, 146, 214)'



Scenario: check that on easyshare page branding is displaying correctly after branding changes in own agency
Meta:@gdam
     @gdamemails
Given I created the agency 'A_AABSB_S02' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| AU_AABSB_S02 | agency.admin | A_AABSB_S02 |streamlined_library|
| AU_AABSB_S01 | agency.admin | A_AABSB_S02 |streamlined_library|
And logged in with details of 'AU_AABSB_S02'
And uploaded logo '/images/SB_Logo.png' and color '#5a3c5a' on system branding page
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails    | Message |
| 12.12.21   | AU_AABSB_S01 | hi dude |
And logout from account
And open link from email when user 'AU_AABSB_S01' received email with next subject 'shared file with you'
Then I 'should not' see that header logo is default
And I 'should' see that header with background color 'rgb(90, 60, 90)'



Scenario: check that user is redirected to dashboard after click on branding
Meta: @skip
      @gdam
!-- 13/08 - confirmed with Maria that the log is no longer clickable--Obsolete now
Given I created the agency 'A_AABSB_S03' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |
| AU_AABSB_S03 | agency.admin | A_AABSB_S03 |
| U_AABSB_S03  | agency.user  | A_AABSB_S03 |
And logged in with details of 'AU_AABSB_S03'
And uploaded logo '/images/SB_Logo.png' and color '#5a3c5a' on system branding page
And uploaded file '/files/Fish Ad.mov' into library
And waited while preview is available in collection 'My Assets'
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following users:
| UserEmails  |
| U_AABSB_S03 |
And login with details of 'U_AABSB_S03'
And open link from email when user 'U_AABSB_S03' received email with next subject 'has been shared'
And click element 'HomeLogo' on page 'BasePage'
And wait for '3' seconds
Then I 'should' be on the Dashboard page