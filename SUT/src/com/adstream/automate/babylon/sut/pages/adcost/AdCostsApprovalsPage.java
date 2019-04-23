package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.babylon.sut.pages.adcost.elements.AdCostApprovalSection;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Raja.Gone on 15/05/2017.
 */
public class AdCostsApprovalsPage extends BaseAdCostPage<AdCostsApprovalsPage> {

    private String approvalsPageFormat = "//cost-distribution";
    By approvalsPageLocator = By.xpath(approvalsPageFormat);
    private String formPageParentLocator = "//md-dialog[contains(@class,'_md md-transition-in')][@role='dialog']";
    String formPageGenericLocator = "//div[@id='%s'][@class='addApprovers']//md-dialog";
    String technicalApproverLocator="//approvals//span[contains(text(), 'Technical Approver')]";
    String brandApproverLocator = "//approvals[@header='Coupa Requisitioner']";

    public AdCostsApprovalsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public boolean waitUntilApprovalsPageVisible() {
        boolean isPageloaded = isPageLoaded(approvalsPageFormat,60);
        if(!isPageloaded){
            throw new TimeoutException("Something went wrong in Adcost Approval page loading!!");
        }
        return web.isElementVisible(approvalsPageLocator); }

    public String getApproverSectionLocator(String approverSectionName) {
        if (approverSectionName.equals(AdCostApprovalSection.TECHNICAL_APPROVER.toString()))
            return technicalApproverLocator;
        else if (approverSectionName.equals(AdCostApprovalSection.BRAND_APPROVER.toString()))
            return brandApproverLocator;
        else
            throw new IllegalArgumentException("Incorrect Approver section name:" + approverSectionName+". Should be 'Technical Approver' or 'Coupa Requisitioner'");
    }

    public int getApproversCount(String sectionNameLocator){ return web.findElements(By.xpath(getApprovalRowLocator(sectionNameLocator))).size(); }

    public String getApprovalRowLocator(String sectionNameLocator){ return sectionNameLocator.concat("/../../following-sibling::div[@class=\"approvers ng-scope\"]/div"); }

    public ApproverSection getApproverSection(){
        if(web.isElementPresent(By.xpath(approvalsPageFormat)))
            return new ApproverSection();
        else
            return null;
    }

    public ApproverFormPage waitForApproverFormPageToLoad(){
        web.waitUntilElementAppear(By.xpath("//*[contains(@placeholder,'Approver')][@role='listbox']"));
        return new ApproverFormPage();
    }

    public ApproverFormPage waitForApproverFormPageToLoadForBrandApprover(){
        web.waitUntilElementAppear(By.xpath("//*[contains(@placeholder,'Requisitioner')][@role='listbox']"));
        return new ApproverFormPage();
    }

    public ApproverFormPage waitForFormPageToload(String formPage){
        String approverType = getFormPageApproverPlaceHolderName(formPage);
        web.waitUntilElementAppearVisible(By.xpath(String.format(formPageGenericLocator,approverType)));
        return new ApproverFormPage();
    }

    public ApproverFormPage waitForApproverFormPageToLoadForWatchers(){
        web.waitUntilElementAppear(By.xpath("//input[contains(@placeholder,'Watcher Name')]"));
        return new ApproverFormPage();
    }

    public void waitUntilApproverFormPageDisappear(){
        web.waitUntilElementDisappear(By.xpath(approvalsPageFormat));
    }

    public void waitUntilCostItemsToLoad(){
        web.waitUntilElementAppearVisible(By.cssSelector(".cost-items"));
    }

    public boolean isApproverSectionVisible(String approverType){
        return web.isElementVisible(By.xpath(getApproverSectionLocator(approverType)));
    }

    public class ApproverSection{

        private String approverName;

        public String getApproverName() { return approverName; }

        public void loadApprovalName(int approverRowCount, String sectionName){
            approverName= web.findElement(By.xpath(getApprovalRowLocator(sectionName).concat("["+approverRowCount+"]/span[2]"))).getText();
        }

        public void selectOptionFromApproverMenu(String action, int approverRowCount,String sectionName){
            web.click(By.xpath(getApprovalRowLocator(sectionName).concat("["+approverRowCount+"]/span[3]")));
            clickBtnInMenuItem(action);
            web.waitUntilElementDisappear(By.xpath(getApprovalRowLocator(sectionName).concat("["+approverRowCount+"]")));
        }
    }

    public class ApproverFormPage{

        public String getFormPageParentLocator() { return formPageParentLocator; }
        public void selectApproverNameOnFormPage(String fieldName, String section) {
            if (section.equals("Add Watcher"))
                selectWatchersFromDropDown(fieldName);
            else
                selectApproversFromDropDown(fieldName, section);
        }
        private void selectWatchersFromDropDown(String fieldName){
            By listBoxLocator = By.xpath(String.format("//md-dialog//input[@placeholder='Watcher Name']"));
            String listBoxValueFormat="//div[contains(@class,'ui-select-dropdown')]//*[contains(@id,'ui-select-choices')]/li/div/span";
            if(web.isElementPresent(listBoxLocator)) {
                web.findElement(listBoxLocator).click();
                web.sleep(3000);
                for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                    if (element.getText().contains(fieldName)) {
                        scrollToFieldName(element);
                        element.click();
                        web.sleep(300);
                        web.findElement(By.xpath(" //md-dialog[contains(@class,'_md md-transition-in')]")).click();
                        break;
                    }
                }
            }
        }

