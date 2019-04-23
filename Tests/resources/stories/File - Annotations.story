Feature:          File - Annotations
Narrative:
In order to
As a              AgencyAdmin
I want to         Check file annotations

Scenario: Add an annotation for a file and check activity published
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role         | Agency        |   Access                               |
| U_CA_1       | agency.user  | DefaultAgency |  dashboard,folders,library,annotations |
And I logged in with details of 'U_CA_1'
And created 'P_CA_1' project
And created '/F_CA_1' folder for project 'P_CA_1'
And uploaded '/files/Fish1-Ad.mov' file into '/F_CA_1' folder for 'P_CA_1' project
And waited while preview is available in folder '/F_CA_1' on project 'P_CA_1' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/F_CA_1' project 'P_CA_1'
Then I 'should' see Annotate button on file info page
When I click on Annotation button on file info page
And I play the file on the opened Annotations tool
And I created an annotation with notes 'Make changes to the format' and 'save' it
Then I 'should' see the annotation with notes 'Make changes to the format'
And I should close the annotations window after the checks
And I 'should' see on Activity tab for file '/files/Fish1-Ad.mov' in folder '/F_CA_1' project 'P_CA_1' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage                                                   |
| U_CA_1 | EMPTY | created      | has annotated file with a comment: Make changes to the format     |
When I set Action 'File annotated' on Activity tab on open uploaded file '/files/Fish1-Ad.mov' in folder '/F_CA_1' project 'P_CA_1'
And I click on filter button in Activity tab on open uploaded file '/files/Fish1-Ad.mov' in folder '/F_CA_1' project 'P_CA_1'
Then I 'should' see on Activity tab for file '/files/Fish1-Ad.mov' in folder '/F_CA_1' project 'P_CA_1' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage                                                   |
| U_CA_1 | EMPTY | created      | has annotated file with a comment: Make changes to the format     |
When I go to project 'P_CA_1' overview page
Then I 'should' see following activities in 'Recent Activity' section on opened Project Overview page:
| UserName     | Message                                                       | Value         |
| U_CA_1       | has annotated file with a comment: Make changes to the format | /Fish1-Ad.mov |
When I set Action 'File annotated' on project overview page for project
And I click on filter button on project overview page
Then I 'should' see following activities in 'Recent Activity' section on opened Project Overview page:
| UserName     | Message                                                       | Value         |
| U_CA_1       | has annotated file with a comment: Make changes to the format | /Fish1-Ad.mov |
When go to project 'P_CA_1' teams page
Then I 'should' see activity for user 'U_CA_1' on project team page with message 'has annotated file with a comment: Make changes to the format' and value '/Fish1-Ad.mov'
When go to Dashboard page
Then 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName | Message                                                       | Value             |
| U_CA_1   | has annotated file with a comment: Make changes to the format | /Fish1-Ad.mov     |
When I set Action 'File annotated' on Dashboard Page
And I click link 'Filter' on Dashboard Page
Then 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName | Message                                                       | Value             |
| U_CA_1   | has annotated file with a comment: Make changes to the format | /Fish1-Ad.mov     |


Scenario: Edit an annotation for a file
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role         | Agency        |   Access                               |
| U_CA_2       | agency.user  | DefaultAgency |  dashboard,folders,library,annotations |
And I logged in with details of 'U_CA_2'
And created 'P_CA_2' project
And created '/F_CA_2' folder for project 'P_CA_2'
And uploaded '/files/Fish1-Ad.mov' file into '/F_CA_2' folder for 'P_CA_2' project
And waited while preview is available in folder '/F_CA_2' on project 'P_CA_2' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/F_CA_2' project 'P_CA_2'
Then I 'should' see Annotate button on file info page
When I click on Annotation button on file info page
And I play the file on the opened Annotations tool
And I created an annotation with notes 'Make changes to the format' and 'save' it
And I edited annotation with notes 'New changes look great!!' and 'save' it
Then I 'should' see the annotation with notes 'New changes look great!!'
And I should close the annotations window after the checks

