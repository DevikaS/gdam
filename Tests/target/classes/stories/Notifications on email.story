!--NGN-2102
Feature:          Notifications on email
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Notifications to email

Scenario: check email notifications for easyshared users
Meta:@gdam
     @gdamemails
Given I created 'NER1' role in 'project' group for advertiser 'DefaultAgency'
And created 'NEP1' project
And created in 'NEP1' project next folders:
| folder  |
| /NEF1_1 |
| /NEF1_2 |
And fill Share popup by users 'NEU1_1' in project 'NEP1' for following folders '/NEF1_1' with role 'NER1' expired '12.12.2022' and 'should' access to subfolders
Then I 'should' see email notification for 'Folder sharing for Easy User' with field to 'NEU1_1' and subject 'You have been invited' contains following attributes:
| Agency        | ProjectName | UserName    |
| DefaultAgency | NEP1        | AgencyAdmin |


Scenario: check that user can open shared project folder from email
Meta:@gdam
     @gdamemails
Given I created 'NER2' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Role        | Password     |
| <UserEmail> | agency.user | TestPassw0rd |
And created 'NEP2' project
And created in 'NEP2' project next folders:
| folder  |
| /NEF2_1 |
| /NEF2_2 |
And fill Share popup by users '<UserEmail>' in project 'NEP2' for following folders '<Folders>' with role 'NER2' expired '12.12.2022' and 'should' access to subfolders
When I logout from account
And open link from email when user '<UserEmail>' received email with next subject 'Folders have been shared with'
And I fill fields login '<UserEmail>' and password 'TestPassw0rd' and then login to system
Then I 'should' see '<Folders>' folder in 'NEP2' project

Examples:
| UserEmail | Folders |
| NEU2_1    | /NEF2_1 |


Scenario: check received email with notification link to shared folder from project
Meta:@gdam
     @gdamemails
     !--user Notification removed as part of TD-628 and FAB-791
Given I created 'PR_NOE_S03' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email     | Role        |
| U_NOE_S03 | agency.user |
And created 'P_NOE_S03' project
And created '/F_NOE_S03' folder for project 'P_NOE_S03'
And added users 'U_NOE_S03' to project 'P_NOE_S03' team folders '/F_NOE_S03' with role 'PR_NOE_S03' expired '12.12.2022' and 'should' access to subfolders
Then I 'should' see email notification for 'Folder sharing for' with field to 'U_NOE_S03' and subject 'Folders have been shared with' contains following attributes:
| UserName    | Agency        | ProjectName | FolderName |
| AgencyAdmin | DefaultAgency | P_NOE_S03   | F_NOE_S03  |



Scenario: check notification links from received email for not easyshare users
Meta:@gdam
     @gdamemails
Given I created 'PR_NOE_S04' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email     | Role        |
| U_NOE_S04 | agency.user |
And created 'P_NOE_S04' project
And created '/F_NOE_S04' folder for project 'P_NOE_S04'
And fill Share popup by users 'U_NOE_S04' in project 'P_NOE_S04' for following folders 'F_NOE_S04' with role 'PR_NOE_S04' expired '12.12.2022' and 'should' access to subfolders
Then I 'should' see email notification for 'Folder sharing for' with field to 'U_NOE_S04' and subject 'Folders have been shared with' contains following attributes:
| UserName    | Agency        | ProjectName | FolderName |
| AgencyAdmin | DefaultAgency | P_NOE_S04   | F_NOE_S04  |