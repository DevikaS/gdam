!--ORD-1462
!--ORD-2073
Feature: Email notifications for Subtitling
Narrative:
In order to:
As a AgencyAdmin
I want to check email notifications for subtitiling

Scenario: Email notification with Select Broadcast Destination section and with file
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name      | A4User        |
| OTVENFSA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | OTVENFSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVENFSA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     | Subtitles Required  | Destination                 |
| automated test info    | OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 | OTVENFSC1 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVENFST1 | <SubtitlesRequired> | BSkyB Green Button:Standard |
And upload to 'tv' order item with clock number '<ClockNumber>' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number  |
| OTVENFSJN1 | OTVENFSPN1 |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVENFSAR1 | United Kingdom | OTVENFSPN1 | OTVENFSJN1 | 1        | 0/1 Delivered |
And 'should' see email notification for 'Subtitles Required' with field to '<UserEmail>' and subject '<ClockNumber>' contains following attributes:
| Agency    | Clock Number  | Advertiser | Product    | Title     | Subtitles Required  | Service Level | Message             |
| OTVENFSA1 | <ClockNumber> | OTVENFSAR1 | OTVENFSPR1 | OTVENFST1 | <SubtitlesRequired> | Standard      | automated test info |

Examples:
| UserEmail   | ClockNumber  | SubtitlesRequired |
| OTVENFSU1_1 | OTVENFSCN1_1 | Adtext SD         |
| OTVENFSU1_2 | OTVENFSCN1_2 | BTI Studios       |

Scenario: Email notification with Select Broadcast Destination section and without file
Meta: @ordering
      @obug
      @orderingemails
!--FAB-479 both examples will fail
Given I created the following agency:
| Name      | A4User        |
| OTVENFSA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | agency.admin | OTVENFSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVENFSA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     | Subtitles Required  | Destination                 |
| automated test info    | OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 | OTVENFSC2 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVENFST2 | <SubtitlesRequired> | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number  |
| OTVENFSJN2 | OTVENFSPN2 |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVENFSAR1 | United Kingdom | OTVENFSPN2 | OTVENFSJN2 | 1        | 0/1 Delivered |
And 'should' see email notification for 'Subtitles Required' with field to '<UserEmail>' and subject '<ClockNumber>' contains following attributes:
| Agency    | Clock Number  | Advertiser | Product    | Title     |  Subtitles Required  | Service Level | Message             |
| OTVENFSA1 | <ClockNumber> | OTVENFSAR1 | OTVENFSPR1 | OTVENFST2 |  <SubtitlesRequired> | Standard      | automated test info |

Examples:
| UserEmail   | ClockNumber  | SubtitlesRequired |
| OTVENFSU2_1 | OTVENFSCN2_1 | Adtext            |
| OTVENFSU2_2 | OTVENFSCN2_2 | BTI Studios       |

Scenario: Email notification with Additional Services section and with file
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @obug
      @orderingemails
!--FAB-479
Given I created the following agency:
| Name      | A4User        |
| OTVENFSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVENFSU3 | agency.user  | OTVENFSA1    |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVENFSA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 |
And on the global 'common custom' metadata page for agency 'OTVENFSA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVENFSU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required  |
| automated test info    | OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 | OTVENFSC3 | OTVENFSCN3   | 20       | 08/14/2022     | HD 1080i 25fps | OTVENFST3 | Adtext              |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City      | Post Code  | Country   |
| Physical | OTVENFSDN3       | OTVENFSCnN3  | OTVENFSSA3     | OTVENFSC3 | OTVENFSPC3 | OTVENFSC3 |
And create for 'tv' order with item clock number 'OTVENFSCN3' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Express |
| Data DVD | OTVENFSDN3  | Avid DNxHD | HD 1080i 25fps | Compile 1     | 1          | OTVENFSDN3 OTVENFSCnN3 OTVENFSSA3 OTVENFSC3 OTVENFSPC3 OTVENFSC3 | automated test notes  | should  |
And upload to 'tv' order item with clock number 'OTVENFSCN3' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'OTVENFSCN3' with following fields:
| Job Number | PO Number  |
| OTVENFSJN3 | OTVENFSPN3 |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVENFSAR1 | United Kingdom | OTVENFSPN3 | OTVENFSJN3 | 1        | 0/1 Delivered |
And 'should' see email notification for 'Subtitles Required' with field to 'OTVENFSU3' and subject 'OTVENFSCN3' contains following attributes:
| Agency    | Clock Number | Advertiser | Product    | Title     | Subtitles Required | Service Level | Message             |
| OTVENFSA1 | OTVENFSCN3   | OTVENFSAR1 | OTVENFSPR1 | OTVENFST3 | Adtext             | Express       | automated test info |

