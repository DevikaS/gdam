!--NGN-11232
Feature:          Permissions inheritance for cases with limited permissions
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that permissions inheritance for cases with limited permissions


Scenario: Check that user who has no Download Master permission from Library can't download original from project folder
Meta:@gdam
@projects
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created users with following fields:
| Email          | Role         | Agency       |Access|
| E_PIFCWLP_01_1 | agency.admin | A_PIFCWLP_01 |streamlined_library,folders|
| E_PIFCWLP_01_2 | agency.user  | A_PIFCWLP_01 |streamlined_library,folders|
And logged in with details of 'E_PIFCWLP_01_1'
And created 'R_PIFCWLP_01' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And I created 'С_PIFCWLP_01' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_01'
And added users 'E_PIFCWLP_01_2' to category 'С_PIFCWLP_01' with role 'R_PIFCWLP_01' by users details
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_01_2'
And I create 'P_PIFCWLP_01' project
And create '/F_PIFCWLP_01' folder for project 'P_PIFCWLP_01'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_01' to project 'P_PIFCWLP_01' folder '/F_PIFCWLP_01'NEWLIB
Then 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_01' project 'P_PIFCWLP_01'

Scenario: Check that user who has no Download Master permission from Library can't download original from WR folder
Meta:@gdam
@projects
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created 'GR_PIFCWLP_02' role in 'global' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                     |
| adkit.create                   |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| dictionary.read                |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
And created users with following fields:
| Email          | Role          | Agency       |Access|
| E_PIFCWLP_02_1 | agency.admin  | A_PIFCWLP_01 |streamlined_library,folders,adkits|
| E_PIFCWLP_02_2 | GR_PIFCWLP_02 | A_PIFCWLP_01 |streamlined_library,folders,adkits|
And logged in with details of 'E_PIFCWLP_02_1'
And created 'R_PIFCWLP_02' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And I created 'С_PIFCWLP_02' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_02'
And added users 'E_PIFCWLP_02_2' to category 'С_PIFCWLP_02' with role 'R_PIFCWLP_02' by users details
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_02_2'
And create new work request with following fields:
| FieldName  | FieldValue    |
| Name       | WR_PIFCWLP_05 |
| Media type | Other         |
| Start date | 07.09.2012    |
| End date   | 07.09.2020    |
And create '/F_PIFCWLP_02' folder for project 'WR_PIFCWLP_05'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_02' to project 'WR_PIFCWLP_05' folder '/F_PIFCWLP_02'NEWLIB
Then 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_02' project 'WR_PIFCWLP_05'


Scenario: Check that user who has no Download Master permission from Library can't download original from template folder
Meta:@gdam
@projects
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created users with following fields:
| Email          | Role         | Agency       |Access|
| E_PIFCWLP_03_1 | agency.admin | A_PIFCWLP_01 |streamlined_library,folders,adkits|
| E_PIFCWLP_03_2 | agency.user  | A_PIFCWLP_01 |streamlined_library,folders,adkits|
And logged in with details of 'E_PIFCWLP_03_1'
And created 'R_PIFCWLP_03' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And I created 'С_PIFCWLP_03' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_03'
And added users 'E_PIFCWLP_03_2' to category 'С_PIFCWLP_03' with role 'R_PIFCWLP_03' by users details
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_03_2'
And I create 'T_PIFCWLP_03' template
And create '/F_PIFCWLP_03' folder for template 'T_PIFCWLP_03'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_03' to template 'T_PIFCWLP_03' folder '/F_PIFCWLP_03'NEWLIB
And go to file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_03' template 'T_PIFCWLP_03'
Then I 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_03' template 'T_PIFCWLP_03'

