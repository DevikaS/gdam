!--ORD-3141
!--ORD-4396
Feature: Spanish watermarking requirements
Narrative:
In order to:
As a AgencyAdmin
I want to check spanish watermarking requirements

Scenario: Check saving Watermarking Required fields after filling
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| SWRA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| SWRU1 | agency.admin | SWRA1        |
And logged in with details of 'SWRU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number |
| SWRCN1       |
When I open order item with following clock number 'SWRCN1'
And fill following fields for Add information form on order item page:
| Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product |
| Yes                   | SWRPD1              | SWRCD1               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                |
And save as draft order
And open order item with following clock number 'SWRCN1'
Then I should see following data for order item on Add information form:
| Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product |
| Yes                   | SWRPD1              | SWRCD1               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                |

Scenario: Check Watermarking Required fields after Copy current
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| SWRA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| SWRU1 | agency.admin | SWRA1        |
And logged in with details of 'SWRU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product |
| SWRCN2       | Yes                   | SWRPD2              | SWRCD2               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                |
When I open order item with following clock number 'SWRCN2'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data for order item on Add information form:
| Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product |
| Yes                   | SWRPD2              | SWRCD2               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                |

Scenario: Check Watermarking Required fields after Copy to All
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| SWRA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| SWRU1 | agency.admin | SWRA1        |
And logged in with details of 'SWRU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product |
| SWRCN3_1     | Yes                   | SWRPD3_1            | SWRCD3_1             | HOGAR  | PRODUCTOS INFANTILES | CUNAS                |
| SWRCN3_2     |                       |                     |                      |        |                      |                      |
When I open order item with following clock number 'SWRCN3_1'
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following clock number 'SWRCN3_1' on cover flow
Then I should see following data for order item on Add information form:
| Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product |
| Yes                   | SWRPD3_1            | SWRCD3_1             | HOGAR  | PRODUCTOS INFANTILES | CUNAS                |

Scenario: Check clearing of Watermarking Required fields
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| SWRA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| SWRU1 | agency.admin | SWRA1        |
And logged in with details of 'SWRU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number | Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product |
| SWRCN4       | Yes                   | SWRPD4              | SWRCD4               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                |
When I open order item with following clock number 'SWRCN4'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Watermarking Required |
| No                    |

Scenario: Check limitation of Product Description field on order item page
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| SWRA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| SWRU1 | agency.admin | SWRA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SWRA1':
| Advertiser | Brand  | Sub Brand | Product |
| SWRAR5     | SWRBR5 | SWRSB5    | SWRP5   |
And logged in with details of 'SWRU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Clave  | Watermarking Required | Product Description                                                                                                                                                  | Creative Description | Sector | Group                | Watermarking Product | Destination           |
| automated test info    | SWRAR5     | SWRBR5 | SWRSB5    | SWRP5   | SWRC5    | SWRCN5       | 20       | 10/14/2022     | HD 1080i 25fps | SWRT5 | Yes                | SWRCL5 | Yes                   | Phantasy Sound Under Exclusive License to Amazing And Beautiful Los Angeles California From English As A Seconf Language USA Podcast And Because Music Awards SWRPD5 | SWRCD5               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                | Barcelona TV:Standard |
When I open order item with following clock number 'SWRCN5'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'Product Description' for order item on Add information form

Scenario: Check limitation of Creative Description field on order item page
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| SWRA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| SWRU1 | agency.admin | SWRA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SWRA1':
| Advertiser | Brand  | Sub Brand | Product |
| SWRAR5     | SWRBR5 | SWRSB5    | SWRP5   |
And logged in with details of 'SWRU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Clave  | Watermarking Required | Product Description | Creative Description                                                                                                                                                 | Sector | Group                | Watermarking Product | Destination           |
| automated test info    | SWRAR5     | SWRBR5 | SWRSB5    | SWRP5   | SWRC6    | SWRCN6       | 20       | 10/14/2022     | HD 1080i 25fps | SWRT6 | Yes                | SWRCL6 | Yes                   | SWRPD6              | Phantasy Sound Under Exclusive License to Amazing And Beautiful Los Angeles California From English As A Seconf Language USA Podcast And Because Music Awards SWRCD6 | HOGAR  | PRODUCTOS INFANTILES | CUNAS                | Barcelona TV:Standard |
When I open order item with following clock number 'SWRCN6'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'Creative Description' for order item on Add information form

Scenario: Check that values of Spanish watermarking fields correctly displayed on QC-ed asset details page
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| SWRA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |Access|
| SWRU1 | agency.admin | SWRA1        |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SWRA1':
| Advertiser | Brand  | Sub Brand | Product |
| SWRAR5     | SWRBR5 | SWRSB5    | SWRP5   |
And logged in with details of 'SWRU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Clave  | Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product | Destination           |
| automated test info    | SWRAR5     | SWRBR5 | SWRSB5    | SWRP5   | SWRC8    | SWRCN8       | 20       | 10/14/2022     | HD 1080i 25fps | SWRT8 | Yes                | SWRCL8 | Yes                   | SWRPD8              | SWRCD8               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                | Barcelona TV:Standard |
And complete order contains item with clock number 'SWRCN8' with following fields:
| Job Number | PO Number |
| SWRJN8     | SWRPN8    |
And I am on asset 'SWRT8' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName             | FieldValue           |
| Watermarking Required | Yes                  |
| Product Description   | SWRPD8               |
| Creative Description  | SWRCD8               |
| Sector                | HOGAR                |
| Group                 | PRODUCTOS INFANTILES |

Scenario: Check that values of Spanish watermarking fields correctly displayed on order item page after retriving QC asset with those fields
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| SWRA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| SWRU1 | agency.admin | SWRA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SWRA1':
| Advertiser | Brand  | Sub Brand | Product |
| SWRAR5     | SWRBR5 | SWRSB5    | SWRP5   |
And logged in with details of 'SWRU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Clave  | Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product | Destination           |
| automated test info    | SWRAR5     | SWRBR5 | SWRSB5    | SWRP5   | SWRC9    | SWRCN9_1     | 20       | 10/14/2022     | HD 1080i 25fps | SWRT9 | Yes                | SWRCL9 | Yes                   | SWRPD9              | SWRCD9               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                | Barcelona TV:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number |
| SWRCN9_2     |
And complete order contains item with clock number 'SWRCN9_1' with following fields:
| Job Number | PO Number |
| SWRJN9     | SWRPN9    |
And add to 'tv' order item with clock number 'SWRCN9_2' following qc asset 'SWRT9' of collection 'My Assets'
When I open order item with following clock number 'SWRCN9_1'
Then I should see following data for order item on Add information form:
| Watermarking Required | Product Description | Creative Description | Sector | Group                | Watermarking Product |
| Yes                   | SWRPD9              | SWRCD9               | HOGAR  | PRODUCTOS INFANTILES | CUNAS                |