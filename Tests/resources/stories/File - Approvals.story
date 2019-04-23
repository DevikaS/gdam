Feature:          File - Approvals
Narrative:
In order to
As a              AgencyAdmin
I want to         Check file approvals

Scenario: Check that approver can approve the stage
Meta: @skip
      @gdam
Given I created 'P_FA_S1' project
And I created users with following fields:
| Email       | Agency        |
| Approver_S1 | DefaultAgency |
And uploaded 'images/logo.png' file into '/P_FA_S1' folder for 'P_FA_S1' project
And waited while transcoding is finished in folder '/P_FA_S1' on project 'P_FA_S1' files page
And I started approval for 'logo.png' file in folder '/P_FA_S1' project 'P_FA_S1' with '1' stages and the following users:
| Name        | Stage |
| Approver_S1 | 1     |
And logged in with details of 'Approver_S1'
When I open approval of 'Pending Approvals' type for 'logo.png' file on project 'P_FA_S1' approvals tab
And I 'approve' the stage as approver
Then I should see 'No submission for approval have been found for this entity.' text on approvals tab


Scenario: Check that approval owner can approve whole stage
Meta: @skip
      @gdam
Given I created 'P_FA_S2' project
And I created users with following fields:
| Email       | Agency        |
| Approver_S2 | DefaultAgency |
And uploaded 'files/atCalcImage.jpg' file into '/P_FA_S2' folder for 'P_FA_S2' project
And waited while transcoding is finished in folder '/P_FA_S2' on project 'P_FA_S2' files page
And I am on file 'atCalcImage.jpg' info page in folder 'P_FA_S2' project 'P_FA_S2' tab approvals
When I create empty approval stage
And I add the following users to the stage '1':
| Name        |
| Approver_S2 |
And start approval
And I 'approve' the stage '1' as approval owner
Then I 'should' see the stage '1' is locked
And I should see the stage '1' in 'green' color


Scenario: Check that approval owner can reject whole stage
Meta: @skip
      @gdam
Given I created 'P_FA_S3' project
And I created users with following fields:
| Email       | Agency        |
| Approver_S3 | DefaultAgency |
And uploaded 'files/atCalcImage.jpg' file into '/P_FA_S3' folder for 'P_FA_S3' project
And waited while transcoding is finished in folder '/P_FA_S3' on project 'P_FA_S3' files page
And I am on file 'atCalcImage.jpg' info page in folder 'P_FA_S3' project 'P_FA_S3' tab approvals
When I create empty approval stage
And I add the following users to the stage '1':
| Name        |
| Approver_S3 |
And start approval
And I 'reject' the stage '1' as approval owner
Then I 'should' see the stage '1' is locked
And I should see the stage '1' in 'red' color


Scenario: Check that approvers are displayed in a table under relevant stage
Meta: @skip
      @gdam
Given I created 'P_FA_S4' project
And I created users with following fields:
| Email         | Agency        |
| Approver_S4_1 | DefaultAgency |
| Approver_S4_2 | DefaultAgency |
And uploaded 'files/atCalcImage.jpg' file into '/P_FA_S4' folder for 'P_FA_S4' project
And waited while transcoding is finished in folder '/P_FA_S4' on project 'P_FA_S4' files page
When I start approval for 'atCalcImage.jpg' file in folder '/P_FA_S4' project 'P_FA_S4' with '2' stages and the following users:
| Name          | Stage |
| Approver_S4_1 | 1     |
| Approver_S4_2 | 2     |
Then I 'should' see the following users under relevant stage:
| Name          | Stage |
| Approver_S4_1 | 1     |
| Approver_S4_2 | 2     |


Scenario: Check that started approval is displayed in pending approvals
Meta: @skip
      @gdam
Given I created 'P_FA_S5' project
And I created users with following fields:
| Email         | Agency        |
| Approver_S5_1 | DefaultAgency |
And uploaded 'files/atCalcImage.jpg' file into '/P_FA_S5' folder for 'P_FA_S5' project
And waited while transcoding is finished in folder '/P_FA_S5' on project 'P_FA_S5' files page
And I started approval for 'atCalcImage.jpg' file in folder '/P_FA_S5' project 'P_FA_S5' with '1' stages and the following users:
| Name          | Stage |
| Approver_S5_1 | 1     |
And logged in with details of 'Approver_S5_1'
Then I 'should' see approval of 'Pending Approvals' type for 'atCalcImage.jpg' file on project 'P_FA_S5' approvals tab


Scenario: Check that approver can reject the stage
Meta: @skip
      @gdam
Given I created 'P_FA_S6' project
And I created users with following fields:
| Email       | Agency        |
| Approver_S6 | DefaultAgency |
And uploaded 'files/atCalcImage.jpg' file into '/P_FA_S6' folder for 'P_FA_S6' project
And waited while transcoding is finished in folder '/P_FA_S6' on project 'P_FA_S6' files page
And I started approval for 'atCalcImage.jpg' file in folder '/P_FA_S6' project 'P_FA_S6' with '1' stages and the following users:
| Name        | Stage |
| Approver_S6 | 1     |
And logged in with details of 'Approver_S6'
When I open approval of 'Pending Approvals' type for 'atCalcImage.jpg' file on project 'P_FA_S6' approvals tab
And I 'reject' the stage as approver
Then I should see reject stage in 'red' color


