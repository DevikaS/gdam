Feature:          Add missing information to asset activities
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that all activity information available for asset

Scenario: Сheck that when unshares asset corresponding actvity is shown in Paper Pusher
Meta: @skip
      @gdam
!--03/09 confimred with Maria that this can be skipped "never implemented and no one is asking for it"
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |
| U_LPTG_S07_2 | agency.user  | A_LPTG_S07 |
And logged in with details of 'U_LPTG_S07_1'
And uploaded file '/files/Fish Ad.mov' into my library
And waited while transcoding is finished in collection 'My Assets'
When add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following users:
| UserEmails   |
| U_LPTG_S07_2 |
And wait for '5' seconds
And remove secure share for asset 'Fish Ad.mov' of user 'U_LPTG_S07_2' from collection 'My Assets'
And go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName       | Message                          | Value       |
| U_LPTG_S07_1   | unshared asset from U_LPTG_S07_2 | Fish Ad.mov |


Scenario: Сheck that when user add asset to Work Request corresponding activity is shown in asset activity
Meta:@gdam
     @library
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |streamlined_library,library,folders,adkits|
And logged in with details of 'U_LPTG_S07_1'
And created 'WR_CWRFLA_S08' work request
And created '/Originals' folder for work request 'WR_CWRFLA_S08'
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'image10.jpg' of collection 'My Assets' to project 'WR_CWRFLA_S08' folder '/Originals'
And I go to asset 'image10.jpg' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'image10.jpg' activity page for collection 'My Assets'NEWLIB:
| UserName     | Message                     | Value                       |
| U_LPTG_S07_1 | Added to Work Request by |  |


Scenario: Сheck that when user add asset to Project corresponding activity is shown in asset activity
Meta:@gdam
     @library
Given I created the following agency:
| Name       |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07   | agency.admin | A_LPTG_S07 |streamlined_library,library,folders|
And logged in with details of 'U_LPTG_S07'
And created 'P_LPTG_S08' project
And created '/F1' folder for project 'P_LPTG_S08'
And uploaded asset '/files/New Text Document.txt' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'New Text Document.txt' of collection 'My Assets' to project 'P_LPTG_S08' folder '/F1'
And I go to asset 'New Text Document.txt' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'New Text Document.txt' activity page for collection 'My Assets'NEWLIB:
| UserName     | Message                     | Value                       |
| U_LPTG_S07 | Added to Project by |  |


Scenario: Сheck that when user add asset to Work Request corresponding activity is shown at work request overview page in recent activity
Meta:@gdam
     @projects
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |streamlined_library,library,folders,adkits|
And logged in with details of 'U_LPTG_S07_1'
And created 'WR_CWRFLA_S08' work request
And created '/Originals' folder for work request 'WR_CWRFLA_S08'
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'image10.jpg' of collection 'My Assets' to project 'WR_CWRFLA_S08' folder '/Originals'
And wait for '5' seconds
And I go to work request 'WR_CWRFLA_S08' overview page
Then I 'should' see following activities in 'Recent Activity' section on opened Work Request Overview page:
| UserName     | Message                         | Value                                |
| U_LPTG_S07_1 | created file from Library asset | /WR_CWRFLA_S08/Originals/image10.jpg |

Scenario: Сheck that when user add asset to Work Request corresponding activity is shown at file activity page
Meta:@gdam
     @projects
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |streamlined_library,library,folders,adkits|
And logged in with details of 'U_LPTG_S07_1'
And created 'WR_CWRFLA_S08' work request
And created '/Originals' folder for work request 'WR_CWRFLA_S08'
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'image10.jpg' of collection 'My Assets' to project 'WR_CWRFLA_S08' folder '/Originals'
And go to file 'image10.jpg' info page in folder 'Originals' work request 'WR_CWRFLA_S08'
And wait for '5' seconds
Then 'should' see on Activity tab for file 'image10.jpg' in folder '/Originals' work request 'WR_CWRFLA_S08' following recent user's activity :
| User         | Logo  | ActivityType      | ActivityMessage                     |
| U_LPTG_S07_1 | EMPTY | moved_to_project  | created file from Library asset     |


Scenario: Сheck that when user add asset to Project corresponding activity is shown on Project overview page
Meta:@gdam
     @projects
Given I created the following agency:
| Name       |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07   | agency.admin | A_LPTG_S07 |streamlined_library,library,folders|
And logged in with details of 'U_LPTG_S07'
And created 'P_LPTG_S08' project
And created '/F1' folder for project 'P_LPTG_S08'
And uploaded asset '/files/New Text Document.txt' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'New Text Document.txt' of collection 'My Assets' to project 'P_LPTG_S08' folder '/F1'
And wait for '5' seconds
And I go to project 'P_LPTG_S08' overview page
Then I 'should' see following activities in 'Recent Activity' section on opened Project Overview page:
| UserName     | Message                         | Value                                |
| U_LPTG_S07   | created file from Library asset | /P_LPTG_S08/F1/New Text Document.txt |


Scenario: Сheck that when user add asset to Project corresponding activity is shown on file activity page
Meta:@gdam
     @projects
Given I created the following agency:
| Name       |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07   | agency.admin | A_LPTG_S07 |streamlined_library,library,folders|
And logged in with details of 'U_LPTG_S07'
And created 'P_LPTG_S08' project
And created '/F1' folder for project 'P_LPTG_S08'
And uploaded asset '/files/New Text Document.txt' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add following asset 'New Text Document.txt' of collection 'My Assets' to project 'P_LPTG_S08' folder '/F1'
And go to file 'New Text Document.txt' info page in folder '/F1' project 'P_LPTG_S08'
And wait for '5' seconds
Then I 'should' see on Activity tab for file 'New Text Document.txt' in folder '/F1' project 'P_LPTG_S08' following recent user's activity :
| User       | Logo  | ActivityType      | ActivityMessage                     |
| U_LPTG_S07 | EMPTY | moved_to_project  | created file from Library asset     |
