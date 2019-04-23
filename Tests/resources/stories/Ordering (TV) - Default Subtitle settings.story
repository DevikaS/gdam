!--ORD-3315
!--ORD-3654
Feature: Default Subtitle settings
Narrative:
In order to:
As a AgencyAdmin
I want to check default subtitle settings

Scenario: Check that default subtitle option depends on country of BU
Meta: @ordering
Given I created the following agency:
| Name     | A4User        | Country   |
| <Agency> | DefaultA4User | <Country> |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| <User> | agency.admin | <Agency>     |
And logged in with details of '<User>'
And I am on own Delivery Setting page
Then I 'should' see available following closed captions '<ClosedCaptions>' in Closed Captions Required field on user delivery setting page
And 'should not' see available following closed captions '<NotIncludeCaption>' in Closed Captions Required field on user delivery setting page

Examples:
| Agency  | Country        | User    | ClosedCaptions                                        | NotIncludeCaption  |
| DSSA1_1 | United Kingdom | DSSU1_1 | None,Adtext HD,Adtext SD,BTI Studios,Already Supplied | Yes                |
| DSSA1_2 | Ireland        | DSSU1_2 | None,Adtext HD,Adtext SD,BTI Studios,Already Supplied | Yes                |
| DSSA1_3 | Spain          | DSSU1_3 | None,Yes,Already Supplied                             | Adtext,BTI Studios |

Scenario: Check that default subtitle value is specified by default in case to create order
!--ORD-3655
Meta: @ordering
Given I created the following agency:
| Name  | A4User        | Country        |
| DSSA2 | DefaultA4User | United Kingdom |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DSSU2 | agency.admin | DSSA2        |
And logged in with details of 'DSSU2'
And I am on own Delivery Setting page
And filled following fields for Delivery Setting form on user delivery setting page:
| Closed Captions Required |
| BTI Studios              |
And saved own Delivery Setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DSSCN2       |
When I open order item with following clock number 'DSSCN2'
Then I should see following data for order item on Add information form:
| Subtitles Required |
| BTI Studios        |

Scenario: Check that default subtitle value is specified by default in case to change market
!--There is a Tiny issue here --If u change the Market to France and change it back to UK then subtitles field defaults to Adtext SD instead of Adstext HD 04/11-Maria said to ignore this
Meta: @ordering
Given I created the following agency:
| Name  | A4User        | Country        |
| DSSA2 | DefaultA4User | United Kingdom |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DSSU2 | agency.admin | DSSA2        |
And logged in with details of 'DSSU2'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Closed Captions Required |
| Adtext HD                |
And save own Delivery Setting
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DSSCN3       |
And open order item with following clock number 'DSSCN3'
And select following market 'United Kingdom' on order item page
Then I should see following data for order item on Add information form:
| Subtitles Required |
| Adtext HD          |

Scenario: Check that default Adtext BTI Studios is changed to Yes if market UK Ireland UK&ROI market isn't selected but market is selected which has Closed Captions
Meta: @ordering
Given I created the following agency:
| Name  | A4User        | Country        |
| DSSA2 | DefaultA4User | United Kingdom |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DSSU2 | agency.admin | DSSA2        |
And logged in with details of 'DSSU2'
And I am on own Delivery Setting page
And filled following fields for Delivery Setting form on user delivery setting page:
| Closed Captions Required |
| <ClosedCaptions>         |
And saved own Delivery Setting
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I should see following data for order item on Add information form:
| Subtitles Required |
| Yes                |

Examples:
| ClosedCaptions | ClockNumber |
| Adtext         | DSSCN4_1    |
| BTI Studios    | DSSCN4_2    |

Scenario: Check that default Yes is changed to Adtext if UK Ireland UK&ROI market is selected
Meta: @ordering
Given I created the following agency:
| Name  | A4User        | Country |
| DSSA5 | DefaultA4User | Spain   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| DSSU5 | agency.admin | DSSA5        |
And logged in with details of 'DSSU5'
And I am on own Delivery Setting page
And filled following fields for Delivery Setting form on user delivery setting page:
| Closed Captions Required |
| Yes                      |
And saved own Delivery Setting
And create 'tv' order with market '<Market>' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I should see following data for order item on Add information form:
| Subtitles Required |
| Adtext SD          |

Examples:
| Market              | ClockNumber |
| United Kingdom      | DSSCN5_1    |
| Republic of Ireland | DSSCN5_2    |

