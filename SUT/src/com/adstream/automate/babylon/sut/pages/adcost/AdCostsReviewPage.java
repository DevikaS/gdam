package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.babylon.sut.pages.adcost.elements.CostStages;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.jdom.IllegalNameException;
import org.openqa.selenium.*;
import sun.security.util.PendingException;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Raja.Gone on 22/05/2017.
 */
public class AdCostsReviewPage extends BaseAdCostPage<AdCostsReviewPage> {

    private String costReviewPageFormat = "//cost-review-header";
    By costReviewPageLocator = By.xpath(costReviewPageFormat);

    private String tabsHeaderLocator = "//tabs[@selected-tab='costsReviewCtrl.selectedTab']";
    private String tabNameFormat = "//li[contains(text(),'%s')]";
    private String btnsHeaderLocator = "//*[@id=\"cost-review-header\"]/div[1]";
    private String costStageSectionLocator="//div[@class='stages-list']";
    public String  parentLocatorApproveButton= "//*[@class='approvals']";
    public String  parentLocatorPolicyException= "//*[@id=\"costReviewSection\"]//policy-exceptions";

    private String costDetailsSectionLocator="//cost-details[@id='cost-details-review']";
    private String usageBuyoutDetailsSectionLocator="//usage-buyout-read-only[@id='cost-usage-buyout-review']";
    private String negotiatedTermsSectionLocator="//negotiated-terms-read-only[@id='cost-negotiated-terms-review']";
    private String costItemsSectionLocator="//cost-line-items-read-only[@id='cost-line-items-review']";
    private String supportingDocsSectionLocator="//cost-supporting-documents[@id='supporting-documents-review']";
    private String approvalsSectionLocator="//cost-approvals-read-only[@id='approvals-review']";

    private String productionDetailsSectionLocator="//cost-production-details-read-only[@id='production-cost-details-review']";
    private String expectedAssetsSectionLocator="//expected-asset-list";
    private String expectedAssetsSectionFieldsLocator=expectedAssetsSectionLocator+"//md-card[contains(@ng-repeat,'expectedAsset')]";
    private String travelCostsSectionLocator = "//travel-costs-list";
    private String associatedAssetsLocator = "//associated-asset";
    private String fieldFormat="//div[@label='%s']";
    private String stageFieldFormat="//*[contains(text(), '%s')]";
    private String approverFormat = "//approvals-review[contains(@header,'%s')]";

    private String supportingDocsFormat="//div[contains(text(),'%s')]";
    private String travelDetailsSectionLocator = "//travel-costs-list//div[@class='table-items']";
    private String paymentSummaryLocator = "//payment-summary";
    private String costItemSectionsLocator = "//*[@id=\"cost-line-items-review\"]//div[@class=\"cost-line-items ng-scope\"]";
    private String valueReportingSectionLocator = "//value-reporting-readonly//legend[contains(text(),'Value reporting')]";
    private String policyExceptionSectionLocator = "//*[@id='costReviewSection']//policy-exceptions/div";

    private String textFieldLocatorFormat = "//textarea[@placeholder='%s']";
    private String inputFieldLocatorFormat = "//input[@placeholder='%s'][@name='input']";
    private String comboBoxLocatorFormat = "//input[@placeholder='%s'][@role='combobox'][@name='autocomplete']";
    private String comboBoxValueFormat = "//ul[@class='md-autocomplete-suggestions']//li";
    private By stageVersionLocator = By.xpath("//div[@class='stages-list']//span[@class='ng-binding ng-scope']");

    private By revisionVersionLocator = By.xpath("//div[@class='stages-list']//span[@class='ng-binding ng-scope']");
    private String currentRevisionVersionLocator = "//div[contains(text(),'%s')]/..//div[@class='stage-status-circle']";
    private By versionStagesDropdownLocator = By.xpath("//div[@id='stageStatusElementeClone']//div[contains(@ng-class,'selected')]");
    private String versionLocatorFormat = "//div[@id='stageStatusElementeClone']//li[@role='button'][";

    public AdCostsReviewPage(ExtendedWebDriver web) {
        super(web);
    }

    public boolean waitUntilCostReviewPageVisible() {
        boolean isPageLoaded = isPageLoaded(costReviewPageFormat,60);
        if(!isPageLoaded)
            throw new TimeoutException("Something went wrong in Adcost Review page loading!!");
        return web.isElementVisible(costReviewPageLocator); }

    public void waitForCostReviewPageToDisappear(){
        web.waitUntilElementDisappear(costReviewPageLocator);
    }

    public void selectTabName(String tabName){
        if(tabName.equals("OVERVIEW") || tabName.equals("PAYMENT SUMMARY"))
            web.click(By.xpath(String.format(tabsHeaderLocator+tabNameFormat,tabName)));
        else throw new IllegalNameException("Incorrect TabName:"+tabName);
    }

    public String selectOptionOnHeader(String btnName){
        if(btnName.equals("Next Stage") || btnName.equals("Cancel Cost") || btnName.equals("Create Revision") || btnName.equals("Approve") || btnName.equals("Request Changes") || btnName.equals("Recall Cost")|| btnName.equals("Reopen")
                || btnName.equals("Request Reopen") || btnName.equals("Approve Reopen") || btnName.equals("Reject Reopen")|| btnName.equals("Edit Value Reporting"))
            return btnsHeaderLocator;
        else throw new IllegalNameException("Incorrect TabName:"+btnName);
    }

    public CostStageSection getCostStageSection(){
        if(web.isElementPresent(By.xpath(costStageSectionLocator)))
            return new CostStageSection();
        else throw new ElementNotVisibleException("Check if Cost-Stage section loaded on Review page");
    }

    public CostDetailsSection getCostDetailsSection(){
        if(web.isElementPresent(By.xpath(costDetailsSectionLocator)))
            return new CostDetailsSection();
        else throw new ElementNotVisibleException("Check if Cost-Details section loaded on Review page");
    }

    public UsageBuyoutDetailsSection getUsageBuyoutDetailsSection(){
        if(web.isElementPresent(By.xpath(usageBuyoutDetailsSectionLocator)))
            return new UsageBuyoutDetailsSection();
        else throw new ElementNotVisibleException("Check if Usage/Buyout details section loaded on Review page");
    }

    public NegotiatedTermsSection getNegotiatedTermsSection(){
        if(web.isElementPresent(By.xpath(negotiatedTermsSectionLocator)))
            return new NegotiatedTermsSection();
        else throw new ElementNotVisibleException("Check if Negotiated Terms section loaded on Review page");
    }

    public CostItemsSection getCostItemsSection(){
        By locator = By.xpath(costItemsSectionLocator);
        if(web.isElementPresent(locator)) {
            web.scrollToElement(web.findElement(locator));
            return new CostItemsSection();
        }
        else throw new ElementNotVisibleException("Check if Cost Items section loaded on Review page");
    }

    public SupportingDocsSection getSupportingDocsSection(){
        if(web.isElementPresent(By.xpath(supportingDocsSectionLocator)))
            return new SupportingDocsSection();
        else throw new ElementNotVisibleException("Check if Supporting Docs section loaded on Review page");
    }

    public ApprovalsSection getApprovalsSection(){
        if(web.isElementPresent(By.xpath(approvalsSectionLocator)))
            return new ApprovalsSection();
        else throw new ElementNotVisibleException("Check if Approvals/Distribution section loaded on Review page");
    }

    public void scrollToIOOwnerSection(){
        web.scrollToElement(web.findElement(By.xpath("//io-owner//span[.='I/O# Owner']")));
    }

    public ProductionDetailsSection getProductionDetailsSection(){
        if(web.isElementPresent(By.xpath(productionDetailsSectionLocator)))
            return new ProductionDetailsSection();
        else throw new ElementNotVisibleException("Check if Production Details section loaded on Review page");
    }

    public ExpectedAssetsSection getExpectedAssetsSection(){
        if(web.isElementPresent(By.xpath(expectedAssetsSectionLocator)))
            return new ExpectedAssetsSection();
        else throw new ElementNotVisibleException("Check if Expected Assets section loaded on Review page");
    }

