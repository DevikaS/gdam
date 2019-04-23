!-- NGN-12914
Feature:          User can filter Activity on Dashboard by Type and User
Narrative:
In order to
As a              AgencyAdmin
I want to         User can filter Activity on Dashboard by Type and User


Scenario: Check that user can filter activity on Dashboard by type
Meta:@gdam
@projects
Given I created the agency 'A_UCFAODBTAU_S01' with default attributes
And created users with following fields:
| Email            | Agency           |
| E_UCFAODBTAU_S01 | A_UCFAODBTAU_S01 |
When I login with details of 'E_UCFAODBTAU_S01'
And create 'Project1' project
And create '/folder1' folder for project 'Project1'
And create 'Project2' project
And create '/folder2' folder for project 'Project2'
And upload '/files/atCalcImage.jpg' file into '/folder1' folder for 'Project1' project
And wait while transcoding is finished in folder '/folder1' on project 'Project1' files page
And upload '/files/big_background.jpg' file into '/folder2' folder for 'Project2' project
And wait while transcoding is finished in folder '/folder2' on project 'Project2' files page
And go to Dashboard page
And choose next filter on Recent Activity: action 'Created project' and user '' on Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName         | Message         | Value    |
| E_UCFAODBTAU_S01 | created project | Project1 |
| E_UCFAODBTAU_S01 | created project | Project2 |
When I choose next filter on Recent Activity: action 'Files uploaded' and user '' on Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName         | Message                             | Value                                        |
| E_UCFAODBTAU_S01 | uploaded 1 files big_background.jpg | Project2/Project2/folder2/big_background.jpg |
| E_UCFAODBTAU_S01 | uploaded 1 files atCalcImage.jpg    | Project1/Project1/folder1/atCalcImage.jpg    |


Scenario: Check that user can filter activity on Dashboard by user
Meta:@gdam
@projects
Given I created the agency 'A_UCFAODBTAU_S01' with default attributes
And created users with following fields:
| Email              | Agency           | Role         |
| E_UCFAODBTAU_S02_1 | A_UCFAODBTAU_S01 | agency.admin |
| E_UCFAODBTAU_S02_2 | A_UCFAODBTAU_S01 | agency.user  |
When I login with details of 'E_UCFAODBTAU_S02_2'
And create 'Project2_1' project
And create '/folder2_1' folder for project 'Project2_1'
And create 'Project2_2' project
And create '/folder2_2' folder for project 'Project2_2'
And upload '/files/file2_.gif' file into '/folder2_1' folder for 'Project2_1' project
And wait while transcoding is finished in folder '/folder2_1' on project 'Project2_1' files page
And upload '/files/image10.jpg' file into '/folder2_2' folder for 'Project2_2' project
And wait while transcoding is finished in folder '/folder2_2' on project 'Project2_2' files page
And login with details of 'E_UCFAODBTAU_S02_1'
And create 'Project2_3' project
And add users 'E_UCFAODBTAU_S02_2' to Address book
And go to Dashboard page
And choose next filter on Recent Activity: action 'All' and user 'E_UCFAODBTAU_S02_2' on Dashboard page
And click link 'Filter' on Dashboard Page
Then I 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName           | Message                       | Value                                       |
| E_UCFAODBTAU_S02_2 | created project               | Project2_1                                  |
| E_UCFAODBTAU_S02_2 | created project               | Project2_2                                  |
| E_UCFAODBTAU_S02_2 | uploaded 1 files file2_.gif   | Project2_1/Project2_1/folder2_1/file2_.gif  |
| E_UCFAODBTAU_S02_2 | uploaded 1 files image10.jpg  | Project2_2/Project2_2/folder2_2/image10.jpg |
Then I 'should not' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName           | Message         | Value      |
| E_UCFAODBTAU_S02_1 | created project | Project2_3 |


Scenario: Check that user can remove filters (click UNfilter)
Meta:@gdam
@projects
Given I created the agency 'A_UCFAODBTAU_S01' with default attributes
And created users with following fields:
| Email            | Agency           | Role         |
| E_UCFAODBTAU_S03 | A_UCFAODBTAU_S01 | agency.admin |
When I login with details of 'E_UCFAODBTAU_S03'
And create 'Project3' project
And create '/folder3_1' folder for project 'Project3'
And upload '/files/image9.jpg' file into '/folder3_1' folder for 'Project3' project
And wait while transcoding is finished in folder '/folder3_1' on project 'Project3' files page
And go to Dashboard page
And choose next filter on Recent Activity: action 'Created project' and user 'E_UCFAODBTAU_S03' on Dashboard page
And click link 'Filter' on Dashboard Page
Then I 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName         | Message         | Value    |
| E_UCFAODBTAU_S03 | created project | Project3 |
And 'should not' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName         | Message                     | Value                                  |
| E_UCFAODBTAU_S03 | uploaded 1 files image9.jpg | Project3/Project3/folder3_1/image9.jpg |
When I choose next filter on Recent Activity: action ' All ' and user '' on Dashboard page
And click link 'Filter' on Dashboard Page
Then I 'should' see following activities in 'Recent Activity' section on opened Dashboard page:
| UserName         | Message         | Value                                              |
| E_UCFAODBTAU_S03 | created project | Project3                                           |
| E_UCFAODBTAU_S03 | uploaded 1 files image9.jpg | Project3/Project3/folder3_1/image9.jpg |