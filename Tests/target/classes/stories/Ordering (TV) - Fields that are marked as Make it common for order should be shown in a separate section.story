!--ORD-3918
!--ORD-4397
Feature: Fields that are marked as Make it common for order should be shown in a separate section
Narrative:
In order to:
As a AgencyAdmin
I want to check that fields that are marked as Make it common for order are shown in a separate section

Scenario: Check making as common of default catalogue structure fields
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MCFOFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU1 | agency.admin | MCFOFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'MCFOFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MCFOFCN1     |
When I open order item with following clock number 'MCFOFCN1'
Then I 'should' see following fields 'Advertiser,Brand,Sub Brand,Product,Campaign' for order item on Common Information section

Scenario: Check saving data in the fields that are marked as common
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MCFOFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU1 | agency.admin | MCFOFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'MCFOFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MCFOFCN2     |
When I open order item with following clock number 'MCFOFCN2'
And fill following fields for Common Information section on order item page:
| Advertiser | Brand    | Sub Brand | Product  | Campaign |
| MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 | MCFOFC2  |
And save as draft order
And open order item with following clock number 'MCFOFCN2'
Then I should see following data for order item on Common Information section:
| Advertiser | Brand    | Sub Brand | Product  | Campaign |
| MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 | MCFOFC2  |

Scenario: Check that marked as common fields are common for each order item
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MCFOFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU1 | agency.admin | MCFOFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'MCFOFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Advertiser | Brand    | Sub Brand | Product  | Campaign |
| MCFOFCN3     | MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 | MCFOFC3  |
When I open order item with following clock number 'MCFOFCN3'
And 'create new' order item by Add Commercial button on order item page
Then I should see following data for order item on Common Information section:
| Advertiser | Brand    | Sub Brand | Product  | Campaign |
| MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 | MCFOFC3  |

Scenario: Check that Common Information section is not shown if there are no any fields marked as common
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MCFOFA4 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU4 | agency.admin | MCFOFA4      |
And logged in with details of 'MCFOFU4'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MCFOFCN4     |
When I open order item with following clock number 'MCFOFCN4'
Then I 'should not' see following sections 'Common Information' on order item page

Scenario: Check saving Make it common for order option for metadatas under Global Admin in case ALL markets
Meta: @ordering
Given I am logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| MCFOFA5 | DefaultA4User |
And I am on the global common ordering metadata page of market 'ALL' for agency 'MCFOFA5'
And clicked '<Metadata>' button in 'editable metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And opened available metadata page 'Available Metadata'
When I click '<Metadata>' button in 'editable metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Make it common for order' on opened string field Settings and Customization page

Examples:
| Metadata        |
| Title           |
| Media Agency    |
| Posthouse       |
| Creative Agency |

Scenario: Check saving Make it common for order option for new custom metadata under Global Admin in case ALL markets
Meta: @ordering
Given I am logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| MCFOFA5 | DefaultA4User |
And I am on the global common ordering metadata page of market 'ALL' for agency 'MCFOFA5'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String Custom' on opened Settings and Customization tab
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I click 'String Custom' button in 'editable metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Make it common for order' on opened string field Settings and Customization page

Scenario: Check visibility metadatas which are making as common on order item page
Meta: @ordering
Given I am logged in as 'GlobalAdmin'
And created the following agency:
| Name    | A4User        |
| MCFOFA7 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU7 | agency.admin | MCFOFA7      |
And I am on the global common ordering metadata page of market 'ALL' for agency 'MCFOFA7'
And clicked 'Title' button in 'editable metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And clicked 'Media Agency' button in 'editable metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And logged in with details of 'MCFOFU7'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| MCFOFCN7     |
When I open order item with following clock number 'MCFOFCN7'
Then I 'should' see following fields 'Title,Media Agency' for order item on Common Information section

Scenario: Check confirming order with fields that are marked as common
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MCFOFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU1 | agency.admin | MCFOFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'MCFOFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 | MCFOFC8  | MCFOFCN8     | 20       | 10/14/2022     | HD 1080i 25fps | MCFOFT8 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MCFOFCN8'
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MCFOFJN8   | MCFOFPN8  |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'MCFOFCN8' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product  | Market         | PO Number | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 | United Kingdom | MCFOFPN8  | MCFOFJN8 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'MCFOFCN8' and items with following fields:
| Clock Number | Advertiser  | Product  | Title   | First Air Date | Format         | Duration | Status        |
| MCFOFCN8     | MCFOFAR1    | MCFOFPR1 | MCFOFT8 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: check that fields that are marked as common are locked after adding QC asset
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MCFOFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU1 | agency.admin | MCFOFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA1':
| Advertiser | Brand    | Sub Brand | Product  |
| MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'MCFOFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MCFOFAR1   | MCFOFBR1 | MCFOFSB1  | MCFOFPR1 | MCFOFC9  | MCFOFCN9_1   | 20       | 10/14/2022     | HD 1080i 25fps | MCFOFT9 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| MCFOFCN9_2   |
And complete order contains item with clock number 'MCFOFCN9_1' with following fields:
| Job Number | PO Number |
| MCFOFJN9   | MCFOFPN9  |
And add to 'tv' order item with clock number 'MCFOFCN9_2' following qc asset 'MCFOFT9' of collection 'My Assets'
When I open order item with clock number 'MCFOFCN9_1' for order with market 'Republic of Ireland'
Then I should see 'disabled' following fields 'Advertiser,Brand,Sub Brand,Product,Campaign' for order item on Common Information section

