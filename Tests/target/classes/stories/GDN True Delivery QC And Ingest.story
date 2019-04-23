!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery for QC and assets

Scenario: A5 Ingest for QC and Ingest only German Markets
Meta:@GDN
Given I created the following agency:
| Name        | A4User    | Country    |
| GDNTDA5 | DefaultA4User | Germany |
And I updated the following agency:
| Name    | Save In Library | Allow To Save In Library |
| GDNTDA5 | should          | should                   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GDNTDU5 | agency.admin | GDNTDA5    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA5':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR5   | GDNTDBR5   | GDNTDSB5   | GDNTDP5   |
And logged in with details of 'GDNTDU5'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Motivnummer |Format         | Title      | Subtitles Required |
| automated test info    | GDNTDAR5    | GDNTDBR5    | GDNTDSB5    | GDNTDP5     | GDNTDC5    | GDNTDCN5_1     | 20       | 10/14/2022     | AutoTest    |SD PAL 16x9 | GDNTDT5    | None               |
When I open order item with following clock number 'GDNTDCN5_1'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD5 | GDNTD5 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'GDNTDCN5_1' to A4
Then ingest assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA5    | GDNTDCN5_1  |


Scenario: Select asset from Library which is QC and Ingested for German Markets
Meta:@GDN
Given I created the following agency:
| Name        | A4User    | Country    |
| GDNTDA6 | DefaultA4User | Germany |
And I updated the following agency:
| Name    | Save In Library | Allow To Save In Library |
| GDNTDA6 | should          | should                   |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| GDNTDU6 | agency.admin | GDNTDA6    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA6':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR6   | GDNTDBR6   | GDNTDSB6   | GDNTDP6   |
And logged in with details of 'GDNTDU6'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number   | Duration | First Air Date | Motivnummer |Format         | Title      | Subtitles Required |
| automated test info    | GDNTDAR6    | GDNTDBR6    | GDNTDSB6    | GDNTDP6     | GDNTDC6    | GDNTDCN6_1     | 20       | 10/14/2022     | AutoTest    |SD PAL 16x9 | GDNTDT6    | None               |
When I open order item with following clock number 'GDNTDCN6_1'
And do QC & Ingest Only for active order item at Select Broadcast Destinations
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD6_1 | GDNTD6 |
And confirm order on Order Proceed page
And wait for '1' seconds
And created 'tv' order with market 'Germany' and items with following fields:
| Clock Number   | Destination     |
| GDNTDCN6_2     | IP Deutschland (online):Standard;kino.de:Standard |
And I open order item with following clock number 'GDNTDCN6_2'
And add to order for order item at Add media to your order form following assets 'GDNTDCN6_1'
And click active Proceed button on order item page
And I fill following fields on Order Proceed page:
| Job Number   | PO Number    |
| GDNTD6_2 | GDNTD6_2 |
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'GDNTDCN6_1' to A4
And ingested assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA6    | GDNTDCN6_1  |
Then find 'DeliveryJobResponse' to the '2' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN6_1 |  GDNTDU6 | GDNTDAR6 | GDNTDP6 | AutoTest | GDNTDT6 | GDNTDC6 | GDNTDA6 |