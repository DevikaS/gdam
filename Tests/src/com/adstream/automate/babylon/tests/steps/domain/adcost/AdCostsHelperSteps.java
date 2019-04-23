package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.TestDataContainer;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsAdminUserAccessPage;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsDetailsPage;
import com.adstream.automate.babylon.sut.pages.adcost.BaseAdCostPage;
import com.adstream.automate.babylon.sut.pages.adcost.elements.StepsAdCostType;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import com.google.api.client.json.Json;
import com.google.gson.*;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.openqa.selenium.TimeoutException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

/**
 * Created by Raja.Gone on 24/04/2017.
 */
public class AdCostsHelperSteps extends BaseStep{

    protected final long timeOut = 1500; //2 sec
    protected final long globalTimeout= 5 * 60 * 1000; // 5 min
    private String ioNumberOwner = "autoTeam@amazingAdstreamQAteam.com";
    private static String adcostUserId;
    private static String mockedAMQComment = "Please change all post production cost line items";

    public static String getMockedAMQComment() {
        return mockedAMQComment;
    }

    public static void setMockedAMQComment(String mockedAMQComment) {
        AdCostsHelperSteps.mockedAMQComment = mockedAMQComment;
    }

    public String getIoNumberOwner() {
        return ioNumberOwner;
    }

    public void setIoNumberOwner(String ioNumberOwner) {
        this.ioNumberOwner = ioNumberOwner;
    }

    public void closeWakeMe(){
        BaseAdCostPage adCostsDetailsPage = new BaseAdCostPage(getSut().getWebDriver());
        adCostsDetailsPage.closeWakeMePopUp();
    }

    // | Continue | Previous | Add Travel |
    @Given("{I |}clicked '$buttonName' button on Adcost system page")
    @When("{I |}click '$buttonName' button on Adcost system page")
    public void clickButtonName(String btnName) {
        BaseAdCostPage basePage = new BaseAdCostPage(getSut().getWebDriver());
        basePage.clickBtnByName(btnName);
    }

    @Given("{I |}clicked '$buttonName' button on Adcost form page")
    @When("{I |}click '$buttonName' button on Adcost form page")
    public void clickButtonNameOnFormPage(String btnName) {
        BaseAdCostPage basePage = new BaseAdCostPage(getSut().getWebDriver());
        basePage.clickBtnByNameOnFormPage(btnName);
    }

    @Given("{I |}selected '$sectionName' tab from left side navigation")
    public void selectSectionNav(String sectioName){
        BaseAdCostPage basePage = new BaseAdCostPage(getSut().getWebDriver());
        basePage.selectLHSNav(sectioName);
    }
    // switchCase: | BusinessUnits | Users | Projects |
    @Given("{I |}waited until following '$switchCase' replicated to Cost Module: $data")
    public void waitUntilReplicationToCostModule(String switchCase, ExamplesTable data){
        switch (switchCase) {
            case "BusinessUnits":
                for (int i = 0; i < data.getRowCount(); i++) {
                    Map<String, String> row = parametrizeTabularRow(data, i);
                    Agency agency = null;
                    if ((row.get("AgencyUnique") != null) && (!row.get("AgencyUnique").isEmpty()))
                        agency = getAgencyByName(row.get("AgencyUnique"));
                    if ((row.get("Agency")!= null) && (!row.get("Agency").isEmpty()))
                        agency = getData().getAgencyByName(row.get("Agency"));
                    String agencyId = agency.getId();
                    long start = System.currentTimeMillis();
                    do {
                        if (timeOut > 0)
                            Common.sleep(timeOut * 1);
                    } while (!checkForBuReplication(agencyId) && System.currentTimeMillis() - start < globalTimeout);
                    if (System.currentTimeMillis() - start > globalTimeout)
                        throw new TimeoutException("Timeout:: Business Unit ID '" + agencyId + "' not found in Cost Module!!");
                } break;
            case "Users":
                String agencyId = null;
                String userId = null;
                User user = null;
                for (int i = 0; i < data.getRowCount(); i++) {
                    Map<String, String> row = parametrizeTabularRow(data, i);
                    long start = System.currentTimeMillis();
                    if (row.containsKey("Email")) {
                        user = getCurrentUser(row.get("Email"));
                        do {
                            if (timeOut > 0)
                                Common.sleep(timeOut * 1);
                        }
                        while (!checkForUserReplication(user.getAgency().getId(), user.getEmail()) && System.currentTimeMillis() - start < globalTimeout);
                    }
                    if (System.currentTimeMillis() - start > globalTimeout)
                        throw new TimeoutException("Timeout:: User with '" + user.getEmail() + "' not found in Cost Module!!");
                } break;
            case "Projects":
                Project project = null;
                for (int i = 0; i < data.getRowCount(); i++) {
                    Map<String, String> row = parametrizeTabularRow(data, i);
                    long start = System.currentTimeMillis();
                    if (row.containsKey("Name")) {
                        do {
                            if (timeOut > 0)
                                Common.sleep(timeOut * 1);
                        }
                        while (!checkForProjectReplication(row.get("Name")) && System.currentTimeMillis() - start < globalTimeout);
                    }
                    if (System.currentTimeMillis() - start > globalTimeout)
                        throw new TimeoutException("Timeout:: Project with '" + row.get("Name") + "' not found in Cost Module!!");
                } break;
        }
    }

