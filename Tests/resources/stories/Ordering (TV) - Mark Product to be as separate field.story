!--ORD-4078
!--ORD-4138
Feature: Mark Product to be as separate field
Narrative:
In order to:
As a AgencyAdmin
I want to check that mark as product field to be as separate field

Scenario: Check marking as Product for String and Dropdown fields
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MPSFU1 | agency.admin | MPSFA1       |
And logged in with details of 'MPSFU1'
And I am on the global 'common custom' metadata page for agency 'MPSFA1'
And clicked '<Metadata>' button in 'custom metadata' section on opened metadata page
And filled Description field with text '<Description>' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I open available metadata page 'Available Metadata'
And click '<Description>' button in 'common metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Mark as Product,Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Metadata | Description      |
| String   | String Product   |
| Dropdown | Dropdown Product |

Scenario: Check unmarking as Product for String and Dropdown fields
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA1 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MPSFU1 | agency.admin | MPSFA1       |
And logged in with details of 'MPSFU1'
And I am on the global 'common custom' metadata page for agency 'MPSFA1'
And clicked '<Metadata>' button in 'custom metadata' section on opened metadata page
And filled Description field with text '<Description>' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I open available metadata page 'Available Metadata'
And click '<Description>' button in 'common metadata' section on opened metadata page
And uncheck 'Mark as Product' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click '<Description>' button in 'common metadata' section on opened metadata page
Then I 'should not' see checked checkbox 'Mark as Product' on opened string field Settings and Customization page
And 'should' see checked checkbox 'Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Metadata | Description              |
| String   | String Another Product   |
| Dropdown | Dropdown Another Product |

Scenario: Check marking as Product for String and Dropdown fields within Video Assets
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA3 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MPSFU3 | agency.admin | MPSFA3       |
And logged in with details of 'MPSFU3'
And I am on the global 'video asset' metadata page for agency 'MPSFA3'
And refreshed the page without delay
And clicked '<Metadata>' button in 'custom metadata' section on opened metadata page
And filled Description field with text '<Description>' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I open available metadata page 'Available Metadata'
And click '<Description>' button in 'editable metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Mark as Product,Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Metadata | Description      |
| String   | String Product   |
| Dropdown | Dropdown Product |

Scenario: Check unmarking as Product for String and Dropdown fields within Video Asets
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA3 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MPSFU3 | agency.admin | MPSFA3       |
And logged in with details of 'MPSFU3'
And I am on the global 'video asset' metadata page for agency 'MPSFA3'
And refreshed the page without delay
And clicked '<Metadata>' button in 'custom metadata' section on opened metadata page
And filled Description field with text '<Description>' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I open available metadata page 'Available Metadata'
And click '<Description>' button in 'editable metadata' section on opened metadata page
And uncheck 'Mark as Product' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click '<Description>' button in 'editable metadata' section on opened metadata page
Then I 'should not' see checked checkbox 'Mark as Product' on opened string field Settings and Customization page
And 'should' see checked checkbox 'Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Metadata | Description              |
| String   | String Another Product   |
| Dropdown | Dropdown Another Product |

Scenario: Check marking as Product for String and Dropdown fields by Global Admin
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA5 | DefaultA4User |
And I am logged in as 'GlobalAdmin'
And I am on the global 'common custom' metadata page for agency 'MPSFA5'
And clicked '<Metadata>' button in 'custom metadata' section on opened metadata page
And filled Description field with text '<Description>' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I open available metadata page 'Available Metadata'
And click '<Description>' button in 'common metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Mark as Product,Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Metadata | Description      |
| String   | String Product   |
| Dropdown | Dropdown Product |

Scenario: Check unmarking as Product for String and Dropdown fields by Global Admin
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA5 | DefaultA4User |
And I am logged in as 'GlobalAdmin'
And I am on the global 'common custom' metadata page for agency 'MPSFA5'
And clicked '<Metadata>' button in 'custom metadata' section on opened metadata page
And filled Description field with text '<Description>' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I open available metadata page 'Available Metadata'
And click '<Description>' button in 'common metadata' section on opened metadata page
And uncheck 'Mark as Product' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click '<Description>' button in 'common metadata' section on opened metadata page
Then I 'should not' see checked checkbox 'Mark as Product' on opened string field Settings and Customization page
And 'should' see checked checkbox 'Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Metadata | Description              |
| String   | String Another Product   |
| Dropdown | Dropdown Another Product |

Scenario: Check marking as Product for String and Dropdown fields within Video Assets by Global Admin
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA7 | DefaultA4User |
And I am logged in as 'GlobalAdmin'
And I am on the global 'video asset' metadata page for agency 'MPSFA7'
And refreshed the page without delay
And clicked '<Metadata>' button in 'custom metadata' section on opened metadata page
And filled Description field with text '<Description>' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I open available metadata page 'Available Metadata'
And click '<Description>' button in 'editable metadata' section on opened metadata page
Then I 'should' see checked checkbox 'Mark as Product,Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Metadata | Description      |
| String   | String Product   |
| Dropdown | Dropdown Product |

