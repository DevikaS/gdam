!--ORD-278
!--ORD-1099
Feature: Validate order after clicking on Proceed button
Narrative:
In order to:
As a AgencyAdmin
I want to check correct validate order after clicking on Proceed button

Scenario: Proceed button is always enabled
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And logged in with details of 'OTVVPOU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
Then I should see 'enabled' Proceed button on order item page

Scenario: No complete/incomplete icons are shown on the cover flow and on sections
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And logged in with details of 'OTVVPOU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
Then I 'should not' see warning icon next active cover flow item
And 'should not' see warning icon next following sections 'Add information,Select Broadcast Destinations'

Scenario: Proceed button is blue
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVVPOAR3  | OTVVPOBR3 | OTVVPOSB3 | OTVVPOP3 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR3 | OTVVPOSB3 | OTVVPOP3 | OTVVPOC3 | OTVVPOCN3    | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT3 | BSkyB Green Button:Standard |
When I open order item with following clock number 'OTVVPOCN3'
Then I should see 'enabled' Proceed button on order item page

Scenario: User is redirected to order proceed page
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVVPOAR3  | OTVVPOBR4 | OTVVPOSB4 | OTVVPOP4 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR4 | OTVVPOSB4 | OTVVPOP4 | OTVVPOC4 | OTVVPOCN4    | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT4 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVVPOCN4'
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Proceed button with QC & Ingest Only (successful flow)
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVVPOAR3  | OTVVPOBR5 | OTVVPOSB5 | OTVVPOP5 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required |
| automated test info    | OTVVPOAR3  | OTVVPOBR5 | OTVVPOSB5 | OTVVPOP5 | OTVVPOC5 | OTVVPOCN5    | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT5 | Already Supplied   |
When I open order item with following clock number 'OTVVPOCN5'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Proceed button with QC & Ingest Only (unsuccessful flow, empty mandatory fields)
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And logged in with details of 'OTVVPOU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click inactive Proceed button on order item page
Then I 'should' see warning icon next active cover flow item
And 'should' see warning icon next following sections 'Add information'

Scenario: Complete icons are shown on the media preview window in cover flow
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVVPOAR3  | OTVVPOBR7 | OTVVPOSB7 | OTVVPOP7 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR7 | OTVVPOSB7 | OTVVPOP7 | OTVVPOC7 | OTVVPOCN7    | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT7 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'OTVVPOCN7'
And 'create new' order item by Add Commercial button on order item page
And click inactive Proceed button on order item page
And select order item with following clock number 'OTVVPOCN7' on cover flow
Then I 'should' see success icon next active cover flow item

Scenario: Add information section with empty required fields is opened after proceed
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And click inactive Proceed button on order item page
Then I 'should' see expanded following sections 'Add information' on order item page
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format      | Product | Title |
|                        |            |          |              |          |                |             |         |       |

Scenario: Warning triangles are shown with message on the Add Information section
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And logged in with details of 'OTVVPOU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'

Scenario: Check Warning Message in Clock mandatory field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR10 | OTVVPOSB10 | OTVVPOP10 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign    | Clock Number | Duration | First Air Date | Format         | Title     | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR10 | OTVVPOSB10 | OTVVPOP10 | OTVVPOC10_1 | OTVVPOCN10   | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT10 | BSkyB Green Button:Standard |
When I open order item with following clock number 'OTVVPOCN10'
And fill following fields for Add information form on order item page:
| Clock Number | Campaign    |
|              | OTVVPOC10_2 |
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message 'Field is required.' next field 'Clock Number' for order item on Add information form

Scenario: Check Warning Message in Add information section for empty mandatory fields
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR11 | OTVVPOSB11 | OTVVPOP11 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration   | First Air Date | Format         | Title     | Destination                 |
| automated test info    | <Advertiser> | OTVVPOBR11 | OTVVPOSB11 | <Product> | OTVVPOC11 | <ClockNumber> | <Duration> | <FirstAirDate> | HD 1080i 25fps | OTVVPOT11 | BSkyB Green Button:Standard |
When I open order item with following clock number '<ClockNumber>'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'

