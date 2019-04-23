!--ORD-1240
!--ORD-1862
Feature: Additional Services section
Narrative:
In order to:
As a AgencyAdmin
I want to check additional services section

Scenario: Cleaning fields from Edit Destinations popup after cancel it
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
| OTVMASSCN22  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |
| Physical | OTVMASSDN22      | OTVMASSCnN22 | OTVMASSCD22     | OTVMASSSA22    | OTVMASSC22 | OTVMASSPC22 | OTVMASSC22 |
When I open order item with following clock number 'OTVMASSCN22'
And fill following fields for Additional Services section on order item page:
| Type     | Destination |
| Data DVD | OTVMASSDN22 |
And go to 'Edit' Destinations form of Additional Services section on order item page
And 'cancel' Edit Destination form of Additional Services section on order item page
And fill following fields for Additional Services section on order item page:
| Type     |
| Data DVD |
And click add destination link for Non Broadcast Destination group of Additional Services section on order item page
Then I should see following data for Add Physical Delivery Destination form of Additional Services section on order item page:
| Destination Name | Contact Name | Contact Details | Street Address | City | Post Code | Country |
|                  |              |                 |                |      |           |         |

Scenario: Cleaning fields from Edit Destinations popup after close it
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
| OTVMASSCN23  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |
| Physical | OTVMASSDN23      | OTVMASSCnN23 | OTVMASSCD23     | OTVMASSSA23    | OTVMASSC23 | OTVMASSPC23 | OTVMASSC23 |
When I open order item with following clock number 'OTVMASSCN23'
And fill following fields for Additional Services section on order item page:
| Type     | Destination |
| Data DVD | OTVMASSDN23 |
And go to 'Edit' Destinations form of Additional Services section on order item page
And 'close' Edit Destination form of Additional Services section on order item page
And fill following fields for Additional Services section on order item page:
| Type     |
| Data DVD |
And click add destination link for Non Broadcast Destination group of Additional Services section on order item page
Then I should see following data for Add Physical Delivery Destination form of Additional Services section on order item page:
| Destination Name | Contact Name | Contact Details | Street Address | City | Post Code | Country |
|                  |              |                 |                |      |           |         |

Scenario: Filling Delivery Details Textbox with Using nVerge Method
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
| OTVMASSCN24 |
When I open order item with following isrc code 'OTVMASSCN24'
And fill following fields for Additional Services section on order item page:
| Type        |
| nVerge Send |
And fill following fields for 'Add' nVerge Delivery Destination form of Additional Services section on order item page:
| Email       |
| nV_email_24 |
And add delivery destination for Additional Services section on order item page during 'Add' destination
And fill following fields for Additional Services section on order item page:
| Destination |
| nV_email_24 |
Then I should see following data for order item on Additional Services section:
| Type        | Delivery Details |
| nVerge Send | nV_email_24      |

Scenario: check that Destination list is alphabetically sorted
!--ORD-3698
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMASSA11 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU1N | agency.admin | OTVMASSA11   |
And logged in with details of 'OTVMASSU1N'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMASSCN25  |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |
| Physical | A_OTVMASSDN25_1  | OTVMASSCnN25 | OTVMASSCD25     | OTVMASSSA25    | OTVMASSC25 | OTVMASSPC25 | OTVMASSC25 |
| Physical | T_OTVMASSDN25_2  | OTVMASSCnN25 | OTVMASSCD25     | OTVMASSSA25    | OTVMASSC25 | OTVMASSPC25 | OTVMASSC25 |
| Physical | F_OTVMASSDN25_3  | OTVMASSCnN25 | OTVMASSCD25     | OTVMASSSA25    | OTVMASSC25 | OTVMASSPC25 | OTVMASSC25 |
| Physical | C_OTVMASSDN25_4  | OTVMASSCnN25 | OTVMASSCD25     | OTVMASSSA25    | OTVMASSC25 | OTVMASSPC25 | OTVMASSC25 |
When I open order item with following clock number 'OTVMASSCN25'
And fill following fields for Additional Services section on order item page:
| Type |
| DVD  |
Then I should see following destinations 'A_OTVMASSDN25_1,C_OTVMASSDN25_4,F_OTVMASSDN25_3,T_OTVMASSDN25_2' in Destination field of Additional Services section on order item page


