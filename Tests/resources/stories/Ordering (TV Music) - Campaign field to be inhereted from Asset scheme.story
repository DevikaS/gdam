!--ORD-2613
!--ORD-2745
Feature: Campaign field to be inhereted from Asset scheme
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of campaign inheritance

Scenario: check campaign in order list after save as draft
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA1 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU1 | agency.admin | OCFA1        |
And created following 'common' custom metadata fields for agency 'OCFA1':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA1' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Title | Duration | First Air Date | Format         |
| automated test info    | OCFCN1       | OCFT1 | 20       | 10/14/2022     | HD 1080i 25fps |
When I open order item with following clock number 'OCFCN1'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR1            | OCFBR1       | OCFPR1         | OCFC1           |
And save as draft order
Then I should see TV order in 'draft' order list with item clock number 'OCFCN1' and following fields:
| Order# | DateTime    | Advertiser | Brand  | Product | Campaign | Market         | NoClocks | Creator | Owner |
| Digit  | CurrentTime | OCFAR1     | OCFBR1 | OCFPR1  | OCFC1    | United Kingdom | 1        | OCFU1   | OCFU1 |
And should see 'draft' order in 'tv' order list contains clock number 'OCFCN1' and items with following fields:
| Clock Number | Advertiser | Product | Title | First Air Date | Format         | Duration |
| OCFCN1       | OCFAR1     | OCFPR1  | OCFT1 | 10/14/2022     | HD 1080i 25fps | 20       |

Scenario: check campaign in live order list for music orders
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA2 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU2 | agency.admin | OCFA2        |
And created following 'common' custom metadata fields for agency 'OCFA2':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA2' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU2'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | ISRC Code | Title | Release Date | Format         | Destination                 |
| automated test info    | OCFCN2    | OCFT2 | 10/14/2022   | HD 1080i 25fps | Aastha:Standard |
When I open order item with following isrc code 'OCFCN2'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR2            | OCFBR2       | OCFPR2         | OCFC2           |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OCFJN2     | OCFPN2    |
And confirm order on Order Proceed page
Then I should see Music order in 'live' order list with item isrc code 'OCFCN2' and following fields:
| Order# | DateTime    | Advertiser | Brand  | Product | Campaign | Market         | PO Number | Job #  | NoClocks | Status        |
| Digit  | CurrentTime | OCFAR2     | OCFBR2 | OCFPR2  | OCFC2    | United Kingdom | OCFPN2    | OCFJN2 | 1        | 0/1 Delivered |
And should see 'live' order in 'music' order list contains isrc code 'OCFCN2' and items with following fields:
| ISRC Code | Advertiser | Product | Campaign | Title | Release Date | Format         | Status        |
| OCFCN2    | OCFAR2     | OCFPR2  | OCFC2    | OCFT2 | 10/14/2022   | HD 1080i 25fps | 0/1 Delivered |

Scenario: check campaign on files thumbnail in case to retrieve from project for music orders
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA3 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU3 | agency.admin | OCFA3        |
And created following 'common' custom metadata fields for agency 'OCFA3':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA3' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU3'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code |
| OCFCN3_1  |
And created 'OCFP3' project
And created '/OCFF3' folder for project 'OCFP3'
And uploaded into project 'OCFP3' following files:
| FileName                   | Path   |
| /files/13DV-CAPITAL-10.mpg | /OCFF3 |
And waited while transcoding is finished in folder '/OCFF3' on project 'OCFP3' files page
And I am on file '13DV-CAPITAL-10.mpg' info page in folder '/OCFF3' project 'OCFP3'
When I 'save' file info by next information:
| FieldName         | FieldValue  |
| Advertiser Custom | OCFAR3      |
| Brand Custom      | OCFBR3      |
| Product Custom    | OCFPR3      |
| Campaign Custom   | OCFC3       |
| Clock number      | OCFCN3_2    |
| Screen            | Music Promo |
And open order item with following isrc code 'OCFCN3_1'
And retrieve files from projects for order item at Add media to your order form
And open project 'OCFP3' folder '/OCFF3' at Add media to your order form for retrieving files
Then I should see for 'music' order item at Add media to your order form following files metadata:
| Title               | Advertiser | Campaign | ISRC Code | Aspect Ratio |
| 13DV-CAPITAL-10.mpg | OCFAR3     | OCFC3    | OCFCN3_2  | 16:9         |