Scenario: Check that the same user can be added as approver to several stages
Meta: @skip
      @gdam
Given I created 'P_FA_S7' project
And I created users with following fields:
| Email       | Agency        |
| Approver_S7 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S7' folder for 'P_FA_S7' project
And waited while transcoding is finished in folder '/P_FA_S7' on project 'P_FA_S7' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S7' project 'P_FA_S7' with '2' stages and the following users:
| Name        | Stage |
| Approver_S7 | 1     |
| Approver_S7 | 2     |
Then I 'should' see the following users under relevant stage:
| Name        | Stage |
| Approver_S7 | 1     |
| Approver_S7 | 2     |


Scenario: Check that approver can not be added to the stage after stage was approved
Meta: @skip
      @gdam
Given I created 'P_FA_S8' project
And I created users with following fields:
| Email       | Agency        |
| Approver_S8 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S8' folder for 'P_FA_S8' project
And waited while transcoding is finished in folder '/P_FA_S8' on project 'P_FA_S8' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S8' project 'P_FA_S8' with '1' stages and the following users:
| Name        | Stage |
| Approver_S8 | 1     |
And I 'approve' the stage '1' as approval owner
Then I 'should not' see Add To Stage button for stage '1'


Scenario: Check that approver can not be added to the stage after stage was rejected
Meta: @skip
      @gdam
Given I created 'P_FA_S9' project
And I created users with following fields:
| Email       | Agency        |
| Approver_S9 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S9' folder for 'P_FA_S9' project
And waited while transcoding is finished in folder '/P_FA_S9' on project 'P_FA_S9' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S9' project 'P_FA_S9' with '1' stages and the following users:
| Name        | Stage |
| Approver_S9 | 1     |
And I 'reject' the stage '1' as approval owner
Then I 'should not' see Add To Stage button for stage '1'


Scenario: Check that approver can be added to the stage when approval of file was started
Meta: @skip
      @gdam
Given I created 'P_FA_S10' project
And I created users with following fields:
| Email          | Agency        |
| Approver_S10_1 | DefaultAgency |
| Approver_S10_2 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S10' folder for 'P_FA_S10' project
And waited while transcoding is finished in folder '/P_FA_S10' on project 'P_FA_S10' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S10' project 'P_FA_S10' with '1' stages and the following users:
| Name           | Stage |
| Approver_S10_1 | 1     |
And I add the following users to the stage '1':
| Name           |
| Approver_S10_2 |
Then I 'should' see the following users under relevant stage:
| Name           | Stage |
| Approver_S10_1 | 1     |
| Approver_S10_2 | 1     |


Scenario: Check that owner can add new stage when approval of file was started
Meta: @skip
      @gdam
Given I created 'P_FA_S11' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S11 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S11' folder for 'P_FA_S11' project
And waited while transcoding is finished in folder '/P_FA_S11' on project 'P_FA_S11' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S11' project 'P_FA_S11' with '1' stages and the following users:
| Name         | Stage |
| Approver_S11 | 1     |
And I create empty approval stage
Then I should see the stage '1' in 'grey' color
And I should see the stage '2' in 'grey' color


Scenario: Check that Send Updates button appears after new user was added to the stage
Meta: @skip
      @gdam
Given I created 'P_FA_S12' project
And I created users with following fields:
| Email          | Agency        |
| Approver_S12_1 | DefaultAgency |
| Approver_S12_2 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S12' folder for 'P_FA_S12' project
And waited while transcoding is finished in folder '/P_FA_S12' on project 'P_FA_S12' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S12' project 'P_FA_S12' with '1' stages and the following users:
| Name           | Stage |
| Approver_S12_1 | 1     |
Then I 'should not' see Send Updates button for stage '1'
When I add the following users to the stage '1':
| Name           |
| Approver_S12_2 |
Then I 'should' see Send Updates button for stage '1'


Scenario: Check that approver does not see approval on approvals tab if the stage was approved by approval owner
Meta: @skip
      @gdam
Given I created 'P_FA_S13' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S13 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S13' folder for 'P_FA_S13' project
And waited while transcoding is finished in folder '/P_FA_S13' on project 'P_FA_S13' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S13' project 'P_FA_S13' with '1' stages and the following users:
| Name         | Stage |
| Approver_S13 | 1     |
And I 'approve' the stage '1' as approval owner
And login with details of 'Approver_S13'
Then I 'should not' see approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S13' approvals tab


Scenario: Check that approver does not see approval on approvals tab if the stage was rejected by approval owner
Meta: @skip
      @gdam
Given I created 'P_FA_S14' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S14 | DefaultAgency |
And uploaded 'files/atCalcImage.jpg' file into '/P_FA_S14' folder for 'P_FA_S14' project
And waited while transcoding is finished in folder '/P_FA_S14' on project 'P_FA_S14' files page
When I start approval for 'atCalcImage.jpg' file in folder '/P_FA_S14' project 'P_FA_S14' with '1' stages and the following users:
| Name         | Stage |
| Approver_S14 | 1     |
And I 'reject' the stage '1' as approval owner
And login with details of 'Approver_S14'
Then I 'should not' see approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S14' approvals tab


