!--ORD-252
!--ORD-275
!--ORD-584
Feature: Ordering(TV) - Media Upload from Library
Narrative:
In order to:
As a AgencyAdmin
I want to check simple search within library assets

Scenario: Check that correct paging after retrieve from library
!--ORD-835
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU1 | agency.admin | OTVMUFLA1    |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
| /files/Fish3-Ad.mov  |
| /files/Fish4-Ad.mov  |
| /files/Fish5-Ad.mov  |
| /files/Fish6-Ad.mov  |
| /files/Fish7-Ad.mov  |
| /files/Fish8-Ad.mov  |
| /files/Fish9-Ad.mov  |
| /files/Fish10-Ad.mov |
| /files/Fish11-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFLCN1   |
When I open order item with following clock number 'OTVMUFLCN1'
Then I 'should' see for order item at Add media to your order form following assets over pages:
| Name          |
| Fish1-Ad.mov  |
| Fish2-Ad.mov  |
| Fish3-Ad.mov  |
| Fish4-Ad.mov  |
| Fish5-Ad.mov  |
| Fish6-Ad.mov  |
| Fish7-Ad.mov  |
| Fish8-Ad.mov  |
| Fish9-Ad.mov  |
| Fish10-Ad.mov |
| Fish11-Ad.mov |


Scenario: Check correct paging of search results after retrieve from library
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU1 | agency.admin | OTVMUFLA1    |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
| /files/Fish3-Ad.mov  |
| /files/Fish4-Ad.mov  |
| /files/Fish5-Ad.mov  |
| /files/Fish6-Ad.mov  |
| /files/Fish7-Ad.mov  |
| /files/Fish8-Ad.mov  |
| /files/Fish9-Ad.mov  |
| /files/Fish10-Ad.mov |
| /files/Fish11-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFLCN2   |
When I open order item with following clock number 'OTVMUFLCN2'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value 'Fish' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following assets over pages:
| Name          |
| Fish1-Ad.mov  |
| Fish2-Ad.mov  |
| Fish3-Ad.mov  |
| Fish4-Ad.mov  |
| Fish5-Ad.mov  |
| Fish6-Ad.mov  |
| Fish7-Ad.mov  |
| Fish8-Ad.mov  |
| Fish9-Ad.mov  |
| Fish10-Ad.mov |
| Fish11-Ad.mov |


Scenario: Check that only video assets are available in case to retrieve assets from library
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA4 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU4 | agency.admin | OTVMUFLA4    |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU4'
And uploaded following assetsNEWLIB:
| Name                       |
| /files/13DV-CAPITAL-10.mpg |
| /files/GWGTest2.pdf        |
| /files/audio02.mp3         |
| /files/logo3.jpg           |
| /files/index.html          |
| /files/BDDStandards.doc    |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFLCN4   |
When I open order item with following clock number 'OTVMUFLCN4'
Then I 'should' see for order item at Add media to your order form following assets:
| Name                |
| 13DV-CAPITAL-10.mpg |
And 'should not' see for order item at Add media to your order form following assets:
| Name             |
| GWGTest2.pdf     |
| audio02.mp3      |
| logo3.jpg        |
| index.html       |
| BDDStandards.doc |

Scenario: Check that assets are searchable by Clock Number within library
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA5 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU5_U1 | agency.admin | OTVMUFLA5    |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU5_U1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue         |
| Clock number | <clockNumberAsset> |
|Duration      |15s|
And open order item with following clock number '<ClockNumber>'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value '<SearchFilter>' for Add media to your order form on order item page
Then I '<ShouldState>' see for order item at Add media to your order form following assets:
| Name         |
| Fish1-Ad.mov |
And 'should not' see for order item at Add media to your order form following assets:
| Name         |
| Fish2-Ad.mov |

Examples:
| ClockNumber  | clockNumberAsset | SearchFilter  | ShouldState |
| OTVMUFLCN5_1 | ABook            | ABook         | should      |
| OTVMUFLCN5_2 | ABook            | abook         | should      |
| OTVMUFLCN5_3 | ABook            | Abo           | should      |
| OTVMUFLCN5_4 | f1-video.Nike    | f1-video.Nike | should      |
| OTVMUFLCN5_5 | ABook\\and/clock | ABook\and/cl  | should      |
| OTVMUFLCN5_6 | ABook            | book          | should not  |
| OTVMUFLCN5_7 | ABook            | *book         | should not  |



