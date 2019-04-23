!--ORD-1046
!--ORD-1173
Feature: Format details on cover flow should depend on entered to order item data
Narrative:
In order to:
As a AgencyAdmin
I want to check format on cover flow only

Scenario: Set Formats in Add Info Section
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FDOCFU1 | agency.admin | FDOCFA1      |
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  | Format   |
| <ClockNumber> | <Format> |
When I open order item with following clock number '<ClockNumber>'
Then I should see for active order item on cover flow following data:
| Aspect Ratio  | Format          |
| <AspectRatio> | <formatQuality> |

Examples:
| ClockNumber | Format            | AspectRatio | formatQuality |
| FDOCFCN1_1  | HD 1080i 29.97fps | 16x9        | hd            |
| FDOCFCN1_2  | SD NTSC 4x3       | 4x3         | sd            |
| FDOCFCN1_3  | SD PAL 16x9       | 16x9        | sd            |

Scenario: Choose QC media from library with SD Formats
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FDOCFU1 | agency.admin | FDOCFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FDOCFA1':
| Advertiser | Brand    | Sub Brand | Product |
| FDOCFAR2   | FDOCFBR2 | FDOCFSB2  | FDOCFP2 |
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| FDOCFCN2_1   |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | FDOCFAR2   | FDOCFBR2 | FDOCFSB2  | FDOCFP2 | FDOCFC2  | FDOCFCN2_2   | 20       | 12/14/2022     | HD 1080i 25fps | FDOCFT2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'FDOCFCN2_2' with following fields:
| Job Number | PO Number |
| FDOCFJN2   | FDOCFPN2  |
And add to 'tv' order item with clock number 'FDOCFCN2_1' following qc asset 'FDOCFT2' of collection 'My Assets'
When I open order item with clock number 'FDOCFCN2_2' for order with market 'Republic of Ireland'
Then I should see for active order item on cover flow following data:
| Aspect Ratio | Format |
| 16x9         | sd     |
And should see following data for order item on Add information form:
| Format      |
| SD PAL 16x9 |

Scenario: Check SD format in Live Order with QC media
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FDOCFU1 | agency.admin | FDOCFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FDOCFA1':
| Advertiser | Brand    | Sub Brand | Product |
| FDOCFAR2   | FDOCFBR3 | FDOCFSB3  | FDOCFP3 |
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number | Destination                |
| FDOCFCN3_1   | Universal Ireland:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | FDOCFAR2   | FDOCFBR3 | FDOCFSB3  | FDOCFP3 | FDOCFC3  | FDOCFCN3_2   | 20       | 12/14/2022     | HD 1080i 25fps | FDOCFT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'FDOCFCN3_2' with following fields:
| Job Number | PO Number  |
| FDOCFJN3_1 | FDOCFPN3_1 |
And add to 'tv' order item with clock number 'FDOCFCN3_1' following qc asset 'FDOCFT3' of collection 'My Assets'
And complete order with market 'Republic of Ireland' with following fields:
| Job Number | PO Number  |
| FDOCFJN3_2 | FDOCFPN3_2 |
When I go to Order Summary page for order with following market 'Republic of Ireland'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Format      |
| FDOCFCN3_2   | SD PAL 16x9 |

Scenario: Choose not QC media from library with SD Formats
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |Access|
| FDOCFU1 | agency.admin | FDOCFA1      |streamlined_library,ordering|
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| FDOCFCN4     |
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'NEWLIB
And add to 'tv' order item with clock number 'FDOCFCN4' following asset 'Fish1-Ad.mov' of collection 'My Assets'
When I open order item with following clock number 'FDOCFCN4'
Then I should see for active order item on cover flow following data:
| Aspect Ratio |
| 4:3          |

Scenario: Check HD and SD Formats after save as draft order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FDOCFU1 | agency.admin | FDOCFA1      |
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
And fill following fields for Add information form on order item page:
| Format   |
| <Format> |
And save as draft order
And open order item with following clock number '<ClockNumber>'
Then I should see for active order item on cover flow following data:
| Aspect Ratio  | Format          |
| <AspectRatio> | <formatQuality> |
And should see following data for order item on Add information form:
| Format   |
| <Format> |

Examples:
| ClockNumber | Format            | AspectRatio | formatQuality |
| FDOCFCN5_1  | HD 1080i 29.97fps | 16x9        | hd            |
| FDOCFCN5_2  | SD NTSC 4x3       | 4x3         | sd            |
| FDOCFCN5_3  | SD PAL 16x9       | 16x9        | sd            |

Scenario: Check HD and SD formats for Live Order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FDOCFU1 | agency.admin | FDOCFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FDOCFA1':
| Advertiser | Brand    | Sub Brand | Product |
| FDOCFAR2   | FDOCFBR6 | FDOCFSB6  | FDOCFP6 |
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format   | Title   | Subtitles Required | Destination                 |
| automated test info    | FDOCFAR2   | FDOCFBR6 | FDOCFSB6  | FDOCFP6 | FDOCFC6  | <ClockNumber> | 20       | 12/14/2022     | <Format> | FDOCFT6 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| FDOCFJN6   | FDOCFPN6  |
When I go to Order Summary page for order contains item with following clock number '<ClockNumber>'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number  | Format   |
| <ClockNumber> | <Format> |

Examples:
| ClockNumber | Format            |
| FDOCFCN6_1  | HD 1080i 29.97fps |
| FDOCFCN6_2  | SD NTSC 4x3       |

Scenario: Check that Format field is mandatory when QC Ingest only is enabled
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FDOCFU1 | agency.admin | FDOCFA1      |
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| FDOCFCN7     |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'FDOCFCN7'
When I open order item with following clock number 'FDOCFCN7'
And I click active Proceed button on order item page
Then I 'should' see that following fields 'Format' are required for order item on Add information form

Scenario: Check HD format with QC Ingest only for Live Order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FDOCFU1 | agency.admin | FDOCFA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'FDOCFA1':
| Advertiser | Brand    | Sub Brand | Product |
| FDOCFAR2   | FDOCFBR8 | FDOCFSB8  | FDOCFP8 |
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format            | Title   | Subtitles Required |
| automated test info    | FDOCFAR2   | FDOCFBR8 | FDOCFSB8  | FDOCFP8 | FDOCFC8  | FDOCFCN8     | 20       | 12/14/2022     | HD 1080i 29.97fps | FDOCFT8 | Already Supplied   |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'FDOCFCN8'
And complete order contains item with clock number 'FDOCFCN8' with following fields:
| Job Number | PO Number |
| FDOCFJN8   | FDOCFPN8  |
When I go to Order Summary page for order contains item with following clock number 'FDOCFCN8'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Format            |
| FDOCFCN8     | HD 1080i 29.97fps |

Scenario: Check SD format with QC Ingest only for Draft Order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| FDOCFA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| FDOCFU1 | agency.admin | FDOCFA1      |
And logged in with details of 'FDOCFU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| FDOCFCN9     |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'FDOCFCN9'
When I open order item with following clock number 'FDOCFCN9'
And fill following fields for Add information form on order item page:
| Format      |
| SD PAL 16x9 |
And save as draft order
And open order item with following clock number 'FDOCFCN9'
Then I should see for active order item on cover flow following data:
| Aspect Ratio | Format |
| 16x9         | sd     |
And should see following data for order item on Add information form:
| Format      |
| SD PAL 16x9 |