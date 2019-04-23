!--NGN-16212
Feature:         Global Admin Can Copy BU
Narrative:
In order to
As a             AgencyAdmin
I want to        check that Global Admin can copy Business Unit

Scenario: check that when a BU is copied from existing BU, Market and DestinationID fields should get copied for BU with type TV Broadcaster ,TV Broadcaster Hub ,Agency
Meta:@gdam
     @globaladmin
Given I created the following agency:
| Name                  |    A4User     | AgencyType     | Application Access |     Market     | DestinationIDUnique  |
|<BusinessUnitName>     | DefaultA4User | <Type>         |      adpath        |   <Market>     | <DestinationID>      |
And I logged in as 'GlobalAdmin'
When I go to the global search BU page
And wait for '1' seconds
Then I should see message success 'Changes saved successfully' on creating copy of BU '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName         | FieldValue               |
|CopyExistingBU     | <BusinessUnitName>       |
|Name               | Copy<BusinessUnitName>   |
|DestinationIDUnique| <NewDestnID>             |
And I 'should' see following fields on agency overview page For diffrent agency '<Type>' Types:
| FieldName                    | FieldValue        |  HubFieldName | HubFieldValue       | AgencyFieldName | AgencyFieldValue |
| Type                         | TV Broadcaster    |  Type         |  TV Broadcaster Hub |  Type           |  agency          |
| Market                       | United Kingdom    |  Market       |  Australia          |                 |                  |
|DestinationID                 | 2501              |               |                     |                 |                  |


Examples:
| BusinessUnitName   |   Type                | Market             | DestinationID | NewDestnID       |
| A_GACCBU_1         |   agency              |                    |               |                  |
| A_GACCBU_2         |   TV Broadcaster      |  United Kingdom    |     2302      |  2501            |
| A_GACCBU_3         |   TV Broadcaster Hub  |  Australia         |               |                  |

