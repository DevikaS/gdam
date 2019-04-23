!--NGN-16236
Meta:

Narrative:
As a              AgencyAdmin
I want to perform an action
So that I can achieve a business goal


Scenario: Check that Traffic Manager can reingest the asset
Meta:@traffic
Given I created the following agency:
| Name       |    A4User     |    AgencyType  | Application Access         |
| TMCRA1_2   | DefaultA4User |   Advertiser   |      ordering,streamlined_library      |
| TMCRI1_2   | DefaultA4User |   Ingest       |       adpath               |
And created users with following fields:
| Email        |          Role             | AgencyUnique      |  Access          |
| TMCRA1_2   |       agency.admin        |   TMCRA1_2      | ordering,streamlined_library |
| TMCRU2_2   | traffic.traffic.manager   |   TMCRI1_2      |  adpath          |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser    | Brand     | Sub Brand     | Product      |
| TMCRAR1       | TMCRBR1   | TMCRSB1       | TMCRSP1      |
And logged in with details of 'TMCRA1_2'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand    | Product    | Campaign  | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer  |
| automated test info    | TMCRAR1  | TMCRBR1 | TMCRSB1    | TMCRSP1  | TMCRC1  | TMCRCN9_2   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCRST1 | Facebook DE:Standard |  1          |
And completed order contains item with clock number 'TMCRCN9_2' with following fields:
| Job Number  | PO Number |
| TMCR11      | TMCR11  |
And waited for finish place order with following item clock number 'TMCRCN9_2' to A4
And ingested assests through A5 with following fields:
 | agencyName | clockNumber      |
 | TMCRA1_2 |   TMCRCN9_2    |
And login with details of 'TMCRU2_2'
And wait till order with clockNumber 'TMCRCN9_2' will be available in Traffic
And wait till order item with clockNumber 'TMCRCN9_2' will have next status 'TVC Ingested OK' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRCN9_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '10' seconds
When open order item details page with clockNumber 'TMCRCN9_2'
And I 'should' see Support Document 'TMCRST1' for clockNumber 'TMCRCN9_2' in order details page
And I click on 'Edit Asset' button on order item details page in traffic
And 'reingest' the clock
And verify 'reingest' message
And refresh the page without delay
Then revision file ID for clockNumber 'TMCRCN9_2' 'should' be empty in Traffic
And 'should not' see transcoded preview on asset info page
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRCN9_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '10' seconds
And open order item details page with clockNumber 'TMCRCN9_2'
And refresh the page without delay
Then I 'should not' see Support Document 'TMCRST1' for clockNumber 'TMCRCN9_2' in order details page
When login with details of 'TMCRA1_2'
And verify ingest doc status set to 'New' for clock 'TMCRCN9_2'
And ingested assests through A5 with following fields:
| agencyName | clockNumber  |
| TMCRA1_2 |   TMCRCN9_2    |
And verify ingest doc status set to 'TVC Ingested OK' for clock 'TMCRCN9_2'
Then revision file ID for clockNumber 'TMCRCN9_2' 'should not' be empty in Traffic
When login with details of 'TMCRU2_2'
And wait till order item with clockNumber 'TMCRCN9_2' will have next status 'TVC Ingested OK' in Traffic
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRCN9_2' in simple search form on Traffic Order Item List page
And expand all orders on Traffic Order List page
And wait for '8' seconds
And open order item details page with clockNumber 'TMCRCN9_2'
And refresh the page without delay
Then I 'should' see Support Document 'TMCRST1' for clockNumber 'TMCRCN9_2' in order details page
And I 'should' see playable preview on order item details page in traffic

