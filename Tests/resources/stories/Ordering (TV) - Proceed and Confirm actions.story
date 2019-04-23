!--ORD-1451
Feature: Proceed and Confirm actions
Narrative:
In order to:
As a AgencyAdmin
I want to check that proceed and confirm actions are correct

Scenario: Data is saved in draft order in the same way as for Save as Draft button after clicking Proceed button
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| PACAAR1    | PACABR1 | PACASB1   | PACAP1  |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAA1'
And on the global 'common custom' metadata page for agency 'PACAA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'PACAU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | PACAAR1    | PACABR1 | PACASB1   | PACAP1  | PACAC1   | PACACN1      | 20       | 12/14/2022     | HD 1080i 25fps | PACAT1 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Bangla TV          |
And click Proceed button on order item page
And open order item with following clock number 'PACACN1'
Then I should see for active order item on cover flow following data:
| Title  | Duration | Clock Number | Aspect Ratio | Format |
| PACAT1 | 20       | PACACN1      | 16x9         | hd     |
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format         | Product | Title  | Subtitles Required |
| automated test info    | PACAAR1    | PACAC1   | PACACN1      | 20       | 12/14/2022     | HD 1080i 25fps | PACAP1  | PACAT1 | Already Supplied   |
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard           |
| Bangla TV          |

Scenario: After confirming order it appears on View Live tab, on View Held tab and disappears from View Draft tab, also check counters
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA2 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU2 | agency.admin | PACAA2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA2':
| Advertiser | Brand   | Sub Brand | Product |
| PACAAR2    | PACABR2 | PACASB2   | PACAP2  |
And logged in with details of 'PACAU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | PACAAR2    | PACABR2 | PACASB2   | PACAP2  | PACAC2   | PACACN2      | 20       | 12/14/2022     | HD 1080i 25fps | PACAT2 | Already Supplied   | Aastha:Standard |
And hold for approval 'tv' order items with following clock numbers 'PACACN2'
When I open order item with following clock number 'PACACN2'
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| PACAJN2    | PACAPN2   |
And confirm order on Order Proceed page
Then I should see count orders '1' on 'View Live Orders' tab in order slider
And should see orders counter '1' above orders list on ordering page
When I select 'View Held Orders' tab on ordering page
Then I should see count orders '1' on 'View Held Orders' tab in order slider
And should see orders counter '1' above orders list on ordering page

Scenario: Check correct work of Back button (data on Order Summary page should be saved)
!--Recipients logic has been added but they dont get saved--Maria asked to ignore it -04/11
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| PACAAR1    | PACABR3 | PACASB3   | PACAP3  |
And logged in with details of 'PACAU1'
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                                 |
| automated test info    | PACAAR1    | PACABR3 | PACASB3   | PACAP3  | PACAC3   | PACACN3      | 20       | 12/14/2022     | HD 1080i 25fps | PACAT3 | Already Supplied   | Sony Singapore:Standard;Tatasky HD:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'PACACN3'
When I fill following fields on Order Proceed page:
| Manage Format Conversions | Notify About Delivery | Notify About Passed QC |Job Number | PO Number |
| should                    | should                | should                 |PACAJN3    | PACAPN3   |
And back to order item page from Order Proceed page
And click Proceed button on order item page
Then I should see following data for order on Order Proceed page:
| Manage Format Conversions | Notify About Delivery | Notify About Passed QC | Job Number | PO Number |
| should                    | should                | should                 | PACAJN3    | PACAPN3   |

