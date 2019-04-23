!--NGN-12947
Feature:          Check when new files or assets are uploaded, dictionary and radio button fields should be prepopulated with default values
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that when new files or assets are uploaded, dictionary and radio button fields should be prepopulated with default values


Scenario: Check applying metadata default values (radio button and Dropdown menu)
Meta:@gdam
@library
Given I created the agency 'A_WNFOAAUDARBFSBPWDV_S01' with default attributes
And created users with following fields:
| Email                    | Role         | Agency                   |Access|
| U_WNFOAAUDARBFSBPWDV_S01 | agency.admin | A_WNFOAAUDARBFSBPWDV_S01 |streamlined_library|
When I login with details of 'U_WNFOAAUDARBFSBPWDV_S01'
And go to the global 'common custom' metadata page for agency 'A_WNFOAAUDARBFSBPWDV_S01'
And create 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   |
| RadioButtons1 |
And create 'Dropdown' custom metadata field with following information on opened metadata page:
| Description |
| Dropdown1   |
And click 'RadioButtons1' button in 'Common Metadata' section on opened metadata page
And add following dropdown choices on opened Settings and Customization page:
| Choice       | Default |
| radioChoice1 |         |
| radioChoice2 | true    |
| radioChoice3 |         |
And click 'Dropdown1' button in 'Common Metadata' section on opened metadata page
And add following dropdown choices on opened Settings and Customization page:
| Choice      | Default |
| dropChoice1 |         |
| dropChoice2 | true    |
| dropChoice3 |         |
And upload file '/files/_file1.gif' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And go to asset '_file1.gif' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName     | FieldValue   |
| RadioButtons1 | radioChoice2 |
| Dropdown1     | dropChoice2  |

