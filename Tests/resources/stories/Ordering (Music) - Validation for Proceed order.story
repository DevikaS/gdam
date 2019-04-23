!--ORD-1535
Feature: Validate order after clicking on Proceed button
Narrative:
In order to:
As a AgencyAdmin
I want to check correct validate order after clicking on Proceed button

Scenario: Proceed button is always enabled for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMVPOCN1  |
When I open order item with following isrc code 'OMVPOCN1'
Then I should see 'enabled' Proceed button on order item page

Scenario: No complete/incomplete icons are shown on the cover flow and on sections for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMVPOCN2  |
When I open order item with following isrc code 'OMVPOCN2'
Then I 'should not' see warning icon next active cover flow item
And 'should not' see warning icon next following sections 'Add information,Select Broadcast Destinations'

Scenario: Proceed button is blue for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand    | Sub Brand | Product |
| OMVPOAR3   | OMVPOBR3 | OMVPOSB3  | OMVPOP3 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR3 | OMVPOSB3  | OMVPOP3 | OMVPOC3 | OMVPOCN3  | 08/14/2022   | HD 1080i 25fps | OMVPOT3 | Aastha:Standard |
When I open order item with following isrc code 'OMVPOCN3'
Then I should see 'enabled' Proceed button on order item page

Scenario: User is redirected to order proceed page for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand    | Sub Brand | Product |
| OMVPOAR3   | OMVPOBR4 | OMVPOSB4  | OMVPOP4 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR4 | OMVPOSB4  | OMVPOP4 | OMVPOC4 | OMVPOCN4  | 08/14/2022   | HD 1080i 25fps | OMVPOT4 | Aastha:Standard |
When I open order item with following isrc code 'OMVPOCN4'
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Proceed button with QC & Ingest Only (successful flow) for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand    | Sub Brand | Product |
| OMVPOAR3   | OMVPOBR5 | OMVPOSB5  | OMVPOP5 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   |
| automated test info    | OMVPOAR3       | OMVPOBR5 | OMVPOSB5  | OMVPOP5 | OMVPOC5 | OMVPOCN5  | 08/14/2022   | HD 1080i 25fps | OMVPOT5 |
When I open order item with following isrc code 'OMVPOCN5'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Proceed button with QC & Ingest Only (unsuccessful flow, empty mandatory fields) for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMVPOCN6  |
When I open order item with following isrc code 'OMVPOCN6'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click inactive Proceed button on order item page
Then I 'should' see warning icon next active cover flow item
And 'should' see warning icon next following sections 'Add information'

Scenario: Complete icons are shown on the media preview window in cover flow for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand    | Sub Brand | Product |
| OMVPOAR3   | OMVPOBR7 | OMVPOSB7  | OMVPOP7 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code | Release Date | Format         | Title   | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR7 | OMVPOSB7  | OMVPOP7 | OMVPOC7 | OMVPOCN7  | 08/14/2022   | HD 1080i 25fps | OMVPOT7 | Aastha:Standard |
When I open order item with following isrc code 'OMVPOCN7'
And 'create new' order item by Add Commercial button on order item page
And click inactive Proceed button on order item page
And select order item with following isrc code 'OMVPOCN7' on cover flow
Then I 'should' see success icon next active cover flow item

Scenario: Add information section with empty required fields is opened after proceed for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMVPOA1'
And logged in with details of 'OMVPOU1'
And I am on View Draft Orders tab of 'music' order on ordering page
When I create 'music' order on View Draft Orders tab on ordering page
And click inactive Proceed button on order item page
Then I 'should' see expanded following sections 'Add information' on order item page
And should see following data for order item on Add information form:
| Additional Information | Record Company | Artist | ISRC Code | Release Date | Format | Label | Title |
|                        |                |        |           |              |        |       |       |

Scenario: Warning triangles are shown with message on the Add Information section for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OMVPOCN9  |
When I open order item with following isrc code 'OMVPOCN9'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'

Scenario: Check Warning Message in Clock mandatory field for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR10 | OMVPOSB10 | OMVPOP10 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMVPOA1'
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist     | ISRC Code | Release Date | Format         | Title    | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR10 | OMVPOSB10 | OMVPOP10 | OMVPOC10_1 | OMVPOCN10 | 08/14/2022   | HD 1080i 25fps | OMVPOT10 | Aastha:Standard |
When I open order item with following isrc code 'OMVPOCN10'
And fill following fields for Add information form on order item page:
| ISRC Code | Artist     |
|           | OMVPOC10_2 |
Then I 'should' see warning icon next following fields 'ISRC Code' for order item on Add information form
And should see warning tooltip with following message 'Field is required.' next field 'ISRC Code' for order item on Add information form

