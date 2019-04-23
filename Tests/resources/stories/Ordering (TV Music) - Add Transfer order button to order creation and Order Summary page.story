!--ORD-2618
!--ORD-3084
Feature: Add Transfer order button to order creation and order summary pages
Narrative:
In order to:
As a AgencyAdmin
I want to check transfer order button on an order creation and order summary pages

Scenario: check working transfer button on an order item page
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ATOBA1_1 | DefaultA4User |
| ATOBA1_2 | DefaultA4User |
And added agency 'ATOBA1_2' as a partner to agency 'ATOBA1_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| ATOBU1_1_email | agency.admin | ATOBA1_1     |
| ATOBU1_2_email | agency.admin | ATOBA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 |
And logged in with details of 'ATOBU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC1   | ATOBCN1      | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT1 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'ATOBCN1' a New Master with following fields:
| Supply Via | Assignee       | Already Supplied | Message        | Deadline Date |
| FTP        | ATOBU1_1_email | should not       | automated test | 12/14/2022    |
And add usage right 'General' for order contains item with clock number 'ATOBCN1' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City   | Post Code | Country |
| Physical | ATOBDN1          | ATOBCnN1     | ATOBCD1         | ATOBSA1        | ATOBC1 | ATOBPC1   | ATOBC1  |
And create for 'tv' order with item clock number 'ATOBCN1' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                       | Notes & Labels        | Express |
| Data DVD | ATOBDN1     | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | ATOBDN1 ATOBCnN1 ATOBCD1 ATOBSA1 ATOBC1 ATOBPC1 ATOBC1 | automated test notes  | should  |
When I open order item with following clock number 'ATOBCN1'
And fill following fields for Transfer Order form on order item page:
| Transfer to    | Message                   |
| ATOBU1_2_email | autotest transfer message |
And click Send button on Transfer Order form on order item page
Then I 'should not' see On Hold button on order item page
And 'should not' see Add Commercial button on order item page
And should see 'disabled' New master button for order item on Add media form
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form
And 'should not' see able to edit following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Campaign,Title,Duration,First Air Date,Format,Subtitles Required,Additional Information' for order item on Add information form
And should see 'active' Select Broadcast Destinations section on order item page
And should see 'inactive' QC & Ingest Only button on order item page
And should see 'disabled' following fields 'Type,Destination,Format,Specification,Media Compile,No copies,Delivery Details,Notes & Labels,Standard,Express' for order item on Additional Services section
And 'should not' see Proceed button on order item page

Scenario: check working transfer button on an order proceed page
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ATOBA1_1 | DefaultA4User |
| ATOBA1_2 | DefaultA4User |
And added agency 'ATOBA1_2' as a partner to agency 'ATOBA1_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| ATOBU1_1_email | agency.admin | ATOBA1_1     |
| ATOBU1_2_email | agency.admin | ATOBA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 |
And logged in with details of 'ATOBU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC2   | ATOBCN2      | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT2 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'ATOBCN2' a New Master with following fields:
| Supply Via | Assignee       | Already Supplied | Message        | Deadline Date |
| FTP        | ATOBU1_1_email | should not       | automated test | 12/14/2022    |
And add usage right 'General' for order contains item with clock number 'ATOBCN2' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City   | Post Code | Country |
| Physical | ATOBDN2          | ATOBCnN2     | ATOBCD2         | ATOBSA2        | ATOBC2 | ATOBPC2   | ATOBC2  |
And create for 'tv' order with item clock number 'ATOBCN2' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                       | Notes & Labels        | Express |
| Data DVD | ATOBDN2     | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | ATOBDN2 ATOBCnN2 ATOBCD2 ATOBSA2 ATOBC2 ATOBPC2 ATOBC2 | automated test notes  | should  |
When I go to Order Proceed page for order contains order item with following clock number 'ATOBCN2'
And fill following fields for Transfer Order form on Order Proceed page:
| Transfer to    | Message                   |
| ATOBU1_2_email | autotest transfer message |
And click Send button on Transfer Order form on Order Proceed page
Then I 'should not' see On Hold button on order item page
And 'should not' see Add Commercial button on order item page
And should see 'disabled' New master button for order item on Add media form
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form
And 'should not' see able to edit following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Campaign,Title,Duration,First Air Date,Format,Subtitles Required,Additional Information' for order item on Add information form
And should see 'active' Select Broadcast Destinations section on order item page
And should see 'inactive' QC & Ingest Only button on order item page
And should see 'disabled' following fields 'Type,Destination,Format,Specification,Media Compile,No copies,Delivery Details,Notes & Labels,Standard,Express' for order item on Additional Services section
And 'should not' see Proceed button on order item page