        private void selectApproversFromDropDown(String fieldName, String sectionName){
            By listBoxLocator = By.xpath(String.format("//md-dialog[contains(@class,'_md md-transition-in')][@role='dialog']//ads-md-select"));
            String listBoxValueFormat = "//div[contains(@id,'select_container')][@aria-hidden='false']//md-content[@class='_md']/div/md-option/div";
            if(web.isElementPresent(listBoxLocator)) {
                web.findElement(listBoxLocator).click();
                if ((sectionName.equals("Add approver"))) {
                    web.findElement(By.xpath(("//*[@id='IPMaddApprovers']//*[contains(@id,'dialogContent_')]//h2[contains(text(),'Edit approval stage settings')]"))).click();
                    if(fieldName.contains("IPM"))
                        fieldName = fieldName.concat(" (Integrated Production Manager)");
                    if(fieldName.contains("Consultant"))
                        fieldName = fieldName.concat(" (Cost Consultant)");
                }
                if ((sectionName.equals("Add Brand Management Approver"))) {
                    web.findElement(By.xpath(("//*[@id='BrandaddApprovers']//*[contains(@id,'dialogContent_')]//h2[contains(text(),'Edit approval stage settings')]"))).click();
                    fieldName = fieldName.concat(" (Brand Management Approver)");
                }
                if(sectionName.equals("Add Coupa Requisitioner")) {
                    web.findElement(By.xpath(("//*[contains(@id,'dialogContent_')]//h2[contains(text(),'Add Requisitioner')]"))).click();
                    fieldName = fieldName.concat(" (Brand Management Approver)");
                }
                web.findElement(listBoxLocator).click();
                for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldName)) {
                        scrollToFieldName(element);
                        element.click();
                        break;
                    }
                }
            }
            web.sleep(2000); // slow-down approver selection as it's too fast and script fails randomly
        }

        public List<String> getAllApproversOnFormPage(String userType){
            String listBoxFormat = formPageParentLocator.concat("//md-select[contains(@placeholder,'%s')][@role='listbox']");
            String listBoxValueFormat = "//div[contains(@id,'select_container')][@aria-hidden='false']//md-content[@class='_md']//md-option/div";

            String userTypeFormat = getApproverType(userType);
            By listBoxLocator = By.xpath(String.format(listBoxFormat,userTypeFormat));
            By by = By.xpath(listBoxValueFormat);
            List<String> approverNames = new ArrayList<>();

            if(web.isElementPresent(listBoxLocator)) {
                Common.sleep(200);
                web.click(listBoxLocator);
                web.waitUntilElementAppearVisible(by);
                approverNames = web.findElementsToStrings(by);
            }
            return approverNames;
        }

        public boolean checkUserInWatcherList(String userName){
            By listBoxLocator = By.xpath(String.format("//md-dialog[contains(@class,'_md md-transition-in')][@role='dialog']//ads-md-multiselect"));
            String listBoxValueFormat="//div[contains(@class,'ui-select-dropdown')]//*[contains(@id,'ui-select-choices')]/li/div/span";
            if(web.isElementPresent(listBoxLocator)) {
                web.findElement(listBoxLocator).click();
                Common.sleep(2000);
                List<WebElement> users = web.findElements(By.xpath(listBoxValueFormat));
                for (WebElement element : users)
                    if (element.getText().equalsIgnoreCase(userName))
                        return true;
                }
            return false;
        }
    }

    public void closeFormPage(String userType){
        String userTypeFormat = getApproverType(userType);
        String cancelButton = formPageParentLocator.concat(String.format("//*[contains(@placeholder,'%s')]/../..//span[.='Cancel']",userTypeFormat));
        web.click(By.xpath(cancelButton));
        Common.sleep(300);
        if(web.isElementVisible(By.xpath(cancelButton))) {
            web.click(By.xpath(cancelButton));
        }
        if(web.isElementVisible(By.xpath(cancelButton))) {
            web.navigate().refresh();
            web.waitUntilElementAppearVisible(By.xpath(approvalsPageFormat));
        }
    }

    private String getApproverType(String userType){
        switch (userType){
            case "Integrated Production Manager":
                return "Approver";
            case "Cost Consultant":
                return "Approver";
            case "Coupa Requisitioner":
                return "Requisitioner";
            case "Brand Management Approver":
                return "Approver";
            default:
                throw new IllegalArgumentException("Unknown User Type: "+userType);
        }
    }

    public String getApproverName(String section){
        return web.findElement(By.xpath(String.format("//approvals[@header='%s']//span[contains(@class,'md-title font-weight-bold ng-binding')]",section))).getText();
    }

    public void closeApproverFormPage(String formPage){
        String approverType = getFormPageApproverPlaceHolderName(formPage);
        String locator = String.format(formPageGenericLocator,approverType).concat("//span[@code='close'][@role='button']");
        By by = By.xpath(locator);
        web.click(by);
        if(web.isElementVisible(by)) {
            String loc = getApproverType(formPage).toLowerCase();
            web.click(By.xpath(String.format(formPageGenericLocator, approverType).concat("//ads-md-button[@id='add-").concat(loc).concat("-cancel-button']")));
        }
    }

    public String getFormPageApproverPlaceHolderName(String formPage){
        switch (formPage){
            case "Integrated Production Manager":
                return "IPMaddApprovers";
            case "Cost Consultant":
                return "IPMaddApprovers";
            case "Coupa Requisitioner":
                return "BrandaddRequisitioners";
            case "Brand Management Approver":
                return "BrandaddApprovers";
            default:
                throw new IllegalArgumentException("Unknown User Type: "+formPage);
        }
    }

    public boolean isCostCannotBeSubmittedPopUpVisible(String message){
        if(web.findElement(By.xpath("//h2[@class='md-title ng-binding']")).getText().equals(message))
            return true;
        return false;
    }
}