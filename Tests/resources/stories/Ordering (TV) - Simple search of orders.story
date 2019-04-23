!--ORD-273
!--ORD-773
Feature: Simple search of orders
Narrative:
In order to:
As a AgencyAdmin
I want to check simple search of orders

Scenario: simple search of orders at draft tab
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA1':
| Advertiser    | Brand     | Sub Brand | Product   |
| OTVSSOAR1 new | OTVSSOBR1 | OTVSSOSB1 | <Product> |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser    | Brand     | Sub Brand | Product   | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title   |
| automated test info    | OTVSSOAR1 new | OTVSSOBR1 | OTVSSOSB1 | <Product> | <Campaign> | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | <Title> |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'draft' order list on ordering page
Then I should see TV 'draft' order in order list with following fields:
| Order# | DateTime    | Advertiser    | Market         | NoClocks | Creator  |
| Digit  | CurrentTime | OTVSSOAR1 new | United Kingdom | 1        | OTVSSOU1 |
And should see 'draft' order in 'tv' order list contains items with following fields:
| Clock Number  | Advertiser    | Product   | Title   | First Air Date | Format         | Duration |
| <ClockNumber> | OTVSSOAR1 new | <Product> | <Title> | 08/14/2022     | HD 1080i 25fps | 20       |

Examples:
| Campaign   | Product           | Title              | ClockNumber      | SearchFilter       |
| OTVSSOC1_1 | OTVSSOP1_1        | OTVSDOT1_1         | OTVSSOCN1_1      | OTVSSOAR1 new      |
| OTVSSOC1_2 | OTVSSOP1_2        | OTVSDOT1_2         | OTVSSOCN1_2      | Digit              |
| OTVSSOC1_3 | OTVSSOP1_3        | OTVSDOT1_3         | !@#\$%^.&*()_+;' | !@#$%^.&*()_+;'    |
| OTVSSOC1_4 | OTVSSOP1_4        | OTVSDOT1_4         | OTVSSOCN1_4      | OTVSSOC1_4         |
| OTVSSOC1_5 | OTVSDOP1_5 \\new/ | OTVSDOT1_5         | OTVSSOCN1_5      | OTVSDOP1_5 \new/   |
| OTVSSOC1_6 | OTVSSOP1_6        | OTVSDOT1_6 äöüäöü: | OTVSSOCN1_6      | OTVSDOT1_6 äöüäöü: |

Scenario: simple search of orders at live tab
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA1':
| Advertiser    | Brand     | Sub Brand | Product   |
| OTVSSOAR1 new | OTVSSOBR2 | OTVSSOSB2 | <Product> |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser    | Brand     | Sub Brand | Product   | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | OTVSSOAR1 new | OTVSSOBR2 | OTVSSOSB2 | <Product> | <Campaign> | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | <Title> | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| OTVSSOJN2  | OTVSSOPN2 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'live' order list on ordering page
Then I should see TV 'live' order in order list with following fields:
| Order# | DateTime    | Advertiser    | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | OTVSSOAR1 new | United Kingdom | OTVSSOPN2 | OTVSSOJN2 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains items with following fields:
| Clock Number  | Advertiser    | Product   | Title   | First Air Date | Format         | Duration | Status        |
| <ClockNumber> | OTVSSOAR1 new | <Product> | <Title> | 08/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Examples:
| Campaign   | Product           | Title            | ClockNumber | SearchFilter     |
| OTVSSOC2_1 | OTVSSOP2_1        | OTVSDOT2_1       | OTVSSOCN2_1 | OTVSSOAR1 new    |
| OTVSSOC2_2 | OTVSSOP2_2        | OTVSDOT2_2       | OTVSSOCN2_2 | Digit            |
| OTVSSOC2_3 | OTVSSOP2_3        | OTVSDOT2_3       | -_#/\\09    | -_#/\09          |
| OTVSSOC2_4 | OTVSSOP2_4        | OTVSDOT2_4       | OTVSSOCN2_4 | OTVSSOC2_4       |
| OTVSSOC2_5 | OTVSDOP2_5 \\new/ | OTVSDOT2_5       | OTVSSOCN2_5 | OTVSDOP2_5 \new/ |
| OTVSSOC2_6 | OTVSSOP2_6        | OTVSDOT2_6 test: | OTVSSOCN2_6 | OTVSDOT2_6 test: |

