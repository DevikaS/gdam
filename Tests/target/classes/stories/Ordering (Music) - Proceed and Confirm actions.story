!--ORD-1538
Feature: Proceed and Confirm actions
Narrative:
In order to:
As a AgencyAdmin
I want to check proceed and confirm actions for music order



Scenario: After confirming order it appears on View Live tab, on View Held tab and disappears from View Draft tab, also check counters for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| PACAAM2 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| PACAUM2 | agency.admin | PACAAM2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM2':
| Advertiser | Brand    | Sub Brand | Product |
| PACAARM2   | PACABRM2 | PACASBM2  | PACAPM2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM2'
And logged in with details of 'PACAUM2'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title  | Destination                  |
| automated test info    | PACAARM2       | PACABRM2 | PACASBM2  | PACAPM2 | PACACM2 | PACACNM2  | 12/14/2022   | HD 1080i 25fps | PACATM2 | Aastha:Standard |
And hold for approval 'music' order items with following isrc codes 'PACACNM2'
When I open order item with following isrc code 'PACACNM2'
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| PACAJNM2   | PACAPNM2  |
And confirm order on Order Proceed page
Then I should see count orders '1' on 'View Live Orders' tab in order slider
And should see orders counter '1' above orders list on ordering page
When I select 'View Held Orders' tab on ordering page
Then I should see count orders '1' on 'View Held Orders' tab in order slider
And should see orders counter '1' above orders list on ordering page

Scenario: Check correct work of Back button (data on Order Summary page should be saved) for music
Meta: @ordering
      @obug
 !--FAB-493
Given I created the following agency:
| Name    | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| PACAUM1 | agency.admin | PACAAM1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand    | Sub Brand | Product  |
| PACAARM1   | PACABRM3 | PACASBM3  | PACAPM3  |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM1'
And logged in with details of 'PACAUM1'
And create 'music' order with market 'India' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   | Destination                                 |
| automated test info    | PACAARM1       | PACABRM3 | PACASBM3  | PACAPM3 | PACACM3 | PACACNM3  | 12/14/2022   | HD 1080i 25fps | PACATM3 | Sony Singapore:Standard;Tatasky HD:Standard |
And I am on Order Proceed page for order contains order item with following isrc code 'PACACNM3'
When I fill following fields on Order Proceed page:
| Manage Format Conversions | Notify About Delivery | Notify About Passed QC | Order Completed Recipients      | Job Number | PO Number |
| should                    | should                | should                 | PACAU1M,PACAUM2                 | PACAJNM3   | PACAPNM3  |
And back to order item page from Order Proceed page
And click Proceed button on order item page
Then I should see following data for order on Order Proceed page:
| Manage Format Conversions | Notify About Delivery | Notify About Passed QC | Order Completed Recipients      | Job Number | PO Number |
| should                    | should                | should                 | PACAU1M,PACAUM2                  | PACAJNM3   | PACAPNM3  |

Scenario: Check that data are correctly displayed for live orders on View Live tab and Order Summary for music
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name    | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email   | FirstName | LastName | Role         | AgencyUnique |
| PACAUM4 | PACAMFN4  | PACAMLN4 | agency.admin | PACAAM1      |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand    | Sub Brand | Product |
| PACAARM1   | PACABRM4 | PACASBM4  | PACAPM4 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM1'
And on the global 'common custom' metadata page for agency 'PACAAM1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'PACAUM4'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   | Destination                 |
| automated test info    | PACAARM1       | PACABRM4 | PACASBM4  | PACAPM4 | PACACM4 | PACACNM4  | 12/14/2022   | HD 1080i 25fps | PACATM4 | GEO News:Standard |
And complete order contains item with isrc code 'PACACNM4' with following fields:
| Job Number | PO Number |
| PACAJNM4   | PACAPNM4  |
When I go to Order Summary page for order contains item with following isrc code 'PACACNM4'
Then I should see for order contains item with isrc code 'PACACNM4' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By        | Job Number | PO Number | Flag           | Market         |
| Dijit        | PACAAM1      | DateSubmitted  | PACAMFN4 PACAMLN4 | PACAJNM4   | PACAPNM4  | United Kingdom | United Kingdom |
And should see clock delivery with following fields on 'music' order summary page:
| ISRC Code | Record Company | Label   | Artist  | Title   | Release Date | Format         | Status        |
| PACACNM4  | PACAARM1       | PACAPM4 | PACACM4 | PACATM4 | 12/14/2022   | HD 1080i 25fps | 0/1 Delivered |
And should see clock delivery 'PACACNM4' contains destinations with following fields on 'music' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| GEO News | Order Placed | -                | Standard |

