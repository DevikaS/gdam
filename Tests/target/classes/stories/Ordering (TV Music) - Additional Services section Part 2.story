!--ORD-1240
!--ORD-1862
Feature: Additional Services section
Narrative:
In order to:
As a AgencyAdmin
I want to check additional services section

Scenario: Deleting Destinations
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN12  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City       | Post Code   | Country    |
| Physical | OTVMASSDN12      | OTVMASSCnN12 | OTVMASSSA12    | OTVMASSC12 | OTVMASSPC12 | OTVMASSC12 |
When I open order item with following clock number 'OTVMASSCN12'
And fill following fields for Additional Services section on order item page:
| Type | Destination |
| DVD  | OTVMASSDN12 |
And go to 'Edit' Destinations form of Additional Services section on order item page
And delete destination on Edit Destinations form of Additional Services section on order item page
Then I 'should not' see available following destinations 'OTVMASSDN12' in Destination field of Additional Services section on order item page

Scenario: Expanded Additional Services sections
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN13  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City       | Post Code   | Country    |
| Physical | OTVMASSDN13      | OTVMASSCnN13 | OTVMASSSA13    | OTVMASSC13 | OTVMASSPC13 | OTVMASSC13 |
When I open order item with following clock number 'OTVMASSCN13'
And fill following fields for Additional Services section on order item page:
| Type     | Destination | Format     | Specification  | Media Compile | No copies | Notes & Labels       | Standard |
| Data DVD | OTVMASSDN13 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2         | automated test notes | should   |
And 'copy current' order item by Add Commercial button on order item page
Then I 'should' see expanded following sections 'Additional Services' on order item page

Scenario: Popups for different methods
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN14  |
And create additional destinations with following fields:
| Type     | Destination Name |
| Physical | OTVMASSDN14      |
When I open order item with following clock number 'OTVMASSCN14'
And fill following fields for Additional Services section on order item page:
| Type     | Destination |
| Data DVD | OTVMASSDN14 |
And fill following fields for Additional Services section on order item page:
| Type       |
| FTP Upload |
And click add destination link for Non Broadcast Destination group of Additional Services section on order item page
Then I should see 'Add FTP delivery destination' form on Additional Services section of order item page

Scenario: Limitation for Additional Services destinations
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN16  |
When I open order item with following clock number 'OTVMASSCN16'
And add '9' new Non Broadcast Destination groups for Additional Services section on order item page
And add new Non Broadcast Destination group for Additional Services section on order item page
Then I should see '10' Non Broadcast Destination groups for Additional Services section on order item page

Scenario: check correcting order fields on Order Summary page after confirming
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASSAR9 | OTVMASSBR9 | OTVMASSSB9 | OTVMASSPR9 |
And on the global 'common custom' metadata page for agency 'OTVMASSA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVMASSAR9 | OTVMASSBR9 | OTVMASSSB9 | OTVMASSPR9 | OTVMASSC17 | OTVMASSCN17  | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST17 | Already Supplied   | GEO News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City       | Post Code   | Country    |
| Physical | OTVMASSDN17      | OTVMASSCnN17 | OTVMASSSA17    | OTVMASSC17 | OTVMASSPC17 | OTVMASSC17 |
And create for 'tv' order with item clock number 'OTVMASSCN17' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                       | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN17 | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASSDN17 OTVMASSCnN17 OTVMASSSA17 OTVMASSC17 OTVMASSPC17 OTVMASSC17 | automated test notes  | should     | should not |
And complete order contains item with clock number 'OTVMASSCN17' with following fields:
| Job Number  | PO Number   |
| OTVMASSJN17 | OTVMASSPN17 |
When I go to Order Summary page for order contains item with following clock number 'OTVMASSCN17'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Product    | Title      | First Air Date | Format         | Duration | Status        | Approve |
| OTVMASSCN17  | OTVMASSAR9 | OTVMASSPR9 | OTVMASST17 | 08/14/22       | HD 1080i 25fps | 20       | 0/2 Delivered |         |

