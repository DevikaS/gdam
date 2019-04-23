Feature:    Traffic Billing
Narrative:
In order to
As a              AgencyAdmin
I want to check billing after order editing

Scenario: Check that after adding add/remove destination and changing SLA billing is updated
Meta: @traffic
      @tbug
 !-- Open bug NIR-776
Given I created the following agency:
| Name       |    A4User     | AgencyType     | Application Access                    | Country        | SAP ID       |
| TBCASap2N  | DefaultA4User |  Agency        |folders,adkits,streamlined_library,ordering        | United Kingdom | DefaultSapID |
And created users with following fields:
| Email           |             Role          | AgencyUnique |  Access                            |
| TBCU2_sapN       | agency.admin              | TBCASap2N     | folders,adkits,streamlined_library,ordering    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TBCASap2N':
| Advertiser | Brand  | Sub Brand  | Product   |
| TBCAR1N     | TBCBR1N | TBCSB1N     | TBCSP1N |
And logged in with details of 'TBCU2_sapN'
And 'enable' Billing Service
When created 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                                                     |
| automated test info    | TBCAR1N     | TBCBR1N | TBCSB1N    | TBCSP1N  | TTVBTVSC1N | TBCCN1_1N     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBB1N  | TV Rio:Standard (US);MONTECARLO TV - Canal 4:Standard (US)  |
| automated test info    | TBCAR1N     | TBCBR1N | TBCSB1N    | TBCSP1N  | TTVBTVSC1N | TBCCN3_1N     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBB1N  | TV Rio:Standard (US);MONTECARLO TV - Canal 4:Standard (US)  |
And create for 'tv' order with item clock number 'TBCCN1_1N' production additional services with following fields:
| Type       | Notes                |
| Reslate SD | automated test notes |
And create for 'tv' order with item clock number 'TBCCN3_1N' production additional services with following fields:
| Type       | Notes                |
| Reslate SD | automated test notes |
And created for 'tv' order with item clock number 'TBCCN1_1N' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | SPMUKDN1N     | Avid DNxHD | Same as Master | Compile 1     | 5          | SPMUKDN1N SPMUKCnN1_1 SPMUKCD1_1 SPMUKSA1_1 SPMUKC1_1 SPMUKPC1_1 SPMUKC1_1 | automated test notes  | should     | should not |
And created for 'tv' order with item clock number 'TBCCN3_1N' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                          | Notes & Labels        | Standard   | Express |
| Data DVD | SPMUKDN1N    | Avid DNxHD | Same as Master | Compile 1     | 3          | SPMUKDN1N SPMUKCnN1_1 SPMUKCD1_1 SPMUKSA1_1 SPMUKC1_1 SPMUKPC1_1 SPMUKC1_1 | automated test notes  | should not | should  |
And created additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     |  Market        |
| Physical | BNPDN2N          | BNPCN2        | BNPCD2          | BNPSA2         | BNPC2       | BNPPC2       | BNPC2       | Uruguay        |
When I open order item with following clock number 'TBCCN1_1N'
And click active Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_1N'
Then I should see following Billing data on Order Proceed page:
| Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax    | Total     |
|SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 1,094.00    | 229.74 | 1,323.74  |
|Dubbing Service: Data DVD - Standard International UY               | 5   |  32.00    | 160.00        | 1,094.00    | 229.74 | 1,323.74  |
|Production service: Reslate SD UY                                   | 1   | 116.00    | 116.00        | 1,094.00    | 229.74 | 1,323.74  |
|SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 1,094.00    | 229.74 | 1,323.74  |
|Dubbing Service: Data DVD - Express International UY                | 3   | 34.00     | 102.00        | 1,094.00    | 229.74 | 1,323.74  |
|Production service: Reslate SD UY                                   | 1   | 116.00    | 116.00        | 1,094.00    | 229.74 | 1,323.74  |
When I completed order contains item with clock number 'TBCCN1_1N' with following fields:
| Job Number  | PO Number |
| TTVBTVS11N   | TTVBTVS11N |
And I login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN1_1N' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And wait till order with clockNumber 'TBCCN1_1N' will have next status 'In Progress' in Traffic
And enter search criteria 'TBCCN1_1N' in simple search form on Traffic Order Item List page
And wait till order with clockNumber 'TBCCN1_1N' will have next status 'In Progress' in Traffic
And open edit page for order with Clock Number 'TBCCN1_1N' in Traffic
And wait for '5' seconds
And fill following fields for Additional Services section on order item page:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies | Notes & Labels         | Standard   | Express    |
| Data DVD | BNPDN2N       | Avid DNxHD | SD PAL 16x9    | Compile 1     |   2       | automated test notes 1 | should     | should not |
And cancel following destinations for Select Broadcast Destinations form on order item page 'TV Rio'
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)     |
| Red TV Uruguay    |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And wait till order with clockNumber 'TBCCN1_1N' will be available in Traffic
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_1N'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock  | Item                                                   |  QTY  | Unit     | TotalPerItem   | Subtotal  | Tax     | Total      |
|TBCCN1_1N|Dubbing Service: Data DVD - Standard International      |  2    | 32.00    |  64.00         | 998.00    | 209.58  | 1,207.58   |
|TBCCN1_1N|SD International Standard Normal (Digital)              |  2    | 150.00   |  300.00        | 998.00    | 209.58  | 1,207.58   |
|TBCCN1_1N|Production service: Reslate SD                          |  1    | 116.00   | 116.00         | 998.00    | 209.58  | 1,207.58   |
|TBCCN1_1N|Dubbing Service: Data DVD - Express International       |  3    |  34.00   |  102.00        | 998.00    | 209.58  | 1,207.58   |
|TBCCN1_1N|SD International Standard Normal (Digital)              |  2    | 150.00   |  300.00        | 998.00    | 209.58  | 1,207.58   |
|TBCCN1_1N|Production service: Reslate SD                          |  1    | 116.00   |  116.00        | 998.00    | 209.58  | 1,207.58   |
When I click done button on Traffic Order Summary page
And I wait for '5' seconds
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TBCCN3_1N' will have next status 'In Progress' in Traffic
And open edit page for order with Clock Number 'TBCCN3_1N' in Traffic
And select order item with following clock number 'TBCCN3_1N' on Edit order page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express (US)  |
| TV Rio        |
And fill following fields for Production Services of Additional Services section on order item page:
| Type       | Notes                  |
| Tagging SD | automated test notes 1 |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And wait till order with clockNumber 'TBCCN3_1N' will be available in Traffic
And wait for Billing data on Order Proceed page specific to clock 'TBCCN3_1N'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock  || Item                                                   |  QTY  | Unit      | TotalPerItem    | Subtotal   | Tax     | Total      |
|TBCCN3_1N|Dubbing Service: Data DVD - Standard International      |  2    | 32.00     |  64.00          | 1,000.00   | 210.00  | 1,210.00   |
|TBCCN3_1N|SD International Standard Normal (Digital               |  2    | 150.00    |  300.00         | 1,000.00   | 210.00  | 1,210.00   |
|TBCCN3_1N|Production service: Tagging SD                          |  1    | 118.00    |  118.00         | 1,000.00   | 210.00  | 1,210.00   |
|TBCCN3_1N|Dubbing Service: Data DVD - Express International       |  3    | 34.00     |  102.00         | 1,000.00   | 210.00  | 1,210.00   |
|TBCCN3_1N|SD International Standard Normal (Digital)              |  2    | 150.00    |  300.00         | 1,000.00   | 210.00  | 1,210.00   |
|TBCCN3_1N|Production service: Reslate SD                          |  1    | 116.00    |  116.00         | 1,000.00   | 210.00  | 1,210.00   |


Scenario: Check billing as AgencyAdmin on updating destination in same clock
Meta: @traffic
Given I created the following agency:
| Name       |    A4User     | AgencyType     | Application Access                    | Country        | SAP ID       |
| TBCASap2Z  | DefaultA4User |  Agency        |folders,adkits,streamlined_library,ordering        | United Kingdom | DefaultSapID |
And created users with following fields:
| Email           |             Role          | AgencyUnique |  Access                            |
| TBCU2_sapZ       | agency.admin              | TBCASap2Z     | folders,adkits,streamlined_library,ordering    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TBCASap2Z':
| Advertiser  | Brand   | Sub Brand  | Product   |
| TBCAR1Z     | TBCBR1z | TBCSB1Z     | TBCSP1Z |
And logged in with details of 'TBCU2_sapZ'
And 'enable' Billing Service
When created 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product  | Campaign   | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                                                     |
| automated test info    | TBCAR1Z     | TBCBR1z | TBCSB1Z    | TBCSP1Z  | TTVBTVSC1Z | TBCCN1_1Z     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBB1N  | TV Rio:Standard (US);MONTECARLO TV - Canal 4:Standard (US)  |
When I open order item with following clock number 'TBCCN1_1Z'
And click active Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_1Z'
Then I should see following Billing data on Order Proceed page:
| Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax    | Total     |
|SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 300.00      |63.00   | 363.00    |
When I back to order item page from Order Proceed page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express (US)  |
| TV Rio        |
And click active Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_1Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock         | Item                                                   |  QTY  | Unit      | TotalPerItem    | Subtotal    | Tax    | Total     |
|TBCCN1_1Z     |SD International Express Normal (Digital)               | 1     | 300.00    | 300.00          | 450.00      | 94.50  | 544.50    |
|TBCCN1_1Z     |SD International Standard Normal (Digital)              | 1     | 150.00    | 150.00          | 450.00      | 94.50  | 544.50    |
When I completed order contains item with clock number 'TBCCN1_1Z' with following fields:
| Job Number  | PO Number  |
| VBPJN13     | VBPPN13    |
And I go to Order Summary page for order contains item with following clock number 'TBCCN1_1Z'
And I click View Billing button on the Order Summary Page
Then I should see that View 'Billing' report opens for order with clock number 'TBCCN1_1Z'
And I should see following Billing data on View Billing page specific to clocks:
|clock         | Item                                                   | QTY   | Unit      | TotalPerItem    | Subtotal    | Tax    | Total     |
|TBCCN1_1Z     |SD International Express Normal (Digital)               | 1     | 300.00    | 300.00          | 450.00      | 94.50  | 544.50    |
|TBCCN1_1Z     |SD International Standard Normal (Digital)              | 1     | 150.00    | 150.00          | 450.00      | 94.50  | 544.50    |


Scenario: Check billing as AgencyAdmin on updating new clock
Meta: @traffic
Given I created the following agency:
| Name       |    A4User     | AgencyType     | Application Access                    | Country        | SAP ID       |
| TBCASap2Z  | DefaultA4User |  Agency        |folders,adkits,streamlined_library,ordering        | United Kingdom | DefaultSapID |
And created users with following fields:
| Email           |             Role          | AgencyUnique |  Access                            |
| TBCU2_sapZ       | agency.admin              | TBCASap2Z     | folders,adkits,streamlined_library,ordering    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TBCASap2Z':
| Advertiser  | Brand   | Sub Brand  | Product   |
| TBCAR1Z     | TBCBR1z | TBCSB1Z     | TBCSP1Z |
And logged in with details of 'TBCU2_sapZ'
And 'enable' Billing Service
When created 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product  | Campaign   | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                                                     |
| automated test info    | TBCAR1Z     | TBCBR1z | TBCSB1Z    | TBCSP1Z  | TTVBTVSC1Z | TBCCN11_1Z     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBB1N  | TV Rio:Standard (US);MONTECARLO TV - Canal 4:Standard (US)  |
When I open order item with following clock number 'TBCCN11_1Z'
And click active Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN11_1Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock     | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax    | Total     |
|TBCCN11_1Z|SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 300.00      |63.00   | 363.00    |
When I back to order item page from Order Proceed page
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      |
| automated test info    | TBCAR1Z    | TBCBR1z   | TBCSB1Z   | TBCSP1Z   | TTVBTVSC1Z | TBCCN1_2Z    | 15       | 10/14/2022     | HD 1080i 25fps | TTVBB2N    |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)     |
| Red TV Uruguay    |
And click Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_2Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock     | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax    | Total     |
|TBCCN11_1Z|SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 450.00      |94.50   | 544.50    |
|TBCCN1_2Z |SD International Standard Normal (Digital) UY                       | 1   | 150.00    | 150.00        | 450.00      |94.50   | 544.50    |
When I completed order contains item with clock number 'TBCCN1_2Z' with following fields:
| Job Number  | PO Number  |
| VBPJN14     | VBPPN14    |
And I go to Order Summary page for order contains item with following clock number 'TBCCN1_2Z'
And I click View Billing button on the Order Summary Page
Then I should see that View 'Billing' report opens for order with clock number 'TBCCN1_2Z'
And I should see following Billing data on View Billing page specific to clocks:
|clock     | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax    | Total     |
|TBCCN11_1Z|SD International Standard Normal (Digital)                          | 2   | 150.00    | 300.00        | 450.00      |94.50   | 544.50    |
|TBCCN1_2Z |SD International Standard Normal (Digital)                          | 1   | 150.00    | 150.00        | 450.00      |94.50   | 544.50    |

