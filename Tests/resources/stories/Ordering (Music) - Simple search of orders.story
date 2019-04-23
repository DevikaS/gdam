!--ORD-1626
Feature: Simple search of orders
Narrative:
In order to:
As a AgencyAdmin
I want to check simple search of orders

Scenario: simple search of orders at draft tab for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMSSOA1':
| Advertiser   | Brand    | Sub Brand | Product  |
| OMSSOAR1 new | OMSSOBR1 | OMSSOSB1  | <Label>  |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMSSOA1'
And logged in with details of 'OMSSOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label    | Artist   | ISRC Code  | Release Date | Format         | Title   | Destination                 |
| automated test info    | OMSSOAR1 new   | OMSSOBR1 | OMSSOSB1  | <Label>  | <Artist> | <ISRCCode> | 08/14/2022   | HD 1080i 25fps | <Title> | BSkyB Green Button:Standard |
And I am on View Draft Orders tab of 'music' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'draft' order list on ordering page
Then I should see Music 'draft' order in order list with following fields:
| Order# | DateTime    | Record Company | Market         | NoClocks | Creator |
| Digit  | CurrentTime | OMSSOAR1 new   | United Kingdom | 1        | OMSSOU1 |
And should see 'draft' order in 'music' order list contains items with following fields:
| ISRC Code  | Record Company | Label   | Artist   | Title   | Release Date | Format         |
| <ISRCCode> | OMSSOAR1 new   | <Label> | <Artist> | <Title> | 08/14/2022   | HD 1080i 25fps |

Examples:
| Artist     | Label            | Title             | ISRCCode         | SearchFilter      |
| OMSSOC1_1  | OMSSOP1_1        | OMSDOT1_1         | OMSSOCN1_1       | OMSSOAR1 new      |
| OMSSOC1_2  | OMSSOP1_2        | OMSDOT1_2         | OMSSOCN1_2       | Digit             |
| OMSSOC1_3  | OMSSOP1_3        | OMSDOT1_3         | !@#\$%^.&*()_+;' | !@#$%^.&*()_+;'   |
| OMSSOC1_4  | OMSSOP1_4        | OMSDOT1_4         | OMSSOCN1_4       | OMSSOC1_4         |
| OMSSOC1_5  | OMSDOP1_5 \\new/ | OMSDOT1_5         | OMSSOCN1_5       | OMSDOP1_5 \new/   |
| OMSSOC1_6  | OMSSOP1_6        | OMSDOT1_6 äöüäöü: | OMSSOCN1_6       | OMSDOT1_6 äöüäöü: |

Scenario: simple search of orders at live tab for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMSSOA1':
| Advertiser   | Brand    | Sub Brand | Product  |
| OMSSOAR1 new | OMSSOBR1 | OMSSOSB1  | <Label>  |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMSSOA1'
And logged in with details of 'OMSSOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label    | Artist   | ISRC Code  | Release Date | Format         | Title   | Destination                 |
| automated test info    | OMSSOAR1 new   | OMSSOBR1 | OMSSOSB1  | <Label>  | <Artist> | <ISRCCode> | 08/14/2022   | HD 1080i 25fps | <Title> | BSkyB Green Button:Standard |
And complete order contains item with isrc code '<ISRCCode>' with following fields:
| Job Number | PO Number |
| OMSSOJN2   | OMSSOPN2  |
And I am on View Live Orders tab of 'music' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'live' order list on ordering page
Then I should see Music 'live' order in order list with following fields:
| Order# | DateTime    | Record Company | Market         | PO Number | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | OMSSOAR1 new   | United Kingdom | OMSSOPN2  | OMSSOJN2 | 1        | 0/1 Delivered |
And should see 'live' order in 'music' order list contains items with following fields:
| ISRC Code  | Record Company | Label   | Artist   | Title   | Release Date | Format         | Status        |
| <ISRCCode> | OMSSOAR1 new   | <Label> | <Artist> | <Title> | 08/14/2022   | HD 1080i 25fps | 0/1 Delivered |

Examples:
| Artist    | Label            | Title           | ISRCCode   | SearchFilter    |
| OMSSOC1_1 | OMSSOP1_1        | OMSDOT1_1       | OMSSOCN2_1 | OMSSOAR1 new    |
| OMSSOC1_2 | OMSSOP1_2        | OMSDOT1_2       | OMSSOCN2_2 | Digit           |
| OMSSOC1_3 | OMSSOP1_3        | OMSDOT1_3       | -_#/\\09   | -_#/\09         |
| OMSSOC1_4 | OMSSOP1_4        | OMSDOT1_4       | OMSSOCN2_4 | OMSSOC1_4       |
| OMSSOC1_5 | OMSDOP1_5 \\new/ | OMSDOT1_5       | OMSSOCN2_5 | OMSDOP1_5 \new/ |
| OMSSOC1_6 | OMSSOP1_6        | OMSDOT1_6 test: | OMSSOCN2_6 | OMSDOT1_6 test: |