Scenario: Check that assets are searchable by Advertiser within library
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA5 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU5 | agency.admin | OTVMUFLA5    |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMUFLA5':
| Advertiser   |
| <Advertiser> |
And logged in with details of 'OTVMUFLU5'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue   |
| Advertiser   | <Advertiser> |
| Clock number | AssetCN6     |
| Duration     | 15s          |
And open order item with following clock number '<ClockNumber>'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value '<SearchFilter>' for Add media to your order form on order item page
Then I '<ShouldState>' see for order item at Add media to your order form following assets:
| Name         |
| Fish1-Ad.mov |
And 'should not' see for order item at Add media to your order form following assets:
| Name         |
| Fish2-Ad.mov |

Examples:
| ClockNumber  | Advertiser         | SearchFilter    | ShouldState |
| OTVMUFLCN6_1 | ABookAR6_1         | ABook           | should      |
| OTVMUFLCN6_2 | ABookAR6_2         | abook           | should      |
| OTVMUFLCN6_3 | ABookAR6_3         | Abo             | should      |
| OTVMUFLCN6_4 | ABookAR6_4 AR new  | ABookAR6_4 AR   | should      |
| OTVMUFLCN6_5 | ABookAR6_5AR/new   |  ABookAR6_5     | should      |
| OTVMUFLCN6_6 | ABookAR6_6 AR new  | AR new          | should not  |
| OTVMUFLCN6_7 | ABookAR6_7         | book            | should not  |
| OTVMUFLCN6_8 | ABookAR6_8         | *book           | should not  |


Scenario: Check that assets are searchable by Title of assets within library
!--ORD-1098, ORD-1088
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA7 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU7 | agency.admin | OTVMUFLA7    |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU7'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue |
| Title        | <Title>    |
| Clock number | AssetCN7   |
And open order item with following clock number '<ClockNumber>'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value '<SearchFilter>' for Add media to your order form on order item page
Then I '<ShouldState>' see for order item at Add media to your order form following assets:
| Name    |
| <Title> |
And 'should not' see for order item at Add media to your order form following assets:
| Name         |
| Fish2-Ad.mov |

Examples:
| ClockNumber   | Title            | SearchFilter     | ShouldState |
| OTVMUFLCN7_1  | ABook            | ABook            | should      |
| OTVMUFLCN7_2  | ABook            | abook            | should      |
| OTVMUFLCN7_3  | ABook            | Abo              | should      |
| OTVMUFLCN7_4  | f1-video.Nike    | f1-video.Nike    | should      |
| OTVMUFLCN7_5  | ABook title      | ABook ti         | should      |
| OTVMUFLCN7_6  | ABook'and"/title | ABook'and"/t     | should      |
| OTVMUFLCN7_7  | ABook:and*title! | ABook:and*title! | should      |
| OTVMUFLCN7_8  | ABook title      | title            | should not  |
| OTVMUFLCN7_9  | ABook            | book             | should not  |
| OTVMUFLCN7_10 | ABook            | *book            | should not  |

Scenario: Check that assets are searchable by Name of assets within library after changing Title
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA8 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU8 | agency.admin | OTVMUFLA8    |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU8'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue |
| Title        | <Title>    |
| Clock number | AssetCN8   |
And open order item with following clock number '<ClockNumber>'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value 'Fish1-Ad.mov' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following assets:
| Name    |
| <Title> |
And 'should not' see for order item at Add media to your order form following assets:
| Name         |
| Fish2-Ad.mov |

Examples:
| ClockNumber  | Title         |
| OTVMUFLCN8_1 | ABook         |
| OTVMUFLCN8_2 | f1-video.Nike |

