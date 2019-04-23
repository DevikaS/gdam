!--QA-381
Feature:          Re-ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery for Re-ingest

Scenario: A5 Re-Ingest and Delivery for German Markets
Destination1 ApprovalOnly true
Destination2 ApprovalOnly false if ApprovalOnly false, there won't be any delivery if reingest.
Meta:@GDN
Given modify Destination collection for following fields:
| DestinationName | HoldForApproval | HouseNumberMandatory | ProxyApprove | ApprovalOnly |
|    Westwing     |  true           |  true                |  true        |  true      |
And refresh destinations
And I created the following agency:
| Name   |    A4User     |
| GDNTDA28 | DefaultA4User |
And created users with following fields:
| Email  | Role          | AgencyUnique |
| GDNTDU28 | agency.admin | GDNTDA28     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA28':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR28 | GDNTDBR28 | GDNTDSB28 | GDNTDP28 |
And logged in with details of 'GDNTDU28'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format         | Title  | Destination         |
| automated test info    | GDNTDAR28   | GDNTDBR28   | GDNTDSB28   | GDNTDP28   | GDNTDC28   |GDNTDCN28_1    | 20       | 12/14/2022     |   AutoTest  |HD 1080i 25fps  | GDNTDT28 | kino.de:Standard;Westwing:Standard|
And complete order contains item with clock number 'GDNTDCN28_1' with following fields:
| Job Number  | PO Number |
| GDNTD2828   | GDNTD2828 |
And wait for finish place order with following item clock number 'GDNTDCN28_1' to A4
When ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA28    | GDNTDCN28_1  |
And find 'DeliveryJobResponse' to the '1' destinations
Then set assest status to 'New' for following fields:
| Email   | clockNumber |
| GDNTDU28| GDNTDCN28_1 |
And wait for '20' seconds
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN28_1 |
Then ingest assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA28    | GDNTDCN28_1  |
And find 'DeliveryJobResponse' to the '1' destinations



Scenario: Select asset from Library which is QC and Ingested and Redeliver for German Markets
Meta:@GDN
Given modify Destination collection for following fields:
| DestinationName | HoldForApproval | HouseNumberMandatory | ProxyApprove | ApprovalOnly |
|    Westwing     |  true           |  true                |  true        |  true        |
And refresh destinations
And I created the following agency:
| Name        | A4User    | Country    |
| GDNTDA29 | DefaultA4User | Germany |
And I updated the following agency:
| Name    | Save In Library | Allow To Save In Library |
| GDNTDA29 | should          | should                   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GDNTDU29 | agency.admin | GDNTDA29    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA29':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR29   | GDNTDBR29   | GDNTDSB29   | GDNTDP29   |
And logged in with details of 'GDNTDU29'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Motivnummer |Format         | Title      | Subtitles Required |
| automated test info    | GDNTDAR29    | GDNTDBR29    | GDNTDSB29    | GDNTDP29     | GDNTDC29    | GDNTDCN29_1     | 20       | 10/14/2022     | AutoTest    |SD PAL 16x9 | GDNTDT29    | None               |
When I open order item with following clock number 'GDNTDCN29_1'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD29_1 | GDNTD29 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'GDNTDCN29_1' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA29    | GDNTDCN29_1  |
And created 'tv' order with market 'Germany' and items with following fields:
| Clock Number   | Destination     |
| GDNTDCN29_2    | Westwing:Standard;Moviepilot:Standard |
And I open order item with following clock number 'GDNTDCN29_2'
And add to order for order item at Add media to your order form following assets 'GDNTDT29'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD29_2 | GDNTD29_2 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'GDNTDCN29_1' to A4
Then find 'DeliveryJobResponse' to the '1' destinations
And set assest status to 'New' for following fields:
| Email   | clockNumber |
| GDNTDU29| GDNTDCN29_1 |
And wait for '20' seconds
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN29_1 |
And ingest assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA29    | GDNTDCN29_1  |
And find 'DeliveryJobResponse' to the '1' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN29_1 |  GDNTDU29 | GDNTDAR29 | GDNTDP29 | AutoTest | GDNTDT29 | GDNTDC29 | GDNTDA29 |


Scenario: Select asset from Library which is QC and Ingested and Redeliver for German Markets
Meta:@GDN

Given modify Destination collection for following fields:
| DestinationName | HoldForApproval | HouseNumberMandatory | ProxyApprove | ApprovalOnly |
|    Westwing     |  true           |  true                |  true        |  true        |
And refresh destinations
And I created the following agency:
| Name        | A4User    | Country    |
| GDNTDA30 | DefaultA4User | Germany |
And I updated the following agency:
| Name    | Save In Library | Allow To Save In Library |
| GDNTDA30 | should          | should                   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GDNTDU30 | agency.admin | GDNTDA30    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA30':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR30   | GDNTDBR30   | GDNTDSB30   | GDNTDP30   |
And logged in with details of 'GDNTDU30'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Motivnummer |Format         | Title      | Subtitles Required |
| automated test info    | GDNTDAR30    | GDNTDBR30    | GDNTDSB30    | GDNTDP30     | GDNTDC30    | GDNTDCN30_1     | 20       | 10/14/2022     | AutoTest    |SD PAL 16x9 | GDNTDT30    | None               |
| automated test info    | GDNTDAR30    | GDNTDBR30    | GDNTDSB30    | GDNTDP30     | GDNTDC30    | GDNTDCN30_2     | 20       | 10/14/2022     | AutoTest    |SD PAL 16x9 | GDNTDT30    | None               |
When I open order item with following clock number 'GDNTDCN30_1'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And save as draft order
And I open order item with following clock number 'GDNTDCN30_2'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD30_12 | GDNTD30_12 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'GDNTDCN30_1' to A4
And created 'tv' order with market 'Germany' and items with following fields:
| Clock Number   | Destination     |
| GDNTDCN30_3    | Westwing:Standard;kino.de:Standard |
| GDNTDCN30_4    | Westwing:Standard;MediaGroup One:Standard;Filmstarts:Standard |
And I open order item with following clock number 'GDNTDCN30_3'
And add to order for order item at Add media to your order form following assets 'GDNTDCN30_1'
And save as draft order
And I open order item with following clock number 'GDNTDCN30_4'
And add to order for order item at Add media to your order form following assets 'GDNTDCN30_2'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD30_34 | GDNTD30_34 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'GDNTDCN30_1' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA30    | GDNTDCN30_1  |
| GDNTDA30    | GDNTDCN30_2  |
Then find 'DeliveryJobResponse' to the '3' destinations
And set assest status to 'New' for following fields:
| Email   | clockNumber |
| GDNTDU30| GDNTDCN30_1 |
| GDNTDU30| GDNTDCN30_2 |
And wait for '20' seconds
And verify ingest doc for following fields:
| status | clockNumber |
|  New   | GDNTDCN30_1 |
|  New   | GDNTDCN30_2 |
And ingest assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA30    | GDNTDCN30_1  |
| GDNTDA30    | GDNTDCN30_2  |
And find 'DeliveryJobResponse' to the '2' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN30_1 |  GDNTDU30 | GDNTDAR30 | GDNTDP30 | AutoTest | GDNTDT30 | GDNTDC30 | GDNTDA30 |
| GDNTDCN30_2 |  GDNTDU30 | GDNTDAR30 | GDNTDP30 | AutoTest | GDNTDT30 | GDNTDC30 | GDNTDA30 |
