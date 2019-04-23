!--ORD-1449
!--ORD-1636
!--ORD-4314
Feature: Reports for Draft Orders
Narrative:
In order to:
As a AgencyAdmin
I want to check reports for draft orders

Scenario: Created report with filled subtitles and checked held for approval button for TV order
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVRDOA1'
And on the global 'common custom' metadata page for agency 'OTVRDOA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVRDOU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And hold for approval active order item on cover flow
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required |
| automated test info    | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC1 | OTVRDOCN1    | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT1 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard               |
| Bangla TV              |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OTVRDOJN1  | OTVRDOPN1 |
And save as draft order on Order Proceed page
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group      | Destination          | Service Level |
| OTVRDOCN1    | OTVRDOJN1  | OTVRDOPN1 | 1                 | 1                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT1 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 1               | ZMTV                   | Bangla TV            | Standard      |

Scenario: Created report with new master and attached file for TV order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And logged in with details of 'OTVRDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC2 | OTVRDOCN2    | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT2 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'OTVRDOCN2' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | OTVRDOU1 | should not       | automated test | 12/14/2024    |
And upload to 'tv' order item with clock number 'OTVRDOCN2' following documents:
| Document          |
| /files/file_2.txt |
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Logo     | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| ADSTREAM | OTVRDOCN2    |            |           | 1                 | 1                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT2 | 20       | HD 1080i 25fps | FTP             | 12/14/2024    | 12/14/2022     | No      | automated test info | file_2.txt  | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |

Scenario: Created report with checked button Hold for approval for Music order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And logged in with details of 'OTVRDOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Title    | Destination                 |
| automated test info    | OTVRDOAR1      | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC3 | OTVRDOCN3 | 12/14/2022   | HD 1080i 25fps | OTVRDOT3 | BSkyB Green Button:Standard |
And hold for approval 'music' order items with following isrc codes 'OTVRDOCN3'
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title    | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Delivery Points | Destination Group | Destination        | Service Level |
| OTVRDOCN3    |            |           | 1                 | 1                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT3 | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | 1               | BSkyB             | BSkyB Green Button | Standard      |

Scenario: Created report with property QC and Ingest only for Music order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And logged in with details of 'OTVRDOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | ISRC Code   | Release Date | Format         | Title    |
| automated test info    | OTVRDOAR1      | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOCN4_1 | 12/14/2022   | HD 1080i 25fps | OTVRDOT4 |
And enable QC & Ingest Only for 'music' order for item with following isrc code 'OTVRDOCN4_1'
When I open order item with following isrc code 'OTVRDOCN4_1'
And fill following fields for Add information form on order item page:
| ISRC Code   | Artist   |
| OTVRDOCN4_2 | OTVRDOC4 |
And click Proceed button on order item page
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title    | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Delivery Points |
| OTVRDOCN4_2  |            |           | 1                 | 1                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT4 | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | 0               |

Scenario: Created report with different property for assets for TV order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And logged in with details of 'OTVRDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC5_1 | OTVRDOCN5_1  | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT5_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC5_2 | OTVRDOCN5_2  | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT5_2 | Already Supplied   |                             |
And hold for approval 'tv' order items with following clock numbers 'OTVRDOCN5_1'
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVRDOCN5_2'
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title      | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| OTVRDOCN5_1  |            |           | 2                 | 1                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT5_1 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |
And should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title      | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points |
| OTVRDOCN5_2  |            |           | 2                 | 2                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT5_2 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 0               |

Scenario: Generated report with using Copy to all property for order items
!--ORD-1646
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And logged in with details of 'OTVRDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC6_1 | OTVRDOCN6_1  | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT6_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC6_2 | OTVRDOCN6_2  | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT6_2 | Adtext             |                             |
When I open order item with following clock number 'OTVRDOCN6_1'
And copy data from 'Select Broadcast Destinations' section of order item page to all other items
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title      | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| OTVRDOCN6_1  |            |           | 2                 | 1                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT6_1 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |
And should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title      | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| OTVRDOCN6_2  |            |           | 2                 | 2                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT6_2 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | Adtext             | 1               | BSkyB             | BSkyB Green Button | Standard      |