    public TravelCostsSection getTravelCostsSection(){
        if(web.isElementPresent(By.xpath(travelCostsSectionLocator)))
            return new TravelCostsSection();
        else throw new ElementNotVisibleException("Check if Production Details section loaded on Review page");
    }

    public AssociatedAssetsSection getAssociatedAssetsSection(){
        if(web.isElementPresent(By.xpath(associatedAssetsLocator)))
            return new AssociatedAssetsSection();
        else throw new ElementNotVisibleException("Check if Associated Assets section loaded on Review page");
    }

    public PaymentSummaryTabNew getPaymentSummaryTabNew(){
        if(web.isElementPresent(By.xpath(paymentSummaryLocator)))
            return new PaymentSummaryTabNew();
        else throw new ElementNotVisibleException("Check if Payment Summary Tab loaded on Review page");
    }

    public ValueReportingSection getValueReportingSection(){
        By valueReportingSection = By.xpath(valueReportingSectionLocator);
        if(web.isElementPresent(valueReportingSection)) {
            return new ValueReportingSection();
        }
        else throw new ElementNotVisibleException("Check if Value Reporting section loaded on Review page");
    }

    public void scrollToValueReportingSection(){
        By valueReportingSection = By.xpath(valueReportingSectionLocator);
        web.scrollToElement(web.findElement(valueReportingSection));
    }

    public BillingTable getBillingTable(){
        return new BillingTable();
    }
    public class CostStageSection{
        private String stageName;
        private String status;

        public String getStageName() {
            return stageName;
        }

        public String getStatus() {
            return status;
        }

        public String getFieldValueInCostStageSection(String fieldName, String Value){
            String fieldValue = web.findElement(By.xpath(String.format(costStageSectionLocator + stageFieldFormat, Value))).getText();
            switch (fieldName) {
                case "Stage":
                    stageName = fieldValue;
                    break;
                case "Status":
                    status = fieldValue;
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }

    }

    public class CostDetailsSection{
        private String costTitle;
        private String description;
        private String costType;
        private String usageBuyoutContractType;
        private String adCostNumber;
        private String agencyName;
        private String agencyLocation;
        private String creator;
        private String agencyProducer;
        private String targetBudgetAmount;
        private String agencyTrackingNumber;
        private String budgetRegion;
        private String campaign;
        private String organisation;
        private String agencyCurrency;
        private String projectId;
        private String projectName;
        private String brand;
        private String sector;

        public String getProjectName() { return projectName; }

        public String getBrand() { return brand; }

        public String getSector() { return sector; }

        public String getCostTitle() {
            return costTitle;
        }

        public String getDescription() {
            return description;
        }

        public String getCostType() {
            return costType;
        }

        public String getUsageBuyoutContractType() {
            return usageBuyoutContractType;
        }

        public String getAdCostNumber() {
            return adCostNumber;
        }

        public String getAgencyName() {
            return agencyName;
        }

        public String getAgencyLocation() {
            return agencyLocation;
        }

        public String getAgencyProducer() { return agencyProducer; }

        public String getTargetBudgetAmount() {
            return targetBudgetAmount;
        }

        public String getAgencyTrackingNumber() {
            return agencyTrackingNumber;
        }

        public String getBudgetRegion() {
            return budgetRegion;
        }

        public String getCampaign() {
            return campaign;
        }

        public String getOrganisation() { return organisation; }

        public String getAgencyCurrency() { return agencyCurrency; }

        public String getProjectId() { return projectId; }

        public String getFieldValueInCostDetailsSection(String fieldName){
            String fieldValue = web.findElement(By.xpath(String.format(costDetailsSectionLocator + fieldFormat, fieldName))).getText().trim();
                switch (fieldName) {
                    case "Cost Title":
                        costTitle = fieldValue;
                        break;
                    case "Description":
                        description = fieldValue;
                        break;
                    case "Cost Type":
                        costType = fieldValue;
                        break;
                    case "Usage/Buyout/Contract Type":
                        usageBuyoutContractType = fieldValue;
                        break;
                    case "Adcost#":
                        adCostNumber = fieldValue;
                        break;
                    case "Agency Name":
                        agencyName = fieldValue;
                        break;
                    case "Agency Location":
                        agencyLocation = fieldValue;
                        break;
                    case "Agency Cost Creator":
                        creator = fieldValue;
                        break;
                    case "Agency Producer/Art Buyer":
                        agencyProducer = fieldValue;
                        break;
                    case "Target Budget Amount":
                        targetBudgetAmount = fieldValue;
                        break;
                    case "Agency Tracking Number":
                        agencyTrackingNumber = fieldValue;
                        break;
                    case "Budget Region":
                        budgetRegion = fieldValue;
                        break;
                    case "Campaign":
                        campaign = fieldValue;
                        break;
                    case "Organisation":
                        organisation = fieldValue;
                        break;
                    case "Agency Currency":
                        agencyCurrency = fieldValue;
                        break;
                    case "Project Id":
                        projectId = fieldValue;
                        break;
                    case "Project Name":
                        projectName = fieldValue;
                        break;
                    case "Brand":
                        brand = fieldValue;
                        break;
                    case "Sector":
                        sector = fieldValue;
                        break;
                    default:
                        throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
                }
            return fieldValue;
        }

        public String getProjectIdFieldValue(){
            return projectId = web.findElement(By.xpath(costDetailsSectionLocator + "/div[contains(@ng-if,'projectId')]")).getText();
        }
    }

    public class UsageBuyoutDetailsSection {

        private String name;
        private String nameOfLicensor;
        private String airingCountries;
        private String touchpoints;
        private String exclusivity;
        private String exclusivityCategory;
        private String startDate;
        private String endDate;
        private String contractPeriod;

        public String getContractPeriod() {
            return contractPeriod;
        }

        public String getEndDate() {
            return endDate;
        }

        public String getStartDate() {
            return startDate;
        }

        public String getExclusivityCategory() {
            return exclusivityCategory;
        }

        public String getExclusivity() {
            return exclusivity;
        }

        public String getTouchpoints() {
            return touchpoints;
        }

        public String getAiringCountries() {
            return airingCountries;
        }

        public String getNameOfLicensor() {
            return nameOfLicensor;
        }

        public String getName() {
            return name;
        }


        public String getFieldValueInUsageBuyoutDetailsSection(String fieldName) {
            String fieldValue = web.findElement(By.xpath(String.format(usageBuyoutDetailsSectionLocator + fieldFormat, fieldName))).getText();
            switch (fieldName) {
                case "Name":
                    name = fieldValue;
                    break;
                case "Name of Licensor(Person or Company)":
                    nameOfLicensor = fieldValue;
                    break;
                case "Airing Countries":
                    airingCountries = fieldValue;
                    break;
                case "Touchpoints":
                    touchpoints = fieldValue;
                    break;
                case "Exclusivity":
                    exclusivity = fieldValue;
                    break;
                case "Exclusivity Category":
                    exclusivityCategory = fieldValue;
                    break;
                case "Start Date":
                    startDate = fieldValue;
                    break;
                case "End Date":
                    endDate = fieldValue;
                    break;
                case "Contract Period (In Months)":
                    contractPeriod = fieldValue;
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }
    }

    public class NegotiatedTermsSection{
        private String producedAsset;
        private String makeupArtist;
        private String hairStylist;
        private String nailArtist;
        private String wardrobeArtist;
        private String celebrity;
        private String manager;
        private String glamSquad;
        private String security;

        public String getSecurity() {
            return security;
        }

        public String getGlamSquad() {
            return glamSquad;
        }

        public String getManager() {
            return manager;
        }

        public String getCelebrity() {
            return celebrity;
        }

        public String getWardrobeArtist() {
            return wardrobeArtist;
        }

        public String getNailArtist() {
            return nailArtist;
        }

        public String getHairStylist() {
            return hairStylist;
        }

        public String getMakeupArtist() {
            return makeupArtist;
        }

        public String getProducedAsset() {
            return producedAsset;
        }

