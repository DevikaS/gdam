!--ORD-3245
!--ORD-3302
Feature: Advanced search within orders
Narrative:
In order to:
As a AgencyAdmin
I want to check advanced search within orders

Scenario: Search results by orders should be different for Tv and Music while do searching at tv tab
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser | Brand   | Sub Brand | Product |
| ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 |
And logged in with details of 'ASWOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | ASWOC1_1 | ASWOCN1_1    | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT1_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Artist   | ISRC Code | Duration | Release Date | Format         | Title    | Destination                 |
| automated test info    | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | ASWOC1_2 | ASWOCN1_2 | 15       | 10/14/2024   | HD 1080i 25fps | ASWOT1_2 | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ASWOCN1_1' with following fields:
| Job Number | PO Number |
| ASWOJN1    | ASWOPN1   |
And complete order contains item with isrc code 'ASWOCN1_2' with following fields:
| Job Number | PO Number |
| ASWOJN1    | ASWOPN1   |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By                                                                                               |
| Advertiser=ASWOAR1,Brand=ASWOBR1,Sub Brand=ASWOSB1,Product=ASWOPR1,PO Number=ASWOPN1,Job Number=ASWOJN1 |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number 'ASWOCN1_1' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | United Kingdom | ASWOPN1   | ASWOJN1 | 1        | 0/1 Delivered |
And 'should not' see 'own' order with following item clock number 'ASWOCN1_2' in 'live' order list

Scenario: Search results by orders should be different for Tv and Music while do searching at music tab
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser | Brand   | Sub Brand | Product |
| ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 |
And logged in with details of 'ASWOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | ASWOC2_1 | ASWOCN2_1    | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT2_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Artist   | ISRC Code | Duration | Release Date | Format         | Title    | Destination                 |
| automated test info    | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | ASWOC2_2 | ASWOCN2_2 | 15       | 10/14/2024   | HD 1080i 25fps | ASWOT2_2 | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ASWOCN2_1' with following fields:
| Job Number | PO Number |
| ASWOJN2    | ASWOPN2   |
And complete order contains item with isrc code 'ASWOCN2_2' with following fields:
| Job Number | PO Number |
| ASWOJN2    | ASWOPN2   |
And I am on View Draft Orders tab of 'music' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By                                                                                               |
| Advertiser=ASWOAR1,Brand=ASWOBR1,Sub Brand=ASWOSB1,Product=ASWOPR1,PO Number=ASWOPN2,Job Number=ASWOJN2 |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see Music order in 'live' order list with item isrc code 'ASWOCN2_2' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | United Kingdom | ASWOPN2   | ASWOJN2 | 1        | 0/1 Delivered |
And 'should not' see 'own' order with following item clock number 'ASWOCN2_1' in 'live' order list

Scenario: search orders by default advertiser structure
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser   | Brand   | Sub Brand  | Product   |
| <advertiser> | <brand> | <subBrand> | <product> |
And logged in with details of 'ASWOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand   | Sub Brand  | Product   | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination     |
| automated test info    | <advertiser> | <brand> | <subBrand> | <product> | ASWOC3   | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT3 | Already Supplied   | Aastha:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| ASWOJN3    | ASWOPN3   |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By  |
| <SearchBy> |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser   | Brand   | Sub Brand  | Product   | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | <advertiser> | <brand> | <subBrand> | <product> | United Kingdom | ASWOPN3   | ASWOJN3 | 1        | 0/1 Delivered |

Examples:
| advertiser | brand     | subBrand  | product   | ClockNumber | SearchBy                                                                   |
| ASWOAR3_1  | ASWOBR3_1 | ASWOSB3_1 | ASWOPR3_1 | ASWOCN3_1   | Advertiser=ASWOAR3_1                                                       |
| ASWOAR3_2  | ASWOBR3_2 | ASWOSB3_2 | ASWOPR3_2 | ASWOCN3_2   | Brand=ASWOBR3_2                                                            |
| ASWOAR3_3  | ASWOBR3_3 | ASWOSB3_3 | ASWOPR3_3 | ASWOCN3_3   | Sub Brand=ASWOSB3_3                                                        |
| ASWOAR3_4  | ASWOBR3_4 | ASWOSB3_4 | ASWOPR3_4 | ASWOCN3_4   | Product=ASWOPR3_4                                                          |
| ASWOAR3_5  | ASWOBR3_5 | ASWOSB3_5 | ASWOPR3_5 | ASWOCN3_5   | Advertiser=ASWOAR3_5,Brand=ASWOBR3_5,Sub Brand=ASWOSB3_5,Product=ASWOPR3_5 |

