!--NGN-1743
Feature:          Presentation list - Sorting and filtering
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sorting and filterring on Presentation List

Meta:
@component presentation

Scenario: Check sorting of presentations
Meta:@gdam
@library
Given I created users with following fields:
| Email    | Role        |
| ATP_U_01 | agency.admin |
And logged in with details of 'ATP_U_01'
And I created following reels:
| Name           | Description |
| 1715           | description |
| 911Advertising | description |
| dDrum&Bass     | description |
| zZZZAd         | description |
And I am on the all presentations page
When I sorting presentations by field '<Field>' in order '<Order>'
Then I 'should' see presentations sorted by '<Field>' field in order '<Order>'

Examples:
| Field    | Order |
| Name     | asc   |
| Name     | desc  |
| Created  | asc   |
| Created  | desc  |
| Modified | asc   |
| Modified | desc  |
| duration | asc   |
| duration | desc  |


Scenario: Check default filtering of presentations
Meta:@gdam
@library
Given I created users with following fields:
| Email    | Role        |
| ATP_U_02 | agency.admin |
And logged in with details of 'ATP_U_02'
And I created following reels:
| Name           | Description |
| 1715           | description |
| 911Advertising | description |
| dDrum&Bass     | description |
| zZZZAd         | description |
And I am on the all presentations page
Then I 'should' see presentation list correctly filtered by default

Scenario: Check filtering of presentations
Meta:@gdam
@library
Given I created users with following fields:
| Email    | Role        |
| ATP_U_03 | agency.admin |
And logged in with details of 'ATP_U_03'
And I created following reels:
| Name           | Description |
| 1715           | description |
| 911Advertising | description |
| dDrum&Bass     | description |
| zZZZAd         | description |
And I am on the all presentations page
When I set 'From' date filter as '<FromDate>' on all presentation page
And set 'To' date filter as '<ToDate>' on all presentation page
Then I 'should' see correctly filtered by FromDate '<FromDate>' and ToDate '<ToDate>' presentation list

Examples:
| FromDate    | ToDate      |
| 01.11.2009  | CurrentDate |
| CurrentDate | CurrentDate |