Scenario: Check that fields that are marked as common are not re-written after adding QC asset for second order item
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MCFOFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU1 | agency.admin | MCFOFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| MCFOFAR10_1 | MCFOFBR10_1 | MCFOFSB10_1 | MCFOFPR10_1 |
| MCFOFAR10_2 | MCFOFBR10_2 | MCFOFSB10_2 | MCFOFPR10_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'MCFOFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | MCFOFAR10_1 | MCFOFBR10_1 | MCFOFSB10_1 | MCFOFPR10_1 | MCFOFC10_1 | MCFOFCN10_1  | 20       | 10/14/2022     | HD 1080i 25fps | MCFOFT10_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | MCFOFAR10_2 | MCFOFBR10_2 | MCFOFSB10_2 | MCFOFPR10_2 | MCFOFC10_2 | MCFOFCN10_2  | 15       | 10/14/2022     | HD 1080i 25fps | MCFOFT10_2 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| MCFOFCN10_3  |
| MCFOFCN10_4  |
And complete order contains item with clock number 'MCFOFCN10_1' with following fields:
| Job Number | PO Number |
| MCFOFJN10  | MCFOFPN10 |
And add to 'tv' order item with clock number 'MCFOFCN10_3' following qc asset 'MCFOFT10_1' of collection 'My Assets'
And add to 'tv' order item with clock number 'MCFOFCN10_4' following qc asset 'MCFOFT10_2' of collection 'My Assets'
When I open order item with clock number 'MCFOFCN10_1' for order with market 'Republic of Ireland'
Then I should see following data for order item on Common Information section:
| Advertiser  | Brand       | Sub Brand   | Product     | Campaign   |
| MCFOFAR10_1 | MCFOFBR10_1 | MCFOFSB10_1 | MCFOFPR10_1 | MCFOFC10_1 |

Scenario: check custom code generation that based on fields that are marked as common
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MCFOFA11 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MCFOFU11 | agency.admin | MCFOFA11     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA11':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMCFOF11  | BRMCFOF11 | SBMCFOF11 | PRMCFOF11 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA11' by following fields:
| Make it common for order |
| should                   |
And update custom code 'Clock number' of schema 'video' agency 'MCFOFA11' by following fields:
| Name     | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| MCFOFC11 | 5                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Campaign:2 | should  |
And logged in with details of 'MCFOFU11'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser | Brand     | Sub Brand | Product   | Campaign  | Title    |
| ARMCFOF11  | BRMCFOF11 | SBMCFOF11 | PRMCFOF11 | CMMCFOF11 | MCFOFT11 |
When I open order item with next title 'MCFOFT11'
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,5}/ARBRSBPRCM' for field 'Clock Number' on Add information form of order item page

Scenario: check validation during custom code generation that based on fields that are marked as common
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MCFOFA11 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MCFOFU11 | agency.admin | MCFOFA11     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA11':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMCFOF11  | BRMCFOF11 | SBMCFOF11 | PRMCFOF11 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA11' by following fields:
| Make it common for order |
| should                   |
And update custom code 'Clock number' of schema 'video' agency 'MCFOFA11' by following fields:
| Name     | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| MCFOFC11 | 5                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Campaign:2 | should  |
And logged in with details of 'MCFOFU11'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Title    |
| MCFOFT12 |
When I open order item with next title 'MCFOFT12'
And click 'auto code' button for Add information form on order item page
Then I 'should' see validation errors next to following fields 'Advertiser,Brand,Sub Brand,Product,Campaign' for order item on Common Information section

Scenario: check validation of required fields that are marked as common during proceeding order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MCFOFA11 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MCFOFU11 | agency.admin | MCFOFA11     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA11':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMCFOF11  | BRMCFOF11 | SBMCFOF11 | PRMCFOF11 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA11' by following fields:
| Make it common for order |
| should                   |
And update custom code 'Clock number' of schema 'video' agency 'MCFOFA11' by following fields:
| Name     | Sequential Number | Free Text | Metadata Elements                                     | Enabled |
| MCFOFC11 | 5                 | /         | Advertiser:2,Brand:2,Sub Brand:2,Product:2,Campaign:2 | should  |
And logged in with details of 'MCFOFU11'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | MCFOFCN13    | 20       | 10/14/2022     | HD 1080i 25fps | MCFOFT13 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'MCFOFCN13'
And click active Proceed button on order item page
Then I 'should' see validation errors next to following fields 'Advertiser,Brand,Sub Brand,Product' for order item on Common Information section

