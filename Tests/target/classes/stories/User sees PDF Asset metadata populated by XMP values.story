!--NGN-11584
Feature:          User sees PDF File/Asset metadata populated by XMP values
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check User sees PDF File/Asset metadata populated by XMP values


Scenario: Check that User sees PDF File/Asset metadata populated by XMP values
Meta: @gdam
@library
Given I created the agency 'A_USAMPBXMPV_S01_1' with default attributes
And created users with following fields:
| Email               | Role         | Agency             |Access|
| AU_USAMPBXMPV_S01_1 | agency.admin | A_USAMPBXMPV_S01_1 |streamlined_library|
And logged in with details of 'AU_USAMPBXMPV_S01_1'
When I create xmp mapping for current agency
And upload file '/files/284769D.pdf' into libraryNEWLIB
And wait while preview is visible on library page for collection 'Everything' for assets '284769D.pdf'NEWLIB
And go to asset '284769D.pdf' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following xmp fields 'custom metadata' on opened asset info page for agency 'A_USAMPBXMPV_S01_1'NEWLIB:
| FieldName  | FieldValue  |
| Advertiser | Schawk      |
| Brand      | P&G Nordics |