Scenario: check search by campaign in draft order list
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA4 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU4 | agency.admin | OCFA4        |
And created following 'common' custom metadata fields for agency 'OCFA4':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA4' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Title | Duration | First Air Date | Format         |
| automated test info    | OCFCN4_1     | OCFT4 | 20       | 10/14/2022     | HD 1080i 25fps |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OCFCN4_2     |
When I open order item with following clock number 'OCFCN4_1'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR4            | OCFBR4       | OCFPR4         | OCFC4           |
And save as draft order
When I fill Search orders field by value 'OCFC4' in 'draft' order list on ordering page
Then I should see TV order in 'draft' order list with item clock number 'OCFCN4_1' and following fields:
| Order# | DateTime    | Advertiser | Brand  | Product | Campaign | Market         | NoClocks | Creator | Owner |
| Digit  | CurrentTime | OCFAR4     | OCFBR4 | OCFPR4  | OCFC4    | United Kingdom | 1        | OCFU4   | OCFU4 |

Scenario: check campaign on Add Information section after adding QC asset
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA5 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU5 | agency.admin | OCFA5        |
And created following 'common' custom metadata fields for agency 'OCFA5':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA5' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Title | Duration | First Air Date | Format         | Subtitles Required | Destination                 |
| automated test info    | OCFCN5_1     | OCFT5 | 20       | 10/14/2022     | HD 1080i 25fps | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OCFCN5_2     |
When I open order item with following clock number 'OCFCN5_1'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR5            | OCFBR5       | OCFPR5         | OCFC5           |
And save as draft order
And completed order contains item with clock number 'OCFCN5_1' with following fields:
| Job Number | PO Number |
| OCFJN5     | OCFPN5    |
And added to 'tv' order item with clock number 'OCFCN5_2' following qc asset 'OCFT5' of collection 'My Assets'
And open order item with clock number 'OCFCN5_1' for order with market 'Republic of Ireland'
Then I should see following data for order item on Add information form:
| Additional Information | Clock Number | Title | Duration | First Air Date | Format      |
|                        | OCFCN5_1     | OCFT5 | 20       | 10/14/2022     | SD PAL 16x9 |
And should see following custom advertiser hierarchy fields data for order item on Add information form:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR5            | OCFBR5       | OCFPR5         | OCFC5           |

Scenario: check that campaign is cleared after clearing Add information section
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA6 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU6 | agency.admin | OCFA6        |
And created following 'common' custom metadata fields for agency 'OCFA6':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA6' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU6'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Title | Duration | First Air Date | Format         |
| automated test info    | OCFCN6       | OCFT6 | 20       | 10/14/2022     | HD 1080i 25fps |
When I open order item with following clock number 'OCFCN6'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR6            | OCFBR6       | OCFPR6         | OCFC6           |
And save as draft order
And open order item with following clock number 'OCFCN6'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Clock Number | Title | Duration | First Air Date | Format |
|                        |              |       |          |                |        |
And should see following custom advertiser hierarchy fields data for order item on Add information form:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
|                   |              |                |                 |

Scenario: check that campaign is copied to order items after Copy to All action
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA7 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU7 | agency.admin | OCFA7        |
And created following 'common' custom metadata fields for agency 'OCFA7':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA7' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU7'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Title | Duration | First Air Date | Format         | Subtitles Required |
| automated test info    | OCFCN7_1     | OCFT7 | 20       | 10/14/2022     | HD 1080i 25fps | Already Supplied   |
|                        | OCFCN7_2     |       |          |                |                |                    |
When I open order item with following clock number 'OCFCN7_1'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR7            | OCFBR7       | OCFPR7         | OCFC7           |
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following clock number 'OCFCN7_1' on cover flow
Then I should see following data for order item on Add information form:
| Additional Information | Clock Number | Title | Duration | First Air Date | Format         | Subtitles Required |
| automated test info    | OCFCN7_1     | OCFT7 | 20       | 10/14/2022     | HD 1080i 25fps | Already Supplied   |
And should see following custom advertiser hierarchy fields data for order item on Add information form:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR7            | OCFBR7       | OCFPR7         | OCFC7           |