Scenario: check notification after transfering order on an order item page
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        |
| ATOBA1_1 | DefaultA4User |
| ATOBA1_2 | DefaultA4User |
And added agency 'ATOBA1_2' as a partner to agency 'ATOBA1_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| ATOBU1_1_email | agency.admin | ATOBA1_1     |
| ATOBU1_3_email | agency.admin | ATOBA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 |
And logged in with details of 'ATOBU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC3   | ATOBCN3      | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT3 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'ATOBCN3'
And fill following fields for Transfer Order form on order item page:
| Transfer to    | Message                   |
| ATOBU1_3_email | autotest transfer message |
And click Send button on Transfer Order form on order item page
Then I 'should' see email notification for 'Transfer Order' with field to 'ATOBU1_3_email' and subject 'An order has been transferred to you' contains following attributes:
| Agency   | Account Type | UserEmail      | Clock Number | Message                   |
| ATOBA1_1 | adstream     | ATOBU1_1_email | ATOBCN3      | autotest transfer message |

Scenario: check notification after transfering order on an order proceed page
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name     | A4User        |
| ATOBA1_1 | DefaultA4User |
| ATOBA1_2 | DefaultA4User |
And added agency 'ATOBA1_2' as a partner to agency 'ATOBA1_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| ATOBU1_1_email | agency.admin | ATOBA1_1     |
| ATOBU1_4_email | agency.admin | ATOBA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 |
And logged in with details of 'ATOBU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC4   | ATOBCN4      | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT4 | Already Supplied   | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'ATOBCN4'
And fill following fields for Transfer Order form on Order Proceed page:
| Transfer to    | Message                   |
| ATOBU1_4_email | autotest transfer message |
And click Send button on Transfer Order form on Order Proceed page
Then I 'should' see email notification for 'Transfer Order' with field to 'ATOBU1_4_email' and subject 'An order has been transferred to you' contains following attributes:
| Agency   | Account Type | UserEmail      | Clock Number | Message                   |
| ATOBA1_1 | adstream     | ATOBU1_1_email | ATOBCN4      | autotest transfer message |

