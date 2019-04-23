Feature:          Traffic Order Item page
Narrative:
In order to
As a              AgencyAdmin
I want to         Check order metadata replication from a5 to Traffic

Scenario: Check that after create order in A5, metadata will be replicated to Traffic(Traffic Manager User)
Meta: @traffic
Given I created the following agency:
| Name      |    A4User     | AgencyType     | Application Access |
| TOIPA1    | DefaultA4User | Advertiser     |      ordering      |
And created users with following fields:
| Email   |             Role          | AgencyUnique |  Access  |
| TOIPU1 |       agency.admin        |   TOIPA1    | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TOIPA1':
| Advertiser | Brand   | Sub Brand  | Product   |
|   TOIPAR1  | TOIPBR1 | TOIPSB1    | TOIPP1    |
And logged in with details of 'TOIPU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TOIPAR1    | TOIPBR1 | TOIPSB1    | TOIPP1    | TTVBTVSC1 | TOIPCN2    | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard|
And complete order contains item with clock number 'TOIPCN2' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber 'TOIPCN2' will be available in Traffic
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And entered search criteria 'TOIPCN2' in simple search form on Traffic Order Item List page
And waited for '2' seconds
And opened order details with clockNumber 'TOIPCN2' from Traffic UI
And refreshed the page without delay
When I open order item details page with clockNumber 'TOIPCN2' from traffic order details page
And refresh the page
Then I should see following metadata on order details page in traffic:
| Clock Number | Advertiser | Product | First Air Date| Order Reference |
|   TOIPCN2    | TOIPAR1    | TOIPP1  |   14/12/2022  |                 |


Scenario: Check that after create order in A5, metadata will be replicated to Traffic (Broadcast User)
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
Given I created the following agency:
| Name      |    A4User     |    AgencyType  | Application Access |  Market  | DestinationID |    A4User     |
| TOIPA2    | DefaultA4User |   Advertiser   |      ordering      |          |               | DefaultA4User |
And created users with following fields:
| Email  |             Role          | AgencyUnique |  Access  |
| TOIPU3 |       agency.admin        |   TOIPA2     | ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TOIPA2':
| Advertiser | Brand   | Sub Brand  | Product   |
|   TOIPAR2  | TOIPBR2 | TOIPSB2    | TOIPP2    |
And logged in with details of 'TOIPU3'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer |Subtitles Required | Format         | Title     | Destination              |
| automated test info    |   TOIPAR2  | TOIPBR2 | TOIPSB2    | TOIPP2    | TTVBTVSC1 | TOIPCN1      | 20       | 12/14/2022     |      1      | Already Supplied  | HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Standard      |
And complete order contains item with clock number 'TOIPCN1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And logged in with details of 'broadcasterTrafficManagerTwo'
And waited till order with clockNumber 'TOIPCN1' will be available in Traffic
And selected 'All' tab in Traffic UI
And refreshed the page
When open order item details page with clockNumber 'TOIPCN1'
Then I should see following metadata on order details page in traffic:
| Clock Number | Advertiser | Product |  Title    |
|   TOIPCN1    | TOIPAR2    | TOIPP2  | TTVBTVST1 |