Scenario: Check that user who has no Download Master permission from Librarym can't download original from project folder if file was copied to another folder
Meta:@gdam
@projects
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created users with following fields:
| Email          | Role         | Agency       |Access|
| E_PIFCWLP_05_1 | agency.admin | A_PIFCWLP_01 |streamlined_library,folders|
| E_PIFCWLP_05_2 | agency.user  | A_PIFCWLP_01 |streamlined_library,folders|
And logged in with details of 'E_PIFCWLP_05_1'
And created 'R_PIFCWLP_05' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And I created 'С_PIFCWLP_05' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_05'
And added users 'E_PIFCWLP_05_2' to category 'С_PIFCWLP_05' with role 'R_PIFCWLP_05' by users details
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_05_2'
And create 'P_PIFCWLP_05' project
And create '/F_PIFCWLP_05_1' folder for project 'P_PIFCWLP_05'
And create '/F_PIFCWLP_05_2' folder for project 'P_PIFCWLP_05'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_05' to project 'P_PIFCWLP_05' folder '/F_PIFCWLP_05_1'NEWLIB
When I copy the 'Fish1-Ad.mov' file into '/F_PIFCWLP_05_2' folder from folder '/F_PIFCWLP_05_1' for 'P_PIFCWLP_05' project
And go to file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_05_2' project 'P_PIFCWLP_05'
Then 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_05_2' project 'P_PIFCWLP_05'


Scenario: Check that user who has no Download Master permission from Library can't download original from project folder if file was copied to another project
Meta:@gdam
@projects
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created users with following fields:
| Email          | Role         | Agency       |Access|
| E_PIFCWLP_06_1 | agency.admin | A_PIFCWLP_01 |streamlined_library,folders|
| E_PIFCWLP_06_2 | agency.user  | A_PIFCWLP_01 |streamlined_library,folders|
And logged in with details of 'E_PIFCWLP_06_1'
And created 'R_PIFCWLP_06' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And I created 'С_PIFCWLP_06' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_06'
And added users 'E_PIFCWLP_06_2' to category 'С_PIFCWLP_06' with role 'R_PIFCWLP_06' by users details
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_06_2'
And create 'P_PIFCWLP_06_1' project
And create '/F_PIFCWLP_06_1' folder for project 'P_PIFCWLP_06_1'
And create 'P_PIFCWLP_06_2' project
And create '/F_PIFCWLP_06_2' folder for project 'P_PIFCWLP_06_2'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_06' to project 'P_PIFCWLP_06_1' folder '/F_PIFCWLP_06_1'NEWLIB
And go to project 'P_PIFCWLP_06_1' folder '/F_PIFCWLP_06_1' page
And refresh the page
And click on Want to copy files to another project link on move/copy file 'Fish1-Ad.mov' popup
And enter 'P_PIFCWLP_06_2' in search field on move/copy file popup
And select folder '/F_PIFCWLP_06_2' on move/copy file popup
And I click copy button on move/copy files popup
And wait for '5' seconds
Then 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_06_2' project 'P_PIFCWLP_06_2'


Scenario: Check that user who has no Download Master permission from Library can't download original from project folder if file was copied to another template
Meta: @skip
      @gdam
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created users with following fields:
| Email          | Role         | Agency       |
| E_PIFCWLP_10_1 | agency.admin | A_PIFCWLP_01 |
| E_PIFCWLP_10_2 | agency.user  | A_PIFCWLP_01 |
And logged in with details of 'E_PIFCWLP_10_1'
And created 'R_PIFCWLP_10' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And I created 'С_PIFCWLP_10' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_10'
And added users 'E_PIFCWLP_10_2' to category 'С_PIFCWLP_10' with role 'R_PIFCWLP_10' by users details
And uploaded asset '/files/Fish1-Ad.mov' into library
And waited while transcoding is finished in collection 'Everything'
And set following file info for next assets from collection 'Everything':
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_10_2'
And create 'T_PIFCWLP_10_1' template
And create '/F_PIFCWLP_10_1' folder for template 'T_PIFCWLP_10_1'
And create 'T_PIFCWLP_10_2' template
And create '/F_PIFCWLP_10_2' folder for template 'T_PIFCWLP_10_2'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_10' to template 'T_PIFCWLP_10_1' folder '/F_PIFCWLP_10_1'
And go to template 'T_PIFCWLP_10_1' folder '/F_PIFCWLP_10_1' page
And refresh the page
And click on Want to copy files to another project link on move/copy file 'Fish1-Ad.mov' popup
And enter 'T_PIFCWLP_10_2' in search field on move/copy file popup
And select folder '/F_PIFCWLP_10_2' on move/copy file popup
And I click copy button on move/copy files popup
Then 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_10_2' project 'T_PIFCWLP_10'