Scenario: Check that approver does not see approval on approvals tab if he was removed from the stage by approval owner
Meta: @skip
      @gdam
Given I created 'P_FA_S15' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S15 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S15' folder for 'P_FA_S15' project
And waited while transcoding is finished in folder '/P_FA_S15' on project 'P_FA_S15' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S15' project 'P_FA_S15' with '1' stages and the following users:
| Name         | Stage |
| Approver_S15 | 1     |
And I remove the approver 'Approver_S15' from the stage '1'
And login with details of 'Approver_S15'
Then I 'should not' see approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S15' approvals tab


Scenario: Check that approver does not see approval on approvals tab if it was removed from stage 1 and was added to stage 2
Meta: @skip
      @gdam
Given I created 'P_FA_S16' project
And I created users with following fields:
| Email          | Agency        |
| Approver_S16_1 | DefaultAgency |
| Approver_S16_2 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S16' folder for 'P_FA_S16' project
And waited while transcoding is finished in folder '/P_FA_S16' on project 'P_FA_S16' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S16' project 'P_FA_S16' with '2' stages and the following users:
| Name           | Stage |
| Approver_S16_1 | 1     |
| Approver_S16_2 | 1     |
And I remove the approver 'Approver_S16' from the stage '1'
When I add the following users to the stage '2':
| Name           |
| Approver_S16_1 |
And login with details of 'Approver_S16'
Then I 'should not' see approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S16' approvals tab


Scenario: Check that  [All Approve] option is set be default
Meta: @skip
      @gdam
Given I created 'P_FA_S17' project
And uploaded 'images/logo.bmp' file into '/P_FA_S17' folder for 'P_FA_S17' project
And waited while transcoding is finished in folder '/P_FA_S17' on project 'P_FA_S17' files page
And I am on file 'logo.bmp' info page in folder '/P_FA_S17' project 'P_FA_S17' tab approvals
Then I 'should' see that All must approve option is selected by default on create stage form


Scenario: Check that User who has to approve approval can leave a comment
Meta: @skip
      @gdam
Given I created 'P_FA_S18' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S18 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S18' folder for 'P_FA_S18' project
And waited while transcoding is finished in folder '/P_FA_S18' on project 'P_FA_S18' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S18' project 'P_FA_S18' with '1' stages and the following users:
| Name         | Stage |
| Approver_S18 | 1     |
And login with details of 'Approver_S18'
And I open approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S18' approvals tab
And I 'approve' the stage with comment 'Approve Comment' as approver
And login with details of 'AgencyAdmin'
And I go to file 'logo.bmp' info page in folder '/P_FA_S18' project 'P_FA_S18' tab approvals
Then I should see the comment 'Approve Comment' from approver 'Approver_S18' in stage '1'


Scenario: Check that User who has to reject approval can leave a comment
Meta: @skip
      @gdam
Given I created 'P_FA_S19' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S19 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S19' folder for 'P_FA_S19' project
And waited while transcoding is finished in folder '/P_FA_S19' on project 'P_FA_S19' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S19' project 'P_FA_S19' with '1' stages and the following users:
| Name         | Stage |
| Approver_S19 | 1     |
And login with details of 'Approver_S19'
And I open approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S19' approvals tab
And I 'approve' the stage with comment 'Reject Comment' as approver
And login with details of 'AgencyAdmin'
And I go to file 'logo.bmp' info page in folder 'P_FA_S19' project 'P_FA_S19' tab approvals
Then I should see the comment 'Reject Comment' from approver 'Approver_S19' in stage '1'


Scenario: Check that default approval status is pending
Meta: @skip
      @gdam
Given I created 'P_FA_S20' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S20 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S20' folder for 'P_FA_S20' project
And waited while transcoding is finished in folder '/P_FA_S20' on project 'P_FA_S20' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S20' project 'P_FA_S20' with '1' stages and the following users:
| Name         | Stage |
| Approver_S20 | 1     |
Then I should see approval in 'Pending' state
And 'should not' see Close button as enabled


Scenario: Check that approval status is approved when all stages were approved
Meta: @skip
      @gdam
Given I created 'P_FA_S21' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S21 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S21' folder for 'P_FA_S21' project
And waited while transcoding is finished in folder '/P_FA_S21' on project 'P_FA_S21' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S21' project 'P_FA_S21' with '2' stages and the following users:
| Name         | Stage |
| Approver_S21 | 1     |
| Approver_S22 | 2     |
And I 'approve' the stage '1' as approval owner
And I 'approve' the stage '2' as approval owner
Then I should see approval in 'Approved' state


Scenario: Check that approval status is rejected when any stage was rejected
Meta: @skip
      @gdam
Given I created 'P_FA_S22' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S22 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S22' folder for 'P_FA_S22' project
And waited while transcoding is finished in folder '/P_FA_S22' on project 'P_FA_S22' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S22' project 'P_FA_S22' with '2' stages and the following users:
| Name         | Stage |
| Approver_S22 | 1     |
| Approver_S22 | 2     |
And I 'reject' the stage '1' as approval owner
And I 'approve' the stage '2' as approval owner
Then I should see approval in 'Rejected' state