Scenario: Generated report with using Copy to all is properly for order items on the Add information section
!--ORD-1652
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And logged in with details of 'OTVRDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required |
| automated test info    | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC7_1 | OTVRDOCN7_1  | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT7_1 | Already Supplied   |
|                        |            |           |           |          |            | OTVRDOCN7_2  |          |                |                |            |                    |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVRDOCN7_1'
When I open order item with following clock number 'OTVRDOCN7_1'
And copy data from 'Add information,Select Broadcast Destinations' sections of order item page to all other items
And select '2' order item with following clock number 'OTVRDOCN7_1' on cover flow
And fill following fields for Add information form on order item page:
| Clock Number | Campaign   |
| OTVRDOCN7_2  | OTVRDOC7_2 |
And refresh the page without delay
And click Proceed button on order item page
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title      | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points |
| OTVRDOCN7_1  |            |           | 2                 | 1                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT7_1 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 0               |
And should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title      | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points |
| OTVRDOCN7_2  |            |           | 2                 | 2                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT7_1 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | Already Supplied   | 0               |

Scenario: Check metadatas in draft order confirmation report
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And logged in with details of 'OTVRDOU1'
And create 'tv' order with market 'Switzerland' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Suisa    | Language | Destination        |
| automated test info    | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC8 | OTVRDOCN8    | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT8 | OTVRDOS8 | English  | Tele Top:Standard  |
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country     | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Suisa    | Language Metadata | Delivery Points | Destination Group | Destination | Service Level |
| OTVRDOCN8    |            |           | 1                 | 1                 | Switzerland | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT8 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info |             | OTVRDOS8 | English           | 1               | Switzerlan        | Tele Top    | Standard      |

Scenario: Check that new market specific fields added per market and per agency with values are displayed on Order Confirmation report
!--ORD-4498
Meta: @ordering
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name     | A4User        |
| OTVRDOA9 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU9 | agency.admin | OTVRDOA9     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA9':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR9  | OTVRDOBR9 | OTVRDOSB9 | OTVRDOP9 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'OTVRDOA9'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Date' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Date' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Multiline' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Multiline' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Phone' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Phone' on opened Settings and Customization tab
And saved metadata field settings
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description | AddOnFly | MultipleChoices | Descendants |
| Dropdown    | should   | should          | drop1,drop2 |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description         | Descendants | AddOnFly | MultipleChoices |
| Catalogue Structure | cat1,cat2   | should   | should          |
And clicked 'Address' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Address' on opened Settings and Customization tab
And saved metadata field settings
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   | Descendants |
| Radio Buttons | t1,t2       |
And clicked 'Hyperlink' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Hyperlink' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'OTVRDOU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVRDOAR9  | OTVRDOBR9 | OTVRDOSB9 | OTVRDOP9 | OTVRDOC9 | OTVRDOCN9    | 20       | 10/14/2022     | HD 1080i 25fps | OTVRDOT9 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVRDOCN9'
And fill following custom fields for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |
And click Proceed button on order item page
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title    | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level | Catalogue Structure                                 | Dropdown | Multiline       | Phone  | Radio Buttons | String       |
| OTVRDOCN9    |            |           | 1                 | 1                 | United Kingdom | OTVRDOAR9  | OTVRDOBR9 | OTVRDOSB9 | OTVRDOP9 | OTVRDOT9 | 20       | HD 1080i 25fps |                 |               | 10/14/2022     | No      | automated test info |             | Already Supplied   | 1               | ZMTV             | Aastha | Standard      | Catalogue Structure catalog,cat1 value1,cat2 value2 | drop1    | multiline-value | 666666 | t2            | string-value |

Scenario: Check that remapped Product catalogue structure is correctly displayed on Order Confirmation report
!--ORD-4326
Meta: @ordering
      @skip
!--13/11 - NGN-17036
!--Can't see this as a high priority.
!--   Not many people would want to create a new custom field and use that for advertiser/product in delivery, instead of available default one.
!--   Also, with A4 decomission, we are going to get rid of the In Delivery flag, and will use only honest fields from Common schema: https://jira.adstream.com/browse/NGN-17037.
!--   So it makes sense to remove this test and close this bug as Won't Be Fixed