Examples:
| ClockNumber  | Advertiser | Product   | Duration | FirstAirDate |
| OTVVPOCN11_1 |            | OTVVPOP11 | 20       | 08/14/2022   |
| OTVVPOCN11_2 | OTVVPOAR3  |           | 20       | 08/14/2022   |
| OTVVPOCN11_3 | OTVVPOAR3  | OTVVPOP11 |          | 08/14/2022   |
| OTVVPOCN11_4 | OTVVPOAR3  | OTVVPOP11 | 20       |              |

Scenario: Check Warning Message in Add information section for empty Clock Number field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR12 | OTVVPOSB12 | OTVVPOP12 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Duration | First Air Date | Format         | Title     | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR12 | OTVVPOSB12 | OTVVPOP12 | OTVVPOC12 | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT12 | BSkyB Green Button:Standard |
When I open order item with next title 'OTVVPOT12'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'

Scenario: Check Warning Message for Select Broadcast Destinations section
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR13 | OTVVPOSB13 | OTVVPOP13 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVVPOAR3  | OTVVPOBR13 | OTVVPOSB13 | OTVVPOP13 | OTVVPOC13 | OTVVPOCN13   | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT13 |
When I open order item with following clock number 'OTVVPOCN13'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Select Broadcast Destinations'

Scenario: Warning triangle on sections disappears when all info is filled and press on Proceed button
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR14 | OTVVPOSB14 | OTVVPOP14 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR14 | OTVVPOSB14 | OTVVPOP14 | OTVVPOC14 | OTVVPOCN14   | 08/14/2022     | HD 1080i 25fps | OTVVPOT14 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVVPOCN14'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'
When I fill following fields for Add information form on order item page:
| Duration |
| 20       |
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Warning triangle appears near Add information section of order item which of not full filled
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR15 | OTVVPOSB15 | OTVVPOP15 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR15 | OTVVPOSB15 | OTVVPOP15 | OTVVPOC15_1 | OTVVPOCN15   | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT15_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    |            |            |            |           | OTVVPOC15_2 |              |          |                | SD PAL 16x9    | OTVVPOT15_2 | Already Supplied   |                             |
When I open order item with following clock number 'OTVVPOCN15'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'
And 'should' see expanded following sections 'Add information' on order item page
And should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign    | Clock Number | Duration | First Air Date | Format      | Product | Title       |
| automated test info    |            | OTVVPOC15_2 |              |          |                | SD PAL 16x9 |         | OTVVPOT15_2 |