Scenario: Check that data are correctly displayed for live orders on View Live tab and Order Summary
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | FirstName | LastName | Role         | AgencyUnique |
| PACAU4 | PACAFN4   | PACALN4  | agency.admin | PACAA1       |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| PACAAR1    | PACABR4 | PACASB4   | PACAP4  |
And on the global 'common custom' metadata page for agency 'PACAA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'PACAU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | PACAAR1    | PACABR4 | PACASB4   | PACAP4  | PACAC4   | PACACN4      | 20       | 12/14/2022     | HD 1080i 25fps | PACAT4 | Already Supplied   | GEO News:Standard |
And complete order contains item with clock number 'PACACN4' with following fields:
| Job Number | PO Number |
| PACAJN4    | PACAPN4   |
When I go to Order Summary page for order contains item with following clock number 'PACACN4'
Then I should see for order contains item with clock number 'PACACN4' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By      | Job Number | PO Number | Flag           | Market         |
| Dijit        | PACAA1       | DateSubmitted  | PACAFN4 PACALN4 | PACAJN4    | PACAPN4   | United Kingdom | United Kingdom |
And should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        |
| PACACN4      | PACAAR1    | PACAP4  | PACAT4 | 12/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |
And should see clock delivery 'PACACN4' contains destinations with following fields on 'tv' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| GEO News | Order Placed | -                | Standard |

Scenario: Check that data are correctly displayed for hold orders on View Hold tab and Order Summary
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| PACAAR1    | PACABR5 | PACASB5   | PACAP5  |
And logged in with details of 'PACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | PACAAR1    | PACABR5 | PACASB5   | PACAP5  | PACAC5   | PACACN5      | 20       | 12/14/2022     | HD 1080i 25fps | PACAT5 | Already Supplied   | BSkyB Green Button:Standard |
And hold for approval 'tv' order items with following clock numbers 'PACACN5'
And complete order contains item with clock number 'PACACN5' with following fields:
| Job Number | PO Number |
| PACAJN5    | PACAPN5   |
When I go to Order Summary page for order contains item with following clock number 'PACACN5'
Then I should see 'enabled' View Delivery Report button on order summary page
And should see for order contains item with clock number 'PACACN5' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number | Flag           | Market         |
| Dijit        | PACAA1       | DateSubmitted  | CreatedBy  | PACAJN5    | PACAPN5   | United Kingdom | United Kingdom |
And should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration | Status        | Approve |
| PACACN5      | PACAAR1    | PACAP5  | PACAT5 | 12/14/22       | HD 1080i 25fps | 20       | 0/1 Delivered | On hold |
And should see clock delivery 'PACACN5' contains destinations with following fields on 'tv' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| BSkyB Green Button | Order Placed | -                | Standard |

Scenario: Check that data are correctly displayed for draft orders on View Draft tab
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| PACAAR1    | PACABR6 | PACASB6   | PACAP6  |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAA1'
And logged in with details of 'PACAU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | PACAAR1    | PACABR6 | PACASB6   | PACAP6  | PACAC6   | PACACN6      | 20       | 12/14/2022     | HD 1080i 25fps | PACAT6 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And click Proceed button on order item page
And go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV order in 'draft' order list with item clock number 'PACACN6' and following fields:
| Order# | DateTime    | Advertiser | Market         | NoClocks | Creator |
| Digit  | CurrentTime | PACAAR1    | United Kingdom | 1        | PACAU1  |
And should see 'draft' order in 'tv' order list contains clock number 'PACACN6' and items with following fields:
| Clock Number | Advertiser | Product | Title  | First Air Date | Format         | Duration |
| PACACN6      | PACAAR1    | PACAP6  | PACAT6 | 12/14/2022     | HD 1080i 25fps | 20       |

