!--QA-249
Feature:          GDN Ingest and Delivery
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 True Delivery Retranscode Asset


Scenario: Change Durations and Retranscode of Asset
Meta:@GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA44  | DefaultA4User  |  Advertiser |      ordering      |
| GDNTDTI44 | DefaultA4User  |   Ingest    |       adpath       |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU44 |       agency.admin  |   GDNTDA44  | ordering |
| GDNTDTM44| traffic.traffic.manager |   GDNTDTI44  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA44':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR44 | GDNTDBR44 | GDNTDSB44 | GDNTDP44 |
And logged in with details of 'GDNTDU44'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR44 | GDNTDBR44 | GDNTDSB44 | GDNTDP44 | GDNTDC44 |GDNTDCN44_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT44 | Moviepilot:Standard;dailyme:Standard;Filmstarts:Standard;IP Deutschland (online):Standard;kino.de:Standard|
And complete order contains item with clock number 'GDNTDCN44_1' with following fields:
| Job Number  | PO Number |
| GDNTD4444   | GDNTD4444 |
And wait for finish place order with following item clock number 'GDNTDCN44_1' to A4
When ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | GDNTDA44 | GDNTDCN44_1  |
And login with details of 'GDNTDTM44'
And wait till order item with clockNumber 'GDNTDCN44_1' will have next status 'TVC Ingested OK' in Traffic
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And enter search criteria 'GDNTDCN44_1' in simple search form on Traffic Order Item List page
And expand all orders on Traffic Order List page
And open order item details page with clockNumber 'GDNTDCN44_1'
Then I 'should' see playable preview on order item details page in traffic
And login with details of 'GDNTDU44'
And set assest Durations:
| OrderingEmail | adpathEmail | clockNumber |
| GDNTDU44      | GDNTDTM44   | GDNTDCN44_1 |
And retranscode assest:
| OrderingEmail | adpathEmail | clockNumber |
| GDNTDU44      | GDNTDTM44   | GDNTDCN44_1 |
And read asset duration for retranscode action