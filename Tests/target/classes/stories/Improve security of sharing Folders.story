!--NGN-3165
Feature:          Improve security of sharing Folders
Narrative:
In order to
As a              AgencyAdmin
I want to         Check improved security of sharing folders


Scenario: Check that user received email about sharing folder
Meta:@gdam
     @gdamemails
Given I created 'ISSFR1' role in 'project' group for advertiser 'DefaultAgency'
And created 'ISSFP1' project
And created '/ISSFF1' folder for project 'ISSFP1'
And fill Share popup by users 'ISSFU1' in project 'ISSFP1' for following folders '/ISSFF1' with role 'ISSFR1' expired '12.12.2022' and 'should' access to subfolders
Then I 'should' see email notification for 'Folder sharing for Easy User' with field to 'ISSFU1' and subject 'You have been invited' contains following attributes:
| Agency        | ProjectName | UserName    |
| DefaultAgency | ISSFP1      | AgencyAdmin |

Scenario: Check that user is redirected to Registration page after using link from email about sharing folder
Meta:@gdam
     @gdamemails
Given I created 'ISSFR2' role in 'project' group for advertiser 'DefaultAgency'
And created 'ISSFP2' project
And created '/ISSFF2' folder for project 'ISSFP2'
And fill Share popup by users 'ISSFU2' in project 'ISSFP2' for following folders '/ISSFF2' with role 'ISSFR2' expired '12.12.2022' and 'should' access to subfolders
When I logout from account
And open link from email when user 'ISSFU2' received email with next subject 'You have been invited'
Then I 'should' be on the registration page


Scenario: share folder to user not existed in A5 but added as new contact in Address Book and receiving email about sharing folder
Meta:@gdam
     @gdamemails
Given I created 'ISSFR8' role in 'project' group for advertiser 'DefaultAgency'
And created 'ISSFP8' project
And created '/ISSFF8' folder for project 'ISSFP8'
And added user 'ISSFU8' into address book
And fill Share popup by users 'ISSFU8' in project 'ISSFP8' for following folders '/ISSFF8' with role 'ISSFR8' expired '12.12.2022' and 'should' access to subfolders
Then I 'should' see email notification for 'Folder sharing for Easy User' with field to 'ISSFU8' and subject 'You have been Invited' contains following attributes:
| Agency        | ProjectName | UserName    |
| DefaultAgency | ISSFP8      | AgencyAdmin |



Scenario: add user not existed in A5 to folder of project via Team tab and receiving email about sharing folder
Meta:@gdam
     @gdamemails
Given I created 'ISSFR12' role in 'project' group for advertiser 'DefaultAgency'
And created 'ISSFP12' project
And created '/ISSFF12' folder for project 'ISSFP12'
And added users 'ISSFU12' to project 'ISSFP12' team folders '/ISSFF12' with role 'ISSFR12' expired '12.12.2022' and 'should' access to subfolders
Then I 'should' see email notification for 'Folder sharing for Easy User' with field to 'ISSFU12' and subject 'You have been invited' contains following attributes:
| Agency        | ProjectName | UserName    |
| DefaultAgency | ISSFP12     | AgencyAdmin |


Scenario: Check that user registered using invite letter received by him in case to share folder for him has guest.user role
Meta:@gdam
     @gdamemails
Given I created 'ISSFR15' role in 'project' group for advertiser 'DefaultAgency'
And created 'ISSFP15' project
And created '/ISSFF15' folder for project 'ISSFP15'
And fill Share popup by users 'ISSFU15' in project 'ISSFP15' for following folders '/ISSFF15' with role 'ISSFR15' expired '12.12.2022' and 'should' access to subfolders
When I logout from account
And open link from email when user 'ISSFU15' received email with next subject 'You have been invited'
And accept new user with first name 'ISSFUFN15' and last name 'ISSFULN15'
And login with details of 'AgencyAdmin'
And go to user 'ISSFU15' details page
Then I should see on user details page fields with following values:
| element   | value      |
| FirstName | ISSFUFN15  |
| LastName  | ISSFULN15  |
| Email     | ISSFU15    |
| Role      | guest.user |


Scenario: Check that user registered using invite letter received by him in case to add him as project owner has guest.user role
!--NGN-3570
Meta:@gdam
     @gdamemails
Given I created 'ISSFP16' project
And created '/ISSFF16' folder for project 'ISSFP16'
And I am on project 'ISSFP16' settings page
When I edit the following fields for 'ISSFP16' project:
| Name    | Administrators |
| ISSFP16 | ISSFU16        |
And click on element 'SaveButton'
Then Project 'ISSFP16' should include the following fields:
| Name    | Administrators      |
| ISSFP16 | AgencyAdmin,ISSFU16 |
When I logout from account
And open link from email when user 'ISSFU16' received email with next subject 'You are invited to Adbank'
And accept new user with first name 'ISSFUFN16' and last name 'ISSFULN16'
And login with details of 'AgencyAdmin'
And go to user 'ISSFU16' details page
Then I should see on user details page fields with following values:
| element   | value      |
| FirstName | ISSFUFN16  |
| LastName  | ISSFULN16  |
| Email     | ISSFU16    |
| Role      | guest.user |