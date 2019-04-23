Feature:          As Traffic Manager I should see SLA color for orders with respective service levels
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that As Traffic Manager I should see SLA color for orders having respective service levels

Scenario: Check whether SLA color is blue for an order with Standard service level
!--QA-726
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| ATMISSSCFOHRSLAR1     | ATMISSSCFOHRSLBR1  | ATMISSSCFOHRSLSB1    | ATMISSSCFOHRSLP1   |
And I create 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser  | Brand    | Product   | Campaign    | Clock Number        |Language  | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                |
| automated test info    | ATMISSSCFOHRSLAR1      | ATMISSSCFOHRSLBR1   | ATMISSSCFOHRSLP1     | ATMISSSCFOHRSLC1       | ATMISSSCFOHRSLCL1              |English   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | ATMISSSCFOHRSLTTL1    | AXN HD Portugal:Standard   |
And complete order contains item with clock number 'ATMISSSCFOHRSLCL1' with following fields:
| Job Number  | PO Number |
| ATMSLJO51     | ATMSLPO51   |
When I login with details of 'trafficManager'
And wait till order with clockNumber 'ATMISSSCFOHRSLCL1' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'ATMISSSCFOHRSLCL1' in simple search form on Traffic Order List page
Then I 'should' see SLA color as 'blue' for an order 'ATMISSSCFOHRSLCL1' with service level 'Standard' in Traffic order list page

Scenario: Check whether SLA color is orange for an order with Express service level
!--QA-726
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| ATMISSSCFOHRSLAR2     | ATMISSSCFOHRSLBR2  | ATMISSSCFOHRSLSB2    | ATMISSSCFOHRSLP2   |
And I create 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser  | Brand   |  Product   | Campaign    | Clock Number        |Language  | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                            |
| automated test info    | ATMISSSCFOHRSLAR2      | ATMISSSCFOHRSLBR2  |  ATMISSSCFOHRSLP2     | ATMISSSCFOHRSLC2       | ATMISSSCFOHRSLCL2              |English   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | ATMISSSCFOHRSLTTL2    | AXN HD Portugal:Express       |
And complete order contains item with clock number 'ATMISSSCFOHRSLCL2' with following fields:
| Job Number  | PO Number |
| ATMSLJO52     | ATMSLPO52   |
When I login with details of 'trafficManager'
And wait till order with clockNumber 'ATMISSSCFOHRSLCL2' will be available in Traffic
When I select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'ATMISSSCFOHRSLCL2' in simple search form on Traffic Order List page
Then I 'should' see SLA color as 'orange' for an order 'ATMISSSCFOHRSLCL2' with service level 'Express' in Traffic order list page

Scenario: Check whether SLA color is red for an order with Hot service level
!--QA-726
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| ATMISSSCFOHRSLAR3     | ATMISSSCFOHRSLBR3  | ATMISSSCFOHRSLSB3    | ATMISSSCFOHRSLP3   |
And I create 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser  | Brand   |  Product   | Campaign    | Clock Number        |Language  | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                            |
| automated test info    | ATMISSSCFOHRSLAR3      | ATMISSSCFOHRSLBR3  |  ATMISSSCFOHRSLP3     | ATMISSSCFOHRSLC3       | ATMISSSCFOHRSLCL3              |English   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | ATMISSSCFOHRSLTTL3    | ITV Ulster (UTV) - DO NOT USE:Red Hot (US)       |
And complete order contains item with clock number 'ATMISSSCFOHRSLCL3' with following fields:
| Job Number           | PO Number            |
| ATMSLJO53   | ATMSLPO53   |
When I login with details of 'trafficManager'
And wait till order with clockNumber 'ATMISSSCFOHRSLCL3' will be available in Traffic
When I select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'ATMISSSCFOHRSLCL3' in simple search form on Traffic Order List page
Then I 'should' see SLA color as 'red' for an order 'ATMISSSCFOHRSLCL3' with service level 'Red Hot (US)' in Traffic order list page

