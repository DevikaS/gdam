!--ORD-283
!--ORD-531
Feature: Adding/Copying commercials within an order
Narrative:
In order to:
As a AgencyAdmin
I want to check adding and copying commercials within an order

Scenario: Check adding new order item in case to use Copy current button
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OTVACCOA1    |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVACCOAR1 | OTVACCOBR1 | OTVACCOSB1 | OTVACCOP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVACCOA1'
And on the global 'common custom' metadata page for agency 'OTVACCOA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     | Destination                                    |
| automated test info    | OTVACCOAR1 | OTVACCOBR1 | OTVACCOSB1 | OTVACCOP1 | OTVACCOC1 | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOT1 | PTV Prime:Express;Bangla TV:Standard |
When I open order item with following clock number '<ClockNumber>'
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign  | Clock Number  | Duration | First Air Date | Format         | Product   | Title     |
| automated test info    | OTVACCOAR1 | OTVACCOC1 | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOP1 | OTVACCOT1 |
And 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            | Express   |
| Bangla TV           | PTV Prime |

Examples:
| UserEmail   | GlobalRole   | ClockNumber  |
| OTVACCOU1_1 | agency.admin | OTVACCOCN1_1 |
| OTVACCOU1_2 | agency.user  | OTVACCOCN1_2 |

Scenario: Check adding new order item in case to use Copy current button (guest.user with required permissions)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created 'OTVACCOR1_3' role with 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'OTVACCOA1'
And created users with following fields:
| Email       | Role        | AgencyUnique |
| OTVACCOU1_3 | OTVACCOR1_3 | OTVACCOA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVACCOAR1 | OTVACCOBR1 | OTVACCOSB1 | OTVACCOP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVACCOA1'
And logged in with details of 'OTVACCOU1_3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Destination                                    |
| automated test info    | OTVACCOAR1 | OTVACCOBR1 | OTVACCOSB1 | OTVACCOP1 | OTVACCOC1 | OTVACCOCN1_3 | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOT1 | PTV Prime:Express;Health Club Network:Standard |
When I open order item with following clock number 'OTVACCOCN1_3'
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign  | Clock Number  | Duration | First Air Date | Format         | Product   | Title     |
| automated test info    | OTVACCOAR1 | OTVACCOC1 | OTVACCOCN1_3  | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOP1 | OTVACCOT1 |
And 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            | Express   |
| Health Club Network | PTV Prime |

Scenario: Check adding new order item in case to use Create New button
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OTVACCOA1    |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVACCOAR1 | OTVACCOBR2 | OTVACCOSB2 | OTVACCOP2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVACCOA1'
And on the global 'common custom' metadata page for agency 'OTVACCOA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     | Destination                                    |
| automated test info    | OTVACCOAR1 | OTVACCOBR2 | OTVACCOSB2 | OTVACCOP2 | OTVACCOC2 | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOT2 | PTV Prime:Express;Bangla TV:Standard           |
When I open order item with following clock number '<ClockNumber>'
And 'create new' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title |
|                        |            |          |              |          |                |        |         |       |
And 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            | Express   |
| Bangla TV           | PTV Prime |

Examples:
| UserEmail   | GlobalRole   | ClockNumber  |
| OTVACCOU1_1 | agency.admin | OTVACCOCN2_1 |
| OTVACCOU1_2 | agency.user  | OTVACCOCN2_2 |

Scenario: Check adding new order item in case to use Create New button (guest.user with required permissions)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created 'OTVACCOR1_3' role with 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'OTVACCOA1'
And created users with following fields:
| Email       | Role        | AgencyUnique |
| OTVACCOU1_3 | OTVACCOR1_3 | OTVACCOA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVACCOAR1 | OTVACCOBR2 | OTVACCOSB2 | OTVACCOP2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVACCOA1'
And logged in with details of 'OTVACCOU1_3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Destination                                    |
| automated test info    | OTVACCOAR1 | OTVACCOBR2 | OTVACCOSB2 | OTVACCOP2 | OTVACCOC2 | OTVACCOCN2_3 | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOT2 | PTV Prime:Express;Health Club Network:Standard |
When I open order item with following clock number 'OTVACCOCN2_3'
And 'create new' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title |
|                        |            |          |              |          |                |        |         |       |
And 'should not' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard            | Express   |
| Health Club Network | PTV Prime |

Scenario: Check that added order item via using Create New Copy current is displayed on order list
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVACCOU1_1 | agency.admin | OTVACCOA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVACCOAR1 | OTVACCOBR3 | OTVACCOSB3 | OTVACCOP3 |
And logged in with details of 'OTVACCOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVACCOAR1 | OTVACCOBR3 | OTVACCOSB3 | OTVACCOP3 | OTVACCOC3 | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOT3 |
When I open order item with following clock number '<ClockNumber>'
And '<Action>' order item by Add Commercial button on order item page
And save as draft order
Then I should see TV 'draft' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | NoClocks | Creator     |
| Digit  | CurrentTime | OTVACCOAR1 | United Kingdom | 2        | OTVACCOU1_1 |

Examples:
| ClockNumber  | Action       |
| OTVACCOCN3_1 | create new   |
| OTVACCOCN3_2 | copy current |

