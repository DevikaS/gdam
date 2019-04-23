!--NGN-11606
Feature:          Check new permissions create/read/update/delete Attachments
Narrative:
In order to
As a              AgencyAdmin
I want to         Check new permissions create/read/update/delete Attachments

Scenario: Check that share user with permissions (attachment read) сouldn't upload and remove attachments in  asset
Meta:@gdam
    @projects
Given created 'R_UUAFFAA3F' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission           |
| element.read         |
| element.write        |
| folder.read          |
| project.read         |
| attached_file.read   |
| attached_file.remove |
And created users with following fields:
| Email        | Role         |
| U_UUAFFAA_33 | R_UUAFFAA3F  |
And I created 'P_UUAFFAA3F' project
And I created '/folder' folder for project 'P_UUAFFAA3F'
And uploaded '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA3F' project
And waited while transcoding is finished in folder '/folder' on project 'P_UUAFFAA3F' files page
And attached new file '/files/big_background.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA3F' project
When I share each folder from project 'P_UUAFFAA3F' to user 'U_UUAFFAA_33' with role 'R_UUAFFAA3F' expired date '12.12.2021'
And login with details of 'U_UUAFFAA_33'
And I go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA3F'
Then I 'should' see 'Attachments' tab on file info page
When I click on 'Attachments' tab on opened file info page
Then I should see element 'Upload button' on page 'ProjectFileInfoPage' in following state 'invisible'
Then I should see element 'Remove button' on page 'ProjectFileInfoPage' in following state 'invisible'

Scenario: Check that share user with permissions on asset could see attachments tab
Meta:@gdam
    @projects
Given created 'R_UUAFFAA3F' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission           |
| element.read         |
| element.write        |
| folder.read          |
| project.read         |
| attached_file.remove |
| attached_file.read   |
And created users with following fields:
| Email        | Role         |
| U_UUAFFAA_33 | R_UUAFFAA3F  |
And I created 'P_UUAFFAA3F' project
And I created '/folder' folder for project 'P_UUAFFAA3F'
And uploaded '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA3F' project
And waited while transcoding is finished in folder '/folder' on project 'P_UUAFFAA3F' files page
And attached new file '/files/big_background.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA3F' project
When I share each folder from project 'P_UUAFFAA3F' to user 'U_UUAFFAA_33' with role 'R_UUAFFAA3F' expired date '12.12.2021'
And login with details of 'U_UUAFFAA_33'
And I go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA3F'
Then I 'should' see 'Attachments' tab on file info page
When I click on 'Attachments' tab on opened file info page
Then I should see element 'Upload button' on page 'ProjectFileInfoPage' in following state 'invisible'
Then I should see element 'Remove button' on page 'ProjectFileInfoPage' in following state 'invisible'

Scenario: Check that share user without permissions on asset couldn't see attachments tab
Meta:@gdam
    @projects
Given created 'R_UUAFFAA' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission           |
| element.read         |
| element.write        |
| folder.read          |
| project.read         |
And created users with following fields:
| Email       | Role         |
| U_UUAFFAA_55 | R_UUAFFAA  |
And I created 'P_UUAFFAA' project
And I created '/folder' folder for project 'P_UUAFFAA'
And uploaded '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA' project
And waited while transcoding is finished in folder '/folder' on project 'P_UUAFFAA' files page
And attached new file '/files/logo1.gif' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA' project
When I share each folder from project 'P_UUAFFAA' to user 'U_UUAFFAA_55' with role 'R_UUAFFAA' expired date '12.12.2021'
And login with details of 'U_UUAFFAA_55'
And I go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA'
Then I 'should not' see 'Attachments' tab on file info page

Scenario: Check that share user with all permissions on file could add attachments and see previously added
Meta:@gdam
    @projects
Given I created 'P_UUAFFAA11' project
And I created '/folder' folder for project 'P_UUAFFAA11'
And uploaded '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA11' project
And waited while transcoding is finished in folder '/folder' on project 'P_UUAFFAA11' files page
And I am on file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA11' tab attachments files
And attached new file '/files/big_background.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/logo1.gif' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/logo2.png' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/logo3.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/logo3.png' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/logo4.bmp' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And refreshed the page
Then I 'should' see attached file 'big_background.jpg,logo1.gif,logo2.png,logo3.jpg,logo3.png,logo4.bmp' on file info page in tab attachments files
Given I am on file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA11' tab attachments files
And attached new file '/files/image9.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/image10.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/image11.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/example3.psd' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And attached new file '/files/example4.psd' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA11' project
And I am on file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA11' tab attachments files
And refreshed the page
Then I 'should' see attached file 'big_background.jpg,logo1.gif,logo2.png,logo3.jpg,logo3.png,logo4.bmp,image9.jpg,image10.jpg,image11.jpg,example3.psd,example4.psd' on file info page in tab attachments files







