!--ORD-688
!--ORD-3583
Feature: Add version and Delivery Title to Netherlands
Narrative:
In order to:
As a AgencyAdmin
I want to check version and Delivery Title for Netherlands

Scenario: check autogenerating Delivery title after filling some of Add Information fields
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'Netherlands' and items with following fields:
| Clock Number |
| AVDTNCN1     |
When I open order item with following clock number 'AVDTNCN1'
And fill following fields for Add information form on order item page:
| Advertiser | Brand    | Sub Brand | Product  | Duration | Title   | Version |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | 20       | AVDTNT1 | v4      |
Then I should see following data for order item on Add information form:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version | Delivery Title                    |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN1     | 20       | AVDTNT1 | v4      | AVDTNPR1_AVDTNT1_20_v4_DD-MM-YYYY |

Scenario: check Delivery title after save as draft order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'Netherlands' and items with following fields:
| Clock Number |
| AVDTNCN2     |
When I open order item with following clock number 'AVDTNCN2'
And fill following fields for Add information form on order item page:
| Advertiser | Brand    | Sub Brand | Product  | Duration | Title   | Version |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | 15       | AVDTNT2 | v2      |
And save as draft order
And open order item with following clock number 'AVDTNCN2'
Then I should see following data for order item on Add information form:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version | Delivery Title                    |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN2     | 15       | AVDTNT2 | v2      | AVDTNPR1_AVDTNT2_15_v2_DD-MM-YYYY |

Scenario: check cleaning fields Delivery Title and Version
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'Netherlands' and items with following fields:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN3     | 15       | AVDTNT3 | v3      |
When I open order item with following clock number 'AVDTNCN3'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Version | Delivery Title |
| v1      | v1_DD-MM-YYYY  |

Scenario: check fields Delivery Title and Version after copy current
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'Netherlands' and items with following fields:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN4     | 15       | AVDTNT4 | v5      |
When I open order item with following clock number 'AVDTNCN4'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data for order item on Add information form:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version | Delivery Title                    |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN4     | 15       | AVDTNT4 | v5      | AVDTNPR1_AVDTNT4_15_v5_DD-MM-YYYY |

Scenario: check fields Delivery Title and Version after copy to all
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'Netherlands' and items with following fields:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN5_1   | 20       | AVDTNT5 | v2      |
|            |          |           |          | AVDTNCN5_2   |          |         |         |
When I open order item with following clock number 'AVDTNCN5_1'
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following clock number 'AVDTNCN5_1' on cover flow
Then I should see following data for order item on Add information form:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version | Delivery Title                    |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN5_1   | 20       | AVDTNT5 | v2      | AVDTNPR1_AVDTNT5_20_v2_DD-MM-YYYY |

Scenario: check fields Delivery Title and Version after proceeding order and coming back
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'Netherlands' and items with following fields:
| Additional Information | Campaign | Clock Number | First Air Date | Format         | Destination         |
| automated test info    | AVDTNC6  | AVDTNCN6     | 10/14/2022     | HD 1080i 25fps | Youtube NL:Standard |
When I open order item with following clock number 'AVDTNCN6'
And fill following fields for Add information form on order item page:
| Advertiser | Brand    | Sub Brand | Product  | Duration | Title   | Version |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | 20       | AVDTNT6 | v3      |
And click Proceed button on order item page
And back to order item page from Order Proceed page
Then I should see following data for order item on Add information form:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version | Delivery Title                    |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN6     | 20       | AVDTNT6 | v3      | AVDTNPR1_AVDTNT6_20_v3_DD-MM-YYYY |

Scenario: check fields Delivery Title and Version after adding QC asset
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNC7  | AVDTNCN7_1   | 20       | 10/14/2022     | HD 1080i 25fps | AVDTNT7 | Adtext             | BSkyB Green Button:Standard |
And create 'tv' order with market 'Netherlands' and items with following fields:
| Clock Number |
| AVDTNCN7_2   |
And complete order contains item with clock number 'AVDTNCN7_1' with following fields:
| Job Number | PO Number |
| AVDTNJN7   | AVDTNPN7  |
And add to 'tv' order item with clock number 'AVDTNCN7_2' following qc asset 'AVDTNT7' of collection 'My Assets'
When I open order item with clock number 'AVDTNCN7_1' for order with market 'Netherlands'
Then I should see following data for order item on Add information form:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title   | Version | Delivery Title                    |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN7_1   | 20       | AVDTNT7 | v1      | AVDTNPR1_AVDTNT7_20_v1_DD-MM-YYYY |
And should see 'disabled' following fields 'Delivery Title,Version' for order item on Add information form


Scenario: check validation for Delivery Title field (100 symbols only)
!--ORD-3730
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'Netherlands' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | First Air Date | Format         | Duration | Title                                                                                                              | Version | Destination         |
| automated test info    | AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNC9  | AVDTNCN9     | 10/14/2022     | HD 1080i 25fps | 15       | Phantasy Sound Under Exclusive License to Because Music And New Movies Blockbusters And Top Favorite Clips AVDTNT9 | v3      | Youtube NL:Standard |
When I open order item with following clock number 'AVDTNCN9'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'Delivery Title' for order item on Add information form

Scenario: Check changing of special symbols for Delivery Title
!--ORD-3872
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| AVDTNA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| AVDTNU1 | agency.admin | AVDTNA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVDTNA1':
| Advertiser | Brand    | Sub Brand | Product  |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 |
And logged in with details of 'AVDTNU1'
And create 'tv' order with market 'Netherlands' and items with following fields:
| Clock Number |
| AVDTNCN10    |
When I open order item with following clock number 'AVDTNCN10'
And fill following fields for Add information form on order item page:
| Advertiser | Brand    | Sub Brand | Product  | Duration | Title                                       | Version |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | 20       | ç ø'åûôîêâùìèàßõñãÿüöïëäúóíéá€%"&+ AVDTNT10 | v4      |
Then I should see following data for order item on Add information form:
| Advertiser | Brand    | Sub Brand | Product  | Clock Number | Duration | Title                                       | Version | Delivery Title                                                                      |
| AVDTNAR1   | AVDTNBR1 | AVDTNSB1  | AVDTNPR1 | AVDTNCN10    | 20       | ç ø'åûôîêâùìèàßõñãÿüöïëäúóíéá€%"&+ AVDTNT10 | v4      | AVDTNPR1_c-oauoieauieasonayuoieauoieaeuroprocentsecenplus-AVDTNT10_20_v4_DD-MM-YYYY |