Scenario: search of deleted order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OTVSSOCN3    |
And I am on View Draft Orders tab of 'tv' order on ordering page
And deleted orders with following markets 'Republic of Ireland'
When I fill Search orders field by value 'OTVSSOCN3' in 'draft' order list on ordering page
Then I 'should not' see orders with following markets 'Republic of Ireland' in 'draft' order list

Scenario: search more than one order
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA1':
| Advertiser    | Brand       | Sub Brand   | Product     |
| OTVSSOAR1 new | OTVSSOBR4_1 | OTVSSOSB4_1 | OTVSSOP4_1  |
| OTVSSOAR4     | OTVSSOBR4_2 | OTVSSOSB4_2 | OTVSSOCN4_1 |
And on the global 'common custom' metadata page for agency 'OTVSSOA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser    | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      |
| automated test info    | OTVSSOAR1 new | OTVSSOBR4_1 | OTVSSOSB4_1 | OTVSSOP4_1  | OTVSSOC4_1 | OTVSSOCN4_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT4_1 |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand       | Sub Brand   | Product      | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      |
| automated test info    | OTVSSOAR4  | OTVSSOBR4_2 | OTVSSOSB4_2 | OTVSSOCN4_1  | OTVSSOC4_2 | OTVSSOCN4_2  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT4_2 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill Search orders field by value 'OTVSSOCN4_1' in 'draft' order list on ordering page
Then I should see TV order in 'draft' order list with item clock number 'OTVSSOCN4_1' and following fields:
| Order# | DateTime    | Advertiser    | Market         | NoClocks | Creator  |
| Digit  | CurrentTime | OTVSSOAR1 new | United Kingdom | 1        | OTVSSOU1 |
And should see TV order in 'draft' order list with item clock number 'OTVSSOCN4_2' and following fields:
| Order# | DateTime    | Advertiser | Market              | NoClocks | Creator  |
| Digit  | CurrentTime | OTVSSOAR4  | Republic of Ireland | 1        | OTVSSOU1 |

Scenario: Search drafted order at live tab
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market 'Albania' and items with following fields:
| Clock Number |
| OTVSSOCN5    |
And I am on View Live Orders tab of 'tv' order on ordering page
When I fill Search orders field by value 'OTVSSOCN5' in 'live' order list on ordering page
Then I 'should not' see orders with following markets 'Albania' in 'live' order list

Scenario: clear search list view
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA6 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU6 | agency.admin | OTVSSOA6     |
And logged in with details of 'OTVSSOU6'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVSSOCN6_1  |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OTVSSOCN6_2  |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill Search orders field by value 'OTVSSOCN6_1' in 'draft' order list on ordering page
And update Search orders field by value '' in 'draft' order list on ordering page
Then I 'should' see orders with following markets 'United Kingdom,Republic of Ireland' in 'draft' order list

Scenario: search orders with same data at draft tab
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA1':
| Advertiser    | Brand     | Sub Brand | Product  |
| OTVSSOAR1 new | OTVSSOBR7 | OTVSSOSB7 | OTVSSOP7 |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser    | Brand     | Sub Brand | Product  | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVSSOAR1 new | OTVSSOBR7 | OTVSSOSB7 | OTVSSOP7 | OTVSSOC7_1 | OTVSSOCN7_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT7_1 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVSSOCN7_1' with following fields:
| Job Number | PO Number |
| OTVSSOJN7  | OTVSSOPN7 |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser    | Brand     | Sub Brand | Product  | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      |
| automated test info    | OTVSSOAR1 new | OTVSSOBR7 | OTVSSOSB7 | OTVSSOP7 | OTVSSOC7_1 | OTVSSOCN7_2  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT7_1 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill Search orders field by value 'OTVSSOC7_1' in 'draft' order list on ordering page
Then I 'should' see orders with following markets 'Republic of Ireland' in 'draft' order list
And 'should not' see orders with following markets 'United Kingdom' in 'draft' order list

Scenario: search orders with same data at live tab
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA1':
| Advertiser    | Brand     | Sub Brand | Product  |
| OTVSSOAR1 new | OTVSSOBR8 | OTVSSOSB8 | OTVSSOP8 |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser    | Brand     | Sub Brand | Product  | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVSSOAR1 new | OTVSSOBR8 | OTVSSOSB8 | OTVSSOP8 | OTVSSOC8_1 | OTVSSOCN8_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT8_1 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVSSOCN8_1' with following fields:
| Job Number | PO Number |
| OTVSSOJN8  | OTVSSOPN8 |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser    | Brand     | Sub Brand | Product  |  Campaign   | Clock Number | Duration | First Air Date | Format         | Title      |
| automated test info    | OTVSSOAR1 new | OTVSSOBR8 | OTVSSOSB8 | OTVSSOP8 |  OTVSSOC8_1 | OTVSSOCN8_1  | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT8_1 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I fill Search orders field by value 'OTVSSOCN8_1' in 'live' order list on ordering page
Then I 'should' see orders with following markets 'United Kingdom' in 'live' order list
And 'should not' see orders with following markets 'Republic of Ireland' in 'live' order list