Scenario: search orders by custom advertiser structure
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And created following 'common' custom metadata fields for agency '<Agency>':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency '<Agency>' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of '<User>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination     |
| automated test info    | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT4 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number '<ClockNumber>'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| ASWOAR4           | ASWOBR4      | ASWOPR4        | ASWOC4          |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| ASWOJN4    | ASWOPN4   |
And confirm order on Order Proceed page
And fill following fields for Advanced Search form on ordering page:
| Search By  |
| <SearchBy> |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Product | Campaign | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR4    | ASWOBR4 | ASWOPR4 | ASWOC4   | United Kingdom | ASWOPN4   | ASWOJN4 | 1        | 0/1 Delivered |

Examples:
| Agency   | User     | ClockNumber | SearchBy                                                                                     |
| ASWOA4_1 | ASWOU4_1 | ASWOCN4_1   | Advertiser Custom=ASWOAR4                                                                    |
| ASWOA4_2 | ASWOU4_2 | ASWOCN4_2   | Brand Custom=ASWOBR4                                                                         |
| ASWOA4_3 | ASWOU4_3 | ASWOCN4_3   | Product Custom=ASWOPR4                                                                       |
| ASWOA4_4 | ASWOU4_4 | ASWOCN4_4   | Campaign Custom=ASWOC4                                                                       |
| ASWOA4_5 | ASWOU4_5 | ASWOCN4_5   | Advertiser Custom=ASWOAR4,Brand Custom=ASWOBR4,Product Custom=ASWOPR4,Campaign Custom=ASWOC4 |

Scenario: Search orders by Owner
!--ORD-3312
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU5 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser | Brand   | Sub Brand | Product |
| ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 |
And logged in with details of 'ASWOU5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | ASWOC5   | ASWOCN5      | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT5 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ASWOCN5' with following fields:
| Job Number | PO Number |
| ASWOJN5    | ASWOPN5   |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By    |
| Owner=ASWOU5 |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number 'ASWOCN5' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | United Kingdom | ASWOPN5   | ASWOJN5 | 1        | 0/1 Delivered |

Scenario: Search orders by Job Number
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser | Brand   | Sub Brand | Product |
| ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 |
And logged in with details of 'ASWOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | ASWOC6   | ASWOCN6      | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT6 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ASWOCN6' with following fields:
| Job Number       | PO Number |
| ATP007           | ASWOPN6   |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By                   |
| Job Number=ATP007           |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number 'ASWOCN6' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #            | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | United Kingdom | ASWOPN6   | ATP007            | 1        | 0/1 Delivered |

Scenario: Search orders by Quick Selection
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA8 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU8 | agency.admin | ASWOA8       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA8':
| Advertiser | Brand   | Sub Brand | Product |
| ASWOAR8    | ASWOBR8 | ASWOSB8   | ASWOPR8 |
And logged in with details of 'ASWOU8'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ASWOAR8    | ASWOBR8 | ASWOSB8   | ASWOPR8 | ASWOC8   | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT8 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| ASWOJN8    | ASWOPN8   |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Quick Selection  |
| <QuickSelection> |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR8    | ASWOBR8 | ASWOSB8   | ASWOPR8 | United Kingdom | ASWOPN8   | ASWOJN8 | 1        | 0/1 Delivered |

Examples:
| ClockNumber | QuickSelection |
| ASWOCN8_1   | Today          |
| ASWOCN8_2   | This Week      |
| ASWOCN8_3   | This Month     |

Scenario: Search orders by date range
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA9 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU9 | agency.admin | ASWOA9       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA9':
| Advertiser | Brand   | Sub Brand | Product |
| ASWOAR9    | ASWOBR9 | ASWOSB9   | ASWOPR9 |
And logged in with details of 'ASWOU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | ASWOAR9    | ASWOBR9 | ASWOSB9   | ASWOPR9 | ASWOC9   | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT9 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| ASWOJN9    | ASWOPN9   |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| From   | To   |
| <From> | <to> |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR9    | ASWOBR9 | ASWOSB9   | ASWOPR9 | United Kingdom | ASWOPN9   | ASWOJN9 | 1        | 0/1 Delivered |

Examples:
| ClockNumber | From  | to       |
| ASWOCN9_1   | Today |          |
| ASWOCN9_2   |       | Tomorrow |
| ASWOCN9_3   | Today | Tomorrow |