Scenario: check validation in case simultaneously adding several QC assets with different common fields
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MCFOFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MCFOFU1 | agency.admin | MCFOFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MCFOFA1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| MCFOFAR10_1 | MCFOFBR10_1 | MCFOFSB10_1 | MCFOFPR10_1 |
| MCFOFAR10_2 | MCFOFBR10_2 | MCFOFSB10_2 | MCFOFPR10_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product,Campaign' in schema 'common' of agency 'MCFOFA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'MCFOFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | MCFOFAR10_1 | MCFOFBR10_1 | MCFOFSB10_1 | MCFOFPR10_1 | MCFOFC14_1 | MCFOFCN14_1  | 20       | 10/14/2022     | HD 1080i 25fps | MCFOFT14_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | MCFOFAR10_2 | MCFOFBR10_2 | MCFOFSB10_2 | MCFOFPR10_2 | MCFOFC14_2 | MCFOFCN14_2  | 15       | 10/14/2022     | HD 1080i 25fps | MCFOFT14_2 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| MCFOFCN14_3  |
And complete order contains item with clock number 'MCFOFCN14_1' with following fields:
| Job Number | PO Number |
| MCFOFJN14  | MCFOFPN14 |
When I open order item with following clock number 'MCFOFCN14_3'
And retrieve assets from library for order item at Add media to your order form
And select following qc assets 'MCFOFT14_1,MCFOFT14_2' for order item at Add media to your order form
And click Add To Order button at Add media to your order form on order item page
Then I should see message error 'You are not able to add another commercial to this order with different metadata. Please create a separate order.'


Scenario: Check that on Create New Order page, fields are displayed per sorted order:
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| COMCBSA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| COMCBSU1 | agency.admin | COMCBSA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'COMCBSA1':
| Advertiser | Brand     | Sub Brand | Product   |
| COMCBSAR1  | COMCBSBR1 | COMCBSSB1 | COMCBSPR1 |
And updated metadatas 'Advertiser,Product,' in schema 'common' of agency 'COMCBSA1' by following fields:
| Make it common for order |
| should                   |
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'ALL' for agency 'COMCBSA1'
And clicked 'Posthouse' button in 'Editable Metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'ALL' for agency 'COMCBSA1'
And clicked 'Creative Agency' button in 'Editable Metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'ALL' for agency 'COMCBSA1'
And I sorted common ordering fields into group 'Add Information' in following order in Active Metadata Preview block on opened metadata page:
| FieldName |
| Posthouse |
And logged in with details of 'COMCBSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination     |
| automated test info    | COMCBSAR1  | COMCBSBR1 | COMCBSSB1 | COMCBSPR1 | COMCBSU1 | COMCBSU1     | 20       | 12/14/2022     | HD 1080i 25fps | COMCBSU1 | Aastha:Standard |
When I open order item with following clock number 'COMCBSU1'
Then I 'should' see following fields 'Advertiser,Product,Post House,Creative Agency' in sorted order on order item in Common Information section


Scenario: Check confirming order after sorting common ordering fields:
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| COMCBSA2 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| COMCBSU2 | agency.admin | COMCBSA2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'COMCBSA2':
| Advertiser | Brand     | Sub Brand | Product   |
| COMCBSAR2  | COMCBSBR2 | COMCBSSB2 | COMCBSPR2 |
And updated metadatas 'Advertiser,Product' in schema 'common' of agency 'COMCBSA2' by following fields:
| Make it common for order |
| should                   |
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'ALL' for agency 'COMCBSA2'
And clicked 'Posthouse' button in 'Editable Metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'ALL' for agency 'COMCBSA2'
And clicked 'Creative Agency' button in 'Editable Metadata' section on opened metadata page
And checked 'Make it common for order' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And I logged in as 'GlobalAdmin'
And I am on the global common ordering metadata page of market 'ALL' for agency 'COMCBSA2'
And I sorted common ordering fields into group 'Add Information' in following order in Active Metadata Preview block on opened metadata page:
| FieldName |
| Posthouse |
And logged in with details of 'COMCBSU2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination     |
| automated test info    | COMCBSAR2  | COMCBSBR2 | COMCBSSB2 | COMCBSPR2 | COMCBSU2 | COMCBSU2     | 20       | 12/14/2022     | HD 1080i 25fps | COMCBSU2 | None               | Aastha:Standard |
When I open order item with following clock number 'COMCBSU2'
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| COMCBSJN2  | COMCBSPN2 |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'COMCBSU2' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | COMCBSAR2  | COMCBSBR2 | COMCBSSB2 | COMCBSPR2 | United Kingdom | COMCBSPN2 | COMCBSJN2 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'COMCBSU2' and items with following fields:
| Clock Number | Advertiser | Product   | Title    | First Air Date | Format         | Duration | Status        |
| COMCBSU2     | COMCBSAR2  | COMCBSPR2 | COMCBSU2 | 12/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |