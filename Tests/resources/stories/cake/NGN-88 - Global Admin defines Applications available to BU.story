!--NGN-88
Feature:          Global Admin defines Applications available to BU
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Ensure access levels are respected as set for the user's agency.

Meta:
@cake

Scenario: Check that global admin can see enable module/feature checkboxes and default values
Given I created the agency 'A_USHTOCP_S01' with default attributes
When I go to agency 'A_USHTOCP_S01' overview page
Then I 'should' see following fields on agency overview page:
| FieldName                                       | FieldValue |
| Enable Projects Module                          | true       |
| Enable Work Requests Feature                    | true       |
| Enable Library Module                           | true       |
| Enable Delivery Module                          | true       |
| Enable Traffic Module                           | true       |