Scenario: check that when a BU with DestinationID  with type TV Broadcaster  should not get copied for BU
!-- There is a open bug for duplicate destination ID (Bug # TD-182)
Meta: @bug
      @gdam
      @globaladmin
Given I created the following agency:
| Name                  |    A4User     | AgencyType                | Application Access |     Market            | DestinationID        |
|A_GACCBU_50            | DefaultA4User | TV Broadcaster            |      adpath        |    United Kingdom     | 000                  |
And I logged in as 'GlobalAdmin'
When I go to the global search BU page
And I create copy of agency 'A_GACCBU_50' with following fields on Global Admin search agency page:
| FieldName         | FieldValue               |
|CopyExistingBU     | A_GACCBU_50              |
|Name               | CopyA_GACCBU_50          |
Then I should see message error 'Agency with id [New id] is not valid, duplicated destinationId [000]'

Scenario: check that when a BU is copied from existing BU,Modules access has to be copied
Meta:@gdam
      @globaladmin
Given I created the following agency:
| Name                  |    A4User       | AgencyType     | Application Access               |
|<BusinessUnitName>     | DefaultA4User   | <Type>         | adpath,ingest,reporting,dashboard|
And I logged in as 'GlobalAdmin'
When I create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue              |
|CopyExistingBU | <BusinessUnitName>      |
|Name           | CopyA_GACCBU_4          |
Then I 'should' see following fields on agency overview page:
| FieldName                                     | FieldValue |
|	Enable Traffic Module                       | True       |
|   Enable Ingest Module                        | True       |
|   Enable Reporting Module                     | True       |
|   Enable Dashboard feature                    | True       |


Examples:
| BusinessUnitName  |   Type                |
| A_GACCBU_4        |  Billing Entity       |



Scenario: check that when a BU is copied from existing BU,Branding are Copied
Meta:@gdam
      @globaladmin
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_1   | agency.admin | <BusinessUnitName> |
When I login with details of 'U_GACCBU_1'
And I fill From email field with text 'test@notadstream.com' on system branding page
And click save on the system branding page
And I login as 'GlobalAdmin'
And I create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_5           |
And create users with following fields:
| Email        | Role           | Agency                 |
| U_GACCBU_2   | agency.admin   |  CopyA_GACCBU_5        |
And login with details of 'U_GACCBU_2'
Then I 'should' see From email field with text 'test@notadstream.com' on system branding page


Examples:
| BusinessUnitName |   Type                |
| A_GACCBU_5       |  Billing Entity       |


Scenario: check that when a BU is copied from existing BU,Roles has to be copied
Meta:@gdam
      @globaladmin
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And I created '<RoleName>' role in 'global' group for advertiser '<BusinessUnitName>' with following permissions:
| Permission                   |
| element.read                 |
| folder.read                  |
| project.read                 |
| project_template.read        |
| comment.read                 |
| element.version_history.read |
When I login as 'GlobalAdmin'
And I create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue              |
|CopyExistingBU | A_GACCBU_6              |
|Name           | CopyA_GACCBU_6          |
And I go to global roles page
And I search advertiser 'CopyA_GACCBU_6' on global roles page
And I select advertiser 'CopyA_GACCBU_6' on global roles page
Then I should see role '<RoleName>' in 'global' group


Examples:
| BusinessUnitName  |   Type               |  RoleName   |
| A_GACCBU_6        |  Billing Entity      |  New Role6  |



Scenario: check that when a BU is copied from existing BU,Approval Templates are Copied
Meta: @bug
      @gdam
      @approvals
!--FAB-456 – For Approval Templates not copied while Copying BU
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_3   | agency.admin | <BusinessUnitName> |
And logged in with details of 'U_GACCBU_3'
When I create approval templates with following information on approval templates page:
| Name       | Description      |
| AT_ATM_S02 | test descriprion |
And I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_7           |
And create users with following fields:
| Email        | Role         | Agency           |
| U_GACCBU_4   | agency.admin | CopyA_GACCBU_7   |
And login with details of 'U_GACCBU_4'
Then I 'should' see template 'AT_ATM_S02' on approval templates page


Examples:
| BusinessUnitName |   Type                |
| A_GACCBU_7       |  Billing Entity       |


Scenario: check that when a BU is copied from existing BU,Custom metadata are Copied
Meta:@gdam
      @globaladmin
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_5   | agency.admin | <BusinessUnitName> |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_GACCBU_8':
| Advertiser         | Brand             | Sub Brand          | Product     |
| ADVERTISERS01      | BRANDS01          | SUBBRANDS01        | PRODUCT_S01 |
When I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue             |
|CopyExistingBU | <BusinessUnitName>     |
|Name           | CopyA_GACCBU_8         |
And create users with following fields:
| Email        | Role         | Agency                 |
| U_GACCBU_6   | agency.admin | CopyA_GACCBU_8         |
And login with details of 'U_GACCBU_6'
And I go to the global 'common custom' metadata page for agency 'CopyA_GACCBU_8'
Then I 'should' see following Advertiser chain on Settings and Customization page:
| Advertiser         | Brand             | Sub Brand          | Product     |
| ADVERTISERS01      | BRANDS01          | SUBBRANDS01        | PRODUCT_S01 |

Examples:
| BusinessUnitName |   Type                |
| A_GACCBU_8       |  Billing Entity       |


Scenario: check that when a BU is copied from existing BU,T&C are Copied
Meta:@gdam
      @projects
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_7   | agency.admin | <BusinessUnitName> |
When I login with details of 'U_GACCBU_7'
And I go to the T&C page
And I fill terms and conditions textbox with text 'Validate terms and Conditions' on T&C page
And I enable current terms and conditions for projects on opened T&C page
And I save current terms and conditions on opened T&C page
And I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_9           |
And create users with following fields:
| Email        | Role         | Agency          |
| U_GACCBU_8   | agency.admin | CopyA_GACCBU_9  |
And login with details of 'U_GACCBU_8'
And I go to the T&C page
Then I 'should' see selected 'Enable Terms & Conditions for project' checkbox
And 'should' see terms and conditions text 'Validate terms and Conditions' on T&C page

Examples:
| BusinessUnitName |   Type                |
| A_GACCBU_9       |  Billing Entity       |

Scenario: check that when a BU is copied from existing BU,Categories are Copied
Meta:@gdam
      @library
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_9   | agency.admin | <BusinessUnitName> |
And logged in with details of 'U_GACCBU_9'
When I create following categories:
| Name          | MediaType |
| CCAA_Nøæ"&_C1 | video     |
And go to collection 'CCAA_Nøæ"&_C1' on administration area collections page
And create collection 'CCAA_Nøæ"&_C1_S1' based on collection 'CCAA_Nøæ"&_C1' on administration area with following metadata:
| key | value |
And I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue             |
|CopyExistingBU | <BusinessUnitName>     |
|Name           | CopyA_GACCBU_10        |
And create users with following fields:
| Email        | Role         | Agency          |
| U_GACCBU_10  | agency.admin | CopyA_GACCBU_10 |
And login with details of 'U_GACCBU_10'
And I go to collection 'CCAA_Nøæ"&_C1_S1' on administration area collections page
Then I should see collection 'CCAA_Nøæ"&_C1_S1' is child of collection 'CCAA_Nøæ"&_C1' on administration area collections page

Examples:
| BusinessUnitName |   Type                |
| A_GACCBU_10      |  Billing Entity      |

Scenario: check that when a BU is copied from existing BU,users are NOT copied and admin users from original BU cannot see users from copied BU
Meta:@gdam
      @projects
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_11  | agency.admin | <BusinessUnitName> |
When I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_11          |
And create users with following fields:
| Email        | Role         | Agency          |
| U_GACCBU_12  | agency.admin | CopyA_GACCBU_11 |
And login with details of 'U_GACCBU_12'
And I go to User list page
Then I 'should' see 'U_GACCBU_12' in User list
And I 'should not' see 'U_GACCBU_11' in User list
When I login with details of 'U_GACCBU_11'
And I go to User list page
Then I 'should not' see 'U_GACCBU_12' in User list

Examples:
| BusinessUnitName  |   Type                 |
| A_GACCBU_11       |  Billing Entity       |



Scenario: check that when a BU is copied from existing BU,Views are copied from Original Bu to Copied Bu
Meta:@gdam
      @projects
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>    | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_15 | agency.admin | <BusinessUnitName> |
When I login  with details of 'U_GACCBU_15'
And I go to View Asset Management page
And I fill  following fields with orders  on View Asset Management  page:
| FieldName     | FieldValue |
|Advertiser     |   1        |
|Title          |   2        |
|Brand          |   3        |
And I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_13          |
And create users with following fields:
| Email        | Role         | Agency                 |
| U_GACCBU_16  | agency.admin | CopyA_GACCBU_13        |
And login with details of 'U_GACCBU_16'
And I go to View Asset Management page
Then I 'should' see following fields on View Asset Management  page:
| FieldName     | FieldValue |
|Advertiser     |   1        |
|Title          |   2        |
|Brand          |   3        |

Examples:
| BusinessUnitName |   Type                |
| A_GACCBU_13      |  Billing Entity       |

Scenario: check that when a BU is copied from existing BU,Types of relations are copied and default relations under Related Files are not duplicated

Meta:@bug
     @gdam
     @projects
!-- FAB-725 – Related Files under Admin section gets duplicated while copying BU

Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_17  | agency.admin | <BusinessUnitName> |
And logged in with details of 'U_GACCBU_17'
When I go to the Related Files Management  page
And I fill  following fields with orders  on the Related Files Management page:
| RelationRole1 | RelationRole2 |
| Ancestor      |   Proxy      |
And I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_14          |
And create users with following fields:
| Email        | Role         | Agency                 |
| U_GACCBU_18  | agency.admin | CopyA_GACCBU_14        |
And login with details of 'U_GACCBU_18'
And I go to the Related Files Management  page
Then I 'should' see Relation Type 'Ancestor,Parent,Master' on the Related Files Management page

Examples:
| BusinessUnitName |   Type                |
| A_GACCBU_14       |  Billing Entity       |

Scenario: check that when a BU is copied from existing BU,Watermarking Logos and text are also Copied
Meta:@gdam
      @projects
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_19  | agency.admin | <BusinessUnitName> |
When I login with details of 'U_GACCBU_19'
And I go to WaterMarking Management page
And I fill  following fields on the WaterMarking Management page:
| WaterMarkingText              |
| Validate Watermarking         |
And I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_15          |
And create users with following fields:
| Email        | Role         | Agency                 |
| U_GACCBU_20  | agency.admin | CopyA_GACCBU_15        |
And login with details of 'U_GACCBU_20'
And I go to WaterMarking Management page
Then I 'should' see following fields on WaterMarking Management  page:
| WaterMarkingText              |
| Validate Watermarking         |

Examples:
| BusinessUnitName |   Type                |
| A_GACCBU_15      |  Billing Entity       |

Scenario: check that when a BU is copied from existing BU, BU Meta Data gets Copied
Meta:@gdam
@projects
Given I created the following agency:
| Name                  |    A4User     | AgencyType     | Application Access |     Market     | DestinationIDUnique  |  Pin | TimeZone      |
|<BusinessUnitName>     | DefaultA4User | <Type>         |      adpath        |   <Market>     | <DestinationID>      | 5389 | Europe-London |
When I login as 'GlobalAdmin'
And I create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | A_GACCBU_16              |
|Name           | CopyA_GACCBU_16          |
And I go to agency 'CopyA_GACCBU_16' overview page
Then I 'should' see following fields on agency overview page For diffrent agency '<Type>' Types:
| FieldName                    | FieldValue        |
| Type                         | TV Broadcaster    |
| Market                       | United Kingdom    |
| DestinationID                | 2302              |
| Pin                          | 5389              |
| Time Zone                    | Europe-London     |

Examples:
| BusinessUnitName   |   Type                | Market             | DestinationID |
| A_GACCBU_16        |   TV Broadcaster      |  United Kingdom    |     2302      |


Scenario: check that when a BU is copied from existing BU, Projects should not get copied
Meta:@gdam
@projects
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |
| U_GACCBU_14_1  | agency.admin | <BusinessUnitName> |
When I login with details of 'U_GACCBU_14_1'
And I create 'CP1' project with 'AllFilledFields'
And I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_13_1          |
And create users with following fields:
| Email        | Role         | Agency          |
| U_GACCBU_15_1  | agency.admin | CopyA_GACCBU_13_1 |
And login with details of 'U_GACCBU_15_1'
Then I shouldn't see 'CP1' project in project list

Examples:
| BusinessUnitName  |   Type                 |
| A_GACCBU_13_1       |  Billing Entity        |


Scenario: check that when a BU is copied from existing BU,that admin users from original BU cannot see anything from Copied BU unless it was shared to them
Meta:@gdam
      @library
Given I created the following agency:
| Name                  |    A4User     | AgencyType    |
|<BusinessUnitName>     | DefaultA4User | <Type>        |
And created users with following fields:
| Email        | Role         | Agency             |Access|
| U_GACCBU_13  | agency.admin | <BusinessUnitName> |streamlined_library,library|
When I login as 'GlobalAdmin'
And create copy of agency '<BusinessUnitName>' with following fields on Global Admin search agency page:
| FieldName     | FieldValue               |
|CopyExistingBU | <BusinessUnitName>       |
|Name           | CopyA_GACCBU_12          |
And create users with following fields:
| Email        | Role         | Agency          |Access|
| U_GACCBU_14  | agency.admin | CopyA_GACCBU_12 |streamlined_library,library|
And login with details of 'U_GACCBU_14'
And upload file '/files/128_shortname.jpg' into libraryNEWLIB
And wait while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg'NEWLIB
And I login with details of 'U_GACCBU_13'
And I go to library pageNEWLIB
Then I 'should not' see assets '128_shortname.jpg' in the collection 'My Assets'NEWLIB

Examples:
| BusinessUnitName  |   Type                 |
| A_GACCBU_12       |  Billing Entity       |