Given I created the following agency:
| Name      | A4User        |
| OTVRDOA10 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVRDOU10 | agency.admin | OTVRDOA10    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA10':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVRDOAR10 | OTVRDOBR10 | OTVRDOSB10 | OTVRDOP10 |
And logged in with details of 'OTVRDOU10'
And I am on the global 'common custom' metadata page for agency 'OTVRDOA10'
And clicked 'Catalogue Structure' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Product Custom' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And checked 'Add values on the fly' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVRDOAR10 | OTVRDOBR10 | OTVRDOSB10 | OTVRDOP10 | OTVRDOC10 | OTVRDOCN10   | 20       | 10/14/2022     | HD 1080i 25fps | OTVRDOT10 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVRDOCN10'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Product Custom |
| OTVRDOP10_2    |
And click Proceed button on order item page
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand      | Sub Brand  | Product Custom | Title     | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| OTVRDOCN10   |            |           | 1                 | 1                 | United Kingdom | OTVRDOAR10 | OTVRDOBR10 | OTVRDOSB10 | OTVRDOP10_2    | OTVRDOT10 | 20       | HD 1080i 25fps |                 |               | 10/14/2022     | No      | automated test info |             | Already Supplied   | 1               | ZMTV             | Aastha | Standard      |

Scenario: Check that logo of BU takes from Branding settings on Order Confirmation report
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVRDOA11 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVRDOU11 | agency.admin | OTVRDOA11    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA11':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVRDOAR11 | OTVRDOBR11 | OTVRDOSB11 | OTVRDOP11 |
And logged in with details of 'OTVRDOU11'
And I am on the system branding page
And uploaded logo '/images/logo.jpeg' on system branding page
And clicked save on the system branding page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVRDOAR11 | OTVRDOBR11 | OTVRDOSB11 | OTVRDOP11 | OTVRDOC11 | OTVRDOCN11   | 20       | 10/14/2022     | HD 1080i 25fps | OTVRDOT11 | Already Supplied   | BSkyB Green Button:Standard |
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Logo | Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand      | Sub Brand  | Product   | Title     | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| JPEG | OTVRDOCN11   |            |           | 1                 | 1                 | United Kingdom | OTVRDOAR11 | OTVRDOBR11 | OTVRDOSB11 | OTVRDOP11 | OTVRDOT11 | 20       | HD 1080i 25fps |                 |               | 10/14/2022     | No      | automated test info |             | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |

Scenario: Check draft order report with different files
!--ORD-4314
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVRDOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVRDOU1 | agency.admin | OTVRDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVRDOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 |
And logged in with details of 'OTVRDOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                  |
| automated test info 1  | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC12_1 | OTVRDOCN12_1 | 20       | 12/14/2022     | HD 1080i 25fps | OTVRDOT12_1 | Already Supplied   | BSkyB Green Button:Standard  |
| automated test info 2  | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOC12_2 | OTVRDOCN12_2 | 15       | 12/14/2024     | HD 1080i 25fps | OTVRDOT12_2 | Already Supplied   | Overseas Property TV:Express |
And upload to 'tv' order item with clock number 'OTVRDOCN12_1' following documents:
| Document          |
| /files/filetext.txt |
And upload to 'tv' order item with clock number 'OTVRDOCN12_2' following documents:
| Document          |
| /files/file_2.txt |
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title       | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                  | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level |
| OTVRDOCN12_1 |            |           | 2                 | 1                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT12_1 | 20       | HD 1080i 25fps |                 |               | 12/14/2022     | No      | automated test info 1 | filetext.txt  | Already Supplied   | 1               | BSkyB             | BSkyB Green Button | Standard      |
And should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand     | Sub Brand | Product  | Title       | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                  | Attachments | Subtitles Required | Delivery Points | Destination Group  | Destination          | Service Level |
| OTVRDOCN12_2 |            |           | 2                 | 2                 | United Kingdom | OTVRDOAR1  | OTVRDOBR1 | OTVRDOSB1 | OTVRDOP1 | OTVRDOT12_2 | 15       | HD 1080i 25fps |                 |               | 12/14/2024     | No      | automated test info 2 | file_2.txt  | Already Supplied   | 1               | Other Broadcasters | Overseas Property TV | Express       |