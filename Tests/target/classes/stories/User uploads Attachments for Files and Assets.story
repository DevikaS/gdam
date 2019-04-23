!--NGN-10623
Feature:          User uploads Attachments for Files and Assets
Narrative:
In order to
As a              AgencyAdmin
I want to         User uploads Attachments for Files and Assets


Scenario: Check that file can be to uploads, edited, re-edited, removed
Meta: @gdam
@projects
Given I created 'P_UUAFFAA1' project
And I created '/folder' folder for project 'P_UUAFFAA1'
And uploaded '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA1' project
And waited while transcoding is finished in folder '/folder' on project 'P_UUAFFAA1' files page
And attached new file '/files/big_background.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/logo1.gif' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/logo2.png' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/logo3.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/logo3.png' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/logo4.bmp' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/image9.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/image10.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/image11.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/example3.psd' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And attached new file '/files/example4.psd' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And I am on file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA1' tab attachments files
And refreshed the page
When I edit name 'big_background_edited.jpg' of file 'big_background.jpg' on info page in tab attachments files
Then I 'should' see attached file 'big_background_edited.jpg,logo1.gif,logo2.png,logo3.jpg,logo3.png,logo4.bmp,image9.jpg,image10.jpg,image11.jpg,example3.psd,example4.psd' on file info page in tab attachments files
When I refresh the page
When I delete attached file 'big_background_edited.jpg' on info page in tab attachments files
Then I 'should not' see attached file 'big_background_edited.jpg' on file info page in tab attachments files
When I refresh the page
When I edit name 'logo1_edited.gif' of file 'logo1.gif' on info page in tab attachments files
Then I 'should' see download button for file 'logo1_edited.gif' on info page in tab attachments files


Scenario: Check that attached file can be downloaded
Meta: @gdam
@projects
!--NGN-18138
Given I created 'P_UUAFFAA1' project
And I created '/folder' folder for project 'P_UUAFFAA1'
And uploaded '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA1' project
And waited while transcoding is finished in folder '/folder' on project 'P_UUAFFAA1' files page
And attached new file '/files/big_background.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project
And I am on file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA1' tab attachments files
And refreshed the page
When I clicked download attached file 'big_background.jpg' on info page in tab attachments files
Then I should sucessfully download attached file 'big_background.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA1' project

Scenario: Check that file should be searchable via attachment name (Global search)
Meta: @gdam
@projects
Given I created the agency 'A_UIRPGSC_S01_1' with default attributes
And created users with following fields:
| Email       | Role         | Agency          |
| U_UUAFFAA_1 | agency.admin | A_UIRPGSC_S01_1 |
And I created 'P_UUAFFAA2' project
And I created '/folder' folder for project 'P_UUAFFAA2'
And uploaded '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA2' project
And waited while transcoding is finished in folder '/folder' on project 'P_UUAFFAA2' files page
And attached new file '/files/big_background.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA2' project
When I search by text 'big_background.jpg'
Then I 'should' see items 'atCalcImage.jpg' of type 'Files & Folders' in global search result


Scenario: Check that attachment could be added in shared file (even if no permission upload,add usage rights on folder)
Meta: @gdam
@projects
Given created users with following fields:
| Email       | Role         |
| U_UUAFFAA_2 | agency.admin |
| U_UUAFFAA_3 | agency.user  |
And created 'R_UUAFFAA' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission           |
| element.read         |
| element.write        |
| folder.read          |
| project.read         |
| attached_file.create |
| attached_file.read   |
And logged in with details of 'U_UUAFFAA_2'
And I created 'P_UUAFFAA3' project
And I am on project 'P_UUAFFAA3' overview page
And I created '/folder' folder for project 'P_UUAFFAA3'
And uploaded '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA3' project
And waited while transcoding is finished in folder '/folder' on project 'P_UUAFFAA3' files page
When I share each folder from project 'P_UUAFFAA3' to user 'U_UUAFFAA_3' with role 'R_UUAFFAA' expired date '12.12.2021'
And login with details of 'U_UUAFFAA_3'
And I go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA3' tab attachments files
And attach new file '/images/logo.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA3' project
And refresh the page
Then I 'should' see attached file 'logo.jpg' on file info page in tab attachments files


Scenario: Check that attached files shouldn't be available in CM
Meta: @gdam
@projects
Given I am on the metadata page
When I go to the '<MetadataPage>' metadata page
Then I 'should not' see button 'Attached Files' in 'Editable Metadata' section on opened metadata page

Examples:
| MetadataPage   |
| project        |
| work request   |
| digital asset  |
| document asset |
| image asset    |
| print asset    |
| video asset    |