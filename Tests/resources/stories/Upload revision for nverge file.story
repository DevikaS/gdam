Feature:          Upload revisions for Nverge file
Narrative:
In order to
As a              AgencyAdmin
I want to         Check possibility to upload new revision for file uploaded via Nverge application

Scenario: Check that new revision successfully uploaded for Nverge file
Meta:@gdam
@skip
Given I created 'URFNFP' project
And created '/F1' folder for project 'URFNFP'
And uploaded '/files/logo1.gif' file into '/F1' folder for 'URFNFP' project using nverge api
And waited while preview is available in folder '/F1' on project 'URFNFP' files page
When I upload new file version '/files/logo2.png' for file 'logo1.gif' into '/F1' folder for 'URFNFP' project
And wait while preview is visible on project 'URFNFP' in folder '/F1' for 'logo1.gif' file revision '2'
Then I should see preview for revision '2' on file 'logo1.gif' version history page in folder '/F1' project 'URFNFP'