Scenario: Check that data are correctly displayed for hold orders on View Hold tab and Order Summary for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| PACAUM1 | agency.admin | PACAAM1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand    | Sub Brand | Product |
| PACAARM1   | PACABRM5 | PACASBM5  | PACAPM5 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM1'
And logged in with details of 'PACAUM1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   | Destination                 |
| automated test info    | PACAARM1       | PACABRM5 | PACASBM5  | PACAPM5 | PACACM5 | PACACNM5  | 12/14/2022   | HD 1080i 25fps | PACATM5 | BSkyB Green Button:Standard |
And hold for approval 'music' order items with following isrc codes 'PACACNM5'
And complete order contains item with isrc code 'PACACNM5' with following fields:
| Job Number | PO Number |
| PACAJNM5   | PACAPNM5  |
When I go to Order Summary page for order contains item with following isrc code 'PACACNM5'
Then I should see 'enabled' View Delivery Report button on order summary page
And should see for order contains item with isrc code 'PACACNM5' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number | Flag           | Market         |
| Dijit        | PACAAM1      | DateSubmitted  | CreatedBy  | PACAJNM5   | PACAPNM5  | United Kingdom | United Kingdom |
And should see clock delivery with following fields on 'music' order summary page:
| ISRC Code | Record Company | Label   | Title   | Release Date | Format         | Status        | Approve |
| PACACNM5  | PACAARM1       | PACAPM5 | PACATM5 | 12/14/22     | HD 1080i 25fps | 0/1 Delivered | On hold |
And should see clock delivery 'PACACNM5' contains destinations with following fields on 'music' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| BSkyB Green Button | Order Placed | -                | Standard |

Scenario: Check that data are correctly displayed for draft orders on View Draft tab for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| PACAUM1 | agency.admin | PACAAM1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand    | Sub Brand | Product |
| PACAARM1   | PACABRM6 | PACASBM6  | PACAPM6 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM1'
And logged in with details of 'PACAUM1'
And I am on View Draft Orders tab of 'music' order on ordering page
When I create 'music' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   |
| automated test info    | PACAARM1   | PACABRM6 | PACASBM6  | PACAPM6 | PACACM6 | PACACNM6  | 12/14/2022   | HD 1080i 25fps | PACATM6 |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And click Proceed button on order item page
And go to View Draft Orders tab of 'music' order on ordering page
Then I should see Music order in 'draft' order list with item isrc code 'PACACNM6' and following fields:
| Order# | DateTime    | Record Company | Market         | NoClocks | Creator |
| Digit  | CurrentTime | PACAARM1       | United Kingdom | 1        | PACAUM1 |
And should see 'draft' order in 'music' order list contains isrc code 'PACACNM6' and items with following fields:
| ISRC Code | Record Company | Label   | Artist  | Title   | Release Date | Format         |
| PACACNM6  | PACAARM1       | PACAPM6 | PACACM6 | PACATM6 | 12/14/2022   | HD 1080i 25fps |