        public String getFieldValueInNegotiatedTermsSection(String fieldName) {
            String fieldValue = web.findElement(By.xpath(String.format(negotiatedTermsSectionLocator + fieldFormat, fieldName))).getText();
            switch (fieldName) {
                case "Produced Asset":
                    producedAsset = fieldValue;
                    break;
                case "Makeup Artist":
                    makeupArtist = fieldValue;
                    break;
                case "Hair Stylist":
                    hairStylist = fieldValue;
                    break;
                case "Nail Artist":
                    nailArtist=fieldValue;
                    break;
                case "Wardrobe Artist":
                    wardrobeArtist = fieldValue;
                    break;
                case "Celebrity":
                    celebrity = fieldValue;
                    break;
                case "Manager":
                    manager = fieldValue;
                    break;
                case "Glam Squad":
                    glamSquad=fieldValue;
                    break;
                case "Security":
                    security=fieldValue;
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }
    }

    public class CostItemsSection {

        String columnHeaderLocator = "//*[@id='cost-line-items-review']//div[@class='cost-line-items ng-scope'][1]//*[contains(@class, 'cost-line-item')][1]//div";
        String costItemsSectionLocator = "//*[@id='cost-line-items-review']//div[@class='cost-line-items ng-scope']";
        String grandTotalSectionLocator = "//div[@class='cost-line-item-total layout-row']";
        String costLineItemsLinkLocator = "//*[@id='costReviewSectionid']//li[4]";

        private String projectGrandTotal;
        private String poNumber;
        private String ioNumber;
        private String finalAssetApprovalDate;
        private String shoppingCartNumber;
        private String grNumber;

        private String originalEstimate;
        private String originalEstimateWithOutSpace;
        private String finalActualLocalWithOutSpace;
        private String finalActualWithOutSpace;
        private String finalActualLocal;
        private String finalActual;
        private String originalEstimateLocalWithOutSpace;
        private String originalEstimateRevisionWithOutSpace;
        private String originalEstimateRevisionLocalWithOutSpace;
        private String firstPresentation;
        private String firstPresentationLocal;
        private String firstPresentationRevision;
        private String firstPresentationRevisionLocal;
        private String originalEstimateLocal;
        private String OriginalEstimateRevisionLocal;
        private String OriginalEstimateRevision;
        private String firstPresentationRevisionLocalWithSpace;
        private String firstPresentationRevisionWithOutAnySpace;
        private String originalEstimateRevisionLocalWithSpace;
        private String originalEstimateRevisionWithOutAnySpace;
        private String CurrentRevision;
        private String CurrentRevisionLocal;

        public String getFirstPresentationRevisionWithOutAnySpace() {
            return firstPresentationRevisionWithOutAnySpace;
        }

        public void setFirstPresentationRevisionWithOutAnySpace(String firstPresentationRevisionWithOutAnySpace) {
            this.firstPresentationRevisionWithOutAnySpace = firstPresentationRevisionWithOutAnySpace;
        }

        public String getFirstPresentationRevisionLocalWithSpace() {
            return firstPresentationRevisionLocalWithSpace;
        }

        public void setFirstPresentationRevisionLocalWithSpace(String firstPresentationRevisionLocalWithSpace) {
            this.firstPresentationRevisionLocalWithSpace = firstPresentationRevisionLocalWithSpace;
        }

        public String getOriginalEstimateRevisionWithOutAnySpace() {
            return originalEstimateRevisionWithOutAnySpace;
        }

        public void setOriginalEstimateRevisionWithOutAnySpace(String originalEstimateRevisionWithOutAnySpace) {
            this.originalEstimateRevisionWithOutAnySpace = originalEstimateRevisionWithOutAnySpace;
        }

        public String getOriginalEstimateRevisionLocalWithSpace() {
            return originalEstimateRevisionLocalWithSpace;
        }

        public void setOriginalEstimateRevisionLocalWithSpace(String originalEstimateRevisionLocalWithSpace) {
            this.originalEstimateRevisionLocalWithSpace = originalEstimateRevisionLocalWithSpace;
        }

        public String getOriginalEstimateRevision() {
            return OriginalEstimateRevision;
        }

        public void setOriginalEstimateRevision(String originalEstimateRevision) {
            OriginalEstimateRevision = originalEstimateRevision;
        }

        public String getOriginalEstimateRevisionLocal() {
            return OriginalEstimateRevisionLocal;
        }

        public void setOriginalEstimateRevisionLocal(String originalEstimateRevisionLocal) {
            OriginalEstimateRevisionLocal = originalEstimateRevisionLocal;
        }

        public String getOriginalEstimateLocal() {
            return originalEstimateLocal;
        }

        public void setOriginalEstimateLocal(String originalEstimateLocal) {
            this.originalEstimateLocal = originalEstimateLocal;
        }

        public String getOriginalEstimate() {
            return originalEstimate;
        }

        public void setOriginalEstimate(String originalEstimate) {
            this.originalEstimate = originalEstimate;
        }

        public String getOriginalEstimateWithOutSpace() {
            return originalEstimateWithOutSpace;
        }

        public void setOriginalEstimateWithOutSpace(String originalEstimateWithOutSpace) {
            this.originalEstimateWithOutSpace = originalEstimateWithOutSpace;
        }

        public String getFinalActualLocal() {
            return finalActualLocal;
        }

        public void setFinalActualLocal(String finalActualLocal) {
            this.finalActualLocal = finalActualLocal;
        }

        public String getFinalActual() {
            return finalActual;
        }

        public void setFinalActual(String finalActual) {
            this.finalActual = finalActual;
        }

        public String getFinalActualLocalWithOutSpace() {
            return finalActualLocalWithOutSpace;
        }

        public void setFinalActualLocalWithOutSpace(String finalActualLocalWithOutSpace) {
            this.finalActualLocalWithOutSpace = finalActualLocalWithOutSpace;
        }

        public String getFinalActualWithOutSpace() {
            return finalActualWithOutSpace;
        }

        public void setFinalActualWithOutSpace(String finalActualWithOutSpace) {
            this.finalActualWithOutSpace = finalActualWithOutSpace;
        }

        public String getOriginalEstimateLocalWithOutSpace() {
            return originalEstimateLocalWithOutSpace;
        }

        public void setOriginalEstimateLocalWithOutSpace(String originalEstimateLocalWithOutSpace) {
            this.originalEstimateLocalWithOutSpace = originalEstimateLocalWithOutSpace;
        }

        public String getOriginalEstimateRevisionWithOutSpace() {
            return originalEstimateRevisionWithOutSpace;
        }

        public void setOriginalEstimateRevisionWithOutSpace(String originalEstimateRevisionWithOutSpace) {
            this.originalEstimateRevisionWithOutSpace = originalEstimateRevisionWithOutSpace;
        }

        public String getOriginalEstimateRevisionLocalWithOutSpace() {
            return originalEstimateRevisionLocalWithOutSpace;
        }

        public void setOriginalEstimateRevisionLocalWithOutSpace(String originalEstimateRevisionLocalWithOutSpace) {
            this.originalEstimateRevisionLocalWithOutSpace = originalEstimateRevisionLocalWithOutSpace;
        }

        public String getFirstPresentation() {
            return firstPresentation;
        }

        public void setFirstPresentation(String firstPresentation) {
            this.firstPresentation = firstPresentation;
        }

        public String getFirstPresentationLocal() {
            return firstPresentationLocal;
        }

        public void setFirstPresentationLocal(String firstPresentationLocal) {
            this.firstPresentationLocal = firstPresentationLocal;
        }

        public String getFirstPresentationRevision() {
            return firstPresentationRevision;
        }

        public void setFirstPresentationRevision(String firstPresentationRevision) {
            this.firstPresentationRevision = firstPresentationRevision;
        }

        public String getFirstPresentationRevisionLocal() {
            return firstPresentationRevisionLocal;
        }

        public void setFirstPresentationRevisionLocal(String firstPresentationRevisionLocal) {
            this.firstPresentationRevisionLocal = firstPresentationRevisionLocal;
        }

        public String getCurrentRevisionLocal() {
            return CurrentRevisionLocal;
        }

        public void setCurrentRevisionLocal(String currentRevisionLocal) {
            this.CurrentRevisionLocal = currentRevisionLocal;
        }

        public String getCurrentRevision() {
            return CurrentRevision;
        }

        public void setCurrentRevision(String currentRevision) {
            this.CurrentRevision = currentRevision;
        }

        public void clickCostSection() {
            web.click(By.xpath(costLineItemsLinkLocator));
        }

