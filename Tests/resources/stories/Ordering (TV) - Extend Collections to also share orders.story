!--ORD-3918
!--ORD-4397
Feature: Extend Collections to also share orders
Narrative:
In order to:
As a AgencyAdmin
I want to check extend collections to also share orders

Scenario: Check that order is shared to agency if asset has been shared via collection
Meta: @skip
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Given I created the following agency:
| Name     | A4User        |
| ECSOA1_1 | DefaultA4User |
| ECSOA1_2 | DefaultA4User |
And added agency 'ECSOA1_2' as a partner to agency 'ECSOA1_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU1_1 | agency.admin | ECSOA1_1     |
| ECSOU1_2 | agency.admin | ECSOA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 |
And logged in with details of 'ECSOU1_1'
And created following categories:
| Name   |
| ECSOC1 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC1       | ECSOA1_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 | ECSOC1   | ECSOCN1      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT1 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ECSOCN1' with following fields:
| Job Number | PO Number |
| ECSOJN1    | ECSOPN1   |
And logged in with details of 'ECSOU1_2'
And accepted all assets on Shared Collection 'ECSOC1' from agency 'ECSOA1_1' page
When I go to View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item clock number 'ECSOCN1' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit# | CurrentTime | ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 | United Kingdom | ECSOPN1   | ECSOJN1 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'ECSOCN1' and items with following fields:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        |
| ECSOCN1      | ECSOAR1    | ECSOPR1 | ECSOT1 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: Check that all data of order item is displayed on shared order on Order Summary page
Meta: @skip
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Given I created the following agency:
| Name     | A4User        |
| ECSOA1_1 | DefaultA4User |
| ECSOA1_2 | DefaultA4User |
And added agency 'ECSOA1_2' as a partner to agency 'ECSOA1_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU1_1 | agency.admin | ECSOA1_1     |
| ECSOU1_2 | agency.admin | ECSOA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 |
And logged in with details of 'ECSOU1_1'
And created following categories:
| Name   |
| ECSOC1 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC1       | ECSOA1_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 | ECSOC2   | ECSOCN2      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ECSOCN2' with following fields:
| Job Number | PO Number |
| ECSOJN2    | ECSOPN2   |
And logged in with details of 'ECSOU1_2'
And accepted all assets on Shared Collection 'ECSOC1' from agency 'ECSOA1_1' page
And I am on Order Summary page for order contains item with following clock number 'ECSOCN2'
Then I should see for order contains item with clock number 'ECSOCN2' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number | Flag           | Market         |
| Dijit        | ECSOA1_1     | DateSubmitted  | CreatedBy  | ECSOJN2    | ECSOPN2   | United Kingdom | United Kingdom |
And should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Brand   | Sub Brand | Product | Title  | First Air Date | Format         | Duration | Status        |
| ECSOCN2      | ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 | ECSOT2 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |
And should see clock delivery 'ECSOCN2' contains destinations with following fields on 'tv' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| BSkyB Green Button | Order Placed | -                | Standard |

Scenario: Check that all data of order item is displayed on shared order on View Media Details page
Meta: @skip
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Given I created the following agency:
| Name     | A4User        |
| ECSOA1_1 | DefaultA4User |
| ECSOA1_2 | DefaultA4User |
And added agency 'ECSOA1_2' as a partner to agency 'ECSOA1_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU1_1 | agency.admin | ECSOA1_1     |
| ECSOU1_2 | agency.admin | ECSOA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 |
And logged in with details of 'ECSOU1_1'
And created following categories:
| Name   |
| ECSOC1 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC1       | ECSOA1_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 | ECSOC3   | ECSOCN3      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ECSOCN3' with following fields:
| Job Number | PO Number |
| ECSOJN3    | ECSOPN3   |
And logged in with details of 'ECSOU1_2'
And accepted all assets on Shared Collection 'ECSOC1' from agency 'ECSOA1_1' page
And I am on View Media Details page for order contains item with following clock number 'ECSOCN3'
Then I should see following media information on View Media Details page:
| Clock Number | Advertiser | Brand | Sub Brand | Product | Title  | Duration | First Air Date | Additional Details  | Video Format                                | Aspect Ratio | Video Standard |
| ECSOCN3      |            |       |           |         | ECSOT3 | 20       | 10/14/2022     | automated test info | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destination delivered for order contains item with clock number 'ECSOCN3' with following fields:
| Order # | Destination        | Date Ordered  | Ordered by | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | ECSOU1_1   | Order Placed |