Scenario: check email notifications for different order items with different Subtitles Required
Meta: @ordering
      @obug
      @orderingemails
!--FAB-479
Given I created the following agency:
| Name      | A4User        |
| OTVENFSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVENFSU4 | agency.admin | OTVENFSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVENFSA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 |
And logged in with details of 'OTVENFSU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required  | Destination                 |
| automated test info 1  | OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 | OTVENFSC4_1 | OTVENFSCN4_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVENFST4_1 | Adtext              |                             |
| automated test info 2  | OTVENFSAR1 | OTVENFSBR1 | OTVENFSSB1 | OTVENFSPR1 | OTVENFSC4_2 | OTVENFSCN4_2 | 20       | 10/14/2022     | SD PAL 16x9    | OTVENFST4_2 | BTI Studios         | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Street Address | City      | Post Code  | Country   |
| Physical | OTVENFSDN4       | OTVENFSCnN4  | OTVENFSSA4     | OTVENFSC4 | OTVENFSPC4 | OTVENFSC4 |
And create for 'tv' order with item clock number 'OTVENFSCN4_1' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Standard |
| Data DVD | OTVENFSDN4  | Avid DNxHD | HD 1080i 25fps | Compile 1     | 1          | OTVENFSDN4 OTVENFSCnN4 OTVENFSSA4 OTVENFSC4 OTVENFSPC4 OTVENFSC4 | automated test notes  | should   |
And create for 'tv' order with item clock number 'OTVENFSCN4_2' additional services with following fields:
| Type     | Destination | Format | Specification  | Media Compile | No copies  | Delivery Details                                                 | Notes & Labels        | Express |
| Data DVD | OTVENFSDN4  | MPEG-1 | Same as Master | Compile 2     | 2          | OTVENFSDN4 OTVENFSCnN4 OTVENFSSA4 OTVENFSC4 OTVENFSPC4 OTVENFSC4 | automated test notes  | should  |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVENFSCN4_1'
And upload to 'tv' order item with clock number 'OTVENFSCN4_1' following documents:
| Document          |
| /files/file_2.txt |
And upload to 'tv' order item with clock number 'OTVENFSCN4_2' following documents:
| Document          |
| /files/file_2.txt |
And complete order contains item with clock number 'OTVENFSCN4_1' with following fields:
| Job Number | PO Number  |
| OTVENFSJN4 | OTVENFSPN4 |
And I am on View Live Orders tab of 'tv' order on ordering page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVENFSAR1 | United Kingdom | OTVENFSPN4 | OTVENFSJN4 | 2        | 0/2 Delivered |
And 'should' see email notification for 'Subtitles Required' with field to 'OTVENFSU4' and subject 'OTVENFSCN4_1' contains following attributes:
| Agency    | Clock Number | Advertiser | Product    | Title       | Subtitles Required | Service Level | Message               |
| OTVENFSA1 | OTVENFSCN4_1 | OTVENFSAR1 | OTVENFSPR1 | OTVENFST4_1 | Adtext             | Standard      | automated test info 1 |
And 'should' see email notification for 'Subtitles Required' with field to 'OTVENFSU4' and subject 'OTVENFSCN4_2' contains following attributes:
| Agency    | Clock Number | Advertiser | Product    | Title       | Subtitles Required | Service Level | Message               |
| OTVENFSA1 | OTVENFSCN4_2 | OTVENFSAR1 | OTVENFSPR1 | OTVENFST4_2 | BTI Studios        | Express       | automated test info 2 |