!--ORD-841
!--ORD-1486
Feature: Add to order Action against files in Folders and Library
Narrative:
In order to:
As a AgencyAdmin
I want to check send to delivery files in Folders and assets in Library

Scenario: Check that only video of the same type can be sent to delivery
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVATOFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVATOFU1 | agency.admin | OTVATOFA1    |
And logged in with details of 'OTVATOFU1'
And created 'OTVATOFP1' project
And created '/OTVATOFF1' folder for project 'OTVATOFP1'
And uploaded into project 'OTVATOFP1' following files:
| FileName                   | Path       |
| /files/13DV-CAPITAL-10.mpg | /OTVATOFF1 |
| /files/GWGTest2.pdf        | /OTVATOFF1 |
| /files/audio02.mp3         | /OTVATOFF1 |
| /files/Fish1-Ad.mov        | /OTVATOFF1 |
| /files/Fish2-Ad.mov        | /OTVATOFF1 |
And waited while transcoding is finished in folder '/OTVATOFF1' on project 'OTVATOFP1' files page
And I am on file 'Fish2-Ad.mov' info page in folder '/OTVATOFF1' project 'OTVATOFP1'
When I 'save' file info by next information:
| FieldName | FieldValue  |
| Screen    | Music Promo |
And go to project 'OTVATOFP1' folder '/OTVATOFF1' page
And select file '<Files>' on project files page
Then I '<ShouldState>' see active following options 'Send to Delivery' in More drop down menu on project files page

Examples:
| Files                            | ShouldState |
| 13DV-CAPITAL-10.mpg,Fish1-Ad.mov | should      |
| 13DV-CAPITAL-10.mpg,GWGTest2.pdf | should not  |
| audio02.mp3                      | should not  |
| 13DV-CAPITAL-10.mpg,Fish2-Ad.mov | should not  |
| Fish2-Ad.mov                     | should      |

Scenario: Check availablity send to delivery according to user's permissions
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVATOFA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVATOFA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |Access|
| <Email> | <Role> | OTVATOFA1    |streamlined_library,ordering|
And logged in with details of '<Email>'
And uploaded following assetsNEWLIB:
| Name                       |
| /files/13DV-CAPITAL-10.mpg |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
And I am on the Library page for collection 'My Assets'NEWLIB
When I select asset '13DV-CAPITAL-10.mpg' in the 'My Assets'  library pageNEWLIB
Then I '<shouldSeeState>' see 'Send to Delivery' option in menu for collection 'My Assets'NEWLIB
Examples:
| Email       | Role        | Permissions                                                                                                           | shouldSeeState |
| OTVATOFU2_1 | OTVATOFR2_1 | asset.create,asset_filter_collection.create                                                                           | should not     |
| OTVATOFU2_2 | OTVATOFR2_2 | asset.create,asset_filter_collection.create,tv_order.create                                                           |  should        |
| OTVATOFU2_3 | OTVATOFR2_3 | asset.create,asset_filter_collection.create,tv_order.write                                                            |  should not    |
| OTVATOFU2_4 | OTVATOFR2_4 | asset.create,asset_filter_collection.create,tv_order.create,tv_order.write                                            |  should        |
| OTVATOFU2_5 | OTVATOFR2_5 | asset.create,asset_filter_collection.create,tv_order.create,tv_order.write,tv_order_music.create,tv_order_music.write |  should        |
| OTVATOFU2_6 | OTVATOFR2_6 | asset.create,asset_filter_collection.create,tv_order.create,tv_order.write,tv_order_music.create,tv_order_music.write |  should        |

Scenario: Check availablity send to delivery according to user's permissions(for music promo)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVATOFA1_1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVATOFA1_1'
And created users with following fields:
| Email   | Role   | AgencyUnique |Access|
| <Email> | <Role> | OTVATOFA1_1    |streamlined_library,ordering|
And logged in with details of '<Email>'
And I am on the library page for collection 'My Assets'NEWLIB
And uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish2-Ad.mov        |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish2-Ad.mov'NEWLIB
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | Screen      |
| Fish2-Ad.mov | Music Promo |
And I go to the library page for collection 'My Assets'NEWLIB
And I refresh the page
And I select asset 'Fish2-Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I '<shouldSeeState>' see 'Send to Delivery' option in menu for collection 'My Assets'NEWLIB

Examples:
| Email        | Role         | Permissions                                                                                                           | shouldSeeState |
| OTVATOFU2_7  | OTVATOFR2_7  | asset.create,asset_filter_collection.create                                                                           |  should not     |
| OTVATOFU2_9  | OTVATOFR2_9  | asset.create,asset_filter_collection.create,tv_order_music.create                                                     |  should     |