Scenario: Check billing as Traffic Manager on updating destination in same clock
Meta: @traffic
Given I created the following agency:
| Name       |    A4User     | AgencyType     | Application Access                    | Country        | SAP ID       |
| TBCASap3Z  | DefaultA4User |  Agency        |folders,adkits,streamlined_library,ordering        | United Kingdom | DefaultSapID |
And created users with following fields:
| Email            |             Role          | AgencyUnique  |  Access                            |
| TBCU3_sapZ       | agency.admin              | TBCASap3Z     | folders,adkits,streamlined_library,ordering    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TBCASap3Z':
| Advertiser  | Brand   | Sub Brand  | Product   |
| TBCAR3Z     | TBCBR3z | TBCSB3Z     | TBCSP3Z |
And logged in with details of 'TBCU3_sapZ'
And 'enable' Billing Service
When created 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser  | Brand   | Sub Brand  | Product  | Campaign   | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                                                     |
| automated test info    | TBCAR3Z     | TBCBR3z | TBCSB3Z    | TBCSP3Z  | TTVBTVSC1Z | TBCCN1_3Z     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBB1N  | TV Rio:Standard (US);MONTECARLO TV - Canal 4:Standard (US)      |
When I open order item with following clock number 'TBCCN1_3Z'
And click active Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_3Z'
Then I should see following Billing data on Order Proceed page:
| Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax    | Total     |
|SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 300.00      |63.00   | 363.00    |
When fill following fields on Order Proceed page:
| Job Number | PO Number |
| JTBCCN1    | PTBCCN1   |
And confirm order on Order Proceed page
And I login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN1_3Z' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And wait till order with clockNumber 'TBCCN1_3Z' will have next status 'In Progress' in Traffic
And enter search criteria 'TBCCN1_3Z' in simple search form on Traffic Order Item List page
And wait till order with clockNumber 'TBCCN1_3Z' will have next status 'In Progress' in Traffic
And open edit page for order with Clock Number 'TBCCN1_3Z' in Traffic
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express (US)  |
| TV Rio        |
And click active Proceed button on order item page
And click confirm button on Traffic Order Summary page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_3Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock         | Item                                                   |  QTY  | Unit      | TotalPerItem    | Subtotal    | Tax    | Total     |
|TBCCN1_3Z     |SD International Express Normal (Digital)               | 1     | 300.00    | 300.00          | 450.00      | 94.50  | 544.50    |
|TBCCN1_3Z     |SD International Standard Normal (Digital)              | 1     | 150.00    | 150.00          | 450.00      | 94.50  | 544.50    |
When I logout from account
And I login with details of 'AgencyAdmin'
And login with details of 'TBCU3_sapZ'
When I go to Order Summary page for order contains item with following clock number 'TBCCN1_3Z'
And I click View Billing button on the Order Summary Page
Then I should see that View 'Billing' report opens for order with clock number 'TBCCN1_3Z'
And I should see following Billing data on View Billing page specific to clocks:
|clock         | Item                                                   |  QTY  | Unit      | TotalPerItem    | Subtotal    | Tax    | Total     |
|TBCCN1_3Z     |SD International Express Normal (Digital)               | 1     | 300.00    | 300.00          | 450.00      | 94.50  | 544.50    |
|TBCCN1_3Z     |SD International Standard Normal (Digital)              | 1     | 150.00    | 150.00          | 450.00      | 94.50  | 544.50    |


