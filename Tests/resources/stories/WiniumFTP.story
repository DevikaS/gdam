!--QA-442
Feature:          Agency Admin - WiniumFTP
Narrative:
In order to
As a              AgencyAdmin
I want to         execute all the windows related scenarios using Winium, FTP and AutoIt


Scenario: Check the MS Office Word docx is editable in Project folders
Meta: @uatgdamsmoke
      @qagdamsmoke
      @gdam
      @projects
Given I created 'P_WFTP_docx' project
And created '/F_WFTP_docx' folder for project 'P_WFTP_docx'
And uploaded into project 'P_WFTP_docx' following files:
| FileName          | Path          |
| /files/usage.docx | /F_WFTP_docx  |
And waited while preview is available in folder '/F_WFTP_docx' on project 'P_WFTP_docx' files page
And I am on file 'usage.docx' info page in folder '/F_WFTP_docx' project 'P_WFTP_docx'
When I click Edit Document button on file 'usage.docx' info page in folder '/F_WFTP_docx' project 'P_WFTP_docx'
And 'EDIT' the file using 'EditDocument.exe' at 'c:\\inetpub\\ftproot\\TEST'
And wait for '20' seconds
And refresh the page
And I click element 'VersionHistory' on page 'FilesPage'
Then I should see next version 'V2' on version history tab


Scenario: Check the MS Office Word doc is editable in Project folders
Meta: @uatgdamsmoke
      @qagdamsmoke
      @gdam
      @projects
Given I created 'P_WFTP_doc' project
And created '/F_WFTP_doc' folder for project 'P_WFTP_doc'
And uploaded into project 'P_WFTP_doc' following files:
| FileName            | Path             |
| /files/EditWord.doc | /F_WFTP_doc  |
And waited while preview is available in folder '/F_WFTP_doc' on project 'P_WFTP_doc' files page
And I am on file 'EditWord.doc' info page in folder '/F_WFTP_doc' project 'P_WFTP_doc'
When I click Edit Document button on file 'EditWord.doc' info page in folder '/F_WFTP_doc' project 'P_WFTP_doc'
And 'EDIT' the file using 'EditDocument.exe' at 'c:\\inetpub\\ftproot\\TEST'
And wait for '20' seconds
And refresh the page
And I click element 'VersionHistory' on page 'FilesPage'
Then I should see next version 'V2' on version history tab

Scenario: Check the MS Office xls is editable in Project folders
Meta: @uatgdamsmoke
      @qagdamsmoke
      @gdam
      @projects
Given I created 'P_WFTP_xls' project
And created '/F_WFTP_xls' folder for project 'P_WFTP_xls'
And uploaded into project 'P_WFTP_xls' following files:
| FileName            | Path             |
| /files/919.xls | /F_WFTP_xls  |
And waited while preview is available in folder '/F_WFTP_xls' on project 'P_WFTP_xls' files page
And I am on file '919.xls' info page in folder '/F_WFTP_xls' project 'P_WFTP_xls'
When I click Edit Document button on file '919.xls' info page in folder '/F_WFTP_xls' project 'P_WFTP_xls'
And 'EDIT' the file using 'EditEXCEL.exe' at 'c:\\inetpub\\ftproot\\TEST'
And wait for '20' seconds
And refresh the page
And I click element 'VersionHistory' on page 'FilesPage'
Then I should see next version 'V2' on version history tab


Scenario: Check the MS Office xlsx is editable in Project folders
Meta: @uatgdamsmoke
      @qagdamsmoke
      @gdam
      @projects
Given I created 'P_WFTP_xlsx' project
And created '/F_WFTP_xlsx' folder for project 'P_WFTP_xlsx'
And uploaded into project 'P_WFTP_xlsx' following files:
| FileName                | Path             |
| /files/TestEditDoc.xlsx | /F_WFTP_xlsx  |
And waited while preview is available in folder '/F_WFTP_xlsx' on project 'P_WFTP_xlsx' files page
And I am on file 'TestEditDoc.xlsx' info page in folder '/F_WFTP_xlsx' project 'P_WFTP_xlsx'
When I click Edit Document button on file 'TestEditDoc.xlsx' info page in folder '/F_WFTP_xlsx' project 'P_WFTP_xlsx'
And 'EDIT' the file using 'EditEXCEL.exe' at 'c:\\inetpub\\ftproot\\TEST'
And wait for '20' seconds
And refresh the page
And I click element 'VersionHistory' on page 'FilesPage'
Then I should see next version 'V2' on version history tab


Scenario: Check the MS Office ppt is editable in Project folders
Meta: @uatgdamsmoke
      @qagdamsmoke
      @gdam
      @projects
Given I created 'P_WFTP_ppt' project
And created '/F_WFTP_ppt' folder for project 'P_WFTP_ppt'
And uploaded into project 'P_WFTP_ppt' following files:
| FileName            | Path             |
| /files/EditPPT.ppt  | /F_WFTP_ppt  |
And waited while preview is available in folder '/F_WFTP_ppt' on project 'P_WFTP_ppt' files page
And I am on file 'EditPPT.ppt' info page in folder '/F_WFTP_ppt' project 'P_WFTP_ppt'
When I click Edit Document button on file 'EditPPT.ppt' info page in folder '/F_WFTP_ppt' project 'P_WFTP_ppt'
And 'EDIT' the file using 'EditPPT.exe' at 'c:\\inetpub\\ftproot\\TEST'
And wait for '20' seconds
And refresh the page
And I click element 'VersionHistory' on page 'FilesPage'
Then I should see next version 'V2' on version history tab


