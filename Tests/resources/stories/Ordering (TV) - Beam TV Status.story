!--ORD-1566
!--ORD-1921
Feature: Beam TV Status API
Narrative:
In order to:
As a AgencyAdmin
I want to check correct Beam TV Status API

Scenario: check correct data are returned for Beam agency
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVBTVSA1 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU1 | agency.admin | OTVBTVSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR1 | OTVBTVSBR1 | OTVBTVSSB1 | OTVBTVSP1 |
And logged in with details of 'OTVBTVSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVBTVSAR1 | OTVBTVSBR1 | OTVBTVSSB1 | OTVBTVSP1 | OTVBTVSC1 | OTVBTVSCN1   | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST1 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OTVBTVSCN1' a New Master with following fields:
| Supply Via | Assignee  | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| FTP        | OTVBTVSU2 | OTVBTVSU1  | should not       | automated test | 12/14/2024    | 20:00        |
And hold for approval 'tv' order items with following clock numbers 'OTVBTVSCN1'
And complete order contains item with clock number 'OTVBTVSCN1' with following fields:
| Job Number | PO Number  |
| OTVBTVSJN1 | OTVBTVSPN1 |
And waited for '5' seconds
Then I should see Beam TV clock of market 'United Kingdom' for date filter begins from 'Yesterday' with following data:
| ClockNumber | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline         | Format         | Title     | Duration | Delivery Method | Status       | Subtitling | Date             | First Air Date | Job Number | PO Number  | Ingest Only | On Hold |
| OTVBTVSCN1  | Dijit           | GBR     | OTVBTVSAR1 | OTVBTVSBR1 | OTVBTVSSB1 | OTVBTVSU1      | Standard      | 12/14/2024 20:00 | HD 1080i 25fps | OTVBTVST1 | 20       | FTP             | Order Placed | Adtext     | StatusChangeDate | 12/14/2022     | OTVBTVSJN1 | OTVBTVSPN1 | should not  | should  |

Scenario: check that data is not retuned for not Beam agency
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVBTVSA2 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU2 | agency.admin | OTVBTVSA2    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA2':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR2 | OTVBTVSBR2 | OTVBTVSSB2 | OTVBTVSP2 |
And logged in with details of 'OTVBTVSU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVBTVSAR2 | OTVBTVSBR2 | OTVBTVSSB2 | OTVBTVSP2 | OTVBTVSC2 | OTVBTVSCN2   | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST2 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OTVBTVSCN2' a New Master with following fields:
| Supply Via | Assignee  | Post House | Already Supplied | Message        | Deadline Date |
| FTP        | OTVBTVSU2 | OTVBTVSU1  | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number 'OTVBTVSCN2' with following fields:
| Job Number | PO Number  |
| OTVBTVSJN2 | OTVBTVSPN2 |
Then I 'should not' see Beam TV clock 'OTVBTVSCN2' for date filter begins from 'Yesterday'

Scenario: check correct data are returned for Beam agency when QC Ingest only enabled for clock
!--NGN-17579: BEAM response changed based on Feature request in 5.5.15
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User             | Country        | SAP ID   |
| OTVBTVSA1 | Beam   | DefaultA4User      | United Kingdom | BMTest02 |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU1 | agency.admin | OTVBTVSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR3 | OTVBTVSBR3 | OTVBTVSSB3 | OTVBTVSP3 |
And logged in with details of 'OTVBTVSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required |
| automated test info    | OTVBTVSAR3 | OTVBTVSBR3 | OTVBTVSSB3 | OTVBTVSP3 | OTVBTVSC3 | OTVBTVSCN3   | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST3 | Adtext             |
And add for 'tv' order to item with clock number 'OTVBTVSCN3' a New Master with following fields:
| Supply Via | Assignee  | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| Physical   | OTVBTVSU2 | OTVBTVSU1  | should not       | automated test | 12/14/2024    | 20:00        |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVBTVSCN3'
And complete order contains item with clock number 'OTVBTVSCN3' with following fields:
| Job Number | PO Number  |
| OTVBTVSJN3 | OTVBTVSPN3 |
And waited for '5' seconds
Then I should see Beam TV clock of market 'United Kingdom' for date filter begins from 'Yesterday' with following data:
| ClockNumber | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline         | Format         | Title     | Duration | Delivery Method | Status       | Subtitling | Date             | First Air Date | Job Number | PO Number  | Ingest Only | On Hold    |
| OTVBTVSCN3  | Dijit           | GBR     | OTVBTVSAR3 | OTVBTVSBR3 | OTVBTVSSB3 | OTVBTVSU1      |               | 12/14/2024 20:00 | HD 1080i 25fps | OTVBTVST3 | 20       | Tape            | Order Placed | Adtext     | StatusChangeDate | 12/14/2022     | OTVBTVSJN3 | OTVBTVSPN3 | should      | should not |

