!--NGN-5705
Feature:          Rework Approval - Create - edit stage
Narrative:
In order to
As a              AgencyAdmin
I want to         Check file approvals

Scenario: Check text on 'Approval tab' of file
Meta: @skip
      @gdam
Given I created users with following fields:
| Email   |
| AppU_S1 |
And I created 'P_FA_S1' project
And uploaded 'images/logo.png' file into '/P_FA_S1' folder for 'P_FA_S1' project
And waited while transcoding is finished in folder '/P_FA_S1' on project 'P_FA_S1' files page
When I go to file 'logo.png' info page in folder 'P_FA_S1' project 'P_FA_S1' tab approvals
Then I should see text on page contains 'Get this file approved'
And I 'should' see following elements on page 'FilesPage':
| element           |
| SubmitForApproval |
| ApplyTemplate     |


Scenario: Check that click on 'Submit Approval' link open new stage dialog with proper elements
Meta: @skip
      @gdam
Given I created users with following fields:
| Email   |
| AppU_S2 |
And I created 'P_FA_S2' project
And uploaded 'images/logo.png' file into '/P_FA_S2' folder for 'P_FA_S2' project
And waited while transcoding is finished in folder '/P_FA_S2' on project 'P_FA_S2' files page
When I go to file 'logo.png' info page in folder 'P_FA_S2' project 'P_FA_S2' tab approvals
And I click element 'SubmitForApproval' on page 'FilesPage'
Then I should see stage pop up with 'Add a new stage' title
And I 'should' see following elements on page 'StagePopUp':
| element                |
| StartButton            |
| SaveAndCloseButton     |
| AdvancedSettingsButton |


Scenario: Check that stage cannot be created without approvers
Meta: @skip
      @gdam
Given I created users with following fields:
| Email   |
| AppU_S3 |
And I created 'P_FA_S3' project
And uploaded 'images/logo.png' file into '/P_FA_S3' folder for 'P_FA_S3' project
And waited while transcoding is finished in folder '/P_FA_S3' on project 'P_FA_S3' files page
When I go to file 'logo.png' info page in folder 'P_FA_S2' project 'P_FA_S2' tab approvals
And I click element 'SubmitForApproval' on page 'FilesPage'
Then I should see 'Stage 1' text in 'Name' field
And should see 'Start' button is disabled


Scenario: Check that added users appear on stage after save
Meta: @skip
      @gdam
Given I created users with following fields:
| Email     |
| AppU_S4_1 |
| AppU_S4_2 |
And I logged in with details of 'AppU_S4_1'
And I created 'P_FA_S4' project
And uploaded 'images/logo.png' file into '/P_FA_S4' folder for 'P_FA_S4' project
And waited while transcoding is finished in folder '/P_FA_S4' on project 'P_FA_S4' files page
And I added approval stage on file 'logo.png' approvals page in folder '/P_FA_S4' project 'P_FA_S4':
| Approvers           |
| AppU_S4_1,AppU_S4_2 |
Then I 'should' see the following users under relevant stage:
| Approvers | Stage |
| AppU_S4_1 | 1     |
| AppU_S4_2 | 1     |
And I should see '2' approvers for stage '1'


Scenario: Check that all entered data properly displays after saving
Meta: @skip
      @gdam
Given I created users with following fields:
| Email     |
| AppU_S5_1 |
| AppU_S5_2 |
And I created 'P_FA_S5' project
And uploaded 'images/logo.png' file into '/P_FA_S5' folder for 'P_FA_S5' project
And waited while transcoding is finished in folder '/P_FA_S5' on project 'P_FA_S5' files page
And I added approval stage on file 'logo.png' approvals page in folder '/P_FA_S5' project 'P_FA_S5':
| Name         | Approvers | Descripton    | Deadline   | Reminder   |
| <Stage_name> | <Users>   | <Description> | <Deadline> | <Reminder> |
Then I should see approval stages with the following options:
| StageNumber | Name         | Approvers | Descripton    | Deadline   | Reminder   |
| 1           | <Stage_name> | <Users>   | <Description> | <Deadline> | <Reminder> |

Examples:
| Users               | Stage_name   | Description | Deadline         | Reminder         |
| AppU_S5_1,AppU_S5_2 | Big Stage_S5 | Test stage  | 01/05/2023 12:15 | 01/05/2023 08:00 |