Scenario: Warning triangle disappears near Add information section of order item after full filled
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR16 | OTVVPOSB16 | OTVVPOP16 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR16 | OTVVPOSB16 | OTVVPOP16 | OTVVPOC16_1 | OTVVPOCN16_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT16_1 | Already Supplied   | Aastha:Standard |
| automated test info    |            |            |            |           | OTVVPOC16_2 |              |          |                | SD PAL 16x9    | OTVVPOT16_2 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVVPOCN16_1'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'
When I fill following fields for Add information form on order item page:
| Advertiser | Brand      | Sub Brand  | Product   | Clock Number | Duration | First Air Date |
| OTVVPOAR3  | OTVVPOBR16 | OTVVPOSB16 | OTVVPOP16 | OTVVPOCN16_2 | 20       | 12/14/2022     |
And refresh the page without delay
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Warning triangle disappears near Select Broadcast Destinations section of order item after select destinatios
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR17 | OTVVPOSB17 | OTVVPOP17 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR17 | OTVVPOSB17 | OTVVPOP17 | OTVVPOC17_1 | OTVVPOCN17_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVVPOT17_1 | Adtext SD          | Aastha:Standard |
| automated test info    | OTVVPOAR3  | OTVVPOBR17 | OTVVPOSB17 | OTVVPOP17 | OTVVPOC17_2 | OTVVPOCN17_2 | 20       | 12/14/2022     | SD PAL 16x9    | OTVVPOT17_2 | Adtext SD          |                             |
When I open order item with following clock number 'OTVVPOCN17_1'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Select Broadcast Destinations'
And 'should' see expanded following sections 'Select Broadcast Destinations' on order item page
When I 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And refresh the page without delay
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: redirect to order proceed page after full filled required sections
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR18 | OTVVPOSB18 | OTVVPOP18 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Title       | Subtitles Required | Destination                 |
|              | OTVVPOT18_1 | Already Supplied   | Aastha:Standard |
| OTVVPOCN18_2 |             | Already Supplied   | Aastha:Standard |
When I open order item with next title 'OTVVPOT18_1'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'
When I fill following fields for Add information form on order item page:
| Advertiser | Brand      | Sub Brand  | Product   | Clock Number | Duration | First Air Date |
| OTVVPOAR3  | OTVVPOBR18 | OTVVPOSB18 | OTVVPOP18 | OTVVPOCN18_1 | 20       | 12/14/2022     |
And select order item with following clock number 'OTVVPOCN18_2' on cover flow
And fill following fields for Add information form on order item page:
| Advertiser | Brand      | Sub Brand  | Product   | Duration | First Air Date | Title       |
| OTVVPOAR3  | OTVVPOBR18 | OTVVPOSB18 | OTVVPOP18 | 15       | 11/14/2022     | OTVVPOT18_2 |
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: validation message for already exist clock number
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR19 | OTVVPOSB19 | OTVVPOP19 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign    | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR19 | OTVVPOSB19 | OTVVPOP19 | OTVVPOC19_1 | OTVVPOCN19   | 20       | 12/14/2022     | HD 1080i 25fps | OTVVPOT19 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVVPOCN19' with following fields:
| Job Number | PO Number  |
| OTVVPOJN19 | OTVVPOPN19 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And fill following fields for Add information form on order item page:
| Clock Number | Campaign    |
| OTVVPOCN19   | OTVVPOC19_2 |
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
And should see warning tooltip with following message 'This commercial already exists. You can add it to this order using the Retrieve from Library button in the Add Media section.' next field 'Clock Number' for order item on Add information form

Scenario: Procced order after change non unique clock number to unique
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR20 | OTVVPOSB20 | OTVVPOP20 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR20 | OTVVPOSB20 | OTVVPOP20 | OTVVPOC20_1 | OTVVPOCN20_1 | 20       | 12/14/2022     | HD 1080i 25fps | OTVVPOT20_1 | Already Supplied   | Aastha:Standard |
And complete order contains item with clock number 'OTVVPOCN20_1' with following fields:
| Job Number | PO Number  |
| OTVVPOJN20 | OTVVPOPN20 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR20 | OTVVPOSB20 | OTVVPOP20 | OTVVPOC20_2 | OTVVPOCN20_1 | 20       | 12/14/2022     | HD 1080i 25fps | OTVVPOT20_2 | Already Supplied   | Aastha:Standard |
When I open order item with next title 'OTVVPOT20_2'
And click inactive Proceed button on order item page
And fill following fields for Add information form on order item page:
| Clock Number | Title       |
| OTVVPOCN20_2 | OTVVPOT20_2 |
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Procced order after change clock number with spaces to correct value
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR21 | OTVVPOSB21 | OTVVPOP21 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number   | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR21 | OTVVPOSB21 | OTVVPOP21 | OTVVPOC21 | OTVVPOCN21 new | 20       | 12/14/2022     | HD 1080i 25fps | OTVVPOT21 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVVPOCN21 new'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
When I fill following fields for Add information form on order item page:
| Clock Number | Title     |
| OTVVPOCN21   | OTVVPOT21 |
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Proceed with Hold for Approval
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVVPOU1 | agency.admin | OTVVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVVPOA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVVPOAR3  | OTVVPOBR22 | OTVVPOSB22 | OTVVPOP22 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVVPOA1'
And logged in with details of 'OTVVPOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVVPOAR3  | OTVVPOBR22 | OTVVPOSB22 | OTVVPOP22 | OTVVPOC22 | OTVVPOCN22   | 20       | 12/14/2022     | HD 1080i 25fps | OTVVPOT22 | Already Supplied   | Aastha:Standard |
And hold for approval 'tv' order items with following clock numbers 'OTVVPOCN22'
When I open order item with following clock number 'OTVVPOCN22'
And click Proceed button on order item page
Then I 'should' see Order Proceed page