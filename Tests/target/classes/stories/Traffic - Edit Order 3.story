Feature:    Traffic Edit Order
Narrative:
In order to
As a              AgencyAdmin
I want to check edit order feature

Scenario: Check order created from Project is editable by TTM
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
      @criticaltraffictests
!--QA-563
Given I created the following agency:
| Name      |    A4User     |    AgencyType  | Application Access |  Market  | DestinationID |    A4User     |
| TEOA2    | DefaultA4User |   Advertiser   |      folders,ordering      |          |               | DefaultA4User |
And created users with following fields:
| Email |             Role          | AgencyUnique |  Access  |
| TEOU2 |       agency.admin        |   TEOA2     | folders,ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TEOA2':
| Advertiser | Brand      | Sub Brand  | Product   |
| TEOAR1     | TEOBR1 | TEOSB1 | TEOP1 |
And logged in with details of 'TEOU2'
And on the global 'common editable' metadata page for agency 'TEOA2'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And created 'TEOFP1' project
And created '/TEOFF1' folder for project 'TEOFP1'
And uploaded into project 'TEOFP1' following files:
| FileName                   | Path       |
| /files/Fish1-Ad.mov        | /TEOFF1 |
And waited while transcoding is finished in folder '/TEOFF1' on project 'TEOFP1' files page
When click Send to Delivery for following files 'Fish1-Ad.mov' on project 'TEOFP1' folder '/TEOFF1' page
And wait for '2' seconds
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand  | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date| Subtitles Required  | Format     |
| automated test info    | TEOAR1     | TEOBR1 | TEOSB1     | TEOP1     | TEOC1     | TEOCN      | 20       | 12/14/2022    | Already Supplied    |HD 1080i 25fps |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| AOL |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number| PO Number   |
| TEOJN     | TEOPO    |
And confirm order on Order Proceed page
And login with details of 'trafficManager'
And wait till order with clockNumber 'TEOCN' will be available in Traffic
And wait till order with clockNumber 'TEOCN' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOCN' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TEOCN' in Traffic
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Title              | ChangedName       |
| Advertiser         | TEOAR2        |
| Brand              | TEOBR2        |
| Sub Brand          | TEOSB2        |
| Product            | TEOP2         |
| Subtitles Required | None              |
| Duration           | 22s               |
| First Air Date     |  12/16/2021       |
And fill following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |
And save usage information for 'Countries' usage right on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard     |
|Talk Sport    |
And fill following fields for Additional Services section on order item page:
| Type       |
| FTP Upload |
And fill following fields for 'Add' FTP Delivery Destination form of Additional Services section on order item page:
| FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path   |
| TEODN2          | TEOHN2   | TEOUN2   | TEOP2   | TEOP2 |
And add delivery destination for Additional Services section on order item page during 'Add' destination
And fill following fields for Additional Services section on order item page:
| Type       | Destination  | Format            | Specification  | No copies | Notes & Labels       | Standard |
| FTP Upload | TEODN2       | MPEG-2 DVD Quality| HD 1080i 25fps | 2         | automated test notes | should   |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOCN' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destinations 'AOL,Talk Sport' for order item in Traffic List with clockNumber 'TEOCN'
And I should see order item with clockNumber 'TEOCN' in traffic order list that have following data:
| Advertiser | Product  |  Title       | Duration | First Air Date | Subtitles Required   |
| TEOAR2     | TEOP2    |  ChangedName | 22s      | 12/16/2021     | None                 |
And refresh the page
And enter search criteria 'TEOCN' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And I 'should' see additional service 'TEODN2' for order item in Traffic List with clockNumber 'TEOCN'
And open edit page for order with Clock Number 'TEOCN' in Traffic
And should see following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |


Scenario: Check order created from Library is editable by TTM
Meta:@traffic
     @uattrafficsmoke
