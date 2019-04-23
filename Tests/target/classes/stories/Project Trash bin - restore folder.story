!--NGN-1372
Feature:          Restore Trash bin - restore folder
Narrative:
In order to
As a              AgencyAdmin
I want to         Check restoring folder from trash bin (Project)

Scenario: Check that folder can be restored
Meta:@gdam
@projects
Given I created 'PTBRFP1' project
And created '/PTBRFF1' folder for project 'PTBRFP1'
And uploaded into project 'PTBRFP1' following files:
| FileName          | Path     |
| /files/_file1.gif | /PTBRFF1 |
And I am on project 'PTBRFP1' folder '/PTBRFF1' page
When I delete folder '/PTBRFF1' in project 'PTBRFP1'
And go to project 'PTBRFP1' folder '/PTBRFF1' trash bin page
And restore folder '/PTBRFF1' from project 'PTBRFP1' trash bin page to folder '/PTBRFP1'
And refresh the page
Then I 'should' see '/PTBRFF1' folder in 'PTBRFP1' project
And 'should' see file '_file1.gif' on project 'PTBRFP1' folder '/PTBRFF1' files page
And 'should not' see '/PTBRFP1/PTBRFF1' folder on 'PTBRFP1' project trash bin page
And 'should not' see the following files in the project 'PTBRFP1' trash bin:
| FileName   |
| _file1.gif |


Scenario: Check that folder is restored with subfolders
Meta:@gdam
@projects
Given I created 'PTBRFP2' project
And created in 'PTBRFP2' project next folders:
| folder            |
| /PTBRFF2_1        |
| /PTBRFF2_1/Sub2_1 |
| /PTBRFF2_1/Sub2_2 |
| /PTBRFF2_1/Sub2_3 |
And I am on project 'PTBRFP2' folder '/PTBRFF2_1' page
When I delete folder '/PTBRFF2_1' in project 'PTBRFP2'
And go to project 'PTBRFP2' folder '/PTBRFF2_1' trash bin page
And restore folder '/PTBRFF2_1' from project 'PTBRFP2' trash bin page to folder '/PTBRFP2'
And go to project 'PTBRFP2' overview page
And refresh the page
Then I should see following folders in 'PTBRFP2' project:
| folder            |
| /PTBRFF2_1        |
| /PTBRFF2_1/Sub2_1 |
| /PTBRFF2_1/Sub2_2 |
| /PTBRFF2_1/Sub2_3 |
And 'should not' see following folders on project 'PTBRFP2' trash bin page :
| folder                    |
| /PTBRFP2/PTBRFF2_1        |
| /PTBRFP2/PTBRFF2_1/Sub2_1 |
| /PTBRFP2/PTBRFF2_1/Sub2_2 |
| /PTBRFP2/PTBRFF2_1/Sub2_3 |


Scenario: Check restoring folder to another folder (not parent)
Meta:@gdam
@projects
Given I created 'PTBRFP5' project
And created in 'PTBRFP5' project next folders:
| folder            |
| /PTBRFF5_1        |
| /PTBRFF5_1/Sub5_1 |
| /PTBRFF5_2        |
And uploaded into project 'PTBRFP5' following files:
| FileName          | Path              |
| /files/_file1.gif | /PTBRFF5_1/Sub5_1 |
And I am on project 'PTBRFP5' folder '/PTBRFF5_1/Sub5_1' page
When I delete folder '/PTBRFF5_1/Sub5_1' in project 'PTBRFP5'
And go to project 'PTBRFP5' folder '/Sub5_1' trash bin page
And restore folder '/Sub5_1' from project 'PTBRFP5' trash bin page to folder '/PTBRFP5/PTBRFF5_2'
And refresh the page
Then I 'should' see '/PTBRFF5_2/Sub5_1' folder in 'PTBRFP5' project
And 'should' see file '_file1.gif' on project 'PTBRFP5' folder '/PTBRFF5_2/Sub5_1' files page
And 'should not' see '/PTBRFF5_1/Sub5_1' folder in 'PTBRFP5' project
And 'should not' see '/PTBRFF5/Sub5_1' folder on 'PTBRFP5' project trash bin page
And 'should not' see the following files in the project 'PTBRFP5' trash bin:
| FileName   |
| _file1.gif |


Scenario: Check that folder can not be restored to deleted folder
Meta:@gdam
@projects
Given I created 'PTBRFP6' project
And created in 'PTBRFP6' project next folders:
| folder     |
| /PTBRFF6_1 |
| /PTBRFF6_2 |
And I am on project 'PTBRFP6' folder '/PTBRFF6_1' page
When I delete folder '/PTBRFF6_1' in project 'PTBRFP6'
And go to project 'PTBRFP6' folder '/PTBRFF6_1' trash bin page
Then I 'should not' see folder '/PTBRFF6_1' on Select folder restore popup when restore folder '/PTBRFF6_1' from project 'PTBRFP6' trash bin page