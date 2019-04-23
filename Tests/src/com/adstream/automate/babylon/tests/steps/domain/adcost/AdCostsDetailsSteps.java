package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsDetailsPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsData;
import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostsSchemaField;
import com.adstream.automate.babylon.sut.pages.adcost.elements.StepsAdCostType;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import scala.util.parsing.combinator.testing.Str;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.core.IsNot.not;

/**
 * Created by Raja.Gone on 21/04/2017.
 */
public class AdCostsDetailsSteps extends AdCostsHelperSteps {

    protected AdCostsDetailsPage openAdCostsDetailsPage(String costPage) {
        String costsPageName = "new";
        if(costPage.contains("buyout"))
            costsPageName=costsPageName.concat("buyout");
        AdCostsDetailsPage costDetailsPage = getSut().getPageNavigator().getAdCostsDetailsPage(costsPageName);
        if (costDetailsPage.waitUntilCostDetailsPageVisible())
            return new AdCostsDetailsPage(getSut().getWebDriver());
        else
            throw new Error("Unable to open Cost Details page for '"+costPage+"'");
    }

    @Given("{I |}closed wake-me pop-up in Adcost System")
    public void closeWakeMePopUp(){
        closeWakeMe();
    }

    @Given("{I |}filled Cost Details with following fields for '$costType' cost: $data")
    @When("{I |}fill Cost Details with following fields for '$costType' cost: $data")
    public void createCostThrowUI(String costType, ExamplesTable data) {
        fillCostDetailFieldsViaUI(data).clickBtnByName("Continue");
        checkForCostIsCreated();
    }

    @Given("{I |}filled Cost Details with following fields for '$costType' cost with page refresh: $data")
    @When("{I |}fill Cost Details with following fields for '$costType' cost with page refresh: $data")
    public void createCostThrowUIAfterPageRefresh(String costType, ExamplesTable data) {
        getSut().getWebDriver().navigate().refresh();
        fillCostDetailFieldsViaUI(data).clickBtnByName("Continue");
        checkForCostIsCreated();
    }

    @Given("{I am |}on new '$costType' cost details page")
    @When("{I |}go to new '$costType' cost details page")
    @Alias("{I |}open a new '$costType' cost details page")
    public AdCostsDetailsPage openCostDetailsPage(String costType) {
        return openAdCostsDetailsPage(costType);
    }

    @Given("{I |}filled following fields on cost details page: $data")
    @When("{I |}fill following fields on cost details page: $data")
    @Alias("{I |}update following fields on cost details page: $data")
    public void fillCostDetails(ExamplesTable data) {
        fillCostDetailFieldsViaUI(data);
    }

    private boolean checkForCostTitleDuplicates(String costTitle){
        Costs[] costs = getAdcostApi().getCosts().getCosts();
        for(Costs cost:costs){
            if(!(cost.getTitle()==null))
                if(cost.getTitle().equalsIgnoreCase(costTitle))
                throw new Error("Found a Cost with similar CostTitle: "+cost.getTitle()+". Check that CostTitle '"+costTitle+"' in scenario is always unique.");
        }
        return true;
    }

    @Given("{I am} on cost details page of cost title '$costTitle'")
    @When("{I am} on cost details page of cost title '$costTitle'")
    public AdCostsDetailsPage openCostDetailPage(String costTitle){
        String url = buildCostPageURL(wrapVariableWithTestSession(costTitle));
        return getSut().getPageNavigator().getAdCostsDetailsPage(url);
    }

    @Then("{I |}'$condition' see following fields popoulated on cost deatil page for any new cost:$data")
    public void checkPrepoulatedFieldsOnNewCostDetaiPage(String condition, ExamplesTable data){
        AdCostsDetailsPage costsDetailsPage = getSut().getPageCreator().getAdCostsCostDetailsPage();
        Map<String, String> row = prepareCostDetailFields(data);
        for (Map.Entry<String, String> entry : row.entrySet()) {
            assertThat("Check field: " + entry.getKey(),costsDetailsPage.getFieldValueInCostDetailsSection(entry.getKey()),
                    condition.equalsIgnoreCase("should")?is(entry.getValue()):not(is(entry.getValue())));
        }
    }

