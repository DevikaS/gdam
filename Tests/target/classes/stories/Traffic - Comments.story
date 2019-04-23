Feature:    Traffic Comment functionality
Narrative:
In order to
As a              AgencyAdmin
I want to check approval feature and ACL

Scenario: Comment added for multiple clocks updated at Order Level and Last comment field
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand       | Sub Brand   | Product     |
| TMCOLAR4    | TMCOLBR4    | TMCOLSB4    | TMCOLMP4    |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand  | Product     | Campaign    | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TMCOLAR4    | TMCOLBR4    | TMCOLSB4   | TMCOLMP4    | TMCOLMC4    | <ClockNumber1>    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMCOLSRT4  | BSkyB Green Button:Standard  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand  | Product     | Campaign    | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TMCOLAR4    | TMCOLBR4    | TMCOLSB4   | TMCOLMP4    | TMCOLMC4    | <ClockNumber2>    | 20       | 12/14/2022     |   Adtext           |HD 1080i 25fps  | TMCOLSRT5  | BSkyB Green Button:Standard  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand  | Product     | Campaign    | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TMCOLAR4    | TMCOLBR4    | TMCOLSB4   | TMCOLMP4    | TMCOLMC4    | <ClockNumber3>    | 20       | 12/14/2022     |   Yes              |HD 1080i 25fps  | TMCOLSRT6  | BSkyB Green Button:Standard  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand  | Product     | Campaign    | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TMCOLAR4    | TMCOLBR4    | TMCOLSB4   | TMCOLMP4    | TMCOLMC4    | <ClockNumber4>    | 20       | 12/14/2022     |   None             |HD 1080i 25fps  | TMCOLSRT6  | BSkyB Green Button:Standard  |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TMCOLSR14   | TMCOLSR14 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TMCOLSR15   | TMCOLSR15 |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TMCOLSR16   | TMCOLSR16 |
And complete order contains item with clock number '<ClockNumber4>' with following fields:
| Job Number  | PO Number |
| TMCOLSR17   | TMCOLSR17|
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber4>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber1>' will have next status 'In Progress' in Traffic
And waited till order with clockNumber '<ClockNumber2>' will have next status 'In Progress' in Traffic
And waited till order with clockNumber '<ClockNumber3>' will have next status 'In Progress' in Traffic
And waited till order with clockNumber '<ClockNumber4>' will have next status 'In Progress' in Traffic
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And I created tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type  |  Value    |
| Advertiser  |    Match        | TMCOLAR4  |
And waited till order list will be loaded
And I add multiple comment '<Comment>' for following clocks:
| clockNumber      |
| <ClockNumber1>   |
| <ClockNumber2>   |
| <ClockNumber3>   |
| <ClockNumber4>   |
And waited for '5' seconds
When am on order details page of clockNumber '<ClockNumber1>'
And refresh the page without delay
Then I should see comment '<Comment>' for clockNumber '<ClockNumber1>' in order details page
When I amon order item details page of clockNumber '<ClockNumber1>'
Then I should see comment '<Comment>' in order item details page
When I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And select exact search by '<Searchtype>' field and search criteria '<SearchString>' in simple search form on Traffic Order List page
And I added multiple comment '<Comment>' for following clocks  on traffic Order list:
| clockNumber      |
| <ClockNumber1>   |
| <ClockNumber2>   |
| <ClockNumber3>   |
| <ClockNumber4>   |
And I open Traffic Order List page
And I select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria '<ClockNumber1>' in simple search form on Traffic Order Item List page
Then I should see order with clockNumber '<ClockNumber1>' in traffic list that have following data:
| Last Comment |
| <Comment>     |

Examples:
| ClockNumber1 | ClockNumber2 | ClockNumber3 | ClockNumber4 | TabName     |  TabType           | Comment| Column        |Searchtype|SearchString|
|   TLCMCNN_1   |   TLCMCNN_2   |    TLCMCNN_3  |   TLCMCNN_4   | CL_AD_1  | Order Item (Clock) | AAAA    |Last Comment |Product   |TMCOLMP4    |


Scenario: Check that traffic manager can comment on order details page
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand       | Sub Brand   | Product     |
| TMCOLAR1    | TMCOLBR1   | TMCOLSB1    | TMCOLMP1    |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand  | Product     | Campaign    | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TMCOLAR1    | TMCOLBR1    | TMCOLSB1   | TMCOLMP1   | TMCOLMC1   | <ClockNumber1>    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMCOLSRT1  | BSkyB Green Button:Standard  |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TMCOLSR14   | TMCOLSR14 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
When am on order details page of clockNumber '<ClockNumber1>'
And refresh the page without delay
When I add comment '<Comment>' on order details page for clockNumber '<ClockNumber1>'
Then I should see comment '<Comment>' on order details page
Examples:
| ClockNumber1  | Comment  |
|   TLCMCN1     |  AAAA    |