Scenario: Check that Traffic Manager can reingest the asset for 2 clocks
Meta:@traffic
Given I created the following agency:
| Name       |    A4User     |    AgencyType  | Application Access         |
| TMCRTCA1_2   | DefaultA4User |   Advertiser   |      ordering,streamlined_library      |
| TMCRTCI2_2   | DefaultA4User |   Ingest       |       adpath               |
And created users with following fields:
| Email        |          Role             | AgencyUnique      |  Access          |
| TMCRTCU1_2   |       agency.admin        |   TMCRTCA1_2      | ordering,streamlined_library |
| TMCRTCU2_2   | traffic.traffic.manager   |   TMCRTCI2_2      |  adpath          |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TMCRTCA1_2':
| Advertiser | Brand      | Sub Brand  | Product    |
| TMCRTSCAR2 | TMCRTSCBR2 | TMCRTSCSB2 | TMCRTSCSP2 |
And logged in with details of 'TMCRTCU1_2'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer  |
| automated test info    | TMCRTSCAR2 | TMCRTSCBR2 | TMCRTSCSB2 | TMCRTSCSP2 | TMCRTCC1  | TMCRTCCN9_2   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCRTCST1 | Facebook DE:Standard |  1          |
| automated test info    | TMCRTSCAR2 | TMCRTSCBR2 | TMCRTSCSB2 | TMCRTSCSP2 | TMCRTCC1  | TMCRTCCN9_3   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCRTCST2 | Facebook DE:Standard |  1          |
And completed order contains item with clock number 'TMCRTCCN9_2' with following fields:
| Job Number  | PO Number |
| TMCRTC11      | TMCRTC11  |
And waited for finish place order with following item clock number 'TMCRTCCN9_2' to A4
And ingested assests through A5 with following fields:
 | agencyName | clockNumber      |
 | TMCRTCA1_2 |   TMCRTCCN9_2    |
 | TMCRTCA1_2 |   TMCRTCCN9_3    |
And login with details of 'TMCRTCU2_2'
And wait till order with clockNumber 'TMCRTCCN9_2' will be available in Traffic
And wait till order item with clockNumber 'TMCRTCCN9_2' will have next status 'TVC Ingested OK' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTCCN9_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '8' seconds
And open order item details page with clockNumber 'TMCRTCCN9_2'
And refresh the page without delay
And I 'should' see Support Document 'TMCRTCST1' for clockNumber 'TMCRTCCN9_2' in order details page
And I click on 'Edit Asset' button on order item details page in traffic
And 'reingest' the clock
And verify 'reingest' message
And refresh the page
Then revision file ID for clockNumber 'TMCRTCCN9_2' 'should' be empty in Traffic
And 'should not' see transcoded preview on asset info page
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TMCRTCCN9_2' will be available in Traffic
And enter search criteria 'TMCRTCCN9_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '12' seconds
And open order item details page with clockNumber 'TMCRTCCN9_2'
And refresh the page without delay
Then I 'should not' see Support Document 'TMCRTCST1' for clockNumber 'TMCRTCCN9_2' in order details page
When login with details of 'TMCRTCU1_2'
And verify ingest doc status set to 'New' for clock 'TMCRTCCN9_2'
And ingested assests through A5 with following fields:
| agencyName | clockNumber      |
| TMCRTCA1_2 |   TMCRTCCN9_2    |
And verify ingest doc status set to 'TVC Ingested OK' for clock 'TMCRTCCN9_2'
Then revision file ID for clockNumber 'TMCRTCCN9_2' 'should not' be empty in Traffic
When login with details of 'TMCRTCU2_2'
And wait till order item with clockNumber 'TMCRTCCN9_2' will have next status 'TVC Ingested OK' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTCCN9_2' in simple search form on Traffic Order Item List page
And expand all orders on Traffic Order List page
And wait for '8' seconds
And open order item details page with clockNumber 'TMCRTCCN9_2'
And refresh the page without delay
Then I 'should' see Support Document 'TMCRTCST1' for clockNumber 'TMCRTCCN9_2' in order details page
And I 'should' see playable preview on order item details page in traffic
When click on 'Back' button on order item details page in traffic
And wait for '5' seconds
And enter search criteria 'TMCRTCCN9_3' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '8' seconds
And open order item details page with clockNumber 'TMCRTCCN9_3'
And refresh the page without delay
And I 'should' see Support Document 'TMCRTCST2' for clockNumber 'TMCRTCCN9_3' in order details page
And I click on 'Edit Asset' button on order item details page in traffic
And 'reingest' the clock
And verify 'reingest' message
And refresh the page without delay
Then revision file ID for clockNumber 'TMCRTCCN9_3' 'should' be empty in Traffic
And 'should not' see transcoded preview on asset info page
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTCCN9_3' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '12' seconds
And open order item details page with clockNumber 'TMCRTCCN9_3'
And refresh the page without delay
Then I 'should not' see Support Document 'TMCRTCST2' for clockNumber 'TMCRTCCN9_3' in order details page
When login with details of 'TMCRTCU1_2'
And verify ingest doc status set to 'New' for clock 'TMCRTCCN9_3'
And ingested assests through A5 with following fields:
| agencyName | clockNumber   |
| TMCRTCA1_2 |   TMCRTCCN9_3 |
And wait for '5' seconds
And verify ingest doc status set to 'TVC Ingested OK' for clock 'TMCRTCCN9_3'
Then revision file ID for clockNumber 'TMCRTCCN9_3' 'should not' be empty in Traffic
When login with details of 'TMCRTCU2_2'
And wait till order item with clockNumber 'TMCRTCCN9_3' will have next status 'TVC Ingested OK' in Traffic
When select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTCCN9_3' in simple search form on Traffic Order Item List page
And expand all orders on Traffic Order List page
And wait for '8' seconds
And open order item details page with clockNumber 'TMCRTCCN9_3'
And refresh the page without delay
Then I 'should' see Support Document 'TMCRTCST2' for clockNumber 'TMCRTCCN9_3' in order details page
And I 'should' see playable preview on order item details page in traffic


