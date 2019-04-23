
Feature: Library - Batch update assets
Narrative:
In order to
As a              AgencyAdmin
I want to         batch update different types of assets

Scenario: Batch update of Assets of same type
Meta:@gdam
@bug
@library
!--UIR-1069
Given I created the agency 'A_VAIPDMT_S01' with default attributes
And I created users with following fields:
| Email         | Agency        |Access|
| U_VAIPDMT_S01 | A_VAIPDMT_S01 |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_VAIPDMT_S01':
| Advertiser | Brand      | Sub Brand  | Product   |
| BUASTAD1   | BUASTBR1   | BUASTSB1   | BUASTTAFSP1|
And I logged in with details of 'U_VAIPDMT_S01'
And I am on Library pageNEWLIB
And uploaded asset 'files/13DV-CAPITAL-10.mpg' into libraryNEWLIB
And uploaded asset 'files/canon-journey.mov' into libraryNEWLIB
And uploaded asset 'files/Fish1-Ad.wmv' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
And I am on the Library page for collection 'Everything'NEWLIB
And selected all assets for collection 'Everything' on the library pageNEWLIB
And 'save' metadata for 'Fish1-Ad.wmv'  on 'Everything'  edit Asset Metadata page:
| FieldName                   | FieldValue                       |SectionName      |
| Advertiser                  | BUASTAD1                         |common |
| Brand                       | BUASTBR1                         |common |
| Sub Brand                   | BUASTSB1                         |common |
| Category                    | Food                             |Video|
| Sub Category                | Meat and Fish                    |Video|
| Country                     | Austria                          |Video|
| Screen                      | Spot                             |Video|
When I go to asset '13DV-CAPITAL-10.mpg' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | BUASTAD1                         |
| Brand                       | BUASTBR1                         |
| Sub Brand                   | BUASTSB1                         |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Country                     | Austria                          |
| Screen                      | Spot                             |
When I go to asset 'canon-journey.mov' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | BUASTAD1                         |
| Brand                       | BUASTBR1                         |
| Sub Brand                   | BUASTSB1                         |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Country                     | Austria                          |
| Screen                      | Spot                             |
When I go to asset 'Fish1-Ad.wmv' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | BUASTAD1                         |
| Brand                       | BUASTBR1                         |
| Sub Brand                   | BUASTSB1                         |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Country                     | Austria                          |
| Screen                      | Spot                             |


Scenario: Batch update of Assets of different types
Meta:@gdam
@bug
@library
!--UIR-1069
Given I created the agency 'A_VAIPDMT_S02' with default attributes
And I created users with following fields:
| Email         | Agency        |Access|
| U_VAIPDMT_S02 | A_VAIPDMT_S02 |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_VAIPDMT_S02':
| Advertiser | Brand      | Sub Brand  | Product   |
| BUADTAD1   | BUADTBR1   | BUADTSB1   | BUADTTAFSP1|
And I logged in with details of 'U_VAIPDMT_S02'
And I am on Library pageNEWLIB
And uploaded asset 'files/13DV-CAPITAL-10.mpg' into libraryNEWLIB
And uploaded asset 'files/128_shortname.jpg' into libraryNEWLIB
And uploaded asset 'files/_file1.gif' into libraryNEWLIB
And waited while preview is available in collection 'Everything'NEWLIB
And selected all assets for collection 'Everything' on the library pageNEWLIB
And 'save' metadata for '_file1.gif'  on 'Everything'  edit Asset Metadata page:
| FieldName                   | FieldValue                       |SectionName      |
| Advertiser                  | BUADTAD1                         |common |
| Brand                       | BUADTBR1                         |common |
| Sub Brand                   | BUADTSB1                         |common |
| Category                    | Food                             |Video|
| Sub Category                | Meat and Fish                    |Video|
| Country                     | Austria                          |Video|
| Screen                      | Spot                             |Video|
When I go to asset '13DV-CAPITAL-10.mpg' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | BUADTAD1                         |
| Brand                       | BUADTBR1                         |
| Sub Brand                   | BUADTSB1                         |
| Category                    | Food                             |
| Sub Category                | Meat and Fish                    |
| Country                     | Austria                          |
| Screen                      | Spot                             |
When I go to asset '128_shortname.jpg' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | BUADTAD1                         |
| Brand                       | BUADTBR1                         |
| Sub Brand                   | BUADTSB1                         |
When I go to asset '_file1.gif' info page in Library for collection 'Everything'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | BUADTAD1                         |
| Brand                       | BUADTBR1                         |
| Sub Brand                   | BUADTSB1                         |