Scenario: Check whether SLA color is blue for an order with Standard (US) service level
!--QA-726
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| ATMISSSCFOHRSLAR4     | ATMISSSCFOHRSLBR4  | ATMISSSCFOHRSLSB4    | ATMISSSCFOHRSLP4   |
And I create 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser  | Brand   |  Product   | Campaign    | Clock Number        |Language  | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                            |
| automated test info    | ATMISSSCFOHRSLAR4      | ATMISSSCFOHRSLBR4  |  ATMISSSCFOHRSLP4     | ATMISSSCFOHRSLC4       | ATMISSSCFOHRSLCL4              |English   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | ATMISSSCFOHRSLTTL3    | !Adstream Internal Destination - MPEG2 50i:Standard (US)      |
And complete order contains item with clock number 'ATMISSSCFOHRSLCL4' with following fields:
| Job Number  | PO Number |
| ATMSLJO54     | ATMSLPO54   |
When I login with details of 'trafficManager'
And wait till order with clockNumber 'ATMISSSCFOHRSLCL4' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'ATMISSSCFOHRSLCL4' in simple search form on Traffic Order List page
Then I 'should' see SLA color as 'blue' for an order 'ATMISSSCFOHRSLCL4' with service level ' Standard (US) ' in Traffic order list page

Scenario: Check whether SLA color is blue for an order with Express (US) service level
!--QA-726
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| ATMISSSCFOHRSLAR5     | ATMISSSCFOHRSLBR5  | ATMISSSCFOHRSLSB5    | ATMISSSCFOHRSLP5   |
And I create 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser  | Brand   |  Product   | Campaign    | Clock Number        |Language  | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                            |
| automated test info    | ATMISSSCFOHRSLAR5      | ATMISSSCFOHRSLBR5  |  ATMISSSCFOHRSLP5     | ATMISSSCFOHRSLC5       | ATMISSSCFOHRSLCL5              |English   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | ATMISSSCFOHRSLTTL3    | !Adstream Internal Destination - MPEG2 50i:Express (US) |
And complete order contains item with clock number 'ATMISSSCFOHRSLCL5' with following fields:
| Job Number  | PO Number |
| ATMSLJO55     | ATMSLPO55   |
When I login with details of 'trafficManager'
And wait till order with clockNumber 'ATMISSSCFOHRSLCL5' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'ATMISSSCFOHRSLCL5' in simple search form on Traffic Order List page
Then I 'should' see SLA color as 'orange' for an order 'ATMISSSCFOHRSLCL5' with service level 'Express (US)' in Traffic order list page

Scenario: Check whether SLA color is black for an order with Overnight only service level
!--QA-726
!-- Skip tag added due to QA-816
Meta:@skip
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| ATMISSSCFOHRSLAR6     | ATMISSSCFOHRSLBR6  | ATMISSSCFOHRSLSB6    | ATMISSSCFOHRSLP6   |
And I create 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser  | Brand   |  Product   | Campaign    | Clock Number        |Language  | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                            |
| automated test info    | ATMISSSCFOHRSLAR6      | ATMISSSCFOHRSLBR6  |  ATMISSSCFOHRSLP6     | ATMISSSCFOHRSLC6       | ATMISSSCFOHRSLCL6              |English   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | ATMISSSCFOHRSLTTL6    | Test Dest - Traffic 001:Overnight |
And complete order contains item with clock number 'ATMISSSCFOHRSLCL6' with following fields:
| Job Number  | PO Number |
| ATMSLJO56     | ATMSLPO56   |
When I login with details of 'trafficManager'
And wait till order with clockNumber 'ATMISSSCFOHRSLCL6' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'ATMISSSCFOHRSLCL6' in simple search form on Traffic Order List page
Then I 'should' see SLA color as 'black' for an order 'ATMISSSCFOHRSLCL6' with service level 'Overnight' in Traffic order list page

Scenario: Check whether SLA color is black for an order with Next Day service level
!--QA-727
!-- Skip tag added due to QA-816
Meta:@skip
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| ATMISSSCFOHRSLAR7     | ATMISSSCFOHRSLBR7  | ATMISSSCFOHRSLSB7    | ATMISSSCFOHRSLP7   |
And I create 'tv' order with market 'other countries' and items with following fields:
| Additional Information | Advertiser  | Brand   |  Product   | Campaign    | Clock Number        |Language  | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                            |
| automated test info    | ATMISSSCFOHRSLAR7      | ATMISSSCFOHRSLBR7  |  ATMISSSCFOHRSLP7     | ATMISSSCFOHRSLC7       | ATMISSSCFOHRSLCL7              |English   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | ATMISSSCFOHRSLTTL7    | America TV HD:Next Day |
And complete order contains item with clock number 'ATMISSSCFOHRSLCL7' with following fields:
| Job Number  | PO Number |
| ATMSLJO57     | ATMSLPO57   |
When I login with details of 'trafficManager'
And wait till order with clockNumber 'ATMISSSCFOHRSLCL7' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'ATMISSSCFOHRSLCL7' in simple search form on Traffic Order List page
Then I 'should' see SLA color as 'black' for an order 'ATMISSSCFOHRSLCL7' with service level 'Next Day' in Traffic order list page