Scenario: Check unmarking as Product for String and Dropdown fields within Video Asets by Global Admin
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA7 | DefaultA4User |
And I am logged in as 'GlobalAdmin'
And I am on the global 'video asset' metadata page for agency 'MPSFA7'
And refreshed the page without delay
And clicked '<Metadata>' button in 'custom metadata' section on opened metadata page
And filled Description field with text '<Description>' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
When I open available metadata page 'Available Metadata'
And click '<Description>' button in 'editable metadata' section on opened metadata page
And uncheck 'Mark as Product' checkbox on opened string field Settings and Customization page
And save metadata field settings
And open available metadata page 'Available Metadata'
And click '<Description>' button in 'editable metadata' section on opened metadata page
Then I 'should not' see checked checkbox 'Mark as Product' on opened string field Settings and Customization page
And 'should' see checked checkbox 'Make this field available in Delivery' on opened string field Settings and Customization page

Examples:
| Metadata | Description              |
| String   | String Another Product   |
| Dropdown | Dropdown Another Product |

Scenario: Check String field that marked as Product in orders list
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| MPSFA9 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| MPSFU9 | agency.admin | MPSFA9       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MPSFA9':
| Advertiser | Brand   | Sub Brand | Product |
| MPSFAR9    | MPSFBR9 | MPSFSB9   | MPSFPR9 |
And logged in with details of 'MPSFU9'
And I am on the global 'common custom' metadata page for agency 'MPSFA9'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String Product' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | MPSFAR9    | MPSFBR9 | MPSFSB9   | MPSFPR9 | MPSFC9   | MPSFCN9      | 20       | 10/14/2022     | HD 1080i 25fps | MPSFT9 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MPSFCN9'
And fill following custom fields for Add information form on order item page:
| String Product |
| MPSFPR9 test   |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MPSFJN9    | MPSFPN9   |
And confirm order on Order Proceed page
And refresh the page without delay
Then I should see TV order in 'live' order list with item clock number 'MPSFCN9' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | MPSFAR9    | MPSFBR9 | MPSFSB9   | MPSFPR9 | United Kingdom | MPSFPN9   | MPSFJN9 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'MPSFCN9' and items with following fields:
| Clock Number | Advertiser | Product      | Title  | First Air Date | Format         | Duration | Status        |
| MPSFCN9      | MPSFAR9    | MPSFPR9 test | MPSFT9 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: Check Dropdown field that marked as Product in orders list
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MPSFA10 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MPSFU10 | agency.admin | MPSFA10       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MPSFA10':
| Advertiser | Brand    | Sub Brand | Product  |
| MPSFAR10   | MPSFBR10 | MPSFSB10  | MPSFPR10 |
And logged in with details of 'MPSFU10'
And I am on the global 'common custom' metadata page for agency 'MPSFA10'
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description      | AddOnFly | Descendants   | Mark As Product |
| Dropdown Product | should   | MPSFPR10 test | should          |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MPSFAR10   | MPSFBR10 | MPSFSB10  | MPSFPR10 | MPSFC10  | MPSFCN10     | 20       | 10/14/2022     | HD 1080i 25fps | MPSFT10 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MPSFCN10'
And fill following custom fields for Add information form on order item page:
| Dropdown Product |
| MPSFPR10 test    |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MPSFJN10   | MPSFPN10  |
And confirm order on Order Proceed page
And refresh the page without delay
Then I should see TV order in 'live' order list with item clock number 'MPSFCN10' and following fields:
| Order# | DateTime    | Advertiser | Brand    | Sub Brand | Product  | Market         | PO Number | Job #    | NoClocks | Status        |
| Digit  | CurrentTime | MPSFAR10   | MPSFBR10 | MPSFSB10  | MPSFPR10 | United Kingdom | MPSFPN10  | MPSFJN10 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'MPSFCN10' and items with following fields:
| Clock Number | Advertiser | Product       | Title   | First Air Date | Format         | Duration | Status        |
| MPSFCN10     | MPSFAR10   | MPSFPR10 test | MPSFT10 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: Check String field that marked as Product on View Media Details page
!--ORD-5506
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MPSFA11 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MPSFU11 | agency.admin | MPSFA11      |
And I logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MPSFA11':
| Advertiser | Brand    | Sub Brand | Product  |
| MPSFAR11   | MPSFBR11 | MPSFSB11  | MPSFPR11 |
And logged in with details of 'MPSFU11'
And I am on the global 'common custom' metadata page for agency 'MPSFA11'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String Product' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MPSFAR11   | MPSFBR11 | MPSFSB11  | MPSFPR11 | MPSFC11  | MPSFCN11     | 20       | 10/14/2022     | HD 1080i 25fps | MPSFT11 | Already Supplied   | BSkyB Green Button:Standard |
When I open order item with following clock number 'MPSFCN11'
And fill following custom fields for Add information form on order item page:
| String Product |
| MPSFPR11 test  |
And click active Proceed button on order item page
And 'confirm' reading BSkyB confirmation popup on order item page
And 'accept' BSkyB confirmation popup on order item page
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MPSFJN11   | MPSFPN11  |
And confirm order on Order Proceed page
And go to View Media Details page for order contains item with following clock number 'MPSFCN11'
Then I should see following media information on View Media Details page:
| Clock Number | Advertiser | Brand    | Sub Brand | Product  | Other Metadata Values | Title   | Duration | First Air Date | Additional Details  | Video Format                                | Aspect Ratio | Video Standard |
| MPSFCN11     | MPSFAR11   | MPSFBR11 | MPSFSB11  | MPSFPR11 | MPSFPR11 test         | MPSFT11 | 20       | 10/14/2022     | automated test info | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destination delivered for order contains item with clock number 'MPSFCN11' with following fields:
| Order # | Destination        | Date Ordered  | Ordered by | Status       |
| Digit   | BSkyB Green Button | DateSubmitted | MPSFU11    | Order Placed |

