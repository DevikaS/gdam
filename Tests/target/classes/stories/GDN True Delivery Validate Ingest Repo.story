!--QA-391
Feature:          Validate Ingest Repo when Order Edit
Narrative:
In order to
As a              AgencyAdmin
I want to         check Ingest Repo when Order Edit


Scenario: Check that after order editing , change fields are replicated to Ingest Repo
Meta: GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA38  | DefaultA4User  |  Advertiser |      ordering      |
| GDNTDTI38 | DefaultA4User  |   Ingest    |       adpath       |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU38 |       agency.admin  |   GDNTDA38  | ordering |
| GDNTDTM38| traffic.traffic.manager |   GDNTDTI38  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA38':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR38 | GDNTDBR38 | GDNTDSB38 | GDNTDP38 |
And logged in with details of 'GDNTDU38'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR38 | GDNTDBR38 | GDNTDSB38 | GDNTDP38 | GDNTDC38 |GDNTDCN38_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT38 | Moviepilot:Standard|
And completed order contains item with clock number 'GDNTDCN38_1' with following fields:
| Job Number  | PO Number |
| GDNTD3838   | GDNTD3838 |
And waited for finish place order with following item clock number 'GDNTDCN38_1' to A4
And login with details of 'GDNTDTM38'
And select 'All' tab in Traffic UI
And refresh the page
And open edit page for order with Clock Number 'GDNTDCN38_1' in Traffic
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Clock #            | GDNTDCN38_2       |
| Title              | GDNTDT38_2       |
| Advertiser         | GDNTDAR38_2       |
| Brand              | GDNTDBR38_2      |
| Sub Brand          | GDNTDSB38_2        |
| Product            | GDNTDP38_2        |
| Duration           | 60s               |
| First Air Date     |  12/16/2021       |
And click proceed button on Traffic Order Edit page
And fill following fields on Order Proceed page:
| Job Number         | PO Number        |
|  GDNTD382382         | GDNTD382382  |
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And login with details of 'GDNTDU38'
Then verify ingest doc for following fields:
|clockNumber  | Title    | Advertiser  | Duration | First Air Date |
| GDNTDCN38_2 | GDNTDT38_2 | GDNTDAR38_2   |   60     |  12/16/2021    |


Scenario: Check that after order editing , change fields and Destinations, then Ingest
Meta: GDN
Given I created the following agency:
| Name     |    A4User      | AgencyType  | Application Access |
| GDNTDA39  | DefaultA4User  |  Advertiser |      ordering      |
| GDNTDTI39 | DefaultA4User  |   Ingest    |       adpath       |
And created users with following fields:
| Email   |           Role      | AgencyUnique  |  Access  |
| GDNTDU39 |       agency.admin  |   GDNTDA39  | ordering |
| GDNTDTM39| traffic.traffic.manager |   GDNTDTI39  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GDNTDA39':
| Advertiser | Brand      | Sub Brand  | Product   |
| GDNTDAR39 | GDNTDBR39 | GDNTDSB39 | GDNTDP39 |
And logged in with details of 'GDNTDU39'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand| Product | Campaign  | Clock Number | Duration | First Air Date | Motivnummer | Format     | Title  | Destination         |
| automated test info    | GDNTDAR39 | GDNTDBR39 | GDNTDSB39 | GDNTDP39 | GDNTDC39 |GDNTDCN39_1 | 20       | 12/14/2022     |   AutoTest    |HD 1080i 25fps | GDNTDT39 | Moviepilot:Standard|
And completed order contains item with clock number 'GDNTDCN39_1' with following fields:
| Job Number  | PO Number |
| GDNTD3939   | GDNTD3939 |
And waited for finish place order with following item clock number 'GDNTDCN39_1' to A4
And login with details of 'GDNTDTM39'
And select 'All' tab in Traffic UI
And refresh the page
And open edit page for order with Clock Number 'GDNTDCN39_1' in Traffic
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Clock #            | GDNTDCN39_2       |
| Title              | GDNTDT39_2        |
| Advertiser         | GDNTDAR39_2        |
| Brand              | GDNTDBR39_2         |
| Sub Brand          | GDNTDSB39_2         |
| Product            | GDNTDP39_2         |
| Duration           | 60s               |
| First Air Date     |  12/16/2021       |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard     |
| kino.de      |
And click proceed button on Traffic Order Edit page
And fill following fields on Order Proceed page:
| Job Number         | PO Number        |
|  GDNTD392392         | GDNTD392392  |
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And login with details of 'GDNTDU39'
Then verify ingest doc for following fields:
|clockNumber  | Title    | Advertiser  | Duration | First Air Date |
| GDNTDCN39_2 | GDNTDT39_2 | GDNTDAR39_2   |   60     |  12/16/2021 |
And ingest assests through A5 with following fields:
| agencyName | clockNumber |
| GDNTDA39   | GDNTDCN39_2 |
And find 'DeliveryJobResponse' to the '2' destinations
And read delivery job response with following fields:
| ClockNumberList | Email | Advertiser | Product | Motivnummer | Title | Campaign| AgencyUnique |
| GDNTDCN39_2 |  GDNTDU39 | GDNTDAR39_2 | GDNTDP39_2 | AutoTest | GDNTDT39_2 | GDNTDC39 | GDNTDA39 |