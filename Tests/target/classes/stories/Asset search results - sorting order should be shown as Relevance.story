!--NGN-9980
Feature:          Asset search results - sorting order should be shown as Relevance
Narrative:
In order to
As a              AgencyAdmin
I want to         Asset search results - sorting order should be shown as Relevance


Scenario: Check that assets on asset search results page are sorted
Meta:@gdam
    @library
Given I created the agency 'SOSBSAR_A1' with default attributes
And created users with following fields:
| Email      | Role         | Agency     |Access|
| SOSBSAR_E2 | agency.admin | SOSBSAR_A1 |dashboard,streamlined_library|
And logged in with details of 'SOSBSAR_E2'
And uploaded following assetsNEWLIB:
| Name                 |
| /files/Fish10-Ad.mov |
| /files/Fish11-Ad.mov |
| /files/Fish12-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset 'Fish11-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName | FieldValue     |
| Title     | Fish100-Ad.mov |
And I 'save' asset 'Fish12-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName | FieldValue      |
| Title     | Fish1000-Ad.mov |
And go to Dashboard page
And search by text 'Ad'
Then I 'should' see the following files 'Fish10-Ad.mov,Fish100-Ad.mov,Fish1000-Ad.mov' on global search result
When I click show all link for global user search for object 'Assets'
And I wait for '5' seconds
And I switch to 'list' view on the library search results pageNEWLIB
And I wait for '2' seconds
Then I should see the following seccession 'Fish10-Ad.mov,Fish100-Ad.mov,Fish1000-Ad.mov' on the library search results pageNEWLIB
And I wait for '2' seconds
When I select Sort By 'Title (Z to A)' on the library search results pageNEWLIB
And I wait for '2' seconds
Then I should see the following seccession 'Fish1000-Ad.mov,Fish100-Ad.mov,Fish10-Ad.mov' on the library search results pageNEWLIB
