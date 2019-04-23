package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.adcost.BudgetFormTemplates;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.adcost.CostOwners;
import com.adstream.automate.babylon.JsonObjects.adcost.Costs;
import com.adstream.automate.babylon.JsonObjects.adcost.ProjectSearch;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsOverviewPage;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsDetailsPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.CostStages;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.hamcrest.CoreMatchers;
import org.hamcrest.Matchers;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.core.IsNot.not;

/**
 * Created by Raja.Gone on 24/04/2017.
 */
public class
AdCostsOverviewSteps extends AdCostsHelperSteps {

    @Given("{I am} on cost overview page")
    @When("{I am} on cost overview page")
    public AdCostsOverviewPage openAdCostOverviewPage() {
        return getSut().getPageNavigator().getAdCostOverviewPage();
    }

    // cosyType = {production | buyout}
    @Given("{I |}created a new '$costType' cost on AdCosts overview page")
    @When("{I |}create a new '$costType' cost on AdCosts overview page")
    public AdCostsDetailsPage createNewCost(String costType) {
        AdCostsOverviewPage overviewPage = openAdCostOverviewPage();
        String costName = overviewPage.getAdCostType(costType);
        return overviewPage.createCosts(costName);
    }

    @Given("{I |}sorted costs on costs overview page by '$sortBy'")
    @When("{I |}sort costs on costs overview page by '$sortBy'")
    public void sortCostsBy(String sortBy) {
        AdCostsOverviewPage overviewPage = openAdCostOverviewPage();
        overviewPage.selectSortByField(sortBy);
    }

    // $tabname = {Filter Costs | All Costs }
    @Given("{I |}selected '$tabName' tab on costs overview page")
    @When("{I |}select '$tabName' tab on costs overview page")
    public void selectTabName(String tabName) {
        AdCostsOverviewPage overviewPage = openAdCostOverviewPage();
        overviewPage.clickCostMenuTab(tabName);
    }

    @Given("{I |}filled filter costs section with following fields:$data")
    @When("{I |}fill filter costs section with following fields:$data")
    public void fillFilterCostsSection(ExamplesTable data) {
        AdCostsOverviewPage overviewPage = openAdCostOverviewPage();
        overviewPage.clickCostMenuTab("Filter Costs");
        String parentPageLocator = overviewPage.getFilterCostPageLocator();
        for (MetadataItem row : wrapMetadataFields_Adcost(data, "FieldName", "FieldValue")) {
            overviewPage.fillFieldByName(row.getKey(), row.getValue(), parentPageLocator);
        }
        overviewPage.closeFilterCostsSection();
    }

    @Given("{I |}opened cost item with title '$costTitle' from costs overview page")
    @When("{I |}open cost item with title '$costTitle' from costs overview page")
    public void openCostItemWithTitle(String costTitle) {
        AdCostsOverviewPage page = openAdCostOverviewPage();
        AdCostsOverviewPage.CostItemDetails costItemDetails = page.getCostItemDetails();
        String costTitleWrap = wrapVariableWithTestSession(costTitle);
        Costs costs = getCostDetails(costTitleWrap);
        page.searchCostItemByString(costs.getCostNumber());
        int costItemsCount = costItemDetails.getCostItemsRowCount();
        for (int i = 1; i <= costItemsCount; i++) {
            costItemDetails.loadCostTitle(i);
            if (costItemDetails.getCostTitle().equals(costTitleWrap)) {
                costItemDetails.OpenCostItemByCostTitle(i);
                break;
            }
        }
    }

    @Then("{I |}'$condition' see '$costTitle' cost item on Adcost overview page")
    public void checkCostItemOnOverviewPage(String condition, String costTitle) {
        for (String costT : costTitle.split(",")) {
            String wrappedTitle = wrapVariableWithTestSession(costT);
            assertThat("Check if " +wrappedTitle+ " cost exists for user: ",
                    verifyCostExisted(wrappedTitle, condition), is(condition.equalsIgnoreCase("should")));
        }
    }

    private boolean verifyCostExisted(String wrappedTitle, String condition) {
        AdCostsOverviewPage overviewPage = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.CostItemDetails costItemDetails = overviewPage.getCostItemDetails();
        Costs costs = condition.equalsIgnoreCase("should") ? getCostDetails(wrappedTitle) :getCostDetailsAsGovernanceManager(wrappedTitle);
        overviewPage.searchCostItemByString(costs.getCostNumber());
        if (costItemDetails.checkIfCostItemsExistedOnPage()) {
            costItemDetails.loadCostTitle(1);
            if (wrappedTitle.equals(costItemDetails.getCostTitle()))
                return true;
            else
                return false;
        }
        return false;
    }

    @Then("{I |}'$condition' see create cost tab on cost overview page")
    public void checkCreateCostTab(String condition){
        AdCostsOverviewPage costsOverviewPage = openAdCostOverviewPage();
       assertThat("Check create cost tab on overview page: ", costsOverviewPage.isCreateCostTabVisible(), is(condition.equalsIgnoreCase("should")) );
    }

    @Then("{I |}'$condition' see admin section on toolbar")
    public void checkAdminSection(String condition){
        AdCostsOverviewPage costsOverviewPage = openAdCostOverviewPage();
        assertThat("Check Admin tab on toolbar: ", costsOverviewPage.isAdminTabPresent(), is(condition.equalsIgnoreCase("should")) );
    }

    // option = {Open| Recall Cost | Cancel Cost | Delete Cost | Reopen}
    @Given("{I |}clicked '$action' and '$finalAction' on title '$CostTitle' from costs overview page")
    @When("{I |}click '$action' and '$finalAction' on title '$CostTitle' from costs overview page")
    public void selectActionAgainstCostTitle(String action, String finalAction, String costTitle) {
        AdCostsOverviewPage costsOverviewPage = openAdCostOverviewPage();
        selectOptionFromCostItemMenu(action,costTitle);
        costsOverviewPage.clickBtnInMenuItem(action);
        costsOverviewPage.clickBtnByNameOnFormPage(finalAction);
        costsOverviewPage.waitUntilFormPageDisappears();
    }

    // Except for CostTitle field. For CostTitle session to be wrapped
    @Given("{I |}searched cost item with '$searchString' on costs overview page")
    @When("{I |}search cost item with '$searchString' on costs overview page")
    public void searchBy(String searchString){
        openAdCostOverviewPage().searchCostItemByString(searchString);
    }

    @Then("{I |}'$should' see following data for '$costTitle' cost item on Adcost overview page:$data")
    public void checkCostItemDetails(String condition,String costTitle,ExamplesTable data) {
        AdCostsOverviewPage overviewPage = openAdCostOverviewPage();
        AdCostsOverviewPage.CostItemDetails costItemDetails = overviewPage.getCostItemDetails();
        String costTitleWrap = wrapVariableWithTestSession(costTitle);
        Costs costs = getCostDetails(costTitleWrap);
        String costNumber = costs.getCostNumber();
        overviewPage.searchCostItemByString(costNumber);
        Map<String, String> row = parametrizeTabularRow(data, 0);
        int costItemsCount = costItemDetails.getCostItemsRowCount();
        for (int i = 1; i <= costItemsCount; i++) {
            costItemDetails.loadCostItemDetails(i);
            if (costItemDetails.getCostTitle().equals(costTitleWrap)) {
                if (row.containsKey("Cost Title"))
                    assertThat("Check 'Cost Title' details: ",
                            costItemDetails.getCostTitle().equals(wrapVariableWithTestSession(row.get("Cost Title"))), is(condition.equalsIgnoreCase("should")));
                if (row.containsKey("AdCost#"))
                    assertThat("Check 'AdCost#' details: ",
                            costItemDetails.getAdCostNumber().contains(costNumber), is(condition.equalsIgnoreCase("should")));
                if (row.containsKey("Cost Type"))
                    assertThat("Check 'Cost Type' details: ",
                            costItemDetails.getCostType().equals(row.get("Cost Type")), is(condition.equalsIgnoreCase("should")));
                if (row.containsKey("Agency Producer"))
                    assertThat("Check 'Agency Producer' details: ",
                            costItemDetails.getAgencyProducer().equals(row.get("Agency Producer")), is(condition.equalsIgnoreCase("should")));
                if (row.containsKey("Cost Stage"))
                    assertThat("Check 'Cost Stage' details: ",
                        costItemDetails.getCostStage(), condition.equalsIgnoreCase("should")?is(row.get("Cost Stage")):not(is(row.get("Cost Stage"))));
                if (row.containsKey("Cost Status")){
                    String status = null;
                    if (((row.get("Cost Status").contains("In Draft with")) || ((row.get("Cost Status").contains("Pending Approval by"))))) {
                        if ((!row.get("Approver").isEmpty() || (row.get("Approver")) != null)){
                            status= row.get("Cost Status").concat(" ").concat(getUserFullName(row.get("Approver")));}
                        else throw new Error("Approver is required for given status, check Approver field");
                    } else status = row.get("Cost Status");
                    assertThat("Check 'Cost Status' details",status, condition.equalsIgnoreCase("should") ? is(costItemDetails.getCostStatus()) : Matchers.not(is(status)));
                }
                if (row.containsKey("Budget"))
                    assertThat("Check 'Budget' details: ",
                            costItemDetails.getBudget().equals(row.get("Budget")), is(condition.equalsIgnoreCase("should")));
                if(row.containsKey("TimeStamp")){
                    String date = costs.getUserModifiedDate();
                    DateTime d = DateTime.parse(date);
                    String expected = d.toString("dd/MM/yyyy HH:mm:ss");

                    assertThat("Check 'Modified Date' details: ",
                            costItemDetails.getTimeStamp(), condition.equalsIgnoreCase("should")?is(expected):not(is(expected)));
                }
                break;
            }
        }
    }

    // option = {Open| Recall Cost | Cancel Cost | Delete Cost | Reopen}
    @Given("{I |}selected '$option' option for '$costTitle' cost item on costs overview page")
    @When("{I |}select '$option' option for 'costTitle' cost item on costs overview page")
    public void selectOptionFromCostItemMenu(String option,String costTitle){
        String costTitleWrap = wrapVariableWithTestSession(costTitle);
        Costs costs = getCostDetails(costTitleWrap);
        String costNumber = costs.getCostNumber();
        searchBy(costNumber);
        AdCostsOverviewPage.CostItemDetails costItemDetails = openAdCostOverviewPage().getCostItemDetails();
        int costItemsCount = costItemDetails.getCostItemsRowCount();
        for (int i = 1; i <= costItemsCount; i++) {
            costItemDetails.loadCostTitle(i);
            if (costTitleWrap.equals(costItemDetails.getCostTitle())) {
                costItemDetails.selectOptionForCostItem(option,i);
                break;
            }
        }
    }

    protected AdCostsOverviewPage.QuickViewDetails getQuickViewForm(String costTitle){
        AdCostsOverviewPage costsOverviewPage = getSut().getPageCreator().getAdCostsOverviewPage();
        selectOptionFromCostItemMenu("Quick View",costTitle);
        costsOverviewPage.clickBtnInMenuItem("Quick View");
        return costsOverviewPage.getQuickViewSection();
    }

    @Given("{I am|} on costs overview page")
    @When("{I am|} on costs overview page")
    public AdCostsOverviewPage openOverviewPage() {
        return openAdCostOverviewPage();
    }

    @Then("{I |}'$condition' see all budget form templates on cost overview page:$data")
    public void verifyAllBudgetTemplateOptions(String condition,ExamplesTable data) {
        AdCostsOverviewPage costsOverviewPage = openAdCostOverviewPage();
        costsOverviewPage.clickOnBudgetFormDropdown();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            assertThat("Check folowing 'Budget Template:'" +row.get("Budget Form Template Name")+" visible",
                    costsOverviewPage.checkValuesInBudgetFormDropDown(row.get("Budget Form Template Name")).contains(row.get("Budget Form Template Name")),is(condition.equalsIgnoreCase("should")));
        }
    }

    @When ("{I |} clicked on 'Budget Form' dropdown on cost overview page")
    public void clickOnBudgetFormDropdown(){
        AdCostsOverviewPage costsOverviewPage = openAdCostOverviewPage();
        costsOverviewPage.clickOnBudgetFormDropdown();

    }

    @Then("{I |} should able to download '$formType' form type and '$fileName' budget form template from overview page")
    public void downloadBudgetFormTemplateforCostOwner(String formType, String fileName){
        String templateName = formType.replaceAll("\\s","").replaceAll("-","");
        BudgetFormTemplates[] docsCount = getAdcostApi().getBudgetFormsTemplates();
        String budgetFormTemplateId = null;
        for(BudgetFormTemplates docs:docsCount) {
            if (docs.getKey().equalsIgnoreCase(templateName)) {
                budgetFormTemplateId = docs.getId();
                break;
            }
        }
        String downloadResponse = getAdcostApi().downloadBudgetForms(budgetFormTemplateId);
        //assertThat("Check Transfer-Encoding is empty",downloadResponse.contains("Transfer-Encoding: chunked"), equalTo(true));
        assertThat("Check Content-type is correct",downloadResponse.contains("Content-Type: application/octet-stream"), equalTo(true));
        assertThat("Check file name in content-disposition",checkDownloadResponseHeaders(downloadResponse, "Content-Disposition").contains(fileName));
    }

    public String checkDownloadResponseHeaders(String response, String headerType) {
        String downloadedFileName = null;
        if (response.contains(headerType)) {
            String[] temp = response.split("filename=");
            downloadedFileName = temp[1];
        }
        return downloadedFileName;
    }
    @Then("{I |}'$condition' see following data for cost title '$costTitle' in quick view option:$data")
    public void selectQuickViewAgainstCostTitle(String condition, String costTitle, ExamplesTable data) {
        AdCostsOverviewPage.QuickViewDetails quickViewDetails = getQuickViewForm(costTitle);
        quickViewDetails.loadQuickViewSection();
        Map<String, String> row = parametrizeTabularRow(data);
        String status = null;
        if (row.containsKey("Cost Title"))
            assertThat("Check Cost Title field on quick view", quickViewDetails.getCostTitle(), equalTo(wrapVariableWithTestSession(row.get("Cost Title"))));
        if (row.containsKey("Description"))
            assertThat("Check Description field on quick view", quickViewDetails.getDescription(), equalTo(wrapVariableWithTestSession(row.get("Description"))));
        if (row.containsKey("Cost Owner"))
            assertThat("Check Cost Owner field on quick view", quickViewDetails.getCostOwner(), equalTo(getUserFullName(row.get("Cost Owner"))));
        if (row.containsKey("Stage"))
            assertThat("Check Stage field on quick view", quickViewDetails.getCostStage(), equalTo(row.get("Stage")));
        if (row.containsKey("Status")){
            if (((row.get("Status").contains("In Draft with")) || ((row.get("Status").contains("Pending Approval by"))))) {
                if ((!row.get("Approver").isEmpty() || (row.get("Approver")) != null)){
                    status= row.get("Status").concat(" ").concat(getUserFullName(row.get("Approver")));}
                else throw new Error("Approver is required for given status, check Approver");
            } else status = row.get("Status");
        assertThat("Check Status field on quick view", quickViewDetails.getCostStatus(), equalTo(status));
        }
        if (row.containsKey("Company"))
            assertThat("Check Company field on quick view", quickViewDetails.getCompany(), equalTo(row.get("Company")));
        if (row.containsKey("Brand"))
            assertThat("Check Brand field on quick view", quickViewDetails.getBrand(), equalTo(row.get("Brand")));
        if (row.containsKey("Campaign"))
            assertThat("Check Campaign field on quick view", quickViewDetails.getCampaign(), equalTo(row.get("Campaign")));
        if (row.containsKey("Agency"))
            assertThat("Check Agency field on quick view", quickViewDetails.getAgency().contains(getCoreApi().getAgencyByName(row.get("Agency")).getName()));
        if (row.containsKey("Project"))
            assertThat("Check Project field on quick view", quickViewDetails.getProject(), equalTo(wrapVariableWithTestSession(row.get("Project"))));
    }

    // $tabname = top navbar || sub menu
    @Given("{I |}select costs tab in '$header' on costs overview page")
    @When("{I |}select costs tab in '$header' on costs overview page")
    public void selectCostsTabOnOverviewPage(String header) {
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        page.clickCostsTab(header);
        getSut().getPageCreator().getAdCostsOverviewPage().waitUntilAdCostsOverviewPageToLoad();
    }

    @Then("{I |}'$should' see project name as '$projectName' on costs overview page")
    public void checkProjectName(String should,String projectName){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        String expected = wrapVariableWithTestSession(projectName);
        String actual = page.getProjectName();
        assertThat(actual,should.equals("should")?is(expected):not(is(expected)));
    }

    private String getUserFullName(String userName){
        String name = null;
        if(!(userName.equals("") || userName.isEmpty() || userName.equals(null)))
            return getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName), 0).getFullName();
        return name;
    }

    @Then("{I |}'$condition' see '$count' cost on overview page")
    public void checkCostCount(String condition, String count){
        AdCostsOverviewPage costsOverviewPage = openAdCostOverviewPage();
        assertThat(Integer.toString(costsOverviewPage.getCostItemsCount()),condition.equals("should")?is(count):not(is(count)));
    }

    // $filterName = filters || close
    @Given("{I |}selected '$filterName' section on cost overview page")
    @When("{I |}select '$filterName' section on cost overview page")
    public void selectFilterMenu(String filterName){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        filters.selectFilterByName(filterName);
    }

    // $status = Enabled || Disabled
    @Then("{I |}'$should' see that '$fieldName' filter is '$status'")
    public void checkFilterStatusInFiltersMenu(String should,String fieldName,String status){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        assertThat(filters.getFilterStatus(fieldName),should.equals("should")?is(status): not(is(status)));
    }

    @Then("{I |}'$should' see that '$fieldName' filter is set with '$fieldValue' value")
    public void checkFilterValueInFiltersMenu(String should,String fieldName,String fieldValue){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        String expected = wrapVariableWithTestSession(fieldValue);
        assertThat(filters.getFilterValue(fieldName),should.equals("should")?is(expected): not(is(expected)));
    }

    // $status = Enabled || Disabled
    @Then("{I |}'$should' see following in filter section on costs overview page: $data")
    public void checkFilterSection(String should, ExamplesTable data){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        for(int i=0;i<data.getRowCount();i++){
            Map<String, String> row = parametrizeTabularRow(data, i);
            if(row.containsKey("Name")) {
                String fieldName = row.get("Name");
                if (row.containsKey("Value")) {
                    String expectedValue = row.get("Value").equals("All")?row.get("Value"): wrapVariableWithTestSession(row.get("Value"));
                    assertThat(filters.getFilterValue(fieldName), should.equals("should") ? is(expectedValue) : not(is(expectedValue)));
                }
                if (row.containsKey("Status"))
                        assertThat(filters.getFilterStatus(fieldName), should.equals("should") ? is(row.get("Status")) : not(is(row.get("Status"))));
            }

            if(row.containsKey("Cost Approval Stage")){
                List<String> actualStages = filters.getValuesInDropDown("Stage");
                for(String expectedStage:row.get("Cost Approval Stage").split(";"))
                    assertThat(actualStages, should.equals("should") ? hasItem(expectedStage.trim()) : not(hasItem(expectedStage.trim())));
            }
        }
    }

    @Given("{I |}filled search filters as: $data")
    @When("{I |}set search filters as: $data")
    public void setSearchFilterValue(ExamplesTable data){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        String parentLocaotr = filters.getParentLocator();
        Map<String, String> row = parametrizeTabularRow(data);
        if(row.containsKey("Project"))
                page.fillFieldByName("Project",wrapVariableWithTestSession(row.get("Project")),parentLocaotr);
        if(row.containsKey("Cost Type"))
            page.fillFieldByName("Cost Type",row.get("Cost Type"),parentLocaotr);
        if(row.containsKey("Content Type")) {
            for(String contentType:row.get("Content Type").split(";"))
            page.fillFieldByName("Content Type", contentType, parentLocaotr);
        }
        if(row.containsKey("Production Type"))
            page.fillFieldByName("All",row.get("Production Type"),parentLocaotr);
        if(row.containsKey("Brand")) {
            String[] temp =  row.get("Brand").split(";");
            if (temp.length == 2){
               String brand = wrapVariableWithTestSession(temp[0]).concat(" ("+wrapVariableWithTestSession(temp[1])+")");
                page.fillFieldByName("Brand",brand , parentLocaotr);
            }else
                throw new IllegalArgumentException("Something went wrong, please check brand and sector provided in input: "+row.get("Brand"));
        }
    }

    @Given("{I |}created a new filter by name '$filterName'")
    @When("{I |}create a new filter by name '$filterName'")
    public void createFilter(String filterName){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        page.clickCreateAQuickFilterLocator();
        filters.fillFilterName(wrapVariableWithTestSession(filterName));
        filters.buttonAction("Save");
    }

    // action: Deletes|Updates|Create
    @Given("{I |}'$action' filter by name '$filterName'")
    @When("{I |}'$action' filter by name '$filterName'")
    public void updateOrDeleteFilter(String action,String filterName){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        switch(action) {
            case "Updates":
                page.updateOrDeleteFilter(action);
                filters.fillFilterName(wrapVariableWithTestSession(filterName));
                filters.buttonAction("Save");
                break;
            case "Deletes":
                page.updateOrDeleteFilter(action);
                filters.buttonAction("Delete");
                break;
            case "Create":
                createFilter(filterName);
                break;
                default:
                    throw new IllegalArgumentException("Unknown action on filter: "+action);
        }
    }

    @When("{I |}select '$filterName' filter on costs overview page")
    public void selectFilterTab(String filterTabName){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        filters.selectFilterTabByName(wrapVariableWithTestSession(filterTabName));
    }

    @Then("{I |}'$should' see costs count as '$count' next to '$filterTabName' filter name on costs overview page")
    public void checkCountNextToFilterTabname(String should, String count,String filterTabName){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        String expectedCount = wrapVariableWithTestSession(filterTabName).concat(" (".concat(count).concat(")"));
        assertThat(filters.getCountInFiltersTab(wrapVariableWithTestSession(filterTabName)),
                should.equals("should")?is(expectedCount): not(is(expectedCount)));
    }

    @Then("{I }'$should' see a filter tab created by name '$filterTabName' on costs overview page")
    public void checkFilterTabName(String should,String filterTabName){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        String expectedName = wrapVariableWithTestSession(filterTabName);
        Boolean expected = should.equals("should");
        Boolean actual = filters.isFilterByNameCreated(expectedName);
        assertThat("Check Filter Tab by Name: "+expectedName,actual,equalTo(expected));
    }

    // $selected: selected | not selected
    @Then("{I }'$should' see that '$filterTabName' filter tab is '$selected' on costs overview page")
    public void checkFilterTabSelection(String should,String filterTabName, String selected){
        AdCostsOverviewPage page = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.FiltersSection filters = page.getFiltersSection();
        String expectedName = wrapVariableWithTestSession(filterTabName);
        assertThat("Check Filter Tab by Name: "+expectedName,filters.isFilterByNameCreated(expectedName));
        String expected = selected.equals("selected")?"true":"false";
        assertThat(filters.checkFiltersTabSelection(expectedName),should.equals("should")?is(expected):not(is(expected)));
    }

    @When("{I |}search cost with project Id of '$projectName' on cost overview page")
    public void searchCostViaProjectId(String projectName){
        String costNumber = new AdCostsDetailsSteps().getProjectNumber(wrapVariableWithTestSession(projectName));
        AdCostsOverviewPage page = openAdCostOverviewPage();
        page.searchCostItemByString(costNumber);
        Common.sleep(3000);
    }

    @When("{I |}delete project '$projectName' on A5 and search the project on cost overview page")
    public void deleteProjectAndSearchCostViaProjectId(String projectName){
        projectName = wrapVariableWithTestSession(projectName);
        Project project = getCoreApi().getProjectByName(projectName, 0);
        String costNumber = new AdCostsDetailsSteps().getProjectNumber(wrapVariableWithTestSession(projectName));
        getCoreApi().deleteProject(project.getId());
        Common.sleep(1000);
        AdCostsOverviewPage page = openAdCostOverviewPage();
        page.searchCostItemByString(costNumber);
        Common.sleep(2000);
    }

    @Then("{I |}'$condition' see '$costTitle' cost item on overview page")
    public void checkIfCostDeleted(String condition, String costTitle) {
            assertThat("Check if " +wrapVariableWithTestSession(costTitle)+ " cost exists for user: ",
                    verifyCostDeleted(costTitle, condition), is(condition.equalsIgnoreCase("should")));
    }

    private boolean verifyCostDeleted(String costTitle, String condition) {
        String costTitlewrap = wrapVariableWithTestSession(costTitle);
        AdCostsOverviewPage overviewPage = openAdCostOverviewPage();
        AdCostsOverviewPage.CostItemDetails costItemDetails = overviewPage.getCostItemDetails();
        if (costItemDetails.checkIfCostItemsExistedOnPage()) {
            int costItemsCount = costItemDetails.getCostItemsRowCount();
            for (int i = 1; i <= costItemsCount; i++) {
                costItemDetails.loadCostTitle(i);
                if (costTitlewrap.equals(costItemDetails.getCostTitle())) {
                    return true;
                }
            }
            return false;
        }
        return false;
    }

    @Then("{I |}'$condition' see edit cost owner icon for cost title '$costTitle' in quick view option")
    public void verifyEditCostOwnericon(String condition, String costTitle) {
        AdCostsOverviewPage.QuickViewDetails quickViewDetails = getQuickViewForm(costTitle);
        assertThat("Check Edit Cost Owner icon present on quick view", quickViewDetails.checkEditCostownerIconPresent(), is(condition.equalsIgnoreCase("should")));
    }

    @When ("{I |}update the cost owner field in quick view for cost title '$costTitle' with new owner '$cOwner'")
    public void updateCostOwnerInQuickView(String costTitle, String cOwner){
        AdCostsOverviewPage.QuickViewDetails quickViewDetails = getQuickViewForm(costTitle);
        quickViewDetails.updateCostOwner(getUserFullName(cOwner));
    }

    @Then("{I |}'$condition' see new owner as '$cOwner' on quick view option for cost title '$costTitle'")
    public void verifyUpdatedCostOwner(String condition, String cOwner, String costTitle) {
        AdCostsOverviewPage.QuickViewDetails quickViewDetails = getQuickViewForm(costTitle);
        assertThat("Check Edit Cost Owner icon present on quick view", quickViewDetails.checkUpdatedCostownerPresent(getUserFullName(cOwner)), is(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}see below users under quick view option for cost title '$costTitle':$data")
    public void verifyUsersForCostOwner(String costTitle, ExamplesTable data) {
        AdCostsOverviewPage.QuickViewDetails quickViewDetails = getQuickViewForm(costTitle);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            Boolean condition = row.get("Condition").equalsIgnoreCase("should");
            if (row.containsKey("Users")) {
                for (String expectedUser : row.get("Users").split(";")) {
                    String expectedUserName = getUserFullName(expectedUser);
                    assertThat("Check User: ",quickViewDetails.isUserAvailableInCostOwnerDropDown(expectedUserName),is(condition));
                }
            }
        }
    }

    @Then("{I |}'$should' see cost module in top header")
    public void checkCostModuleAccess(String condition){
        boolean actual = getSut().getPageCreator().getAdCostsOverviewPage().checkCostModuleTabInHeader();
        boolean expected = condition.equalsIgnoreCase("should")?true:false;
        assertThat("Check Cost Module access in header: ",actual,is(expected));
    }


    @Then("{I |}'$should' land on cost overview page")
    public void checkCostOverviewPageLanding(String condition){
        boolean actual = getSut().getPageNavigator().getAdCostOverviewPage().isCostOverPageloaded();
        boolean expected = condition.equalsIgnoreCase("should")?true:false;
        assertThat("Check Cost Module access in header: ",actual,is(expected));
    }

    @When("{I }close quick view popup")
    public void closeQuickViewPopUp(){
        AdCostsOverviewPage costsOverviewPage = getSut().getPageCreator().getAdCostsOverviewPage();
        costsOverviewPage.getQuickViewSection().clockQuickViewPopUp();
    }

    @Then("{I |}'$should' see download project totals button on cost overview page")
    public void checkDownloadProjectTotalsViaUI(String condition){
        boolean actual = getSut().getPageNavigator().getAdCostOverviewPage().isDownloadProjectTotalsButtonVisible();
        boolean expected = condition.equalsIgnoreCase("should")?true:false;
        assertThat("Check 'Download Project Totals' button: ",actual,is(expected));
    }

    @Then("{I |}'$should'  be able to download project totals for '$projectName' project of cost title '$costTitle':$data")
    public void checkDownloadProjectTotals(String condition, String projectName, String costTitle, ExamplesTable data){
        String gdamProjectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        ProjectSearch[] projectSearch=getAdcostApi().getProjectNumber(gdamProjectId);
        ProjectSearch project = null;
        for(ProjectSearch prot:projectSearch) {
            if (prot.getGdamProjectId().equals(gdamProjectId)) {
                project = prot;
                break;
            }
        }

        String response = getAdcostApi().checkDownloadProjectTotals(project.getId());

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            assertThat("Check Project Name:", response.contains("Project Name," + project.getName()), equalTo(true));
            assertThat("Check Project ID:", response.contains("Project ID," + project.getProjectNumber()), equalTo(true));
            if (row.containsKey("Project Creator Agecny"))
                assertThat("Check Project Creator Agecny:", response.contains(row.get("Project Creator Agecny")), equalTo(true));
            if (row.containsKey("Project Creator"))
                assertThat("Check Project Creator:", response.contains(getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("Project Creator")), 0).getEmail()), equalTo(true));
            if (row.containsKey("Project Creator Agecny"))
                assertThat("Check Project Creator Agecny:", response.contains(row.get("Project Creator Agecny")), equalTo(true));
            if (row.containsKey("Sector"))
                assertThat("Check Sector:", response.contains(row.get("Sector")), equalTo(true));
            if (row.containsKey("Brand"))
                assertThat("Check Brand:", response.contains(row.get("Brand")), equalTo(true));
            if (row.containsKey("User Business Unit"))
                assertThat("Check User Business Unit:", response.contains(row.get("User Business Unit")), equalTo(true));
            if (row.containsKey("Default currency"))
                assertThat("Check Default currency:", response.contains(row.get("Default currency")), equalTo(true));
            if (row.containsKey("Project total USD"))
                assertThat("Check Project total USD:", response.contains(row.get("Project total USD")), equalTo(true));
            if (row.containsKey("Cost Owner"))
                assertThat("Check Cost Owner:", response.contains(getUserFullName(row.get("Cost Owner"))), equalTo(true));
            if (row.containsKey("Title"))
                assertThat("Check Title:", response.contains(wrapVariableWithTestSession(row.get("Title"))), equalTo(true));
            if (row.containsKey("Content Type"))
                assertThat("Check Content Type:", response.contains(row.get("Content Type")), equalTo(true));
            if (row.containsKey("Production Type"))
                assertThat("Check Production Type:", response.contains(row.get("Production Type")), equalTo(true));
            if (row.containsKey("Budget Region"))
                assertThat("Check Budget Region:", response.contains(row.get("Budget Region")), equalTo(true));
            if (row.containsKey("Status"))
                assertThat("Status:", response.contains(row.get("Status")), equalTo(true));
            if (row.containsKey("Stage Name"))
                assertThat("Stage Name:", response.contains(row.get("Stage Name")), equalTo(true));
        }
    }

    @Then("{I |}'$condition' see following history data for cost title '$costTitle' in quick view option:$data")
    public void valdateQuickViewHistoryCostTitle(String condition, String costTitle, ExamplesTable data) {
        AdCostsOverviewPage.QuickViewDetails quickViewDetails = getQuickViewForm(costTitle);
        Costs costs = getCostDetails(wrapVariableWithTestSession(costTitle));
        CostOwners[] owners = getAdcostApi().getCostOwnersforCostId(costs.getId());
        List<String> allHistoryDetails = quickViewDetails.loadQuickViewHistoryData();
        List<String> expectedValues = new ArrayList<>();
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            if (row.get("Name") != null && !row.get("Name").isEmpty()) {
                String userFullName = getUserFullName(row.get("Name"));
                if (row.get("Assigned Till") != null && !row.get("Assigned Till").isEmpty()) {
                    if (row.get("Assigned Till").equals("Today")) {
                        String date = owners[i].getEndDate();
                        DateTime d = new DateTime(date);
                        expectedValues.add(userFullName.concat(";").concat(d.toString("dd/MM/yyyy HH:mm:ss")));
                    }
                } else {
                    expectedValues.add(userFullName);
                    assertThat("Check Current Cost Owner name is highlighted on Quick View section:",quickViewDetails.isUserNameHighlighted(userFullName, i+2),is(condition.equalsIgnoreCase("should")));
                }
            }
        }
        for(String exp:expectedValues)
        assertThat("Check History details on Quick View, expected: " + expectedValues + " Actual: " + allHistoryDetails, allHistoryDetails,condition.equalsIgnoreCase("should")?hasItem(exp): Matchers.not(hasItem(exp)));
    }

    @Given("{I |}selected '$tabName' tab under costs toolbar")
    @When("{I |}select '$tabName' tab under costs toolbar")
    public void selectTabOnCostsToolBar(String tabName){
        AdCostsOverviewPage costsOverviewPage = getSut().getPageCreator().getAdCostsOverviewPage();
        costsOverviewPage.clickTabOnToolBar(tabName);
        Common.sleep(1500);
    }

    @Then("{I |}'$condition' see '$count' costs on Adcost overview page")
    public void checkCostItemsOnOverviewPage(String condition, String count) {
        AdCostsOverviewPage overviewPage = getSut().getPageCreator().getAdCostsOverviewPage();
        AdCostsOverviewPage.CostItemDetails costItemDetails = overviewPage.getCostItemDetails();
        assertThat(Integer.toString(overviewPage.getCostItemsCount()),condition.equals("should")?is(count):not(is(count)));
    }
}