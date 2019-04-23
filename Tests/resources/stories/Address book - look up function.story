!--NGN-1169
Feature:          Address book - look up function
Narrative:
In order to
As a              AnotherAgencyAdmin
I want to         Check address book look up function

Scenario: Check that look up correctly
Meta: @gdam
      @projects
Given I created the agency 'A_ABLUF_S01' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_ABLUF_S01 | agency.admin | A_ABLUF_S01  |
And created users with following fields:
| FirstName      | LastName  | Email         | Telephone | Logo | Agency      |
| Eric           | Cartman   | U_ABLUF_S01_1 | +33333    | GIF  | A_ABLUF_S01 |
| Liane          | Cartman   | U_ABLUF_S01_2 | +44444    | GIF  | A_ABLUF_S01 |
| Kenny          | McCormick | U_ABLUF_S01_3 | +88888    | GIF  | A_ABLUF_S01 |
| Màr`garet Anna | Tetcher   | U_ABLUF_S01_4 | +99999    | GIF  | A_ABLUF_S01 |
And logged in with details of 'U_ABLUF_S01'
When I start type '<Text>' SearchCriteria on AddUsersPopUp page
Then I should see displayed users '<Users>' on Add User popup according to '<Text>'
And I should see displayed user '<UserName>' logo '<Image>' on Add User popup according to '<Text>'

Examples:
| Text           | Users                                 | Image | UserName      |
| Màr`garet Anna | Màr`garet Anna Tetcher\nU_ABLUF_S01_4 | GIF   | U_ABLUF_S01_4 |


Scenario: Check that data displayed in look-up can be selected
Meta: @gdam
      @projects
Given I created the agency 'A_ABLUF_S01' with default attributes
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_ABLUF_S01 | agency.admin | A_ABLUF_S01  |
And created users with following fields:
| FirstName      | LastName  | Email         | Telephone | Logo | Agency      |
| Eric           | Cartman   | U_ABLUF_S01_1 | +33333    | GIF  | A_ABLUF_S01 |
| Liane          | Cartman   | U_ABLUF_S01_2 | +44444    | GIF  | A_ABLUF_S01 |
| Kenny          | McCormick | U_ABLUF_S01_3 | +88888    | GIF  | A_ABLUF_S01 |
| Màr`garet Anna | Tetcher   | U_ABLUF_S01_4 | +99999    | GIF  | A_ABLUF_S01 |
And logged in with details of 'U_ABLUF_S01'
When I select users according to text '<Text>' in add user to address book popup
Then I should see selected '<SelectedUsers>' in add user as contact to Address Book

Examples:
| Text                            | SelectedUsers                 |
| qatbabylonautotester+U_ABLUF_S01_3 | Kenny McCormick U_ABLUF_S01_3 |