Scenario: check sorting by campaign column in order list
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA8 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU8 | agency.admin | OCFA8        |
And created following 'common' custom metadata fields for agency 'OCFA8':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA8' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU8'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OCFCN8_1     |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OCFCN8_2     |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OCFCN8_3     |
When I open order item with following clock number 'OCFCN8_1'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR8_1          | OCFBR8_1     | OCFPR8_1       | A_OCFC8_1       |
And save as draft order
And open order item with following clock number 'OCFCN8_2'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR8_2          | OCFBR8_2     | OCFPR8_2       | C_OCFC8_2       |
And save as draft order
And open order item with following clock number 'OCFCN8_3'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR8_3          | OCFBR8_3     | OCFPR8_3       | T_OCFC8_3       |
And save as draft order
When sort order list by column 'Campaign Custom' with following sorting order 'ASC' on ordering page
Then I should see following values 'A_OCFC8_1,C_OCFC8_2,T_OCFC8_3' for column 'Campaign Custom' of advertiser hierarchy in 'draft' order list
When sort order list by column 'Campaign Custom' with following sorting order 'DESC' on ordering page
Then I should see following values 'T_OCFC8_3,C_OCFC8_2,A_OCFC8_1' for column 'Campaign Custom' of advertiser hierarchy in 'draft' order list

Scenario: check advertiser hierarchy after change marked fields in CM
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OCFA9 | DefaultA4User |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OCFU9 | agency.admin | OCFA9        |
And created following 'common' custom metadata fields for agency 'OCFA9':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Product Custom    | Brand Custom      | true     | true                |
| CatalogueStructure | Campaign Custom   | Product Custom    | true     | true                |
And updated agency 'OCFA9' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product | Mark as Campaign |
| Advertiser Custom  | Product Custom  | Campaign Custom  |
And logged in with details of 'OCFU9'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | ISRC Code | Title | Release Date | Format         |
| automated test info    | OCFCN9    | OCFT9 | 10/14/2022   | HD 1080i 25fps |
When I open order item with following isrc code 'OCFCN9'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Product Custom | Campaign Custom |
| OCFAR9            | OCFBR9       | OCFPR9         | OCFC9           |
And save as draft order
And I go to the global 'common custom' metadata page for agency 'OCFA9'
And click 'Advertiser Custom' button in 'Common Metadata' section on opened metadata page
And check 'Mark as Campaign' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Campaign Custom' button in 'Common Metadata' section on opened metadata page
And check 'Mark as Advertiser' checkbox on opened string field Settings and Customization page
And save metadata field settings
And go to View Draft Orders tab of 'music' order on ordering page
Then I should see Music order in 'draft' order list with item isrc code 'OCFCN9' and following fields:
| Order# | DateTime    | Advertiser | Brand  | Product | Campaign | Market         | NoClocks | Creator | Owner |
| Digit  | CurrentTime | OCFC9      | OCFBR9 | OCFPR9  | OCFAR9   | United Kingdom | 1        | OCFU9   | OCFU9 |
And should see 'draft' order in 'music' order list contains isrc code 'OCFCN9' and items with following fields:
| ISRC Code | Advertiser | Product | Campaign | Title | Release Date | Format         |
| OCFCN9    | OCFAR9     | OCFPR9  | OCFC9    | OCFT9 | 10/14/2022   | HD 1080i 25fps |

