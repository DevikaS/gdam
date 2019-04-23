!--NGN-636 NGN-1636 NGN-1156
Feature:          CreateTemplate
Narrative:
In order to
As a              AgencyAdmin
I want to         Check create of a new Template

Scenario: Successfully creating a new Template (mandatory fields)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I created users with following fields:
| Email    | Role        | Agency        |
| U_CT_S01 | agency.user | DefaultAgency |
And logged in with details of 'U_CT_S01'
When I go to Dashboard page
And create new template with following fields:
| FieldName  | FieldValue |
| Name       | T_CT_S01   |
| Media type | Broadcast  |
| Start date | Today      |
| End date   | Tomorrow   |
Then I should see 'T_CT_S01' template in template list


Scenario: Successfully creating a new Template (all fields)
Meta:@gdam
@projects
Given I am on Create New Template page
When I fill 'AllFilledFields' for 'CT2' template
And click Save button on template popup without delay
Then I should see message warning 'Changes saved successfully'
And 'CT2' template should include 'AllFilledFields'


Scenario: Creating a new template with extended examples
Meta:@gdam
@projects
Given I am on Create New Template page
When I fill following fields on create new template page:
| FieldName  | FieldValue     |
| Name       | <TemplateName> |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And click on element 'SaveButton'
And go to template list page
Then I should see '<TemplateName>' template in templates list

Examples:
| TemplateName                                              |
| Nødhjælp O'Čöggànstsuvwyxz1234567890-=/*-+\\~!@#\$%^&*()_ |


Scenario: Unsuccessfully creating a Template with empty mandatory fields
Meta:@gdam
@projects
When I open Create New Template popup
Then I 'should not' see element 'ActiveSaveButton' on page 'CreateNewTemplatePopUp'



Scenario: Check that uploaded logo should displayed in template list positive
Meta:@gdam
@projects
Given I am on Create New Template page
When I fill following fields on create new template page:
| FieldName  | FieldValue     |
| Name       | <templateName> |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
| Logo       | <Logo>         |
And click on element 'SaveButton' without delay
Then I should see message warning '<Message>'
When I go to template list page
Then I should see template '<templateName>' with logo '<Logo>' in template list

Examples:
| templateName | Logo | Message                    |
| ct1          | PNG  | Changes saved successfully |
| ct2          | GIF  | Changes saved successfully |
| ct3          | JPG  | Changes saved successfully |
| ct4          | JPEG | Changes saved successfully |