Scenario: Check the type displayed for dubbing services under additional servcies section when the market is Australia and New Zealand
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |Labels|
| OTVMASSA30 | DefaultA4User |au,dubbing_services,nVerge,Physical,FTP,production_services |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU30 | agency.admin | OTVMASSA30    |
And logged in with details of 'OTVMASSU30'
And create 'tv' order with market 'Australia and New Zealand' and items with following fields:
| Clock Number |
| OTVSDOCN30    |
When I open order item with following clock number 'OTVSDOCN30'
Then I should see available following types '<AvailableTypes>' in Type field of Additional Services section on order item page for AU market

Examples:
| AvailableTypes      |
| FILE,PHYSICAL MEDIA |


Scenario: Check the format displayed for each type under dubbing services in additional services section when the market is Australia and New Zealand
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |Labels|
| OTVMASSA31 | DefaultA4User |au,dubbing_services,nVerge,Physical,FTP,production_services |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU32 | agency.admin | OTVMASSA31    |
And logged in with details of 'OTVMASSU32'
And create 'tv' order with market 'Australia and New Zealand' and items with following fields:
| Clock Number |
| OTVSDOCN32    |
When I open order item with following clock number 'OTVSDOCN32'
And fill following fields for Additional Services section on order item page for AU market:
| Type   |
| <Type> |
Then I should see available following formats '<AvailableFormats>' in Format field of Additional Services section on order item page for AU market

Examples:
| Type           | AvailableFormats                                              |
| FILE           | Prores,Uncompressed QT,QT (H264/MOV),Flv,mp4,DCP,webm,AVI,TGA |
| PHYSICAL MEDIA | HD CAM,Digital Betacam,USB/Hardrive,DVD                       |


Scenario: Check the type displayed for dubbing services under additional servcies section when the market is Australia
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |Labels|
| OTVMASSA35 | DefaultA4User |au,dubbing_services,nVerge,Physical,FTP,production_services |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU35 | agency.admin | OTVMASSA35    |
And logged in with details of 'OTVMASSU35'
And create 'tv' order with market 'Australia' and items with following fields:
| Clock Number |
| OTVSDOCN35    |
When I open order item with following clock number 'OTVSDOCN35'
Then I should see available following types '<AvailableTypes>' in Type field of Additional Services section on order item page for AU market

Examples:
| AvailableTypes      |
| FILE,PHYSICAL MEDIA |


Scenario: Check the format displayed for each type under dubbing services in additional services section when the market is Australia
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |Labels|
| OTVMASSA36 | DefaultA4User |au,dubbing_services,nVerge,Physical,FTP,production_services |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASSU36 | agency.admin | OTVMASSA36   |
And logged in with details of 'OTVMASSU36'
And create 'tv' order with market 'Australia' and items with following fields:
| Clock Number |
| OTVSDOCN36    |
When I open order item with following clock number 'OTVSDOCN36'
And fill following fields for Additional Services section on order item page for AU market:
| Type   |
| <Type> |
Then I should see available following formats '<AvailableFormats>' in Format field of Additional Services section on order item page for AU market

Examples:
| Type           | AvailableFormats                                              |
| FILE           | Prores,Uncompressed QT,QT (H264/MOV),Flv,mp4,DCP,webm,AVI,TGA |
| PHYSICAL MEDIA | HD CAM,Digital Betacam,USB/Hardrive,DVD                       |



Scenario: Check additional destination created for one market should only visible to that market and shouldn't visible to another market, NGN-16204
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMASSA37 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMASSU37 | agency.admin | OTVMASSA37   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA37':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMASSAR37 | OTVMASSBR37 | OTVMASSSB37 | OTVMASSPR37 |
And logged in with details of 'OTVMASSU37'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number    | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR37 | OTVMASSBR37 | OTVMASSSB37 | OTVMASSPR37 | OTVMASSC37 | <ClockNumber_1> | 20       | 08/14/2022     | HD 1080i 25fps |OTVMASST37 | None               | ABP News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | OTVMASSDN37      | OTVMASSCnN37 | OTVMASSCD37     | OTVMASSSA37    | OTVMASSC37 | OTVMASSPC37 | OTVMASSC37 | United Kingdom |
And create for 'tv' order with item clock number '<ClockNumber_1>' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                   | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN37  | Avid DNxHD | Same as Master | Compile 1     | 5          | OTVMASSDN37 OTVMASSCnN37 OTVMASSCD37 OTVMASSSA37 OTVMASSC37 OTVMASSPC37 OTVMASSC37 | automated test notes  | should     | should not |
When I open order item with following clock number '<ClockNumber_1>'
And click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number  | PO Number   |
| OTVMASSJN37 | OTVMASSPN37 |
And confirm order on Order Proceed page
And created 'tv' order with market '<Market>' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number    | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination   |
| automated test info    | OTVMASSAR37 | OTVMASSBR37 | OTVMASSSB37 | OTVMASSPR37 | OTVMASSC37 | <ClockNumber_2> | 20       | 08/14/2022     | HD 1080i 25fps |OTVMASST37 | None               | <Destination> |
And open order item with following clock number '<ClockNumber_2>'
And fill following fields for Additional Services section on order item page:
| Type     |
| Data DVD |
Then I '<shouldstate>' see available following destinations 'OTVMASSDN37' in Destination field of Additional Services section on order item page