        public void loadDataInGrandTotalSection() {
            int totalNumberOfColumnHeaders = web.findElements(By.xpath(columnHeaderLocator)).size();
            for (int columnHeaderCounter = 2; columnHeaderCounter <= totalNumberOfColumnHeaders; columnHeaderCounter++) {
                String columnName = web.findElement(By.xpath(columnHeaderLocator.concat("[" + columnHeaderCounter + "]"))).getText().split(" \\(")[0];
                String value = web.findElement(By.xpath(grandTotalSectionLocator.concat("/div[" + columnHeaderCounter + "]"))).getText().trim();
                setData(columnName,value);
            }
        }

        public void loadDataInCostLineItems(String sectionName, String itemSectionName) {
            boolean condition = false;
            int totalSectionsInCostItems = web.findElements(By.xpath(costItemsSectionLocator)).size();
            for (int sectionCounter = 1; sectionCounter <= totalSectionsInCostItems; sectionCounter++) {
                String secName = web.findElement(By.xpath(costItemSectionsLocator.concat("[" + sectionCounter + "]//h3"))).getText().trim();
                if (itemSectionName.isEmpty())
                    condition = loadDataOnCostItemSection(sectionCounter, sectionName,condition);
                if (itemSectionName.equals(secName))
                    condition = loadDataOnCostItemSection(sectionCounter, sectionName,condition);
            }
            if(!condition)
                throw new IllegalArgumentException("Found unknown 'Item Description': "+sectionName);
        }

        private boolean loadDataOnCostItemSection(int sectionCounter, String sectionName, boolean condition){
            int totalNumberOfColumnHeaders = web.findElements(By.xpath(columnHeaderLocator)).size();

                String eachRowInCostItemsSectionLocator = costItemsSectionLocator.concat("[" + sectionCounter + "]/div/div[contains(@class,'cost-line-item')]");
                List<WebElement> rowList = web.findElements(By.xpath(eachRowInCostItemsSectionLocator));
                for (int columnHeaderCounter = 2; columnHeaderCounter <= totalNumberOfColumnHeaders; columnHeaderCounter++) {
                    for (int rowCounter = 1; rowCounter <= rowList.size(); rowCounter++) {
                        String itemDescriptionLocator = eachRowInCostItemsSectionLocator.concat("[" + rowCounter + "]/div[1]");
                        if (web.findElement(By.xpath(itemDescriptionLocator)).getText().equalsIgnoreCase(sectionName)) {

                            String columnName = web.findElement(By.xpath(columnHeaderLocator.concat("[" + columnHeaderCounter + "]"))).getText().split(" \\(")[0];
                            String value = web.findElement(By.xpath(eachRowInCostItemsSectionLocator.concat("[" + rowCounter + "]/div[" + columnHeaderCounter + "]"))).getText();
                            setData(columnName, value);
                            condition = true;
                        }
                    }
                }
            return condition;
        }

        private void setData(String keyName, String value){
            if (keyName.equals(CostStages.ORIGINALESTIMATEWITHOUTSPACE.toString()))
                setOriginalEstimateWithOutSpace(value);
            if (keyName.equals(CostStages.ORIGINALESTIMATELOCALWITHOUTSPACE.toString()))
                setOriginalEstimateLocalWithOutSpace(value);
            if (keyName.equals(CostStages.ORIGINALESTIMATEREVISIONWITHOUTSPACE.toString()))
                setOriginalEstimateRevisionWithOutSpace(value);
            if (keyName.equals(CostStages.ORIGINALESTIMATEREVISIONLOCALWITHOUTSPACE.toString()))
                setOriginalEstimateRevisionLocalWithOutSpace(value);
            if (keyName.equals(CostStages.FIRSTPRESENTATION.toString()))
                setFirstPresentation(value);
            if (keyName.equals(CostStages.FIRSTPRESENTATIONLOCAL.toString()))
                setFirstPresentationLocal(value);
            if (keyName.equals(CostStages.FIRSTPRESENTATIONREVISION.toString()))
                setFirstPresentationRevision(value);
            if (keyName.equals(CostStages.FIRSTPRESENTATIONREVISIONLOCAL.toString()))
                setFirstPresentationRevisionLocal(value);
            if (keyName.equals(CostStages.ORIGINALESTIMATE.toString()))
                setOriginalEstimate(value);
            if (keyName.equals(CostStages.ORIGINALESTIMATEREVISIONLOCAL.toString()))
                setOriginalEstimateRevisionLocal(value);
            if(keyName.equals(CostStages.ORIGINALESTIMATELOCAL.toString()))
                setOriginalEstimateLocal(value);
            if(keyName.equals(CostStages.ORIGINALESTIMATEREVISION.toString()))
                setOriginalEstimateRevision(value);
            if (keyName.equals(CostStages.FINALACTUALLOCAL.toString()))
                setFinalActualLocal(value);
            if (keyName.equals(CostStages.FINALACTUAL.toString()))
                setFinalActual(value);
            if (keyName.equals(CostStages.FINALACTUALLOCALWITHOUTSPACE.toString()))
                setFinalActualLocalWithOutSpace(value);
            if (keyName.equals(CostStages.FINALACTUALWITHOUTSPACE.toString()))
                setFinalActualWithOutSpace(value);
            if (keyName.equals(CostStages.ORIGINALESTIMATEREVISIONLOCALWITHSPACE.toString()))
                setOriginalEstimateRevisionLocalWithSpace(value);
            if (keyName.equals(CostStages.ORIGINALESTIMATEREVISIONWITHOUTANYSPACE.toString()))
                setFirstPresentationRevisionLocalWithSpace(value);
            if (keyName.equals(CostStages.FIRSTPRESENTATIONREVISIONLOCALWITHSPACE.toString()))
                setOriginalEstimateRevisionLocalWithSpace(value);
            if (keyName.equals(CostStages.FIRSTPRESENTATIONREVISIONWITHOUTANYSPACE.toString()))
                setFirstPresentationRevisionWithOutAnySpace(value);
            if (keyName.equals(CostStages.CURRENTREVISION.toString()))
                setCurrentRevision(value);
            if (keyName.equals(CostStages.CURRENTREVISIONLOCAL.toString()))
                setCurrentRevisionLocal(value);
        }

        public String getFieldValueInCostTermsSection(String fieldName) {
            String fieldValue = web.findElement(By.xpath(String.format(costItemsSectionLocator + fieldFormat, fieldName))).getText();
            switch (fieldName) {
                case "PO#":
                    poNumber = fieldValue;
                    break;
                case "IO#":
                    ioNumber = fieldValue;
                    break;
                case "Final Asset Approval Date":
                    finalAssetApprovalDate= fieldValue;
                    break;
                case "Shopping Cart #":
                    shoppingCartNumber = fieldValue;
                    break;
                case "GR #":
                    grNumber = fieldValue;
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }
    }

    public class SupportingDocsSection{
        private String documentFormat;
        private String formName;
        private String documentName;
        private boolean isDownloadButton;

        public boolean isDownloadButton() {
            return isDownloadButton;
        }

        public String getDocumentFormat() {
            return documentFormat;
        }

        public String getFormName() {
            return formName;
        }

        public String getDocumentName() {
            return documentName;
        }

        public int getSupportingDocsCount(){
            return web.findElements((By.xpath(supportingDocsSectionLocator.concat("//div[contains(@class,'supporting-document')]")))).size();
        }

        public int getAdditionalSupportingDocsCount(){
            return web.findElements((By.xpath(supportingDocsSectionLocator.concat("//div[contains(text(),'Additional supporting document')]")))).size();
        }

        public void loadSupportingDocs(String fieldName){
            By supportingDocLocator = By.xpath(String.format(supportingDocsFormat,fieldName));
            documentFormat=web.findElement(By.xpath(String.format(supportingDocsFormat+"/../..//div[@class='type ng-binding']",fieldName))).getText();
            formName=web.findElement(supportingDocLocator).getText();
            documentName=web.findElement(By.xpath(String.format(supportingDocsFormat+"/../..//span[@class='ng-binding']",fieldName))).getText();
            isDownloadButton=web.isElementVisible(By.xpath(String.format(supportingDocsFormat+"/../..//span[@code='download-doc']",fieldName)));
        }