Scenario: Add a comment to the annotation added by the owner and project user and check activity published
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role         | Agency        |   Access                               |
| U_CA_3       | agency.admin | DefaultAgency | dashboard,folders,library,annotations  |
| U_CA_4       | agency.admin  | DefaultAgency | dashboard,folders,library,annotations  |
And I logged in with details of 'U_CA_3'
And created 'P_CA_3' project
And created '/F_CA_3' folder for project 'P_CA_3'
And fill Share popup by users 'U_CA_4' in project 'P_CA_3' folders '/F_CA_3' with role 'project.user' expired '20.12.2022' and 'should' access to subfolders
And uploaded '/files/Fish1-Ad.mov' file into '/F_CA_3' folder for 'P_CA_3' project
And waited while preview is available in folder '/F_CA_3' on project 'P_CA_3' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/F_CA_3' project 'P_CA_3'
Then I 'should' see Annotate button on file info page
When I click on Annotation button on file info page
And I play the file on the opened Annotations tool
And I created an annotation with notes 'Make changes to the format' and 'save' it
And I added a comment to an annotation as 'Changes looks good' and 'save' it
Then I 'should' see annotation with comment 'Changes looks good' from user 'U_CA_3'
And I should close the annotations window after the checks
And I 'should' see on Activity tab for file '/files/Fish1-Ad.mov' in folder '/F_CA_3' project 'P_CA_3' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage                                                   |
| U_CA_3 | EMPTY | created      | has annotated file with a comment: Changes looks good             |
When I go to project 'P_CA_3' overview page
Then I 'should' see following activities in 'Recent Activity' section on opened Project Overview page:
| UserName     | Message                                                       | Value         |
| U_CA_3       | has annotated file with a comment: Changes looks good         | /Fish1-Ad.mov |
When go to project 'P_CA_3' teams page
Then I 'should' see activity for user 'U_CA_3' on project team page with message 'has annotated file with a comment: Changes looks good' and value '/Fish1-Ad.mov'
When go to Dashboard page
Then 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName | Message                                                       | Value             |
| U_CA_3   | has annotated file with a comment: Changes looks good         | /Fish1-Ad.mov     |
When I login with details of 'U_CA_4'
And go to project 'P_CA_3' folder '/' page
And I go to file 'Fish1-Ad.mov' info page in folder '/F_CA_3' project 'P_CA_3'
And I click on Annotation button on file info page
And I selected the first annotation
And I added a comment to an annotation as 'New user makes change' and 'save' it
Then I 'should' see annotation with comment 'New user makes change' from user 'U_CA_4'
And I should close the annotations window after the checks
And I 'should' see on Activity tab for file '/files/Fish1-Ad.mov' in folder '/F_CA_3' project 'P_CA_3' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage                                             |
| U_CA_4 | EMPTY | created      | has annotated file with a comment: New user makes change    |
When I set Action 'File annotated' on Activity tab on open uploaded file '/files/Fish1-Ad.mov' in folder '/F_CA_3' project 'P_CA_3'
And I click on filter button in Activity tab on open uploaded file '/files/Fish1-Ad.mov' in folder '/F_CA_3' project 'P_CA_3'
Then I 'should' see on Activity tab for file '/files/Fish1-Ad.mov' in folder '/F_CA_3' project 'P_CA_3' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage                                              |
| U_CA_4 | EMPTY | created      | has annotated file with a comment: New user makes change     |

Scenario: Delete the comment added to annotation
Meta:@gdam
     @skip
!-- Skipped until QA-1278 is resolved
Given I created users with following fields:
| Email        | Role         | Agency        |   Access                               |
| U_CA_5       | agency.admin | DefaultAgency | dashboard,folders,library,annotations  |
And I logged in with details of 'U_CA_5'
And created 'P_CA_4' project
And created '/F_CA_4' folder for project 'P_CA_4'
And uploaded '/files/Fish1-Ad.mov' file into '/F_CA_4' folder for 'P_CA_4' project
And waited while preview is available in folder '/F_CA_4' on project 'P_CA_4' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/F_CA_4' project 'P_CA_4'
Then I 'should' see Annotate button on file info page
When I click on Annotation button on file info page
And I play the file on the opened Annotations tool
And I created an annotation with notes 'Make changes to the format' and 'save' it
And I added a comment to an annotation as 'Changes looks good' and 'save' it
Then I 'should' see annotation with comment 'Changes looks good' from user 'U_CA_5'
When I deleted comment from annotation
Then I 'should not' see annotation with comment 'Changes looks good' from user 'U_CA_5'
And I should close the annotations window after the checks

Scenario: Delete an annotation added by user
Meta:@gdam
     @skip
!-- Skipped until QA-1278 is resolved
Given I created users with following fields:
| Email        | Role         | Agency        |   Access                               |
| U_CA_6       | agency.admin | DefaultAgency | dashboard,folders,library,annotations  |
And I logged in with details of 'U_CA_6'
And created 'P_CA_5' project
And created '/F_CA_5' folder for project 'P_CA_5'
And uploaded '/files/Fish1-Ad.mov' file into '/F_CA_5' folder for 'P_CA_5' project
And waited while preview is available in folder '/F_CA_5' on project 'P_CA_5' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/F_CA_5' project 'P_CA_5'
Then I 'should' see Annotate button on file info page
When I click on Annotation button on file info page
And I play the file on the opened Annotations tool
And I created an annotation with notes 'Make changes to the format' and 'save' it
Then I 'should' see the annotation with notes 'Make changes to the format'
When I deleted the annotation
Then I 'should not' see the annotation with notes 'Make changes to the format'
And I should close the annotations window after the checks

Scenario: Compare annotations between 2 versions of the file
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role         | Agency        |   Access                               |
| U_CA_7       | agency.admin | DefaultAgency | dashboard,folders,library,annotations  |
And I logged in with details of 'U_CA_7'
And created 'P_CA_6' project
And created '/F_CA_6' folder for project 'P_CA_6'
And uploaded '/files/Fish1-Ad.mov' file into '/F_CA_6' folder for 'P_CA_6' project
And waited while preview is available in folder '/F_CA_6' on project 'P_CA_6' files page
And uploaded new file version '/files/Fish Ad.mov' for file 'Fish1-Ad.mov' into '/F_CA_6' folder for 'P_CA_6' project
And waited while preview is available in folder '/F_CA_6' on project 'P_CA_6' files page
When I go to file 'Fish1-Ad.mov' info page in folder '/F_CA_6' project 'P_CA_6'
Then I 'should' see Annotate button on file info page
When I click on Annotation button on file info page
And I play the file on the opened Annotations tool
Then I 'should' see version 'V 2' displayed on Annotations page
And I 'should' see link Compare on Annotations page
When I opened compare view on Annotations page
Then I 'should' exit the compare view on Annotations page
When I play the file on the opened Annotations tool
And I created an annotation with notes 'Make changes to the format' and 'save' it
Then I 'should' see the annotation with notes 'Make changes to the format'
And I 'should' see link Compare on Annotations page
When I play the file on the opened Annotations tool
And I closed compare view on Annotations page
Then I 'should' exit the compare view on Annotations page
And I should close the annotations window after the checks