Scenario: check campaign after transfer an order between agencies
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OCFA10_1 | DefaultA4User |
| OCFA10_2 | DefaultA4User |
And added agency 'OCFA10_2' as a partner to agency 'OCFA10_1'
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OCFU10_1 | agency.admin | OCFA10_1     |
| OCFU10_2 | agency.admin | OCFA10_2     |
And created following 'common' custom metadata fields for agency 'OCFA10_1':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_1 |                     | true     | true                |
| CatalogueStructure | Brand Custom_1      | Advertiser Custom_1 | true     | true                |
| CatalogueStructure | Product Custom_1    | Brand Custom_1      | true     | true                |
| CatalogueStructure | Campaign Custom_1   | Product Custom_1    | true     | true                |
And created following 'common' custom metadata fields for agency 'OCFA10_2':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_2 |                     | true     | true                |
| CatalogueStructure | Brand Custom_2      | Advertiser Custom_2 | true     | true                |
| CatalogueStructure | Product Custom_2    | Brand Custom_2      | true     | true                |
| CatalogueStructure | Campaign Custom_2   | Product Custom_2    | true     | true                |
And updated agency 'OCFA10_1' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product  | Mark as Campaign  |
| Advertiser Custom_1 | Product Custom_1 | Campaign Custom_1 |
And updated agency 'OCFA10_2' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product  | Mark as Campaign  |
| Advertiser Custom_2 | Product Custom_2 | Campaign Custom_2 |
And logged in with details of 'OCFU10_1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | ISRC Code | Title    | Release Date | Format         | Destination                 |
| automated test info    | OCFCN10_1 | OCFT10_1 | 10/14/2022   | HD 1080i 25fps | Aastha:Standard |
When I open order item with following isrc code 'OCFCN10_1'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_1 | Brand Custom_1 | Product Custom_1 | Campaign Custom_1 |
| OCFAR10_1           | OCFBR10_1      | OCFPR10_1        | OCFC10_1          |
And save as draft order
And transfer order contains item with isrc code 'OCFCN10_1' to user 'OCFU10_2' with following message 'autotest transfer message'
And login with details of 'OCFU10_2'
And open order item with following isrc code 'OCFCN10_1'
And fill following fields for Add information form on order item page:
| Additional Information | ISRC Code | Title    | Release Date | Format         |
| automated test info    | OCFCN10_2 | OCFT10_2 | 11/14/2022   | HD 1080i 25fps |
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_1 | Brand Custom_1 | Product Custom_1 | Campaign Custom_1 |
| OCFAR10_2           | OCFBR10_2      | OCFPR10_2        | OCFC10_2          |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| OCFJN10    | OCFPN10   |
And confirm order on Order Proceed page
And refresh the page without delay
Then I should see Music order in 'live' order list with item isrc code 'OCFCN10_2' and following fields:
| Order# | DateTime    | Advertiser | Brand | Product   | Campaign | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | OCFAR10_2  |       | OCFPR10_2 | OCFC10_2 | United Kingdom | OCFPN10   | OCFJN10 | 1        | 0/1 Delivered |
And should see 'live' order in 'music' order list contains isrc code 'OCFCN10_2' and items with following fields:
| ISRC Code | Advertiser | Product   | Campaign | Title    | Release Date | Format         | Status        |
| OCFCN10_2 | OCFAR10_2  | OCFPR10_2 | OCFC10_2 | OCFT10_2 | 11/14/2022   | HD 1080i 25fps | 0/1 Delivered |
When I login with details of 'OCFU10_1'
And go to View Live Orders tab of 'music' order on ordering page
And refresh the page without delay
Then I should see Music order in 'live' order list with item isrc code 'OCFCN10_2' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Product   | Campaign | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | OCFAR10_2  | OCFBR10_2 | OCFPR10_2 | OCFC10_2 | United Kingdom | OCFPN10   | OCFJN10 | 1        | 0/1 Delivered |
And should see 'live' order in 'music' order list contains isrc code 'OCFCN10_2' and items with following fields:
| ISRC Code | Advertiser | Product   | Campaign | Title    | Release Date | Format         | Status        |
| OCFCN10_2 | OCFAR10_2  | OCFPR10_2 | OCFC10_2 | OCFT10_2 | 11/14/2022   | HD 1080i 25fps | 0/1 Delivered |