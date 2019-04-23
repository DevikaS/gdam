!--ORD-3381
!--ORD-3717
Feature: Market Schemes ediatable is Super Admin
Narrative:
In order to:
As a GlobalAdmin
I want to check market schemes ediatable is Super Admin

Scenario: Check that all types of fields can be added to Common Ordering Metadata
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSEISAA1 | DefaultA4User |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA1'
When I click 'String' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'String Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And click 'Date' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Date Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And click 'Multiline' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Multiline Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And click 'Phone' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Phone Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And click 'Dropdown' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Dropdown Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Catalogue Structure' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Catalogue Structure Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Address' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Address Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And click 'Radio Buttons' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Radio Buttons Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Hyperlink' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Hyperlink Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And click 'Custom Code' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'Custom Code Common Ordering' on opened Settings and Customization tab
And save metadata field settings
Then I 'should' see button 'String Common Ordering,Date Common Ordering,Multiline Common Ordering,Phone Common Ordering,Dropdown Common Ordering,Catalogue Structure Common Ordering,Address Common Ordering,Radio Buttons Common Ordering,Hyperlink Common Ordering,Custom Code Common Ordering' in 'editable metadata' section on opened metadata page

Scenario: Check that Common Ordering Metadata is unique per Market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSEISAA1 | DefaultA4User |
And I am on the global common ordering metadata page of market 'Republic of Ireland' for agency 'MSEISAA1'
When I click 'String' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'String Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And go to the global common traffic metadata page of market 'Republic of Ireland' for agency ''
And go to the global common ordering metadata page of market 'Spain' for agency 'MSEISAA1'
Then I 'should not' see button 'String Common Ordering' in 'editable metadata' section on opened metadata page

Scenario: Check that Common Ordering Metadata of someone market is common for all BU
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| MSEISAA1   | DefaultA4User |
| MSEISAA3_2 | DefaultA4User |
And I am on the global common ordering metadata page of market 'Guatemala' for agency ''
When I click 'String' button in 'custom metadata' section on opened metadata page
And fill Description field with text 'String Common Ordering' on opened Settings and Customization tab
And save metadata field settings
And go to the global common traffic metadata page of market 'Guatemala' for agency ''
And go to the global common ordering metadata page of market 'Guatemala' for agency 'MSEISAA1'
Then I 'should' see button 'String Common Ordering' in 'editable metadata' section on opened metadata page
When I go to the global common traffic metadata page of market 'Guatemala' for agency ''
And go to the global common ordering metadata page of market 'Guatemala' for agency 'MSEISAA3_2'
Then I 'should' see button 'String Common Ordering' in 'editable metadata' section on opened metadata page

Scenario: Check that added Common Ordering Metadata fields are successfully displayed in Add Information section they can be filled and order can be confirmed
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSEISAA4 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSEISAU4 | agency.admin | MSEISAA4     |
And logged in with details of 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSEISAA4':
| Advertiser | Brand     | Sub Brand | Product   |
| MSEISAAR4  | MSEISABR4 | MSEISASB4 | MSEISAPR4 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA4'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Date' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Date' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Multiline' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Multiline' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Phone' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Phone' on opened Settings and Customization tab
And saved metadata field settings
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description | AddOnFly | MultipleChoices | Descendants |
| Dropdown    | should   | should          | drop1,drop2 |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description         | Descendants | AddOnFly | MultipleChoices |
| Catalogue Structure | cat1,cat2   | should   | should          |
And clicked 'Address' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Address' on opened Settings and Customization tab
And saved metadata field settings
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   | Descendants |
| Radio Buttons | t1,t2       |
And clicked 'Hyperlink' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Hyperlink' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'MSEISAU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | MSEISAAR4  | MSEISABR4 | MSEISASB4 | MSEISAPR4 | MSEISAC4 | MSEISACN4    | 20       | 10/14/2022     | HD 1080i 25fps | MSEISAT4 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MSEISACN4'
And fill following custom fields for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MSEISAJN4  | MSEISAPN4 |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'MSEISACN4' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit# | CurrentTime | MSEISAAR4  | MSEISABR4 | MSEISASB4 | MSEISAPR4 | United Kingdom | MSEISAPN4 | MSEISAJN4 | 1        | 0/1 Delivered |