Scenario: Check Warning Message in Add information section for empty mandatory fields for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product |
| OMVPOAR3   | OMVPOBR11 | OMVPOSB11 | OMVPOP11 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company  | Brand      | Sub Brand  | Label   | Artist    | ISRC Code  | Release Date  | Format         | Title     | Destination                 |
| automated test info    | <RecordCompany> | OTVVPOBR11 | OTVVPOSB11 | <Label> | OTVVPOC11 | <ISRCCode> | <ReleaseDate> | HD 1080i 25fps | OTVVPOT11 | Aastha:Standard |
When I open order item with following clock number '<ISRCCode>'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'

Examples:
| ISRCCode    | RecordCompany | Label    | ReleaseDate |
| OMVPOCN11_1 |               | OMVPOP11 | 08/14/2022  |
| OMVPOCN11_2 | OMVPOAR3      |          | 08/14/2022  |
| OMVPOCN11_4 | OMVPOAR3      | OMVPOP11 |             |

Scenario: Check Warning Message in Add information section for empty ISRC Code field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR12 | OMVPOSB12 | OMVPOP12 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | Release Date | Format         | Title    | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR12 | OMVPOSB12 | OMVPOP12 | OMVPOC12 | 08/14/2022   | HD 1080i 25fps | OMVPOT12 | Aastha:Standard |
When I open order item with next title 'OMVPOT12'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'

Scenario: Check Warning Message for Select Broadcast Destinations section for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR13 | OMVPOSB13 | OMVPOP13 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Title    | Destination |
| automated test info    | OMVPOAR3       | OMVPOBR13 | OMVPOSB13 | OMVPOP13 | OMVPOC13 | OMVPOCN13 | 08/14/2022   | HD 1080i 25fps | OMVPOT13 |             |
When I open order item with following isrc code 'OMVPOCN13'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Select Broadcast Destinations'

Scenario: Warning triangle on sections disappears when all info is filled and press on Proceed button for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR14 | OMVPOSB14 | OMVPOP14 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR14 | OMVPOSB14 | OMVPOP14 | OMVPOC14 | OMVPOCN14 | 08/14/2022   | HD 1080i 25fps | Aastha:Standard |
When I open order item with following isrc code 'OMVPOCN14'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'
When I fill following fields for Add information form on order item page:
| Title    |
| OMVPOT14 |
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Warning triangle disappears near Add information section of order item after full filled for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR16 | OMVPOSB16 | OMVPOP16 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist     | ISRC Code   | Release Date | Format         | Title      | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR16 | OMVPOSB16 | OMVPOP16 | OMVPOC16_1 | OMVPOCN16_1 | 08/14/2022   | HD 1080i 25fps | OMVPOT16_1 | Aastha:Standard |
| automated test info    |                |           |           |          | OMVPOC16_2 |             |              | SD PAL 16x9    | OMVPOT16_2 | Aastha:Standard |
When I open order item with following isrc code 'OMVPOCN16_1'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'
When I fill following fields for Add information form on order item page:
| Advertiser | Brand     | Sub Brand | Label    | ISRC Code   | Release Date |
| OMVPOAR3   | OMVPOBR16 | OMVPOSB16 | OMVPOP16 | OMVPOCN16_2 | 12/14/2022   |
And refresh the page without delay
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Warning triangle disappears near Select Broadcast Destinations section of order item after select destinatios for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR17 | OMVPOSB17 | OMVPOP17 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist     | ISRC Code   | Release Date | Format         | Title      | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR17 | OMVPOSB17 | OMVPOP17 | OMVPOC17_1 | OMVPOCN17_1 | 08/14/2022   | HD 1080i 25fps | OMVPOT17_1 | Aastha:Standard |
| automated test info    | OMVPOAR3       | OMVPOBR17 | OMVPOSB17 | OMVPOP17 | OMVPOC17_2 | OMVPOCN17_2 | 12/14/2022   | SD PAL 16x9    | OMVPOT17_2 |                             |
When I open order item with following isrc code 'OMVPOCN17_1'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Select Broadcast Destinations'
And 'should' see expanded following sections 'Select Broadcast Destinations' on order item page
When I 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| Aastha |
And refresh the page without delay
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: redirect to order proceed page after full filled required sections for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR18 | OMVPOSB18 | OMVPOP18 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code   | Title      | Destination                 |
|             | OMVPOT18_1 | Aastha:Standard |
| OMVPOCN18_2 |            | Aastha:Standard |
When I open order item with next title 'OMVPOT18_1'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following sections 'Add information'
When I fill following fields for Add information form on order item page:
| Advertiser | Brand     | Sub Brand | Label    | ISRC Code   | Release Date |
| OMVPOAR3   | OMVPOBR18 | OMVPOSB18 | OMVPOP18 | OMVPOCN18_1 | 12/14/2022   |
And select order item with following isrc code 'OMVPOCN18_2' on cover flow
And fill following fields for Add information form on order item page:
| Advertiser | Brand     | Sub Brand | Label    | Release Date | Title      |
| OMVPOAR3   | OMVPOBR18 | OMVPOSB18 | OMVPOP18 | 11/14/2022   | OMVPOT18_2 |
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: validation message for already exist isrc code
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR19 | OMVPOSB19 | OMVPOP19 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMVPOA1'
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist     | ISRC Code | Release Date | Format         | Title    | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR19 | OMVPOSB19 | OMVPOP19 | OMVPOC19_1 | OMVPOCN19 | 12/14/2022   | HD 1080i 25fps | OMVPOT19 | Aastha:Standard |
And complete order contains item with isrc code 'OMVPOCN19' with following fields:
| Job Number | PO Number |
| OMVPOJN19  | OMVPOPN19 |
And I am on View Draft Orders tab of 'music' order on ordering page
When I create 'music' order on View Draft Orders tab on ordering page
And fill following fields for Add information form on order item page:
| ISRC Code | Artist     |
| OMVPOCN19 | OMVPOC19_2 |
Then I 'should' see warning icon next following fields 'ISRC Code' for order item on Add information form
And should see warning tooltip with following message 'This commercial already exists. You can add it to this order using the Retrieve from Library button in the Add Media section.' next field 'ISRC Code' for order item on Add information form

