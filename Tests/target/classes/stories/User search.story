!--NGN-1044 NGN-4318
Feature:          User search
Narrative:
In order to
As a              AgencyAdmin
I want to         Check User Search

Scenario: Check user search
Meta: @gdam
@projects
!--NGN-4428
Given I created users with following fields:
| FirstName     | LastName           | Email          | Telephone |
| valeriy3      | salmin3            | emailvaleriy3  | +33333    |
| valeriy4      | salmin4            | emailvaleriys4 | +44444    |
| Jennifer      | Lopez-Brea Högdahl | lopez          | +55555    |
| Català        | Česky              | cesky          | +66666    |
| ivan          | O'Higgins          | higgins2       | +77777    |
| igor          | Kööpenhaminassa    | asssa2         | +88888    |
| Margaret Anna | Tetcher            | tetcher2       | +99999    |
| Folkekirkens  | Nødhjælp           | Nødhjælp       | +5665444  |
And I am on Users list page
When I search user by text '<Text>'
And I sort users by field 'User' in order 'asc'
Then I 'should' see user '<UserEmail>' on users list page in according to search text '<Text>'

Examples:
| Text                     | UserEmail                                                                  |
| Margaret Anna            | tetcher2                                                                   |
| Folkekirkens Nødhjælp    | Nødhjælp                                                                   |
| sal                      | emailvaleriy3,emailvaleriys4                                               |
|                          | emailvaleriy3,emailvaleriys4,lopez,cesky,higgins2,asssa2,tetcher2,Nødhjælp |
| textforemptysearchresult |                                                                            |


Scenario: Check that 'Show all users' shows all users available before search
Meta: @gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email     |
| avaleriy1 | salmin1  | valeriys1 |
| avaleriy2 | salmin2  | valeriys2 |
| avaleriy3 | salmin3  | valeriys3 |
| avaleriy4 | salmin4  | valeriys4 |
And I am on Users list page
And I searched user by text 'blablabla'
When I click element 'ShowAllUsers' on page 'Users'
Then I 'should' see user 'valeriys1,valeriys2,valeriys3,valeriys4' on users list page in according to search text ''


Scenario: Check that search users correctly works on user's search results
Meta: @gdam
@projects
Given I created users with following fields:
| Logo | FirstName | LastName | Email      |
| JPEG | val1      | sal1     | valeriys31 |
| JPEG | val2      | sal2     | valeriys32 |
| JPEG | val22     | val22    | valeriys33 |
| JPEG | sal22     | sal22    | valeriys34 |
| JPEG | val3      | sal3     | ivanov3    |
And I am on Users list page
When I search user by text 'val2'
And I sort users by field 'User' in order 'asc'
Then I 'should' see user 'valeriys32,valeriys33' on users list page in according to search text 'val2'
And I 'should not' see user 'valeriys31,valeriys34,ivanov3' on users list page in according to search text 'val2'


Scenario: Check that user from another agency cannot be found in current agency
Meta: @gdam
@projects
Given I created users with following fields:
| FirstName  | LastName  | Email      | Agency        |
| dvaleriy1  | dsalmin1  | dvaleriys1 | AnotherAgency |
| dvaleriy2  | dsalmin2  | dvaleriys2 | DefaultAgency |
And I am on Users list page
When I search user by text 'dvaleriy'
Then I 'should' see user 'dvaleriys2' on users list page in according to search text 'dvaleriy'
And I 'should not' see user 'dvaleriys1' on users list page in according to search text 'dvaleriy'


Scenario: Check that user search correctly works with updated data
Meta: @gdam
@projects
Given I created users with following fields:
| FirstName  | LastName  | Email      |
| aevaleriy1 | aesalmin1 | valeriys41 |
And I filled following fields on user 'valeriys41' details page:
| FirstName      | LastName          | Email      |
| aevaleriy2_3_2 | aesalmin2_3_2     | valeriys41 |
And I clicked save on users details page
When I search user by text 'aevaleriy2_3_2 aesalmin2_3_2'
Then I 'should' see user 'valeriys41' on users list page in according to search text 'aevaleriy2_3_2 aesalmin2_3_2'


Scenario: Check that search result isn't reseted after selecting user
Meta: @gdam
@projects
Given I created users with following fields:
| FirstName | LastName  | Email      |
| Eric      | Cartman   | U_US_S09_1 |
| Eric      | Cartman   | U_US_S09_2 |
| Kenny     | McCormick | U_US_S09_3 |
When I search user by text 'Eric Cartman'
And select user 'U_US_S09_1' for current search result on Users Page
Then I 'should' see user 'U_US_S09_1,U_US_S09_2' on users list page in according to search text 'Eric Cartman'
And 'should not' see user 'U_US_S09_3' on users list page in according to search text 'Eric Cartman'