Scenario: Check that assets are searchable by Product within library
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA9 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU9 | agency.admin | OTVMUFLA9    |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMUFLA9':
| Advertiser   | Brand   | Sub Brand  | Product   |
| <Advertiser> | <Brand> | <Subbrand> | <Product> |
And logged in with details of 'OTVMUFLU9'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
| /files/Fish2-Ad.mov  |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov,Fish2-Ad.mov'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue   |
| Advertiser   | <Advertiser> |
| Brand        | <Brand>      |
| Sub Brand    | <Subbrand>   |
| Product      | <Product>    |
| Clock number | AssetCN9     |
And open order item with following clock number '<ClockNumber>'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value '<SearchFilter>' for Add media to your order form on order item page
Then I '<ShouldState>' see for order item at Add media to your order form following assets:
| Name         |
| Fish1-Ad.mov |
And 'should not' see for order item at Add media to your order form following assets:
| Name         |
| Fish2-Ad.mov |

Examples:
| ClockNumber  | Advertiser   | Brand          | Subbrand       | Product            | SearchFilter    | ShouldState |
| OTVMUFLCN9_1 | OTVMUFLAR9_1 | OTVMUFLBR9_1   | OTVMUFLSB9_1   | ABookPR9_1         | ABook           | should      |
| OTVMUFLCN9_2 | OTVMUFLAR9_1 | OTVMUFLBR9_1   | OTVMUFLSB9_1   | ABookPR9_2         | abook           | should      |
| OTVMUFLCN9_3 | OTVMUFLAR9_1 | OTVMUFLBR9_1   | OTVMUFLSB9_1   | ABookPR9_3         | Abo             | should      |
| OTVMUFLCN9_4 | OTVMUFLAR9_1 | OTVMUFLBR9_1   | OTVMUFLSB9_1   | ABookPR9_4 PR new  | ABookPR9_4 PR   | should      |
| OTVMUFLCN9_5 | OTVMUFLAR9_1 | OTVMUFLBR9_1   | OTVMUFLSB9_1   | ABookPR9_5PR/new | ABookPR9_5PR/n    | should      |
| OTVMUFLCN9_6 | OTVMUFLAR9_1 | OTVMUFLBR9_1   | OTVMUFLSB9_1   | ABookPR9_6 PR new  | PR new          | should not  |
| OTVMUFLCN9_7 | OTVMUFLAR9_1 | OTVMUFLBR9_1   | OTVMUFLSB9_1   | ABookPR9_7         | book            | should not  |
| OTVMUFLCN9_8 | OTVMUFLAR9_1 | OTVMUFLBR9_1   | OTVMUFLSB9_1   | ABookPR9_8         | *book           | should not  |





Scenario: Check that correct data is showed on asset’s thumbnail in case to retrieve from library
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA9 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU9 | agency.admin | OTVMUFLA9    |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMUFLA9':
| Advertiser  | Brand       | Sub Brand   | Product      |
| OTVMUFLAR10 | OTVMUFLBR10 | OTVMUFLSB10 | OTVMUFLSPR10 |
And logged in with details of 'OTVMUFLU9'
And I am on the library page for collection 'My Assets'NEWLIB
And uploaded following assetsNEWLIB:
| Name                       |
| /files/13DV-CAPITAL-10.mpg |
And waited while preview is visible on library page for collection 'My Assets' for assets '13DV-CAPITAL-10.mpg'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFLCN10  |
When I 'save' asset '13DV-CAPITAL-10.mpg' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue     |
| Title        | OTVMUFLT10.mpg |
| Advertiser   | OTVMUFLAR10    |
| Brand        | OTVMUFLBR10    |
| Sub Brand    | OTVMUFLSB10    |
| Product      | OTVMUFLSPR10   |
| Clock number | AssetCN10      |
And wait for '3' seconds
And open order item with following clock number 'OTVMUFLCN10'
And retrieve assets from library for order item at Add media to your order form
Then I should see for 'tv' order item at Add media to your order form following files metadata:
| Title          | Clock Number | Format | Aspect Ratio | Clock Number Label |
| OTVMUFLT10.mpg | AssetCN10    | MPEG   | 16:9         | Clock number       |


Scenario: Check blocking buttons after adding asset into order item
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA9 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU9_1 | agency.admin | OTVMUFLA9    |streamlined_library,ordering,folders|
And logged in with details of 'OTVMUFLU9_1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFLCN11  |
When I open order item with following clock number 'OTVMUFLCN11'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
Then I should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form