Scenario: check correct data are returned for Beam agency for clock with Non Broadcast Destinations items
!--NGN-17579: BEAM response changed based on Feature request in 5.5.15
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVBTVSA1 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU1 | agency.admin | OTVBTVSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR4 | OTVBTVSBR4 | OTVBTVSSB4 | OTVBTVSP4 |
And logged in with details of 'OTVBTVSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required |
| automated test info    | OTVBTVSAR4 | OTVBTVSBR4 | OTVBTVSSB4 | OTVBTVSP4 | OTVBTVSC4 | OTVBTVSCN4   | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST4 | Adtext             |
And add for 'tv' order to item with clock number 'OTVBTVSCN4' a New Master with following fields:
| Supply Via | Assignee  | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| Physical   | OTVBTVSU2 | OTVBTVSU1  | should not       | automated test | 12/14/2024    | 20:00        |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City      | Post Code  | Country   |
| Physical | OTVBTVSDN4       | OTVBTVSCnN4  | OTVBTVSCD4      | OTVBTVSSA4     | OTVBTVSC4 | OTVBTVSPC4 | OTVBTVSC4 |
And create for 'tv' order with item clock number 'OTVBTVSCN4' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                            | Notes & Labels        | Express |
| Data DVD | OTVBTVSDN4  | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVBTVSDN4 OTVBTVSCnN4 OTVBTVSCD4 OTVBTVSSA4 OTVBTVSC4 OTVBTVSPC4 OTVBTVSC4 | automated test notes  | should  |
And complete order contains item with clock number 'OTVBTVSCN4' with following fields:
| Job Number | PO Number  |
| OTVBTVSJN4 | OTVBTVSPN4 |
And waited for '5' seconds
Then I should see Beam TV clock of market 'United Kingdom' for date filter begins from 'Yesterday' with following data:
| ClockNumber | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline         | Format         | Title     | Duration | Delivery Method | Status       | Subtitling | Date             | First Air Date | Job Number | PO Number  | Ingest Only | On Hold    |
| OTVBTVSCN4  | Dijit           | GBR     | OTVBTVSAR4 | OTVBTVSBR4 | OTVBTVSSB4 | OTVBTVSU1      | Express       | 12/14/2024 20:00 | HD 1080i 25fps | OTVBTVST4 | 20       | Tape            | Order Placed | Adtext     | StatusChangeDate | 12/14/2022     | OTVBTVSJN4 | OTVBTVSPN4 | should not  | should not |

Scenario: Check that correct data is returned for Beam Agency into status field if asset with uploaded video has been retrieved from Library
!--FAB-417 - bug logged
!--NGN-17579: BEAM response changed based on Feature request in 5.5.15
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVBTVSA1 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVBTVS_U5 | agency.admin | OTVBTVSA1    |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR5 | OTVBTVSBR5 | OTVBTVSSB5 | OTVBTVSP5 |
And logged in with details of 'OTVBTVS_U5'
And I am on the Library page for collection 'My Assets'NEWLIB
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish1-Ad.mov'NEWLIB
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVBTVSAR5 | OTVBTVSBR5 | OTVBTVSSB5 | OTVBTVSP5 | OTVBTVSC5 | OTVBTVSCN5   | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST5 | Adtext             | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'OTVBTVSCN5' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And complete order contains item with clock number 'OTVBTVSCN5' with following fields:
| Job Number | PO Number  |
| OTVBTVSJN5 | OTVBTVSPN5 |
And waited for '5' seconds
Then I should see Beam TV clock of market 'United Kingdom' for date filter begins from 'Yesterday' with following data:
| ClockNumber | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline | Format         | Title        | Duration | Delivery Method | Status         | Subtitling | Date             | First Air Date | Job Number | PO Number  | Ingest Only | On Hold    |
| OTVBTVSCN5  | Dijit           | GBR     | OTVBTVSAR5 | OTVBTVSBR5 | OTVBTVSSB5 |                | Standard      |          | HD 1080i 25fps | Fish1-Ad.mov | 6s 33ms  | From Library    | Received Media | Adtext     | StatusChangeDate | 12/14/2022     | OTVBTVSJN5 | OTVBTVSPN5 | should not  | should not |

