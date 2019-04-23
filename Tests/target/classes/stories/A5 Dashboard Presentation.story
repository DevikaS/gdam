!--NGN-4924 NGN-5156
Feature:          A5 Dashboard Presentation
Narrative:
In order to
As a              AgencyAdmin
I want to         Check A5 Dashboard Presentation

Meta:
@component dashboard

Scenario: check that at Presentations display 'You have no presentations' if user haven't any presentations
Meta:@gdam
     @library
Given I created the agency 'A_A5DP_S01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_A5DP_S01 | agency.admin | A_A5DP_S01   |
And logged in with details of 'U_A5DP_S01'
When I go to Dashboard page
When I maximize 'Presentations' section on Dashboard page
Then I 'should' see text 'You have no presentations' for expanded section 'Presentations' on Dashboard page


Scenario: check that a new presentation created correct
Meta:@gdam
     @library
When I click link 'Create a new presentation' on Dashboard Page
And fill 'New Presentation' popup with name 'P_A5DP_S02' and description 'description' on Dashboard Page
Then I 'should' be on Presentations page


Scenario: Check correctness value of 'No. Asset' field
Meta:@gdam
     @library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I created following reels:
| Name              |
| P_A5DP_S03 |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I added asset 'Fish Ad.mov' into existing presentation 'P_A5DP_S03' from collection 'Everything'NEWLIB
Then I 'should' see assets count '1' for presentation 'P_A5DP_S03' on Dashboard page

Scenario: Check that 'Total Duration' value is calculated correctly
Meta:@gdam
     @library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
| /files/Fish-Ad.mov |
And I created following reels:
| Name              |
| P_A5DP_S04 |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name        |
| Fish Ad.mov |
| Fish-Ad.mov |
And I added asset 'Fish Ad.mov,Fish-Ad.mov' into existing presentation 'P_A5DP_S04' from collection 'Everything'NEWLIB
Then I 'should' see Duration '00:00:12' for presentation 'P_A5DP_S04' on Dashboard page


Scenario: check that click on Presentation Name open Presentation assets page
Meta:@gdam
     @library
Given I created following reels:
| Name       | Description |
| P_A5DP_S05 | description |
When I click presentation 'P_A5DP_S05' in 'Presentations' section on dashboard page
Then I 'should' be on Presentation Assets page


Scenario: check that at Presentations window 5 latest presentations are appear
Meta:@gdam
     @library
Given I created the agency 'A_A5DP_S06' with default attributes
And created users with following fields:
| Email      | Role        | AgencyUnique |
| U_A5DP_S06 | agency.user | A_A5DP_S06   |
And logged in with details of 'U_A5DP_S06'
And created following reels:
| Name         | Description |
| P_A5DP_S06_1 | description |
| P_A5DP_S06_2 | description |
| P_A5DP_S06_3 | description |
| P_A5DP_S06_4 | description |
| P_A5DP_S06_5 | description |
| P_A5DP_S06_6 | description |
| P_A5DP_S06_7 | description |
| P_A5DP_S06_8 | description |
| P_A5DP_S06_9 | description |
Then I should see following presentations in 'Presentations' section on Dashboard page:
| Name         | Condition  |
| P_A5DP_S06_1 | should not |
| P_A5DP_S06_2 | should not |
| P_A5DP_S06_3 | should not |
| P_A5DP_S06_4 | should not |
| P_A5DP_S06_5 | should     |
| P_A5DP_S06_6 | should     |
| P_A5DP_S06_7 | should     |
| P_A5DP_S06_8 | should     |
| P_A5DP_S06_9 | should     |


Scenario: Check that user see only his presentations
Meta:@gdam
     @library
Given I created users with following fields:
| Email      | Role        |
| U_A5DP_S07 | agency.user |
And created following reels:
| Name         | Description |
| P_A5DP_S07_1 | description |
And logged in with details of 'U_A5DP_S07'
And created following reels:
| Name         | Description |
| P_A5DP_S07_2 | description |
Then I should see following presentations in 'Presentations' section on Dashboard page:
| Name         | Condition  |
| P_A5DP_S07_1 | should not |
| P_A5DP_S07_2 | should     |