Scenario: Check availablity send to delivery according to user's permissions(tv + music promo)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVATOFA1 | DefaultA4User |
And created 'OTVATOFR2_12' role with 'asset.create,asset.write,asset_filter_collection.create,tv_order.create,tv_order.write,tv_order_music.create,tv_order_music.write' permissions in 'global' group for advertiser 'OTVATOFA1'
And created users with following fields:
| Email        | Role         | AgencyUnique |Access|
| OTVATOFU2_12 | OTVATOFR2_12 | OTVATOFA1    |streamlined_library,ordering|
And logged in with details of 'OTVATOFU2_12'
And uploaded following assetsNEWLIB:
| Name                       |
| /files/13DV-CAPITAL-10.mpg |
| /files/Fish2-Ad.mov        |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I am on the library page for collection 'My Assets'NEWLIB
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | Screen      |
| Fish2-Ad.mov | Music Promo |
And I refresh the page
And I select asset '13DV-CAPITAL-10.mpg,Fish2-Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I 'should not' see 'Send to Delivery' option in menu for collection 'My Assets'NEWLIB



Scenario: Check availablity send to delivery according to application access
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVATOFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique | Access          |
| OTVATOFU3 | agency.admin | OTVATOFA1    | folders,streamlined_library |
And logged in with details of 'OTVATOFU3'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I am on the library page for collection 'My Assets'NEWLIB
When I select asset 'Fish1-Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I 'should not' see 'Send to Delivery' option in menu for collection 'My Assets'NEWLIB

Scenario: Check that files can be sent to delivery
!--ORD-3202
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVATOFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVATOFU1 | agency.admin | OTVATOFA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVATOFA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVATOFAR4 | OTVATOFBR4 | OTVATOFSB4 | OTVATOFPR4 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVATOFA1'
And logged in with details of 'OTVATOFU1'
And created 'OTVATOFP1' project
And created '/OTVATOFF1' folder for project 'OTVATOFP1'
And uploaded into project 'OTVATOFP1' following files:
| FileName                   | Path       |
| /files/Fish1-Ad.mov        | /OTVATOFF1 |
| /files/13DV-CAPITAL-10.mpg | /OTVATOFF1 |
And waited while transcoding is finished in folder '/OTVATOFF1' on project 'OTVATOFP1' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVATOFF1' project 'OTVATOFP1'
When I 'save' file info by next information:
| FieldName    | FieldValue       |
| Advertiser   | OTVATOFAR4       |
| Brand        | OTVATOFBR4       |
| Sub Brand    | OTVATOFSB4       |
| Product      | OTVATOFPR4       |
| Clock number | FileCN4          |
| Title        | Fish1-Ad-new.mov |
| Air Date     | 12/14/2022       |
And go to project 'OTVATOFP1' folder '/OTVATOFF1' page
And send following files '13DV-CAPITAL-10.mpg,Fish1-Ad-new.mov' on project 'OTVATOFP1' folder '/OTVATOFF1' page to Delivery
Then I should see for active order item on cover flow following data:
| Title            | Counter |
| Fish1-Ad-new.mov | 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product    | Title            |
|                        | OTVATOFAR4 |          | FileCN4      | 6s 33ms  | 12/14/2022     |        | OTVATOFPR4 | Fish1-Ad-new.mov |

Scenario: Check that assets can be sent to delivery
!--ORD-3202
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @orderingcrossbrowser
Given I created the following agency:
| Name      | A4User        |
| OTVATOFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVATOFU1 | agency.admin | OTVATOFA1    |streamlined_library,ordering|
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVATOFA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVATOFAR4 | OTVATOFBR4 | OTVATOFSB4 | OTVATOFPR4 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVATOFA1'
And on the global 'common custom' metadata page for agency 'OTVATOFA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVATOFU1'
And uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/13DV-CAPITAL-10.mpg |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to the library page for collection 'My Assets'NEWLIB
And 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName                   | FieldValue                           |
| Advertiser                  | OTVATOFAR4                           |
| Brand                       | OTVATOFBR4                           |
| Sub Brand                   | OTVATOFSB4                           |
| Product                     | OTVATOFPR4                           |
| Clock number                | AssetCN5                             |
| Screen                      | Music Promo                          |
| Air Date                    | 10/14/22                             |
| Title                       | Fish1-Ad-new.mov                     |
And I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name                | Screen     |
| 13DV-CAPITAL-10.mpg |Music Promo |
And I refresh the page
And I select asset '13DV-CAPITAL-10.mpg,Fish1-Ad-new.mov' in the 'My Assets'  library pageNEWLIB
And I click Send To Delivery from library 'My Assets' collectionNEWLIB
Then I should see for active order item on cover flow following data:
| Title            | Counter |
| Fish1-Ad-new.mov | 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Record Company | Artist | ISRC Code | Release Date | Format | Label      | Title            |
|                        | OTVATOFAR4     |        | AssetCN5  | 10/13/2022   |        | OTVATOFPR4 | Fish1-Ad-new.mov |