Scenario: Check that traffic manager can comment on multiple clocks on order item details page
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser  | Brand       | Sub Brand   | Product     |
| TMCOLAR2    | TMCOLBR2   | TMCOLSB2    | TMCOLMP2    |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand  | Product     | Campaign    | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TMCOLAR2   | TMCOLBR2    | TMCOLSB2   | TMCOLMP2    | TMCOLMC2    | <ClockNumber1>    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMCOLSRT2  | BSkyB Green Button:Standard  |
| automated test info    | TMCOLAR3    | TMCOLBR3    | TMCOLSB3  | TMCOLMP3   | TMCOLMC3   | <ClockNumber2>    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TMCOLSRT3  | BSkyB Green Button:Standard  |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TMCOLSR2   | TMCOLSR2 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And am on order details page of clockNumber '<ClockNumber1>'
And waited for '5' seconds
And refreshed the page without delay
When I amon order item details page of clockNumber '<ClockNumber1>'
And I add comment '<Comment1>' on order item details page for clockNumber '<ClockNumber1>'
Then I should see comment '<Comment1>' in order item details page
When I open Traffic Order List page
And I amon order item details page of clockNumber '<ClockNumber2>'
When I add comment '<Comment2>' on order item details page for clockNumber '<ClockNumber2>'
Then I should see comment '<Comment2>' in order item details page
Examples:
| ClockNumber1  | Comment1  |ClockNumber2 | Comment2 |
|   TLCMCN2_1   |  AAAA     |TLCMCN2_2    | BBBB |

Scenario: Check that broadcaster can comment on destination level and should be visible under Last Comment field in list view
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand | Sub Brand | Product |
| TCAR1      | TCBR1 | TCSB1     | TCSP1   |
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |             Destination                |
| automated test info    | TCAR1      | TCBR1 | TCSB1     | TCSP1   | TBCCP1    | TBCCN1       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TBCT1     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TBCCN1' with following fields:
| Job Number  | PO Number |
| TBCJN1  | TBCPON1 |
And wait for finish place order with following item clock number 'TBCCN1' to A4
When I login with details of 'broadcasterTrafficManagerTwo'
And I amon order item details page of clockNumber 'TBCCN1'
When I click on comment icon for 'Motorvision TV'
And wait for '2' seconds
When I add comment 'AAAA' on order details page for clockNumber 'TAFCN1'
When I open Traffic Order List page
And wait till order item list will be loaded in Traffic
And enter search criteria 'TBCCN1' in simple search form on Traffic Order List page
And wait for '5' seconds
Then I should see destination 'Motorvision TV' for order item with clockNumber 'TBCCN1' in traffic order list that have following data:
|     Last Comment    |
|     AAAA            |


Scenario: Check that broadcaster cannot comment on clock level
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TBCAR2     | TBCBR2     | TBCSB2    | TBCSP2    |
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |             Destination                |
| automated test info    | TBCAR2     | TBCBR2     | TBCSB2     | TBCSP2   | TBCCP2    | TBCCN2       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TBCT2     |  Motorvision TV:Express   |
And complete order contains item with clock number 'TBCCN2' with following fields:
| Job Number  | PO Number |
| TBCJN2  | TBCPON2 |
And wait for finish place order with following item clock number 'TBCCN2' to A4
When I login with details of 'broadcasterTrafficManagerTwo'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And enter search criteria 'TBCCN2' in simple search form on Traffic Order List page
And open order item details page with clockNumber 'TBCCN2'
Then I should not see an option to comment at clock level



Scenario: Check that Last Comment can be sorted when broadcaster enters '*' in comments
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand | Sub Brand | Product |
| TCAR3      | TCBR3 | TCSB3     | TCSP3   |
And I logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |             Destination                |
| automated test info    | TCAR3      | TCBR3 | TCSB3     | TCSP3   | TBCCP3    | TBCCN3       | 20       | 12/14/2022    |      1      |   Already Supplied |HD 1080i 25fps  | TBCT3    |  Motorvision TV:Express   |
And complete order contains item with clock number 'TBCCN3' with following fields:
| Job Number  | PO Number |
| TBCJN3   | TBCPO3 |
And wait for finish place order with following item clock number 'TBCCN3' to A4
When I login with details of 'broadcasterTrafficManagerTwo'
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And I create tab with name 'sortLastComment' and type 'Order Item Send' and dataRange 'Today' and the following rules:
| Condition | Condition Type | Value |
| Market | Match | Germany |
And wait till order item list will be loaded in Traffic
And enter search criteria 'TBCCN3' in simple search form on Traffic Order List page
And I add comment '****AAAA' at tab level for clockNumber 'TBCCN3'
And clear search criteria in simple search form on Traffic Order List page
When I sort Order Items by field 'Last Comment' in order 'asc' from Order Level Send
Then I 'should' see the 'Last Comment' '****AAAA' listed at the top in the sorting results