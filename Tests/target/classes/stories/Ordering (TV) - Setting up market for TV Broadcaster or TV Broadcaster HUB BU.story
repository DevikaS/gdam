!--ORD-3739
!--ORD-3783
!--ORD-3855
Feature: Setting up market for TV Broadcaster or TV Broadcaster HUB BU
Narrative:
In order to:
As a GlobalAdmin
I want to check setting up market for TV Broadcaster or TV Broadcaster HUB BU

Scenario: Check that Market becomes available after specifiying TV Broadcaster Hub type on BU details
Meta: @ordering
Given I created the following agency:
| Name        | A4User        | AgencyType | Ingest Location |
| SUMFTVBA1_1 | DefaultA4User | Ingest     |                 |
| SUMFTVBA1_2 | DefaultA4User | Advertiser | SUMFTVBA1_1     |
And logged in with details of 'GlobalAdmin'
And updated agency 'SUMFTVBA1_2' with following fields on agency overview page:
| FieldName       | FieldValue         |
| Type            | TV Broadcaster Hub |
| Market          | United Kingdom     |
| Ingest location | SUMFTVBA1_1        |
Then I 'should' see following fields on agency overview page:
| FieldName | FieldValue         |
| Type      | TV Broadcaster Hub |
| Market    | United Kingdom     |

Scenario: Check that Market and DestinationID become available after specifiying TV Broadcaster type on BU details
Meta: @ordering
Given I created the following agency:
| Name        | A4User        | AgencyType | Ingest Location |
| SUMFTVBA2_1 | DefaultA4User | Ingest     |                 |
| SUMFTVBA2_2 | DefaultA4User | Advertiser | SUMFTVBA2_1     |
And logged in with details of 'GlobalAdmin'
And updated agency 'SUMFTVBA2_2' with following fields on agency overview page:
| FieldName           | FieldValue     |
| Type                | TV Broadcaster |
| Market              | United Kingdom |
| DestinationIDUnique | 494            |
| Ingest location     |SUMFTVBA1 |
Then I 'should' see following fields on agency overview page:
| FieldName           | FieldValue     |
| Type                | TV Broadcaster |
| Market              | United Kingdom |
| DestinationID       | 494            |

Scenario: Check that Market becomes unavailable after removing TV Broadcaster Hub type on BU details even it has already specified data
Meta: @ordering
Given I created the following agency:
| Name        | A4User        | AgencyType | Ingest Location |
| SUMFTVBA3_1 | DefaultA4User | Ingest     |                 |
| SUMFTVBA3_2 | DefaultA4User | Advertiser | SUMFTVBA3_1     |
And logged in with details of 'GlobalAdmin'
And updated agency 'SUMFTVBA3_2' with following fields on agency overview page:
| FieldName       | FieldValue         |
| Type            | TV Broadcaster Hub |
| Market          | United Kingdom     |
| Ingest location | SUMFTVBA3_1        |
When I update agency 'SUMFTVBA3_2' with following fields on agency overview page:
| FieldName | FieldValue |
| Type      | Advertiser |
Then I 'should not' see following fields on agency overview page:
| FieldName | FieldValue         |
| Type      | TV Broadcaster Hub |
| Market    | United Kingdom     |

Scenario: Check that Market and DestinationID become unavailable after removing TV Broadcaster type on BU details even it has already specified data
Meta: @ordering
Given I created the following agency:
| Name        | A4User        | AgencyType | Ingest Location   |
| SUMFTVBA4_1 | DefaultA4User | Ingest     |                   |
| SUMFTVBA4_2 | DefaultA4User | Advertiser | SUMFTVBA4_1       |
And logged in with details of 'GlobalAdmin'
And updated agency 'SUMFTVBA4_2' with following fields on agency overview page:
| FieldName             | FieldValue     |
| Type                  | TV Broadcaster |
| Market                | United Kingdom |
| DestinationIDUnique   | 494            |
| Ingest location       |SUMFTVBA4_1     |
When I update agency 'SUMFTVBA4_2' with following fields on agency overview page:
| FieldName | FieldValue |
| Type      | Advertiser |
Then I 'should not' see following fields on agency overview page:
| FieldName           | FieldValue     |
| Type                | TV Broadcaster |
| Market              | United Kingdom |
| DestinationIDUnique | 494            |

Scenario: Check validation of DestinationID field on BU details
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| SUMFTVBA5 | DefaultA4User |
And logged in with details of 'GlobalAdmin'
When I fill following fields for agency 'SUMFTVBA5' on Edit agency popup:
| FieldName           | FieldValue     |
| Type                | TV Broadcaster |
| Market              | United Kingdom |
| DestinationIDUnique | test           |
Then I 'should' see validation error for following fields 'DestinationID' on Edit agency popup