Scenario: Check that approval status cannot be changed after approval was closed
Meta: @skip
      @gdam
Given I created 'P_FA_S23' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S23 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S23' folder for 'P_FA_S23' project
And waited while transcoding is finished in folder '/P_FA_S23' on project 'P_FA_S23' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S23' project 'P_FA_S23' with '1' stages and the following users:
| Name         | Stage |
| Approver_S23 | 1     |
And I 'reject' the stage '1' as approval owner
And I close approval with status 'Rejected'
Then I 'should not' see Change Approval Status dropdown list


Scenario: Check that approver from the second stage is not able to see approval if first stage was rejected
Meta: @skip
      @gdam
Given I created 'P_FA_S24' project
And I created users with following fields:
| Email          | Agency        |
| Approver_S24_1 | DefaultAgency |
| Approver_S24_2 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S24' folder for 'P_FA_S24' project
And waited while transcoding is finished in folder '/P_FA_S24' on project 'P_FA_S24' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S24' project 'P_FA_S24' with '1' stages and the following users:
| Name           | Stage |
| Approver_S24_1 | 1     |
| Approver_S24_2 | 2     |
And I 'reject' the stage '1' as approval owner
And login with details of 'Approver_S24_2'
Then I 'should not' see approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S24' approvals tab


Scenario: Check that approver from the second stage is able to see approval if first stage was approved
Meta: @skip
      @gdam
Given I created 'P_FA_S25' project
And I created users with following fields:
| Email          | Agency        |
| Approver_S25_1 | DefaultAgency |
| Approver_S25_2 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S25' folder for 'P_FA_S25' project
And waited while transcoding is finished in folder '/P_FA_S25' on project 'P_FA_S25' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S25' project 'P_FA_S25' with '2' stages and the following users:
| Name           | Stage |
| Approver_S25_1 | 1     |
| Approver_S25_2 | 2     |
And I 'approve' the stage '1' as approval owner
And login with details of 'Approver_S25_2'
Then I 'should' see approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S25' approvals tab


Scenario: Check that approval owner can set additional options for approval stage
Meta: @skip
      @gdam
Given I created 'P_FA_S26' project
And uploaded 'images/logo.bmp' file into '/P_FA_S26' folder for 'P_FA_S26' project
And waited while transcoding is finished in folder '/P_FA_S26' on project 'P_FA_S26' files page
And I am on file 'logo.bmp' info page in folder '/P_FA_S26' project 'P_FA_S26' tab approvals
When I create empty approval stages with the following options:
| Name       | Description          | ApprovalType    | Deadline           | Reminder           |
| Test Stage | Approval Description | Single Approval | 12/10/2020 17 : 15 | 12/11/2020 12 : 00 |
Then I should see approval stages with the following options:
| Name       | Description          | ApprovalType    | Deadline           | Reminder           |
| Test Stage | Approval Description | Single Approval | 12/10/2020 17 : 15 | 12/11/2020 12 : 00 |


Scenario: Check that approval owner can edit approver comment
Meta: @skip
      @gdam
Given I created 'P_FA_S27' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S27 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S27' folder for 'P_FA_S27' project
And waited while transcoding is finished in folder '/P_FA_S27' on project 'P_FA_S27' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S27' project 'P_FA_S27' with '1' stages and the following users:
| Name         | Stage |
| Approver_S27 | 1     |
And login with details of 'Approver_S27'
And I open approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S27' approvals tab
And I 'approve' the stage with comment 'Reject Comment' as approver
And login with details of 'AgencyAdmin'
And I go to file 'logo.bmp' info page in folder 'P_FA_S27' project 'P_FA_S27' tab approvals
And I update 'Approver_S27' approver comment from stage '1' with text 'Updated Comment'
Then I should see the comment 'Moderated Updated Comment' from approver 'Approver_S27' in stage '1'


Scenario: Check that stage options can be changed if approval stage was not locked
Meta: @skip
      @gdam
Given I created 'P_FA_S28' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S28 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S28' folder for 'P_FA_S28' project
And waited while transcoding is finished in folder '/P_FA_S28' on project 'P_FA_S28' files page
And I am on file 'logo.bmp' info page in folder '/P_FA_S28' project 'P_FA_S28' tab approvals
When I create empty approval stages with the following options:
| Name       | Description          | ApprovalType    | Deadline           | Reminder           |
| Test Stage | Approval Description | Single Approval | 12/10/2020 17 : 15 | 12/11/2020 12 : 00 |
And add the following users to the stage '1':
| Name         |
| Approver_S28 |
And I start approval
And I update approval stages with the following options:
| Name          | Description         | ApprovalType     | Deadline           | Reminder           |
| Updated Stage | Updated Description | All must approve | 12/11/2020 16 : 15 | 12/10/2020 13 : 00 |
Then I should see approval stages with the following options:
| Name          | Description         | ApprovalType     | Deadline           | Reminder           |
| Updated Stage | Updated Description | All must approve | 12/11/2020 16 : 15 | 12/10/2020 13 : 00 |


Scenario: Check that stage options can be changed if approval stage was locked
Meta: @skip
      @gdam