Scenario: Check that Traffic Manager can re-transcode the asset
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand      | Product     |
| TMCRTSCAR1 | TMCRTSCBR1 | TMCRTSCSB1     | TMCRTSCSP1  |
And I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand      | Sub Brand  | Product     | Campaign   | Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination          | Motivnummer  |
| automated test info    | TMCRTSCAR1  | TMCRTSCBR1 | TMCRTSCSB1 | TMCRTSCSP1  | TMCRTSCC1  | TMCRTSCCN9_2   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCRTSCST1 | MDF 1:Standard |  1           |
And completed order contains item with clock number 'TMCRTSCCN9_2' with following fields:
| Job Number  | PO Number  |
| TMCRTSC11   | TMCRTSC11  |
And waited for finish place order with following item clock number 'TMCRTSCCN9_2' to A4
And should reset the transcode Job
And ingested assests through A5 with following fields:
 | agencyName  | clockNumber      |
 | DefaultAgency |   TMCRTSCCN9_2   |
And start the restranscode Job
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMCRTSCCN9_2' will be available in Traffic
And wait till order item with clockNumber 'TMCRTSCCN9_2' will have next status 'TVC Ingested OK' in Traffic
And wait till order item with clockNumber 'TMCRTSCCN9_2' will have A5 view status 'Passed QC' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTSCCN9_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '10' seconds
And open order item details page with clockNumber 'TMCRTSCCN9_2'
And refresh the page without delay
And I should store created date for proxy document with clockNumber 'TMCRTSCCN9_2' in traffic order item list
When I click on 'Edit Asset' button on order item details page in traffic
And 'should' see transcoded preview on asset info page
And 'saved' asset info by following information on opened asset info page:
| FieldName                       | FieldValue         |
| Ad duration in frames           |   22f              |
|First active frame               |    3s              |
|Full Duration in frames          |   21s              |
| Title                           | IMG LAUR S24 TRAN  |
When 'retranscode' the clock
And verify 'retranscode' message
And refresh the page without delay
And 'should not' see transcoded preview on asset info page
And start the restranscode Job
Then read asset duration for retranscode action in A5
| Ad duration in frames           |   Full Duration in frames  | First active frame   |
|22                               |   525                      | 75                   |
And refresh the page
And 'should' see transcoded preview on asset info page
When I open Traffic Order List page
And wait till order item with clockNumber 'TMCRTSCCN9_2' will have next status 'TVC Ingested OK' in Traffic
And wait till order item with clockNumber 'TMCRTSCCN9_2' will have A5 view status 'Passed QC' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTSCCN9_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '10' seconds
And open order item details page with clockNumber 'TMCRTSCCN9_2'
And refresh the page without delay
Then should verify proxy created date for clockNumber 'TMCRTSCCN9_2' in traffic order item list is updated
And should clear created date for proxy document with clockNumber 'TMCRTSCCN9_2' in traffic order item list