Scenario: Check that asset’s metadata is transferred to active order item under Add Information section
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMUFLA9 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVMUFLU9 | agency.admin | OTVMUFLA9    |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMUFLA9':
| Advertiser  | Brand       | Sub Brand   | Product      |
| OTVMUFLAR10 | OTVMUFLBR10 | OTVMUFLSB10 | OTVMUFLSPR10 |
And logged in with details of 'OTVMUFLU9'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFLCN12  |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue      |
| Title        | !@#\$%^.&*()_+;'|
| Clock number | !@#\$%^.&*()_+;'|
| Duration     | 8s              |
| Advertiser   | OTVMUFLAR10     |
| Brand        | OTVMUFLBR10     |
| Sub Brand    | OTVMUFLSB10     |
| Product      | OTVMUFLSPR10    |
And open order item with following clock number 'OTVMUFLCN12'
And add to order for order item at Add media to your order form following assets '!@#\$%^.&*()_+;''
Then I should see following data for order item on Add information form:
| Advertiser  | Clock Number     | Duration | Product      | Title           |
| OTVMUFLAR10 | !@#\$%^.&*()_+;' | 8s       | OTVMUFLSPR10 | !@#\$%^.&*()_+;'|


Scenario: Check that asset’s metadata is transferred to active order item in cover flow
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFLA13 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| OTVMUFLU13 | agency.admin | OTVMUFLA13   |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU13'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFLCN13  |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue       |
| Title        | !@#\$%^.&*()_+;' |
| Clock number | !@#\$%^.&*()_+;' |
| Duration     | 8s               |
| Category       |Food       |
And open order item with following clock number 'OTVMUFLCN13'
And add to order for order item at Add media to your order form following assets '!@#\$%^.&*()_+;''
Then I should see for active order item on cover flow following data:
| Title            | Duration | Clock Number     |
|  !@#\$%^.&*()_+;' | 8s       | !@#\$%^.&*()_+;' |

Scenario: Check multiple adding assets from Library to order
!--ORD-915
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFLA14 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| OTVMUFLU14 | agency.admin | OTVMUFLA14   |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU14'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
| /files/Fish2-Ad.mov |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMUFLCN14  |
When I open order item with following clock number 'OTVMUFLCN14'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov,Fish2-Ad.mov,Fish3-Ad.mov'
Then I should see count '3' cover flow order items in carousel
And should see for active order item on cover flow following data:
| Title        | Counter |
| Fish1-Ad.mov | 1 of 3  |


Scenario: Check disabling of editing metadata fields for selected QC-asset added to active order item
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFLA15 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| OTVMUFLU15 | agency.admin | OTVMUFLA15   |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU15'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | ClockNumber | SubType        |
| Fish1-Ad.mov | AssetCN15   | <MediaSubType> |
And open order item with following clock number '<ClockNumber>'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
Then I should see '<State>' following fields '<Fields>' for order item on Add information form

Examples:
| ClockNumber   | MediaSubType   | State    | Fields                                                                |
| OTVMUFLCN15_1 | Generic Master | enabled  | Title,Advertiser,Clock Number,Duration,Format                         |
| OTVMUFLCN15_2 | QC-ed master   | disabled | Title,Advertiser,Brand,Sub Brand,Product,Clock Number,Duration,Format |


Scenario: Check that preview is displayed for QC assets in case to add them into order item
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMUFLA15 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| OTVMUFLU15 | agency.admin | OTVMUFLA15   |streamlined_library,ordering|
And logged in with details of 'OTVMUFLU15'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I set following file info for next assets from collection 'My Assets'NEWLIB:
| Name         | ClockNumber | SubType        |
| Fish1-Ad.mov | AssetCN15   | <MediaSubType> |
And open order item with following clock number '<ClockNumber>'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
Then I should see for active order item on cover flow following data:
| Cover Title  |
| Fish1-Ad.mov |
And '<ShouldState>' see preview asset 'Fish1-Ad.mov' of collection 'My Assets' for active order item on cover flow

Examples:
| ClockNumber   | MediaSubType   | ShouldState |
| OTVMUFLCN16_1 | Generic Master | should not  |
| OTVMUFLCN16_2 | QC-ed master   | should      |