Scenario: Search orders by Quick Selection past period
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser | Brand   | Sub Brand | Product |
| ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 |
And logged in with details of 'ASWOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | ASWOAR1    | ASWOBR1 | ASWOSB1   | ASWOPR1 | ASWOC10  | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT10 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| ASWOJN10   | ASWOPN10  |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Quick Selection  |
| <QuickSelection> |
And do searching by selected filters for Advanced Search form on ordering page
Then I 'should not' see 'own' order with following item clock number '<ClockNumber>' in 'live' order list

Examples:
| ClockNumber | QuickSelection |
| ASWOCN10_1  | Yesterday      |
| ASWOCN10_2  | Last Week      |
| ASWOCN10_3  | Last Month     |

Scenario: Check that orders can be searched using combined search criteria
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser   | Brand   | Sub Brand  | Product   |
| <advertiser> | <brand> | <subBrand> | <product> |
And logged in with details of 'ASWOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand   | Sub Brand  | Product   | Campaign | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | <advertiser> | <brand> | <subBrand> | <product> | ASWOC11  | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT11 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| ASWOJN11   | ASWOPN11  |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By  | From   | To   | Quick Selection  |
| <SearchBy> | <From> | <to> | <QuickSelection> |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser   | Brand   | Sub Brand  | Product   | Market         | PO Number  | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | <advertiser> | <brand> | <subBrand> | <product> | United Kingdom | ASWOPN11   | ASWOJN11 | 1        | 0/1 Delivered |

Examples:
| advertiser  | brand       | subBrand    | product     | ClockNumber  | SearchBy                                                                                                                  | From  | to         | QuickSelection |
| ASWOAR11_1  | ASWOBR11_1  | ASWOSB11_1  | ASWOPR11_1  | ASWOCN11_1   | Advertiser=ASWOAR11_1                                                                                                     | Today |            |                |
| ASWOAR11_2  | ASWOBR11_2  | ASWOSB11_2  | ASWOPR11_2  | ASWOCN11_2   | Brand=ASWOBR11_2                                                                                                          |       | Tomorrow   |                |
| ASWOAR11_3  | ASWOBR11_3  | ASWOSB11_3  | ASWOPR11_3  | ASWOCN11_3   | Product=ASWOPR11_3                                                                                                        |       |            | Today          |
| ASWOAR11_4  | ASWOBR11_4  | ASWOSB11_4  | ASWOPR11_4  | ASWOCN11_4   | PO Number=ASWOPN11,Job Number=ASWOJN11                                                                                    | Today |            |                |
| ASWOAR11_5  | ASWOBR11_5  | ASWOSB11_5  | ASWOPR11_5  | ASWOCN11_5   | PO Number=ASWOPN11,Job Number=ASWOJN11                                                                                    |       | Tomorrow   |                |
| ASWOAR11_6  | ASWOBR11_6  | ASWOSB11_6  | ASWOPR11_6  | ASWOCN11_6   | PO Number=ASWOPN11,Job Number=ASWOJN11                                                                                    |       |            | This Week      |
| ASWOAR11_7  | ASWOBR11_7  | ASWOSB11_7  | ASWOPR11_7  | ASWOCN11_7   | Advertiser=ASWOAR11_7,Brand=ASWOBR11_7,Sub Brand=ASWOSB11_7,Product=ASWOPR11_7                                            | Today |            |                |
| ASWOAR11_8  | ASWOBR11_8  | ASWOSB11_8  | ASWOPR11_8  | ASWOCN11_8   | Advertiser=ASWOAR11_8,Brand=ASWOBR11_8,Sub Brand=ASWOSB11_8,Product=ASWOPR11_8                                            |       | Tomorrow   |                |
| ASWOAR11_9  | ASWOBR11_9  | ASWOSB11_9  | ASWOPR11_9  | ASWOCN11_9   | Advertiser=ASWOAR11_9,Brand=ASWOBR11_9,Sub Brand=ASWOSB11_9,Product=ASWOPR11_9                                            |       |            | This Month     |
| ASWOAR11_10 | ASWOBR11_10 | ASWOSB11_10 | ASWOPR11_10 | ASWOCN11_10  | Advertiser=ASWOAR11_10,Brand=ASWOBR11_10,Sub Brand=ASWOSB11_10,Product=ASWOPR11_10,PO Number=ASWOPN11,Job Number=ASWOJN11 | Today | Tomorrow   |                |
| ASWOAR11_11 | ASWOBR11_11 | ASWOSB11_11 | ASWOPR11_11 | ASWOCN11_11  | Advertiser=ASWOAR11_11,Brand=ASWOBR11_11,Sub Brand=ASWOSB11_11,Product=ASWOPR11_11,PO Number=ASWOPN11,Job Number=ASWOJN11 |       |            | This Week      |