Scenario: Check that values specified into added fields in Common Ordering Metadata are successfully copied using Copy Current
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSEISAA5 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSEISAU5 | agency.admin | MSEISAA5     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSEISAA5':
| Advertiser | Brand     | Sub Brand | Product   |
| MSEISAAR5  | MSEISABR5 | MSEISASB5 | MSEISAPR5 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA5'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Date' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Date' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Multiline' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Multiline' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Phone' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Phone' on opened Settings and Customization tab
And saved metadata field settings
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description | AddOnFly | MultipleChoices | Descendants |
| Dropdown    | should   | should          | drop1,drop2 |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description         | Descendants | AddOnFly | MultipleChoices |
| Catalogue Structure | cat1,cat2   | should   | should          |
And clicked 'Address' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Address' on opened Settings and Customization tab
And saved metadata field settings
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   | Descendants |
| Radio Buttons | t1,t2       |
And clicked 'Hyperlink' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Hyperlink' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'MSEISAU5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MSEISACN5    |
When I open order item with following clock number 'MSEISACN5'
And fill following custom fields for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |
And 'copy current' order item by Add Commercial button on order item page
Then I should see following custom fields data for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |

Scenario: Check that values specified into added fields in Common Ordering Metadata are successfully copied using Copy To All
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSEISAA6 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSEISAU6 | agency.admin | MSEISAA6     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSEISAA6':
| Advertiser | Brand     | Sub Brand | Product   |
| MSEISAAR6  | MSEISABR6 | MSEISASB6 | MSEISAPR6 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA6'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Date' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Date' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Multiline' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Multiline' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Phone' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Phone' on opened Settings and Customization tab
And saved metadata field settings
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description | AddOnFly | MultipleChoices | Descendants |
| Dropdown    | should   | should          | drop1,drop2 |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description         | Descendants | AddOnFly | MultipleChoices |
| Catalogue Structure | cat1,cat2   | should   | should          |
And clicked 'Address' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Address' on opened Settings and Customization tab
And saved metadata field settings
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   | Descendants |
| Radio Buttons | t1,t2       |
And clicked 'Hyperlink' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Hyperlink' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'MSEISAU6'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MSEISACN6_1  |
| MSEISACN6_2  |
When I open order item with following clock number 'MSEISACN6_1'
And fill following custom fields for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following clock number 'MSEISACN6_1' on cover flow
Then I should see following custom fields data for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |

Scenario: Check that values specified into added fields in Common Ordering Metadata are successfully deleted using Clear button
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSEISAA7 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSEISAU7 | agency.admin | MSEISAA7     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSEISAA7':
| Advertiser | Brand     | Sub Brand | Product   |
| MSEISAAR7  | MSEISABR7 | MSEISASB7 | MSEISAPR7 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA7'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Date' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Date' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Multiline' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Multiline' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Phone' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Phone' on opened Settings and Customization tab
And saved metadata field settings
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description | AddOnFly | MultipleChoices | Descendants |
| Dropdown    | should   | should          | drop1,drop2 |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description         | Descendants | AddOnFly | MultipleChoices |
| Catalogue Structure | cat1,cat2   | should   | should          |
And clicked 'Address' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Address' on opened Settings and Customization tab
And saved metadata field settings
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   | Descendants |
| Radio Buttons | t1,t2       |
And clicked 'Hyperlink' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Hyperlink' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'MSEISAU7'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MSEISACN7  |
When I open order item with following clock number 'MSEISACN7'
And fill following custom fields for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |
And clear 'Add information' section on order item page
Then I should see following custom fields data for Add information form on order item page:
| Catalogue Structure | cat1 | cat2 | String | Multiline | Phone | Date | Radio Buttons | Dropdown | Address | Hyperlink | Custom Code |
|                     |      |      |        |           |       |      |               |          | ,,,,    | http://   |             |