Scenario: Check that Export CSV will create an excel file and verify the data
!--QA-453
Meta:@ClientScenarioAMS
Given I logged in with details of 'AgencyAdmin'
And I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser   | Brand    | Sub Brand  | Product  |
| TMCOAR20     | TMCOBR20 | TMCOSB20   | TMCOP20  |
| TMCOAR21     | TMCOBR21 | TMCOSB21   | TMCOP21  |
And I create 'tv' order with market 'United Arab Emirates' and items with following fields:
| Additional Information | Advertiser   | Brand    | Sub Brand   | Product    | Campaign    | Clock Number     |Language| Duration | First Air Date | Subtitles Required | Format         | Title     | Destination               |
| automated test info    | TMCOAR20     | TMCOBR20 | TMCOSB20    | TMCOP20    | TTVBTVSC1   | <ClockNumber1>   |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST2 | MBC group (SD):Express;   |
| automated test info    | TMCOAR21     | TMCOBR21 | TMCOSB21    | TMCOP21    | TTVBTVSC2   | <ClockNumber2>   |Hindi   |20        | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST3 | MBC group (SD):Express;   |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TMCOJO55    | TMCOPO55 |
And I wait for finish place order with following item clock number '<ClockNumber1>' to A4
And I wait for finish place order with following item clock number '<ClockNumber2>' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber         |
| DefaultAgency | <ClockNumber1>      |
| DefaultAgency | <ClockNumber2>      |
When I login as 'ams.approval.user@adbank.me'
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber '<ClockNumber2>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And select 'Waiting for AMS Approval' tab in Traffic UI
And enter search criteria '<SearchCriteria>' in simple search form on Traffic Order List page
And click on 'DownloadCSV' link on Traffic Order List page
And 'open' the file using 'TrafficCSV.exe' at 'c:\\inetpub\\ftproot\\TEST'
Then 'should' see following data in 'export.csv' order item list in Traffic:
|Clock Number |Advertiser   | Title      | Broadcaster Approval Status   |  Market              | Destination name   |
|TBMSEAR_10    |   TMCOAR20  | TTVBTVST2  | Proxy Ready For Approval      | United Arab Emirates | MBC group (SD)     |
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic

Examples:
|ClockNumber1|ClockNumber2|OrderNotAvailable        |OrderAvailable    |SearchCriteria   |
|TBMSEAR_10   |TBMSEAR_11   |  TBMSEAR_11           |TBMSEAR_10         |   TMCOAR20      |

Scenario: Check that Broadcaster Traffic Manager can filter based upon the date
Meta: @uattrafficsmoke
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo      |      broadcasterTrafficManagerTwo     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber1>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1            |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber2>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1     |
And completed order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And completed order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS12   | TTVBTVS12 |
And created 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination           | Motivnummer  |
| automated test info    | TTVBTVSAR1 | TTVBTVSBR1 | TTVBTVSSB1 | TTVBTVSP1 | TTVBTVSC1 |<ClockNumber3>| 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Motorvision TV:Express | 1  |
And completed order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS13   | TTVBTVS13 |
And waited for finish place order with following item clock number '<ClockNumber1>' to A4
And waited for finish place order with following item clock number '<ClockNumber2>' to A4
And waited for finish place order with following item clock number '<ClockNumber3>' to A4
When ingested assests through A5 with following fields:
 | agencyName                | clockNumber        |
 | DefaultAgency      |   <ClockNumber1>    |
And login with details of 'broadcasterTrafficManagerTwo'
And wait till order with clockNumber '<ClockNumber1>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber2>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber3>' will be available in Traffic
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And wait till order item with clockNumber '<ClockNumber1>' with destination 'Motorvision TV' will have the next Destination Status 'Awaiting station release' in Traffic
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And refresh the page without delay
And wait till order item list will be loaded in Traffic
And filter by date:
|Filter By Date  | Start Date  | End Date |
|Arrival Date    | Today       | Today    |
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic
When open order item details page with clockNumber '<ClockNumber1>'
And click on 'Approve Proxy' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Master Ready For Approval' in Traffic
And refresh the page without delay
And click on 'Release Master' button on order item details page in traffic
And fill the following fields on approval traffic pop up for new user:
|           Email                 |  Comment  |
|      test1_1        |    Test   |
And wait till order item with clockNumber '<ClockNumber1>' will have broadcaster status 'Delivered' in Traffic
And I open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order item list will be loaded in Traffic
And filter by date:
|Filter By Date  | Start Date  | End Date |
|Delivery Date    | Today       | Today    |
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic
When I create tab with name 'Date_Tab' and type 'Order Item (Send)' and dataRange 'Today' and the following rules:
|  Condition       | Condition Type |  Value    |
|   Advertiser     |   Match        |  TTVBTVSAR1 |
And wait till order item list will be loaded in Traffic
Then 'should' see orderItems '<OrderAvailable>' in order item list in Traffic
And 'should not' see orderItems '<OrderNotAvailable>' in order item list in Traffic
When click on 'DownloadCSV' link on Traffic Order List page
And 'open' the file using 'TrafficFilterDate.exe' at 'c:\\inetpub\\ftproot\\TEST'
Then 'should' see following data in 'export.csv' order item list in Traffic:
|Clock Number  |Advertiser     | Title      |
|TBTMFDCN_7    |   TTVBTVSAR1  | TTVBTVST1  |

Examples:
|ClockNumber1 |ClockNumber2 |ClockNumber3 |   OrderNotAvailable        |      OrderAvailable        |
|TBTMFDCN_7|TBTMFDCN_8|TBTMFDCN_9|TBTMFDCN_9,TBTMFDCN_8 |  TBTMFDCN_7             |


Scenario: Stop the winium service
Meta: @uatgdamsmoke
      @qagdamsmoke
      @gdam
      @ClientScenarioAMS
      @skip
Then I 'stop' the winium service