Scenario: Search results shouldn't include draft orders and include Live Hold Completed orders
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| ASWOAR12   | ASWOBR12 | ASWOSB12  | ASWOPR12 |
And logged in with details of 'ASWOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | ASWOAR12   | ASWOBR12 | ASWOSB12  | ASWOPR12 | ASWOC12_1 | ASWOCN12_1   | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT12_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required |
| automated test info    | ASWOAR12   | ASWOBR12 | ASWOSB12  | ASWOPR12 | ASWOC12_2 | ASWOCN12_2   | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT12_2 | Already Supplied   |
And hold for approval 'tv' order items with following clock numbers 'ASWOCN12_1'
And complete order contains item with clock number 'ASWOCN12_1' with following fields:
| Job Number | PO Number |
| ASWOJN12   | ASWOPN12  |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By                                                              |
| Advertiser=ASWOAR12,Brand=ASWOBR12,Sub Brand=ASWOSB12,Product=ASWOPR12 |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number 'ASWOCN12_1' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product  | Market         | PO Number | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR12   | ASWOBR12 | ASWOSB12  | ASWOPR12 | United Kingdom | ASWOPN12  | ASWOJN12 | 1        | 0/1 Delivered |
And 'should not' see 'own' order with following item clock number 'ASWOCN12_2' in 'live' order list

Scenario: Check that Back button clicked on Order Summary returns to Search results
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1N | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1N | agency.admin | ASWOA1N       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1N':
| Advertiser | Brand    | Sub Brand | Product  |
| ASWOAR13   | ASWOBR13 | ASWOSB13  | ASWOPR13 |
And logged in with details of 'ASWOU1N'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | ASWOAR13   | ASWOBR13 | ASWOSB13  | ASWOPR13 | ASWOC13  | ASWOCN13     | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT13 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ASWOCN13' with following fields:
| Job Number | PO Number |
| ASWOJN13   | ASWOPN13  |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By        |
| Product=ASWOPR13 |
And do searching by selected filters for Advanced Search form on ordering page
And open summary page for order contains item with following clock number 'ASWOCN13' in 'live' order list
And back to ordering page from Order Summary page
Then I should see orders counter '1' above orders list on ordering page

Scenario: check deleting selected Search by filters
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| ASWOA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| ASWOU1 | agency.admin | ASWOA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| ASWOAR14   | ASWOBR14 | ASWOSB14  | ASWOPR14 |
And logged in with details of 'ASWOU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By                            |
| Advertiser=ASWOAR14,Product=ASWOPR14 |
And delete Search by filter 'Product' for Advanced Search form on ordering page
Then I should see following Search by filters count '1' for Advanced Search form on ordering page

Scenario: Search orders by remapped metadata fields
!--ORD-3307
Meta: @ordering
      @skip
!--BugRef--NGN-17032 - Resolved as won't fix
Given I created the following agency:
| Name    | A4User        |
| ASWOA15 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| ASWOU15 | agency.admin | ASWOA15      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'ASWOA15':
| Advertiser | Brand    | Sub Brand | Product  |
| ASWOAR15   | ASWOBR15 | ASWOSB15  | ASWOPR15 |
And logged in with details of 'ASWOU15'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | ASWOAR15   | ASWOBR15 | ASWOSB15  | ASWOPR15 | ASWOC15  | ASWOCN15     | 20       | 10/14/2022     | HD 1080i 25fps | ASWOT15 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'ASWOCN15' with following fields:
| Job Number | PO Number |
| ASWOJN15   | ASWOPN15  |
And created following 'common' custom metadata fields for agency 'ASWOA15':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'ASWOA15' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill following fields for Advanced Search form on ordering page:
| Search By                  |
| Advertiser Custom=ASWOAR15 |
And do searching by selected filters for Advanced Search form on ordering page
Then I should see TV order in 'live' order list with item clock number 'ASWOCN15' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Product  | Campaign | Market         | PO Number | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | ASWOAR15   | ASWOBR15 | ASWOPR15 | ASWOC15  | United Kingdom | ASWOPN15  | ASWOJN15 | 1        | 0/1 Delivered |