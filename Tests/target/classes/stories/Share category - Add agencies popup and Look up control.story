!--NGN-4766 NGN-2298
Feature:          Share category - Add agencies popup and Look up controll
Narrative:
In order to
As a              AgencyAdmin
I want to         Check correct work of look up control on Add Agencies popup and Add Agencies popup

Scenario: Check that after clicking on 'Add Agency' button Add Agencies popup opens (S1)
Meta:@globaladmin
     @library
Given I created 'C_SCAAPLC_S01' category
When I click Add Agencies button for category 'C_SCAAPLC_S01'
Then I 'should' Add Agencies popup on the category page


Scenario: Check that look up correctly found agencies (S2)
Meta:@library
     @gdam
Given I created the agency 'A_SCAAPLC_S02' with default attributes
And created the agency 'A_öbČeø-sækà S02' with default attributes
And logged in with details of 'GlobalAdmin'
And added following partners 'A_öbČeø-sækà S02' to agency 'A_SCAAPLC_S02' on partners page
And created users with following fields:
| Email         | Role         | Agency        |
| U_SCAAPLC_S02 | agency.admin | A_SCAAPLC_S02 |
And logged in with details of 'U_SCAAPLC_S02'
And created 'C_SCAAPLC_S02' category
When I click Add Agencies button for category 'C_SCAAPLC_S02'
And start type agency name 'A_öbČeø-sækà' on Add Agencies popup
Then I 'should' see agencies in the dropdown list according to text 'A_öbČeø-sækà S02'


Scenario: Check that data displayed in look-up can be selected (S3)
Meta:@library
     @gdam
Given I created the agency 'A_SCAAPLC_S03' with default attributes
And created the agency 'A_öbČeø-sækà S03' with default attributes
And logged in with details of 'GlobalAdmin'
And added following partners 'A_öbČeø-sækà S03' to agency 'A_SCAAPLC_S03' on partners page
And created users with following fields:
| Email         | Role         | Agency        |
| U_SCAAPLC_S03 | agency.admin | A_SCAAPLC_S03 |
And logged in with details of 'U_SCAAPLC_S03'
And created 'C_SCAAPLC_S03' category
When I click Add Agencies button for category 'C_SCAAPLC_S03'
And specify agency name 'A_öbČeø-sækà S03' on Add Agencies popup
Then I should see selected agencies 'A_öbČeø-sækà S03' on the Add Agencies popup


Scenario: Check that selected agency can be removed in Add Agencies popup (S4)
Meta:@library
     @gdam
Given I created the agency 'A_SCAAPLC_S04' with default attributes
And created the agency 'A_SCAAPLC_S04_1' with default attributes
And created the agency 'A_SCAAPLC_S04_2' with default attributes
And logged in with details of 'GlobalAdmin'
And added following partners 'A_SCAAPLC_S04_1,A_SCAAPLC_S04_2' to agency 'A_SCAAPLC_S04' on partners page
And created users with following fields:
| Email         | Role         | Agency        |
| U_SCAAPLC_S04 | agency.admin | A_SCAAPLC_S04 |
And logged in with details of 'U_SCAAPLC_S04'
And created 'C_SCAAPLC_S04' category
When I click Add Agencies button for category 'C_SCAAPLC_S04'
And specify agency name 'A_SCAAPLC_S04_1' on Add Agencies popup
And specify agency name 'A_SCAAPLC_S04_2' on Add Agencies popup
And delete '1' agency from Add Agencies popup
And save Add Agencies on the Add Agencies popup
Then I 'should not' see agency 'A_SCAAPLC_S04_1' in the agencies list for current category
And 'should' see agency 'A_SCAAPLC_S04_2' in the agencies list for current category


Scenario: Check that the same agency cannot be selected in Add Agencies popup (S5)
Meta:@library
     @gdam
Given I created the agency 'A_SCAAPLC_S05_1' with default attributes
And created the agency 'A_SCAAPLC_S05_2' with default attributes
And logged in with details of 'GlobalAdmin'
And added following partners 'A_SCAAPLC_S05_2' to agency 'A_SCAAPLC_S05_1' on partners page
And created users with following fields:
| Email         | Role         | Agency          |
| U_SCAAPLC_S05 | agency.admin | A_SCAAPLC_S05_1 |
And logged in with details of 'U_SCAAPLC_S05'
And created 'C_SCAAPLC_S05' category
When I click Add Agencies button for category 'C_SCAAPLC_S05'
And specify agency name 'A_SCAAPLC_S05_2' on Add Agencies popup
And start type agency name 'A_SCAAPLC_S05_2' on Add Agencies popup
Then I 'should not' see agencies in the dropdown list according to text 'A_SCAAPLC_S05_2'