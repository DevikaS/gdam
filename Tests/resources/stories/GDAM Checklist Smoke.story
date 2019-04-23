!--NGN-18338
Feature:          Agency Admin - GDAM Checklist Smoke
Narrative:
In order to
As a           AgencyAdmin
I want to         check from email address for notifications field

Scenario: Check that GDN transcoding happen while uploading files in Projects
Meta: @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I logged in as 'AgencyAdmin'
And I created 'GDAMCHKLST_P1' project
And created '/GDAMCHKLST_F1' folder for project 'GDAMCHKLST_P1'
And created '/GDAMCHKLST_F2' folder for project 'GDAMCHKLST_P1'
And created '/GDAMCHKLST_F3' folder for project 'GDAMCHKLST_P1'
And uploaded few files '/files/logo3.jpg,/files/GWGTestfile064v3.pdf,/files/4002c.ai,/files/example3.psd,/files/Fish-Ad.mov' with delimiter ',' into '/GDAMCHKLST_F1' folder for 'GDAMCHKLST_P1' project
And waited while preview is available in folder '/GDAMCHKLST_F1' on project 'GDAMCHKLST_P1' files page
Then I 'should' see preview files 'logo3.jpg,GWGTestfile064v3.pdf,4002c.ai,example3.psd,Fish-Ad.mov' on project 'GDAMCHKLST_P1' folder '/GDAMCHKLST_F1' page
When I upload few files '/files/Fish1-Ad.wmv,/files/voiceclip.mp4,/files/index.html,/files/_file1.gif,/files/Fish1-Ad.mp3,/files/shortname.wav,/files/13DV-CAPITAL-10.mpg' with delimiter ',' into '/GDAMCHKLST_F2' folder for 'GDAMCHKLST_P1' project
And wait while preview is available in folder '/GDAMCHKLST_F2' on project 'GDAMCHKLST_P1' files page
Then I 'should' see preview files 'Fish1-Ad.wmv,voiceclip.mp4,index.html,_file1.gif' on project 'GDAMCHKLST_P1' folder '/GDAMCHKLST_F2' page
When I upload few files '/files/doc2.zip,/files/AEG.swf,/files/filetext.txt' with delimiter ',' into '/GDAMCHKLST_F3' folder for 'GDAMCHKLST_P1' project
And wait while preview is available in folder '/GDAMCHKLST_F3' on project 'GDAMCHKLST_P1' files page
Then I 'should' see preview files 'filetext.txt' on project 'GDAMCHKLST_P1' folder '/GDAMCHKLST_F3' page
And I should see following files metadata on project 'GDAMCHKLST_P1' overview page:
| FileName                         | Type  |
|AEG.swf                           | SWF   |
|Fish1-Ad.mp3                      | MP3   |
|shortname.wav                     | WAV   |
|13DV-CAPITAL-10.mpg               | MPEG  |
|doc2.zip                          | ZIP   |

Scenario: Check that GDN transcoding happen while uploading microsoft office files in Projects
Meta: @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
Given I logged in as 'AgencyAdmin'
And I created 'GDAMCHKLST_P1' project
And created '/GDAMCHKLST_F1' folder for project 'GDAMCHKLST_P1'
And uploaded few files '/files/BDDStandards.doc,/files/perfromance.xlsx,/files/presentation.ppt,/files/919.xls,/files/usage.docx' with delimiter ',' into '/GDAMCHKLST_F1' folder for 'GDAMCHKLST_P1' project
And waited while preview is available in folder '/GDAMCHKLST_F1' on project 'GDAMCHKLST_P1' files page
Then I 'should' see preview files 'BDDStandards.doc,perfromance.xlsx,presentation.ppt,919.xls,usage.docx' on project 'GDAMCHKLST_P1' folder '/GDAMCHKLST_F1' page

Scenario: Check that GDN transcoding happen while uploading microsoft office files in Library
Meta: @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @bug
      @library
!--QAB-883 Preview is not generated for xls and xlsx alone on new library
Given I logged in as 'AgencyAdmin'
When I go to the library page for collection 'Everything'NEWLIB
And I uploaded asset '/files/BDDStandards.doc,/files/perfromance.xlsx,/files/presentation.ppt,/files/919.xls,/files/usage.docx' into libraryNEWLIB
And wait while previews are visible on library page for collection 'Everything' for asset 'BDDStandards.doc,perfromance.xlsx,presentation.ppt,919.xls,usage.docx'NEWLIB
Then I should see available preview for asset 'BDDStandards.doc,perfromance.xlsx,presentation.ppt,919.xls,usage.docx' in collection 'Everything'NEWLIB
And I should see preview on the library assets info page for asset 'BDDStandards.doc,perfromance.xlsx,presentation.ppt,919.xls,usage.docx' in collection 'Everything'NEWLIB

