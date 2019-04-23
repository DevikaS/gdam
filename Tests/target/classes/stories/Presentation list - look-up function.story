!--NGN-1743
Feature:          Presentation list - look-up function
Narrative:
In order to
As a              AgencyAdmin
I want to         Check presentation list look-up

Meta:
@component presentation

Scenario: Check that look up for presentations is correctly woks
Meta:@gdam
@library
Given created '<Presentations>' reels with description 'description'
And I am on the all presentations page
When I type in element 'PresentationSearchField' on page 'Presentations' text '<SearchQuery>'
Then I 'should' see displayed presentations '<SearchResult>' on search popup

Examples:
| Presentations          | SearchQuery  | SearchResult  |
| Nike11,Nike12,Nike-Air | Nike1        | Nike11,Nike12 |
| Nike11,Nike12,Nike-Air | NotAvailable |               |


Scenario: Check that presentation from look-up can be selected
Meta:@gdam
@library
Given created '<Presentation>' reels with description 'description'
And I am on the all presentations page
When I type in element 'PresentationSearchField' on page 'Presentations' text '<SearchQuery>'
And I select '<Presentation>' from search popup
Then I 'should' see opened tab 'Assets' on '<Presentation>' presentation page

Examples:
| Presentation   | SearchQuery    |
| 5thCorpöration | 5thCorpöration |