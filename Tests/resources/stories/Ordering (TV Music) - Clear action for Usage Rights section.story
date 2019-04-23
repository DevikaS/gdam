!--ORD-290
!--ORD-1627
Feature: Clear action for Usage Rights section
Narrative:
In order to:
As a AgencyAdmin
I want to check clear action for usage rights section

Scenario: Clear action for Usage Rights if you manually entered data to the Usage Rights section
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCURA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCURU1 | agency.admin | OTVCURA1     |
And logged in with details of 'OTVCURU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCURCN1    |
When I open order item with following clock number 'OTVCURCN1'
And fill following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And save usage information for 'General' usage right on order item page
And clear 'Usage rights' section on order item page
Then I 'should not' see following usage rights 'General' on order item page

Scenario: Clear action for Usage Rights if you pulled data from Project
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| OTVCURA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCURU1 | agency.admin | OTVCURA1     |
And logged in with details of 'OTVCURU1'
And created 'OTVCURP2' project
And created '/OTVCURF2' folder for project 'OTVCURP2'
And uploaded '/files/Fish1-Ad.mov' file into '/OTVCURF2' folder for 'OTVCURP2' project
And waited while transcoding is finished in folder '/OTVCURF2' on project 'OTVCURP2' files page
And added 'General' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/OTVCURF2' and project 'OTVCURP2' Usage Rights page:
| StartDate  | ExpirationDate |
| 02.02.2022 | 02.02.2024     |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCURCN2    |
And add to 'tv' order item with clock number 'OTVCURCN2' following file '/files/Fish1-Ad.mov' from folder '/OTVCURF2' of project 'OTVCURP2'
When I open order item with following clock number 'OTVCURCN2'
And clear 'Usage rights' section on order item page
Then I 'should not' see following usage rights 'General' on order item page

Scenario: Clear action for Usage Rights for some order items when copy current item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCURA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCURU1 | agency.admin | OTVCURA1     |
And logged in with details of 'OTVCURU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCURCN3_1  |
And add usage right 'General' for order contains item with clock number 'OTVCURCN3_1' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
When I open order item with following clock number 'OTVCURCN3_1'
And 'copy current' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number |
| OTVCURCN3_2  |
And clear 'Usage rights' section on order item page
And wait for '1' seconds
And select order item with following clock number 'OTVCURCN3_1' on cover flow
Then I should see following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |

Scenario: Clear action for Usage Rights if you save data before clearing for music order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCURA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCURU1 | agency.admin | OTVCURA1     |
And logged in with details of 'OTVCURU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OTVCURCN4 |
When I open order item with following isrc code 'OTVCURCN4'
And fill following fields for usage right 'General' on order item page:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And save usage information for 'General' usage right on order item page
And save as draft order
And open order item with following isrc code 'OTVCURCN4'
And clear 'Usage rights' section on order item page
Then I 'should not' see following usage rights 'General' on order item page

Scenario: Clear action for Usage Rights and Proceed order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCURA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCURU1 | agency.admin | OTVCURA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCURA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVCURAR5  | OTVCURBR5 | OTVCURSB5 | OTVCURP5 |
And logged in with details of 'OTVCURU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVCURAR5  | OTVCURBR5 | OTVCURSB5 | OTVCURP5 | OTVCURC5 | OTVCURCN5    | 20       | 12/10/2022     | HD 1080i 25fps | OTVCURT5 | Already Supplied   | Aastha:Standard |
And add usage right 'General' for order contains item with clock number 'OTVCURCN5' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
When I open order item with following clock number 'OTVCURCN5'
And clear 'Usage rights' section on order item page
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OTVCURJN5  | OTVCURPN5 |
And confirm order on Order Proceed page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | OTVCURAR5  | United Kingdom | OTVCURPN5 | OTVCURJN5 | 1        | 0/1 Delivered |

Scenario: Clear action for Usage Rights and Proceed order (for music order)
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCURA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVCURU1 | agency.admin | OTVCURA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCURA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVCURAR6  | OTVCURBR6 | OTVCURSB6 | OTVCURP6 |
And logged in with details of 'OTVCURU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code | First Air Date | Format         | Title    | Destination                 |
| automated test info    | OTVCURAR6      | OTVCURBR6 | OTVCURSB6 | OTVCURP6 | OTVCURC6 | OTVCURCN6 | 12/10/2022     | HD 1080i 25fps | OTVCURT6 | BSkyB Green Button:Standard |
And add usage right 'General' for order contains item with isrc code 'OTVCURCN6' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
When I open order item with following isrc code 'OTVCURCN6'
And clear 'Usage rights' section on order item page
And completed order contains item with isrc code 'OTVCURCN6' with following fields:
| Job Number | PO Number |
| OTVCURJN6  | OTVCURPN6 |
And go to View Live Orders tab of 'music' order on ordering page
And refresh the page without delay
Then I should see Music 'live' order in order list with following fields:
| Order# | DateTime    | Record Company | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | OTVCURAR6      | United Kingdom | OTVCURPN6 | OTVCURJN6 | 1        | 0/1 Delivered |


Scenario: Clear action for Usage Rights using asset form Library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVCURA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| OTVCURU1 | agency.admin | OTVCURA1     |streamlined_library|
And logged in with details of 'OTVCURU1'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And added Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2022 | 02.02.2024     |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCURCN7    |
And add to 'tv' order item with clock number 'OTVCURCN7' following asset 'Fish1-Ad.mov' of collection 'My Assets'
When I open order item with following clock number 'OTVCURCN7'
And clear 'Usage rights' section on order item page
Then I 'should not' see following usage rights 'General' on order item page