Scenario: Check that data are correctly displayed for draft orders on View Draft tab after editing created order
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand     | Sub Brand | Product  |
| PACAAR7_1  | PACABR7_1 | PACASB7_1 | PACAP7_1 |
| PACAAR7_2  | PACABR7_2 | PACASB7_2 | PACAP7_2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAA1'
And logged in with details of 'PACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information  | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info new | PACAAR7_1  | PACABR7_1 | PACASB7_1 | PACAP7_1 | PACAC7_1 | PACACN7_1    | 20       | 12/14/2022     | HD 1080i 25fps | PACAT7_1 | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'PACACN7_1'
When I fill following fields on Order Proceed page:
| Job Number | PO Number |
| PACAJN7_1  | PACAPN7_1 |
And back to order item page from Order Proceed page
And select following market 'Republic of Ireland' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format            | Title    | Subtitles Required |
| automated test info    | PACAAR7_2  | PACABR7_2 | PACASB7_2 | PACAP7_2 | PACAC7_2 | PACACN7_2    | 15       | 10/14/2022     | HD 1080i 29.97fps | PACAT7_2 | Adtext HD          |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard          |
| Universal Ireland |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| PACAJN7_2  | PACAPN7_2 |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'PACACN7_2' and following fields:
| Order# | DateTime    | Advertiser | Market              | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | PACAAR7_2  | Republic of Ireland | PACAPN7_2 | PACAJN7_2 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'PACACN7_2' and items with following fields:
| Clock Number | Advertiser | Product  | Title    | First Air Date | Format            | Duration | Status        |
| PACACN7_2    | PACAAR7_2  | PACAP7_2 | PACAT7_2 | 10/14/2022     | HD 1080i 29.97fps | 15       | 0/1 Delivered |

Scenario: Check that data of order item is correctly transferred to QC asset if order item is created as new one
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| PACAAR1    | PACABR8 | PACASB8   | PACAP8  |
And logged in with details of 'PACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | PACAAR1    | PACABR8 | PACASB8   | PACAP8  | PACAC8   | PACACN8      | 20       | 12/14/2022     | HD 1080i 25fps | PACA.T8 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'PACACN8' with following fields:
| Job Number | PO Number |
| PACAJN8    | PACAPN8   |
When I go to asset 'PACA.T8' info page in Library for collection 'My Assets'
Then I 'should' see following 'custom metadata' fields on opened asset info page:
| FieldName       | FieldValue                                  |
| Advertiser      | PACAAR1                                     |
| Product         | PACAP8                                      |
| Title           | PACA.T8                                     |
| Media type      | video                                       |
| Media sub-type  | QC-ed master                                |
| Clock number    | PACACN8                                     |
| Air Date        | 12/14/2022                                  |
| Duration        | 20                                          |
And 'should' see following 'specification' fields on opened asset info page:
| FieldName       | FieldValue                                  |
| Height:          | 608                                         |
| Standard:        | 720x576i@25fps                              |
| Width:           | 720                                         |
| Aspect ratio:    | 16x9                                        |
| Frame:           | 25                                          |
| Encoding system: | PAL                                         |
| Profile name:    | Broadcast SD PAL 16x9 Program Stream master |

Scenario: Check that data of order item is correctly transferred to QC asset if order item is created by retrieving asset from Library
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand   | Sub Brand | Product |
| PACAAR1    | PACABR9 | PACASB9   | PACAP9  |
And logged in with details of 'PACAU1'
And uploaded following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | PACAAR1    | PACABR9 | PACASB9   | PACAP9  | PACAC9   | PACACN9      | 20       | 12/14/2022     | HD 1080i 25fps | PACAT9 | Already Supplied   | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'PACACN9' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And complete order contains item with clock number 'PACACN9' with following fields:
| Job Number | PO Number |
| PACAJN9    | PACAPN9   |
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'
Then I 'should' see following 'custom metadata' fields on opened asset info page:
| FieldName       | FieldValue                                  |
| Advertiser      | PACAAR1                                     |
| Product         | PACAP9                                      |
| Title           | Fish1-Ad.mov                                |
| Media type      | video                                       |
| Media sub-type  | QC-ed master                                |
| Air Date        | 12/14/2022                                  |
| Duration        | 6s 33ms                                     |
And 'should' see following 'specification' fields on opened asset info page:
| FieldName       | FieldValue                                  |
| Height:          | 608                                         |
| Standard:        | 720x576i@25fps                              |
| Width:           | 720                                         |
| Aspect ratio:    | 16x9                                        |
| Frame:           | 25                                          |
| Encoding system: | PAL                                         |
| Profile name:    | Broadcast SD PAL 16x9 Program Stream master |

