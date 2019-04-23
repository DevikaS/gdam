Feature:          Traffic default tabs for users
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Default tab for destinations


Scenario: Check that specific default tabs are displayed for Aproval broadcaster
Meta: @qatrafficsmoke
@traffic
@uattrafficsmoke
Given I logged in as 'GlobalAdmin'
And waited for '5' seconds
And I opened role 'broadcast.traffic.manager' page with parent 'BroadCasterAgencyTwoStage'
And refreshed the page
And I clicked element 'CopyButton' on page 'Roles'
And waited for '20' seconds
And I changed role name to 'newRole'
And clicked element 'SaveButton' on page 'Roles'
And update role 'newRole' role by following 'traffic.tab.default.view.all,traffic.tab.default.view.master.approved,traffic.tab.default.view.master.rejected,traffic.tab.default.view.proxy.rejected,traffic.tab.default.view.proxy.approved,traffic.tab.default.view.awaiting.master.approval,traffic.tab.default.view.awaiting.proxy.approval,' permissions for advertiser 'BroadCasterAgencyTwoStage'
And created users with following fields:
| Email       |           Role            | Agency |  Access  | Password |
| TDTFDU1_2   | newRole                   |   BroadCasterAgencyTwoStage    |  adpath  | abcdefghA1 |
And updated the following agency:
| Name     | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
| BroadCasterAgencyTwoStage  |       true         |      two      |    TDTFDU1_2   |   TDTFDU1_2     |
When login as 'TDTFDU1_2' of Agency 'BroadCasterAgencyTwoStage'
And refresh the page
And wait till order item list will be loaded in Traffic
Then I 'should' see following tabs:
| Tab name                 |
| All                      |
| Awaiting Proxy Approval  |
| Proxy Approved           |
| Proxy Rejected           |
| Awaiting Master Approval |
| Master Approved          |
| Master Rejected          |

Scenario: Check that specific default tabs are displayed for not Aproval broadcaster
Meta: @traffic
Given I logged in with details of 'broadcasterTrafficManagerTwo'
When refresh the page
And wait till order item list will be loaded in Traffic
Then I 'should' see following tabs:
| Tab name                 |
| All                      |



Scenario: Check that specific default tabs are displayed for Traffic Manager
Meta: @traffic
Given I logged in with details of 'trafficManager'
And refreshed the page
And waited till order item list will be loaded in Traffic
Then I 'should' see following tabs:
| Tab name                 |
| My Orders                |

Scenario: Check that broadcast traffic manager can view default tabs based on the permissions enabled
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
Given I logged in as 'GlobalAdmin'
And created 'New_BTM' role with 'enum.read,file.download,project_team.read,role.read,traffic.csv.export,traffic.edit.housenumber,traffic.file.download,traffic.master.restore,traffic.order.view.all,traffic.proxy.restore,traffic.tab.configure,traffic.tab.create,traffic.tab.default.view.all,traffic.tab.global.create,traffic.tab.global.delete,traffic.tab.global.edit,user.read' permissions in 'global' group for advertiser 'BroadCasterAgencyTwoStage'
And created users with following fields:
| Email             |   Role      |  Agency   |  Access  | Password  |
| BTMCVTBOP12_2     |   New_BTM   |   BroadCasterAgencyTwoStage   |  adpath  | abcdefghA1 |
And updated the following agency:
| Name         | Escalation Enabled | Approval Type | Proxy Approver     | Master Approver    |
| BroadCasterAgencyTwoStage  |       true         |      two      |    BTMCVTBOP12_2   |   BTMCVTBOP12_2    |
And update role 'New_BTM' role by following '<NewPermissions>' permissions for advertiser 'BroadCasterAgencyTwoStage'
And waited for '2' seconds
When login as 'BTMCVTBOP12_2' of Agency 'BroadCasterAgencyTwoStage'
And refresh the page
Then I 'should' see following tabs:
| Tab name                 |
| <ShouldSeeTabNames>      |
Then I 'should not' see following tabs:
| Tab name                 |
| <ShouldNotSeeTabNames>   |

Examples:
|  NewPermissions   |   ShouldSeeTabNames      |   ShouldNotSeeTabNames      |
| traffic.tab.default.view.all,traffic.tab.default.view.awaiting.master.approval,traffic.tab.default.view.awaiting.proxy.approval,traffic.tab.default.view.master.approved,traffic.tab.default.view.master.rejected,traffic.tab.default.view.proxy.approved,traffic.tab.default.view.proxy.rejected | All,Awaiting Proxy Approval,Awaiting Master Approval,Master Approved,Proxy Approved,Master Rejected,Proxy Rejected | Null |
| traffic.tab.default.view.all | All | Awaiting Proxy Approval,Awaiting Master Approval,Master Approved,Proxy Approved,Master Rejected,Proxy Rejected |
| traffic.tab.default.view.awaiting.master.approval,traffic.tab.default.view.awaiting.proxy.approval | Awaiting Proxy Approval,Awaiting Master Approval | All,Master Approved,Proxy Approved,Master Rejected,Proxy Rejected |
| traffic.tab.default.view.master.approved,traffic.tab.default.view.proxy.approved | Master Approved,Proxy Approved | All,Awaiting Proxy Approval,Awaiting Master Approval,Master Rejected,Proxy Rejected |
| traffic.tab.default.view.master.rejected,traffic.tab.default.view.proxy.rejected | Master Rejected,Proxy Rejected | All,Awaiting Proxy Approval,Awaiting Master Approval,Awaiting Proxy Approval,Awaiting Master Approval |
