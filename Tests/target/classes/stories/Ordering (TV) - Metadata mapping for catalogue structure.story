!--ORD-1529
!--ORD-1797
Feature: Check metadata mapping
Narrative:
In order to:
As a AgencyAdmin
I want to check correct metadata mapping

Scenario: Check that Mark as Advertiser check box is set
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMMCSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMMCSU1 | agency.admin | OTVMMCSA1    |
And logged in with details of 'OTVMMCSU1'
And on the metadata page
And clicked '<Field>' button in 'Common Metadata' section on opened metadata page
When I check 'Mark as Advertiser' checkbox on opened string field Settings and Customization page
And save metadata field settings
Then I 'should' see checked checkbox 'Mark as Advertiser' on opened string field Settings and Customization page
And 'should' see checked checkbox 'Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Field      |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |

Scenario: Check displaying feelds with Mark as Advertiser option
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMMCSA2 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMMCSU2 | agency.admin | OTVMMCSA2    |
And logged in with details of 'OTVMMCSU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMMCS_CN2  |
When I open order item with following clock number 'OTVMMCS_CN2'
Then I 'should' see following fields 'Advertiser,Brand,Sub Brand,Product' for order item on Add information form

Scenario: Check displaying Advertiser catalogue structure according to Mark as Advertiser option
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Advertiser |
| <Agency> | DefaultA4User | <Field>            |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And logged in with details of '<User>'
And on the metadata page
When I click '<Field>' button in 'Common Metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Mark as Advertiser' on opened string field Settings and Customization page

Examples:
| Field      | User        | Agency      |
| Advertiser | OTVMMCSU3_1 | OTVMMCSA3_1 |
| Brand      | OTVMMCSU3_2 | OTVMMCSA3_2 |
| Sub Brand  | OTVMMCSU3_3 | OTVMMCSA3_3 |
| Product    | OTVMMCSU3_4 | OTVMMCSA3_4 |

Scenario: Check displaying Advertiser catalogue structure according to Mark as Product option
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Product |
| <Agency> | DefaultA4User | <Field>         |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And logged in with details of '<User>'
And on the metadata page
When I click '<Field>' button in 'Common Metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Mark as Product' on opened string field Settings and Customization page

Examples:
| Field      | User        | Agency      |
| Advertiser | OTVMMCSU4_1 | OTVMMCSA4_1 |
| Brand      | OTVMMCSU4_2 | OTVMMCSA4_2 |
| Sub Brand  | OTVMMCSU4_3 | OTVMMCSA4_3 |
| Product    | OTVMMCSU4_4 | OTVMMCSA4_4 |

Scenario: Check that Mark as Advertiser and Mark as Product cannot be both selected
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Mark as Advertiser |
| OTVMMCSA5 | DefaultA4User | <Field>            |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMMCSU5 | agency.admin | OTVMMCSA5    |
And logged in with details of 'OTVMMCSU5'
And on the metadata page
And clicked '<Field>' button in 'Common Metadata' section on opened metadata page
When I check 'Mark as Product' checkbox on opened string field Settings and Customization page
And check 'Mark as Advertiser' checkbox on opened string field Settings and Customization page
And save metadata field settings
Then I 'should not' see checked checkbox 'Mark as Product' on opened string field Settings and Customization page

Examples:
| Field      |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |

Scenario: Check data after save Draft order with empty Advertiser
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Advertiser |
| <Agency> | DefaultA4User | <Field>            |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| <Email> | agency.admin | <Agency>     |
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And save as draft order
Then I should see TV 'draft' order in order list with following fields:
| Clock Number  | Advertiser |
| <ClockNumber> |            |
And should see 'draft' order in 'tv' order list contains clock number '<ClockNumber>' and items with following fields:
| Clock Number  | Advertiser | Product |
| <ClockNumber> |            |         |

Examples:
| Field      | ClockNumber  | Email       | Agency      |
| Advertiser | OTVMMCSCN6_1 | OTVMMCSU6_1 | OTVMMCSA6_1 |
| Brand      | OTVMMCSCN6_2 | OTVMMCSU6_2 | OTVMMCSA6_2 |
| Sub Brand  | OTVMMCSCN6_3 | OTVMMCSU6_3 | OTVMMCSA6_3 |
| Product    | OTVMMCSCN6_4 | OTVMMCSU6_4 | OTVMMCSA6_4 |