Scenario: Check that data are correctly displayed for draft orders on View Draft tab after editing created order for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| PACAUM1 | agency.admin | PACAAM1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand      | Sub Brand  | Product   |
| PACAARM7_1 | PACABRM7_1 | PACASBM7_1 | PACAPM7_1 |
| PACAARM7_2 | PACABRM7_2 | PACASBM7_2 | PACAPM7_2 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM1'
And logged in with details of 'PACAUM1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information  | Record Company | Brand      | Sub Brand  | Label     | Artist    | ISRC Code  | Release Date | Format         | Title     | Destination                 |
| automated test info new | PACAARM7_1     | PACABRM7_1 | PACASBM7_1 | PACAPM7_1 | PACACM7_1 | PACACNM7_1 | 12/14/2022   | HD 1080i 25fps | PACATM7_1 | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following isrc code 'PACACNM7_1'
When I fill following fields on Order Proceed page:
| Job Number | PO Number  |
| PACAJNM7_1 | PACAPNM7_1 |
And back to order item page from Order Proceed page
And select following market 'Republic of Ireland' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand      | Sub Brand  | Label     | Artist    | ISRC Code  | Release Date | Format            | Title     |
| automated test info    | PACAARM7_2 | PACABRM7_2 | PACASBM7_2 | PACAPM7_2 | PACACM7_2 | PACACNM7_2 | 10/14/2022   | HD 1080i 29.97fps | PACATM7_2 |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard          |
| Universal Ireland |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number  |
| PACAJNM7_2 | PACAPNM7_2 |
And confirm order on Order Proceed page
Then I should see Music order in 'live' order list with item isrc code 'PACACNM7_2' and following fields:
| Order# | DateTime    | Record Company | Market              | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | PACAARM7_2     | Republic of Ireland | PACAPNM7_2 | PACAJNM7_2 | 1        | 0/1 Delivered |
And should see 'live' order in 'music' order list contains isrc code 'PACACNM7_2' and items with following fields:
| ISRC Code  | Record Company | Label     | Artist    | Title     | Release Date | Format            | Status        |
| PACACNM7_2 | PACAARM7_2     | PACAPM7_2 | PACACM7_2 | PACATM7_2 | 10/14/2022   | HD 1080i 29.97fps | 0/1 Delivered |

Scenario: Check that data of order item is correctly transferred to QC asset if order item is created as new one for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| PACAUM1 | agency.admin | PACAAM1       |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand    | Sub Brand | Product |
| PACAARM1   | PACABRM8 | PACASBM8  | PACAPM8 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM1'
And logged in with details of 'PACAUM1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist   | ISRC Code | Release Date | Format         | Title   | Destination                 |
| automated test info    | PACAARM1       | PACABRM8 | PACASBM8  | PACAPM8 | PACACM8  | PACACNM8  | 12/14/2022   | HD 1080i 25fps | PACA.T8 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'PACACNM8' with following fields:
| Job Number | PO Number |
| PACAJNM8   | PACAPNM8  |
When I go to asset 'PACA.T8' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue                                  |
| Advertiser      | PACAARM1                                    |
| Product         | PACAPM8                                     |
| Title           | PACA.T8                                     |
| Media type      | video                                       |
| Media sub-type  | QC-ed master                                |
| Clock number    | PACACNM8                                    |
| Air Date        | 12/14/2022                                  |
And 'should' see following 'specification' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue                                  |
| Height         | 608                                         |
| Standard        | 720x576i@25fps                              |
| Width          | 720                                         |
| Aspect ratio    | 16x9                                        |
| Frame           | 25                                          |
| Encoding system | PAL                                         |
| Profile name    | Broadcast SD PAL 16x9 Program Stream master |