Scenario: Check billing as Traffic Manager on updating destination in Multiple clocks
Meta: @traffic
Given I created the following agency:
| Name       |    A4User     | AgencyType     | Application Access                    | Country        | SAP ID       |
| TBCASap9Z  | DefaultA4User |  Agency        |folders,adkits,streamlined_library,ordering        | United Kingdom | DefaultSapID |
And created users with following fields:
| Email           |             Role          | AgencyUnique |  Access                            |
| TBCU9_sapZ       | agency.admin              | TBCASap9Z     | folders,adkits,streamlined_library,ordering    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TBCASap9Z':
| Advertiser  | Brand   | Sub Brand  | Product   |
| TBCAR9Z     | TBCBR9z | TBCSB9Z     | TBCSP9Z |
And logged in with details of 'TBCU9_sapZ'
And 'enable' Billing Service
When created 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser  | Brand    | Sub Brand  | Product  | Campaign   | Clock Number   | Duration | First Air Date | Subtitles Required | Format          | Title      | Destination                                                     |
| automated test info    | TBCAR9Z     | TBCBR9z  | TBCSB9Z    | TBCSP9Z  | TTVBTVSC1Z | TBCCN1_12Z      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps   | TTVBB9N    | TV Rio:Standard (US);MONTECARLO TV - Canal 4:Standard (US)      |
| automated test info    | TBCAR9Z     | TBCBR9z | TBCSB9Z    | TBCSP9Z  | TTVBTVSC1Z | TBCCN1_13Z     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps   | TTVBB10N   | Fox Uruguay:Standard (US);Canal 8 Salto:Standard (US)           |
When I go to Order Proceed page for order contains order item with following clock number 'TBCCN1_13Z'
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_13Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock            | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax     | Total     |
|TBCCN1_12Z        |SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 600.00      |126.00   | 726.00    |
|TBCCN1_13Z       |SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 600.00      |126.00   | 726.00    |
When fill following fields on Order Proceed page:
| Job Number | PO Number |
| JTBCCN1    | PTBCCN1   |
And confirm order on Order Proceed page
And I login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN1_12Z' will be available in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And wait till order with clockNumber 'TBCCN1_12Z' will have next status 'In Progress' in Traffic
And enter search criteria 'TBCCN1_12Z' in simple search form on Traffic Order Item List page
And wait till order with clockNumber 'TBCCN1_12Z' will have next status 'In Progress' in Traffic
And open edit page for orderitem with Clock Number 'TBCCN1_12Z' in Traffic
And cancel following destinations for Select Broadcast Destinations form on order item page 'TV Rio'
And I wait for '10' seconds
And click active Proceed button on order item page
And click confirm button on Traffic Order Summary page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_12Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock      | Item                                                                | QTY | Unit      | TotalPerItem  | Subtotal    | Tax    | Total     |
|TBCCN1_12Z  |SD International Standard Normal (Digital)                          | 1   | 150.00    | 150.00        | 450.00      |94.50   | 544.50    |
|TBCCN1_13Z |SD International Standard Normal (Digital)                           | 2   | 150.00    | 300.00        | 450.00      |94.50   | 544.50    |
When I click done button on Traffic Order Summary page
And I wait for '5' seconds
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order with clockNumber 'TBCCN1_13Z' will have next status 'In Progress' in Traffic
And enter search criteria 'TBCCN1_13Z' in simple search form on Traffic Order Item List page
And wait till order with clockNumber 'TBCCN1_13Z' will have next status 'In Progress' in Traffic
And expand all orders on Traffic Order List page
And open edit page for orderitem with Clock Number 'TBCCN1_13Z' in Traffic
And I wait for '10' seconds
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)     |
| Sony Uruguay      |
And click active Proceed button on order item page
And click confirm button on Traffic Order Summary page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_13Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock            | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax     | Total     |
|TBCCN1_12Z       |SD International Standard Normal (Digital)                          | 1   | 150.00    | 150.00        | 600.00      |126.00   | 726.00    |
|TBCCN1_13Z       |SD International Standard Normal (Digital)                          | 3   | 150.00    | 450.00        | 600.00      |126.00   | 726.00    |
When I logout from account
And I login with details of 'AgencyAdmin'
And login with details of 'TBCU9_sapZ'
When I go to Order Summary page for order contains item with following clock number 'TBCCN1_13Z'
And I click View Billing button on the Order Summary Page
Then I should see that View 'Billing' report opens for order with clock number 'TBCCN1_13Z'
And I should see following Billing data on View Billing page specific to clocks:
|clock             | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax     | Total     |
|TBCCN1_12Z        |SD International Standard Normal (Digital)                          | 1   | 150.00    | 150.00        | 600.00      |126.00   | 726.00    |
|TBCCN1_13Z        |SD International Standard Normal (Digital)                          | 3   | 150.00    | 450.00        | 600.00      |126.00   | 726.00    |