Scenario: simple search of orders at draft tab by Market field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA1':
| Advertiser    | Brand     | Sub Brand | Product  |
| OTVSSOAR1 new | OTVSSOBR9 | OTVSSOSB9 | OTVSSOP9 |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market '<Market>' and items with following fields:
| Additional Information | Advertiser    | Brand     | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVSSOAR1 new | OTVSSOBR9 | OTVSSOSB9 | OTVSSOP9 | OTVSSOC9 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT9 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'draft' order list on ordering page
Then I should see TV order in 'draft' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser    | Market   | NoClocks | Creator  |
| Digit  | CurrentTime | OTVSSOAR1 new | <Market> | 1        | OTVSSOU1 |
And should see 'draft' order in 'tv' order list contains clock number '<ClockNumber>' and items with following fields:
| Clock Number  | Advertiser    | Product  | Title    | First Air Date | Format         | Duration |
| <ClockNumber> | OTVSSOAR1 new | OTVSSOP9 | OTVSDOT9 | 08/14/2022     | HD 1080i 25fps | 20       |

Examples:
| Market               | ClockNumber | SearchFilter |
| United Kingdom       | OTVSSOCN9_1 | United       |
| Republic of Ireland  | OTVSSOCN9_2 | Republic     |
| Bosnia & Herzegovina | OTVSSOCN9_3 | Bosnia       |

Scenario: simple search of orders at live tab for Market field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA1':
| Advertiser    | Brand      | Sub Brand  | Product   |
| OTVSSOAR1 new | OTVSSOBR10 | OTVSSOSB10 | OTVSSOP10 |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market '<Market>' and items with following fields:
| Additional Information | Advertiser    | Brand      | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     | Subtitles Required  | Destination   |
| automated test info    | OTVSSOAR1 new | OTVSSOBR10 | OTVSSOSB10 | OTVSSOP10 | OTVSSOC10 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT10 | <SubtitlesRequired> | <Destination> |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number  |
| OTVSSOJN10 | OTVSSOPN10 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I fill Search orders field by value '<SearchFilter>' in 'live' order list on ordering page
Then I should see TV order in 'live' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser    | Market   | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVSSOAR1 new | <Market> | OTVSSOPN10 | OTVSSOJN10 | 1        | 0/1 Delivered |

Examples:
| Market               | ClockNumber  | SearchFilter | Destination                                 | SubtitlesRequired |
| United Kingdom       | OTVSSOCN10_1 | United       | BSkyB Green Button:Standard                 | Already Supplied  |
| Republic of Ireland  | OTVSSOCN10_2 | Republic     | Universal Ireland:Standard                  | Already Supplied  |
| Bosnia & Herzegovina | OTVSSOCN10_3 | Bosnia       | New Station - Bosnia & Herzegovina:Standard |                   |

Scenario: Search orders by Mark Advertiser and Mark as Product fields should work if these fields are newly created
!--ORD-2278
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>    |
And created following 'common' custom metadata fields for agency '<Agency>':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency '<Agency>' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Brand Custom    |
And logged in with details of '<User>'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVSSOC11 | OTVSSOCN11   | 20       | 10/14/2022     | HD 1080i 25fps | OTVSDOT11 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign    | Clock Number  | Duration | First Air Date | Format         | Title       |
| automated test info    | OTVSSOC11_1 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT11_1 |
When I open order item with following clock number '<ClockNumber>'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
| OTVSSOAR11        | <Brand>      | OTVSSOBR11       | OTVSSOPR11     |
And save as draft order
And fill Search orders field by value '<SearchFilter>' in 'draft' order list on ordering page
Then I should see TV order in 'draft' order list with item clock number '<ClockNumber>' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand  | Product    | Market         | NoClocks | Creator |
| Digit  | CurrentTime | OTVSSOAR11 | <Brand> | OTVSSOBR11 | OTVSSOPR11 | United Kingdom | 1        | <User>  |
And should see 'draft' order in 'tv' order list contains items with following fields:
| Clock Number  | Advertiser | Product | Title       | First Air Date | Format         | Duration |
| <ClockNumber> | OTVSSOAR11 | <Brand> | OTVSDOT11_1 | 08/14/2022     | HD 1080i 25fps | 20       |