        public void clickDownloadBtn(String fieldName){
            web.click(By.xpath(String.format(supportingDocsFormat+"/../..//span[@code='download-doc']",fieldName)));
        }

        public String getDocumentName(String fieldName){
            return web.findElement(By.xpath(String.format(supportingDocsFormat+"/../..//span[@class='ng-binding']",fieldName))).getText();
        }
    }

    public class ApprovalsSection{

        private String approverName;

        private String timestamp;

        private String stage;

        private String reason;

        private String ioOwner;

        public String getStageName() {
            return stage;
        }

        public String getTimestamp() {
            return timestamp;
        }

        public String getReason() {
            return reason;
        }

        public String getApproverName() { return approverName; }

        public String getIoOwner() { return ioOwner; }

        public String getApproverSectionLocator(String approverSectionName) {
            return String.format(approverFormat,approverSectionName);
        }

        public int getApproversCount(String sectionNameLocator){ return web.findElements(By.xpath(getApprovalRowLocator(sectionNameLocator))).size(); }

        public String getApprovalRowLocator(String sectionNameLocator){ return sectionNameLocator.concat("//div[@class=\"approvers ng-scope\"]/div"); }

        public void loadApprovalName(int approverRowCount, String sectionName){
            approverName= web.findElement(By.xpath(getApprovalRowLocator(sectionName).concat("["+approverRowCount+"]/span[2]"))).getText();
        }

        // action = {Approve || Request Changes }
        public void clickButtonInApproverSection(String sectionNameLocator,String action){
            String btnFormat = getApproverSectionLocator(sectionNameLocator).concat("//button//span[contains(text(),'%s')]");
            By btnLocator = By.xpath(String.format(btnFormat,action));
            web.click(btnLocator);
        }

        public void selectBtnNameOnPopUp(String btnName){
            throw new PendingException("'Approval' button on pop-up to be implemented once Sel 3.0 is resolved");
        }

        public String getFieldValueInDistributionSection(String fieldName, String value){
            String locator = "//rejection-details//*[@class='data layout-column']//*[contains(@class,'%s')]";
            String fieldValue = null;
            switch (fieldName) {
                case "User Name":
                    approverName = fieldValue = web.findElement(By.xpath(String.format("//approvals-review//span[contains(text(),'%s')]",value))).getText();
                    break;
                case "Timestamp":
                    timestamp = fieldValue = web.findElement(By.xpath(String.format(locator, fieldName.toLowerCase()))).getText();
                    break;
                case "Stage":
                    stage = fieldValue = web.findElement(By.xpath(String.format(locator, fieldName.toLowerCase()))).getText();
                    break;
                case "Comments":
                    locator = locator.concat("/p");
                    reason = fieldValue = web.findElement(By.xpath(String.format(locator, fieldName.toLowerCase()))).getText();
                    break;
                case "I/O# Owner":
                    ioOwner = fieldValue = web.findElement(By.xpath("//io-owner//span/a/..")).getText().trim().replaceAll("\n","");
                    break;
                case "I/O# Owner TimeStamp":
                    ioOwner = fieldValue = web.findElement(By.xpath("//io-owner//p[@class='timestamp ng-binding']")).getText().trim().replaceAll("\n","");
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }

        public boolean checkIfIoOwnerisHyperlinked(String ioOwner){
            if(web.findElement(By.xpath("//io-owner//span/a")).getAttribute("ng-href").contains(ioOwner))
                return true;
            return false;
        }

        public boolean checkIOOwnerSectionPresent(){
            return web.isElementVisible(By.xpath("//io-owner//span[.='I/O# Owner']"));
        }
    }

    public class ProductionDetailsSection{
        private String postProductionCompany;
        private String musicCompany;
        private String cgiAnimationCompany;

        public String getPostProductionCompany() {
            return postProductionCompany;
        }

        public String getMusicCompany() {
            return musicCompany;
        }

        public String getCgiAnimationCompany() {
            return cgiAnimationCompany;
        }

        public String getFieldValueInProductionDetailsSection(String fieldName) {
            String fieldValue = web.findElement(By.xpath(String.format(productionDetailsSectionLocator + fieldFormat, fieldName))).getText();
            switch (fieldName) {
                case "Post Production Company":
                    postProductionCompany = fieldValue;
                    break;
                case "Music Company":
                    musicCompany = fieldValue;
                    break;
                case "CGI/Animation Company":
                    cgiAnimationCompany = fieldValue;
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }
    }

    public class ExpectedAssetsSection{
        private String initiative;
        private String assetTitle;
        private String adId;
        private String duration;
        private String definition;
        private String mediaTouchPoint;
        private String oval;
        private String firstAirInsertionDate;
        private String scrapped;

        public String getLength() {
            return length;
        }

        public void setLength(String length) {
            this.length = length;
        }

        private String length;

        public String getCountry() {
            return country;
        }

        public void setCountry(String country) {
            this.country = country;
        }

        public String getScrapped() {
            return scrapped;
        }

        public void setScrapped(String scrapped) {
            this.scrapped = scrapped;
        }

        public String getFirstAirInsertionDate() {
            return firstAirInsertionDate;
        }

        public void setFirstAirInsertionDate(String firstAirInsertionDate) {
            this.firstAirInsertionDate = firstAirInsertionDate;
        }

        public String getOval() {
            return oval;
        }

        public void setOval(String oval) {
            this.oval = oval;
        }

        public String getMediaTouchPoint() {
            return mediaTouchPoint;
        }

        public void setMediaTouchPoint(String mediaTouchPoint) {
            this.mediaTouchPoint = mediaTouchPoint;
        }

        public String getDefinition() {
            return definition;
        }

        public void setDefinition(String definition) {
            this.definition = definition;
        }

        public String getDuration() {
            return duration;
        }

        public void setDuration(String duration) {
            this.duration = duration;
        }

        public String getAdId() {
            return adId;
        }

        public void setAdId(String adId) {
            this.adId = adId;
        }

        public String getAssetTitle() {
            return assetTitle;
        }

        public void setAssetTitle(String assetTitle) {
            this.assetTitle = assetTitle;
        }

        public String getInitiative() {
            return initiative;
        }

        public void setInitiative(String initiative) {
            this.initiative = initiative;
        }

        private String country;

        public String getFieldValueInExpectedAssetsSection(String fieldName) {
            String fieldValue = web.findElement(By.xpath(String.format(expectedAssetsSectionLocator + fieldFormat, fieldName))).getText();
            switch (fieldName) {
                case "":
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }

        public String getExpectedAssetsCount(){
            return web.findElement(By.xpath("//div[@id='expected-assets-review']//h2[@class='ng-binding']")).getText();
        }

        public int getExpectedAssetsSectionsCount() {
            return web.findElements(By.xpath(expectedAssetsSectionLocator.concat("//tr[@ng-repeat='expectedAsset in $ctrl.assets']"))).size();
        }

        public void loadDataInExpectedAssetsSection(int childNode) {
            int sectionCount = childNode+1;
            String tableHeadersLocator = expectedAssetsSectionLocator+"//th[contains(@class,'md-column ')]";
            String tableRowLocator = expectedAssetsSectionLocator+"//tr[contains(@class,'md-row')]";

            setInitiative(web.findElement(By.xpath(expectedAssetsSectionLocator+"//tr["+sectionCount+"]//span[contains(@class,'asset')][1]")).getText());
            setAssetTitle(web.findElement(By.xpath(expectedAssetsSectionLocator+"//tr["+sectionCount+"]//span[contains(@class,'asset')][2]")).getText());
            setAdId(web.findElement(By.xpath(expectedAssetsSectionLocator+"//tr["+sectionCount+"]//span[contains(@class,'asset-adid')]")).getText());

            int tableColumnCount = web.findElements(By.xpath(tableHeadersLocator)).size();
            for (int j = 2; j <= tableColumnCount; j++) {
                By tableCellDataLocator = By.xpath(tableRowLocator.concat("[").concat(Integer.toString(sectionCount).concat("]//td[contains(@class,'md-cell')][").concat(Integer.toString(j)).concat("]")));
                String tableRowName = web.findElement(By.xpath(tableHeadersLocator + "[" + j + "]")).getText();
                String cellValue = web.findElement(tableCellDataLocator).getText();
                switch (tableRowName) {
                    case "Length":
                        setLength(cellValue);
                        break;
                    case "Definition":
                        setDefinition(cellValue);
                        break;
                    case "Media / Touchpoint":
                        setMediaTouchPoint(cellValue);
                        break;
                    case "OVAL":
                        setOval(cellValue);
                        break;
                    case "First Air / Insertion Date":
                        setFirstAirInsertionDate(cellValue);
                        break;
                    case "Scrapped":
                        setScrapped(cellValue);
                        break;
                    case "Airing Country / Region":
                        setCountry(cellValue);
                        break;
                }
            }
        }
    }

