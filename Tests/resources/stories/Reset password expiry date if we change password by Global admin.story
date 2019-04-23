!--NGN-10405
Feature:          Reset password expiry date if we change password by Global admin
Narrative:
In order to
As a              AgencyAdmin
I want to         check resetting password expiry date if we change password by Global admin

Scenario: Check that after change password user could log in and Create project with folder and upload file
Meta:@projects
     @gdam
Given I created the agency 'RPEDIWCPGA_A1' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| RPEDIWCPGA_E1 | agency.admin | RPEDIWCPGA_A1 |
And I logged in with details of 'GlobalAdmin'
When I go to the global admin passwords page
And I change password for user 'RPEDIWCPGA_E1' with password 'abcdefghA1' and repeat password 'abcdefghA1'
And login such as user 'RPEDIWCPGA_E1' and with updated password 'abcdefghA1'
And I create 'RPEDIWCPGA_P2' project
And create '/folder1' folder for project 'RPEDIWCPGA_P2'
And upload '/files/Fish1-Ad.mov' file into '/folder1' folder for 'RPEDIWCPGA_P2' project
And wait while transcoding is finished in folder '/folder1' on project 'RPEDIWCPGA_P2' files page
Then I should see following count '1' of total files in project folder


Scenario: Check that after change expired password by global admin, user could create project with folder and upload file
Meta:@projects
     @gdam
Given I created the agency 'RPEDIWCPGA_A1' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| RPEDIWCPGA_E2 | agency.admin | RPEDIWCPGA_A1 |
And I logged in with details of 'RPEDIWCPGA_E2'
And I setted expired password for current user '33' before today
And I logged in with details of 'GlobalAdmin'
When I go to the global admin passwords page
And I change password for user 'RPEDIWCPGA_E2' with password 'abcdefghA1' and repeat password 'abcdefghA1'
And wait for '10' seconds
And login such as user 'RPEDIWCPGA_E2' and with updated password 'abcdefghA1'
And I create 'RPEDIWCPGA_P3' project
And create '/folder1' folder for project 'RPEDIWCPGA_P3'
And upload '/files/Fish1-Ad.mov' file into '/folder1' folder for 'RPEDIWCPGA_P3' project
And wait while transcoding is finished in folder '/folder1' on project 'RPEDIWCPGA_P3' files page
Then I should see following count '1' of total files in project folder



Scenario: Check that entered password should be same with entered repeat password
Meta:@globaladmin
     @gdam
Given I created the agency 'RPEDIWCPGA_A1' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| RPEDIWCPGA_E4 | agency.admin | RPEDIWCPGA_A1 |
And I logged in with details of 'GlobalAdmin'
When I go to the global admin passwords page
And I change password for user 'RPEDIWCPGA_E4' with password 'abcdefghhhABCDE123' and repeat password 'abcdefghhhABCDE124'
Then I should see warning message '"Password" and "Repeat password" should be same' on global admin passwords page


Scenario: Check that new password could be the same as entered in first time
Meta:@projects
     @gdam
Given I created the agency 'RPEDIWCPGA_A1' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |
| RPEDIWCPGA_E5 | agency.admin | RPEDIWCPGA_A1 |
And I logged in with details of 'GlobalAdmin'
When I go to the global admin passwords page
And I change password for user 'RPEDIWCPGA_E5' with password 'abcdefghhhABCDE123' and repeat password 'abcdefghhhABCDE123'
And refresh the page
And change password for user 'RPEDIWCPGA_E5' with password 'abcdefghA1' and repeat password 'abcdefghA1'
And login with details of 'RPEDIWCPGA_E5'
Then I 'should' be on the Dashboard page


Scenario: Check that after add user email,will be load password strength from user BU (check different password strenght with different BU)
Meta:@projects
     @gdam
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email       | Role         | Agency   |
| <UserEmail> | agency.admin | <Agency> |
And I logged in with details of 'GlobalAdmin'
And on agency '<Agency>' security page
And added password strength: with min. password length: '<PasswordLength>', min. number of uppercase A-Z: '<NumOfUppercase>', min. number of numbers 0-9: '<NumOfNumbers>', password expiration in days '30'
When I go to the global admin passwords page
And I change password for user '<UserEmail>' with password '<Password>' and repeat password '<Password>'
And login such as user '<UserEmail>' and with updated password '<Password>'
Then I 'should' be on the Dashboard page

Examples:
| Agency         | UserEmail      | PasswordLength | NumOfUppercase | NumOfNumbers | Password |
| RPEDIWCPGA6_A1 | RPEDIWCPGA6_E1 | 5              | 1              | 3            | Ab123    |
| RPEDIWCPGA6_A2 | RPEDIWCPGA6_E2 | 4              | 1              | 2            | Ab12     |
| RPEDIWCPGA6_A2 | RPEDIWCPGA6_E2 | 3              | 1              | 2            | A12      |


Scenario: Check that after change expired password by global admin, user could create collection and upload asset
Meta:@gdam
@library
Given I created the agency 'RPEDIWCPGA_A1' with default attributes
And created users with following fields:
| Email         | Role         | Agency        |Access|
| RPEDIWCPGA_E3 | agency.admin | RPEDIWCPGA_A1 |streamlined_library|
And I logged in with details of 'RPEDIWCPGA_E3'
And I setted expired password for current user '33' before today
And I logged in with details of 'GlobalAdmin'
When I go to the global admin passwords page
And I change password for user 'RPEDIWCPGA_E3' with password 'abcdefghhhABCDE123' and repeat password 'abcdefghhhABCDE123'
And login such as user 'RPEDIWCPGA_E3' and with updated password 'abcdefghhhABCDE123'
And upload following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
And I select asset 'Fish Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'RPEDIWCPGA_C3' from collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish Ad.mov' in the collection 'RPEDIWCPGA_C3'NEWLIB

