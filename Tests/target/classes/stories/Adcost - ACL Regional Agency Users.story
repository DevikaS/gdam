Feature: Audio Content Type
Narrative:
In order to
As a GlobalAdmin
I want to check Regional Agency User access

Lifecycle:
Before:
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name        | A4User        | Country        | Labels                                                                      | Application Access    |
| AACLRAUBU_1 | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,costPG,CM_AgencyName_AACLRAUBU_JAPAN | adcost,folders,adkits |
| AACLRAUBU_2 | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,costPG,CM_AgencyName_AACLRAUBU_JAPAN | adcost,folders,adkits |
| AACLRAUBU_3 | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,costPG,CM_AgencyName_AACLRAUBU_IMEA  | adcost,folders,adkits |
And created users with following fields and waited until replication to Cost Module:
| Email                      | Role        | AgencyUnique   | Access                                    |
| AACLRAUAgencyAdmin1_AG1    | agency.user | AACLRAUBU_1    | dashboard,adkits,approvals,folders,adcost |
| AACLRAURegionalAgUser1_AG1 | agency.user | AACLRAUBU_1    | dashboard,adkits,approvals,folders,adcost |
| AACLRAUAgencyAdmin2_AG2    | agency.user | AACLRAUBU_2    | dashboard,adkits,approvals,folders,adcost |
| AACLRAURegionalAgUser2_AG2 | agency.user | AACLRAUBU_2    | dashboard,adkits,approvals,folders,adcost |
| AACLRAUAgencyAdmin3_AG3    | agency.user | AACLRAUBU_3    | dashboard,adkits,approvals,folders,adcost |
| AACLRAURegionalAgUser3_AG3 | agency.user | AACLRAUBU_3    | dashboard,adkits,approvals,folders,adcost |
| AACLRAURegionalAgUser4_AG3 | agency.user | AACLRAUBU_3    | dashboard,adkits,approvals,folders,adcost |
And added existing user 'AACLRAUAgencyAdmin1_AG1' to agency 'DefaultAgency' with role 'agency.user'
And added existing user 'AACLRAUAgencyAdmin2_AG2' to agency 'DefaultAgency' with role 'agency.user'
And added existing user 'AACLRAUAgencyAdmin3_AG3' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email                       | User Role            | Approval limit | Access Type | Condition   | LabelName  |
| AACLRAUAgencyAdmin1_AG1     | Agency Admin         |                | Client      | AACLRAUBU_1 |            |
| AACLRAURegionalAgUser1_AG1  | Regional Agency User |                | Region      | AACLRAUBU_1 | JAPAN      |
| AACLRAUAgencyAdmin2_AG2     | Agency Owner         |                | Client      | AACLRAUBU_2 |            |
| AACLRAURegionalAgUser2_AG2  | Regional Agency User |                | Region      | AACLRAUBU_2 | JAPAN      |
| AACLRAUAgencyAdmin3_AG3     | Agency Admin         |                | Client      | AACLRAUBU_3 |            |
| AACLRAURegionalAgUser3_AG3  | Regional Agency User |                | Region      | AACLRAUBU_3 | IMEA       |
| AACLRAURegionalAgUser4_AG3  | Regional Agency User |                | Region      | AACLRAUBU_4 | IMEA       |
And logged in with details of 'AACLRAUAgencyAdmin1_AG1'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name             | Custom Code | Advertiser | Sector        | Brand        |
| AACLRAUProject_1 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And logged in with details of 'AACLRAUAgencyAdmin2_AG2'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name             | Custom Code | Advertiser | Sector        | Brand        |
| AACLRAUProject_2 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And logged in with details of 'AACLRAUAgencyAdmin3_AG3'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name             | Custom Code | Advertiser | Sector         | Brand       |
| AACLRAUProject_3 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |


Scenario: Check that Regional Agency users will be able to view ALL costs for all BUs which have the same Global Agency Name and Region label.
Meta:@adcost
     @adcostACL
!--QA-733
Given logged in with details of 'AACLRAUAgencyAdmin1_AG1'
And waited for '15' seconds
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number  | Cost Title | Description  | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| AACLRAUProject_1| AACLRAUCT1 | AACLRAUD1    | Christine Meyer (Leo Burnett) | 20000                | Digital Development | AACLRAUATN1            | AAK            | DefaultCampaign | BFO          | USD - US Dollar         |
And logged in with details of 'AACLRAUAgencyAdmin2_AG2'
And I created a new 'buyout' cost with following CostDetails:
| Project Number  | New  | Approval stage for submission | Type | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| AACLRAUProject_2| true | OriginalEstimate              | Film | Contract              | AACLRAUCT2  | AACLRAUCD2 | Lily Ross (Publicis)| AACLRAUATN2            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And logged in with details of 'AACLRAUAgencyAdmin3_AG3'
And I created a new 'buyout' cost with following CostDetails:
| Project Number  | New  | Approval stage for submission | Type | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| AACLRAUProject_3| true | OriginalEstimate              | Actor| Usage                 | AACLRAUCT3  | AACLRAUCD3 | Lily Ross (Publicis)| AACLRAUATN3            | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
When I login with details of 'AACLRAURegionalAgUser1_AG1'
And I am on cost overview page
Then I 'should' see 'AACLRAUCT1,AACLRAUCT2' cost item on Adcost overview page
And I 'should not' see 'AACLRAUCT3' cost item on Adcost overview page
When I login with details of 'AACLRAURegionalAgUser2_AG2'
And I am on cost overview page
Then I 'should' see 'AACLRAUCT1,AACLRAUCT2' cost item on Adcost overview page
And I 'should not' see 'AACLRAUCT3' cost item on Adcost overview page
When I login with details of 'AACLRAURegionalAgUser3_AG3'
And I am on cost overview page
Then I 'should' see 'AACLRAUCT3' cost item on Adcost overview page
And I 'should not' see 'AACLRAUCT1,AACLRAUCT2' cost item on Adcost overview page
When I login with details of 'AACLRAURegionalAgUser4_AG3'
When I am on cost overview page
Then I 'should' see 'AACLRAUCT3' cost item on Adcost overview page
And I 'should not' see 'AACLRAUCT1,AACLRAUCT2' cost item on Adcost overview page