    @Given("{I |}wait until cost status is '$costStatus' and cost stage is '$costStage' for cost title '$costTitle'")
    @When("{I |}wait until cost status is '$costStatus' and cost stage is '$costStage' for cost title '$costTitle'")
    public void waitUntilCorrectStatusAndStage(String costStatus,String costStage, String costTitle){
        String stage= null;
        String status = null;
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 1);
            List<String> details = getCostStageAndStatus(wrapVariableWithTestSession(costTitle));
            if(details.get(0).equalsIgnoreCase(costStage) && details.get(1).equalsIgnoreCase(costStatus))
                break;
        }while(System.currentTimeMillis() - start < globalTimeout);
        if (System.currentTimeMillis() - start > globalTimeout)
            throw new TimeoutException("Timeout:: Check CostStage & CostStatus for cost title '"+wrapVariableWithTestSession(costTitle)+"'");
    }

    public User getCurrentUser(String userName){
        User user = getData().getUserByType(userName);
        User currentUser = null;
        if (user == null) {
            userName = wrapUserEmailWithTestSession(userName);
            currentUser = getCoreApiAdmin().getUserByEmail(userName);
        }
        return currentUser;
    }

    public String getUsersFullName(String userName){
        if(!(userName.equals("") || userName.isEmpty() || userName.equals(null)))
            return getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName), 0).getFullName();
        throw new Error("Not valid cost creator name, Please check: "+userName);
    }

    private Boolean checkForBuReplication(String agencyId){
        Agencies[] agencies = getAdcostCoreAdminApi().getAgencyIdInCostModule();
        for(Agencies agency:agencies)
            if(agency.getGdamAgencyId().equals(agencyId)) {
                  return true;
            }
        return false;
    }

    private Boolean checkForUserReplication(String agencyId,String email){
        CostUser users = getCoreApiDefaultAdmin().searchUserByAgencyID(email);
        CostUsers[] costUsers = users.getUsers();
        for(CostUsers user:costUsers)
            if(user.getEmail().equalsIgnoreCase(email))
                return true;
        return false;
    }

    public void clickButtonName(String btnName,String parentLocator) {
        BaseAdCostPage basePage = new BaseAdCostPage(getSut().getWebDriver());
        basePage.clickBtnByName(btnName,parentLocator);
    }

    public static String getCurrentUserID(){
        BaseAdCostPage page = new BaseAdCostPage(getSut().getWebDriver());
        adcostUserId = page.getUserId();
        return adcostUserId;
    }

    public String getAdCostType(String costType) {
        if (costType.equalsIgnoreCase(StepsAdCostType.PRODUCTION.toString()))
            return "CREATE NEW PRODUCTION COST";
        else if (costType.equalsIgnoreCase(StepsAdCostType.BUYOUT.toString()))
            return "CREATE NEW USAGE/BUYOUT COST";
        else
            throw new IllegalArgumentException("Unknown AdCost type: " + costType);
    }

    protected DateTime parseDateWithUTCZone(String date) {
        return DateTimeUtils.parseDateWithUTCZone(date, getContext().userDateTimeFormat);
    }

    protected String getCostId(String costTitle){
        Costs[] costs = getAdcostApi().getCosts().getCosts();
        for(Costs cost:costs){
            if(!(cost.getTitle()==null))
            if(cost.getTitle().equalsIgnoreCase(costTitle)){
                return cost.getId();
            }
        }
        throw new IllegalArgumentException("Check CostTitle, unable to find: "+costTitle);
    }

    public Costs getCostDetails(String costTitle){
        Costs[] costs = getAdcostApi().getCosts().getCosts();
        for(Costs cost:costs){
            if(!(cost.getTitle()==null))
            if(cost.getTitle().equalsIgnoreCase(costTitle)){
                return cost;
            }
        }
        throw new IllegalArgumentException("Check CostTitle, unable to find: "+costTitle);
    }

    protected Costs getCostDetailsAsGovernanceManager(String costTitle){
        Costs[] costs = getAdcostCoreAdminApi().getCosts().getCosts();
        for(Costs cost:costs){
            if(!(cost.getTitle()==null))
                if(cost.getTitle().equalsIgnoreCase(costTitle)){
                    return cost;
                }
        }
        throw new IllegalArgumentException("Check CostTitle, unable to find: "+costTitle);
    }

    protected BudgetRegions getBudgetRegionId(String budgetRegion){
//        BudgetRegions[] region = getAdcostApi().getBudgetRegions();
          BudgetRegions[] region = getAdcostCoreAdminApi().getBudgetRegions();
        for (BudgetRegions budget : region){
            if (budget.getName().equals(budgetRegion))
                return budget;

            }
        throw new IllegalArgumentException("Check 'Budget Region', found unknown Budget Region: "+budgetRegion);
    }

    protected SmoOrganisations getSmoOrganisations(String budgetRegionId, String SmoOrganisation){
        SmoOrganisations[] smo = getAdcostApi().getSmoOrganisations(budgetRegionId);
        for (SmoOrganisations org : smo){
            if (org.getName().equals(SmoOrganisation))
                return org;
        }
        throw new IllegalArgumentException("Check 'SMO Organisation', found unknown SMOOrganisation: "+SmoOrganisation);
    }

    public String getCostStageId(String costId) {
        return getAdcostApi().getCostStage(costId).getId();
    }

    public String getCostRevisionId(String costId, String costStageId) {
        return getAdcostApi().getCostStageRevision(costId, costStageId).getId();
    }

    protected String buildCostPageURL(String costTitle){
        String costId = getCostId(costTitle);
        String costStageId = getCostStageId(costId);
        String costRevisionId = getCostRevisionId(costId,costStageId);
        StringBuilder urlBuilder = new StringBuilder();
        urlBuilder.append("costId=").append(costId).append("&revisionId=").append(costRevisionId);
        return urlBuilder.toString();
    }

    protected void checkForDuplicateTravellerName(TravelDetails travelDetails){
        int counter=0;
        TravelDetails[] details = getAdcostApi().getTravelCostDetails(travelDetails);
        for(TravelDetails detail:details){
            if(detail.getName().equalsIgnoreCase(travelDetails.getName())){
                counter++;
            }
        }
        if(counter==0) throw new AssertionError("Couldn't found any Travel Costs with 'Traveler name': "+travelDetails.getName());
        else if(counter>1) throw new AssertionError("Ambiguity: Found multiple Travel Costs with same 'Traveler name': "+travelDetails.getName()+"'. For obvious reasons traveller name should be unique");
    }

    protected Double getExchangeRate(String currencyCode, String costId){
        for(AdcostCurrency currency:getAdcostApi().getAdcostCurrnecy()){
            if(currency.getCode().equals(currencyCode)) {
                for(ExchangeRates rates:getAdcostApi().getExchangeRates(costId)){
                    if(rates.getId().equals(currency.getId())){
                        return rates.getRate();
                    }}
            }
        }
        throw new IllegalArgumentException("Check CostTitle, unable to find currency for currencyCode: "+currencyCode);
    }

    protected TravelRegions getRegionByName(String regionName){
        TravelRegions[] regions = getAdcostApi().getTravelRegions();
        for(TravelRegions region:regions){
            if(region.getName().equalsIgnoreCase(regionName)){
                return region;
            }
        }
        throw new IllegalArgumentException("Check 'Region of travel', found unknown region name: "+regionName);
    }

    protected String getPerDiemsCost(String shootCity){
        PerDiems[] perDiems = getAdcostApi().getTravelPerDiems();
        for(PerDiems diems:perDiems){
            if(diems.getShootCity().equalsIgnoreCase(shootCity)){
                return diems.getCost();
            }
        }
        throw new IllegalArgumentException("Check 'Shoot City', found unknown City: "+shootCity);
    }

    protected TravelCountry getCountryDetails(String countryName){
        TravelCountry[] countries = getAdcostApi().getTravelCountry();
        for(TravelCountry country:countries){
            if(country.getName().equalsIgnoreCase(countryName)){
                return country;
            }
        }
        throw new IllegalArgumentException("Check 'Country of travel', found unknown Country name: "+countryName);
    }

    protected TravelDetails getTravelCostDetails(TravelDetails travelDetails){
        TravelDetails[] details = getAdcostApi().getTravelCostDetails(travelDetails);
        for(TravelDetails detail:details){
            if(detail.getName().equalsIgnoreCase(travelDetails.getName())){
                return detail;
            }
        }
        return null;
    }

    protected String getFormDefinitionId(String costType, String page){
        for (CostTemplates temp : getAdcostApi().getCostTemplates())
            if (temp.getCostType().equals(costType)) {
                for (Versions versions : temp.getVersions())
                    for (Forms forms : versions.getForms())
                        if (forms.getLabel().contains(page))
                            return forms.getId();
            }
        return  null;
    }


    protected  DictionaryEntries getTravellerRole(String role){
        AdcostDictionaries[] dictionaries = getAdcostApi().getTravellerRole();
        for(AdcostDictionaries dic:dictionaries){
            DictionaryEntries[] entries = dic.getDictionaryEntries();
            for(DictionaryEntries entry:entries)
                if(entry.getValue().equals(role))
                    return entry;
        }
        throw new IllegalArgumentException("Unknown Role Name: "+role);
    }

    protected boolean CheckIfTravelDetailsAlreadyExists(TravelDetails details){
        TravelDetails detail = getTravelCostDetails(details);
        if(detail !=null)
            if(detail.getName().equals(details.getName()))
                throw new IllegalArgumentException("Traveller Name already exists. Please provide a unique name: "+details.getName());
        return true;
    }

    protected String checkDirectorName(String directorName){
        AdcostDictionaries[] dictionaries=getAdcostApi().getDirectorName();
        for(AdcostDictionaries dic:dictionaries){
            DictionaryEntries[] entries = dic.getDictionaryEntries();
            for(DictionaryEntries entry:entries)
                if(entry.getValue().equals(directorName))
                    return entry.getValue();
        }
        throw new IllegalArgumentException("Unknown Director Name: "+directorName);
    }

    protected String checkPhotographerName(String photographerName){
        AdcostDictionaries[] dictionaries=getAdcostApi().getPhotographerName();
        for(AdcostDictionaries dic:dictionaries){
            DictionaryEntries[] entries = dic.getDictionaryEntries();
            for(DictionaryEntries entry:entries)
                if(entry.getValue().equals(photographerName))
                    return entry.getValue();
        }
        throw new IllegalArgumentException("Unknown Photographer Name: "+photographerName);
    }

    protected Vendors loadVendorDetails(String vendorName){
        Vendors[] vendors= getAdcostApi().getVendors(vendorName).getVendors();
        for(Vendors vendor:vendors){
            if(vendor.getName().equals(vendorName)){
                return vendor;
            }
        }
        throw new IllegalArgumentException("Unknown Vendor Name: "+vendorName);
    }

    protected Vendors loadVendorListPerProductionCategory(String productionCategory,String vendorName){
        Vendors[] vendors = getAdcostApi().getVendorListPerProductionCategory(productionCategory);
        Common.sleep(1000);
        for(Vendors vendor:vendors) {
            if (vendor.getName().equals(vendorName)) {
                Vendors ven = getAdcostApi().getVendorDetails(vendor.getId());
                List<VendorCategoryModels> vendorCategoryModelses = ven.getVendorCategoryModels();
                for (VendorCategoryModels models : vendorCategoryModelses)
                    if (models.getName().equals(productionCategory.concat("Company")))
                        return vendor;
            }
            if(vendor.getName().equals(wrapVariableWithTestSession(vendorName))){
                Vendors ven = getAdcostApi().getVendorDetails(vendor.getId());
                List<VendorCategoryModels> vendorCategoryModelses = ven.getVendorCategoryModels();
                for (VendorCategoryModels models : vendorCategoryModelses)
                    if (models.getName().equals(productionCategory.concat("Company")))
                        return vendor;
            }
        }
        throw new IllegalArgumentException(vendorName+" vendor not found under 'Production Category' Name: "+productionCategory);
    }

    protected Vendors loadVendorListPerNonProductionost(String productionCategory,String vendorName){
        Vendors[] vendors = null;
        if ((productionCategory.contains("Usage"))|| (productionCategory.contains("Trafficking")))
            vendors = getAdcostApi().getVendorListforNonProductionCost(productionCategory);
        Common.sleep(1000);
        for(Vendors vendor:vendors) {
            if(vendor.getName().equals(wrapVariableWithTestSession(vendorName))){
                Vendors ven = getAdcostApi().getVendorDetails(vendor.getId());
                List<VendorCategoryModels> vendorCategoryModelses = ven.getVendorCategoryModels();
                for (VendorCategoryModels models : vendorCategoryModelses)
                    if (models.getName().equals(productionCategory))
                        return vendor;
            }
        }
        throw new IllegalArgumentException(vendorName+" vendor not found under 'Production Category' Name: "+productionCategory);
    }

    protected VendorCategoryModels getVendorCategoryModels(String productionCategory,Vendors vendor){
        Vendors ven = getAdcostApi().getVendorDetails(vendor.getId());
        List<VendorCategoryModels> vendorCategoryModelses = ven.getVendorCategoryModels();
        for (VendorCategoryModels models : vendorCategoryModelses)
            if (models.getName().equals(productionCategory.concat("Company")))
                return models;
        throw new IllegalArgumentException("Couldn't found Vendor details for 'Production Category': "+productionCategory);
    }

    protected String getInitiativeName(String initiative){
        AdcostDictionaries[] dictionaries=getAdcostApi().getInitiatives();
        for(AdcostDictionaries dic:dictionaries){
            DictionaryEntries[] entries = dic.getDictionaryEntries();
            for(DictionaryEntries entry:entries)
                if(entry.getValue().equals(initiative))
                    return entry.getValue();
        }
        throw new IllegalArgumentException("Unknown Initiative Name: "+initiative);
    }

    protected String getDictionaryValueByName(String dictionaryName, String dictionaryValue){
        AdcostDictionaries[] dictionaries=getAdcostDictionaryByName(dictionaryName);
        for(AdcostDictionaries dic:dictionaries){
            DictionaryEntries[] entries = dic.getDictionaryEntries();
            for(DictionaryEntries entry:entries)
                if(entry.getValue().equals(dictionaryValue))
                    return entry.getValue();
        }
        throw new IllegalArgumentException("Unknown Dictionary Name: "+dictionaryName);
    }

    protected DictionaryEntries getDictionaryEntriesIdByName(String dictionaryName, String dictionaryValue){
        AdcostDictionaries[] dictionaries=getAdcostDictionaryByName(dictionaryName);
        for(AdcostDictionaries dic:dictionaries){
            DictionaryEntries[] entries = dic.getDictionaryEntries();
            for(DictionaryEntries entry:entries)
                if(entry.getValue().equals(dictionaryValue))
                    return entry;
        }
        throw new IllegalArgumentException("Unknown Dictionary Name: "+dictionaryName);
    }

    protected AdcostDictionaries[] getAdcostDictionaryByName(String dictionaryName){
        return getAdcostApi().getAdcostDictionaryByName(dictionaryName);
    }

    protected DictionaryEntries getAdcostDictionaryEntryByName(String dictionaryName, String dictionaryValue){
        AdcostDictionaries[] dictionaries=getAdcostDictionaryByName(dictionaryName);
        for(AdcostDictionaries dic:dictionaries){
            DictionaryEntries[] entries = dic.getDictionaryEntries();
            for(DictionaryEntries entry:entries)
                if(entry.getValue().equals(dictionaryValue))
                    return entry;
        }
        throw new IllegalArgumentException("Unknown Dictionary Name: "+dictionaryName);
    }

    protected boolean checkDateFormatINddMMyyyy(String date){
        DateTimeFormat.forPattern("dd/MM/yyyy").parseDateTime(date);
        return true;
    }

    protected  DictionaryEntries getShootCity(String shootCity){
        AdcostDictionaries[] dictionaries = getAdcostApi().getShootCity();
        for(AdcostDictionaries dic:dictionaries){
            DictionaryEntries[] entries = dic.getDictionaryEntries();
            for(DictionaryEntries entry:entries)
                if(entry.getValue().contains(shootCity))
                    return entry;
        }
        throw new IllegalArgumentException("Unknown Shoot City: "+shootCity);
    }

    protected String getUserIdInCostModule(String agencyId,String email){
        return getCostUserDetails(agencyId,email).getId();
    }

    protected CostUsers getCostUserDetails(String agencyId,String email){
        CostUser users = getCoreApiDefaultAdmin().searchUserByAgencyID(email);
        CostUsers[] costUsers = users.getUsers();
        for(CostUsers user:costUsers)
            if(user.getEmail().equalsIgnoreCase(email))
                return user;
        throw new IllegalArgumentException("Check if user with email: "+email+" replicated to cost module");
    }

    protected  String getBusinessRoleId(String userRole) {
        UserRoles[] userRoles = getAdcostCoreAdminApi().getBusinessRoles();
        for (UserRoles role : userRoles)
            if (role.getKey().equalsIgnoreCase(userRole)) {
                return role.getId();
            }
        throw new IllegalArgumentException("Couldn't found BusinessUserRole in Cost Module: " + userRole);
    }

    protected String getAgencyIdInCostModule(String agencyId){
        Agencies[] agencies = getAdcostCoreAdminApi().getAgencyIdInCostModule();
        for(Agencies agency:agencies)
            if(agency.getGdamAgencyId().equals(agencyId))
                return agency.getId();
        throw new IllegalArgumentException("Couldn't found Agency in Cost Module with GDAM AgencyId: "+agencyId);
    }

    public List<String> getCostStageAndStatus(String costTitle){
        String respone = getAdcostApi().getCostsAsString(costTitle);
        List<String> details = new ArrayList<String>();
        JsonObject jObj = new JsonParser().parse(respone).getAsJsonObject();
        JsonArray jArray = jObj.get("costs").getAsJsonArray();

        for(JsonElement element: jArray){
            JsonObject jObject = element.getAsJsonObject();
            if(jObject.get("title").getAsString().equalsIgnoreCase(costTitle)) {
                details.add(jObject.get("stage").getAsString());
                details.add(jObject.get("status").getAsString());
                break;
            }
        }
        return details;
    }

    @Then("{I |}'$condition' see admin section on toolbar")
    public void checkAdminSection(String condition){
        BaseAdCostPage adCostsDetailsPage = new BaseAdCostPage(getSut().getWebDriver());
        assertThat("Check Admin tab on toolbar: ", adCostsDetailsPage.isAdminTabPresent(), is(condition.equalsIgnoreCase("should")) );
    }

    private Boolean checkForProjectReplication(String projectName){
        String gdamProjectId = getCoreApi().getProjectByName(projectName).getId();
        ProjectSearch[] projectSearch=getAdcostApi().getProjectNumber(gdamProjectId);
        for(ProjectSearch project:projectSearch){
            if(project.getGdamProjectId().equals(gdamProjectId))
                return true;
        }
        return  false;
    }

    public String getUserRoleInCostModule(String userEmail){
        return getAdcostCoreAdminApi().getUserRoleInCostModule(userEmail);
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
}