Given I created 'P_FA_S29' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S29 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S29' folder for 'P_FA_S29' project
And waited while transcoding is finished in folder '/P_FA_S29' on project 'P_FA_S29' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S29' project 'P_FA_S29' with '1' stages and the following users:
| Name         | Stage |
| Approver_S29 | 1     |
And I 'approve' the stage '1' as approval owner
Then I 'should not' see Edit button for stage '1'


Scenario: Check that stage with type All must approve is approved when all approvers approve the stage
Meta: @skip
      @gdam
Given I created 'P_FA_S30' project
And I created users with following fields:
| Email          | Agency        |
| Approver_S30_1 | DefaultAgency |
| Approver_S30_2 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S30' folder for 'P_FA_S30' project
And waited while transcoding is finished in folder '/P_FA_S30' on project 'P_FA_S30' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S30' project 'P_FA_S30' with '1' stages and the following users:
| Name           | Stage |
| Approver_S30_1 | 1     |
| Approver_S30_2 | 1     |
And login with details of 'Approver_S30_1'
And I open approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S30' approvals tab
And I 'approve' the stage as approver
And login with details of 'Approver_S30_2'
And I open approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S30' approvals tab
And I 'approve' the stage as approver
And login with details of 'AgencyAdmin'
And I go to file 'logo.bmp' info page in folder '/P_FA_S30' project 'P_FA_S30' tab approvals
Then I 'should' see the stage '1' is locked
And I should see the stage '1' in 'green' color


Scenario: Check that stage with type Single Approval is approved when one approver approve the stage
Meta: @skip
      @gdam
Given I created 'P_FA_S31' project
And I created users with following fields:
| Email          | Agency        |
| Approver_S31_1 | DefaultAgency |
| Approver_S31_2 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S31' folder for 'P_FA_S31' project
And waited while transcoding is finished in folder '/P_FA_S31' on project 'P_FA_S31' files page
And I am on file 'logo.bmp' info page in folder '/P_FA_S31' project 'P_FA_S31' tab approvals
When I create empty approval stages with the following options:
| ApprovalType    |
| Single Approval |
And I add the following users to the stage '1':
| Name           |
| Approver_S31_1 |
| Approver_S31_2 |
And I start approval
And login with details of 'Approver_S31_1'
And I open approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S31' approvals tab
And I 'approve' the stage as approver
And login with details of 'AgencyAdmin'
And I go to file 'logo.bmp' info page in folder '/P_FA_S31' project 'P_FA_S31' tab approvals
Then I 'should' see the stage '1' is locked
And I should see the stage '1' in 'green' color


Scenario: Check approval is removed from pending approvals after project was deleted
Meta: @skip
      @gdam
Given I created 'P_FA_S32' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S32 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S32' folder for 'P_FA_S32' project
And waited while transcoding is finished in folder '/P_FA_S32' on project 'P_FA_S32' files page
And I started approval for 'logo.bmp' file in folder '/P_FA_S32' project 'P_FA_S32' with '1' stages and the following users:
| Name         | Stage |
| Approver_S32 | 1     |
And I deleted 'P_FA_S32' project
When login with details of 'Approver_S32'
Then I 'should not' see approval of 'Pending Approvals' type for 'logo.bmp' file on approvals tab


Scenario: Check approval is removed from pending approvals after folder was deleted
Meta: @skip
      @gdam
Given I created 'P_FA_S33' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S33 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S33' folder for 'P_FA_S33' project
And waited while transcoding is finished in folder '/P_FA_S33' on project 'P_FA_S33' files page
And I started approval for 'logo.bmp' file in folder '/P_FA_S33' project 'P_FA_S33' with '1' stages and the following users:
| Name         | Stage |
| Approver_S33 | 1     |
And I deleted folder '/P_FA_S33' in project 'P_FA_S33'
When login with details of 'Approver_S33'
Then I 'should not' see approval of 'Pending Approvals' type for 'logo.bmp' file on approvals tab


Scenario: Check approval is removed from pending approvals after file was deleted
Meta: @skip
      @gdam
Given I created 'P_FA_S34' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S34 | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S34' folder for 'P_FA_S34' project
And waited while transcoding is finished in folder '/P_FA_S34' on project 'P_FA_S34' files page
And I started approval for 'logo.bmp' file in folder '/P_FA_S34' project 'P_FA_S34' with '1' stages and the following users:
| Name         | Stage |
| Approver_S34 | 1     |
And I am on project 'P_FA_S34' folder '/P_FA_S34' page
When I 'delete' file 'logo.bmp' from project files page
When login with details of 'Approver_S34'
Then I 'should not' see approval of 'Pending Approvals' type for 'logo.bmp' file on approvals tab


Scenario: Check that user who added in project team is able to approve file
Meta: @skip
      @gdam
Given I created '<Project>' project
And I created users with following fields:
| Email  | Role        | Agency        |
| <User> | agency.user | DefaultAgency |
And uploaded 'images/logo.bmp' file into '<Folder>' folder for '<Project>' project
And waited while transcoding is finished in folder '<Folder>' on project '<Project>' files page
And added users '<User>' to project '<Project>' team folders '<Folder>' with role '<RoleName>' expired '12.12.2021'
And I started approval for 'logo.bmp' file in folder '<Folder>' project '<Project>' with '1' stages and the following users:
| Name   | Stage |
| <User> | 1     |
When login with details of '<User>'
And I open approval of 'Pending Approvals' type for 'logo.bmp' file on project '<Project>' approvals tab
And I 'approve' the stage as approver
Then I should see 'No submission for approval have been found for this entity.' text on approvals tab