    private Map<String, String> prepareCostDetailFields(ExamplesTable fieldsTable) {
        String projectName;
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (AdCostsData.containsField(AdCostsSchemaField.AGENCYNAME, row, false)) {
        }  if (AdCostsData.containsField(AdCostsSchemaField.AGENCYNAME, row, false)) {
            String userName = AdCostsData.getField(AdCostsSchemaField.AGENCYNAME, row);
            User user=getData().getUserByType(userName);
            if(user==null)
                user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
            row.put(AdCostsSchemaField.AGENCYNAME.toString(), user.getAgency().getName());
        } if (AdCostsData.containsField(AdCostsSchemaField.COSTCREATOR, row, false)) {
            String costCreator = getUsersFullName(AdCostsData.getField(AdCostsSchemaField.COSTCREATOR, row));
            row.put(AdCostsSchemaField.COSTCREATOR.toString(), (costCreator));
        } if (AdCostsData.containsField(AdCostsSchemaField.AGENCYLOCATION, row, false)) {
            String costCreator = getUsersFullName(AdCostsData.getField(AdCostsSchemaField.CREATOR, row));
            row.put(AdCostsSchemaField.CREATOR.toString(), (costCreator));
        } if (AdCostsData.containsField(AdCostsSchemaField.PROJECTNAME, row, false)) {
            projectName = AdCostsData.getField(AdCostsSchemaField.PROJECTNAME, row);
            projectName = getProjectByNameAsGlobalAdmin(projectName);
            row.put(AdCostsSchemaField.PROJECTNAME.toString(), projectName);
        } if (AdCostsData.containsField(AdCostsSchemaField.BRAND, row, false)) {
            String brand = AdCostsData.getField(AdCostsSchemaField.BRAND, row);
            if(!brand.contains("DefaultBrand"))
                brand = wrapVariableWithTestSession(brand);
            row.put(AdCostsSchemaField.BRAND.toString(), brand);
        } if (AdCostsData.containsField(AdCostsSchemaField.SECTOR, row, false)) {
            String sector = AdCostsData.getField(AdCostsSchemaField.SECTOR, row);
            if(!sector.contains("DefaultSector"))
                sector = wrapVariableWithTestSession(sector);
            row.put(AdCostsSchemaField.SECTOR.toString(), sector);
        } if (AdCostsData.containsField(AdCostsSchemaField.PROJECTNUMBER, row, false)) {
            projectName = AdCostsData.getField(AdCostsSchemaField.PROJECTNUMBER, row);
            projectName = getProjectByNameAsGlobalAdmin(projectName);
            String projectNumber = getProjectNumber(projectName);
            row.put(AdCostsSchemaField.PROJECTNUMBER.toString(), projectNumber);
        }
        return row;
    }
    // via core
    @Given("{I |}created a new '$costType' cost with following CostDetails:$data")
    @When("{I |}create a new '$costType' cost with following CostDetails:$data")
    public void createCostDetails(String costType, ExamplesTable data){
        CostDetails costDetails = new CostDetails();
        if(costType.equals(StepsAdCostType.PRODUCTION.toString())) {
            costType = StepsAdCostType.PRODUCTION.toString();
            costDetails.getStageDetails().getData().setCostType("Production");
            costDetails=buildRequestForContentAndProductionFields(data,costDetails);
        }
        else if(costType.equals(StepsAdCostType.BUYOUT.toString())) {
            costDetails.getStageDetails().getData().setCostType("Buyout");
            costType = StepsAdCostType.BUYOUT.toString();
        }else if(costType.equals(StepsAdCostType.TRAFFICKINGDISTRIBUTION.toString())) {
            costDetails.getStageDetails().getData().setCostType("Trafficking");
            costType = StepsAdCostType.TRAFFICKINGDISTRIBUTION.toString();
        }
        else
            throw new IllegalArgumentException("Unknown Cost Type: "+costType);

        for(CostTemplates templates:getAdcostApi().getCostTemplates())
            if(templates.getCostType().equalsIgnoreCase(costType)) {
                costDetails.setTemplateId(templates.getId());
                break;
            }
        costDetails=prepareCostDetailFieldsForCoreCall(data,costDetails);
        getAdcostApi().createCostDetails(costDetails);
        Common.sleep(1000); // slow down cost creation process
    }