Scenario: Check that copied data is correctly displayed on cover flow
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVACCOU1_1 | agency.admin | OTVACCOA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVACCOAR1 | OTVACCOBR4 | OTVACCOSB4 | OTVACCOP4 |
And logged in with details of 'OTVACCOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVACCOAR1 | OTVACCOBR4 | OTVACCOSB4 | OTVACCOP4 | OTVACCOC4 | OTVACCOCN4   | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOT4 |
When I open order item with following clock number 'OTVACCOCN4'
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Title     | Duration | Clock Number | Counter |
| OTVACCOT4 | 20       | OTVACCOCN4   | 2 of 2  |


Scenario: Check that data of order item retrieved from library is copied and file isn't copied
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| OTVACCOU1_1 | agency.admin | OTVACCOA1    |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVACCOAR1 | OTVACCOBR5 | OTVACCOSB5 | OTVACCOPR5 |
And logged in with details of 'OTVACCOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVACCOCN5   |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue    |
| Title        | OTVACCOT5.mov |
| Duration     |8s             |
| Clock number | AssetACCOCN5  |
| Advertiser   | OTVACCOAR1    |
| Brand        | OTVACCOBR5    |
| Sub Brand    | OTVACCOSB5    |
| Product      | OTVACCOPR5    |Check availablity send to delivery according to user's permissions
And open order item with following clock number 'OTVACCOCN5'
And add to order for order item at Add media to your order form following assets 'OTVACCOT5.mov'
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Title         | Duration | Clock Number | Counter | Cover Title |
| OTVACCOT5.mov | 8s       | AssetACCOCN5 | 2 of 2  |             |
And should see following data for order item on Add information form:
| Advertiser | Clock Number | Duration | Product    | Title         |
| OTVACCOAR1 | AssetACCOCN5 | 8s       | OTVACCOPR5 | OTVACCOT5.mov |



Scenario: Check that QC & Ingest Only is copied in case to Copy current
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVACCOU1_1 | agency.admin | OTVACCOA1    |
And logged in with details of 'OTVACCOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVACCOCN6   |
When I open order item with following clock number 'OTVACCOCN6'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see 'inactive' QC & Ingest Only button on order item page
And should see 'inactive' Select Broadcast Destinations section on order item page

Scenario: Check that value of market related fields are copied in case to use Copy current button
!--ORD-958
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created 'OTVACCOR7' role with 'asset.create,asset_filter_collection.create,dictionary.add_on_the_fly,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'OTVACCOA1'
And created users with following fields:
| Email     | Role      | AgencyUnique |
| OTVACCOU7 | OTVACCOR7 | OTVACCOA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVACCOAR1 | OTVACCOBR7 | OTVACCOSB7 | OTVACCOP7 |
And logged in with details of 'OTVACCOU7'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'Spain' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Media Agency | Clave     | Media Agency Contact | Creative Agency Contact |
| automated test info    | OTVACCOAR1 | OTVACCOBR7 | OTVACCOSB7 | OTVACCOP7 | OTVACCOC7 | OTVACCOCN7   | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOT7 | Yes                | OTVACCOMA7	| OTVACCOC7 | OTVACCOMAC7	       | OTVACCOCAC7	         |
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Counter |
| 2 of 2  |
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign  | Clock Number | Duration | First Air Date | Format         | Product   | Title     | Subtitles Required | Media Agency | Clave     | Media Agency Contact | Creative Agency Contact |
| automated test info    | OTVACCOAR1 | OTVACCOC7 | OTVACCOCN7   | 20       | 12/14/2022     | HD 1080i 25fps | OTVACCOP7 | OTVACCOT7 | Yes                | OTVACCOMA7	  | OTVACCOC7 | OTVACCOMAC7	         | OTVACCOCAC7	           |

Scenario: Check that data of order item retrieved from project is copied and file isn’t copied
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVACCOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVACCOU1_1 | agency.admin | OTVACCOA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVACCOA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVACCOAR1 | OTVACCOBR8 | OTVACCOSB8 | OTVACCOPR8 |
And logged in with details of 'OTVACCOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVACCOCN8   |
And created 'OTVACCOP8' project
And created '/OTVACCOF8' folder for project 'OTVACCOP8'
And uploaded into project 'OTVACCOP8' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /OTVACCOF8 |
And waited while transcoding is finished in folder '/OTVACCOF8' on project 'OTVACCOP8' files page
And I am on file 'Fish1-Ad.mov' info page in folder '/OTVACCOF8' project 'OTVACCOP8'
When I 'save' file info by next information:
| FieldName    | FieldValue    |
| Title        | OTVACCOT8.mov |
| Advertiser   | OTVACCOAR1    |
| Brand        | OTVACCOBR8    |
| Sub Brand    | OTVACCOSB8    |
| Product      | OTVACCOPR8    |
| Clock number | FileACCOCN8   |
| Duration     | 8s            |
And open order item with following clock number 'OTVACCOCN8'
And add to order for order item at Add media to your order form following files 'OTVACCOT8.mov' from folder '/OTVACCOF8' of project 'OTVACCOP8'
And 'copy current' order item by Add Commercial button on order item page
Then I should see for active order item on cover flow following data:
| Title         | Duration | Clock Number | Counter | Cover Title |
| OTVACCOT8.mov | 8s       | FileACCOCN8  | 2 of 2  |             |
And should see following data for order item on Add information form:
| Advertiser | Clock Number | Duration | Product    | Title         |
| OTVACCOAR1 | FileACCOCN8  | 8s       | OTVACCOPR8 | OTVACCOT8.mov |