Scenario: search of deleted order for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And logged in with details of 'OMSSOU1'
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| ISRC Code |
| OMSSOCN3  |
And I am on View Draft Orders tab of 'music' order on ordering page
And deleted orders with following markets 'Republic of Ireland'
When I fill Search orders field by value 'OMSSOCN3' in 'draft' order list on ordering page
Then I 'should not' see orders with following markets 'Republic of Ireland' in 'draft' order list

Scenario: search more than one order for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMSSOA1':
| Advertiser   | Brand      | Sub Brand  | Product    |
| OMSSOAR1 new | OMSSOBR4_1 | OMSSOSB4_1 | OMSSOP4_1  |
| OMSSOAR4     | OMSSOBR4_2 | OMSSOSB4_2 | OMSSOCN4_1 |
And logged in with details of 'OMSSOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label      | Artist    | ISRC Code  | Release Date | Format         | Title     |
| automated test info    | OMSSOAR1 new   | OMSSOBR4_1 | OMSSOSB4_1 | OMSSOP4_1  | OMSSOC4_1 | OMSSOCN4_1 | 08/14/2022   | HD 1080i 25fps | OMSDOT4_1 |
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label      | Artist    | ISRC Code  | Release Date | Format         | Title     |
| automated test info    | OMSSOAR4       | OMSSOBR4_2 | OMSSOSB4_2 | OMSSOCN4_1 | OMSSOC4_2 | OMSSOCN4_2 | 08/14/2022   | HD 1080i 25fps | OMSDOT4_2 |
And I am on View Draft Orders tab of 'music' order on ordering page
When I fill Search orders field by value 'OMSSOCN4_1' in 'draft' order list on ordering page
Then I should see Music order in 'draft' order list with item clock number 'OMSSOCN4_1' and following fields:
| Order# | DateTime    | Record Company | Market         | NoClocks | Creator |
| Digit  | CurrentTime | OMSSOAR1 new   | United Kingdom | 1        | OMSSOU1 |
And should see Music order in 'draft' order list with item clock number 'OMSSOCN4_2' and following fields:
| Order# | DateTime    | Record Company | Market              | NoClocks | Creator |
| Digit  | CurrentTime | OMSSOAR4       | Republic of Ireland | 1        | OMSSOU1 |

Scenario: Search drafted order at live tab for you for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And logged in with details of 'OMSSOU1'
And create 'music' order with market 'Albania' and items with following fields:
| ISRC Code |
| OMSSOCN5  |
And I am on View Live Orders tab of 'music' order on ordering page
When I fill Search orders field by value 'OMSSOCN5' in 'live' order list on ordering page
Then I 'should not' see orders with following markets 'Albania' in 'live' order list

Scenario: clear search list view for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA6 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU6 | agency.admin | OMSSOA6      |
And logged in with details of 'OMSSOU6'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code  |
| OMSSOCN6_1 |
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| ISRC Code  |
| OMSSOCN6_2 |
And I am on View Draft Orders tab of 'music' order on ordering page
When I fill Search orders field by value 'OMSSOCN6_1' in 'draft' order list on ordering page
And update Search orders field by value '' in 'draft' order list on ordering page
Then I 'should' see orders with following markets 'United Kingdom,Republic of Ireland' in 'draft' order list

Scenario: search orders with same data at draft tab for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMSSOA1':
| Advertiser   | Brand      | Sub Brand  | Product    |
| OMSSOAR1 new | OMSSOBR7_1 | OMSSOSB7_1 | OMSSOP7_1  |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMSSOA1'
And logged in with details of 'OMSSOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label     | Artist    | ISRC Code  | Release Date | Format         | Title     | Destination                 |
| automated test info    | OMSSOAR1 new   | OMSSOBR7_1 | OMSSOSB7_1 | OMSSOP7_1 | OMSSOC7_1 | OMSSOCN7_1 | 08/14/2022   | HD 1080i 25fps | OMSDOT7_1 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'OMSSOCN7_1' with following fields:
| Job Number | PO Number |
| OMSSOJN7   | OMSSOPN7  |
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label     | Artist    | ISRC Code  | Release Date | Format         | Title     |
| automated test info    | OMSSOAR1 new   | OMSSOBR7_1 | OMSSOSB7_1 | OMSSOP7_1 | OMSSOC7_1 | OMSSOCN7_2 | 08/14/2022   | HD 1080i 25fps | OMSDOT7_1 |
And I am on View Draft Orders tab of 'music' order on ordering page
When I fill Search orders field by value 'OMSSOC7_1' in 'draft' order list on ordering page
Then I 'should' see orders with following markets 'Republic of Ireland' in 'draft' order list
And 'should not' see orders with following markets 'United Kingdom' in 'draft' order list

