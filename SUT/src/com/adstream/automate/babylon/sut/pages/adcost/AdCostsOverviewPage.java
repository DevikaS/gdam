package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Raja.Gone on 21/04/2017.
 */
public class AdCostsOverviewPage extends BaseAdCostPage<AdCostsOverviewPage> {

    private Button createCostsButtonLocator;
    private static final By costsDropDownLocator = By.cssSelector(".icon-arrow.ng-binding.ng-isolate-scope");
    private String listBoxFormat = "//*[contains(@placeholder,'%s')][@role='listbox']";
    private String listBoxValueFormat = "//md-content[@class='_md']/div/md-option/div";
    private String costTabFormat = "//nav[@role='navigation']//li[@name='%s']";
    private String filterCostPageLocator="//*[@md-component-id='filterMenu']";
    private String closeFilterCostsSection = "//span[@role='button'][@code='menu']";

    private String textFieldLocatorFormat = "//input[contains(@id,'input')][@placeholder='%s']";
    private String comboBoxLocatorFormat = "//*[contains(@placeholder,'%s')] [@role='combobox']";
    private String radioButtonsFieldLocatorFormat = "//ads-md-radio-button";

    private String listBoxValueFormat_FilterCosts = "//div[@class=\"md-select-menu-container md-active md-clickable\"]//md-content[@class='_md']//md-option/div";
    private String comboBoxValueFormat = "//ul[@class='md-autocomplete-suggestions']";
    private String costItemsLocator="//div[@class='cost-items']";
    private String costItemRowLocator =costItemsLocator.concat("//div[contains(@class,'cost-items-row')]");
    private String budgetFormTemplateLocator = "//md-option[@value='%s']/div";
    private String createAQuickFilterLocator = "//span[contains(text(),' CREATE A QUICK FILTER')]";
    private String createOrDeleteFilterLocator = "//div[contains(@class,'filterManagementPanel')]//ads-md-button[@aria-label='%s selected custom filter']";