Scenario: Check that user who has no Download Master permission from Library can't download original from project folder if file was moved to another project
Meta:@gdam
@projects
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created users with following fields:
| Email          | Role         | Agency       |Access|
| E_PIFCWLP_07_1 | agency.admin | A_PIFCWLP_01 |streamlined_library,folders|
| E_PIFCWLP_07_2 | agency.user  | A_PIFCWLP_01 |streamlined_library,folders|
And logged in with details of 'E_PIFCWLP_07_1'
And created 'R_PIFCWLP_07' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And I created 'С_PIFCWLP_07' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_07'
And added users 'E_PIFCWLP_07_2' to category 'С_PIFCWLP_07' with role 'R_PIFCWLP_07' by users details
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And set following file info for next assets from collection 'Everything'NEWLIB:
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_07_2'
And I create 'P_PIFCWLP_07_1' project
And create '/F_PIFCWLP_07_1' folder for project 'P_PIFCWLP_07_1'
And I create 'P_PIFCWLP_07_2' project
And create '/F_PIFCWLP_07_2' folder for project 'P_PIFCWLP_07_2'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_07' to project 'P_PIFCWLP_07_1' folder '/F_PIFCWLP_07_1'NEWLIB
When I go to project 'P_PIFCWLP_07_1' folder '/F_PIFCWLP_07_1' page
And refresh the page
And click on Want to move files to another project link on move/copy file 'Fish1-Ad.mov' popup
And enter 'P_PIFCWLP_07_2' in search field on move/copy file popup
And select folder '/F_PIFCWLP_07_2' on move/copy file popup
And wait for '2' seconds
And I click move button on move/copy files popup
And wait for '3' seconds
And go to file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_07_2' project 'P_PIFCWLP_07_2'
Then 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_07_2' project 'P_PIFCWLP_07_2'



Scenario: Check that user who has no Download Master permission from Library can't download original from project folder if file was moved to another wr
Meta: @skip
      @gdam
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created 'GR_PIFCWLP_08' role in 'global' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                     |
| adkit.create                   |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| dictionary.read                |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
And created users with following fields:
| Email          | Role          | Agency       |
| E_PIFCWLP_08_1 | agency.admin  | A_PIFCWLP_01 |
| E_PIFCWLP_08_2 | GR_PIFCWLP_08 | A_PIFCWLP_01 |
And logged in with details of 'E_PIFCWLP_08_1'
And created 'R_PIFCWLP_08' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
And I created 'С_PIFCWLP_08' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_08'
And added users 'E_PIFCWLP_08_2' to category 'С_PIFCWLP_08' with role 'R_PIFCWLP_08' by users details
And uploaded asset '/files/Fish1-Ad.mov' into library
And waited while transcoding is finished in collection 'Everything'
And set following file info for next assets from collection 'Everything':
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_08_2'
And create new work request with following fields:
| FieldName  | FieldValue      |
| Name       | WR_PIFCWLP_08_1 |
| Media type | Other           |
| Start Date | 07.09.2012      |
| End Date   | 07.09.2020      |
And create '/F_PIFCWLP_08_1' folder for project 'WR_PIFCWLP_08_1'
And create new work request with following fields:
| FieldName  | FieldValue      |
| Name       | WR_PIFCWLP_08_2 |
| Media type | Other           |
| Start Date | 07.09.2012      |
| End Date   | 07.09.2020      |
And create '/F_PIFCWLP_08_2' folder for project 'WR_PIFCWLP_08_2'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_08' to project 'WR_PIFCWLP_08_1' folder '/F_PIFCWLP_08_1'
And go to project 'WR_PIFCWLP_08_1' folder '/F_PIFCWLP_08_1' page
And refresh the page
And click on Want to move files to another project link on move/copy file 'Fish1-Ad.mov' popup
And enter 'WR_PIFCWLP_08_2' in search field on move/copy file popup
And select folder '/F_PIFCWLP_08_2' on move/copy file popup
And I click move button on move/copy files popup
Then 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_08_2' project 'WR_PIFCWLP_08_2'