Scenario: Check that Traffic Manager can re-transcode the asset for 2 clocks
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product    |
| TMCRTSCAR1 | TMCRTSCBR1 | TMCRTSCSB1 | TMCRTSCSP1 |
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand      | Sub Brand     | Product     | Campaign    | Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination          | Motivnummer  |
| automated test info    | TMCRTSCAR1  | TMCRTSCBR1 | TMCRTSCSB1    | TMCRTSCSP1  | TMCRTSCCC1  | TMCRTTCCN9_2   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCRTTCST1 | Facebook DE:Standard |  1           |
| automated test info    | TMCRTSCAR1  | TMCRTSCBR1 | TMCRTSCSB1    | TMCRTSCSP1  | TMCRTSCCC1  | TMCRTTCCN9_3   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMCRTTCST2 | Facebook DE:Standard |  1           |
And completed order contains item with clock number 'TMCRTTCCN9_2' with following fields:
| Job Number  | PO Number  |
| TMCRTTC11   | TMCRTTC11  |
And waited for finish place order with following item clock number 'TMCRTTCCN9_2' to A4
And should reset the transcode Job
And ingested assests through A5 with following fields:
 | agencyName  | clockNumber      |
 | DefaultAgency |   TMCRTTCCN9_2   |
And start the restranscode Job
And ingested assests through A5 with following fields:
| agencyName  | clockNumber      |
| DefaultAgency |   TMCRTTCCN9_3   |
And start the restranscode Job
And login with details of 'trafficManager'
And wait till order with clockNumber 'TMCRTTCCN9_2' will be available in Traffic
And wait till order item with clockNumber 'TMCRTTCCN9_2' will have next status 'TVC Ingested OK' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTTCCN9_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '10' seconds
And open order item details page with clockNumber 'TMCRTTCCN9_2'
And refresh the page without delay
And wait for '2' seconds
And I should store created date for proxy document with clockNumber 'TMCRTTCCN9_2' in traffic order item list
When I click on 'Edit Asset' button on order item details page in traffic
And 'should' see transcoded preview on asset info page
And 'saved' asset info by following information on opened asset info page:
| FieldName                       | FieldValue         |
| Ad duration in frames           |   22f              |
|First active frame               |    3s              |
|Full Duration in frames          |   21s              |
| Title                           | IMG LAUR S24       |
When 'retranscode' the clock
And verify 'retranscode' message
And refresh the page without delay
And 'should not' see transcoded preview on asset info page
And start the restranscode Job
Then read asset duration for retranscode action in A5
| Ad duration in frames           |   Full Duration in frames  | First active frame   |
|22                               |   525                      | 75                   |
And refresh the page
And 'should' see transcoded preview on asset info page
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTTCCN9_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '12' seconds
And wait till order item with clockNumber 'TMCRTTCCN9_2' will have next status 'TVC Ingested OK' in Traffic
And open order item details page with clockNumber 'TMCRTTCCN9_2'
And refresh the page without delay
Then should verify proxy created date for clockNumber 'TMCRTTCCN9_2' in traffic order item list is updated
And should clear created date for proxy document with clockNumber 'TMCRTTCCN9_2' in traffic order item list
When click on 'Back' button on order item details page in traffic
And wait for '5' seconds
And enter search criteria 'TMCRTTCCN9_3' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '10' seconds
And open order item details page with clockNumber 'TMCRTTCCN9_3'
And refresh the page without delay
And I should store created date for proxy document with clockNumber 'TMCRTTCCN9_3' in traffic order item list
When I click on 'Edit Asset' button on order item details page in traffic
And 'should' see transcoded preview on asset info page
And 'saved' asset info by following information on opened asset info page:
| FieldName                       | FieldValue         |
| Ad duration in frames           |   23f              |
|First active frame               |    3s              |
|Full Duration in frames          |   21s              |
| Title                           | IMG LAUR S24       |
When 'retranscode' the clock
And verify 'retranscode' message
And refresh the page without delay
And 'should not' see transcoded preview on asset info page
And start the restranscode Job
Then read asset duration for retranscode action in A5
| Ad duration in frames           |   Full Duration in frames  | First active frame   |
|23                               |   525                      | 75                   |
And refresh the page
And 'should' see transcoded preview on asset info page
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMCRTTCCN9_3' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait till order item with clockNumber 'TMCRTTCCN9_3' will have next status 'TVC Ingested OK' in Traffic
And wait for '12' seconds
And open order item details page with clockNumber 'TMCRTTCCN9_3'
And refresh the page without delay
Then should verify proxy created date for clockNumber 'TMCRTTCCN9_3' in traffic order item list is updated
And should clear created date for proxy document with clockNumber 'TMCRTTCCN9_3' in traffic order item list

