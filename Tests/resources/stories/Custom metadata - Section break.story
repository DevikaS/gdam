!--NGN-7062
Feature:          Custom metadata - Section break
Narrative:
In order to:
As a              GlobalAdmin
I want to         Check Section break

Scenario: Check generating Section break in Common schema
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMSB_S01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSB_S01 | agency.admin | A_CMSB_S01   |
And logged in with details of 'U_CMSB_S01'
When I go to the 'common custom' metadata page
And create 'Section Break' custom metadata field with following information on opened metadata page:
| Description |
| SB CMSB S01 |
Then I 'should' see section break 'SB CMSB S01' in Active Metadata Preview block on opened metadata page
When I go to the 'project' metadata page
Then I 'should' see section break 'SB CMSB S01' in Active Metadata Preview block on opened metadata page
When I go to the 'audio asset' metadata page
Then I 'should' see section break 'SB CMSB S01' in Active Metadata Preview block on opened metadata page
When I go to the 'digital asset' metadata page
Then I 'should' see section break 'SB CMSB S01' in Active Metadata Preview block on opened metadata page
When I go to the 'document asset' metadata page
Then I 'should' see section break 'SB CMSB S01' in Active Metadata Preview block on opened metadata page
When I go to the 'image asset' metadata page
Then I 'should' see section break 'SB CMSB S01' in Active Metadata Preview block on opened metadata page
When I go to the 'print asset' metadata page
Then I 'should' see section break 'SB CMSB S01' in Active Metadata Preview block on opened metadata page
When I go to the 'video asset' metadata page
Then I 'should' see section break 'SB CMSB S01' in Active Metadata Preview block on opened metadata page


Scenario: Check generating Section break in Progect schema
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMSB_S02' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSB_S02 | agency.admin | A_CMSB_S02   |
And logged in with details of 'U_CMSB_S02'
When I go to the 'project' metadata page
And create 'Section Break' custom metadata field with following information on opened metadata page:
| Description |
| SB CMSB S02 |
Then I 'should' see section break 'SB CMSB S02' in Active Metadata Preview block on opened metadata page


Scenario: Check generating Section break in Print asset schema
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMSB_S03' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSB_S03 | agency.admin | A_CMSB_S03   |
And logged in with details of 'U_CMSB_S03'
When I go to the 'print asset' metadata page
And create 'Section Break' custom metadata field with following information on opened metadata page:
| Description |
| SB CMSB S03 |
Then I 'should' see section break 'SB CMSB S03' in Active Metadata Preview block on opened metadata page


Scenario: Check generating Section break in Video asset schema
Meta:@globaladmin
     @gdam
Given I created the agency 'A_CMSB_S04' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSB_S04 | agency.admin | A_CMSB_S04   |
And logged in with details of 'U_CMSB_S04'
When I go to the 'video asset' metadata page
And create 'Section Break' custom metadata field with following information on opened metadata page:
| Description |
| SB CMSB S04 |
Then I 'should' see section break 'SB CMSB S04' in Active Metadata Preview block on opened metadata page


Scenario: Check drag and drop function and proper order of fields for Sommon schema
Meta:@globaladmin
     @skip
     @gdam
Given I created the agency 'A_CMSB_S05' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSB_S05 | agency.admin | A_CMSB_S05   |
And logged in with details of 'U_CMSB_S05'
And on the 'common custom' metadata page
When I move fields into group 'Product Info' in following order in Active Metadata Preview block on opened metadata page:
| FieldName  |
| Campaign   |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
Then I 'should' see metadata fields and groups in following order in Active Metadata Preview block on opened metadata page:
| FieldName    |
| Product Info |
| Campaign     |
| Advertiser   |
| Brand        |
| Sub Brand    |
| Product      |


Scenario: Check drag and drop function and proper order of fields for Project schema
Meta:@globaladmin
     @skip
     @gdam
Given I created the agency 'A_CMSB_S06' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSB_S06 | agency.admin | A_CMSB_S06   |
And logged in with details of 'U_CMSB_S06'
And on the 'project' metadata page
When I move fields into group 'Product Info' in following order in Active Metadata Preview block on opened metadata page:
| FieldName  |
| Campaign   |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
Then I 'should' see metadata fields and groups in following order in Active Metadata Preview block on opened metadata page:
| FieldName    |
| Product Info |
| Campaign     |
| Advertiser   |
| Brand        |
| Sub Brand    |
| Product      |


Scenario: Check drag and drop function and proper order of fields for Print asset schema
Meta:@globaladmin
     @skip
     @gdam
Given I created the agency 'A_CMSB_S07' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSB_S07 | agency.admin | A_CMSB_S07   |
And logged in with details of 'U_CMSB_S07'
And on the 'print asset' metadata page
When I move fields into group 'Product Info' in following order in Active Metadata Preview block on opened metadata page:
| FieldName  |
| Campaign   |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
| Title      |
Then I 'should' see metadata fields and groups in following order in Active Metadata Preview block on opened metadata page:
| FieldName    |
| Product Info |
| Campaign     |
| Advertiser   |
| Brand        |
| Sub Brand    |
| Product      |
| Title        |


Scenario: Check drag and drop function and proper order of fields for Video asset schema
Meta:@globaladmin
     @skip
     @gdam
Given I created the agency 'A_CMSB_S08' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CMSB_S08 | agency.admin | A_CMSB_S08   |
And logged in with details of 'U_CMSB_S08'
And on the 'video asset' metadata page
When I move fields into group 'Product Info' in following order in Active Metadata Preview block on opened metadata page:
| FieldName  |
| Campaign   |
| Advertiser |
| Brand      |
| Sub Brand  |
| Product    |
| Title      |
Then I 'should' see metadata fields and groups in following order in Active Metadata Preview block on opened metadata page:
| FieldName    |
| Product Info |
| Campaign     |
| Advertiser   |
| Brand        |
| Sub Brand    |
| Product      |
| Title        |