    private CostDetails prepareCostDetailFieldsForCoreCall(ExamplesTable fieldsTable,CostDetails costDetails) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (AdCostsData.containsField(AdCostsSchemaField.AGENCYCURRNECY, row, false)) {
            String[] agencyCurrency = AdCostsData.getField(AdCostsSchemaField.AGENCYCURRNECY, row).split("-");
            AdcostCurrency[] currency = getAdcostApi().getAdcostCurrnecy();
            for(AdcostCurrency curr:currency){
                if(curr.getCode().equals(agencyCurrency[0].trim()) && curr.getDescription().equals(agencyCurrency[1].trim())){
                    costDetails.getStageDetails().getData().setAgencyCurrency(agencyCurrency[0].trim());
                    costDetails.getStageDetails().getData().setInitialBudgetCurrencySymbol((curr.getSymbol()));
                }
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.AIPE, row, false))
            if(AdCostsData.getField(AdCostsSchemaField.AIPE, row).equalsIgnoreCase("true"))
                    costDetails.getStageDetails().getData().setIsAIPE(true);
            else
                costDetails.getStageDetails().getData().setIsAIPE(false);
        else
            costDetails.getStageDetails().getData().setIsAIPE(false);

        // TODO: IsCurrencyChanged field

        if (AdCostsData.containsField(AdCostsSchemaField.PROJECTNAME, row, false)) {
            String projectName = (AdCostsData.getField(AdCostsSchemaField.PROJECTNAME, row));
            String projectId = getProjectId(projectName);
            costDetails.getStageDetails().getData().setProjectId(projectId);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PROJECTNUMBER, row, false)) {
            String projectName = AdCostsData.getField(AdCostsSchemaField.PROJECTNUMBER, row);
            projectName = getProjectByNameAsGlobalAdmin(projectName);
            String projectId = getCoreApi().getProjectByName(projectName).getId();

            /*LuceneSearchingParams query = new LuceneSearchingParams();
            query.setQuery(String.format("createdBy._id:%s", getCoreApi().getCurrentUser().getId()));
            SearchResult<Project> result = getCoreApi().findProjects(query);
            String projectId = null;
            for(Project project : result.getResult()) {
                if (project.getName().equals(wrapVariableWithTestSession(projectName))) {
                    projectId = project.getId();
                    break;
                }
            }

            if(projectId==null) {
                for (Project project : result.getResult()) {
                    if (project.getName().contains(projectName) && project.getAdvertiser().equals("DefaultAdv")) {
                        projectId = project.getId();
                        break;
                    }
                }
            }*/

            costDetails.getStageDetails().getData().setProjectId(projectId);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.CAMPAIGN, row, false))
            costDetails.getStageDetails().getData().setCampaign((AdCostsData.getField(AdCostsSchemaField.CAMPAIGN, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.COSTTITLE, row, false)) {
            String costTitle = wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.COSTTITLE, row));
            checkForCostTitleDuplicates(costTitle);
            costDetails.getStageDetails().getData().setTitle(costTitle);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.DESCRIPTION, row, false))
            costDetails.getStageDetails().getData().setDescription(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.DESCRIPTION, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.AGENCYPRODUCER, row, false)) {
            String[] agencyProducers = AdCostsData.getField(AdCostsSchemaField.AGENCYPRODUCER, row).split(",");
            costDetails.getStageDetails().getData().setAgencyProducer(agencyProducers);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.TARGETBUDGETAMOUNT, row, false))
            costDetails.getStageDetails().getData().setInitialBudget(Integer.parseInt(AdCostsData.getField(AdCostsSchemaField.TARGETBUDGETAMOUNT, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.AGENCYTRACKINGNUMBER, row, false))
            costDetails.getStageDetails().getData().setAgencyTrackingNumber(wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.AGENCYTRACKINGNUMBER, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.BUGDETREGION, row, false)) {
            String budgetRegion = AdCostsData.getField(AdCostsSchemaField.BUGDETREGION, row);
            BudgetRegions budget = getBudgetRegionId(budgetRegion);
            costDetails.getStageDetails().getData().getBudgetRegion().setId(budget.getId());
            costDetails.getStageDetails().getData().getBudgetRegion().setName(budget.getName());
            costDetails.getStageDetails().getData().getBudgetRegion().setkey(budget.getkey());
        }
        // TODO: financialYear field
        if (AdCostsData.containsField(AdCostsSchemaField.ORGANISATION, row, false))
            if ((AdCostsData.getField(AdCostsSchemaField.ORGANISATION, row).equals("BFO"))|| (AdCostsData.getField(AdCostsSchemaField.ORGANISATION, row).equals("Other"))) {
                costDetails = buildOrganizationDetails(costDetails,"BFO");
            }
            else
                if ((AdCostsData.getField(AdCostsSchemaField.ORGANISATION, row).equals("SMO"))& (AdCostsData.containsField(AdCostsSchemaField.SMO, row, false) )){
                    BudgetRegions budget = getBudgetRegionId(AdCostsData.getField(AdCostsSchemaField.BUGDETREGION, row));
                    String smoOrganisation = AdCostsData.getField(AdCostsSchemaField.SMO, row);
                    SmoOrganisations smo = getSmoOrganisations(budget.getId(),smoOrganisation);
                    costDetails = buildOrganizationDetails(costDetails,"SMO");
                    costDetails.getStageDetails().getData().setSmoId((smo.getId()));
                    costDetails.getStageDetails().getData().setSmoName(smo.getName());
                }
        else
            throw new IllegalArgumentException("Unknown Organisation: "+AdCostsData.getField(AdCostsSchemaField.ORGANISATION, row));

        if (AdCostsData.containsField(AdCostsSchemaField.NEW, row, false) || AdCostsData.containsField(AdCostsSchemaField.EXTENSION, row, false))
            if(AdCostsData.getField(AdCostsSchemaField.NEW, row).equalsIgnoreCase("true") || AdCostsData.getField(AdCostsSchemaField.EXTENSION, row).equalsIgnoreCase("false") )
                costDetails.getStageDetails().getData().setNewBuyout(true);
            else if(AdCostsData.getField(AdCostsSchemaField.EXTENSION, row).equalsIgnoreCase("true") || AdCostsData.getField(AdCostsSchemaField.NEW, row).equalsIgnoreCase("false") )
                costDetails.getStageDetails().getData().setNewBuyout(false);
        if (AdCostsData.containsField(AdCostsSchemaField.APPROVALSTAGEFORSUBMISSION, row, false))
            costDetails.getStageDetails().getData().setApprovalStage((AdCostsData.getField(AdCostsSchemaField.APPROVALSTAGEFORSUBMISSION, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.TYPE, row, false)) {
            DictionaryEntries entries = new DictionaryEntries();
            entries = getAdcostDictionaryEntryByName("UsageType", (AdCostsData.getField(AdCostsSchemaField.TYPE, row)));
            costDetails.getStageDetails().getData().getUsageType().setProjects(entries.getProjects());
            costDetails.getStageDetails().getData().getUsageType().setDictionaryId(entries.getDictionaryId());
            costDetails.getStageDetails().getData().getUsageType().setKey(entries.getKey());
            costDetails.getStageDetails().getData().getUsageType().setValue(entries.getValue());
            costDetails.getStageDetails().getData().getUsageType().setVisible(entries.getVisible());
            costDetails.getStageDetails().getData().getUsageType().setId(entries.getId());
        }
        if (AdCostsData.containsField(AdCostsSchemaField.USAGEBUYOUTCONTRACT, row, false)) {
            DictionaryEntries entries = new DictionaryEntries();
            entries = getAdcostDictionaryEntryByName("UsageBuyoutType", (AdCostsData.getField(AdCostsSchemaField.USAGEBUYOUTCONTRACT, row)));
            costDetails.getStageDetails().getData().getUsageBuyoutType().setProjects(entries.getProjects());
            costDetails.getStageDetails().getData().getUsageBuyoutType().setDictionaryId(entries.getDictionaryId());
            costDetails.getStageDetails().getData().getUsageBuyoutType().setKey(entries.getKey());
            costDetails.getStageDetails().getData().getUsageBuyoutType().setValue(entries.getValue());
            costDetails.getStageDetails().getData().getUsageBuyoutType().setVisible(entries.getVisible());
            costDetails.getStageDetails().getData().getUsageBuyoutType().setId(entries.getId());

        }
        if (AdCostsData.containsField(AdCostsSchemaField.AIRINSERTIONDATE, row, false)) {
            DateTime airInsertionDate = parseDateWithUTCZone(AdCostsData.getField(AdCostsSchemaField.AIRINSERTIONDATE, row));
            costDetails.getStageDetails().getData().setAirInsertionDate(airInsertionDate);
        }

        return costDetails;
    }

    // Production Cost Type: Content Type | Production Type
    private CostDetails buildRequestForContentAndProductionFields(ExamplesTable fieldsTable,CostDetails costDetails) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        AdcostDictionaries[] dictionaries = getAdcostApi().getAdcostDictionaries();
        if (AdCostsData.containsField(AdCostsSchemaField.CONTENTTYPE, row, false)) {
            for (AdcostDictionaries dict : dictionaries) {
                DictionaryEntries[] dictionaryEntries = dict.getDictionaryEntries();
                for (DictionaryEntries entries : dictionaryEntries) {
                    if (entries.getValue().equals(AdCostsData.getField(AdCostsSchemaField.CONTENTTYPE, row))) {
                        costDetails.getStageDetails().getData().getContentType().setProjects(entries.getProjects());
                        costDetails.getStageDetails().getData().getContentType().setDictionaryId(entries.getDictionaryId());
                        costDetails.getStageDetails().getData().getContentType().setKey(entries.getKey());
                        costDetails.getStageDetails().getData().getContentType().setValue(entries.getValue());
                        costDetails.getStageDetails().getData().getContentType().setVisible(entries.getVisible());
                        costDetails.getStageDetails().getData().getContentType().setId(entries.getId());
                        break;
                    }
                }
            }
        }
        if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONTYPE, row, false)) {
            for (AdcostDictionaries dict : dictionaries) {
                DictionaryEntries[] dictionaryEntries = dict.getDictionaryEntries();
                for (DictionaryEntries entries : dictionaryEntries) {
                    if (entries.getKey().equals(AdCostsData.getField(AdCostsSchemaField.PRODUCTIONTYPE, row))) {
//                        costDetails.getStageDetails().getData().getProductionType().setProjects(entries.getProjects());
//                        costDetails.getStageDetails().getData().getProductionType().setDictionaryId(entries.getDictionaryId());
                        costDetails.getStageDetails().getData().getProductionType().setKey(entries.getKey());
                        costDetails.getStageDetails().getData().getProductionType().setValue(entries.getValue());
//                        costDetails.getStageDetails().getData().getProductionType().setVisible(entries.getVisible());
                        costDetails.getStageDetails().getData().getProductionType().setId(entries.getId());
                        break;
                    }
                }
            }
        }
        return costDetails;
    }

    private AdCostsDetailsPage fillCostDetailFieldsViaUI(ExamplesTable fieldsTable) {
        AdCostsDetailsPage costDetailsPage = getSut().getPageCreator().getAdCostsCostDetailsPage();

        Map<String, String> row = parametrizeTabularRow(fieldsTable);

        if (AdCostsData.containsField(AdCostsSchemaField.COSTTITLE, row, false)) {
            String costTitle = wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.COSTTITLE, row));
            checkForCostTitleDuplicates(costTitle);
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.COSTTITLE), costTitle);}
        if (AdCostsData.containsField(AdCostsSchemaField.DESCRIPTION, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.DESCRIPTION), wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.DESCRIPTION, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.PROJECTNAME, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PROJECTNAME), AdCostsData.getField(AdCostsSchemaField.PROJECTNAME, row));
        if (AdCostsData.containsField(AdCostsSchemaField.PROJECTNUMBER, row, false)) { // ProjectName should be passed as "PROJECTNUMBER"
            String pName = AdCostsData.getField(AdCostsSchemaField.PROJECTNUMBER, row);
            String projectName = getProjectByName(pName);
            String projectNumber = getProjectNumber(projectName);
            if(projectNumber==null)
                throw new Error("Unable to retrieve Project Number for Project: "+projectName);
            //costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PROJECTNUMBER), projectNumber);
            costDetailsPage.fillFieldByName("Project#", projectNumber);
            costDetailsPage.checkBrandAutoPopulatedAfterFillingProject(projectNumber);
        }
            if (AdCostsData.containsField(AdCostsSchemaField.TARGETBUDGETAMOUNT, row, false))
                //costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TARGETBUDGETAMOUNT), AdCostsData.getField(AdCostsSchemaField.TARGETBUDGETAMOUNT, row));
                costDetailsPage.fillFieldByName("Target Budget Amount (USD)", AdCostsData.getField(AdCostsSchemaField.TARGETBUDGETAMOUNT, row));
        if (AdCostsData.containsField(AdCostsSchemaField.AGENCYTRACKINGNUMBER, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.AGENCYTRACKINGNUMBER), wrapVariableWithTestSession(AdCostsData.getField(AdCostsSchemaField.AGENCYTRACKINGNUMBER, row)));
        if (AdCostsData.containsField(AdCostsSchemaField.CONTENTTYPE, row, false)) {
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CONTENTTYPE), AdCostsData.getField(AdCostsSchemaField.CONTENTTYPE, row));
            if (AdCostsData.containsField(AdCostsSchemaField.PRODUCTIONTYPE, row, false))
                costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.PRODUCTIONTYPE), AdCostsData.getField(AdCostsSchemaField.PRODUCTIONTYPE, row));
        }
        /*if (AdCostsData.containsField(AdCostsSchemaField.BUGDETREGION, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.BUGDETREGION), AdCostsData.getField(AdCostsSchemaField.BUGDETREGION, row));*/
        if (AdCostsData.containsField(AdCostsSchemaField.CAMPAIGN, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.CAMPAIGN), AdCostsData.getField(AdCostsSchemaField.CAMPAIGN, row));  // ToDo: sessionToBeWrapped if CAMPAIGN created in scenario
        /*if (AdCostsData.containsField(AdCostsSchemaField.ORGANISATION, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ORGANISATION), AdCostsData.getField(AdCostsSchemaField.ORGANISATION, row));*/
        if (AdCostsData.containsField(AdCostsSchemaField.AGENCYCURRNECY, row, false)) {
            String fieldName = AdCostsData.getPrimaryFieldName(AdCostsSchemaField.AGENCYCURRNECY);
            String currency = AdCostsData.getField(AdCostsSchemaField.AGENCYCURRNECY, row);
            if(!costDetailsPage.getDefaultAgencyCurrency(fieldName).equalsIgnoreCase(currency))
                costDetailsPage.fillFieldByName(fieldName, currency);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.AIRINSERTIONDATE, row, false)) {
            String date = AdCostsData.getField(AdCostsSchemaField.AIRINSERTIONDATE, row);
            if (checkDateFormatINddMMyyyy(date))
                costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.AIRINSERTIONDATE), date);
        }
        if (AdCostsData.containsField(AdCostsSchemaField.BUGDETREGION, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.BUGDETREGION), AdCostsData.getField(AdCostsSchemaField.BUGDETREGION, row));
        if (AdCostsData.containsField(AdCostsSchemaField.ORGANISATION, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.ORGANISATION), AdCostsData.getField(AdCostsSchemaField.ORGANISATION, row));
        if (AdCostsData.containsField(AdCostsSchemaField.NEW, row, false) || AdCostsData.containsField(AdCostsSchemaField.EXTENSION, row, false))
            if(AdCostsData.getField(AdCostsSchemaField.NEW, row).equalsIgnoreCase("true") || AdCostsData.getField(AdCostsSchemaField.EXTENSION, row).equalsIgnoreCase("false") )
                costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.NEW), AdCostsData.getField(AdCostsSchemaField.NEW, row)); // ToDo: to be validate for correct name
            else if(AdCostsData.getField(AdCostsSchemaField.EXTENSION, row).equalsIgnoreCase("true") || AdCostsData.getField(AdCostsSchemaField.NEW, row).equalsIgnoreCase("false") )
                costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.NEW), AdCostsData.getField(AdCostsSchemaField.NEW, row)); // ToDo: to be validate for correct name
        if (AdCostsData.containsField(AdCostsSchemaField.APPROVALSTAGEFORSUBMISSION, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.APPROVALSTAGEFORSUBMISSION), AdCostsData.getField(AdCostsSchemaField.APPROVALSTAGEFORSUBMISSION, row));
        if (AdCostsData.containsField(AdCostsSchemaField.TYPE, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.TYPE), AdCostsData.getField(AdCostsSchemaField.TYPE, row));
        if (AdCostsData.containsField(AdCostsSchemaField.USAGEBUYOUTCONTRACT, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.USAGEBUYOUTCONTRACT), AdCostsData.getField(AdCostsSchemaField.USAGEBUYOUTCONTRACT, row));
        /*if (AdCostsData.containsField(AdCostsSchemaField.AGENCYPRODUCER, row, false))
            for (String agencyProducer : AdCostsData.getField(AdCostsSchemaField.AGENCYPRODUCER, row).split(",")) {
              //  costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.AGENCYPRODUCER), agencyProducer); // ToDo: sessionToBeWrapped if AGENCYPRODUCER created in scenario
                costDetailsPage.fillFieldByName("Agency Art Producer Buyer", agencyProducer);
            }*/
        if (AdCostsData.containsField(AdCostsSchemaField.AIPE, row, false))
            costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.AIPE), AdCostsData.getField(AdCostsSchemaField.AIPE, row));

        if (AdCostsData.containsField(AdCostsSchemaField.AGENCYPRODUCER, row, false))
            for (String agencyProducer : AdCostsData.getField(AdCostsSchemaField.AGENCYPRODUCER, row).split(",")) {
                //  costDetailsPage.fillFieldByName(AdCostsData.getPrimaryFieldName(AdCostsSchemaField.AGENCYPRODUCER), agencyProducer); // ToDo: sessionToBeWrapped if AGENCYPRODUCER created in scenario
                costDetailsPage.fillFieldByName("Agency Producer/Art Buyer", agencyProducer);
            }
        Common.sleep(3000); //just to slow down the process
        return costDetailsPage;
    }

    protected void checkForCostIsCreated(){
        AdCostsDetailsPage detailPage = new AdCostsDetailsPage(getSut().getWebDriver());
        detailPage.waitUntilCostDetailsPageDisappears();
    }

    public String getProjectNumber(String projectName){
        String gdamProjectId = getProjectId(projectName);
        if(gdamProjectId==null)
            throw new Error("Check if project replicated to cost module: "+projectName);
        ProjectSearch[] projectSearch=getAdcostApi().getProjectNumber(gdamProjectId);
        for(ProjectSearch project:projectSearch){
            if(project.getGdamProjectId().equals(gdamProjectId))
                return project.getProjectNumber();
        }
        return  null;
    }

    public String getProjectByName(String pName){
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("createdBy._id:%s", getCoreApi().getCurrentUser().getId()));
        SearchResult<Project> result = getCoreApi().findProjects(query);
        for(Project project : result.getResult()) {
            if (project.getName().equals(wrapVariableWithTestSession(pName)))
                return project.getName();
            else if (project.getName().contains(pName) && project.getAdvertiser().equals("DefaultAdv"))
                return project.getName();
        }
        return null;
    }

    public String getProjectByNameAsGlobalAdmin(String pName){
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setSortingField("_created");
        query.setSortingOrder("desc");
        SearchResult<Project> result = getCoreApiAdmin().findProjects(query);
        for(Project project : result.getResult()) {
            if (project.getName().equals(wrapVariableWithTestSession(pName)))
                return project.getName();
            else if (project.getName().contains(wrapVariableWithTestSession(pName)) && project.getAdvertiser().equals("DefaultAdv"))
                return project.getName();
            else if (project.getName().contains(pName) && project.getAdvertiser().equals("DefaultAdv"))
                return project.getName();
        }
        throw new IllegalArgumentException("Could not found requested Project: "+pName);
    }

    private String getProjectId(String projectName){
        Project project = getCoreApi().getProjectByName(projectName);
        if(project==null)
            project = getCoreApiAdmin().getProjectByName(projectName);
        return project.getId();
    }

    private CostDetails buildOrganizationDetails(CostDetails costDetails, String dictionaryValue){
        DictionaryEntries entry = getAdcostDictionaryEntryByName("Organization",dictionaryValue);
        costDetails.getStageDetails().getData().getOrganisation().setProjects(entry.getProjects());
        costDetails.getStageDetails().getData().getOrganisation().setDictionaryId(entry.getDictionaryId());
        costDetails.getStageDetails().getData().getOrganisation().setKey(entry.getKey());
        costDetails.getStageDetails().getData().getOrganisation().setValue(entry.getValue());
        costDetails.getStageDetails().getData().getOrganisation().setVisible(entry.getVisible());
        costDetails.getStageDetails().getData().getOrganisation().setId(entry.getId());
        return costDetails;
    }

    @Then("{I }'$should' see project number auto filled as '$projectName'")
    public void checkProjectNumber(String should,String projectName){
        AdCostsDetailsPage costDetailsPage = getSut().getPageCreator().getAdCostsCostDetailsPage();
        String expected = getProjectNumber(wrapVariableWithTestSession(projectName));
        String actual = costDetailsPage.getFieldValueInCostDetailsSection("Project Number");
        assertThat(actual,should.equals("should")?is(expected):not(is(expected)));
    }

    @Given("{I |}edited cost for cost title '$costTitle' with following CostDetails:$data")
    @When("{I |}edit cost for cost title '$costTitle' with following CostDetails:$data")
    public void editCostDetails(String costTitle, ExamplesTable data){
        fillCostDetailFieldsViaUI(data).clickBtnByName("Continue");

    }

    @Then ("{I |}'$condition' able to edit the currency field on cost detail page for costTitle '$costTitle'")
    public void checkCurrencyFieldEditableOrNot(String condition, String costTitle){
        AdCostsDetailsPage costDetailsPage = openCostDetailPage(costTitle);
        assertThat("Check currency field is editable: ", costDetailsPage.verifyCurrencyFieldIsEditable(), is(condition.equalsIgnoreCase("should")));

    }

    @Then ("{I |}'$condition' able to edit the '$fieldName' field on cost detail page for costTitle '$costTitle'")
    public void checkFieldsEditableOrNot(String condition, String fieldName, String costTitle){
        AdCostsDetailsPage costDetailsPage = getSut().getPageCreator().getAdCostsCostDetailsPage();
        assertThat("Check currency field is editable: ", costDetailsPage.verifyFieldsAreEditableOnCostDetailPage(fieldName), is(condition.equalsIgnoreCase("should")));

    }

    @Then ("{I |}'$condition' see following project Number '$projName' on cost details page")
    public void checkPeojectNumberOnCostdetailPage(String condition, String projName){
        AdCostsDetailsPage costDetailsPage = getSut().getPageCreator().getAdCostsCostDetailsPage();
        String projectName = getProjectByName(projName);
        boolean projectExistInCM=true;
        if(projectName==null) {
            projectExistInCM = false;
            assertThat("Check project : "+projName+ " exists in CostModule: ", projectExistInCM, is(condition.equalsIgnoreCase("should")));
        }else {
            String projectNumber = getProjectNumber(projectName);
            if (projectNumber == null)
                throw new Error("Unable to retrieve Project Number for Project: " + projectName);
            assertThat("Check project# " +projectNumber+ " found in dropdown of cost detail page: ", costDetailsPage.checkProjectIdOnCostDetailPage("Project#", projectNumber), is(condition.equalsIgnoreCase("should")));
        }
    }
}