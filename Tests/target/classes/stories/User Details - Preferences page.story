!--NGN-210 NGN-1133
Feature:          User Details - Preferences page
Narrative:
In order to
As a              AgencyAdmin
I want to         Check User Details page from account settings

Scenario: check that on User details page appears all options
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email           | Telephone   | Role         | Access          |
| UserFN    | UserLN   | agencytestadmin | 80501554825 | agency.admin | library,folders |
And I logged in with details of 'agencytestadmin'
And I am on user 'agencytestadmin' details page
Then I should see on user details page fields with following values:
| element   | value              |
| FirstName | UserFN             |
| LastName  | UserLN             |
| Email     | agencytestadmin    |
| Telephone | 80501554825        |
| Role      | Business Unit Admin|
| Folders   | should             |
| Ordering  | should not         |
| Library   | should             |

Scenario: check that User details changed successfully
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email            | Telephone   | Access          | Role         |
| AdminFN   | AdminLN  | agencytest2admin | 80501554825 | folders,library | agency.admin |
And I am on user 'agencytest2admin' details page
When I change fields on page user details on following values:
| FirstName      | LastName       | Telephone   | Access  | Role        |
| AdminFNChanged | AdminLNChanged | +3805555555 | library | agency.user |
And wait for '3' seconds
And go to user 'agencytest2admin' details page
Then I should see on user details page fields with following values:
| element   | value              |
| FirstName | AdminFNChanged     |
| LastName  | AdminLNChanged     |
| Email     | agencytest2admin   |
| Telephone | +3805555555        |
| Folders   | should not         |
| Ordering  | should not         |
| Library   | should             |
| Role      | Business Unit User |



Scenario: Check mandatory fields
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email            | Telephone   | Access          | Role         |
| AdminFN   | AdminLN  | agencytest3admin | 80501554825 | folders,library | agency.admin |
And I logged in with details of 'agencytest3admin'
And I am on user 'agencytest3admin' details page
When I type in field 'UserRoleList' on user details page empty value ''
And I click save on users details page
Then I 'should' see red inputs on page


Scenario: Unsuccessfully picture load
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email            | Telephone   | Access          | Role         |
| AdminFN   | AdminLN  | agencytest5admin | 80501554825 | folders,library | agency.admin |
And I logged in with details of 'agencytest5admin'
And I am on user 'agencytest5admin' details page
When I upload logo 'TXT' on user details page
Then I should see  error message '.*.txt has invalid extension. Only jpg, jpeg, png are allowed.'
And I should see logo 'EMPTY' on user details page and on a header


Scenario: check that picture successfully change
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email            | Telephone   | Access          | Role         |
| AdminFN   | AdminLN  | agencytest5admin | 80501554825 | folders,library | agency.admin |
And I logged in with details of 'agencytest5admin'
And I am on user 'agencytest5admin' details page
When I upload logo 'PNG' on user details page
And I click save on users details page
And I go to user 'agencytest5admin' details page
Then I should see logo 'PNG' on user details page and on a header


Scenario: check user access if user has access to only library after edit
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email            | Telephone   | Access | Role         |
| AdminFN   | AdminLN  | agencytest6admin | 80501554825 |        | agency.admin |
And I logged in with details of 'agencytest6admin'
And I am on user 'agencytest6admin' details page
Then I should see on user details page fields with following values:
| element  | value        |
| Folders  | <FoldersCB>  |
| Ordering | <OrderingCB> |
| Streamlined Library  | <LibraryCB>  |
When I change fields on page user details on following values:
| FirstName | LastName | Telephone   | Access      | Role         |
| AdminFN   | AdminLN  | 80501554825 | streamlined_library | agency.admin |
And refresh the page
Then I '<FoldersMenu>' see element 'Projects' on page 'Dashboard'
Then I '<OrderingMenu>' see element 'Ordering' on page 'Dashboard'
Then I '<LibraryMenu>' see element 'Library' on page 'Dashboard'

Examples:
| FoldersCB      | OrderingCB | LibraryCB  |  FoldersMenu | OrderingMenu | LibraryMenu |
| should not     | should not | should not |  should not  | should not   | should      |

Scenario: check user access if user has access to only folders after edit
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email            | Telephone   | Access | Role         |
| AdminFN   | AdminLN  | agencytest7admin | 80501554825 |        | agency.admin |
And I logged in with details of 'agencytest7admin'
And I am on user 'agencytest7admin' details page
Then I should see on user details page fields with following values:
| element  | value        |
| Folders  | <FoldersCB>  |
| Ordering | <OrderingCB> |
| Streamlined Library  | <LibraryCB>  |
When I change fields on page user details on following values:
| FirstName | LastName | Telephone   | Access      | Role         |
| AdminFN   | AdminLN  | 80501554825 | folders | agency.admin |
And refresh the page
Then I '<FoldersMenu>' see element 'Projects' on page 'Dashboard'
Then I '<OrderingMenu>' see element 'Ordering' on page 'Dashboard'
Then I '<LibraryMenu>' see element 'Library' on page 'Dashboard'

Examples:
| FoldersCB      | OrderingCB | LibraryCB  |  FoldersMenu | OrderingMenu | LibraryMenu |
| should not     | should not | should not |  should  | should not   | should not      |

Scenario: check user access if user has access to only folders and library after edit
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email            | Telephone   | Access | Role         |
| AdminFN   | AdminLN  | agencytest8admin | 80501554825 |        | agency.admin |
And I logged in with details of 'agencytest8admin'
And I am on user 'agencytest8admin' details page
Then I should see on user details page fields with following values:
| element  | value        |
| Folders  | <FoldersCB>  |
| Ordering | <OrderingCB> |
| Streamlined Library  | <LibraryCB>  |
When I change fields on page user details on following values:
| FirstName | LastName | Telephone   | Access      | Role         |
| AdminFN   | AdminLN  | 80501554825 | folders,streamlined_library | agency.admin |
And refresh the page
Then I '<FoldersMenu>' see element 'Projects' on page 'Dashboard'
Then I '<OrderingMenu>' see element 'Ordering' on page 'Dashboard'
Then I '<LibraryMenu>' see element 'Library' on page 'Dashboard'

Examples:
| FoldersCB      | OrderingCB | LibraryCB  |  FoldersMenu | OrderingMenu | LibraryMenu |
| should not     | should not | should not |  should  | should not   | should      |

Scenario: check user access if user has access to only folders,ordering and library after edit
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email            | Telephone   | Access | Role         |
| AdminFN   | AdminLN  | agencytest9admin | 80501554825 |        | agency.admin |
And I logged in with details of 'agencytest9admin'
And I am on user 'agencytest9admin' details page
Then I should see on user details page fields with following values:
| element  | value        |
| Folders  | <FoldersCB>  |
| Ordering | <OrderingCB> |
| Streamlined Library  | <LibraryCB>  |
When I change fields on page user details on following values:
| FirstName | LastName | Telephone   | Access      | Role         |
| AdminFN   | AdminLN  | 80501554825 | folders,streamlined_library,ordering | agency.admin |
And refresh the page
Then I '<FoldersMenu>' see element 'Projects' on page 'Dashboard'
Then I '<OrderingMenu>' see element 'Ordering' on page 'Dashboard'
Then I '<LibraryMenu>' see element 'Library' on page 'Dashboard'

Examples:
| FoldersCB      | OrderingCB | LibraryCB  |  FoldersMenu | OrderingMenu | LibraryMenu |
| should not     | should not | should not |  should  | should   | should      |