Scenario: Check that user who has no Download Master permission from Library can't download original from project folder if file was moved to another template
Meta: @skip
      @gdam
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created users with following fields:
| Email          | Role         | Agency       |
| E_PIFCWLP_09_1 | agency.admin | A_PIFCWLP_01 |
| E_PIFCWLP_09_2 | agency.user  | A_PIFCWLP_01 |
And logged in with details of 'E_PIFCWLP_09_1'
And created 'R_PIFCWLP_09' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
And I created 'С_PIFCWLP_09' category
And selected media type 'video' and sub media type 'generic master' for category 'С_PIFCWLP_09'
And added users 'E_PIFCWLP_09_2' to category 'С_PIFCWLP_09' with role 'R_PIFCWLP_09' by users details
And uploaded asset '/files/Fish1-Ad.mov' into library
And waited while transcoding is finished in collection 'Everything'
And set following file info for next assets from collection 'Everything':
| Name          | SubType        |
| Fish1-Ad.mov  | Generic Master |
When I login with details of 'E_PIFCWLP_09_2'
And I create 'T_PIFCWLP_09_1' template
And create '/F_PIFCWLP_09_1' folder for template 'T_PIFCWLP_09_1'
And I create 'T_PIFCWLP_09_2' template
And create '/F_PIFCWLP_09_2' folder for template 'T_PIFCWLP_09_2'
And add following asset 'Fish1-Ad.mov' of collection 'С_PIFCWLP_09' to template 'T_PIFCWLP_09_1' folder '/F_PIFCWLP_09_1'
And go to template 'T_PIFCWLP_09_1' folder '/F_PIFCWLP_09_1' page
And refresh the page
And click on Want to move files to another project link on move/copy file 'Fish1-Ad.mov' popup
And enter 'T_PIFCWLP_09_2' in search field on move/copy file popup
And select folder '/F_PIFCWLP_09_2' on move/copy file popup
And I click move button on move/copy files popup
Then 'should not' see Download Original button on file 'Fish1-Ad.mov' info page in folder '/F_PIFCWLP_09_2' project 'T_PIFCWLP_09_2'




Scenario: Check that user who has no Download Master permission from Library can't download original from collection create on fly
Meta:@gdam
@projects
Given I created the agency 'A_PIFCWLP_01' with default attributes
And created users with following fields:
| Email          | Role         | Agency       |Access|
| E_PIFCWLP_10_1 | agency.admin | A_PIFCWLP_01 |streamlined_library,library|
| E_PIFCWLP_10_2 | agency.user  | A_PIFCWLP_01 |streamlined_library,library|
And created 'R_PIFCWLP_01' role in 'library' group for advertiser 'A_PIFCWLP_01' with following permissions:
| Permission                 |
| asset.add_to_presentation  |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
| asset_filter_category.read |
| presentation.create        |
| presentation.delete        |
| presentation.read          |
| presentation.write         |
| proxy.download             |
And logged in with details of 'E_PIFCWLP_10_1'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_PIFCWLP_01':
| Advertiser      |
| ADV_PIFCWLP_S01 |
And uploaded asset '/files/Fish1-Ad.mov' into libraryNEWLIB
And I created 'С_PIFCWLP_03' category
And added users 'E_PIFCWLP_10_2' to category 'С_PIFCWLP_03' with role 'R_PIFCWLP_01' by users details
When I login with details of 'E_PIFCWLP_10_2'
And go to  Library page for collection 'С_PIFCWLP_03'NEWLIB
And I switch 'on' media type filter 'video' for collection 'My Assets' on the page LibraryNEWLIB
And I select asset 'Fish1-Ad.mov' from filter pageNEWLIB
And I click on 'sub' option on the collection filter page
And I type collection name 'test_col_10' and save on opened 'sub' collection popup from filter pageNEWLIB
And go to asset 'Fish1-Ad.mov' info page in Library for collection 'test_col_10'NEWLIB
Then I 'should not' see 'download original' button on opened asset info pageNEWLIB