Scenario: Check that correct values are showed in Advertiser on Draft tab
!--ORD-739
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Advertiser |
| <Agency> | DefaultA4User | <Field>            |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| <Email> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMMCSAR7 | OTVMMCSBR7 | OTVMMCSSB7 | OTVMMCSPR7 |
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand      | Sub Brand   | Product    | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVMMCSAR7  | OTVMMCSBR7 | OTVMMCSSB7  | OTVMMCSPR7 | OTVMMCSC7 | <ClockNumber> | 20       | 08/15/2022     | HD 1080i 25fps | OTVMMCST7 |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV 'draft' order in order list with following fields:
| Clock Number  | Advertiser |
| <ClockNumber> | OTVMMCSAR7 |
And should see 'draft' order in 'tv' order list contains clock number '<ClockNumber>' and items with following fields:
| Clock Number  | Advertiser |
| <ClockNumber> | <Data>     |

Examples:
| Field      | Data       | Email       | ClockNumber  | Agency      |
| Advertiser | OTVMMCSAR7 | OTVMMCSU7_1 | OTVMMCSCN7_1 | OTVMMCSA7_1 |
| Brand      | OTVMMCSBR7 | OTVMMCSU7_2 | OTVMMCSCN7_2 | OTVMMCSA7_2 |
| Sub Brand  | OTVMMCSSB7 | OTVMMCSU7_3 | OTVMMCSCN7_3 | OTVMMCSA7_3 |
| Product    | OTVMMCSPR7 | OTVMMCSU7_4 | OTVMMCSCN7_4 | OTVMMCSA7_4 |

Scenario: Check that correct values  are showed in Product on Draft tab
!--ORD-839
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Product |
| <Agency> | DefaultA4User | <Field>         |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| <Email> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMMCSAR8 | OTVMMCSBR8 | OTVMMCSSB8 | OTVMMCSPR8 |
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand   | Product    | Campaign  | Clock Number  | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVMMCSAR8 | OTVMMCSBR8 | OTVMMCSSB8  | OTVMMCSPR8 | OTVMMCSC8 | <ClockNumber> | 20       | 08/15/2022     | HD 1080i 25fps | OTVMMCST8 |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see 'draft' order in 'tv' order list contains clock number '<ClockNumber>' and items with following fields:
| Clock Number  | Product |
| <ClockNumber> | <Data>  |

Examples:
| Field      | Data       | Email       | ClockNumber  | Agency      |
| Advertiser | OTVMMCSAR8 | OTVMMCSU8_1 | OTVMMCSCN8_1 | OTVMMCSA8_1 |
| Brand      | OTVMMCSBR8 | OTVMMCSU8_2 | OTVMMCSCN8_2 | OTVMMCSA8_2 |
| Sub Brand  | OTVMMCSSB8 | OTVMMCSU8_3 | OTVMMCSCN8_3 | OTVMMCSA8_3 |
| Product    | OTVMMCSPR8 | OTVMMCSU8_4 | OTVMMCSCN8_4 | OTVMMCSA8_4 |

Scenario: Check correct search by QC Product
!--ORD-739
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMMCSA9 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMMCSU9 | agency.admin | OTVMMCSA9    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMMCSA9':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMMCSAR9 | OTVMMCSBR9 | OTVMMCSSB9 | OTVMMCSPR9 |
And logged in with details of 'OTVMMCSU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVMMCSAR9 | OTVMMCSBR9 | OTVMMCSSB9 | OTVMMCSPR9 | OTVMMCSC9 | OTVMMCSCN9_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMMCS.T9 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVMMCSCN9_1' with following fields:
| Job Number | PO Number  |
| OTVMMCSJN9 | OTVMMCSPN9 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVMMCSCN9_2 |
When I open order item with following clock number 'OTVMMCSCN9_2'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value 'OTVMMCSPR9' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following assets:
| Name       |
| OTVMMCS.T9 |

Scenario: Check correct search by QC Advertiser
!--ORD-739
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMMCSA10 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVMMCSU10 | agency.admin | OTVMMCSA10   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMMCSA10':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMMCSAR10 | OTVMMCSBR10 | OTVMMCSSB10 | OTVMMCSPR10 |
And logged in with details of 'OTVMMCSU10'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVMMCSAR10 | OTVMMCSBR10 | OTVMMCSSB10 | OTVMMCSPR10 | OTVMMCSC10 | OTVMMCSCN10_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMMCS.T10 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVMMCSCN10_1' with following fields:
| Job Number  | PO Number   |
| OTVMMCSJN10 | OTVMMCSPN10 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| OTVMMCSCN10_2 |
When I open order item with following clock number 'OTVMMCSCN10_2'
And retrieve assets from library for order item at Add media to your order form
And fill Search field by value 'OTVMMCSAR10' for Add media to your order form on order item page
Then I 'should' see for order item at Add media to your order form following assets:
| Name        |
| OTVMMCS.T10 |