    public class TravelCostsSection {

        private String travelerName;
        private String travelerRole;
        private String shootCity;
        private String days;
        private String travelType;

        public String getTotalAgencyTravelCosts() {
            return totalAgencyTravelCosts;
        }

        public String getTravelType() {
            return travelType;
        }

        public String getDays() {
            return days;
        }

        public String getShootCity() {
            return shootCity;
        }

        public String getTravelerRole() {
            return travelerRole;
        }

        public String getTravelerName() {
            return travelerName;
        }

        private String totalAgencyTravelCosts;

        public String getFieldValueInTravelCostsSection(String fieldName) {
            String fieldValue = web.findElement(By.xpath(String.format(costItemsSectionLocator + fieldFormat, fieldName))).getText();
            switch (fieldName) {
                case "":
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }


        public int getRowsInTravelDetailsSection() {
            return web.findElements(getTravelDetailsRowLocator()).size();
        }

        private By getTravelDetailsRowLocator() {
            return By.xpath(travelCostsSectionLocator.concat("//tr[@ng-repeat='cost in $ctrl.travelCostsModels']"));
        }

        public int getRowNumber(String travellerRowName){
            int rowCount = web.findElements(By.xpath(travelCostsSectionLocator.concat("//tbody//tr"))).size();
            for(int i=1;i<=rowCount;i++) {
                if (web.findElement(By.xpath(travelCostsSectionLocator.concat("//tbody//tr[" + i + "]//td[1]"))).getText().equals(travellerRowName))
                    return i;
            }
            throw new Error("Check Travel Details: Couldn't found row with travellerName: "+travellerRowName);
        }

        public void loadTravelDetailsSection(String travellerRowName) {
            int rowNumber = getRowNumber(travellerRowName);
            String tableHeaderLocator = travelCostsSectionLocator + "//thead//th[@class='md-column ng-isolate-scope']";
            int tableColumnCount = web.findElements(By.xpath(tableHeaderLocator)).size();
            for (int j = 1; j <= tableColumnCount; j++) {
                By tableCellLocator = By.xpath(travelCostsSectionLocator + "//tr[contains(@class,'table-item item md-row ng-scope')][" + rowNumber + "]/td[" + j + "]");
                String tableColumnName = web.findElement(By.xpath(travelCostsSectionLocator + "//thead//th[" + j + "]")).getText();
                String cellValue = web.findElement(tableCellLocator).getText().trim();
                switch (tableColumnName) {
                    case "Traveller name":
                        travelerName = cellValue;
                        break;
                    case "Traveller role":
                        travelerRole = cellValue;
                        break;
                    case "Shoot city":
                        shootCity = cellValue;
                        break;
                    case "No. of days":
                        days = cellValue;
                        break;
                    case "Travel type":
                        travelType = cellValue;
                        break;
                    case "Total Agency Travel Costs":
                        totalAgencyTravelCosts = cellValue;
                        break;
                }
            }
        }
    }

    public class AssociatedAssetsSection {

        private String tableHeaderLocator = "//associated-assets-list//div[contains(@class,'table-item header')]";
        private String tableRowLocator = "//associated-assets-list//div[contains(@class,'table-item item')]";
        private String adID;
        private String assetName;
        private String initiative;
        private String associatedCost;

        public String getAdID() {
            return adID;
        }

        public void setAdID(String adID) {
            this.adID = adID;
        }

        public String getAssetName() {
            return assetName;
        }

        public void setAssetName(String assetName) {
            this.assetName = assetName;
        }

        public String getInitiative() {
            return initiative;
        }

        public void setInitiative(String initiative) {
            this.initiative = initiative;
        }

        public String getAssociatedCost() {
            return associatedCost;
        }

        public void setAssociatedCost(String associatedCost) {
            this.associatedCost = associatedCost;
        }

        public void loadData(int rowCounter) {
            rowCounter++;
            List<String> headerLocator = web.findElementsToStrings(By.xpath(tableHeaderLocator.concat("/div")));
            for (int counter = 1; counter <= headerLocator.size(); counter++) {
                String columnHeader = web.findElement(By.xpath(tableHeaderLocator + "/div[" + counter + "]")).getText().trim();
                String rowValue = web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[" + counter + "]")).getText().trim();
                switch (columnHeader) {
                    case "Ad-ID":
                        setAdID(rowValue);
                        break;
                    case "Asset name":
                        setAssetName(rowValue);
                        break;
                    case "Initiative":
                        setInitiative(rowValue);
                        break;
                    case "Associated Cost":
                        setAssociatedCost(rowValue);
                        break;
                    default:
                        throw new IllegalArgumentException("Unknown headerName: " + rowValue);
                }
            }
        }

        public String selectAssociatedCost(String costNumber,String assetName) {
            int totalRows = web.findElements(By.xpath(tableRowLocator)).size();
            for (int rowCounter = 1; rowCounter <= totalRows; rowCounter++) {
                if (web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[4]")).getText().equals(costNumber) &&
                        web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[2]")).getText().equals(assetName)) {
                    return web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[4]/a")).getAttribute("href");
                }
            }
            return null;
        }
    }

    public class PaymentSummaryTabNew{
        private String aipePaymentAmount;
        private String originalEstimatePaymentAmount;
        private String firstPresentationPaymentAmount;
        private String finalActualPaymentAmount;
        private String poTotal;
        private String stillImageProduction;
        private String stillImagePostProduction;
        private String technicalFee;
        private String insurance;
        private String otherCosts;
        private String videoProduction;
        private String videoPostProduction;
        private String costTotal;
        private String talentFees;

        public String getAipePaymentAmount() {
            return aipePaymentAmount;
        }

        public void setAipePaymentAmount(String aipePaymentAmount) {
            this.aipePaymentAmount = aipePaymentAmount;
        }

        public String getPoTotal() {
            return poTotal;
        }

        public void setPoTotal(String poTotal) {
            this.poTotal = poTotal;
        }

        public String getOriginalEstimatePaymentAmount() {
            return originalEstimatePaymentAmount;
        }

        public void setOriginalEstimatePaymentAmount(String originalEstimatePaymentAmount) {
            this.originalEstimatePaymentAmount = originalEstimatePaymentAmount;
        }

        public String getFirstPresentationPaymentAmount() {
            return firstPresentationPaymentAmount;
        }

        public void setFirstPresentationPaymentAmount(String firstPresentationPaymentAmount) {
            this.firstPresentationPaymentAmount = firstPresentationPaymentAmount;
        }

        public String getFinalActualPaymentAmount() {
            return finalActualPaymentAmount;
        }

        public void setFinalActualPaymentAmount(String finalActualPaymentAmount) {
            this.finalActualPaymentAmount = finalActualPaymentAmount;
        }

        public String getStillImageProduction() {
            return stillImageProduction;
        }

        public void setStillImageProduction(String stillImageProduction) {
            this.stillImageProduction = stillImageProduction;
        }

        public String getStillImagePostProduction() {
            return stillImagePostProduction;
        }

        public void setStillImagePostProduction(String stillImagePostProduction) {
            this.stillImagePostProduction = stillImagePostProduction;
        }

        public String getVideoProduction() {
            return videoProduction;
        }

        public void setVideoProduction(String videoProduction) {
            this.videoProduction = videoProduction;
        }

        public String getVideoPostProduction() {
            return videoPostProduction;
        }

        public void setVideoPostProduction(String videoPostProduction) {
            this.videoPostProduction = videoPostProduction;
        }

        public String getTechnicalFee() {
            return technicalFee;
        }

