Feature:          Traffic API
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that Traffic API might be used

Lifecycle:
Before:
Given updated the following agency:
| Name     | Escalation Enabled | Approval Type |Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |broadcasterTrafficManagerTwo      |      broadcasterTrafficManagerTwo     |


Scenario: Check Integration with existing broadcaster workflows
Meta:     @traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TAPIAR1     | TAPIBR1     | TAPISB1     | TAPISP1    |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date| Motivnummer | Subtitles Required | Format         | Title     |             Destination                |
| automated test info    | TAPIAR1    | TAPIBR1    | TAPISB1    | TAPISP1   | TAPICP1   | TAPICN1      | 20       | 12/14/2022    |      1      | Already Supplied   | HD 1080i 25fps | TAPIT1    |  Motorvision TV:Express;TV Bayern Media:Standard   |
And complete order contains item with clock number 'TAPICN1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And wait for finish place order with following item clock number 'TAPICN1' to A4
And ingested assests through A5 with following fields:
 | agencyName | clockNumber |
 | DefaultAgency    | TAPICN1  |
And logged in with details of 'broadcasterTrafficManagerTwo'
And waited till order with clockNumber 'TAPICN1' will be available in Traffic
And waited till order item with clockNumber 'TAPICN1' will have broadcaster status 'Proxy Ready For Approval' in Traffic
And I amon order item details page of clockNumber 'TAPICN1'
And refreshed the page
And clicked on 'Approve Proxy' button on order item details page in traffic
And filled the following fields on approval traffic pop up:
|           Email                 |  Comment     |
|      test1_1@adstream.com       |  TestMessage |
And waited for '5' seconds
Then I should see order item 'TAPICN1' clock number with 'Motorvision TV' destination with following details:
| Title  | Product | Approvals Message |
| TAPIT1 | TAPISP1 | TestMessage       |