Scenario: Check that data of order item is correctly transferred to QC asset if order item is created by retrieving file from Projects
Meta: @qaorderingsmoke
      @uatorderingsmoke
!-- On UAT's scenario would fail if BU created with S3 storage, FAB-767 should fix the issue
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |Access|
| PACAU1 | agency.admin | PACAA1       |streamlined_library,folders,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand    | Sub Brand | Product |
| PACAAR1    | PACABR10 | PACASB10  | PACAP10 |
And logged in with details of 'PACAU1'
And created 'PACAP10' project
And created '/PACAF10' folder for project 'PACAP10'
And uploaded into project 'PACAP10' following files:
| FileName             | Path     |
| /files/Fish2-Ad.mov  | /PACAF10 |
And waited while transcoding is finished in folder '/PACAF10' on project 'PACAP10' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | PACAAR1    | PACABR10 | PACASB10  | PACAP10 | PACAC10  | PACACN10     | 20       | 12/14/2022     | HD 1080i 25fps | PACAT10 | Already Supplied   | GEO News:Standard |
And add to 'tv' order item with clock number 'PACACN10' following file '/files/Fish2-Ad.mov' from folder '/PACAF10' of project 'PACAP10'
And complete order contains item with clock number 'PACACN10' with following fields:
| Job Number | PO Number |
| PACAJN10   | PACAPN10  |
When I go to asset 'Fish2-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue                                  |
| Advertiser      | PACAAR1                                     |
| Product         | PACAP10                                     |
| Title           | Fish2-Ad.mov                                |
| Media type      | video                                       |
| Media sub-type  | QC-ed master                                |
| Air Date        | 12/14/2022                                  |
| Duration        | 6s 33ms                                     |
And 'should' see following 'specification' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue                                  |
| Height         | 608                                         |
| Standard        | 720x576i@25fps                              |
| Width           | 720                                         |
| Aspect ratio    | 16x9                                        |
| Frame          | 25                                          |
| Encoding system | PAL                                         |
| Profile name    | Broadcast SD PAL 16x9 Program Stream master |


Scenario: Check that View Delivery Report is correctly opened
!--QA-396,ORD-1644, ORD-1651
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand    | Sub Brand | Product |
| PACAAR1    | PACABR11 | PACASB11  | PACAP11 |
And logged in with details of 'PACAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | PACAAR1    | PACABR11 | PACASB11  | PACAP11 | PACAC11  | PACACN11     | 20       | 12/14/2022     | HD 1080i 25fps | PACAT11 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'PACACN11' with following fields:
| Job Number | PO Number |
| PACAJN11   | PACAPN11  |
When I go to Order Summary page for order contains item with following clock number 'PACACN11'
And I click ViewDeliveryReport button on the Order Summary Page
Then I should see that View 'Delivery' report opens for order with clock number 'PACACN11'

Scenario: Check work of Back button on Order Summary page
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| PACAU1 | agency.admin | PACAA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAA1':
| Advertiser | Brand    | Sub Brand | Product |
| PACAAR12   | PACABR12 | PACASB12  | PACAP12 |
And logged in with details of 'PACAU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                |
| automated test info    | PACAAR12   | PACABR12 | PACASB12  | PACAP12 | PACAC12  | PACACN12     | 20       | 12/14/2022     | HD 1080i 25fps | PACAT12 | Already Supplied   | Universal Ireland:Standard |
When I open order item with following clock number 'PACACN12'
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| PACAJN12   | PACAPN12  |
And confirm order on Order Proceed page
When I go to Order Summary page for order contains item with following clock number 'PACACN12'
And back to ordering page from Order Summary page
Then I should see page 'orders?status=in_progress&type=tv_order'