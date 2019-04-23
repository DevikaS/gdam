!--NGN-480
Feature:          Templates - Copy Move files - Template search
Narrative:
In order to
As a              AgencyAdmin
I want to         Check template searching on Copy/Move files

Scenario: Check that after clicking on 'Want to move files to another project?' link Search template field is displayed on Move pop-up
Meta:@gdam
@projects
Given I created 'T_TCMFTSS_S1_1' template
And created '/F_TCMFTSS_S1_1' folder for template 'T_TCMFTSS_S1_1'
And uploaded into template 'T_TCMFTSS_S1_1' following files:
| FileName         | Path            |
| /images/logo.jpg | /F_TCMFTSS_S1_1 |
And I am on template 'T_TCMFTSS_S1_1' folder '/F_TCMFTSS_S1_1' page
When I click on Want to move files to another project link on move/copy file 'logo.jpg' popup
Then I 'should' see search input field on move/copy file popup for template


Scenario: Check that after clicking on 'Want to copy files to another project?' link Search template field is displayed on Copy pop-up
Meta:@gdam
@projects
Given I created 'T_TCMFTSS_S2_1' template
And created '/F_TCMFTSS_S2_1' folder for template 'T_TCMFTSS_S2_1'
And uploaded into template 'T_TCMFTSS_S2_1' following files:
| FileName         | Path            |
| /images/logo.jpg | /F_TCMFTSS_S2_1 |
And I am on template 'T_TCMFTSS_S2_1' folder '/F_TCMFTSS_S2_1' page
When I click on Want to copy files to another project link on move/copy file 'logo.jpg' popup
Then I 'should' see search input field on move/copy file popup for template


Scenario: Search template in look-up
Meta: @bug
      @gdam
      @projects
!-- Fails till FAB-404 gets fixed
Given I created following templates:
| Name                             |
| Nødhjælp Second Third_TCMFTSS_S3 |
| Nødhjælp Second_TCMFTSS_S3       |
| Nødhjælp_TCMFTSS_S3              |
| O'Higgins_TCMFTSS_S3             |
| Česky_TCMFTSS_S3                 |
| Català_TCMFTSS_S3                |
| Template1_TCMFTSS_S3             |
And created '/F_TCMFTSS_S3_1' folder for template 'Template1_TCMFTSS_S3'
And uploaded into template 'Template1_TCMFTSS_S3' following files:
| FileName         | Path            |
| /images/logo.jpg | /F_TCMFTSS_S3_1 |
And I am on template 'Template1_TCMFTSS_S3' folder '/F_TCMFTSS_S3_1' page
And I clicked on Want to copy files to another project link on move/copy file 'logo.jpg' popup
When I type '<Text>' in search field on move/copy file popup
Then I should see templates '<Templates>' are available for selecting on move/copy file popup according to '<Text>'

Examples:
| Text                  | Templates                                                                       |
| Nødhjælp              | Nødhjælp Second Third_TCMFTSS_S3,Nødhjælp Second_TCMFTSS_S3,Nødhjælp_TCMFTSS_S3 |

Scenario: Check that another template can be found and selected
Meta: @bug
      @gdam
      @projects
!-- Fails till FAB-404 gets fixed
Given I created following templates:
| Name           |
| T_TCMFTSS_S4_1 |
| T_TCMFTSS_S4_2 |
And created '/F_TCMFTSS_S4_1' folder for template 'T_TCMFTSS_S4_1'
And created '/F_TCMFTSS_S4_2' folder for template 'T_TCMFTSS_S4_2'
And uploaded into template 'T_TCMFTSS_S4_1' following files:
| FileName         | Path            |
| /images/logo.jpg | /F_TCMFTSS_S4_1 |
And I am on template 'T_TCMFTSS_S4_1' folder '/F_TCMFTSS_S4_1' page
And I clicked on Want to copy files to another project link on move/copy file 'logo.jpg' popup
When I enter 'T_TCMFTSS_S4_2' in search field on move/copy file popup
And I select template 'T_TCMFTSS_S4_2' on move/copy file popup
Then I should see selected template 'T_TCMFTSS_S4_2' with folder '/F_TCMFTSS_S4_2' on move/copy file popup