Examples:
| ClockNumber_1 | ClockNumber_2 | Market         | Destination             | shouldstate |
| OTVMASSCN37_1 | OTVMASSCN37_2 | United Kingdom | ABP News:Standard       | should      |
| OTVMASSCN37_3 | OTVMASSCN37_4 | Spain          | Real Madrid TV:Standard | should not  |



Scenario: Check additional destination created in one BU shouldn't visible to another BU user, NGN-16204
Meta: @ordering
Given I created the following agency:
| Name         | A4User        |
| OTVMASSA38_1 | DefaultA4User |
| OTVMASSA38_2 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OTVMASSU38_1 | agency.admin | OTVMASSA38_1 |
| OTVMASSU38_2 | agency.admin | OTVMASSA38_2 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA38_1':
| Advertiser    | Brand         | Sub Brand     | Product       |
| OTVMASSAR38_1 | OTVMASSBR38_1 | OTVMASSSB38_1 | OTVMASSPR38_1 |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA38_2':
| Advertiser    | Brand         | Sub Brand     | Product       |
| OTVMASSAR38_2 | OTVMASSBR38_2 | OTVMASSSB38_2 | OTVMASSPR38_2 |
And logged in with details of 'OTVMASSU38_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser    | Brand         | Sub Brand     | Product       | Campaign     | Clock Number  | Duration | First Air Date | Format         | Title        | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR38_1 | OTVMASSBR38_1 | OTVMASSSB38_1 | OTVMASSPR38_1 | OTVMASSC38_1 | OTVMASSCN38_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST38_1 | None               | ABP News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | OTVMASSDN38      | OTVMASSCnN38 | OTVMASSCD38     | OTVMASSSA38    | OTVMASSC38 | OTVMASSPC38 | OTVMASSC38 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASSCN38_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                   | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN38  | Avid DNxHD | Same as Master | Compile 1     | 5          | OTVMASSDN38 OTVMASSCnN38 OTVMASSCD38 OTVMASSSA38 OTVMASSC38 OTVMASSPC38 OTVMASSC38 | automated test notes  | should     | should not |
When I open order item with following clock number 'OTVMASSCN38_1'
And click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number    | PO Number     |
| OTVMASSJN38_1 | OTVMASSPN38_1 |
And confirm order on Order Proceed page
And login with details of 'OTVMASSU38_2'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser    | Brand         | Sub Brand     | Product       | Campaign     | Clock Number  | Duration | First Air Date | Format         | Title        | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR38_2 | OTVMASSBR38_2 | OTVMASSSB38_2 | OTVMASSPR38_2 | OTVMASSC38_2 | OTVMASSCN38_2 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST38_2 | None               | ABP News:Standard |
And open order item with following clock number 'OTVMASSCN38_2'
And fill following fields for Additional Services section on order item page:
| Type     |
| Data DVD |
Then I 'should not' see available following destinations 'OTVMASSDN38' in Destination field of Additional Services section on order item page