Scenario: Check that correct data is returned for Beam Agency into status field if asset with uploaded video has been retrieved from Projects
!--NGN-17579: BEAM response changed based on Feature request in 5.5.15
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVBTVSA1 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU1 | agency.admin | OTVBTVSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR6 | OTVBTVSBR6 | OTVBTVSSB6 | OTVBTVSP6 |
And logged in with details of 'OTVBTVSU1'
And waited for '2' seconds
And created new project with following fields:
| FieldName          | FieldValue        |
| Name               | OTVBTVSP6         |
| Advertiser         | OTVBTVSAR6        |
| Brand              | OTVBTVSBR6        |
| Sub Brand          | OTVBTVSSB6        |
| Product            | OTVBTVSP6         |
| Media type         | Broadcast        |
| Start date         | Today            |
| End date           | Tomorrow         |
And created '/OTVBTVSF6' folder for project 'OTVBTVSP6'
And uploaded into project 'OTVBTVSP6' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /OTVBTVSF6 |
And waited while transcoding is finished in folder '/OTVBTVSF6' on project 'OTVBTVSP6' files page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVBTVSAR6 | OTVBTVSBR6 | OTVBTVSSB6 | OTVBTVSP6 | OTVBTVSC6 | OTVBTVSCN6   | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST6 | Adtext             | BSkyB Green Button:Standard |
And add to 'tv' order item with clock number 'OTVBTVSCN6' following file '/files/Fish1-Ad.mov' from folder '/OTVBTVSF6' of project 'OTVBTVSP6'
And complete order contains item with clock number 'OTVBTVSCN6' with following fields:
| Job Number | PO Number  |
| OTVBTVSJN6 | OTVBTVSPN6 |
And waited for '5' seconds
Then I should see Beam TV clock of market 'United Kingdom' for date filter begins from 'Yesterday' with following data:
| ClockNumber | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline | Format         | Title        | Duration | Delivery Method | Status         | Subtitling | Date             | First Air Date | Job Number | PO Number  | Ingest Only | On Hold    |
| OTVBTVSCN6  | Dijit           | GBR     | OTVBTVSAR6 | OTVBTVSBR6 | OTVBTVSSB6 |                | Standard      |          | HD 1080i 25fps | Fish1-Ad.mov | 6s 33ms  | From Projects   | Received Media | Adtext     | StatusChangeDate | 12/14/2022     | OTVBTVSJN6 | OTVBTVSPN6 | should not  | should not |

Scenario: Format definition in API should return manually entered Format under Add Information section for new asset
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVBTVSA1 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU1 | agency.admin | OTVBTVSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR7 | OTVBTVSBR7 | OTVBTVSSB7 | OTVBTVSP7 |
And logged in with details of 'OTVBTVSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVBTVSAR7 | OTVBTVSBR7 | OTVBTVSSB7 | OTVBTVSP7 | OTVBTVSC7 | OTVBTVSCN7   | 20       | 12/14/2022     |        | OTVBTVST7 | Adtext             | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OTVBTVSCN7' a New Master with following fields:
| Supply Via | Assignee  | Post House | Already Supplied | Message        | Deadline Date | Arrival Time |
| FTP        | OTVBTVSU1 | OTVBTVSU1  | should not       | automated test | 12/14/2024    | 20:00        |
And hold for approval 'tv' order items with following clock numbers 'OTVBTVSCN7'
And complete order contains item with clock number 'OTVBTVSCN7' with following fields:
| Job Number | PO Number  |
| OTVBTVSJN7 | OTVBTVSPN7 |
And waited for '5' seconds
Then I should see Beam TV clock of market 'United Kingdom' for date filter begins from 'Yesterday' with following data:
| ClockNumber | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline         | Format | Title     | Duration | Delivery Method | Status       | Subtitling | Date             | First Air Date | Job Number | PO Number  | Ingest Only | On Hold |
| OTVBTVSCN7  | Dijit           | GBR     | OTVBTVSAR7 | OTVBTVSBR7 | OTVBTVSSB7 | OTVBTVSU1      | Standard      | 12/14/2024 20:00 |        | OTVBTVST7 | 20       | FTP             | Order Placed | Adtext     | StatusChangeDate | 12/14/2022     | OTVBTVSJN7 | OTVBTVSPN7 | should not  | should  |