Scenario: Rename the Advertiser field in metadata and check data in Draft
!--ORD-739
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Advertiser | Mark as Product |
| <Agency> | DefaultA4User | <Field>            | Brand           |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| <Email> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMMCSAR11 | OTVMMCSBR11 | OTVMMCSSB11 | OTVMMCSPR11 |
And logged in with details of '<Email>'
And on the metadata page
And clicked '<Field>' button in 'Common Metadata' section on opened metadata page
And changed field name in description field to 'Vertus'
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand    | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      |
| automated test info    | OTVMMCSAR11 | OTVMMCSBR11 | OTVMMCSSB11  | OTVMMCSPR11 | OTVMMCSC11 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVMMCST11 |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV 'draft' order in order list with following fields:
| Clock Number  | Advertiser  |
| <ClockNumber> | OTVMMCSAR11 |
And should see 'draft' order in 'tv' order list contains clock number '<ClockNumber>' and items with following fields:
| Clock Number  | Advertiser |
| <ClockNumber> | <Data>     |

Examples:
| Field     | Data        | Email        | ClockNumber   | Agency       |
| Sub Brand | OTVMMCSSB11 | OTVMMCSU11_1 | OTVMMCSCN11_1 | OTVMMCSA11_1 |
| Product   | OTVMMCSPR11 | OTVMMCSU11_2 | OTVMMCSCN11_2 | OTVMMCSA11_2 |

Scenario: Rename the Product field in metadata and check data in Draft
!--ORD-739
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Mark as Product |
| <Agency> | DefaultA4User | <Field>         |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| <Email> | agency.admin | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser  | Brand       | Sub Brand   | Product     |
| OTVMMCSAR12 | OTVMMCSBR12 | OTVMMCSSB12 | OTVMMCSPR12 |
And logged in with details of '<Email>'
And on the metadata page
And clicked '<Field>' button in 'Common Metadata' section on opened metadata page
And changed field name in description field to 'Vertus'
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand    | Product     | Campaign   | Clock Number  | Duration | First Air Date | Format         | Title      |
| automated test info    | OTVMMCSAR12 | OTVMMCSBR12 | OTVMMCSSB12  | OTVMMCSPR12 | OTVMMCSC12 | <ClockNumber> | 20       | 08/15/2022     | HD 1080i 25fps | OTVMMCST12 |
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I should see 'draft' order in 'tv' order list contains clock number '<ClockNumber>' and items with following fields:
| Clock Number  | Product |
| <ClockNumber> | <Data>  |

Examples:
| Field     | Data        | Email        | ClockNumber   | Agency       |
| Sub Brand | OTVMMCSSB12 | OTVMMCSU12_1 | OTVMMCSCN12_1 | OTVMMCSA12_1 |
| Product   | OTVMMCSPR12 | OTVMMCSU12_2 | OTVMMCSCN12_2 | OTVMMCSA12_2 |

Scenario: Check that Mark as Advertiser and Mark as Product can be selected not only from the same catalogue hierarchy
!--ORD-4121
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVMMCSA13 | DefaultA4User |
And created users with following fields:
| Email     | Role          | AgencyUnique |
| OTVMMCSU13 | agency.admin | OTVMMCSA13   |
And created following 'common' custom metadata fields for agency 'OTVMMCSA13':
| FieldType          | Description | Parent |
| CatalogueStructure | Cat1        |        |
| CatalogueStructure | Cat2        | Cat1   |
And created following 'common' custom metadata fields for agency 'OTVMMCSA13':
| FieldType          | Description | Parent |
| CatalogueStructure | Cat3        |        |
| CatalogueStructure | Cat4        | Cat3   |
And logged in with details of 'OTVMMCSU13'
When go to the metadata page
And click 'Cat1' button in 'Common Metadata' section on opened metadata page
When I check 'Mark as Advertiser' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Cat3' button in 'Common Metadata' section on opened metadata page
When I check 'Mark as Product' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Cat1' button in 'Common Metadata' section on opened metadata page
And I check 'Mark as Advertiser' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Cat3' button in 'Common Metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Mark as Product' on opened string field Settings and Customization page