Scenario: Check additional destinations should be available for all users in a BU, NGN-16204
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMASSA39 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OTVMASSU39_1 | agency.admin | OTVMASSA39   |
| OTVMASSU39_2 | agency.admin | OTVMASSA39   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA39':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMASSAR39 | OTVMASSBR39 | OTVMASSSB39 | OTVMASSPR39 |
And logged in with details of 'OTVMASSU39_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR39 | OTVMASSBR39 | OTVMASSSB39 | OTVMASSPR39 | OTVMASSC39 | OTVMASSCN39_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST39 | None               | ABP News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | OTVMASSDN39      | OTVMASSCnN39 | OTVMASSCD39     | OTVMASSSA39    | OTVMASSC39 | OTVMASSPC39 | OTVMASSC39 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASSCN39_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                   | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN39  | Avid DNxHD | Same as Master | Compile 1     | 5          | OTVMASSDN39 OTVMASSCnN39 OTVMASSCD39 OTVMASSSA39 OTVMASSC39 OTVMASSPC39 OTVMASSC39 | automated test notes  | should     | should not |
When I open order item with following clock number 'OTVMASSCN39_1'
And click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number  | PO Number   |
| OTVMASSJN39 | OTVMASSPN39 |
And confirm order on Order Proceed page
And login with details of 'OTVMASSU39_2'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR39 | OTVMASSBR39 | OTVMASSSB39 | OTVMASSPR39 | OTVMASSC39 | OTVMASSCN39_2 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST39 | None               | ABP News:Standard |
And open order item with following clock number 'OTVMASSCN39_2'
And fill following fields for Additional Services section on order item page:
| Type     |
| Data DVD |
Then I 'should' see available following destinations 'OTVMASSDN39' in Destination field of Additional Services section on order item page


Scenario: Check additional destination created for one type is available for other similar types, NGN-16204
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMASSA40 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OTVMASSU40_1 | agency.admin | OTVMASSA40   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA40':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMASSAR40 | OTVMASSBR40 | OTVMASSSB40 | OTVMASSPR40 |
And logged in with details of 'OTVMASSU40_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR40 | OTVMASSBR40 | OTVMASSSB40 | OTVMASSPR40 | OTVMASSC40 | OTVMASSCN40_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST40 | None               | ABP News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | OTVMASSDN40      | OTVMASSCnN40 | OTVMASSCD40     | OTVMASSSA40    | OTVMASSC40 | OTVMASSPC40 | OTVMASSC40 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASSCN40_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                   | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN40  | Avid DNxHD | Same as Master | Compile 1     | 5          | OTVMASSDN40 OTVMASSCnN40 OTVMASSCD40 OTVMASSSA40 OTVMASSC40 OTVMASSPC40 OTVMASSC40 | automated test notes  | should     | should not |
When I open order item with following clock number 'OTVMASSCN40_1'
And click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number  | PO Number   |
| OTVMASSJN40 | OTVMASSPN40 |
And confirm order on Order Proceed page
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination   |
| automated test info    | OTVMASSAR40 | OTVMASSBR40 | OTVMASSSB40 | OTVMASSPR40 | OTVMASSC40 | OTVMASSCN40_2 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST40 | None               | ABP News:Standard |
And open order item with following clock number 'OTVMASSCN40_2'
And fill following fields for Additional Services section on order item page:
| Type            |
| Data DVD        |
| DVD             |
| Tape            |
| USB Flash Drive |
Then I 'should' see available following destinations 'OTVMASSDN40' in Destination field of Additional Services section on order item page


Scenario: Check additional destination created for one type isn't available for other types, NGN-16204
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMASSA41 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OTVMASSU41_1 | agency.admin | OTVMASSA41   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA41':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMASSAR41 | OTVMASSBR41 | OTVMASSSB41 | OTVMASSPR41 |
And logged in with details of 'OTVMASSU41_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR41 | OTVMASSBR41 | OTVMASSSB41 | OTVMASSPR41 | OTVMASSC41 | OTVMASSCN41_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST41 | None               | ABP News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | OTVMASSDN41      | OTVMASSCnN41 | OTVMASSCD41     | OTVMASSSA41    | OTVMASSC41 | OTVMASSPC41 | OTVMASSC41 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASSCN41_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                   | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN41  | Avid DNxHD | Same as Master | Compile 1     | 5          | OTVMASSDN41 OTVMASSCnN41 OTVMASSCD41 OTVMASSSA41 OTVMASSC41 OTVMASSPC41 OTVMASSC41 | automated test notes  | should     | should not |
When I open order item with following clock number 'OTVMASSCN41_1'
And click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number  | PO Number   |
| OTVMASSJN41 | OTVMASSPN41 |
And confirm order on Order Proceed page
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination   |
| automated test info    | OTVMASSAR41 | OTVMASSBR41 | OTVMASSSB41 | OTVMASSPR41 | OTVMASSC41 | OTVMASSCN41_2 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST41 | None               | ABP News:Standard |
And open order item with following clock number 'OTVMASSCN41_2'
And fill following fields for Additional Services section on order item page:
| Type            |
| FTP Upload      |
| nVerge Send     |
| Generics Upload |
Then I 'should not' see available following destinations 'OTVMASSDN41' in Destination field of Additional Services section on order item page


