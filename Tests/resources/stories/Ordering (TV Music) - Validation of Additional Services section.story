!--ORD-1240
!--ORD-1862
Feature: Validation of Additional Services section
Narrative:
In order to:
As a AgencyAdmin
I want to check validation of additional services section

Scenario: Validation for destinadion FTP popup (fill exist destination)
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMVASSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMVASSU1 | agency.admin | OTVMVASSA1   |
And logged in with details of 'OTVMVASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMVASSCN1  |
And create additional destinations with following fields:
| Type | FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path    |
| FTP  | OTVMVASSFDN1         | OTVMVASSFHN1  | OTVMVASSFUN1  | OTVMVASSFP1  | OTVMVASSFP1 |
When I open order item with following clock number 'OTVMVASSCN1'
And fill following fields for Additional Services section on order item page:
| Type       |
| FTP Upload |
And fill following fields for 'Add' FTP Delivery Destination form of Additional Services section on order item page:
| FTP Destination Name |
| OTVMVASSFDN1         |
Then I should see 'inactive' Add button for Add delivery destination form of Additional Services section on order item page

Scenario: Validation for destinadion Physical popup (fill exist destination)
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMVASSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMVASSU1 | agency.admin | OTVMVASSA1   |
And logged in with details of 'OTVMVASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City       | Post Code   | Country    |
| Physical | <Destination>    | OTVMVASSCnN2 | OTVMVASSSA2    | OTVMVASSC2 | OTVMVASSPC2 | OTVMVASSC2 |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for Additional Services section on order item page:
| Type   |
| <Type> |
And fill following fields for 'Add' Physical Delivery Destination form of Additional Services section on order item page:
| Destination Name |
| <Destination>    |
Then I should see 'inactive' Add button for Add delivery destination form of Additional Services section on order item page

Examples:
| ClockNumber   | Type     | Destination   |
| OTVMVASSCN2_1 | Data DVD | OTVMVASSDN2_1 |
| OTVMVASSCN2_2 | DVD      | OTVMVASSDN2_2 |
| OTVMVASSCN2_3 | Tape     | OTVMVASSDN2_3 |

Scenario: Validation for field No copies
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMVASSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMVASSU1 | agency.admin | OTVMVASSA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMVASSA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMVASSAR3 | OTVMVASSBR3 | OTVMVASSSB3 | OTVMVASSPR3 |
And logged in with details of 'OTVMVASSU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand       | Sub Brand   | Label       | Artist     | ISRC Code  | Release Date | Format         | Title      | Destination                 |
| automated test info    | OTVMVASSAR3    | OTVMVASSBR3 | OTVMVASSSB3 | OTVMVASSPR3 | OTVMVASSC3 | <ISRCCode> | 08/14/2022   | HD 1080i 25fps | OTVMVASST3 | BSkyB Green Button:Standard |
When I open order item with following isrc code '<ISRCCode>'
And fill following fields for Additional Services section on order item page:
| Type       | No copies  |
| FTP Upload | <NoCopies> |
And click inactive Proceed button on order item page
Then I 'should' see validation error for following fields 'No copies' of Additional Services section on order item page

Examples:
| ISRCCode      | NoCopies |
| OTVMVASSCN3_1 | one      |
| OTVMVASSCN3_2 | 1/1      |
| OTVMVASSCN3_3 | #2       |
| OTVMVASSCN3_4 | №2      |

Scenario: Validation for Additional Services section
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMVASSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMVASSU1 | agency.admin | OTVMVASSA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMVASSA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMVASSAR3 | OTVMVASSBR3 | OTVMVASSSB3 | OTVMVASSPR3 |
And logged in with details of 'OTVMVASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Destination                 |
| automated test info    | OTVMVASSAR3 | OTVMVASSBR3 | OTVMVASSSB3 | OTVMVASSPR3 | OTVMVASSC4 | OTVMVASSCN4  | 20       | 08/14/2022     | HD 1080i 25fps | OTVMVASST4 | BSkyB Green Button:Standard |
When I open order item with following clock number 'OTVMVASSCN4'
And fill following fields for Additional Services section on order item page:
| Type       | No copies |
| FTP Upload | one       |
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Additional Services'

Scenario: Validation for Additional Services section fields
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMVASSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMVASSU1 | agency.admin | OTVMVASSA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMVASSA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMVASSAR3 | OTVMVASSBR3 | OTVMVASSSB3 | OTVMVASSPR3 |
And logged in with details of 'OTVMVASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Destination                 |
| automated test info    | OTVMVASSAR3 | OTVMVASSBR3 | OTVMVASSSB3 | OTVMVASSPR3 | OTVMVASSC5 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVMVASST5 | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type | FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path    |
| FTP  | OTVMVASSFDN5         | OTVMVASSFHN5  | OTVMVASSFUN5  | OTVMVASSFP5  | OTVMVASSFP5 |
And create for 'tv' order with item clock number '<ClockNumber>' additional services with following fields:
| Type   | Destination   | Format   | Specification   | Media Compile  | No copies  | Delivery Details  | Notes & Labels | Standard   |
| <Type> | <Destination> | <Format> | <Specification> | <MediaCompile> | <NoCopies> | <DeliveryDetails> | <NotesLabels>  | <Standard> |
When I open order item with following clock number '<ClockNumber>'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Additional Services'
And 'should' see validation error for following fields '<ValidationFields>' of Additional Services section on order item page