    public AdCostsOverviewPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
        createCostsButtonLocator = new Button(this, By.xpath("//span[@id='create-new-cost-button']"));
    }

    public void waitUntilAdCostsOverviewPageToLoad(){
        web.waitUntilElementAppear(By.xpath("//section[contains(@ng-if,'!costsListCtrl')]"));
    }

    public void clickCostsTab(String header){
        switch (header){
            case "top navbar":
                web.click(By.xpath("//ads-md-nav-item//span[contains(text(),'Costs')]"));
                break;
            case "sub menu":
                web.click(By.xpath("//md-tab-item//span[@class='ng-binding ng-scope'][.='Costs']"));
                break;
            default:
                throw new IllegalArgumentException("Unknown costs tab name: "+header);
        }
    }

    public String getProjectName(){
        return web.findElement(By.xpath("//div[@id='project-navbar-title']")).getText();
    }

    public AdCostsDetailsPage createCosts(String costType) {
        web.findElement(costsDropDownLocator).click();
        web.sleep(500);
        selectCostsType(costType).click();
        web.sleep(500);
        createCostsButtonLocator.click();
        return new AdCostsDetailsPage(web);
    }

    private WebElement selectCostsType(String costName){  return web.findElement(By.xpath(String.format("//button//span[contains(text(),'%s')]", costName)));     }

    public void selectSortByField(String sortName){
        By listBoxLocator = By.xpath(String.format(listBoxFormat,"Sort by"));

        if(web.isElementPresent(listBoxLocator)) {
            web.findElement(listBoxLocator).click();
            for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                if (element.getText().equalsIgnoreCase(sortName)) {
                    element.click();
                    break;
                }
            }
        } else throw new IllegalArgumentException(String.format("Unable to find 'Sort By' field on Costs-Overview page"));
    }

    public void clickCostMenuTab(String tabName){
        By costTabLocator = By.xpath(String.format(costTabFormat,getTabName(tabName)));
        if(web.isElementPresent(costTabLocator))
            web.click(costTabLocator);
        if(tabName.contains("All"))
            web.navigate().refresh();
    }

    private String getTabName(String tabName){
        switch(tabName){
            case "Filter Costs":
                return "costs-list-menu";
            case "All Costs":
                return "all";
            default:
                throw new IllegalArgumentException(String.format("Unknown tab name on Costs-Overview page"));
        }
    }

    public boolean isCreateCostTabVisible() {
        if (web.isElementVisible(By.xpath("//select-action[contains(@class,'ng-scope')]")))
            return true;
        return false;
    }

    public String getFilterCostPageLocator() {
        return filterCostPageLocator;
    }

    public void closeFilterCostsSection(){
        By closeFilterCostsSectionLocator = By.xpath(filterCostPageLocator+closeFilterCostsSection);
        if(web.isElementVisible(closeFilterCostsSectionLocator)) {
            web.findElement(closeFilterCostsSectionLocator).click();
        }
    }

    public void fillFieldByName(String fieldName, String fieldValues,String parentPageLocator) {
        String checkBoxFormat = "/div[contains(text(),'%s')]/./..//div[@class='mediaCheckBox ng-scope']";
        By textFieldLocator = By.xpath(String.format(parentPageLocator+textFieldLocatorFormat, fieldName));
        By comboBoxLocator = By.xpath(String.format(parentPageLocator+comboBoxLocatorFormat, fieldName));
        By radioButtonsFieldLocator = By.xpath(parentPageLocator+radioButtonsFieldLocatorFormat);
        By listBoxLocator = By.xpath(String.format(parentPageLocator+listBoxFormat,fieldName));
        By buttonToClickLocator = By.xpath(String.format(parentPageLocator+buttonNameFormat, fieldName));
        By checkBoxLocator = By.xpath(String.format(parentPageLocator+checkBoxFormat, fieldName));

        for (String fieldValue : fieldValues.split(",")) {
            if(web.isElementPresent(listBoxLocator)) {
                web.findElement(listBoxLocator).click();
                int counter = 0;
                for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        counter++;
                        break;
                    }
                } if(counter==0)
                    for (WebElement element : web.findElements(By.xpath(listBoxValueFormat_FilterCosts))) {
                        if (element.getText().equalsIgnoreCase(fieldValue)) {
                            element.click();
                            break;
                        }
                    }
            } else if (web.isElementPresent(comboBoxLocator)) {
                scrollToFieldName(web.findElement(comboBoxLocator));
                // String s = fieldValue.substring(0,5); // SubString approach to handle ADC-1157
                web.typeClean(comboBoxLocator,fieldValue);
                Common.sleep(1000);
                for (WebElement element : web.findElements(By.xpath(comboBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        break;
                    }
                }
            } else if (web.isElementPresent(textFieldLocator)) {
                WebElement element = web.findElement(textFieldLocator);
                JavascriptExecutor executor =web.getJavascriptExecutor();
                executor.executeScript("arguments[0].scrollIntoView(true);", element);
                web.typeClean(textFieldLocator, fieldValue);
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {
                WebElement element = web.findElement(radioButtonsFieldLocator);
                element.findElement(By.xpath(String.format("//*[@value='%s']", fieldValue))).click();
            } else if(web.isElementPresent(buttonToClickLocator)){
                new Button(this, buttonToClickLocator).click();
            } else if(web.isElementPresent(checkBoxLocator)){
                List<WebElement> elements = web.findElements(checkBoxLocator);
                for(int i=1;i<=elements.size();i++) {
                    String locatorFormat = String.format(parentPageLocator+checkBoxFormat, fieldName).concat("[").concat(Integer.toString(i)).concat("]//");
                    String text = web.findElement((By.xpath(locatorFormat.concat("span[2]")))).getText();
                    if(text.equalsIgnoreCase(fieldValue))
                        web.findElement(By.xpath(locatorFormat.concat("div[@class='md-icon']"))).click();
                }
            }
            else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }

    public CostItemDetails getCostItemDetails(){
        return new CostItemDetails();
    }

    public FiltersSection getFiltersSection(){
        return new FiltersSection();
    }

    public void clickCreateAQuickFilterLocator(){
        web.waitUntilElementAppearVisible(By.xpath(createAQuickFilterLocator));
        web.click(By.xpath(createAQuickFilterLocator));
    }

    public void updateOrDeleteFilter(String action){
        web.click(By.xpath(String.format(createOrDeleteFilterLocator,action)));
    }

    public void searchCostItemByString(String searchString){
        By searchFieldLocator=By.xpath(String.format(textFieldLocatorFormat,"Search for Project ID/Cost Number"));
        web.typeClean(searchFieldLocator, searchString);
        Common.sleep(3000);
    }

    public QuickViewDetails getQuickViewSection(){
        return new QuickViewDetails();
    }


    public class CostItemDetails {

        private String costTitle;
        private String adCostNumber;
        private String costType;
        private String agencyProducer;
        private String costStage;
        private String costStatus;
        private String timeStamp;
        private String budget;
        private String currency;

        public String getTimeStamp() { return timeStamp; }

        public void setTimeStamp(String timeStamp) { this.timeStamp = timeStamp;}

        public String getCostTitle() { return costTitle; }

        public String getAdCostNumber() {
            return adCostNumber;
        }

        public String getCostType() {
            return costType;
        }

        public String getAgencyProducer() {
            return agencyProducer;
        }

        public String getCostStage() {
            return costStage;
        }

        public String getCostStatus() {
            return costStatus;
        }

        public String getBudget() {
            return budget;
        }

        public String getCurrency() {
            return currency;
        }


        public void loadCostItemDetails(int rowCount) {
            costTitle = web.findElement(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//*[@class='title force-word-wrap ng-binding']"))).getText().trim();
            String[] temp = web.findElement(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//a"))).getText().trim().split("-");
            adCostNumber = temp[0].trim();
            costType = temp[1].trim();
            agencyProducer = web.findElement(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//*[@class='truncate agency ng-binding']"))).getText().trim();
            costStage = web.findElement(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//*[contains(@class,'cost-status')]/div[2]/div/div[2]/div[1]"))).getText().trim();
            costStatus = web.findElement(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//*[contains(@class,'cost-status')]//p"))).getText().trim();
            timeStamp = web.findElement(By.cssSelector(".cost-modified")).getText();
            String[] tempBudget = web.findElement(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//div[contains(@class,'heading cost-value')]//p"))).getText().trim()
                    .split("\\)");
            currency = tempBudget[0].substring(1);
            budget = tempBudget[1].trim();
        }

        public void loadCostTitle(int rowCount){
            costTitle = web.findElement(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//*[@class='title force-word-wrap ng-binding']"))).getText().trim();
        }

        public int getCostItemsRowCount() {
            return web.findElements(By.xpath(costItemRowLocator)).size();
        }

        public void OpenCostItemByCostTitle(int rowCount) {
            web.findElement(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//a"))).click();
        }

        public void selectOptionForCostItem(String action, int rowCount) {
            checkActionNameForCost(action);
            if (action.equalsIgnoreCase("Open"))
                OpenCostItemByCostTitle(rowCount);
            else
                web.click(By.xpath(costItemRowLocator.concat("[" + rowCount + "]//md-icon")));
        }

        public boolean checkIfCostItemsExistedOnPage() {
            if (web.isElementPresent(By.xpath("//h1[contains(text(), 'No costs found')]")))
                return false;
            return true;
        }

        private boolean checkActionNameForCost(String action) {
            switch (action) {
                case "Open":
                    return true;
                case "Recall Cost":
                    return true;
                case "Cancel Cost":
                    return true;
                case "Delete Cost":
                    return true;
                case "Reopen":
                    return true;
                case "Request Changes":
                    return true;
                case "Quick View":
                    return  true;
                case "Request Reopen":
                    return true;
                case "Approve Reopen":
                    return true;
                case "Reject Reopen":
                    return true;
                default:
                    throw new IllegalArgumentException("Unknown option for Cost-Item: " + action);
            }
        }
    }

    public class QuickViewDetails {
        private String costTitle;
        private String description;
        private String costOwner;
        private String costStage;
        private String costStatus;
        private String company;
        private String brand;
        private String campaign;
        private String agency;
        private String project;
        private String assignedTill;

        public String getCostTitle() {
            return costTitle;
        }
        public void setCostTitle(String costTitle) { this.costTitle = costTitle; }

        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description;   }

        public String getCostOwner() { return costOwner; }
        public void setCostOwner(String costOwner) { this.costOwner = costOwner;   }

        public String getCostStage() {
            return costStage;
        }
        public void setCostStage(String costStage) {
            this.costStage = costStage;
        }

        public String getCostStatus() {
            return costStatus;
        }
        public void setCostStatus(String costStatus) {
            this.costStatus = costStatus;
        }

        public String getCompany() {
            return company;
        }
        public void setCompany(String company) {
            this.company = company;
        }

        public String getBrand() {
            return brand;
        }
        public void setBrand(String brand) {
            this.brand = brand;
        }

        public String getCampaign() {
            return campaign;
        }
        public void setCampaign(String campaign) {
            this.campaign = campaign;
        }

        public String getAgency() {
            return agency;
        }
        public void setAgency(String agency) { this.agency = agency;}

        public String getProject() { return project; }
        public void setProject(String project) { this.project = project;   }

        public String getAssignedtill() { return assignedTill; }
        public void setAssignedTill(String assignedTill) { this.assignedTill = assignedTill;   }

        public void loadQuickViewSection() {
            costTitle = web.findElement(By.xpath("//*[@id=\"cl-title\"]")).getText().trim();
            description= web.findElement(By.xpath("//*[@id=\"cl-description-section\"]/div/p")).getText().trim();
            costStage= web.findElement(By.xpath("//*[@id=\"cl-stage-label\"]")).getText().trim();
            costOwner = web.findElement(By.xpath("//*[contains(@class,\"CostNavOwners\")]//div[@class='heading costNavOwner ng-binding']")).getAttribute("title").trim();
            costStatus= web.findElement(By.xpath("//*[@id=\"cl-stage-section\"]/div/div[2]/span")).getText().trim();
            company= web.findElement(By.xpath("//*[@id=\"cl-details-company-section\"]/div/div[2]/div")).getText().trim();
            brand= web.findElement(By.xpath("//*[@id=\"cl-details-brand-section\"]/div/div[2]/div")).getText().trim();
            campaign= web.findElement(By.xpath("//*[@id=\"cl-details-campaign-section\"]/div/div[2]/div")).getText().trim();
            agency= web.findElement(By.xpath("//*[@id=\"cl-details-agency-section\"]/div/div[2]/div")).getText().trim();
            project = web.findElement(By.xpath("//*[@id=\"cl-details-project-section\"]/div/div[2]/div")).getText().trim();
        }

        public List<String> loadQuickViewHistoryData() {
            List<String> allHistoryDetails = new ArrayList<>();
            String rowLocator = "//*[@id='cl-history-section']//*[@id='cl-details-company-section']";
            for(int i=2; i<=web.findElements(By.xpath(rowLocator)).size(); i++){
                assignedTill = "";
                costOwner = web.findElement(By.xpath(String.format(rowLocator.concat("[" + i + "]").concat("//div[1]//span")))).getText();
                if(web.isElementVisible(By.xpath(String.format(rowLocator.concat("[" + i + "]").concat("//div[2]//div"))))) {
                    assignedTill = web.findElement(By.xpath(String.format(rowLocator.concat("[" + i + "]").concat("//div[2]//div")))).getText();
                }
                if (!assignedTill.isEmpty())
                    allHistoryDetails.add(costOwner.concat(";").concat(assignedTill));
                else
                    allHistoryDetails.add(costOwner);
            }
         return allHistoryDetails;
        }

        public boolean checkEditCostownerIconPresent(){
            return (web.isElementVisible(By.xpath("//span[contains(@class,'cost-owner-edit icon-')]")));
        }

        public void updateCostOwner(String cOwner){
            By locator = By.xpath("//md-dialog-content//md-autocomplete-wrap//input[@placeholder='Cost Owner Name']");
            web.click(By.xpath("//span[contains(@class,'cost-owner-edit icon-')]"));
            web.sleep(300);
            web.waitUntilElementAppearVisible(locator);
            for (int i = 0; i < cOwner.length(); i++){
                char c = cOwner.charAt(i);
                String s = new StringBuilder().append(c).toString();
                web.findElement(locator).sendKeys(s);
                Common.sleep(100);
            }
//            web.typeClean(locator,cOwner);
//            if(!web.isElementVisible(By.xpath("//md-virtual-repeat-container//ul/li[@role='button']//span"))) {
//                web.findElement(locator).clear();
//                web.findElement(locator).sendKeys(cOwner);
//                web.waitUntilElementAppearVisible(By.xpath("//md-virtual-repeat-container//ul/li[@role='button']//span"));
//            }
            for(WebElement option : web.findElements(By.xpath("//md-virtual-repeat-container//ul/li[@role='button']//span"))){
                if(option.getText().equals(cOwner)) {
                    web.clickThroughJavascript(option);
                    web.sleep(300);//to slow down
                    clickBtnByName("Save");
                    web.sleep(300);
                    break;
                }
            }
        }

        public boolean checkUpdatedCostownerPresent(String cOwner){
            return (web.isElementVisible(By.xpath(String.format("//*[contains(@class,'CostNavOwners')]//div[contains(text(),'%s')]", cOwner))));
        }

        public boolean isUserNameHighlighted(String userFullName, int userCounter){
           WebElement ele = web.findElement(By.xpath(String.format("//*[@id='cl-history-section']//*[@id='cl-details-company-section']".concat("[" + userCounter + "]").concat("//div[1]//span"))));
           return (ele.getCssValue("font-weight").equals("700"));
        }

        public List<String> checkUsersUnderCostOwner(){
            By locator = By.xpath("//md-dialog-content//md-autocomplete-wrap//input[@placeholder='Cost Owner Name']");
            web.click(By.xpath("//span[contains(@class,'cost-owner-edit icon-')]"));
            web.sleep(500);
            web.waitUntilElementAppearVisible(locator);
            web.click(locator);
            web.findElement(locator).sendKeys(Keys.ENTER);
            web.sleep(2000);
            return web.findElementsToStrings(By.xpath("//md-virtual-repeat-container//ul/li[@role='button']//span"));
        }

        public  void clockQuickViewPopUp(){
            if(web.isElementVisible(By.xpath("//ads-md-button[@id='cl-close-button']//button")))
                web.click(By.xpath("//ads-md-button[@id='cl-close-button']//button"));
        }

        public boolean isUserAvailableInCostOwnerDropDown(String userName){
                By locator = By.xpath("//md-dialog-content//md-autocomplete-wrap//input[@placeholder='Cost Owner Name']");
                web.click(By.xpath("//span[contains(@class,'cost-owner-edit icon-')]"));
                web.sleep(300);
                web.waitUntilElementAppearVisible(locator);
                web.findElement(locator).sendKeys(Keys.ENTER);
                web.findElement(locator).sendKeys(userName.substring(0,7));
                web.sleep(500);
                web.waitUntilElementAppearVisible(By.xpath("//md-virtual-repeat-container//ul/li[@role='button']//span"));
                for(WebElement option : web.findElements(By.xpath("//md-virtual-repeat-container//ul/li[@role='button']//span"))) {
                    if (option.getText().equals(userName))
                        return true;
                }

                return false;
        }
    }

    public String checkValuesInBudgetFormDropDown(String fieldName){
        //String templateName = fieldName.replaceAll("\\s","").replaceAll("-","");
        String templateName=null;
        if(fieldName.contains("Video")){
            //VideoFullProductionAllSummary
            String[] temp = fieldName.split("production");
            templateName = (temp[0].replaceAll("\\s","").replaceAll("-","").trim()).concat("ProductionAll").concat(temp[1].replaceAll("\\s","").replaceAll("-","").trim());
        }else
           templateName = fieldName.replaceAll("\\s","").replaceAll("-","");

        By budgetTemplateLocator = By.xpath(String.format(budgetFormTemplateLocator,templateName));
      //  web.findElement(By.xpath("//md-select[@placeholder='Budget Forms']")).click();
        if(web.isElementVisible(budgetTemplateLocator))
            return web.findElement(budgetTemplateLocator).getText();
        return null;
    }

    public void clickOnBudgetFormDropdown(){
        web.findElement(By.xpath("//md-select[@placeholder='Budget Forms']")).click();
    }

    public int getCostItemsCount() {
        if (web.isElementVisible(By.xpath(costItemsLocator)))
          return web.findElements(By.xpath(costItemRowLocator)).size();
        return 0;
    }

    public class FiltersSection {
        private String parentLocator = "//div[@class='fieldFilter']";
        private String filtersLocatorFormat = "//span[@code='%s']";
        private String quickFilterPopUpLocator = "//*[@id='quick-filter-dialog']";
        private String fileterNameLocator = quickFilterPopUpLocator.concat("//input[@type='text']");
        private String fileterButtonLocator = quickFilterPopUpLocator.concat("//span[.='%s']");
        private String filterTabNameLocator = "//nav[@role='navigation']//li[@name='%s']";

        public String getParentLocator(){
            return parentLocator;
        }

        public void selectFilterByName(String filterName) {
            web.click(By.xpath(String.format(filtersLocatorFormat, filterName)));
        }

        public String getFilterValue(String fieldName) {
            String locator = String.format("//div[@class='assetsFilter']//div[@class='fieldFilter']//ads-md-select[@placeholder='%s']//span//div[contains(@class,'md-text')]", fieldName);
            return web.findElement(By.xpath(locator)).getText().trim();
        }

        public String getFilterStatus(String fieldName) {
            String actual = web.findElement(By.xpath(String.format("//ads-md-select[@placeholder='%s']//md-select", fieldName))).getAttribute("aria-disabled");
            if (actual.equals("true"))
                return "Disabled";
            else
                return "Enabled";
        }

        public void fillFilterName(String filterName){
            web.typeClean(By.xpath(fileterNameLocator),filterName);
        }

        public void buttonAction(String buttonName){
            web.click(By.xpath(String.format(fileterButtonLocator,buttonName)));
        }

        public Boolean isFilterByNameCreated(String filterTabName) {
            try {
                return web.isElementPresent(By.xpath(String.format(filterTabNameLocator, filterTabName)));
            } catch (Exception e) {
                return false;
            }
        }

        public void selectFilterTabByName(String filterTabName){
            web.click(By.xpath(String.format(filterTabNameLocator,filterTabName)));
        }

        public String getCountInFiltersTab(String filterTabName) {
            return web.findElement(By.xpath(String.format(filterTabNameLocator, filterTabName))).getAttribute("aria-label").trim();
        }

        public String checkFiltersTabSelection(String filterTabName) {
            return web.findElement(By.xpath(String.format(filterTabNameLocator, filterTabName))).getAttribute("aria-selected");
        }

        public List<String> getValuesInDropDown(String fieldName){
            By element = By.xpath(String.format("//div[@class='fieldFilter']//ads-md-select[@placeholder='%s']",fieldName));
            web.scrollToElement(web.findElement(element));
            web.click(element);
            return web.findElementsToStrings(By.xpath("//div[@class='md-select-menu-container md-active md-clickable'][@aria-hidden='false']//md-option[@role='option']/div"));
        }
    }

    public boolean checkCostModuleTabInHeader(){
        return web.isElementVisible(By.xpath("//a[@href='/costs']"));
    }

    public boolean isCostOverPageloaded(){
        return web.isElementVisible(By.xpath("//span[@id='create-new-cost-button']"));
    }

    public boolean isDownloadProjectTotalsButtonVisible(){
        return web.isElementVisible(By.xpath("//span[contains(text(),'Download project totals')]"));
    }
 }