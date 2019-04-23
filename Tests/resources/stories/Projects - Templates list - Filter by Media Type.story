!--NGN-2469
Feature:          Projects - Templates list - Filter by Media Type
Narrative:
In order to
As a              AgencyAdmin
I want to         Check filtering list by Media Type

Scenario: Check that Broadcast, Cross Media, Digital, Print, Other options are available in Media Type combo box for Projects list
Meta:@gdam
@projects
Given I am on Project list page
When I click element 'MediaTypeComboBox' on page 'Projects'
Then I 'should' see following elements on page 'Projects':
| element     |
| Broadcast   |
| Cross Media |
| Digital     |
| Print       |
| Other       |


Scenario: Check that All is selected by default in Media Type combo box for Projects list
Meta:@gdam
@projects
Given I am on Project list page
Then I should see Media Type 'All' is selected on Projects list page


Scenario: Check that Broadcast, Cross Media, Digital, Print, Other options are available in Media Type combo box for Templates list
Meta:@gdam
@projects
Given I am on Template list page
When I click element 'MediaTypeComboBox' on page 'Templates'
Then I 'should' see following elements on page 'Templates':
| element     |
| Broadcast   |
| Cross Media |
| Digital     |
| Print       |
| Other       |


Scenario: Check that All option is selected by default in Media Type combo box for Templates list
Meta:@gdam
@projects
Given I am on Template list page
Then I should see Media Type 'All' is selected on Templates list page


Scenario: Check that filtering by Media Type works for Templates list
Meta: @bug
      @gdam
      @projects
!--FAB-455 Only cross media fails
Given the following templates were created:
| Name       | Media Type  |
| PTLFMTT6_1 | Broadcast   |
| PTLFMTT6_2 | Cross Media |
| PTLFMTT6_3 | Digital     |
| PTLFMTT6_4 | Print       |
| PTLFMTT6_5 | Other       |
And I am on Template list page
When I select filtering by media type '<MediaType>' for templates
Then I should see Media Type '<MediaType>' is selected on Templates list page
And I 'should' see only template '<TemplateName>' in template list
And I 'should not' see only template '<IncorrectTemplate>' in template list

Examples:
| MediaType   | TemplateName | IncorrectTemplate                           |
| Broadcast   | PTLFMTT6_1   | PTLFMTT6_2,PTLFMTT6_3,PTLFMTT6_4,PTLFMTT6_5 |
| Cross Media | PTLFMTT6_2   | PTLFMTT6_1,PTLFMTT6_3,PTLFMTT6_4,PTLFMTT6_5 |
| Digital     | PTLFMTT6_3   | PTLFMTT6_1,PTLFMTT6_2,PTLFMTT6_4,PTLFMTT6_5 |
| Print       | PTLFMTT6_4   | PTLFMTT6_1,PTLFMTT6_2,PTLFMTT6_3,PTLFMTT6_5 |
| Other       | PTLFMTT6_5   | PTLFMTT6_1,PTLFMTT6_2,PTLFMTT6_3,PTLFMTT6_4 |


Scenario: Check that filtering by Media Type works for Projects list
Meta: @bug
      @gdam
      @projects
!--FAB-455 --Only cross media fails
Given the following projects were created:
| Name       | Media Type  |
| PTLFMTT3_1 | Broadcast   |
| PTLFMTT3_2 | Cross Media |
| PTLFMTT3_3 | Digital     |
| PTLFMTT3_4 | Print       |
| PTLFMTT3_5 | Other       |
And I am on Project list page
And refreshed the page
When I select filtering by media type '<MediaType>'
Then I should see Media Type '<MediaType>' is selected on Projects list page
And I 'should' see only project '<ProjectName>' in project list
And I 'should not' see only project '<IncorrectProject>' in project list

Examples:
| MediaType  | ProjectName | IncorrectProject                            |
| Broadcast  | PTLFMTT3_1  | PTLFMTT3_2,PTLFMTT3_3,PTLFMTT3_4,PTLFMTT3_5 |
| Cross Media| PTLFMTT3_2  | PTLFMTT3_1,PTLFMTT3_3,PTLFMTT3_4,PTLFMTT3_5 |
| Digital    | PTLFMTT3_3  | PTLFMTT3_1,PTLFMTT3_2,PTLFMTT3_4,PTLFMTT3_5 |
| Print      | PTLFMTT3_4  | PTLFMTT3_1,PTLFMTT3_2,PTLFMTT3_3,PTLFMTT3_5 |
| Other      | PTLFMTT3_5  | PTLFMTT3_1,PTLFMTT3_2,PTLFMTT3_3,PTLFMTT3_4 |