Scenario: Check that values are displayed in added fields in Common Ordering metadata after retrieving asset from Library with already filled these fields
!--ORD-4404
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Save In Library |Allow To Save In Library|
| MSEISAA8 | DefaultA4User | should          |should                  |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSEISAU8 | agency.admin | MSEISAA8     |
And logged in with details of 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSEISAA8':
| Advertiser | Brand     | Sub Brand | Product   |
| MSEISAAR8  | MSEISABR8 | MSEISASB8 | MSEISAPR8 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA8'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Date' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Date' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Multiline' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Multiline' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Phone' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Phone' on opened Settings and Customization tab
And saved metadata field settings
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description | AddOnFly | MultipleChoices | Descendants |
| Dropdown    | should   | should          | drop1,drop2 |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description         | Descendants | AddOnFly | MultipleChoices |
| Catalogue Structure | cat1,cat2   | should   | should          |
And clicked 'Address' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Address' on opened Settings and Customization tab
And saved metadata field settings
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   | Descendants |
| Radio Buttons | t1,t2       |
And clicked 'Hyperlink' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Hyperlink' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'MSEISAU8'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | MSEISAAR8  | MSEISABR8 | MSEISASB8 | MSEISAPR8 | MSEISAC8 | MSEISACN8_1  | 20       | 10/14/2022     | HD 1080i 25fps | MSEISAT8 | Already Supplied   | Aastha:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MSEISACN8_2  |
When I open order item with following clock number 'MSEISACN8_1'
And fill following custom fields for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MSEISAJN8  | MSEISAPN8 |
And 'check' checkbox Archive for following clock number 'MSEISACN8_1' of QC View summary on Order Proceed page
And confirm order on Order Proceed page
And added to 'tv' order item with clock number 'MSEISACN8_2' following qc asset 'MSEISAT8' of collection 'My Assets'
And open order item with clock number 'MSEISACN8_1' for order with market 'United Kingdom'
Then I should see following custom fields data for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               | Hyperlink            | Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine | http://www.adbank.me | custom-code-value |

Scenario: Check that values specified into added fields in Common Ordering Metadata are successfully displayed in QC-ed assets after order confirming
!--ORD-4404
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |Save In Library |Allow To Save In Library|
| MSEISAA9 | DefaultA4User |should          |should                  |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| MSEISAU9 | agency.admin | MSEISAA9     |streamlined_library,ordering|
And logged in with details of 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSEISAA9':
| Advertiser | Brand     | Sub Brand | Product   |
| MSEISAAR9  | MSEISABR9 | MSEISASB9 | MSEISAPR9 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA9'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Date' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Date' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Multiline' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Multiline' on opened Settings and Customization tab
And saved metadata field settings
And clicked 'Phone' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Phone' on opened Settings and Customization tab
And saved metadata field settings
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description | AddOnFly | MultipleChoices | Descendants |
| Dropdown    | should   | should          | drop1,drop2 |
And created 'Catalogue Structure' custom metadata field with following information on opened metadata page:
| Description         | Descendants | AddOnFly | MultipleChoices |
| Catalogue Structure | cat1,cat2   | should   | should          |
And clicked 'Address' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Address' on opened Settings and Customization tab
And saved metadata field settings
And created 'Radio Buttons' custom metadata field with following information on opened metadata page:
| Description   | Descendants |
| Radio Buttons | t1,t2       |
And clicked 'Custom Code' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Custom Code' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'MSEISAU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | MSEISAAR9  | MSEISABR9 | MSEISASB9 | MSEISAPR9 | MSEISAC9 | MSEISACN9    | 20       | 10/14/2022     | HD 1080i 25fps | MSEISAT9 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MSEISACN9'
And fill following custom fields for Add information form on order item page:
| Catalogue Structure | cat1   | cat2   | String       | Multiline       | Phone  | Date       | Radio Buttons | Dropdown | Address                                               |  Custom Code       |
| catalog             | value1 | value2 | string-value | multiline-value | 666666 | 01/28/2022 | t2            | drop1    | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine |  custom-code-value |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MSEISAJN9  | MSEISAPN9 |
And 'check' checkbox Archive for following clock number 'MSEISACN9' of QC View summary on Order Proceed page
And confirm order on Order Proceed page
And go to asset 'MSEISAT9' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName           | FieldValue                                            |
| Catalogue Structure | catalog                                               |
| cat1                | value1                                                |
| cat2                | value2                                                |
| String              | string-value                                          |
| Multiline           | multiline-value                                       |
| Phone               | 666666                                                |
| Date                | 01/28/2022                                            |
| Radio Buttons       | t2                                                    |
| Dropdown            | drop1                                                 |
| Address             | Chreshatik Street 45. Apart. 44,Kiev,Kiev,777,Ukraine |
| Custom Code         | custom-code-value                                     |