Scenario: Check that data of order item is correctly transferred to QC asset if order item is created by retrieving asset from Library for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| PACAUM1 | agency.admin | PACAAM1      |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand    | Sub Brand | Product |
| PACAARM1   | PACABRM9 | PACASBM9  | PACAPM9 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM1'
And logged in with details of 'PACAUM1'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   | Destination                 |
| automated test info    | PACAARM1       | PACABRM9 | PACASBM9  | PACAPM9 | PACACM9 | PACACNM9  | 12/14/2022   | HD 1080i 25fps | PACATM9 | BSkyB Green Button:Standard |
And add to 'music' order item with isrc code 'PACACNM9' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And complete order contains item with isrc code 'PACACNM9' with following fields:
| Job Number | PO Number |
| PACAJNM9   | PACAPNM9  |
When I go to asset 'Fish1-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue                                  |
| Advertiser      | PACAARM1                                    |
| Product         | PACAPM9                                     |
| Title           | Fish1-Ad.mov                                |
| Media type      | video                                       |
| Media sub-type  | QC-ed master                                |
| Air Date        | 12/14/2022                                  |
And 'should' see following 'specification' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue                                  |
| Height          | 608                                         |
| Standard       | 720x576i@25fps                              |
| Width           | 720                                         |
| Aspect ratio   | 16x9                                        |
| Frame          | 25                                          |
| Encoding system | PAL                                         |
| Profile name    | Broadcast SD PAL 16x9 Program Stream master |



Scenario: Check that data of order item is correctly transferred to QC asset if order item is created by retrieving file from Projects for music
Meta: @qaorderingsmoke
      @uatorderingsmoke
!-- On UAT's scenario would fail if BU created with S3 storage, FAB-767 should fix the issue
Given I created the following agency:
| Name   | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| PACAUM1 | agency.admin | PACAAM1      |streamlined_library,folders|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand     | Sub Brand | Product  |
| PACAARM1   | PACABRM10 | PACASBM10 | PACAPM10 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'PACAAM1'
And logged in with details of 'PACAUM1'
And created 'PACAP10' project
And created '/PACAF10' folder for project 'PACAP10'
And uploaded into project 'PACAP10' following files:
| FileName             | Path     |
| /files/Fish2-Ad.mov  | /PACAF10 |
And waited while transcoding is finished in folder '/PACAF10' on project 'PACAP10' files page
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Title    | Destination                 |
| automated test info    | PACAARM1       | PACABRM10 | PACASBM10 | PACAPM10 | PACACM10 | PACACNM10 | 12/14/2022   | HD 1080i 25fps | PACATM10 | GEO News:Standard |
And add to 'music' order item with isrc code 'PACACNM10' following file '/files/Fish2-Ad.mov' from folder '/PACAF10' of project 'PACAP10'
And complete order contains item with isrc code 'PACACNM10' with following fields:
| Job Number | PO Number |
| PACAJNM10  | PACAPNM10 |
When I go to asset 'Fish2-Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue                                  |
| Advertiser      | PACAARM1                                    |
| Product         | PACAPM10                                    |
| Title           | Fish2-Ad.mov                                |
| Media type      | video                                       |
| Media sub-type  | QC-ed master                                |
| Air Date        | 12/14/2022                                  |
| Duration        | 6s 33ms                                     |
And 'should' see following 'specification' fields on opened asset info pageNEWLIB:
| FieldName       | FieldValue                                  |
| Height          | 608                                         |
| Standard        | 720x576i@25fps                              |
| Width           | 720                                         |
| Aspect ratio    | 16x9                                        |
| Frame           | 25                                          |
| Encoding system | PAL                                         |
| Profile name    | Broadcast SD PAL 16x9 Program Stream master |



Scenario: Check that View Delivery Report is correctly opened for music
!--QA-396, ORD-1644, ORD-1651
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| PACAAM1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| PACAUM1 | agency.admin | PACAAM1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'PACAAM1':
| Advertiser | Brand     | Sub Brand | Product  |
| PACAARM1   | PACABRM11 | PACASBM11 | PACAPM11 |
And logged in with details of 'PACAUM1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Title    |  Destination                |
| automated test info    | PACAARM1       | PACABRM11 | PACASBM11 | PACAPM11 | PACACM11 | PACACNM11 | 12/14/2022   | HD 1080i 25fps | PACATM11 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'PACACNM11' with following fields:
| Job Number | PO Number |
| PACAJNM11  | PACAPNM11 |
When I go to Order Summary page for order contains item with following isrc code 'PACACNM11'
And I click ViewDeliveryReport button on the Order Summary Page
Then I should see that View 'Delivery' report opens for order with isrc code 'PACACNM11'