Examples:
| Agency      | User        | ClockNumber  | Brand        | SearchFilter |
| OTVSSOA11_1 | OTVSSOU11_1 | OTVSSOCN11_1 | OTVSSOBR11_1 | OTVSSOAR11   |
| OTVSSOA11_2 | OTVSSOU11_2 | OTVSSOCN11_2 | OTVSSOBR11_2 | OTVSSOBR11_2 |

Scenario: check saving search results in order list after back from order summary page
!--ORD-2867
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVSSOA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVSSOU1 | agency.admin | OTVSSOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA1':
| Advertiser   | Brand        | Sub Brand    | Product     |
| OTVSSOAR12_1 | OTVSSOBR12_1 | OTVSSOSB12_1 | OTVSSOP12_1 |
| OTVSSOAR12_2 | OTVSSOBR12_2 | OTVSSOSB12_2 | OTVSSOP12_2 |
And logged in with details of 'OTVSSOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVSSOAR12_1 | OTVSSOBR12_1 | OTVSSOSB12_1 | OTVSSOP12_1 | OTVSSOC12_1 | OTVSSOCN12_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT12_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                |
| automated test info    | OTVSSOAR12_2 | OTVSSOBR12_2 | OTVSSOSB12_2 | OTVSSOP12_2 | OTVSSOC12_2 | OTVSSOCN12_2 | 20       | 08/14/2022     | HD 1080i 25fps | OTVSDOT12_2 | Already Supplied   | Universal Ireland:Standard |
And complete order contains item with clock number 'OTVSSOCN12_1' with following fields:
| Job Number   | PO Number    |
| OTVSSOJN12_1 | OTVSSOPN12_1 |
And complete order contains item with clock number 'OTVSSOCN12_2' with following fields:
| Job Number   | PO Number    |
| OTVSSOJN12_2 | OTVSSOPN12_2 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I fill Search orders field by value 'OTVSSOAR12_1' in 'live' order list on ordering page
And open summary page for order contains item with following clock number 'OTVSSOCN12_1' in 'live' order list
And back to ordering page from Order Summary page
Then I should see TV order in 'live' order list with item clock number 'OTVSSOCN12_1' and following fields:
| Order# | DateTime    | Advertiser   | Brand        | Sub Brand    | Product     | Market         | PO Number    | Job #        | NoClocks | Status        |
| Digit  | CurrentTime | OTVSSOAR12_1 | OTVSSOBR12_1 | OTVSSOSB12_1 | OTVSSOP12_1 | United Kingdom | OTVSSOPN12_1 | OTVSSOJN12_1 | 1        | 0/1 Delivered |
And 'should not' see orders with following markets 'Republic of Ireland' in 'live' order list

Scenario: check searching orders by Clave for Spain market in Spain BU
!--ORD-4035
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Country |
| OTVSSOA13 | DefaultA4User | Spain   |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVSSOU13 | agency.admin | OTVSSOA13    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVSSOA13':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVSSOAR13 | OTVSSOBR13 | OTVSSOSB13 | OTVSSOP13 |
And logged in with details of 'OTVSSOU13'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Clave      |
| automated test info    | OTVSSOAR13 | OTVSSOBR13 | OTVSSOSB13 | OTVSSOP13 | OTVSSOC13 | OTVSSOCN13   | 20       | 10/14/2022     | HD 1080i 25fps | OTVSSOT13 | OTVSSOCL13 |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I fill Search orders field by value 'OTVSSOT13' in 'draft' order list on ordering page
Then I should see TV order in 'draft' order list with item clock number 'OTVSSOCN13' and following fields:
| Order# | DateTime    | Advertiser | Brand      | Sub Brand  | Product   | Market | NoClocks | Creator   |
| Digit  | CurrentTime | OTVSSOAR13 | OTVSSOBR13 | OTVSSOSB13 | OTVSSOP13 | Spain  | 1        | OTVSSOU13 |
And should see 'draft' order in 'tv' order list contains clock number 'OTVSSOCN13' and items with following fields:
| Clock Number | Advertiser | Product   | Title     | Clave      | First Air Date | Format         | Duration |
| OTVSSOCN13   | OTVSSOAR13 | OTVSSOP13 | OTVSSOT13 | OTVSSOCL13 | 10/14/2022     | HD 1080i 25fps | 20       |