Examples:
| User           | RoleName            | Project    | Folder      |
| Approver_S35_1 | project.user        | P_FA_S35_1 | /P_FA_S35_1 |
| Approver_S35_2 | project.observer    | P_FA_S35_2 | /P_FA_S35_2 |
| Approver_S35_3 | project.contributor | P_FA_S35_3 | /P_FA_S35_3 |


Scenario: Check approval is displayed on 'Approvals' tab of the project in 'Submitted approval' for owner
Meta: @skip
      @gdam
Given I created users with following fields:
| Email          | Agency        |
| Approver_S37_1 | DefaultAgency |
| Approver_S37_2 | DefaultAgency |
And I logged in with details of 'Approver_S37_37'
And I created 'P_FA_S37' project
And uploaded 'images/logo.bmp' file into '/P_FA_S37' folder for 'P_FA_S37' project
And waited while transcoding is finished in folder '/P_FA_S37' on project 'P_FA_S37' files page
When I start approval for 'logo.bmp' file in folder '/P_FA_S37' project 'P_FA_S37' with '1' stages and the following users:
| Name           | Stage |
| Approver_S37_2 | 1     |
Then I 'should' see approval of 'Submitted Approvals' type for 'logo.bmp' file on project 'P_FA_S37' approvals tab


Scenario: Check contributor does not have access to the approvals if approval stage was created by owner
Meta: @skip
      @gdam
Given I created 'P_FA_S38' project
And I created users with following fields:
| Email        | Role        | Agency        |
| Cont_S38     | agency.user | DefaultAgency |
| Approver_S38 | agency.user | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S38' folder for 'P_FA_S38' project
And waited while transcoding is finished in folder '/P_FA_S38' on project 'P_FA_S38' files page
And added users 'Cont_S38' to project 'P_FA_S38' team folders '/P_FA_S38' with role 'project.contributor' expired '12.12.2021'
And I started approval for 'logo.bmp' file in folder '/P_FA_S38' project 'P_FA_S38' with '1' stages and the following users:
| Name         | Stage |
| Approver_S38 | 38    |
When login with details of 'Cont_S38'
And I go to file 'logo.bmp' info page in folder '/P_FA_S38' project 'P_FA_S38' tab approvals
Then I should see 'You're not or no longer allowed to access this resource' notification on approvals tab


Scenario: Check contributor does not have access to the approvals if approval stage was created by other contributor
Meta: @skip
      @gdam
Given I created 'P_FA_S39' project
And I created users with following fields:
| Email        | Role        | Agency        |
| Cont_S39_1   | agency.user | DefaultAgency |
| Cont_S39_2   | agency.user | DefaultAgency |
| Approver_S39 | agency.user | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S39' folder for 'P_FA_S39' project
And waited while transcoding is finished in folder '/P_FA_S39' on project 'P_FA_S39' files page
And added users 'Cont_S39_1,Cont_S39_2' to project 'P_FA_S39' team folders '/P_FA_S39' with role 'project.contributor' expired '12.12.2021'
And I logged in with details of 'Cont_S39_39'
And I started approval for 'logo.bmp' file in folder '/P_FA_S39' project 'P_FA_S39' with '1' stages and the following users:
| Name         | Stage |
| Approver_S39 | 1     |
When login with details of 'Cont_S39_2'
And I go to file 'logo.bmp' info page in folder '/P_FA_S39' project 'P_FA_S39' tab approvals
Then I should see 'You're not or no longer allowed to access this resource' notification on approvals tab


Scenario: Check contributor is able to approve stage as approver if this stage was created by owner
Meta: @skip
      @gdam
Given I created 'P_FA_S40' project
And I created users with following fields:
| Email    | Role        | Agency        |
| Cont_S40 | agency.user | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S40' folder for 'P_FA_S40' project
And waited while transcoding is finished in folder '/P_FA_S40' on project 'P_FA_S40' files page
And added users 'Cont_S40' to project 'P_FA_S40' team folders '/P_FA_S40' with role 'project.contributor' expired '12.12.2021'
And I started approval for 'logo.bmp' file in folder '/P_FA_S40' project 'P_FA_S40' with '1' stages and the following users:
| Name     | Stage |
| Cont_S40 | 1     |
And I logged in with details of 'Cont_S40'
When I open approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S40' approvals tab
And I 'approve' the stage as approver
Then I should see 'No submission for approval have been found for this entity.' text on approvals tab


Scenario: Check contributor is able to approve stage as approver if this stage was created by contributor
Meta: @skip
      @gdam
