!--NGN-41
Feature:          Upload logo to Project or Template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check upload and logo displaying

Scenario: Successfully creating a new Project with logo-1
Meta:@gdam
@projects
Given I am on Create New Project page
When I create '<ProjectName>' project with 'AllFilledFields' and '<Logo>' logo without delay
Then I should see message without delay warning 'Changes saved successfully'
And '<ProjectName>' project should include 'AllFilledFields' and '<Logo>' logo

Examples:
| ProjectName | Logo               |
| ULPT1       | GIF                |
| ULPT2       | JPG                |


Scenario: Successfully creating a new Project with logo-2
Meta:@gdam
@projects
Given I am on Create New Project page
When I create '<ProjectName>' project with 'AllFilledFields' and '<Logo>' logo without delay
Then I should see message without delay warning 'Changes saved successfully'
And '<ProjectName>' project should include 'AllFilledFields' and '<Logo>' logo

Examples:
| ProjectName | Logo               |
| ULPT3       | JPEG               |
| ULPT4       | PNG                |
| ULPA0       | EMPTY_PROJECT_LOGO |

Scenario: Successfully upload after upload project
Meta:@gdam
@projects
Given I am on Create New Project page
When I fill 'AllFilledFields' and 'PNG' logo for 'ULPT5' project
And I fill 'AllFilledFields' and 'GIF' logo for 'ULPT5' project
And click on element 'SaveButton'
Then I should see message warning 'Changes saved successfully'
And 'ULPT5' project should include 'AllFilledFields' and 'GIF' logo



Scenario: Successfully creating a new Project with uploaded logo (not supported format file)
Meta:@gdam
@projects
Given I am on Create New Project page
When I fill 'MandatoryFields' and 'BMP' logo for 'ULPT7' project
Then I should see  error message '\w*.bmp has invalid extension. Only jpg, jpeg, png are allowed.'


Scenario: Successfully upload after upload template
Meta:@gdam
@projects
Given I am on Create New Template page
When I fill 'MandatoryFields' and 'PNG' logo for 'ULPT12' template
And I fill 'MandatoryFields' and 'GIF' logo for 'ULPT12' template
And click Save button on template popup without delay
Then I should see message warning 'Changes saved successfully'
And 'ULPT12' template in template list

Scenario: Successfully creating a new Template with uploaded logo (not supported format file)
Meta:@gdam
@projects
Given I am on Create New Template page
When I fill 'MandatoryFields' and 'BMP' logo for 'ULPT13' template
Then I should see  error message '\w*.bmp has invalid extension. Only jpg, jpeg, png are allowed.'