Scenario: Check that default field can be renamed
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| MSEISAA11 | DefaultA4User |
And I am on the global common ordering metadata page of market 'Republic of Ireland' for agency 'MSEISAA11'
When I click 'Title' button in 'editable metadata' section on opened metadata page
And fill Description field with text 'Title Auto Test' on opened Settings and Customization tab
And save metadata field settings
Then I 'should' see button 'Title Auto Test' in 'editable metadata' section on opened metadata page

Scenario: Check that default field can be renamed and it is displayed in Add Information section with changed name
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| MSEISAA12 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| MSEISAU12 | agency.admin | MSEISAA12    |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA12'
And clicked 'Title' button in 'editable metadata' section on opened metadata page
And filled Description field with text 'Title Auto Test' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'MSEISAU12'
When I created 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MSEISACN12   |
And open order item with following clock number 'MSEISACN12'
Then I should see following fields labels for order item on Add information form:
| Title           |
| Title Auto Test |

Scenario: Check that hyperlink fields in Common Ordering Metadata are successfully displayed in QC-ed assets after order confirming
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |Save In Library |Allow To Save In Library|
| MSEISAA9_1 | DefaultA4User |should          |should                  |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| MSEISAU9_1 | agency.admin | MSEISAA9_1     |streamlined_library,ordering|
And logged in with details of 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSEISAA9_1':
| Advertiser | Brand     | Sub Brand | Product   |
| MSEISAAR9_1  | MSEISABR9_1 | MSEISASB9_1 | MSEISAPR9_1 |
And I am on the global common ordering metadata page of market 'United Kingdom' for agency 'MSEISAA9_1'
And clicked 'Hyperlink' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'Hyperlink' on opened Settings and Customization tab
And saved metadata field settings
And logged in with details of 'MSEISAU9_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | MSEISAAR9_1  | MSEISABR9_1 | MSEISASB9_1 | MSEISAPR9_1 | MSEISAC9 | MSEISACN9_1    | 20       | 10/14/2022     | HD 1080i 25fps | MSEISAT9_1 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MSEISACN9_1'
And fill following custom fields for Add information form on order item page:
| Hyperlink           |
| http://www.adbank.me             |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MSEISAJN9_1  | MSEISAPN9_1 |
And 'check' checkbox Archive for following clock number 'MSEISACN9_1' of QC View summary on Order Proceed page
And confirm order on Order Proceed page
And go to asset 'MSEISAT9_1' info page in Library for collection 'My Assets'NEWLIB
Then I should see following hyperlink fields on opened asset info pageNEWLIB:
|FieldName|FieldValue|
|Hyperlink|http://www.adbank.me    |