Scenario: search orders with same data at live tab for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMSSOA1':
| Advertiser   | Brand      | Sub Brand  | Product    |
| OMSSOAR1 new | OMSSOBR8_1 | OMSSOSB8_1 | OMSSOP8_1  |
And logged in with details of 'OMSSOU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label     | Artist    | ISRC Code  | Release Date | Format         | Title     | Destination                 |
| automated test info    | OMSSOAR1 new   | OMSSOBR8_1 | OMSSOSB8_1 | OMSSOP8_1 | OMSSOC8_1 | OMSSOCN8_1 | 08/14/2022   | HD 1080i 25fps | OMSDOT8_1 | BSkyB Green Button:Standard |
And complete order contains item with isrc code 'OMSSOCN8_1' with following fields:
| Job Number | PO Number |
| OMSSOJN8   | OMSSOPN8  |
And create 'music' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label     | Artist    | ISRC Code  | Release Date | Format         | Title     |
| automated test info    | OMSSOAR1 new   | OMSSOBR8_1 | OMSSOSB8_1 | OMSSOP8_1 | OMSSOC8_1 | OMSSOCN8_1 | 08/14/2022   | HD 1080i 25fps | OMSDOT8_1 |
And I am on View Live Orders tab of 'music' order on ordering page
When I fill Search orders field by value 'OMSSOCN8_1' in 'live' order list on ordering page
Then I 'should' see orders with following markets 'United Kingdom' in 'live' order list
And 'should not' see orders with following markets 'Republic of Ireland' in 'live' order list

Scenario: simple search of orders at draft tab by Market field for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMSSOA1':
| Advertiser   | Brand    | Sub Brand | Product |
| OMSSOAR1 new | OMSSOBR9 | OMSSOSB9  | OMSSOP9 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMSSOA1'
And logged in with details of 'OMSSOU1'
And create 'music' order with market '<Market>' and items with following fields:
| Additional Information | Record Company | Brand    | Sub Brand | Label   | Artist  | ISRC Code  | Release Date | Format         | Title   |
| automated test info    | OMSSOAR1 new   | OMSSOBR9 | OMSSOSB9  | OMSSOP9 | OMSSOC9 | <ISRCCode> | 08/14/2022   | HD 1080i 25fps | OMSDOT9 |
And I am on View Draft Orders tab of 'music' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'draft' order list on ordering page
Then I should see Music order in 'draft' order list with item isrc code '<ISRCCode>' and following fields:
| Order# | DateTime    | Record Company | Market   | NoClocks | Creator |
| Digit  | CurrentTime | OMSSOAR1 new   | <Market> | 1        | OMSSOU1 |
And should see 'draft' order in 'music' order list contains isrc code '<ISRCCode>' and items with following fields:
| ISRC Code  | Record Company | Label   | Artist  | Title   | Release Date | Format         |
| <ISRCCode> | OMSSOAR1 new   | OMSSOP9 | OMSSOC9 | OMSDOT9 | 08/14/2022   | HD 1080i 25fps |

Examples:
| Market               | ISRCCode   | SearchFilter  |
| United Kingdom       | OMSSOCN9_1 | United        |
| Republic of Ireland  | OMSSOCN9_2 | Republic      |
| Bosnia & Herzegovina | OMSSOCN9_3 | Bosnia        |

Scenario: simple search of orders at live tab for Market field for music
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OMSSOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OMSSOU1 | agency.admin | OMSSOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMSSOA1':
| Advertiser   | Brand     | Sub Brand | Product  |
| OMSSOAR1 new | OMSSOBR10 | OMSSOSB10 | OMSSOP10 |
And logged in with details of 'OMSSOU1'
And create 'music' order with market '<Market>' and items with following fields:
| Additional Information | Record Company | Brand     | Sub Brand | Label    | Artist   | ISRC Code  | Release Date | Format         | Title    | Destination   |
| automated test info    | OMSSOAR1 new   | OMSSOBR10 | OMSSOSB10 | OMSSOP10 | OMSSOC10 | <ISRCCode> | 08/14/2022   | HD 1080i 25fps | OMSDOT10 | <Destination> |
And complete order contains item with isrc code '<ISRCCode>' with following fields:
| Job Number | PO Number |
| OMSSOJN10  | OMSSOPN10 |
And I am on View Live Orders tab of 'music' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'live' order list on ordering page
Then I should see Music order in 'live' order list with item isrc code '<ISRCCode>' and following fields:
| Order# | DateTime    | Record Company | Market   | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | OMSSOAR1 new   | <Market> | OMSSOPN10 | OMSSOJN10 | 1        | 0/1 Delivered |

Examples:
| Market               | ISRCCode    | SearchFilter | Destination                                 |
| United Kingdom       | OMSSOCN10_1 | United       | BSkyB Green Button:Standard                 |
| Republic of Ireland  | OMSSOCN10_2 | Republic     | Universal Ireland:Standard                  |
| Bosnia & Herzegovina | OMSSOCN10_3 | Bosnia       | New Station - Bosnia & Herzegovina:Standard |