Scenario: check working transfer button on an order item page for several items
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ATOBA1_1 | DefaultA4User |
| ATOBA1_2 | DefaultA4User |
And added agency 'ATOBA1_2' as a partner to agency 'ATOBA1_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| ATOBU1_1_email | agency.admin | ATOBA1_1     |
| ATOBU1_2_email | agency.admin | ATOBA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 |
And logged in with details of 'ATOBU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC5_1 | ATOBCN5_1    | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT5_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC5_2 | ATOBCN5_2    | 15       | 10/14/2022     | HD 1080i 25fps | ATOBT5_2 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'ATOBCN5_1' a New Master with following fields:
| Supply Via | Assignee       | Already Supplied | Message        | Deadline Date |
| FTP        | ATOBU1_1_email | should not       | automated test | 12/14/2022    |
And add for 'tv' order to item with clock number 'ATOBCN5_2' a New Master with following fields:
| Supply Via | Assignee       | Already Supplied | Message        | Deadline Date |
| FTP        | ATOBU1_1_email | should not       | automated test | 12/14/2022    |
And add usage right 'General' for order contains item with clock number 'ATOBCN5_1' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And add usage right 'General' for order contains item with clock number 'ATOBCN5_2' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City   | Post Code | Country |
| Physical | ATOBDN5          | ATOBCnN5     | ATOBCD5         | ATOBSA5        | ATOBC5 | ATOBPC5   | ATOBC5  |
And create for 'tv' order with item clock number 'ATOBCN5_1' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                       | Notes & Labels        | Express |
| Data DVD | ATOBDN5     | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | ATOBDN5 ATOBCnN5 ATOBCD5 ATOBSA5 ATOBC5 ATOBPC5 ATOBC5 | automated test notes  | should  |
And create for 'tv' order with item clock number 'ATOBCN5_2' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                       | Notes & Labels        | Standard |
| Data DVD | ATOBDN5     | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | ATOBDN5 ATOBCnN5 ATOBCD5 ATOBSA5 ATOBC5 ATOBPC5 ATOBC5 | automated test notes  | should   |
When I open order item with following clock number 'ATOBCN5_1'
And fill following fields for Transfer Order form on order item page:
| Transfer to    | Message                   |
| ATOBU1_2_email | autotest transfer message |
And click Send button on Transfer Order form on order item page
Then I 'should not' see On Hold button on order item page
And 'should not' see Add Commercial button on order item page
And should see 'disabled' New master button for order item on Add media form
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form
And 'should not' see able to edit following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Campaign,Title,Duration,First Air Date,Format,Subtitles Required,Additional Information' for order item on Add information form
And should see 'active' Select Broadcast Destinations section on order item page
And should see 'inactive' QC & Ingest Only button on order item page
And should see 'disabled' following fields 'Type,Destination,Format,Specification,Media Compile,No copies,Delivery Details,Notes & Labels,Standard,Express' for order item on Additional Services section
And 'should not' see Proceed button on order item page
When I select order item with following clock number 'ATOBCN5_1' on cover flow
Then I 'should not' see On Hold button on order item page
And 'should not' see Add Commercial button on order item page
And should see 'disabled' New master button for order item on Add media form
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form
And 'should not' see able to edit following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Campaign,Title,Duration,First Air Date,Format,Subtitles Required,Additional Information' for order item on Add information form
And should see 'active' Select Broadcast Destinations section on order item page
And should see 'inactive' QC & Ingest Only button on order item page
And should see 'disabled' following fields 'Type,Destination,Format,Specification,Media Compile,No copies,Delivery Details,Notes & Labels,Standard,Express' for order item on Additional Services section
And 'should not' see Proceed button on order item page

Scenario: check whole custom catalog structure after transfering
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ATOBA6_1 | DefaultA4User |
| ATOBA6_2 | DefaultA4User |
And added agency 'ATOBA6_2' as a partner to agency 'ATOBA6_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| ATOBU6_1_email | agency.admin | ATOBA6_1     |
| ATOBU6_2_email | agency.admin | ATOBA6_2     |
And created following 'common' custom metadata fields for agency 'ATOBA6_1':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency 'ATOBA6_1' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Product Custom  |
And logged in with details of 'ATOBU6_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | ATOBC6   | ATOBCN6      | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT6 | Already Supplied   |
When I open order item with following clock number 'ATOBCN6'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
| ATOBAR1           | ATOBBR1      | ATOBSB1          | ATOBPR1        |
And fill following fields for Transfer Order form on order item page:
| Transfer to    | Message                   |
| ATOBU6_2_email | autotest transfer message |
And click Send button on Transfer Order form on order item page
Then I should see following read-only 'common' data for order item on Add information form:
| Additional Information | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | ATOBC6   | ATOBCN6      | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT6 | Already Supplied   |
And should see following read-only 'custom' data for order item on Add information form:
| Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
| ATOBAR1           | ATOBBR1      | ATOBSB1          | ATOBPR1        |