Scenario: Check 'Advanced settings' additional pop up
Meta: @skip
      @gdam
Given I created users with following fields:
| Email     |
| AppU_S7_1 |
| AppU_S7_2 |
And I created 'P_FA_S7' project
And uploaded 'images/logo.png' file into '/P_FA_S7' folder for 'P_FA_S7' project
And waited while transcoding is finished in folder '/P_FA_S7' on project 'P_FA_S7' files page
When I go to file 'logo.png' info page in folder 'P_FA_S7' project 'P_FA_S7' tab approvals
And I click element 'SubmitForApproval' on page 'FilesPage'
And click element 'AdvancedSettingsButton' on page 'StagePopUp'
Then I should see <Elements> on 'Advanced settings' pop up

Examples:
| Elements                              |
| 'Multiple approval stage' radiobutton |
| 'Single approval stage' radiobutton   |
| 'Add stage Owners' checkbox           |
| 'Save & Back' element                 |
| 'Save & Close' element                |


Scenario: Check the ability to add new stage after creation first one
Meta: @skip
      @gdam
Given I created users with following fields:
| Email   |
| AppU_S7 |
And I created 'P_FA_S7' project
And uploaded 'images/logo.png' file into '/P_FA_S7' folder for 'P_FA_S7' project
And waited while transcoding is finished in folder '/P_FA_S7' on project 'P_FA_S7' files page
And I added approval stage on file 'logo.png' approvals page in folder '/P_FA_S7' project 'P_FA_S7':
| Approvers | Descripton    | Deadline   | Reminder   |
| <Users>   | <Description> | <Deadline> | <Reminder> |
| <Users>   | <Description> | <Deadline> | <Reminder> |
Then I should see approval stages with the following options:
| Stage | Name    | Approvers | Descripton    | Deadline   | Reminder   |
| 1     | Stage 1 | <Users>   | <Description> | <Deadline> | <Reminder> |
| 2     | Stage 2 | <Users>   | <Description> | <Deadline> | <Reminder> |

Examples:
| Users   | Stage_name   | Description | Deadline         | Reminder         |
| AppU_S7 | Big Stage_S7 | Test stage  | 01/05/2023 12:15 | 01/04/2023 08:00 |


Scenario: Check that stage can be removed and doesn't appear after removing
Meta: @skip
      @gdam
Given I created users with following fields:
| Email   |
| AppU_S8 |
And I created 'P_FA_S8' project
And uploaded 'images/logo.png' file into '/P_FA_S8' folder for 'P_FA_S8' project
And waited while preview is available in folder '/P_FA_S8' on project 'P_FA_S8' files page
And I added approval stage on file 'logo.png' approvals page in folder '/P_FA_S8' project 'P_FA_S8':
| Approvers |
| AppU_S8   |
When I remove 'AppU_S8' approval stage
Then I should see text on page contains 'Get this file approved'
And I 'should' see following elements on page 'FilesPage':
| element           |
| SubmitForApproval |
| ApplyTemplate     |


Scenario: Check that use is able to edit the stage
Meta: @skip
      @gdam
Given I created users with following fields:
| Email     |
| AppU_S9_1 |
| AppU_S9_2 |
And I created 'P_FA_S9' project
And uploaded 'images/logo.png' file into '/P_FA_S9' folder for 'P_FA_S9' project
And waited while transcoding is finished in folder '/P_FA_S9' on project 'P_FA_S9' files page
And I added approval stage on file 'logo.png' approvals page in folder '/P_FA_S9' project 'P_FA_S9':
| Approvers | Name         | Descripton | Deadline         | Reminder         |
| AppU_S9_1 | Big Stage_S9 | Test stage | 01/05/2023 12:15 | 01/05/2023 08:00 |
When I update approval stages using the following data:
| Stage | Approvers | Name         | Descripton    | Deadline   | Reminder   |
| 1     | <Users>   | <Stage_name> | <Description> | <Deadline> | <Reminder> |
Then I should see approval stages with the following options:
| Stage | Name         | Approvers | Descripton    | Deadline   | Reminder   |
| 1     | <Stage_name> | <Users>   | <Description> | <Deadline> | <Reminder> |

Examples:
| Users     | Stage_name       | Description | Deadline         | Reminder         |
| AppU_S9_2 | Updated Stage_S9 | Test stage  | 01/05/2023 13:15 | 01/05/2023 02:00 |