Scenario:  Check that Traffic Manager - Ingest Locator able to view and download the QCed asset from Library
Meta: @traffic
Given I created the following agency:
| Name         |    A4User          | AgencyType     | Application Access |     Market     | DestinationID | Save In Library | Allow To Save In Library |
| TCNTA14_1    | DefaultA4User      | Advertiser     |streamlined_library,ordering    |                |               |should          | should                    |
| TCNTI15      | DefaultA4User      |   Ingest       |       adpath       |                |               |                |                           |
And created users with following fields:
| Email  |           Role            | AgencyUnique |  Access          |
| TCNTU8_1 |       agency.admin        |   TCNTA14_1    | streamlined_library,ordering |
| TCNTU9_1| traffic.traffic.manager   |   TCNTI15    |  adpath          |
And logged in with details of 'TCNTU8_1'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TCNTA14_1':
| Advertiser | Brand   | Sub Brand | Product |
| TOIPAR1    | TOIPBR1 | TOIPSB1   | TOIPPR1 |
And I uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TOIPAR1    | TOIPBR1 | TOIPSB1   | TOIPPR1 | TTVBTVSC1 | TTVBTVSCN15_110| 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue |
| Advertiser | TOIPAR1    |
| Brand      | TOIPBR1    |
| Sub Brand  | TOIPSB1    |
| Product    | TOIPPR1    |
| Clock number    | TOICLK1    |
And open order item with following clock number 'TTVBTVSCN15_110'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| TTVBTVS110   | TTVBTVS110   |
And confirm order on Order Proceed page
When ingested assests through A5 with following fields:
 | agencyName   | clockNumber      |
 | TCNTA14_1    | TTVBTVSCN15_110  |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TOIPAR1    | TOIPBR1 | TOIPSB1   | TOIPPR1 | TTVBTVSC1 | TTVBTVSCN15_111| 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST2 | Talk Sport:Standard |
And I open order item with following clock number 'TTVBTVSCN15_111'
And add to order for order item at Add media to your order form following assets 'Fish1-Ad.mov'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| TTVBTVS112   | TTVBTVS112   |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TTVBTVSCN15_110' to A4
And I logout from account
And login with details of 'TCNTU9_1'
And wait till order with clockNumber 'TTVBTVSCN15_110' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'TTVBTVSCN15_110' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And open order item details page with clockNumber 'TTVBTVSCN15_110'
Then I 'should' see Support Document 'Matser' for clockNumber 'TTVBTVSCN15_110' in order details page
And I 'should' see Support Document '_Matser.zip' for clockNumber 'TTVBTVSCN15_110' is downloaded from order details page
And refresh the page
And I 'should' see Support Document '_CLAPPER.jpg' for clockNumber 'TTVBTVSCN15_110' is downloaded from order details page
And I 'should' see Support Document '_thumbnail.png' for clockNumber 'TTVBTVSCN15_110' is downloaded from order details page
And I 'should' see Support Document '.mp4' for clockNumber 'TTVBTVSCN15_110' is downloaded from order details page
And I 'should' see Support Document 'JPG_SB' for clockNumber 'TTVBTVSCN15_110' is downloaded from order details page


Scenario:  Check that Traffic Manager - Ingest Locator able to view and download the Non QCed asset from Library
Meta: @traffic
Given I created the following agency:
| Name      |    A4User     | AgencyType     | Application Access |     Market     | DestinationID |
| TCNTA8    | DefaultA4User      | Advertiser     |streamlined_library,ordering    |                |               |
| TCNTI9    | DefaultA4User      |   Ingest       |       adpath       |                |               |
And created users with following fields:
| Email  |           Role            | AgencyUnique |  Access          |
| TCNTU8 |       agency.admin        |   TCNTA8     | streamlined_library,ordering |
| TCNTU9 | traffic.traffic.manager   |   TCNTI9     |  adpath          |
And logged in with details of 'TCNTU8'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TCNTA8':
| Advertiser | Brand   | Sub Brand | Product |
| TOIPAR2    | TOIPBR2 | TOIPSB2   | TOIPPR2 |
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish1-Ad.mov  |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TOIPAR2    | TOIPBR2 | TOIPSB2   | TOIPPR2 | TTVBTVSC1 | TTVBTVSCN15_1| 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard |
And added to 'tv' order item with clock number 'TTVBTVSCN15_1' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And completed order contains item with clock number 'TTVBTVSCN15_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And I logout from account
And login with details of 'TCNTU9'
And wait till order with clockNumber 'TTVBTVSCN15_1' will be available in Traffic
And select 'All' tab in Traffic UI
And enter search criteria 'TTVBTVSCN15_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And open order item details page with clockNumber 'TTVBTVSCN15_1'
Then I 'should' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_1' in order details page
And I 'should' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_1' is downloaded from order details page
When I login with details of 'TCNTU8'
And ingested assests through A5 with following fields:
 | agencyName   | clockNumber      |
 | TCNTA8       | TTVBTVSCN15_1    |