        public void setTechnicalFee(String technicalFee) {
            this.technicalFee = technicalFee;
        }

        public String getInsurance() {
            return insurance;
        }

        public void setInsurance(String insurance) {
            this.insurance = insurance;
        }

        public String getOtherCosts() {
            return otherCosts;
        }

        public void setTalentFees(String talentFees) {
            this.talentFees = talentFees;}

        public String getTalentFees() {
            return talentFees;
        }

        public void setOtherCosts(String otherCosts) {
            this.otherCosts = otherCosts;}

        public String getCostTotal() {
            return costTotal;
        }

        public void setCostTotal(String costTotal) {
            this.costTotal = costTotal;
        }

        public void loadDataForStage(String stageName){
            String stageNameColumnHeaderLocator = "//div[@ng-if='$ctrl.paymentsSectionVisible']//div[@class='payment-summary-header layout-row']/div";
            String rowLocator = "//payment-summary//div[contains(@ng-repeat,'allApplicableStages')]";

            int stageNameColumnNumber=1;
            int columnHeadersCount = web.findElements(By.xpath(stageNameColumnHeaderLocator)).size();
            for(int i=2;i<=columnHeadersCount;i++) {
                if (web.findElement(By.xpath(stageNameColumnHeaderLocator.concat("[" + i + "]/span[1]"))).getText().equalsIgnoreCase(stageName)) {
                    stageNameColumnNumber = i;
                    break;
                }
            }
            int rowCount = web.findElements(By.xpath(rowLocator)).size();
            for(int j =1;j<=rowCount;j++) {
                String value = web.findElement(By.xpath(rowLocator.concat("[" + j + "]/div[" + stageNameColumnNumber + "]"))).getText().replace(",","").trim();
                switch (web.findElement(By.xpath(rowLocator.concat("[" + j + "]/div[1]"))).getText()) {
                    case "Aipe payment amount":
                        setAipePaymentAmount(value);
                        break;
                    case "Original Estimate payment amount":
                        setOriginalEstimatePaymentAmount(value);
                    case "First Presentation payment amount":
                        setFirstPresentationPaymentAmount(value);
                        break;
                    case "Final Actual payment amount":
                        setFinalActualPaymentAmount(value);
                        break;
                }
            }
            setPoTotal(web.findElement(By.xpath("//payment-summary/section//div[@class='payment-summary-total po layout-row']/div["+stageNameColumnNumber+"]")).getText().replace(",","").trim());
        }

        public void loadPaymentLineItemsForStage(String stageName){
            String stageColumnHeaderLocator = "//payment-summary/section/div[contains(@class,'payment-summary-table budget-table')]//div[@class='payment-summary-header layout-row']/div";
            String rowItemLocator = "//payment-summary/section/div[@class='payment-summary-table budget-table']//div[@class='payment-summary-item ng-scope layout-row']";
            int stageNameColumnNumber=1;
            for(int i=2;i<=web.findElements(By.xpath(stageColumnHeaderLocator)).size();i++) {
                if (web.findElement(By.xpath(stageColumnHeaderLocator.concat("[" + i + "]//span[1]"))).getText().equalsIgnoreCase(stageName)) {
                    stageNameColumnNumber = i;
                    break;
                }
            }
            setCostTotal(web.findElement(By.xpath("//payment-summary/section/div[contains(@class,'payment-summary-table')]//div[@class='payment-summary-total agency layout-row']/div["+stageNameColumnNumber+"]")).getText().replace(",","").trim());
            for(int j =1;j<=web.findElements(By.xpath(rowItemLocator)).size();j++) {
                String value = web.findElement(By.xpath(rowItemLocator.concat("[" + j + "]/div[" + stageNameColumnNumber + "]/span"))).getText().replace(",","").trim();
                switch (web.findElement(By.xpath(rowItemLocator.concat("[" + j + "]/div[1]/span"))).getText()) {
                    case "STILL IMAGE PRODUCTION COST":
                        setStillImageProduction(value);
                        break;
                    case "STILL IMAGE POST PRODUCTION COST":
                        setStillImagePostProduction(value);
                        break;
                    case "PRODUCTION COST":
                        setVideoProduction(value);
                        break;
                    case "POST PRODUCTION COST":
                        setVideoPostProduction(value);
                        break;
                    case "TECHNICAL FEE (IF APPLICABLE)":
                        setTechnicalFee(value);
                        break;
                    case "INSURANCE (IF NOT COVERED BY P&G)":
                        setInsurance(value);
                        break;
                    case "OTHER COSTS":
                        setOtherCosts(value);
                        break;
                    case "TALENT FEES":
                        setTalentFees(value);
                        break;
                }
            }
        }

        public boolean checkPaymentSectionLoaded(){
            return  web.isElementVisible(By.xpath("//payment-summary//div[contains(@ng-repeat,'allApplicableStages')][1]//span[.='-']"));
        }
    }

    public void selectCurrentRevisionVersion(String version,String stage){
        By revisionLocatorFormat = By.xpath(String.format(currentRevisionVersionLocator,stage));
        int expectedVersion = Integer.parseInt(version);
        web.click(revisionLocatorFormat);
        List<WebElement> elementList= web.waitUntilElementAppearVisible(versionStagesDropdownLocator).findElements(versionStagesDropdownLocator);

        if(elementList.size()>=expectedVersion) {
            for (int i = 1; i <= elementList.size(); i++)
                if (i == expectedVersion) {
                    if (!web.findElement(By.xpath(versionLocatorFormat + i + "]//div[contains(@ng-class,'selected')]")).getAttribute("class").contains("selected")) {
                        web.click(By.xpath(versionLocatorFormat + i + "]"));
                        web.waitUntilElementDisappear(versionStagesDropdownLocator);
                        break;
                    } else
                    {
                        web.click(revisionLocatorFormat);
                        break;
                    }
                }
        } else throw new IllegalArgumentException("Mismatch with Current Revision version number, Expected = "+expectedVersion+", but Actual = "+elementList.size());
    }

    public String getCurrentRevisionVersion(){
        return web.findElement(revisionVersionLocator).getText();
    }

    public List<String> getAllStatusFromCurrenRevisionBecaon(String stage){
        By revisionLocatorFormat = By.xpath(String.format(currentRevisionVersionLocator,stage));
        if(web.isElementPresent(revisionLocatorFormat))
            web.click(revisionLocatorFormat);
        else
            web.click(revisionVersionLocator);
        List<WebElement> elementList= web.waitUntilElementAppearVisible(versionStagesDropdownLocator).findElements(versionStagesDropdownLocator);
        List<String> allElements = new ArrayList<>();
        for(WebElement element:elementList) {
            allElements.add(element.getText());
        }
        return  allElements;
    }

public class ValueReportingSection {
    String supportingDocsLinkLocator = "//*[@id='costReviewSectionid']//li[contains(text(),'Supporting Documents')]";
    private String provenStrategy;
    private String activity;
    private String costAvoidance;
    private String valueAdded;
    private String hardSavingsCurrentStage;
    private String totalSavings;
    public String getProvenStrategy() {
        return provenStrategy;
    }

        public void setProvenStrategy(String ProvenStrategy) {
            provenStrategy = ProvenStrategy;
        }

        public String getActivity() {
            return activity;
        }

        public void setActivity(String Activity) {
            activity = Activity;
        }

        public String getCostAvoidance() {
            return costAvoidance;
        }

        public void setcostAvoidance(String costAvoidance) {
            this.costAvoidance = costAvoidance;
        }

        public String getValueAdded() {
            return valueAdded;
        }

        public void setValueAdded(String valueAdded) {
            this.valueAdded = valueAdded;
        }

        public String getHardSavingsCurrentStage() {
            return hardSavingsCurrentStage;
        }

        public void setHardSavingsCurrentStage(String hardSavingsCurrentStage) {
            this.hardSavingsCurrentStage = hardSavingsCurrentStage;
        }

        public String getTotalSavings() {
            return totalSavings;
        }

        public void setTotalSavings(String totalSavings) {
            this.totalSavings = totalSavings;
        }


        public void clickCostSection() {
            web.click(By.xpath(supportingDocsLinkLocator));
        }