Scenario: Format definition in API should return manually entered Format under Add Information section for retrieved from library qc-ed asset
!--NGN-17579: BEAM response changed based on Feature request in 5.5.15
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVBTVSA1 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU1 | agency.admin | OTVBTVSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR8 | OTVBTVSBR8 | OTVBTVSSB8 | OTVBTVSP8 |
And logged in with details of 'OTVBTVSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVBTVSAR8 | OTVBTVSBR8 | OTVBTVSSB8 | OTVBTVSP8 | OTVBTVSC8 | OTVBTVSCN8_1N | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST8 | Adtext SD          | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number | Destination               |
| OTVBTVSCN8_2 | Universal Ireland:Express |
And complete order contains item with clock number 'OTVBTVSCN8_1N' with following fields:
| Job Number   | PO Number    |
| OTVBTVSJN8_1 | OTVBTVSPN8_1 |
And waited for '10' seconds
And hold for approval 'tv' order items with following clock numbers 'OTVBTVSCN8_2'
And add to 'tv' order item with clock number 'OTVBTVSCN8_2' following qc asset 'OTVBTVST8' of collection 'My Assets'
And complete order with market 'Republic of Ireland' with following fields:
| Job Number   | PO Number    |
| OTVBTVSJN8_2 | OTVBTVSPN8_2 |
And waited for '20' seconds
Then I should see Beam TV clock of market 'Republic of Ireland' for date filter begins from 'Yesterday' with following data:
| ClockNumber  | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline | Format      | Title     | Duration | Delivery Method | Status       | Subtitling       | Date             | First Air Date | Job Number   | PO Number    | Ingest Only | On Hold |
| OTVBTVSCN8_1 | Dijit           | IRL     | OTVBTVSAR8 | OTVBTVSBR8 | OTVBTVSSB8 |                | Express       |          | SD PAL 16x9 | OTVBTVST8 | 20       | From Library    | Order Placed | Already Supplied | StatusChangeDate | 12/14/2022     | OTVBTVSJN8_2 | OTVBTVSPN8_2 | should not  | should  |

Scenario: Check that approving onHold order item modifies date update
Meta: @ordering
Given I created the following agency:
| Name      | Labels | A4User        |
| OTVBTVSA1 | Beam   | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVBTVSU1 | agency.admin | OTVBTVSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVBTVSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVBTVSAR9 | OTVBTVSBR9 | OTVBTVSSB9 | OTVBTVSP9 |
And logged in with details of 'OTVBTVSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVBTVSAR9 | OTVBTVSBR9 | OTVBTVSSB9 | OTVBTVSP9 | OTVBTVSC9 | OTVBTVSCN9   | 20       | 12/14/2022     | HD 1080i 25fps | OTVBTVST9 | Adtext             | BSkyB Green Button:Standard |
And hold for approval 'tv' order items with following clock numbers 'OTVBTVSCN9'
And waited for '5' seconds
And complete order contains item with clock number 'OTVBTVSCN9' with following fields:
| Job Number | PO Number  |
| OTVBTVSJN9 | OTVBTVSPN9 |
And approve 'tv' order items with following clock numbers 'OTVBTVSCN9'
Then I should see Beam TV clock of market 'United Kingdom' for date filter begins from 'Yesterday' with following data:
| ClockNumber | Order Reference | Country | Advertiser | Brand      | Product    | Master Held At | Service Level | Deadline | Format         | Title     | Duration | Delivery Method | Status       | Subtitling | Date             | First Air Date | Job Number | PO Number  |  Ingest Only | On Hold    |
| OTVBTVSCN9  | Dijit           | GBR     | OTVBTVSAR9 | OTVBTVSBR9 | OTVBTVSSB9 |                | Standard      |          | HD 1080i 25fps | OTVBTVST9 | 20       |                 | Order Placed | Adtext     | StatusChangeDate | 12/14/2022     | OTVBTVSJN9 | OTVBTVSPN9 |  should not  | should not |