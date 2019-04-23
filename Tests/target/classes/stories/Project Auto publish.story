!--NGN-17914
Feature:          Check that user can set the publish date while creating a project and make sure it gets autp published based on the date and time given
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Set the publish date while creating a project

!--Publish Date has a value "Current" which adds 3 minutes to current time
Scenario: Check that user can set the publish date, Publish Time, Publish DateTimeZone and Publish Message while creating a project and receives an email for project publish notification
Meta:@gdam
@gdamemails
Given I created the agency 'PPDAA1' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PPD_01 | agency.admin | PPDAA1   |
| U_PPD_02 | agency.user | PPDAA1   |
And logged in with details of 'U_PPD_01'
And the following projects were created:
| Name | Media Type    | Start Date | End Date   |Published|Publish DateTimeZone|Publish Message|Publish Date|
| PPD_P1  | Digital    | [Today]   | [Tomorrow]  |false    |Europe/London       |Test message   |Current  |
Then I should see the following fields on project 'PPD_P1' overview page:
|Publish Date|Publish DateTimeZone|Publish Message |
|Current  |Europe/London       |Test message    |
Then I 'should not' see 'Publish' button on project 'PPD_P1' Overview page with interval
And I should see an email sent to user 'U_PPD_01' for project publish and notification with message as 'will be Published on' with interval

Scenario: Check that user can set the Publish Date, Publish Time, Publish DateTimeZone and Publish Message while publishing the project later and receives an email for project publish notification
Meta:@gdam
@projects
Given I created the agency 'PPDAA2' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PPD_03 | agency.admin | PPDAA2   |
| U_PPD_04 | agency.user | PPDAA2   |
And logged in with details of 'U_PPD_03'
And the following projects were created:
|Advertiser| Name | Media Type | Start Date | End Date   |Published|
|PAART1| PPD_P2  | Digital    | [Today]   | [Tomorrow] |false|
And I am on project 'PPD_P2' overview page
When I publish the project 'PPD_P2' later:
|Publish Date|Publish Time|Publish DateTimeZone|Publish Message|
|[Tomorrow]|6:00 PM|Europe/London|Test Message|
Then I should see the following fields on project 'PPD_P2' overview page:
|Publish Date|Publish DateTimeZone|Publish Message |Publish DateTimeZone|
|[Tomorrow]  |Europe/London       |Test Message    |6:00 PM             |

Scenario: Check that user can publish the project manually before the publish date given
Meta:@gdam
@projects
Given I created the agency 'PPDAA3' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PPD_05 | agency.admin | PPDAA3  |
| U_PPD_06 | agency.user | PPDAA3   |
And logged in with details of 'U_PPD_05'
And the following projects were created:
| Name | Media Type    | Start Date | End Date   |Published|Publish DateTimeZone|Publish Message|Publish Date|Publish Time  |
| PPD_P3  | Digital    | [Today]   | [Tomorrow]  |false    |Europe/London       |Test message   |[Tomorrow]  |T21:00:00.000Z|
And I published the project 'PPD_P3'
Then I 'should not' see 'Publish' button on project 'PPD_P3' Overview page
Then I 'should not' see the following fields on project 'PPD_P3' overview page:
|Publish Date|
|Publish DateTimeZone|
|Publish Message |

Scenario: Check that project can be published automatically based on the given date and time and make sure that project can be unpublished manually after auto publishing plus team should receive an email when it gets auto published
Meta:@gdam
@projects
Given I created the agency 'PPDAA4' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_PPD_07 | agency.admin | PPDAA4   |
| U_PAR_08 | agency.user | PPDAA4   |
And logged in with details of 'U_PPD_07'
And set following notification settings for users:
| UserEmail    | SettingName       | SettingState |
| U_PAR_08 | Project Published | on           |
And the following projects were created:
| Name | Media Type    | Start Date | End Date   |Published|Publish DateTimeZone|Publish Message|Publish Date|
| PPD_P4  | Digital    | [Today]   | [Tomorrow]  |false    |Europe/London       |Test message   | Current  |
And created 'PARR1' role in 'project' group for advertiser 'PPDAA4'
And I am on project 'PPD_P4' teams page
And I added users 'U_PAR_08' to project 'PPD_P4' team with role 'PARR1' expired '12.12.2021'
And I am on project 'PPD_P4' overview page
Then I 'should not' see 'Publish' button on project 'PPD_P4' Overview page with interval
And I should see an email sent to user 'U_PPD_07' for project publish and notification with message as 'Project Publication Notification for PPD_P4' with interval
And I should see an email sent to user 'U_PAR_08' for project publish and notification with message as 'shared project' with interval
When I unpublish the project 'PPD_P4'
Then I 'should' see 'Publish' button on project 'PPD_P4' Overview page

Scenario: Check project is not published when future publish date is removed after project is created
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role        |
| U_PAP_S05    | agency.user |
And logged in with details of 'U_PAP_S05'
And the following projects were created:
| Name    | Media Type    | Start Date | End Date      |Published|Publish DateTimeZone|Publish Message|Publish Date|Publish Time  |
| PPD_P5  | Digital       | [Today]    | [DeepFuture]  |false    |Europe/London       |Test message   |[DeepFuture]|T21:00:00.000Z|
When I edit the following fields for 'PPD_P5' project:
|Name  |Publish Date|Publish Time  |
|PPD_P5|[Tomorrow]  |T23:00:00.000Z|
And click on element 'SaveButton'
And I edit the following fields for 'PPD_P5' project:
| Name   |Publish Date|Publish Time  |
| PPD_P5 |            |              |
And click on element 'SaveButton'
Then I 'should' see 'Publish' button on project 'PPD_P5' Overview page with interval