Scenario: Check billing as AgencyAdmin on updating destination in Multiple clocks
Meta: @traffic
Given I created the following agency:
| Name       |    A4User     | AgencyType     | Application Access                    | Country        | SAP ID       |
| TBCASap9Z  | DefaultA4User |  Agency        |folders,adkits,streamlined_library,ordering        | United Kingdom | DefaultSapID |
And created users with following fields:
| Email           |             Role          | AgencyUnique |  Access                            |
| TBCU9_sapZ       | agency.admin              | TBCASap9Z     | folders,adkits,streamlined_library,ordering    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TBCASap9Z':
| Advertiser  | Brand   | Sub Brand  | Product   |
| TBCAR9Z     | TBCBR9z | TBCSB9Z     | TBCSP9Z |
And logged in with details of 'TBCU9_sapZ'
And 'enable' Billing Service
When created 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser  | Brand    | Sub Brand  | Product  | Campaign   | Clock Number   | Duration | First Air Date | Subtitles Required | Format          | Title      | Destination                                                     |
| automated test info    | TBCAR9Z     | TBCBR9z  | TBCSB9Z    | TBCSP9Z  | TTVBTVSC1Z | TBCCN1_9Z      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps   | TTVBB9N    | TV Rio:Standard (US);MONTECARLO TV - Canal 4:Standard (US)      |
| automated test info    | TBCAR9Z     | TBCBR10z | TBCSB9Z    | TBCSP9Z  | TTVBTVSC1Z | TBCCN1_10Z     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps   | TTVBB10N   | Fox Uruguay:Standard (US);Canal 8 Salto:Standard (US)           |
When I go to Order Proceed page for order contains order item with following clock number 'TBCCN1_10Z'
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_10Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock            | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax     | Total     |
|TBCCN1_9Z        |SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 600.00      |126.00   | 726.00    |
|TBCCN1_10Z       |SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 600.00      |126.00   | 726.00    |
When I open order item with following clock number 'TBCCN1_9Z'
And wait for '5' seconds
And 'uncheck' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)     |
| TV Rio            |
And click active Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_10Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock      | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax    | Total     |
|TBCCN1_9Z  |SD International Standard Normal (Digital) UY                       | 1   | 150.00    | 150.00        | 450.00      |94.50   | 544.50    |
|TBCCN1_10Z |SD International Standard Normal (Digital) UY                       | 2   | 150.00    | 300.00        | 450.00      |94.50   | 544.50    |
When I open order item with following clock number 'TBCCN1_10Z'
And wait for '5' seconds
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)     |
| Sony Uruguay      |
And click active Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_10Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock            | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal    | Tax     | Total     |
|TBCCN1_9Z        |SD International Standard Normal (Digital) UY                       | 1   | 150.00    | 150.00        | 600.00      |126.00   | 726.00    |
|TBCCN1_10Z       |SD International Standard Normal (Digital) UY                       | 3   | 150.00    | 450.00        | 600.00      |126.00   | 726.00    |
When I open order item with following clock number 'TBCCN1_10Z'
And 'create new' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      |
| automated test info    | TBCAR9Z    | TBCBR9z   | TBCSB9Z   | TBCSP9Z   | TTVBTVSC1Z | TBCCN1_11Z    | 15       | 10/14/2022     | HD 1080i 25fps | TTVBB11N    |
And wait for '5' seconds
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard (US)     |
|  TV Rio           |
And click Proceed button on order item page
And wait for Billing data on Order Proceed page specific to clock 'TBCCN1_10Z'
Then I should see following Billing data on Order Proceed page specific to clocks:
|clock            | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal     | Tax     | Total     |
|TBCCN1_9Z        |SD International Standard Normal (Digital) UY                       | 1   | 150.00    | 150.00        | 750.00       |157.50   | 907.50    |
|TBCCN1_10Z       |SD International Standard Normal (Digital) UY                       | 3   | 150.00    | 450.00        | 750.00       |157.50   | 907.50    |
|TBCCN1_11Z       |SD International Standard Normal (Digital) UY                       | 1   | 150.00    | 150.00        | 750.00       |157.50   | 907.50    |
When I completed order contains item with clock number 'TBCCN1_11Z' with following fields:
| Job Number   | PO Number   |
| VBPJN180     | VBPPN180    |
And I go to Order Summary page for order contains item with following clock number 'TBCCN1_9Z'
And I click View Billing button on the Order Summary Page
Then I should see that View 'Billing' report opens for order with clock number 'TBCCN1_9Z'
And I should see following Billing data on View Billing page specific to clocks:
|clock            | Item                                                               | QTY | Unit      | TotalPerItem  | Subtotal     | Tax     | Total     |
|TBCCN1_9Z        |SD International Standard Normal (Digital)                          | 1   | 150.00    | 150.00        | 750.00       |157.50   | 907.50    |
|TBCCN1_10Z       |SD International Standard Normal (Digital)                          | 3   | 150.00    | 450.00        | 750.00       |157.50   | 907.50    |
|TBCCN1_11Z       |SD International Standard Normal (Digital)                          | 1   | 150.00    | 150.00        | 750.00       |157.50   | 907.50    |