Scenario: Check that GDN transcoding happen while uploading files in Library
Meta: @uatgdamsmoke
      @livegdamsmoke
      @gdam
      @library
Given I logged in as 'AgencyAdmin'
When I go to the library page for collection 'Everything'NEWLIB
And I uploaded asset '/files/Fish-Ad.mov,/files/Fish1-Ad.wmv,/files/voiceclip.mp4,/files/index.html' into libraryNEWLIB
And wait while previews are visible on library page for collection 'Everything' for asset 'Fish-Ad.mov,Fish1-Ad.wmv,voiceclip.mp4,index.html'NEWLIB
Then I should see available preview for asset 'Fish-Ad.mov,Fish1-Ad.wmv,voiceclip.mp4,index.html' in collection 'Everything'NEWLIB
And I should see preview on the library assets info page for asset 'Fish-Ad.mov,Fish1-Ad.wmv,voiceclip.mp4,index.html' in collection 'Everything'NEWLIB
When I uploaded asset '/files/_file1.gif,/files/Fish1-Ad.mp3,/files/shortname.wav,/files/logo3.jpg,/files/GWGTestfile064v3.pdf,/files/4002c.ai,/files/example3.psd,/files/13DV-CAPITAL-10.mpg,/files/doc2.zip,/files/AEG.swf,/files/filetext.txt' into libraryNEWLIB
And wait while previews are visible on library page for collection 'Everything' for asset '_file1.gif,logo3.jpg,GWGTestfile064v3.pdf,4002c.ai,example3.psd,filetext.txt'NEWLIB
Then I should see available preview for asset '_file1.gif,logo3.jpg,GWGTestfile064v3.pdf,4002c.ai,example3.psd,filetext.txt' in collection 'Everything'NEWLIB
And I should see preview on the library assets info page for asset '_file1.gif,logo3.jpg,GWGTestfile064v3.pdf,4002c.ai,example3.psd,filetext.txt' in collection 'Everything'NEWLIB

Scenario: Check Beam login page
Meta:@livegdamsmoke
     @gdam
Given I am on babylon Login page
And I access client 'Beam' url
When I fill fields login 'beam@beam.tv' and password 'abcdefghA1'
And click on element 'BeamLoginButton'
Then I 'should' see BeemReels section on Dashboard page
And I 'should' see Custom Logo for 'Beam' on Dashboard page
When I click element 'MainMenu' on page 'BasePage'
And I click on element 'Logout'
Then I 'should' see Client Logo in 'Beam' login page

Scenario: Check Elizabeth Arden login page
Meta:@livegdamsmoke
Given I am on babylon Login page
When I login as 'GlobalAdmin'
And I impersonated as Client user 'eaadmin@adbank.me' on opened page
Then I 'should' see Custom Logo for 'ElizabethArden' on Dashboard page
When I click element 'MainMenu' on page 'BasePage'
And I click on element 'Logout'
When I access client 'ElizabethArden' url
Then I 'should' see Client Logo in 'ElizabethArden' login page

Scenario: Check Schawk login page
Meta:@livegdamsmoke
Given I am on babylon Login page
And I access client 'Schawk' url
When I fill fields login 'adstream.support.schawk@adbank.me' and password 'abcdefghA1'
And click on element 'LoginButton'
And I wait for '5' seconds
Then I 'should' see Custom Logo for 'Schawk' on Dashboard page
When I click element 'MainMenu' on page 'BasePage'
And I click on element 'Logout'
Then I 'should' see Client Logo in 'Schawk' login page

Scenario: Check Apple Beam login page
Meta:@livegdamsmoke
Given I am on babylon Login page
And I access client 'AppleBeam' url
Then I 'should' see Client Logo in 'AppleBeam' login page

Scenario: Check Mismatch between Calendar and date in UI
Meta: @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @library
Given I logged in as 'AgencyAdmin'
When I go to User list page
And open 'AgencyAdmin' user menu and search by First Name
And click element 'EditProfileLink' on page 'Users'
And I fill following fields on user 'AgencyAdmin' with timezone details page:
| Role        |timeZone           |
| agency.user |Australia/Melbourne|
And I click save on users details page
When login with details of 'AgencyAdmin'
And upload file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I wait while preview is visible on library page for collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And add Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |



Scenario: Check Whether Downloaded of Proxy file size is less than the Master File
Meta:@uatgdamsmoke
     @livegdamsmoke
     @gdam
     @projects