Given I created 'P_FA_S41' project
And I created users with following fields:
| Email      | Role        | Agency        |
| Cont_S41_1 | agency.user | DefaultAgency |
| Cont_S41_2 | agency.user | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S41' folder for 'P_FA_S41' project
And waited while transcoding is finished in folder '/P_FA_S41' on project 'P_FA_S41' files page
And added users 'Cont_S41_1,Cont_S41_2' to project 'P_FA_S41' team folders '/P_FA_S41' with role 'project.contributor' expired '12.12.2021'
And I logged in with details of 'Cont_S41_1'
And I started approval for 'logo.bmp' file in folder '/P_FA_S41' project 'P_FA_S41' with '1' stages and the following users:
| Name       | Stage |
| Cont_S41_2 | 1     |
And I logged in with details of 'Cont_S41_2'
When I open approval of 'Pending Approvals' type for 'logo.bmp' file on project 'P_FA_S41' approvals tab
And I 'approve' the stage as approver
Then I should see 'No submission for approval have been found for this entity.' text on approvals tab


Scenario: Check observer doesn't have access to approvals tab
Meta: @skip
      @gdam
Given I created 'P_FA_S42' project
And I created users with following fields:
| Email   | Role        | Agency        |
| Obs_S42 | agency.user | DefaultAgency |
And uploaded 'images/logo.bmp' file into '/P_FA_S42' folder for 'P_FA_S42' project
And waited while transcoding is finished in folder '/P_FA_S42' on project 'P_FA_S42' files page
And added users 'Obs_S42' to project 'P_FA_S42' team folders '/P_FA_S42' with role 'project.observer' expired '12.12.2021'
And I logged in with details of 'Obs_S42'
When I go to file 'logo.bmp' info page in folder '/P_FA_S42' project 'P_FA_S42' tab approvals
Then I should see 'You're not or no longer allowed to access this resource' notification on approvals tab


Scenario: Check that approver can reject the stage using reject button from the file view
Meta: @skip
      @gdam
Given I created 'P_FA_S43' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S43 | DefaultAgency |
And uploaded 'files/atCalcImage.jpg' file into '/P_FA_S43' folder for 'P_FA_S43' project
And waited while transcoding is finished in folder '/P_FA_S43' on project 'P_FA_S43' files page
And I started approval for 'atCalcImage.jpg' file in folder '/P_FA_S43' project 'P_FA_S43' with '1' stages and the following users:
| Name         | Stage |
| Approver_S43 | 1     |
And logged in with details of 'Approver_S43'
When I go to file 'atCalcImage.jpg' info page in folder '/P_FA_S43' project 'P_FA_S43'
And I reject file using top reject button
Then I 'should not' see approve top button
And I 'should not' see reject top button
And I should see reject stage in 'red' color


Scenario: Check that approver can approve the stage using approve button from the file view
Meta: @skip
      @gdam
Given I created 'P_FA_S44' project
And I created users with following fields:
| Email        | Agency        |
| Approver_S44 | DefaultAgency |
And uploaded 'images/logo.png' file into '/P_FA_S44' folder for 'P_FA_S44' project
And waited while transcoding is finished in folder '/P_FA_S44' on project 'P_FA_S44' files page
And I started approval for 'logo.png' file in folder '/P_FA_S44' project 'P_FA_S44' with '1' stages and the following users:
| Name         | Stage |
| Approver_S44 | 1     |
And logged in with details of 'Approver_S44'
When I open approval of 'Pending Approvals' type for 'logo.png' file on project 'P_FA_S44' approvals tab
And I approve file using top approve button
Then I 'should not' see approve top button
And I 'should not' see reject top button
And I should see 'You're not or no longer allowed to access this resource' notification on approvals tab


Scenario: Check that Automatically close approval is checked by default in file approvals tab when it is set to true in BU settings page
Meta:@gdam
@approvals
Given I created the agency 'A_FCVSTL_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| E_FCVSTL_S01 | agency.admin | A_FCVSTL_S01 |
| E_FCVSTL_S02 | agency.admin | A_FCVSTL_S01 |
And logged in with details of 'GlobalAdmin'
And I updated agency 'A_FCVSTL_S01' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Auto Close Approval | true       |
When I login with details of 'E_FCVSTL_S01'
And create 'P_FCVSTL_S01' project
And create '/F_FCVSTL_S01' folder for project 'P_FCVSTL_S01'
And upload '/files/image9.jpg' file into '/F_FCVSTL_S01' folder for 'P_FCVSTL_S01' project
And wait while transcoding is finished on project 'P_FCVSTL_S01' in folder '/F_FCVSTL_S01' for 'image9.jpg' file
And add approval stage on file 'image9.jpg' approvals page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01':
| Name            | Approvers                 | Deadline         | Reminder         | Description       |
| AS_FCVSTL_S01_2 |  E_FCVSTL_S02 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 |
And go to file 'image9.jpg' info page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01' tab approvals
Then I 'should' see checkbox 'Auto Close Approval' selected on opened approvals page