        public String getFieldValueInValueReportngSection(String fieldName){
            web.sleep(1000);
            String fieldValue = web.findElement(By.xpath(String.format("//value-reporting-readonly//*[@class='label'][@label='%s']/ads-truncate/div/div", fieldName))).getText();
            switch (fieldName) {
                case "Proven strategy":
                    setProvenStrategy(fieldValue);
                    break;
                case "Activity":
                    setActivity(fieldValue);
                    break;
                case "Cost avoidance":
                    setcostAvoidance(fieldValue);
                    break;
                case "Value added":
                    setValueAdded(fieldValue);
                    break;
                case "Hard savings current stage":
                    setHardSavingsCurrentStage(fieldValue);
                    break;
                case "Total savings":
                    setTotalSavings(fieldValue);
                    break;
                default:
                    throw new IllegalArgumentException("Unknown fieldName: " + fieldName);
            }
            return fieldValue;
        }

        public void fillFieldByName(String fieldName, String fieldValues) {
            By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName));
            By inputFieldLocator = By.xpath(String.format(inputFieldLocatorFormat, fieldName));
            By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, fieldName));

            for (String fieldValue : fieldValues.split(",")) {
               if (web.isElementPresent(comboBoxLocator)) {
                   Common.sleep(2000);
//                   web.findElement(comboBoxLocator).clear();
//                   Common.sleep(700);
//                   for (int i = 0; i < fieldValue.length(); i++){
//                       char c = fieldValue.charAt(i);
//                       String s = new StringBuilder().append(c).toString();
//                       web.findElement(comboBoxLocator).sendKeys(s);
//                       Common.sleep(100);
//                   }
                   web.findElement(comboBoxLocator).click();
                   Common.sleep(1000);
                   web.typeClean(comboBoxLocator, fieldValue);

//                   if(!web.isElementVisible(By.xpath("//md-virtual-repeat-container//li[@role='button']"))){
//                       web.findElement(comboBoxLocator).clear();
//                       web.findElement(comboBoxLocator).sendKeys(fieldValue);
//                   }
                   for(WebElement element:web.findElements(By.xpath("//ul[@class='md-autocomplete-suggestions']//li[@role='button']"))){
                       if (element.getText().equalsIgnoreCase(fieldValue)) {
                           element.click();
                           break;
                       }
                   }
               }
               else if (web.isElementVisible(textFieldLocator)) {
                    web.typeClean(textFieldLocator, fieldValue);
               }
               else if (web.isElementPresent(inputFieldLocator)) {
                   web.typeClean(inputFieldLocator, fieldValue);
                } else {
                    throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
                }
            }
        }

        public void waitUntilValueReportingFormLoaded(){
            web.waitUntilElementAppearVisible(By.xpath("//form[@name='valueReportingForm']"));
        }

        public void actionOnValueReportingSection(String action){
            clickBtnByNameOnFormReviewPage(action);
            web.waitUntilElementDisappear(By.xpath("//form[@name='valueReportingForm']"));
        }

        public boolean verifyEditalueReportingButtonPresent(){
           return web.isElementVisible(By.xpath("//*[@id='cost-review-header']/div[1]//button//span[contains(text(),'Edit Value Reporting')]"));
        }
        public boolean verifyHardSavingField(){
           return web.isElementVisible(By.xpath("//form[@name='valueReportingForm']//*[@ng-if='$ctrl.valueReporting.hardSavingsDisabled']"));
        }
    }

    public void tickPolicyExceptionApprovalOption(){
        web.waitUntilElementAppearVisible(By.xpath("//md-checkbox/div[1]"));
        web.findElement(By.xpath("//md-checkbox/div[1]")).click();
    }

    public boolean verifyApproveBtnEnabledOrNot(){
        if(web.isElementPresent((By.xpath("//md-dialog[@role='dialog']//button[@ disabled='disabled']//span[contains(text(),'Approve')]"))))
            return  false;
        return true;
    }

    public boolean verifyPolicyExceptionCheckboxSelected(){
        web.waitUntilElementAppearVisible(By.xpath("//md-checkbox/div[1]"));
        String checked = web.findElement(By.xpath("//md-checkbox")).getAttribute("aria-checked");
        if (checked.equalsIgnoreCase("true"))
            return true;
        return  false;
    }

    public PolicyExceptionSection getPolicyexceptionSection(){
        if(web.isElementPresent(By.xpath(policyExceptionSectionLocator)))
            return new PolicyExceptionSection();
        else throw new ElementNotVisibleException("Check if Policy Exception section loaded on Review page");
    }

    public class PolicyExceptionSection{
        private String exceptionType;
        private String reason;
        private String costImplication;
        private String status;

        public String getExceptionType() {
            return exceptionType;
        }
        public void setExceptionType(String exceptionType) {
            this.exceptionType = exceptionType;
        }
        public String getReason() {
            return reason;
        }
        public void setReason(String reason) {
            this.reason = reason;
        }
        public String getCostImplication() {
            return costImplication;
        }
        public void setCostImplication(String costImplication) {
            this.costImplication = costImplication;
        }
        public String getStatus() {
            return status;
        }
        public void setStatus(String status) {
            this.status = status;
        }

        public List<String> loadPolicyexceptionTableOnReviewPage(){
            List<String> actualValues = new ArrayList<>();
            String rowLocator = " //*[@id=\"costReviewSection\"]//policy-exceptions//policy-exceptions-table//md-table-container//tr";
            int stageNameColumnNumber;
            for(int i=1;i<=web.findElements(By.xpath(rowLocator)).size()-1;i++) {
               for(int j=1;j<=web.findElements(By.xpath(rowLocator.concat("[" + i + "][@role='button']/td"))).size();j++) {
                  String columnHeaderLocator = rowLocator.concat("[1]/th");
                  String value = web.findElement(By.xpath(rowLocator.concat("[" + i + "][@role='button']/td[" + j + "]"))).getText().replace(",", "").trim();
                  switch (web.findElement(By.xpath(columnHeaderLocator.concat("[" + j + "]"))).getText()) {
                      case "Exception Type":
                          setExceptionType(value);
                          actualValues.add("Exception Type: "+getExceptionType());
                          break;
                      case "Reason":
                          setReason(value);
                          actualValues.add("Reason: "+getReason());
                          break;
                      case "Cost Implication":
                          setCostImplication(value);
                          actualValues.add("Cost Implication: "+getCostImplication());
                          break;
                      case "Status":
                          setStatus(value);
                          actualValues.add("Status: "+getStatus());
                          break;
                  }
               }
            }
            return actualValues;
        }
    }
    public boolean verifyIfValueReportingSectionPresent(){
        By valueReportingSectionLocator = By.xpath("//*[@id='costReviewSection']/value-reporting-readonly/div");
        if(web.isElementVisible(valueReportingSectionLocator)) {
            web.scrollToElement(web.findElement(valueReportingSectionLocator));
            return true;
        } else return false;
    }

    public void selectPreviousStageVersion(String status){
        web.click((By.xpath(String.format("//div[@id='stageStatusElementeClone']//div[contains(@ng-class,'selected')][contains(text(), '%s')]", status))));
        web.waitUntilElementDisappear(versionStagesDropdownLocator);
    }

    public class BillingTable {

        public List<String> getDataInRow(String fieldName) {
            String rowLocator = String.format("//div[@class='billing-expenses ng-scope']//div[.='%s']/../../div", fieldName);
            return web.findElementsToStrings(By.xpath(rowLocator));
        }
    }

    public String getStageVersion(){
        return web.findElement(stageVersionLocator).getText();
    }

    public String getStageName(String stage){
        return web.findElement(By.xpath(String.format(costStageSectionLocator + stageFieldFormat, stage))).getText();
    }

    public boolean verifyCurrentUrl(String desiredUrl){
        web.sleep(200);
        String currentPage = web.getCurrentUrl().split("\\?")[0].replace("#/", "#");
        String desiredPage = desiredUrl.split("\\?")[0].replace("#/", "#");
        return currentPage.equalsIgnoreCase(desiredPage);
    }

    public String getTimeStampsByFiledName(String fieldName){
        String locatorFormat = String.format("//h5[@id='cd-%s']",fieldName.toLowerCase());
        By locator = By.xpath(locatorFormat);
        return web.findElement(locator).getText();
    }
}