Given I logged in as 'AgencyAdmin'
And I created 'P_VMI_S5' project
And created '/F_VMI_S5' folder for project 'P_VMI_S5'
And I uploaded into project 'P_VMI_S5' following files:
| FileName            | Path      |
| /files/Fish2-Ad.mov | /F_VMI_S5 |
And I uploaded into project 'P_VMI_S5' following revisions:
| FileName                   | Path      | MasterFileName |
| /files/13DV-CAPITAL-10.mpg | /F_VMI_S5 | Fish2-Ad.mov   |
And waited while preview is available in folder '/F_VMI_S5' on project 'P_VMI_S5' files page
Then I 'should' see download size of 'Fish2-Ad.mov' Proxy file 'rev-1-Fish2-Ad_proxy.mov' on folder '/F_VMI_S5' project 'P_VMI_S5' file info page is less than the size of 'rev-1-Fish2-Ad_master.mov'
And I 'should' see download size of 'Fish2-Ad.mov' Proxy file 'rev-2-Fish2-Ad_proxy.mov' on folder '/F_VMI_S5' project 'P_VMI_S5' file info page is less than the size of 'rev-2-Fish2-Ad_master.mov'

!-- QAB-432 CustomBranding case will fail until it is fixed
Scenario: Check URL with custom branding stored in A5
Meta: @uatgdamsmoke
Given I am on babylon Login page
And I access client '<Custompage>' url
When I fill fields login '<username>' and password '<password>'
And click on element '<ButtonName>'
Then I 'should' see Custom Logo for '<Custompage>' on Dashboard page
And I 'should' see Client Header color in '<Custompage>' Dashboard page
And I 'should' see Client Footer color and text in '<Custompage>' Dashboard page
When I click element 'MainMenu' on page 'BasePage'
And I click on element 'Logout'
Then I 'should' see Client Logo in '<Custompage>' login page

Examples:
|Custompage         |username                            |password     |ButtonName     |
|CustomBranding     |testautomation02_user01@adstream.com|Adstreamqa123|LoginButton    |
|CustomBeamBranding |testautomation01_user01@adstream.com|Adstreamqa123|BeamLoginButton|

Scenario: check that user is able to download Assets
Meta: @gdam
@livegdamsmoke
@uatgdamsmoke
@library
Given I logged in as 'AgencyAdmin'
When I upload file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And wait while previews are visible on library page for collection 'Everything' for asset 'Fish1-Ad.mov'NEWLIB
Then 'Original' files 'Fish1-Ad.mov' is downloaded as 'rev-1-Fish1-Ad_master.mov' in collection 'My Assets' from Library
And 'preview' files 'Fish1-Ad.mov' is downloaded as 'rev-1-Fish1-Ad_proxy.mov' in collection 'My Assets' from Library

Scenario: Check that Download Works in Presentation
!-- This scenario has been removed from Live and UAT smoke as it will fail on S3 storage. Since S3 doesn't pass a URI unlike adgate.
Meta:@gdam
      @library
Given I logged in as 'AgencyAdmin'
When I upload file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And create following reels:
| Name           | Description |
| PDAFOZAR8_1    | description |
And I go to library page for collection 'My Assets'NEWLIB
And I add asset 'Fish1-Ad.mov' into existing presentation 'PDAFOZAR8_1' from collection 'My Assets'NEWLIB
And I wait while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name         |
| Fish1-Ad.mov |
And I go to preview presentation 'PDAFOZAR8_1' page
Then 'master' files 'Fish1-Ad.mov' on Presentation 'PDAFOZAR8_1' from collection 'My Assets' is downloaded for 'DefaultAgency'
Then 'proxy' files 'Fish1-Ad.mov' on Presentation 'PDAFOZAR8_1' from collection 'My Assets' is downloaded for 'DefaultAgency'


Scenario: Check that shared asset could be added to collection
Meta: @uatgdamsmoke
	  @livegdamsmoke
	  @library
Given I logged in as 'AgencyAdmin'
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And created 'C_LAATC_S04_1' category
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added users 'AgencyUser' to category 'C_LAATC_S04_1' with role 'Library User' by users details
And logged in with details of 'AgencyUser'
When go to the Library page for collection 'C_LAATC_S04_1'NEWLIB
And I select asset 'Fish Ad.mov' in the 'C_LAATC_S04_1'  library pageNEWLIB
And copy to 'C_LAATC_S04_2'  from 'C_LAATC_S04_1' library page
And I go to  Library page for collection 'C_LAATC_S04_2'NEWLIB
Then I 'should' see assets 'Fish Ad.mov' in the collection 'C_LAATC_S04_2'NEWLIB