Scenario: Check Dropdown field that marked as Product on View Media Details page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| MPSFA12 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| MPSFU12 | agency.admin | MPSFA12      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MPSFA12':
| Advertiser | Brand    | Sub Brand | Product  |
| MPSFAR12   | MPSFBR12 | MPSFSB12  | MPSFPR12 |
And logged in with details of 'MPSFU12'
And I am on the global 'common custom' metadata page for agency 'MPSFA12'
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description      | AddOnFly | Descendants   | Mark As Product |
| Dropdown Product | should   | MPSFPR12 test | should          |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MPSFAR12   | MPSFBR12 | MPSFSB12  | MPSFPR12 | MPSFC12  | MPSFCN12     | 20       | 10/14/2022     | HD 1080i 25fps | MPSFT12 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MPSFCN12'
And fill following custom fields for Add information form on order item page:
| Dropdown Product |
| MPSFPR12 test    |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MPSFJN12   | MPSFPN12  |
And confirm order on Order Proceed page
And go to View Media Details page for order contains item with following clock number 'MPSFCN12'
Then I should see following media information on View Media Details page:
| Clock Number | Advertiser | Brand    | Sub Brand | Product  | Other Metadata Values | Title   | Duration | First Air Date | Additional Details  | Video Format                                | Aspect Ratio | Video Standard |
| MPSFCN12     | MPSFAR12   | MPSFBR12 | MPSFSB12  | MPSFPR12 | MPSFPR12 test         | MPSFT12 | 20       | 10/14/2022     | automated test info | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destination delivered for order contains item with clock number 'MPSFCN12' with following fields:
| Order # | Destination        | Date Ordered  | Ordered by | Status       |
| Digit   | Aastha | DateSubmitted | MPSFU12    | Order Placed |

Scenario: Check String field that marked as Product on QC asset details page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |Save In Library |Allow To Save In Library|
| MPSFA13 | DefaultA4User |should          |should                  |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| MPSFU13 | agency.admin | MPSFA13      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MPSFA13':
| Advertiser | Brand    | Sub Brand | Product  |
| MPSFAR13   | MPSFBR13 | MPSFSB13  | MPSFPR13 |
And logged in with details of 'MPSFU13'
And I am on the global 'common custom' metadata page for agency 'MPSFA13'
And clicked 'String' button in 'custom metadata' section on opened metadata page
And filled Description field with text 'String Product' on opened Settings and Customization tab
And checked 'Mark as Product' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MPSFAR13   | MPSFBR13 | MPSFSB13  | MPSFPR13 | MPSFC13  | MPSFCN13     | 20       | 10/14/2022     | HD 1080i 25fps | MPSFT13 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MPSFCN13'
And fill following custom fields for Add information form on order item page:
| String Product |
| MPSFPR13 test  |
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'MPSFCN13' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MPSFJN13   | MPSFPN13  |
And confirm order on Order Proceed page
And go to asset 'MPSFT13' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName      | FieldValue    |
| String Product | MPSFPR13 test |

Scenario: Check Dropdown field that marked as Product on QC asset details page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |Save In Library |Allow To Save In Library|
| MPSFA14 | DefaultA4User |should          |should                  |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| MPSFU14 | agency.admin | MPSFA14      |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MPSFA14':
| Advertiser | Brand    | Sub Brand | Product  |
| MPSFAR14   | MPSFBR14 | MPSFSB14  | MPSFPR14 |
And logged in with details of 'MPSFU14'
And I am on the global 'common custom' metadata page for agency 'MPSFA14'
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description      | AddOnFly | Descendants   | Mark As Product |
| Dropdown Product | should   | MPSFPR14 test | should          |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | MPSFAR14   | MPSFBR14 | MPSFSB14  | MPSFPR14 | MPSFC14  | MPSFCN14     | 20       | 10/14/2022     | HD 1080i 25fps | MPSFT14 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'MPSFCN14'
And fill following custom fields for Add information form on order item page:
| Dropdown Product |
| MPSFPR14 test    |
And click Proceed button on order item page
And 'check' checkbox Archive for following clock number 'MPSFCN14' of QC View summary on Order Proceed page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MPSFJN14   | MPSFPN14  |
And confirm order on Order Proceed page
And go to asset 'MPSFT14' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName        | FieldValue    |
| Dropdown Product | MPSFPR14 test |