And I logout from account
And login with details of 'TCNTU9'
And wait till order with clockNumber 'TTVBTVSCN15_1' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order item with clockNumber 'TTVBTVSCN15_1' will have next status 'TVC Ingested OK' in Traffic
And enter search criteria 'TTVBTVSCN15_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And open order item details page with clockNumber 'TTVBTVSCN15_1'
And wait for '10' seconds
And refresh the page
Then I 'should' see Support Document '_.mov' for clockNumber 'TTVBTVSCN15_1' in order details page
And I 'should' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_1' is downloaded from order details page
And I 'should' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_1' is downloaded from order details page
And I 'should' see Support Document '_Matser.zip' for clockNumber 'TTVBTVSCN15_1' is downloaded from order details page
And I 'should' see Support Document '_CLAPPER.jpg' for clockNumber 'TTVBTVSCN15_1' is downloaded from order details page
And I 'should' see Support Document '_thumbnail.png' for clockNumber 'TTVBTVSCN15_1' is downloaded from order details page
And I 'should' see Support Document '.mp4' for clockNumber 'TTVBTVSCN15_1' is downloaded from order details page
And I 'should' see Support Document 'JPG_SB' for clockNumber 'TTVBTVSCN15_1' is downloaded from order details page

Scenario:  Check that Traffic Manager - Ingest Locator able to view and download the Non QCed asset from Project
Meta: @traffic
Given I created the following agency:
| Name       |    A4User          | AgencyType     | Application Access         |     Market     | DestinationID |
| TCNTA10    | DefaultA4User      | Advertiser     |folders,streamlined_library,ordering    |                |               |
| TCNTI11    | DefaultA4User      |   Ingest       |       adpath               |                |               |
And created users with following fields:
| Email   |           Role            | AgencyUnique |  Access                 |
| TCNTU10A |       agency.admin        |   TCNTA10   | folders,streamlined_library,ordering |
| TCNTU11 | traffic.traffic.manager   |   TCNTI11   | adpath                   |
And logged in with details of 'TCNTU10A'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TCNTA10':
| Advertiser | Brand   | Sub Brand | Product |
| TOIPAR3    | TOIPBR3 | TOIPSB3   | TOIPPR3 |
And created 'PLTOPQCP1' project
And created '/PLTOPQCF1' folder for project 'PLTOPQCP1'
And uploaded into project 'PLTOPQCP1' following files:
| FileName             | Path       |
| /files/Fish1-Ad.mov  | /PLTOPQCF1 |
And waited while transcoding is finished in folder '/PLTOPQCF1' on project 'PLTOPQCP1' files page
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TOIPAR3    | TOIPBR3 | TOIPSB3   | TOIPPR3 | TTVBTVSC1 | TTVBTVSCN15_113| 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And added to 'tv' order item with clock number 'TTVBTVSCN15_113' following file '/files/Fish1-Ad.mov' from folder '/PLTOPQCF1' of project 'PLTOPQCP1'
And completed order contains item with clock number 'TTVBTVSCN15_113' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And I logout from account
And login with details of 'TCNTU11'
And wait till order with clockNumber 'TTVBTVSCN15_113' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And expand all orders on Traffic Order List page
And open order item details page with clockNumber 'TTVBTVSCN15_113'
Then I 'should' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_113' in order details page
And I 'should' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_113' is downloaded from order details page
When I login with details of 'TCNTU10A'
And ingested assests through A5 with following fields:
 | agencyName   | clockNumber        |
 | TCNTA10      | TTVBTVSCN15_113    |