Examples:
| ClockNumber   | Type       | Destination  | Format     | Specification  | MediaCompile | NoCopies | DeliveryDetails                                                | NotesLabels          | Standard   | ValidationFields                                    |
| OTVMVASSCN5_1 | FTP Upload | OTVMVASSFDN5 | JPEG 72dpi | HD 1080i 25fps | Compile 2    | 1        | OTVMVASSFDN5 OTVMVASSFHN5 OTVMVASSFUN5 OTVMVASSFP5 OTVMVASSFP5 | automated test notes | should not | Standard                                            |
| OTVMVASSCN5_2 | FTP Upload | OTVMVASSFDN5 | JPEG 72dpi | HD 1080i 25fps | Compile 2    |          | OTVMVASSFDN5 OTVMVASSFHN5 OTVMVASSFUN5 OTVMVASSFP5 OTVMVASSFP5 | automated test notes | should     | No copies                                           |
| OTVMVASSCN5_3 | FTP Upload | OTVMVASSFDN5 | JPEG 72dpi |                | Compile 2    | 1        | OTVMVASSFDN5 OTVMVASSFHN5 OTVMVASSFUN5 OTVMVASSFP5 OTVMVASSFP5 | automated test notes | should     | Specification                                       |
| OTVMVASSCN5_4 | FTP Upload | OTVMVASSFDN5 |            | HD 1080i 25fps | Compile 2    | 1        | OTVMVASSFDN5 OTVMVASSFHN5 OTVMVASSFUN5 OTVMVASSFP5 OTVMVASSFP5 | automated test notes | should     | Format                                              |
| OTVMVASSCN5_5 | FTP Upload |              | JPEG 72dpi | HD 1080i 25fps | Compile 2    | 1        |                                                                | automated test notes | should     | Destination                                         |
| OTVMVASSCN5_6 | FTP Upload |              |            |                |              |          |                                                                |                      | should not | Destination,Format,Specification,No copies,Standard |

Scenario: Validation without Compile and Notes Labels fields for Additional Services section
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMVASSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMVASSU1 | agency.admin | OTVMVASSA1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMVASSA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMVASSAR3 | OTVMVASSBR3 | OTVMVASSSB3 | OTVMVASSPR3 |
And logged in with details of 'OTVMVASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVMVASSAR3 | OTVMVASSBR3 | OTVMVASSSB3 | OTVMVASSPR3 | OTVMVASSC6 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVMVASST6 | Already Supplied   | Aastha:Standard |
And create additional destinations with following fields:
| Type | FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path    |
| FTP  | OTVMVASSFDN6         | OTVMVASSFHN6  | OTVMVASSFUN6  | OTVMVASSFP6  | OTVMVASSFP6 |
And create for 'tv' order with item clock number '<ClockNumber>' additional services with following fields:
| Type   | Destination   | Format   | Specification   | Media Compile  | No copies  | Delivery Details  | Notes & Labels | Standard   |
| <Type> | <Destination> | <Format> | <Specification> | <MediaCompile> | <NoCopies> | <DeliveryDetails> | <NotesLabels>  | <Standard> |
When I open order item with following clock number '<ClockNumber>'
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Examples:
| ClockNumber   | Type       | Destination  | Format     | Specification  | MediaCompile | NoCopies | DeliveryDetails                                                | NotesLabels          | Standard |
| OTVMVASSCN6_1 | FTP Upload | OTVMVASSFDN6 | JPEG 72dpi | HD 1080i 25fps |              | 1        | OTVMVASSFDN6 OTVMVASSFHN6 OTVMVASSFUN6 OTVMVASSFP6 OTVMVASSFP6 | automated test notes | should   |
| OTVMVASSCN6_1 | FTP Upload | OTVMVASSFDN6 | JPEG 72dpi | HD 1080i 25fps | Compile 2    | 1        | OTVMVASSFDN6 OTVMVASSFHN6 OTVMVASSFUN6 OTVMVASSFP6 OTVMVASSFP6 |                      | should   |
| OTVMVASSCN6_1 | FTP Upload | OTVMVASSFDN6 | JPEG 72dpi | HD 1080i 25fps |              | 1        | OTVMVASSFDN6 OTVMVASSFHN6 OTVMVASSFUN6 OTVMVASSFP6 OTVMVASSFP6 |                      | should   |

Scenario: Validation for Destination Name field
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMVASSA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMVASSU1 | agency.admin | OTVMVASSA1   |
And logged in with details of 'OTVMVASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMVASSCN7  |
When I open order item with following clock number 'OTVMVASSCN7'
And fill following fields for Additional Services section on order item page:
| Type     |
| Data DVD |
And fill following fields for 'Add' Physical Delivery Destination form of Additional Services section on order item page:
| Contact Name | Street Address | City       | Post Code   | Country    |
| OTVMVASSCnN7 | OTVMVASSSA7    | OTVMVASSC7 | OTVMVASSPC7 | OTVMVASSC7 |
Then I should see 'inactive' Add button for Add delivery destination form of Additional Services section on order item page