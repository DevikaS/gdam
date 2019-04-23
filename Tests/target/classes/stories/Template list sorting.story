!--NGN-1468
Feature:          Template list sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Check template list sorting


Scenario: Check sorting by MediaType/Template name
Meta:@gdam
@projects
Given the following templates were created:
| Name           | Media Type |
| 1715           | Broadcast  |
| 5thCorporation | Digital    |
| 911Advertising | Print      |
| Adstream       | Broadcast  |
| aAndA          | Digital    |
| Duglas         | Print      |
| dDrum&Bass     | Broadcast  |
| Zero Company   | Digital    |
| zZZZAd         | Print      |
And I am on Template list page
When I sorting templates by field '<FieldName>' in order '<Order>'
Then I should see templates sorted by field '<FieldName>' in order '<Order>'

Examples:
| FieldName                   | Order |
| _cm.common.name             | asc   |
| _cm.common.name             | desc  |
| _cm.common.projectMediaType | asc   |
| _cm.common.projectMediaType | desc  |


Scenario: Sorting by Created user
Meta:@gdam
@projects
Given the following templates were created:
| Name           |
| <TemplateName> |
And I am on Template list page
When I sorting templates by field '<FieldName>' in order '<Order>'
Then I should see templates sorted by field '<FieldName>' in order '<Order>'

Examples:
| TemplateName | FieldName           | Order |
| new data 1   | createdBy.fullName  | asc   |
| new data 2   | createdBy.fullName  | desc  |


Scenario: Default sorting for template list(by created By)
Meta:@gdam
@projects
When I go to template list page
Then I should see templates sorted by field 'createdBy.fullName' in order 'desc'