And I logout from account
And login with details of 'TCNTU11'
And wait till order with clockNumber 'TTVBTVSCN15_113' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TTVBTVSCN15_113' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And open order item details page with clockNumber 'TTVBTVSCN15_113'
Then I 'should' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_113' in order details page
And I 'should' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_113' is downloaded from order details page
And I 'should' see Support Document '_Matser.zip' for clockNumber 'TTVBTVSCN15_113' is downloaded from order details page
And refresh the page
And I 'should' see Support Document '_CLAPPER.jpg' for clockNumber 'TTVBTVSCN15_113' is downloaded from order details page
And I 'should' see Support Document '_thumbnail.png' for clockNumber 'TTVBTVSCN15_113' is downloaded from order details page
And I 'should' see Support Document '.mp4' for clockNumber 'TTVBTVSCN15_113' is downloaded from order details page
And I 'should' see Support Document 'JPG_SB' for clockNumber 'TTVBTVSCN15_113' is downloaded from order details page

Scenario:  Check that Traffic Manager - Ingest Locator able to view and download the New Master QCed asset
Meta: @traffic
Given I created the following agency:
| Name     |    A4User      | AgencyType     | Application Access |Market    | DestinationID |    A4User        |
| TCNTA12  | DefaultA4User  |  Advertiser    |streamlined_library,ordering    |          |               |   DefaultA4User  |
| TCNTI13  | DefaultA4User  |   Ingest       |       adpath       |          |               |                  |
And created users with following fields:
| Email   |           Role            | AgencyUnique |  Access          |
| TCNTU12 |       agency.admin        |   TCNTA12    | streamlined_library,ordering |
| TCNTU13 | traffic.traffic.manager   |   TCNTI13    |  adpath          |
And logged in with details of 'TCNTU12'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TCNTA12':
| Advertiser | Brand   | Sub Brand | Product |
| TOIPAR4    | TOIPBR4 | TOIPSB4   | TOIPPR4 |
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination             | Motivnummer |
| automated test info    | TOIPAR4    | TOIPBR4 | TOIPSB4   | TOIPPR4 | TTVBTVSC1 | TTVBTVSCN15_112 | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Motorvision TV:Standard |  1          |
And completed order contains item with clock number 'TTVBTVSCN15_112' with following fields:
| Job Number    | PO Number    |
| TTVBTVS1112   | TTVBTVS1112 |
And login with details of 'TCNTU13'
And wait till order with clockNumber 'TTVBTVSCN15_112' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'TTVBTVSCN15_112' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And on order item details page of clockNumber 'TTVBTVSCN15_112'
Then I 'shouldnot' see Support Document 'Fish1-Ad' for clockNumber 'TTVBTVSCN15_112' in order details page
When I login with details of 'TCNTU12'
And ingested assests through A5 with following fields:
| agencyName | clockNumber      |
| TCNTA12    | TTVBTVSCN15_112  |
And logout from account
And login with details of 'TCNTU13'
And wait till order with clockNumber 'TTVBTVSCN15_112' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'TTVBTVSCN15_112' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And on order item details page of clockNumber 'TTVBTVSCN15_112'
And refresh the page
Then I 'should' see Support Document 'Matser' for clockNumber 'TTVBTVSCN15_112' in order details page
And I 'should' see Support Document '_Matser.zip' for clockNumber 'TTVBTVSCN15_112' is downloaded from order details page
And refresh the page
And I 'should' see Support Document '_CLAPPER.jpg' for clockNumber 'TTVBTVSCN15_112' is downloaded from order details page
And I 'should' see Support Document '_thumbnail.png' for clockNumber 'TTVBTVSCN15_112' is downloaded from order details page
And I 'should' see Support Document '.mp4' for clockNumber 'TTVBTVSCN15_112' is downloaded from order details page
And I 'should' see Support Document 'JPG_SB' for clockNumber 'TTVBTVSCN15_112' is downloaded from order details page