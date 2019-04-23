!--NGN-2562 NGN-10998
Feature:          Library sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Check library sorting


Scenario: Check availability sorting options
Meta:@gdam
@library
Given I am on Library page for collection 'Everything'NEWLIB
Then I 'should' see following elements on collection 'Everything'NEWLIB:
| element               |
| Last uploaded         |
| First uploaded        |
| Last modified         |
| First modified        |
| Title (A to Z)        |
| Title (Z to A)        |

Scenario: Check that assets are sorted as newest first by default
Meta:@gdam
@library
Given I created the agency 'A_LS_S02' with default attributes
And I created users with following fields:
| Email    | Agency   | Access             |
| U_LS_S02 | A_LS_S02 |streamlined_library   |
When I login with details of 'U_LS_S02'
And upload file '/images/admin.logo.jpg' into libraryNEWLIB
And upload file '/images/big.logo.png' into libraryNEWLIB
And upload file '/images/branding_logo.png' into libraryNEWLIB
And upload file '/images/empty.logo.png' into libraryNEWLIB
And upload file '/images/empty.project.logo.png' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
Then I should see on the library page for 'My Assets' that element sort by has value 'Last uploaded'NEWLIB
And I should see assets sorting by 'Last uploaded' for collection 'My Assets' on the library pageNEWLIB

Scenario: Check that asset list is saved after navigating between asset details tab and library
!--NGN-10595
Meta:@gdam
@library
Given I created the agency 'A_LS_S06' with default attributes
And I created users with following fields:
| Email    | Agency   | Access           |
| U_LS_S06 | A_LS_S06 | streamlined_library   |
And logged in with details of 'U_LS_S06'
And uploaded file '/images/admin.logo.jpg' into libraryNEWLIB
And uploaded file '/images/big.logo.png' into libraryNEWLIB
And uploaded file '/images/branding_logo.png' into libraryNEWLIB
And uploaded file '/images/empty.logo.png' into libraryNEWLIB
And uploaded file '/images/empty.project.logo.png' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I select Sort By '<SortingOptions>' in collection 'My Assets'NEWLIB
And I go to asset 'admin.logo.jpg' page in Library for collection 'My Assets'NEWLIB
And click back to library Button on asset info page
When I switch to 'list' view from the collection 'My Assets' pageNEWLIB
And I wait for '3' seconds
Then I should see on the library page for 'My Assets' that element sort by has value '<SortingOptions>'NEWLIB
And should see assets sorting by '<Result>' for collection 'My Assets' on the library pageNEWLIB

Examples:
| Result                |SortingOptions|
| Last Uploaded Last         |First uploaded|


Scenario: Check that sorting of assets work based upon Last modified and First modified
Meta:@gdam
@library
Given I created the agency 'A_LS_S07' with default attributes
And I created users with following fields:
| Email    | Agency   | Access               |
| U_LS_S07 | A_LS_S07 |streamlined_library   |
When I login with details of 'U_LS_S07'
And upload file '/images/admin.logo.jpg' into libraryNEWLIB
And upload file '/images/big.logo.png' into libraryNEWLIB
And upload file '/images/branding_logo.png' into libraryNEWLIB
And upload file '/images/empty.logo.png' into libraryNEWLIB
And upload file '/images/empty.project.logo.png' into libraryNEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
And I refresh the page
And I set following file info for next assets from collection 'Everything'NEWLIB:
| Name             |  Campaign  |
| admin.logo.jpg   |  TAFAC1    |
| big.logo.png     |  TAFAC2    |
| branding_logo.png |  TAFAC3    |
| empty.logo.png    |  TAFAC4    |
| empty.project.logo.png   |  TAFAC5    |
And I refresh the page
And select Sort By '<SortingOptions>' in collection 'Everything'NEWLIB
And I switch to 'list' view from the collection 'Everything' pageNEWLIB
Then I should see assets sorting by '<Result>' for collection 'Everything' on the library pageNEWLIB

Examples:
| Result                      |SortingOptions|
| Last Uploaded First          |Last modified|
| Last Uploaded Last          |First modified|