Scenario: Procced order after change non unique isrc code to unique
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR20 | OMVPOSB20 | OMVPOP20 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist     | ISRC Code   | Release Date | Format         | Title      | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR20 | OMVPOSB20 | OMVPOP20 | OMVPOC20_1 | OMVPOCN20_1 | 12/14/2022   | HD 1080i 25fps | OMVPOT20_1 | Aastha:Standard |
And complete order contains item with isrc code 'OMVPOCN20_1' with following fields:
| Job Number | PO Number |
| OMVPOJN20  | OMVPOPN20 |
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | ISRC Code   | Release Date | Format         | Title      | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR20 | OMVPOSB20 | OMVPOP20 | OMVPOCN20_1 | 12/14/2022   | HD 1080i 25fps | OMVPOT20_2 | Aastha:Standard |
When I open order item with next title 'OMVPOT20_2'
And click inactive Proceed button on order item page
And fill following fields for Add information form on order item page:
| ISRC Code   | Artist     |
| OMVPOCN20_2 | OMVPOC20_2 |
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Procced order after change isrc code with spaces to correct value
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR21 | OMVPOSB21 | OMVPOP21 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | ISRC Code     | Release Date | Format         | Title    | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR21 | OMVPOSB21 | OMVPOP21 | OMVPOCN21 new | 12/14/2022   | HD 1080i 25fps | OMVPOT21 | Aastha:Standard |
When I open order item with following isrc code 'OMVPOCN21 new'
And click inactive Proceed button on order item page
Then I 'should' see warning icon next following fields 'ISRC Code' for order item on Add information form
When I fill following fields for Add information form on order item page:
| ISRC Code | Artist   |
| OMVPOCN21 | OMVPOC21 |
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Proceed with Hold for Approval for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMVPOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMVPOU1 | agency.admin | OMVPOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMVPOA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OMVPOAR3   | OMVPOBR22 | OMVPOSB22 | OMVPOP22 |
And logged in with details of 'OMVPOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | Release Date | Format         | Title    | Destination                 |
| automated test info    | OMVPOAR3       | OMVPOBR22 | OMVPOSB22 | OMVPOP22 | OMVPOC22 | OMVPOCN22 |  12/14/2022  | HD 1080i 25fps | OMVPOT22 | Aastha:Standard |
And hold for approval 'music' order items with following isrc codes 'OMVPOCN22'
When I open order item with following isrc code 'OMVPOCN22'
And click Proceed button on order item page
Then I 'should' see Order Proceed page