!--NGN-13213
Feature:          User can add Related Files to multiple selected Files
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that User can add Related Files to multiple selected Files


Scenario: Check that user can select several files with all media types and try to add related files
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role        |
| U_UCMARFFF_S01 | agency.user |
And logged in with details of 'U_UCMARFFF_S01'
And created 'P_UCARFTMSF_7_1' project
And created '/F_UCARFTMSF_7_1' folder for project 'P_UCARFTMSF_7_1'
And uploaded '/files/120.600.gif' file into '/F_UCARFTMSF_7_1' folder for 'P_UCARFTMSF_7_1' project
And uploaded '/files/at01.odt' file into '/F_UCARFTMSF_7_1' folder for 'P_UCARFTMSF_7_1' project
And uploaded '/files/atCalcAudio01.mp3' file into '/F_UCARFTMSF_7_1' folder for 'P_UCARFTMSF_7_1' project
And uploaded '/files/example5.psd' file into '/F_UCARFTMSF_7_1' folder for 'P_UCARFTMSF_7_1' project
And uploaded '/files/Fish1-Ad.mov' file into '/F_UCARFTMSF_7_1' folder for 'P_UCARFTMSF_7_1' project
And waited while transcoding is finished in folder '/F_UCARFTMSF_7_1' on project 'P_UCARFTMSF_7_1' files page
When I go to file '120.600.gif' in '/F_UCARFTMSF_7_1' in project 'P_UCARFTMSF_7_1' on related files page
And search and select following files 'at01.odt,atCalcAudio01.mp3,example5.psd,Fish1-Ad.mov' on related file pop-up
Then should see following count '4' of related files