Scenario: Check that sorting of assets work based upon Title
Meta:@gdam
@library
Given I created the agency 'A_LS_S08' with default attributes
And I created users with following fields:
| Email    | Agency   | Access               |
| U_LS_S08 | A_LS_S08 |streamlined_library   |
When I login with details of 'U_LS_S08'
And upload file '/images/admin.logo.jpg' into libraryNEWLIB
And upload file '/images/big.logo.png' into libraryNEWLIB
And upload file '/images/branding_logo.png' into libraryNEWLIB
And upload file '/images/empty.logo.png' into libraryNEWLIB
And upload file '/images/empty.project.logo.png' into libraryNEWLIB
And wait while transcoding is finished in collection 'Everything'NEWLIB
And I refresh the page
And select Sort By '<Result>' in collection 'Everything'NEWLIB
And I switch to 'list' view from the collection 'Everything' pageNEWLIB
Then I should see assets sorting by '<Result>' for collection 'Everything' on the library pageNEWLIB

Examples:
| Result           |
| Title (A to Z) |
| Title (Z to A) |

Scenario: Check that sorting saved when user relogin to system
Meta:@gdam
@skip
!--invalid for both old and new lib
Given I created the agency 'A_LS_S03' with default attributes
And I created users with following fields:
| Email    | Agency   |
| U_LS_S03 | A_LS_S03 |
When I login with details of 'U_LS_S03'
And upload file '/images/admin.logo.jpg' into library
And upload file '/images/big.logo.png' into library
And upload file '/images/branding_logo.png' into library
And upload file '/images/empty.logo.png' into library
And upload file '/images/empty.project.logo.png' into library
And wait while transcoding is finished in collection 'My Assets'
And select Sort By '<Result>' on the current library page
And logout from account
And login with details of 'U_LS_S03'
Then I should see assets sorting by '<Result>' for collection 'Everything' on the library page

Examples:
| Result                       |
| Most recently uploaded First |
| Most recently uploaded Last  |

Scenario: Check that asset list is saved after navigating between collections
Meta:@gdam
@skip
!--invalid for both old and new lib
Given I created the agency 'A_LS_S04' with default attributes
And I created users with following fields:
| Email    | Agency   |
| U_LS_S04 | A_LS_S04 |
And logged in with details of 'U_LS_S04'
And uploaded file '/images/admin.logo.jpg' into library
And uploaded file '/images/big.logo.png' into library
And uploaded file '/images/branding_logo.png' into library
And uploaded file '/images/empty.logo.png' into library
And uploaded file '/images/empty.project.logo.png' into library
And waited while transcoding is finished in collection 'My Assets'
When I select Sort By '<Result>' on the current library page
And go to the Library page for collection 'Everything'
And go to the Library page for collection 'My Assets'
Then I should see on the library page that element sort by has value '<Result>'
And should see assets sorting by '<Result>' for collection 'My Assets' on the library page

Examples:
| Result         |
| Title (A to Z) |
| Title (Z to A) |

Scenario: Check that asset list is saved after navigating between projects and library
Meta:@gdam
@skip
!--invalid for both old and new lib
Given I created the agency 'A_LS_S05' with default attributes
And I created users with following fields:
| Email    | Agency   |
| U_LS_S05 | A_LS_S05 |
And logged in with details of 'U_LS_S05'
And created 'P_LS_S05' project
And uploaded file '/images/admin.logo.jpg' into library
And uploaded file '/images/big.logo.png' into library
And uploaded file '/images/branding_logo.png' into library
And uploaded file '/images/empty.logo.png' into library
And uploaded file '/images/empty.project.logo.png' into library
And waited while transcoding is finished in collection 'My Assets'
When I select Sort By '<Result>' on the current library page
And go to project 'P_LS_S05' overview page
And go to the Library page for collection 'My Assets'
Then I should see on the library page that element sort by has value '<Result>'
And should see assets sorting by '<Result>' for collection 'My Assets' on the library page

Examples:
| Result            |
| Size (Descending) |
| Size (Ascending)  |