Scenario: check transfering after adding QC asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ATOBA1_1 | DefaultA4User |
| ATOBA1_2 | DefaultA4User |
And added agency 'ATOBA1_2' as a partner to agency 'ATOBA1_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| ATOBU1_1_email | agency.admin | ATOBA1_1     |
| ATOBU1_2_email | agency.admin | ATOBA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 |
And logged in with details of 'ATOBU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC7_1 | ATOBCN7_1    | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT7_1 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ATOBCN7_1' with following fields:
| Job Number | PO Number |
| ATOBJN7    | ATOBPN7   |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| ATOBCN7_2    |
And add to 'tv' order item with clock number 'ATOBCN7_2' following qc asset 'ATOBT7_1' of collection 'My Assets'
When I open order item with clock number 'ATOBCN7_1' for order with market 'Republic of Ireland'
And wait for '1' seconds
And fill following fields for Transfer Order form on order item page:
| Transfer to    | Message                   |
| ATOBU1_2_email | autotest transfer message |
And click Send button on Transfer Order form on order item page
Then I should see following read-only 'common' data for order item on Add information form:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format      | Title    | Subtitles Required |
|                        | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC7_1 | ATOBCN7_1    | 20       | 10/14/2022     | SD PAL 16x9 | ATOBT7_1 | Already Supplied   |

Scenario: check data after transfering order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| ATOBA1_1 | DefaultA4User |
| ATOBA1_2 | DefaultA4User |
And added agency 'ATOBA1_2' as a partner to agency 'ATOBA1_1'
And created users with following fields:
| Email          | Role         | AgencyUnique |
| ATOBU1_1_email | agency.admin | ATOBA1_1     |
| ATOBU1_2_email | agency.admin | ATOBA1_2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ATOBA1_1':
| Advertiser | Brand   | Sub Brand | Product |
| ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 |
And logged in with details of 'ATOBU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC8   | ATOBCN8      | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT8 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'ATOBCN8' a New Master with following fields:
| Supply Via | Assignee       | Already Supplied | Message        | Deadline Date |
| FTP        | ATOBU1_1_email | should not       | automated test | 12/14/2022    |
And add usage right 'General' for order contains item with clock number 'ATOBCN8' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City   | Post Code | Country |
| Physical | ATOBDN8          | ATOBCnN8     | ATOBCD8         | ATOBSA8        | ATOBC8 | ATOBPC8   | ATOBC8  |
And create for 'tv' order with item clock number 'ATOBCN8' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                       | Notes & Labels        | Express |
| Data DVD | ATOBDN8     | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | ATOBDN8 ATOBCnN8 ATOBCD8 ATOBSA8 ATOBC8 ATOBPC8 ATOBC8 | automated test notes  | should  |
When I open order item with following clock number 'ATOBCN8'
And fill following fields for Transfer Order form on order item page:
| Transfer to    | Message                   |
| ATOBU1_2_email | autotest transfer message |
And click Send button on Transfer Order form on order item page
And wait for '3' seconds
And login with details of 'ATOBU1_2_email'
And open order item with following clock number 'ATOBCN8'
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee       | Already Supplied | Message        | Deadline Date |
| ATOBU1_1_email | should not       | automated test | 12/14/2022    |
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required |
| automated test info    | ATOBAR1    | ATOBBR1 | ATOBSB1   | ATOBPR1 | ATOBC8   | ATOBCN8      | 20       | 10/14/2022     | HD 1080i 25fps | ATOBT8 | Already Supplied   |
And should see following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard           |
| BSkyB Green Button |
And should see following data for order item on Additional Services section:
| Type     | Format     | Specification | Media Compile | No copies  | Delivery Details                                       | Notes & Labels        | Express |
| Data DVD | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | ATOBDN8 ATOBCnN8 ATOBCD8 ATOBSA8 ATOBC8 ATOBPC8 ATOBC8 | automated test notes  | should  |