Scenario: Check that Traffic Manager cannot see reingest and retranscode button when clock in not ingested
Meta:@traffic
Given I created the following agency:
| Name        |    A4User     |    AgencyType  | Application Access         |
| TMDSRARFNIA | DefaultA4User |   Advertiser   |      ordering,streamlined_library      |
| TMDSRARFNII | DefaultA4User |   Ingest       |       adpath               |
And created users with following fields:
| Email        |          Role             | AgencyUnique       |  Access          |
| TMDSRARFNIAU |       agency.admin        |   TMDSRARFNIA      | ordering,streamlined_library |
| TMDSRARFNIIU | traffic.traffic.manager   |   TMDSRARFNII      |  adpath          |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TMDSRARFNIA':
| Advertiser    | Brand           | Sub Brand     | Product       |
| TMDSRARFNIR1  | TMDSRARFNIBR1   | TMDSRARFNISB1 | TMDSRARFNISP1 |
And logged in with details of 'TMDSRARFNIAU'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser    | Brand         | Sub Brand     | Product        | Campaign      | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         | Motivnummer  |
| automated test info    | TMDSRARFNIR1  | TMDSRARFNIBR1 | TMDSRARFNISB1 | TMDSRARFNISP1  | TMDSRARFNIC1  | TMDSRARFNICN1   | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TMDSRARFNIT1 | Facebook DE:Standard |  1          |
And completed order contains item with clock number 'TMDSRARFNICN1' with following fields:
| Job Number       | PO Number       |
| TMDSRARFNIJB11   | TMDSRARFNIPB11  |
And waited for finish place order with following item clock number 'TMDSRARFNICN1' to A4
And login with details of 'TMDSRARFNIIU'
And wait till order with clockNumber 'TMDSRARFNICN1' will be available in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TMDSRARFNICN1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And wait for '10' seconds
And open order item details page with clockNumber 'TMDSRARFNICN1'
When I click on 'Edit Asset' button on order item details page in traffic
Then I verify that 'reingest' button 'should not' be enabled
And I verify that 'retranscode' button 'should not' be enabled