Scenario: Check that View Delivery Report and View Billing Information are visible for shared order
!--ORD-4678
Meta: @skip
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Given I created the following agency:
| Name     | A4User        | Country        | SAP ID       |
| ECSOA4_1 | DefaultA4User | United Kingdom | DefaultSapID |
| ECSOA4_2 | DefaultA4User | United Kingdom | DefaultSapID |
And added agency 'ECSOA4_2' as a partner to agency 'ECSOA4_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU4_1 | agency.admin | ECSOA4_1     |
| ECSOU4_2 | agency.admin | ECSOA4_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA4_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR4    | ECSOBR4 | ECSOSB4   | ECSOPR4 |
And logged in with details of 'ECSOU4_1'
And 'enable' Billing Service
And created following categories:
| Name   |
| ECSOC4 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC4       | ECSOA4_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR4    | ECSOBR4 | ECSOSB4   | ECSOPR4 | ECSOC4   | ECSOCN4      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT4 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ECSOCN4' with following fields:
| Job Number | PO Number |
| ECSOJN4    | ECSOPN4   |
And logged in with details of 'ECSOU4_2'
And accepted all assets on Shared Collection 'ECSOC4' from agency 'ECSOA4_1' page
And I am on Order Summary page for order contains item with following clock number 'ECSOCN4'
Then I 'should' see 'View Delivery Report,View Billing' buttons on order summary page

Scenario: Check that shared order cannot be assigned
!--ORD-4385
Meta: @skip
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Given I created the following agency:
| Name     | A4User        |
| ECSOA1_1 | DefaultA4User |
| ECSOA1_2 | DefaultA4User |
And added agency 'ECSOA1_2' as a partner to agency 'ECSOA1_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU1_1 | agency.admin | ECSOA1_1     |
| ECSOU1_2 | agency.admin | ECSOA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 |
And logged in with details of 'ECSOU1_1'
And created following categories:
| Name   |
| ECSOC1 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC1       | ECSOA1_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 | ECSOC5   | ECSOCN5      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT5 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ECSOCN5' with following fields:
| Job Number | PO Number |
| ECSOJN5    | ECSOPN5   |
And logged in with details of 'ECSOU1_2'
And accepted all assets on Shared Collection 'ECSOC1' from agency 'ECSOA1_1' page
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'ECSOCN5' in 'live' order list
Then I 'should not' see Assign order button on ordering page