Scenario: Additional Services destinations after proceeding order and coming back
!--NGN-19470 QC&Ingest step is added
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASSAR9 | OTVMASSBR9 | OTVMASSSB9 | OTVMASSPR9 |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required |
| automated test info    | OTVMASSAR9 | OTVMASSBR9 | OTVMASSSB9 | OTVMASSPR9 | OTVMASSC18 | OTVMASSCN18  | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST18 | Already Supplied   |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name   | Street Address | City         | Post Code     | Country      |
| Physical | OTVMASSDN18_1    | OTVMASSCnN18_1 | OTVMASSSA18_1  | OTVMASSC18_1 | OTVMASSPC18_1 | OTVMASSC18_1 |
| Physical | OTVMASSDN18_2    | OTVMASSCnN18_2 | OTVMASSSA18_2  | OTVMASSC18_2 | OTVMASSPC18_2 | OTVMASSC18_2 |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVMASSCN18'
When I open order item with following clock number 'OTVMASSCN18'
And fill following fields for Additional Services section on order item page:
| Type     | Destination   | Format     | Specification  | Media Compile | No copies | Notes & Labels         | Standard   | Express    |
| Data DVD | OTVMASSDN18_1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2         | automated test notes 1 | should     | should not |
| DVD      | OTVMASSDN18_2 | Auto-loop  | SD PAL 16x9    | Compile 1     | 1         | automated test notes 2 | should not | should     |
And click Proceed button on order item page
And back to order item page from Order Proceed page
Then I should see following data for order item on Additional Services section:
| Type     | Destination   | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                   | Notes & Labels         | Standard  | Express    |
| Data DVD | OTVMASSDN18_1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2          | OTVMASSDN18_1 OTVMASSCnN18_1 OTVMASSSA18_1 OTVMASSC18_1 OTVMASSPC18_1 OTVMASSC18_1 | automated test notes 1 | should    | should not |
| DVD      | OTVMASSDN18_2 | Auto-loop  | SD PAL 16x9    | Compile 1     | 1          | OTVMASSDN18_2 OTVMASSCnN18_2 OTVMASSSA18_2 OTVMASSC18_2 OTVMASSPC18_2 OTVMASSC18_2 | automated test notes 2 | should not| should     |

Scenario: check only Destination Name in the Delivery Details field
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code   |
| OTVMASSCN19 |
When I open order item with following isrc code 'OTVMASSCN19'
And fill following fields for Additional Services section on order item page:
| Type     |
| Data DVD |
And fill following fields for 'Add' Physical Delivery Destination form of Additional Services section on order item page:
| Destination Name |
| OTVMASSDN19      |
And add delivery destination for Additional Services section on order item page during 'Add' destination
And fill following fields for Additional Services section on order item page:
| Destination |
| OTVMASSDN19 |
Then I should see following data for order item on Additional Services section:
| Type     | Delivery Details |
| Data DVD | OTVMASSDN19      |

Scenario: Update data for destination
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN20  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name   | Contact Details | Street Address | City         | Post Code     | Country      |
| Physical | OTVMASSDN20      | OTVMASSCnN20_1 | OTVMASSCD20_1   | OTVMASSSA20_1  | OTVMASSC20_1 | OTVMASSPC20_1 | OTVMASSC20_1 |
When I open order item with following clock number 'OTVMASSCN20'
And fill following fields for Additional Services section on order item page:
| Type     | Destination |
| Data DVD | OTVMASSDN20 |
And fill following fields for 'Edit' Physical Delivery Destination form of Additional Services section on order item page:
| Contact Name   | Contact Details | Street Address | City         | Post Code     | Country      |
| OTVMASSCnN20_2 | OTVMASSCD20_2   | OTVMASSSA20_2  | OTVMASSC20_2 | OTVMASSPC20_2 | OTVMASSC20_2 |
And add delivery destination for Additional Services section on order item page during 'Edit' destination
Then I should see following data for order item on Additional Services section:
| Type     | Destination | Delivery Details                                                                               |
| Data DVD | OTVMASSDN20 | OTVMASSDN20 OTVMASSCnN20_2 OTVMASSCD20_2 OTVMASSSA20_2 OTVMASSC20_2 OTVMASSPC20_2 OTVMASSC20_2 |

Scenario: Pulling field Format on the Additional Services section
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1 | agency.admin | OTVMASSA1    |
And logged in with details of 'OTVMASSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN21  |
When I open order item with following clock number 'OTVMASSCN21'
And fill following fields for Additional Services section on order item page:
| Type   |
| <Type> |
Then I should see available following formats '<AvailableFormats>' in Format field of Additional Services section on order item page

Examples:
| Type        | AvailableFormats                                                                                                                                         |
| Data DVD    | Uncompressed Quicktime,Apple ProRes422 HQ,Avid DNxHD,MPEG-1,Quicktime H264                                                                               |
| DVD         | No menu - straight play,Auto-loop,Authored with menu                                                                                                     |
| FTP Upload  | Quicktime (Presentation),WMV (Presention),JPEG 300dpi,MPEG-2 DVD Quality,JPEG 72dpi,MPEG-1 (Presentation),Quicktime (Broadcast),MPEG-2 Broadcast Quality |
| nVerge Send | DVC Pro 50,Uncompressed master,Targa Sequence                                                                                                            |
| Tape        | Digital Betacam,MiniDV,VHS,SP Betacam,DVC Pro 25,DVC Pro 50,DVCam,HDCam,U-Matic,Betacam SX,D1,DCT,D5 Standard,HDV,D2,S-VHS,Hi-8,Digital-8                |