Scenario: Check that Automatically close approval is unchecked by default in file approvals tab when it is set to flase in BU settings page
Meta:@gdam
@approvals
Given I created the agency 'A_FCVSTL_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| E_FCVSTL_S01 | agency.admin | A_FCVSTL_S01 |
| E_FCVSTL_S02 | agency.admin | A_FCVSTL_S01 |
And logged in with details of 'GlobalAdmin'
And I updated agency 'A_FCVSTL_S01' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Auto Close Approval | false       |
When I login with details of 'E_FCVSTL_S01'
And create 'P_FCVSTL_S01' project
And create '/F_FCVSTL_S01' folder for project 'P_FCVSTL_S01'
And upload '/files/image9.jpg' file into '/F_FCVSTL_S01' folder for 'P_FCVSTL_S01' project
And wait while transcoding is finished on project 'P_FCVSTL_S01' in folder '/F_FCVSTL_S01' for 'image9.jpg' file
And add approval stage on file 'image9.jpg' approvals page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01':
| Name            | Approvers                 | Deadline         | Reminder         | Description       |
| AS_FCVSTL_S01_2 |  E_FCVSTL_S02 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 |
And go to file 'image9.jpg' info page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01' tab approvals
Then I 'should not' see checkbox 'Auto Close Approval' selected on opened approvals page


Scenario: Check that Close button is not displayed in file approvals tab after approver approves a file (when Auto Close approval is set to true in BU settings page)
Meta:@gdam
@approvals
Given I created the agency 'A_FCVSTL_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| E_FCVSTL_S01 | agency.admin | A_FCVSTL_S01 |
| E_FCVSTL_S02 | agency.admin | A_FCVSTL_S01 |
And logged in with details of 'GlobalAdmin'
And I updated agency 'A_FCVSTL_S01' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Auto Close Approval | true       |
When I login with details of 'E_FCVSTL_S01'
And create 'P_FCVSTL_S01' project
And create '/F_FCVSTL_S01' folder for project 'P_FCVSTL_S01'
And upload '/files/image9.jpg' file into '/F_FCVSTL_S01' folder for 'P_FCVSTL_S01' project
And wait while transcoding is finished on project 'P_FCVSTL_S01' in folder '/F_FCVSTL_S01' for 'image9.jpg' file
And add approval stage on file 'image9.jpg' approvals page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01':
| Name            | Approvers                 | Deadline         | Reminder         | Description       |
| AS_FCVSTL_S01_2 |  E_FCVSTL_S02 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 |
And I login with details of 'E_FCVSTL_S02'
And click file 'image9.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test description1' on opened file info page
And I login with details of 'E_FCVSTL_S01'
And go to file 'image9.jpg' info page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01' tab approvals
Then I 'should not' see Close button displayed


Scenario: Check that Close button is displayed in file approvals tab after approver approves a file (when Auto Close approval is set to false in BU settings page)
Meta:@gdam
@approvals
Given I created the agency 'A_FCVSTL_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| E_FCVSTL_S01 | agency.admin | A_FCVSTL_S01 |
| E_FCVSTL_S02 | agency.admin | A_FCVSTL_S01 |
And logged in with details of 'GlobalAdmin'
And I updated agency 'A_FCVSTL_S01' with following fields on agency overview page:
| FieldName     | FieldValue |
| Enable Auto Close Approval | false       |
When I login with details of 'E_FCVSTL_S01'
And create 'P_FCVSTL_S01' project
And create '/F_FCVSTL_S01' folder for project 'P_FCVSTL_S01'
And upload '/files/image9.jpg' file into '/F_FCVSTL_S01' folder for 'P_FCVSTL_S01' project
And wait while transcoding is finished on project 'P_FCVSTL_S01' in folder '/F_FCVSTL_S01' for 'image9.jpg' file
And add approval stage on file 'image9.jpg' approvals page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01':
| Name            | Approvers                 | Deadline         | Reminder         | Description       |
| AS_FCVSTL_S01_2 |  E_FCVSTL_S02 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 |
And I login with details of 'E_FCVSTL_S02'
And click file 'image9.jpg' in 'Received' tab in 'Approvals' section on dashboard page
And 'approve' file with comment 'test description1' on opened file info page
And I login with details of 'E_FCVSTL_S01'
And go to file 'image9.jpg' info page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01' tab approvals
Then I 'should' see Close button displayed


Scenario: Check that Automatically close approval is not checked by default in file approvals tab when Approvals checkbox  is selected at user level and Auto Approval is set to false at BU level)
Meta:@gdam
@approvals
Given I created the agency 'A_FCVSTL_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access |
| E_FCVSTL_S01 | agency.admin | A_FCVSTL_S01 |folders,dashboard,approvals |
| E_FCVSTL_S02 | agency.admin | A_FCVSTL_S01 |folders,dashboard,approvals |
When I login with details of 'E_FCVSTL_S01'
And create 'P_FCVSTL_S01' project
And create '/F_FCVSTL_S01' folder for project 'P_FCVSTL_S01'
And upload '/files/image9.jpg' file into '/F_FCVSTL_S01' folder for 'P_FCVSTL_S01' project
And wait while transcoding is finished on project 'P_FCVSTL_S01' in folder '/F_FCVSTL_S01' for 'image9.jpg' file
And add approval stage on file 'image9.jpg' approvals page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01':
| Name            | Approvers                 | Deadline         | Reminder         | Description       |
| AS_FCVSTL_S01_2 |  E_FCVSTL_S02 | 01/05/2023 12:15 | 01/05/2023 08:00 | test description1 |
And go to file 'image9.jpg' info page in folder '/F_FCVSTL_S01' project 'P_FCVSTL_S01' tab approvals
Then I 'should not' see checkbox 'Auto Close Approval' selected on opened approvals page