Scenario: Check displaying custom advertiser hierarchy for shared order in orders list
Meta: @skip
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Given I created the following agency:
| Name     | A4User        |
| ECSOA6_1 | DefaultA4User |
| ECSOA6_2 | DefaultA4User |
And added agency 'ECSOA6_2' as a partner to agency 'ECSOA6_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU6_1 | agency.admin | ECSOA6_1     |
| ECSOU6_2 | agency.admin | ECSOA6_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA6_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR6    | ECSOBR6 | ECSOSB6   | ECSOPR6 |
And logged in with details of 'ECSOU6_1'
And created following categories:
| Name   |
| ECSOC6 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC6       | ECSOA6_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR6    | ECSOBR6 | ECSOSB6   | ECSOPR6 | ECSOC6   | ECSOCN6      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT6 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ECSOCN6' with following fields:
| Job Number | PO Number |
| ECSOJN6    | ECSOPN6   |
And logged in with details of 'ECSOU6_2'
And accepted all assets on Shared Collection 'ECSOC6' from agency 'ECSOA6_1' page
And created following 'common' custom metadata fields for agency 'ECSOA6_2':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency 'ECSOA6_2' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Product Custom  |
When I go to View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item clock number 'ECSOCN6' and following fields:
| Order# | DateTime    | Advertiser | Brand | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit# | CurrentTime | ECSOAR6    |       |           | ECSOPR6 | United Kingdom | ECSOPN6   | ECSOJN6 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'ECSOCN6' and items with following fields:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        |
| ECSOCN6      | ECSOAR6    | ECSOPR6 | ECSOT6 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: Check displaying custom advertiser hierarchy for shared order on order summary page
!--ORD-4389
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Meta: @skip
Given I created the following agency:
| Name     | A4User        |
| ECSOA7_1 | DefaultA4User |
| ECSOA7_2 | DefaultA4User |
And added agency 'ECSOA7_2' as a partner to agency 'ECSOA7_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU7_1 | agency.admin | ECSOA7_1     |
| ECSOU7_2 | agency.admin | ECSOA7_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA7_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR7    | ECSOBR7 | ECSOSB7   | ECSOPR7 |
And logged in with details of 'ECSOU7_1'
And created following categories:
| Name   |
| ECSOC7 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC7       | ECSOA7_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR7    | ECSOBR7 | ECSOSB7   | ECSOPR7 | ECSOC7   | ECSOCN7      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT7 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ECSOCN7' with following fields:
| Job Number | PO Number |
| ECSOJN7    | ECSOPN7   |
And logged in with details of 'ECSOU7_2'
And accepted all assets on Shared Collection 'ECSOC7' from agency 'ECSOA7_1' page
And created following 'common' custom metadata fields for agency 'ECSOA7_2':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency 'ECSOA7_2' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Product Custom  |
And I am on Order Summary page for order contains item with following clock number 'ECSOCN7'
Then I should see for order contains item with clock number 'ECSOCN7' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number | Flag           | Market         |
| Dijit        | ECSOA7_1     | DateSubmitted  | CreatedBy  | ECSOJN7    | ECSOPN7   | United Kingdom | United Kingdom |
And should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Brand | Sub Brand | Product | Title  | First Air Date | Format         | Duration | Status        |
| ECSOCN7      | ECSOAR7    |       |           | ECSOPR7 | ECSOT7 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: Check that after approving hold order changes is displayed for shared order
Meta: @skip
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Given I created the following agency:
| Name     | A4User        |
| ECSOA1_1 | DefaultA4User |
| ECSOA1_2 | DefaultA4User |
And added agency 'ECSOA1_2' as a partner to agency 'ECSOA1_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU1_1 | agency.admin | ECSOA1_1     |
| ECSOU1_2 | agency.admin | ECSOA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 |
And logged in with details of 'ECSOU1_1'
And created following categories:
| Name   |
| ECSOC1 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC1       | ECSOA1_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 | ECSOC8   | ECSOCN8      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT8 | Already Supplied   | BSkyB Green Button:Standard |
And hold for approval 'tv' order items with following clock numbers 'ECSOCN8'
And complete order contains item with clock number 'ECSOCN8' with following fields:
| Job Number | PO Number |
| ECSOJN8    | ECSOPN8   |
And logged in with details of 'ECSOU1_2'
And accepted all assets on Shared Collection 'ECSOC1' from agency 'ECSOA1_1' page
And logged in with details of 'ECSOU1_1'
And approve 'tv' order items with following clock numbers 'ECSOCN8'
And logged in with details of 'ECSOU1_2'
And I am on Order Summary page for order contains item with following clock number 'ECSOCN8'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Brand   | Sub Brand | Product | Title  | First Air Date | Format         | Duration | Status        | Approve  |
| ECSOCN8      | ECSOAR1    | ECSOBR1 | ECSOSB1   | ECSOPR1 | ECSOT8 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered | Approved |

Scenario: Check that metadata isn't updated for shared agency by updating it in agency which shared it
Meta: @skip
!--Functionality to share orders was removed, Ref: NGN-16266. So added meta = 'Skip'.
Given I created the following agency:
| Name     | A4User        |
| ECSOA9_1 | DefaultA4User |
| ECSOA9_2 | DefaultA4User |
And added agency 'ECSOA9_2' as a partner to agency 'ECSOA9_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| ECSOU9_1 | agency.admin | ECSOA9_1     |
| ECSOU9_2 | agency.admin | ECSOA9_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ECSOA9_1':
| Advertiser | Brand   | Sub Brand | Product |
| ECSOAR9    | ECSOBR9 | ECSOSB9   | ECSOPR9 |
And logged in with details of 'ECSOU9_1'
And created following categories:
| Name   |
| ECSOC9 |
And shared next agencies for following categories:
| CategoryName | AgencyName |
| ECSOC9       | ECSOA9_2   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ECSOAR9    | ECSOBR9 | ECSOSB9   | ECSOPR9 | ECSOC9   | ECSOCN9      | 20       | 10/14/2022     | HD 1080i 25fps | ECSOT9 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ECSOCN9' with following fields:
| Job Number | PO Number |
| ECSOJN9    | ECSOPN9   |
And logged in with details of 'ECSOU9_2'
And accepted all assets on Shared Collection 'ECSOC9' from agency 'ECSOA9_1' page
And logged in with details of 'ECSOU9_1'
And I am on the global 'common custom' metadata page for agency 'ECSOA9_1'
And clicked 'Advertiser' button in 'common metadata' section on opened metadata page
And filled Description field with text 'Advertiser Custom' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'ECSOU9_2'
When I go to View Live Orders tab of 'tv' order on ordering page
Then I 'should not' see column 'Advertiser Custom' for order list on ordering page