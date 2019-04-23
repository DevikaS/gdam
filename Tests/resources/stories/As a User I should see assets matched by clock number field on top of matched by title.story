Feature:          As a User I should see assets matched by clock number field on top of matched by title
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that assets matched by clock number

Scenario: Check that assets matched by clock number field on top of matched by title
Meta:@gdam
Given I created the agency 'A_SS_S1' with default attributes
And created users with following fields:
| Email   | AgencyUnique |
| U_SS_S1 | A_SS_S1   |
And logged in with details of 'U_SS_S1'
And I uploaded following assets:
| Name                           |
| /files/Fish1-Ad.mov            |
| /files/Fish2-Ad.mov            |
| /files/Fish3-Ad.mov            |
And waited while transcoding is finished in collection 'My Assets'
And on asset 'Fish1-Ad.mov ' info page in Library for collection 'My Assets'
And 'saved' asset info by following information on opened asset info page:
| FieldName                       | FieldValue                        |
| Clock number                    | UK/001/ABC                        |
| Title                           | British Scientists tell           |
| Description                     | Mushrooms grow better with Mozart |
And on  library page for collection 'My Assets'
And on asset 'Fish2-Ad.mov ' info page in Library for collection 'My Assets'
And 'saved' asset info by following information on opened asset info page:
| FieldName                       | FieldValue                          |
| Clock number                    | IT/002/ABC                          |
| Title                           | UK Ladies                           |
| Description                     | Spring season opening photo session |
And on  library page for collection 'My Assets'
And on asset 'Fish3-Ad.mov ' info page in Library for collection 'My Assets'
And 'saved' asset info by following information on opened asset info page:
| FieldName                       | FieldValue                                    |
| Clock number                    | IT/003/ABC                                    |
| Title                           | Behind the scene                              |
| Description                     | UK Ladies in this spring season photo session |
And on  library page for collection 'My Assets'
When I search by text 'UK' in library
Then I should see items 'British Scientists tell,UK Ladies,Behind the scene' of type 'Assets' with proper order in global search result
When I logout from account
And login with details of 'U_SS_S1'
And go to library page for collection 'My Assets'
And I 'check' match all words for strict search
And search by text 'UK Ladies' in library
Then I should see items 'UK Ladies,Behind the scene' of type 'Assets' with proper order in global search result