!--QA-563
Given I created the following agency:
| Name      |    A4User     |    AgencyType  | Application Access |  Market  | DestinationID |    A4User     |
| TEOA3    | DefaultA4User |   Advertiser   |      streamlined_library,ordering      |          |               | DefaultA4User |
And created users with following fields:
| Email |             Role          | AgencyUnique |  Access  |
| TEOU3 |       agency.admin        |   TEOA3     | streamlined_library,ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TEOA3':
| Advertiser | Brand  | Sub Brand  | Product   |
| TEOAR1     | TEOBR1 | TEOSB1 | TEOP1 |
And logged in with details of 'TEOU3'
And on the global 'common editable' metadata page for agency 'TEOA3'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
And I selected asset 'Fish Ad.mov' in the 'My Assets'  library pageNEWLIB
When I click Send To Delivery from library 'My Assets' collectionNEWLIB
And wait for '5' seconds
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand  | Sub Brand  | Product   | Campaign  | Clock Number  | Duration | First Air Date|  Subtitles Required  | Format       |
| automated test info    | TEOAR1     | TEOBR1 | TEOSB1     | TEOP1     | TEOC1 |    TEOCN_1      | 20       | 12/14/2022      | Already Supplied    |HD 1080i 25fps |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| AOL |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number| PO Number   |
| TEOJN     | TEOPO    |
And confirm order on Order Proceed page
And login with details of 'trafficManager'
And wait till order with clockNumber 'TEOCN_1' will be available in Traffic
And wait till order with clockNumber 'TEOCN_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOCN_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TEOCN_1' in Traffic
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Title              | ChangedName       |
| Advertiser         | TEOAR2        |
| Brand              | TEOBR2        |
| Sub Brand          | TEOSB2        |
| Product            | TEOP2         |
| Subtitles Required | None              |
| Duration           | 22s               |
| First Air Date     |  12/16/2021       |
And fill following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |
And save usage information for 'Countries' usage right on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard     |
|Talk Sport    |
And fill following fields for Additional Services section on order item page:
| Type       |
| FTP Upload |
And fill following fields for 'Add' FTP Delivery Destination form of Additional Services section on order item page:
| FTP Destination Name | FTP Host Name | FTP User Name | FTP Password | FTP Path   |
| TEODN3          | TEOHN2   | TEOUN2   | TEOP2   | TEOP2 |
And add delivery destination for Additional Services section on order item page during 'Add' destination
And fill following fields for Additional Services section on order item page:
| Type       | Destination  | Format            | Specification  | No copies | Notes & Labels       | Standard |
| FTP Upload | TEODN3       | MPEG-2 DVD Quality| HD 1080i 25fps | 2         | automated test notes | should   |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOCN_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TEOCN_1' in traffic order list that have following data:
| Advertiser |Product|  Title       | Duration | First Air Date | Subtitles Required   |
| TEOAR2     |  TEOP2|ChangedName   | 22s      | 12/16/2021     | None                 |
And I 'should' see destinations 'AOL,Talk Sport' for order item in Traffic List with clockNumber 'TEOCN_1'
And refresh the page
And enter search criteria 'TEOCN_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And I 'should' see additional service 'TEODN3' for order item in Traffic List with clockNumber 'TEOCN_1'
And open edit page for order with Clock Number 'TEOCN' in Traffic
And should see following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |


Scenario: Check that TTM editing only clocknumber in order created from Library cannot be processed
Meta:@traffic
!--QA-563
Given I created the following agency:
| Name      |    A4User     |    AgencyType  | Application Access |  Market  | DestinationID |    A4User     |cl
| TEOA4    | DefaultA4User |   Advertiser   |      streamlined_library,ordering      |          |               | DefaultA4User |
And created users with following fields:
| Email |             Role          | AgencyUnique |  Access  |
| TEOU4 |       agency.admin        |   TEOA4     | streamlined_library,ordering |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TEOA4':
| Advertiser | Brand  | Sub Brand  | Product   |
| TEOAR1     | TEOBR1| TEOSB1| TEOP1 |
And logged in with details of 'TEOU4'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
And I selected asset 'Fish Ad.mov' in the 'My Assets'  library pageNEWLIB
When I click Send To Delivery from library 'My Assets' collectionNEWLIB
And wait for '5' seconds
And select following market 'United Kingdom' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number           | Duration | First Air Date | Format         | Subtitles Required |
| automated test info    | TEOAR1     | TEOBR1    | TEOSB1    | TEOP1     | TEOC1     | TEOCN_2                | 10       | 10/14/2024     | HD 1080i 25fps | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard           |
| AOL |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| AACAJN4    | AACAPN4   |
And confirm order on Order Proceed page
And login with details of 'trafficManager'
And wait till order with clockNumber 'TEOCN_2' will be available in Traffic
And wait till order with clockNumber 'TEOCN_2' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOCN_2' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TEOCN_2' in Traffic
And edit order in traffic with the following fields:
| FieldName          | FieldValue        |
| Clock number            | Clk123            |
| Duration           | 22                |
When click proceed button on Traffic Order Edit page
And wait for '1' seconds
Then I 'should' see warning message 'We are unable to process your request at this time. Please try again later and if the problem persists contact our team via the Help Centre' on page
When open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOCN_2' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I should see order item with clockNumber 'TEOCN_2' in traffic order list that have following data:
| Clock Number |
| TEOCN_2      |