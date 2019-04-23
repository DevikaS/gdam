!--NGN-3764
Feature:          All notifications should be OFF by default for new user
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that all email notifications are OFF by default for new user

Scenario: Check that all email notifications are off by default for invited user
Meta: @gdam
      @gdamemails
Given I invited user 'U_CTALENAOBDFIU'
When I logout from account
And I open link from email when user 'U_CTALENAOBDFIU' received email with next subject 'You are invited to the Adstream Platform'
And accept new user with first name 'U_CTALENAOBDFIU_firstname_' and last name 'U_CTALENAOBDFIU_lastname_'
And I go to my Notifications Settings page
Then I should see that I have the following notifications:
| Name                              | Checked |
| Project owner added               | on      |
| Folder sharing for user           | on      |
| Presentation sharing for user     | on      |
| Asset sharing for user            | on      |
| Comment written                   | off     |
| File deleted                      | off     |
| File downloaded                   | off     |
| Files Moved To Library            | off     |
| File played                       | off     |
| File upload failed                | off     |
| File uploaded                     | off     |
| Folder change permission for user | off     |
| Folder unsharing for user         | off     |
| Guest user welcome                | on      |
| Preview transcode failed          | off     |
| Project owner removed             | off     |
| Project team added                | off     |
| Project team removed              | off     |
| Presentation downloaded           | off     |
| Presentation file downloaded      | off     |
| Presentation viewed               | off     |
| Revision uploaded                 | off     |
| Usage rights expire soon          | off     |


Scenario: Check that all email notifications are off by default for created user
Meta: @gdam
      @gdamemails
Given I created 'U_CTAENAOBDFCU' User
When I go to user 'U_CTAENAOBDFCU' Notifications Settings page
Then I should see that user 'U_CTAENAOBDFCU' has the following notifications:
| Name                              | Checked |
| Project owner added               | on      |
| Folder sharing for user           | on      |
| Presentation sharing for user     | on      |
| Asset sharing for user            | on      |
| Comment written                   | off     |
| File deleted                      | off     |
| File downloaded                   | off     |
| Files Moved To Library            | off     |
| File played                       | off     |
| File upload failed                | off     |
| File uploaded                     | off     |
| Folder change permission for user | off     |
| Folder unsharing for user         | off     |
| Guest user welcome                | on      |
| Preview transcode failed          | off     |
| Project owner removed             | off     |
| Project team added                | off     |
| Project team removed              | off     |
| Presentation downloaded           | off     |
| Presentation file downloaded      | off     |
| Presentation viewed               | off     |
| Revision uploaded                 | off     |
| Usage rights expire soon          | off     |


Scenario: Check that all email notifications are off by default for new user added in Team tab
Meta: @gdam
      @gdamemails
Given created 'P_CTAENAOBDFNUAITT' project
And I created 'F_CTAENAOBDFNUAITT' folder for project 'P_CTAENAOBDFNUAITT'
And I created 'U_CTAENAOBDFNUAITT' User
And I am on project 'P_CTAENAOBDFNUAITT' teams page
And added users 'U_CTAENAOBDFNUAITT' to project 'P_CTAENAOBDFNUAITT' team folders '/F_CTAENAOBDFNUAITT' with role 'project.user' expired '12.12.2021'
When I go to user 'U_CTAENAOBDFNUAITT' Notifications Settings page
Then I should see that user 'U_CTAENAOBDFNUAITT' has the following notifications:
| Name                              | Checked |
| Project owner added               | on      |
| Folder sharing for user           | on      |
| Presentation sharing for user     | on      |
| Asset sharing for user            | on      |
| Comment written                   | off     |
| File deleted                      | off     |
| File downloaded                   | off     |
| Files Moved To Library            | off     |
| File played                       | off     |
| File upload failed                | off     |
| File uploaded                     | off     |
| Folder change permission for user | off     |
| Folder unsharing for user         | off     |
| Guest user welcome                | on      |
| Preview transcode failed          | off     |
| Project owner removed             | off     |
| Project team added                | off     |
| Project team removed              | off     |
| Presentation downloaded           | off     |
| Presentation file downloaded      | off     |
| Presentation viewed               | off     |
| Revision uploaded                 | off     |
| Usage rights expire soon          | off     |

Scenario: Check that all email notifications settings by default for created user as Global Admin
Meta:@gdam
      @gdamemails
Given I logged in as 'GlobalAdmin'
And created users with following fields:
| Email          | Role         | Agency         |
| U_CTAENAOBDFCU | agency.admin | DefaultAgency  |
When I go to user 'U_CTAENAOBDFCU' Notifications Settings page of agency 'DefaultAgency'
Then I should see that the user 'U_CTAENAOBDFCU' of agency 'DefaultAgency' has the following notifications:
| Name                                           | Checked |
| Approval Has Been Canceled                     |  off    |
| Assets Shared With Users                       |  on     |
| Comment Submitted                              |  on     |
| Files Shared With Users                        |  on     |
| Folders Shared With Users                      |  on     |
| Order Delivered                                |  on     |
| Order Generics Upload Requested                |  on     |
| Order Ingested                                 |  on     |
| Order Media Ftp Upload Requested               |  on     |
| Order Media NVerge Upload Requested            |  on     |
| Order Media Physical Upload Requested          |  on     |
| Order Media Upload Requested                   |  on     |
| Order Placed                                   |  on     |
| Order Subtitles Required                       |  on     |
| Order Transferred                              |  on     |
| Presentation Shared With Users                 |  on     |
| Presentation Zip Download Bundle Created       |  on     |
| Project Publication Notify                     |  on     |
| Project Published                              |  on     |
| Project Shared                                 |  off    |
| Project Shared With Users                      |  on     |
| Radio Order Delivered                          |  on     |
| Radio Order Downloaded                         |  on     |
| Zip Download Bundle Created                    |  on     |
| Presentation Shared                            |  off    |

Scenario: No blank notification drop-down values should be displayed for user level notification settings
Meta:@gdamemails
     @gdam
Given I logged in as 'GlobalAdmin'
And I created users with following fields:
| Email          | Role         | Agency         |
| U_USNS_S01 | agency.admin | DefaultAgency  |
When I go to user 'U_USNS_S01' Notifications Settings page of agency 'DefaultAgency'
Then I 'should' be able to see a value selected on all user notification settings dropdown

Scenario: No blank notification drop-down values should be displayed for user level notification settings on the agency admin
Meta: @gdamemails
     @gdam
Given I created users with following fields:
| Email          | Role         | Agency         |
| U_USNS_S01 | agency.admin | DefaultAgency  |
And I logged in with details of 'U_USNS_S01'
When I go to user 'U_USNS_S01' Notifications Settings page
Then I 'should' be able to see a value selected on all user notification settings on My Notification settings page