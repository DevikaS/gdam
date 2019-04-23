!--ORD-3783
!--ORD-3853
Feature: DestinationID field for BU with type TV Broadcaster
Narrative:
In order to:
As a GlobalAdmin
I want to check a correct destinationID field for BU with type TV Broadcaster

Scenario: Check Market and DestinationID fields for BU with type TV Broadcaster
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| DIDFTVBA1 | DefaultA4User |
And filled following fields for agency 'DIDFTVBA1' on Edit agency popup:
| FieldName | FieldValue     |
| Type      | TV Broadcaster |
Then I 'should' see following fields 'Market,DestinationID' on Edit agency popup

Scenario: Check Market and DestinationID fields for BU with type TV Broadcaster Hub
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| DIDFTVBA2 | DefaultA4User |
And filled following fields for agency 'DIDFTVBA2' on Edit agency popup:
| FieldName | FieldValue         |
| Type      | TV Broadcaster Hub |
Then I 'should' see following fields 'Market' on Edit agency popup
And 'should not' see following fields 'DestinationID' on Edit agency popup

Scenario: Check Type values for BU
!--ORD-4039
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| DIDFTVBA3 | DefaultA4User |
And I am on agency 'DIDFTVBA3' overview page
Then I 'should' see following values 'Media Agency,Creative Agency,Production House,Post Production House,Billing Entity' for field 'Type' on Edit agency popup

Scenario: Check visibility of the BU Type in Partners list
!--ORD-4228
Meta: @ordering
Given I created the following agency:
| Name        | A4User        | AgencyType         | Market         |
| DIDFTVBA4_1 | DefaultA4User | TV Broadcaster Hub | United Kingdom |
| DIDFTVBA4_2 | DefaultA4User | TV Broadcaster Hub | United Kingdom |
And added agency 'DIDFTVBA4_2' as a partner to agency 'DIDFTVBA4_1'
And I am on agency 'DIDFTVBA4_1' partners page
Then I should see following type 'TV Broadcaster Hub' for agency 'DIDFTVBA4_2' on agency partners page