Feature: Payment Rules in Cost module
Narrative:
In order to
As a GlobalAdmin
I want to check AIPE Activation for production cost

Scenario: Check AIPE section activated for different production type, content type and budget regions
Meta:@adcost
     @AIPE activation rules
!--QA-683
Given I logged to AdCosts system with userID as '58adb95be49a7152b1a32cce'
And I created a new 'production' cost on AdCosts overview page
And filled Cost Details page with following fields for 'production' cost:
| Project Number | Cost Title  | Description   | Agency Producer/Art | Target Budget Amount | Content Type  | Production Type  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| Adidas Project | <CostTitle> | <Description> | Agency Producer 1   | <TargetBudgetAmount> | <ContentType> | <ProductionType> | <AgencyTrackingNumber> | <BudgetRegion>| Campaign 1 | BFO          | USD - US Dollar         |
Then I 'should' see AIPE section enabled on cost detail page

Examples:
| CostTitle | Description| ProductionType       | AgencyTrackingNumber| ContentType  | BudgetRegion  | TargetBudgetAmount  |
| AARVPCT1  | AARVPCD1   | Full Production      | AARVPCATN1          | Video        | AAK           | 5000                |
| AARVPCT2  | AARVPCD2   | Full Production      | AARVPCATN2          | Still Image  | AAK           | 27000               |
| AARVPCT3  | AARVPCD3   | Post Production Only | AARVPCATN3          | Still Image  | AAK           | 72000               |
| AARVPCT4  | AARVPCD4   | Full Production      | AARVPCATN4          | Audio        | AAK           | 52000               |
| AARVPCT5  | AARVPCD5   | Post Production Only | AARVPCATN5          | Audio        | AAK           | 82000               |
| AARVPCT6  | AARVPCD6   | Full Production      | AARVPCATN6          | Video        | Europe        | 5000                |
| AARVPCT7  | AARVPCD7   | Full Production      | AARVPCATN7          | Still Image  | Europe        | 27000               |
| AARVPCT8  | AARVPCD8   | Post Production Only | AARVPCATN3          | Still Image  | Europe        | 52000               |
| AARVPCT9  | AARVPCD9   | Full Production      | AARVPCATN4          | Audio        | Europe        | 52000               |
| AARVPCT10 | AARVPCD10  | Post Production Only | AARVPCATN5          | Audio        | Europe        | 62000               |
| AARVPCT11 | AARVPCD11  | Full Production      | AARVPCATN1          | Video        | IMEA          | 5000                |
| AARVPCT12 | AARVPCD12  | Full Production      | AARVPCATN2          | Still Image  | IMEA          | 27000               |
| AARVPCT13 | AARVPCD13  | Post Production Only | AARVPCATN13         | Still Image  | IMEA          | 52000               |
| AARVPCT14 | AARVPCD14  | Full Production      | AARVPCATN14         | Audio        | IMEA          | 52000               |
| AARVPCT15 | AARVPCD15  | Post Production Only | AARVPCATN15         | Audio        | IMEA          | 52000               |
| AARVPCT16 | AARVPCD16  | Full Production      | AARVPCATN16         | Video        | North America | 5000                |
| AARVPCT17 | AARVPCD17  | Full Production      | AARVPCATN17         | Still Image  | North America | 27000               |
| AARVPCT18 | AARVPCD18  | CGI/Animation        | AARVPCATN17         | Video        | North America | 50000               |
| AARVPCT19 | AARVPCD19  | Post Production Only | AARVPCATN19         | Video        | North America | 50000               |
| AARVPCT20 | AARVPCD20  | Post Production Only | AARVPCATN20         | Still Image  | North America | 52000               |
| AARVPCT21 | AARVPCD21  | Full Production      | AARVPCATN21         | Audio        | North America | 75000               |
| AARVPCT22 | AARVPCD22  | Post Production Only | AARVPCATN22         | Audio        | North America | 85000               |