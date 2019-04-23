!--NGN-43
Feature:          Edit project details
Narrative:
In order to
As a              AgencyAdmin
I want to         Check editing project details

Scenario: Successfully updating project details
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @projects
      @gdamcrossbrowser
Given the following projects were created:
| Name | Job Number | Advertiser    | Media Type | Start Date | End Date   |
| EPD1 | job1       | DefaultAgency | Digital    | [Today]    | 12.12.2016 |
And I am on project 'EPD1' settings page
When I edit the following fields for 'EPD1' project:
| Name | Job Number | Media Type | Start Date | End Date   |
| UEPD2 | job2       | Print      | [Tomorrow] | 11.11.2015 |
And click on element 'SaveButton'
And refresh the page
Then Project 'UEPD2' should include the following fields:
| Name  | Job Number | Media Type |
| UEPD2 | job2       | Print      |


Scenario: Successfully updating project details #2_
Meta:@gdam
@projects
Given the following projects were created:
| Name    | Job Number | Media Type | Start date | End date   |
| EPD1_11 | job1       | Digital    | [Today]    | 12.12.2016 |
And I am on project 'EPD1_11' settings page
When I edit the following fields for 'EPD1_11' project:
| Name   | Job Number | Media Type | Start date | End date   |
| <Name> | job2       | Print      | [Tomorrow] | 11.11.2015 |
And click Save button on project popup without Delay
Then I should see message warning 'Changes saved successfully'
And Project '<Name>' should include the following fields:
| Name   | Job Number | Media Type | Start date | End date   |
| <Name> | job2       | Print      | [Tomorrow] | 11.11.2015 |

Examples:
| Name                                                    |
| aabcdefghijklmnoprqtsuvwyxz1234567890-=*-+~!@#\$%^&*()_ |


Scenario: Updating project details using logo with invalid extension
Meta:@gdam
@projects
Given the following projects were created:
| Name | Logo |
| EPD7 | GIF  |
And I am on project 'EPD7' settings page
When I edit the following fields for 'EPD7' project:
| Name | Logo |
| EPD7 | BMP  |
Then I should see  error message 'logo.*.bmp has invalid extension. Only jpg, jpeg, png are allowed.'


Scenario: Updating project details with empty mandatory field
Meta:@gdam
@projects
Given I created 'EPD8' project
And I am on project 'EPD8' settings page
When I edit the following fields for 'EPD8' project:
| Name | Job Number |
|      |            |
Then I 'should' see red inputs on page


Scenario: Updating project details with new user as project administrator
Meta:@gdam
@projects
Given I created 'EPD9' project
When I edit the following fields for 'EPD9' project:
| Name | Administrators     |
| EPD9 | NotExistPAdminName |
Then I should see count '2' of administrators on create new project page


Scenario: Check that Logo after update should be displayed in project list
Meta:@gdam
@projects
Given I created following projects:
| Name   | Logo |
| Wicked | GIF  |
And I am on project 'Wicked' settings page
When I edit the following fields for 'Wicked' project:
| Name   | Logo |
| Wicked | PNG  |
And click on element 'SaveButton'
When I go to project list page
Then I should see project 'Wicked' with logo 'PNG' in project list