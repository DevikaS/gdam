Feature:        Global Mail Templates
Narrative:
In order to
As a            GlobalAdmin
I want to       check Global mail templates


Scenario: No blank notification drop-down values should be displayed for Business Unit level notification settings
Meta:@globaladmin
    @gdam
Given I created the agency 'GMT_BU_S01' with default attributes
And I am on the Mail templates notification settings page
When I search and select advertiser 'GMT_BU_S01' on mail templates notification settings page
Then I 'should' be able to see all notification settings dropdown with a value selected