Scenario: Check additional destination created for one type is available for other similar types across BU, NGN-16204
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMASSA42 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OTVMASSU42_1 | agency.admin | OTVMASSA42   |
| OTVMASSU42_2 | agency.admin | OTVMASSA42   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA42':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMASSAR42 | OTVMASSBR42 | OTVMASSSB42 | OTVMASSPR42 |
And logged in with details of 'OTVMASSU42_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR42 | OTVMASSBR42 | OTVMASSSB42 | OTVMASSPR42 | OTVMASSC42 | OTVMASSCN42_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST42 | None               | ABP News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | OTVMASSDN42      | OTVMASSCnN42 | OTVMASSCD42     | OTVMASSSA42    | OTVMASSC42 | OTVMASSPC42 | OTVMASSC42 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASSCN42_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                   | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN42  | Avid DNxHD | Same as Master | Compile 1     | 5          | OTVMASSDN42 OTVMASSCnN42 OTVMASSCD42 OTVMASSSA42 OTVMASSC42 OTVMASSPC42 OTVMASSC42 | automated test notes  | should     | should not |
When I open order item with following clock number 'OTVMASSCN42_1'
And click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number  | PO Number   |
| OTVMASSJN42 | OTVMASSPN42 |
And confirm order on Order Proceed page
And login with details of 'OTVMASSU42_2'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination   |
| automated test info    | OTVMASSAR42 | OTVMASSBR42 | OTVMASSSB42 | OTVMASSPR42 | OTVMASSC42 | OTVMASSCN42_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST42 | None               | ABP News:Standard |
And open order item with following clock number 'OTVMASSCN42_1'
And fill following fields for Additional Services section on order item page:
| Type            |
| Data DVD        |
| DVD             |
| Tape            |
| USB Flash Drive |
Then I 'should' see available following destinations 'OTVMASSDN42' in Destination field of Additional Services section on order item page



Scenario: Check additional destination created for one type isn't available for other BU's, NGN-16204
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMASSA43 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| OTVMASSU43_1 | agency.admin | OTVMASSA43   |
| OTVMASSU43_2 | agency.admin | OTVMASSA43   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASSA43':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMASSAR43 | OTVMASSBR43 | OTVMASSSB43 | OTVMASSPR43 |
And logged in with details of 'OTVMASSU43_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination       |
| automated test info    | OTVMASSAR43 | OTVMASSBR43 | OTVMASSSB43 | OTVMASSPR43 | OTVMASSC43 | OTVMASSCN43_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST43 | None               | ABP News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | OTVMASSDN43      | OTVMASSCnN43 | OTVMASSCD43     | OTVMASSSA43    | OTVMASSC43 | OTVMASSPC43 | OTVMASSC43 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASSCN43_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                   | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASSDN43  | Avid DNxHD | Same as Master | Compile 1     | 5          | OTVMASSDN43 OTVMASSCnN43 OTVMASSCD43 OTVMASSSA43 OTVMASSC43 OTVMASSPC43 OTVMASSC43 | automated test notes  | should     | should not |
When I open order item with following clock number 'OTVMASSCN43_1'
And click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number  | PO Number   |
| OTVMASSJN43 | OTVMASSPN43 |
And confirm order on Order Proceed page
And login with details of 'OTVMASSU43_2'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination   |
| automated test info    | OTVMASSAR43 | OTVMASSBR43 | OTVMASSSB43 | OTVMASSPR43 | OTVMASSC43 | OTVMASSCN43_2 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASST43 | None               | ABP News:Standard |
And open order item with following clock number 'OTVMASSCN43_2'
And fill following fields for Additional Services section on order item page:
| Type            |
| FTP Upload      |
| nVerge Send     |
| Generics Upload |
Then I 'should not' see available following destinations 'OTVMASSDN43' in Destination field of Additional Services section on order item page