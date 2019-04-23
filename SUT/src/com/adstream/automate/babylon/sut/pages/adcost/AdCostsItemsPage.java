package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.enums.CatagoryDPV;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.ElementNotVisibleException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Raja.Gone on 12/05/2017.
 */
public class AdCostsItemsPage  extends BaseAdCostPage<AdCostsItemsPage> {

    private String costsItemsPageFormat = "//cost-line-items";
    private String policyexceptionPageLocator = "//*[@aria-label='Add Policy Exception']";
    private String textFieldLocatorFormat = "//div[.='%s']/../div[2]//input[@type='text']";
    private String textFieldFormat = "//input[contains(@id,'input')][@placeholder='%s']";
    private String textFieldFormatPE = "//textarea[contains(@id,'input')][@placeholder='%s']";
    private String listBoxFormat = "//*[contains(@placeholder,'%s')][@role='listbox']";
    private String listBoxValueFormat = "//md-content[@class='_md']/div/md-option/div";
    private String listBoxValueFormatPE = "//md-option[@ng-value='exceptionType.id']/div[contains(text(),'%s')]";
    private String datePickerFormat = "//ads-md-datepicker[@placeholder=\"%s\"]//span[@code=\"calendar\"]";
    private String policyExceptionSectionLocator = "//*[@id=\"content\"]//cost-line-items//policy-exceptions";
    private String sectionLocator = "//cost-line-items//div[@class=\"cost-line-items ng-scope\"]";
    private String grandTotalWithCurrencyLocator = "//cost-line-items//div[@class=\"cost-line-item-total layout-row\"]/div[2]";
    private String comboBoxLocatorFormat = "//*[contains(@placeholder,'%s')][@role='combobox']";
    private String comboBoxValueFormat = "//ul[@class='md-autocomplete-suggestions']/li/md-autocomplete-parent-scope/span";

    By costsItemsPageLocator = By.xpath(costsItemsPageFormat);
    By costsLineItemsSectionLocator = By.xpath(costsItemsPageFormat.concat("//div[@class='cost-line-items ng-scope'][@ng-repeat='group in $ctrl.costLineItemsTemplate']"));

    public AdCostsItemsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public boolean waitUntilCostsItemsVisible() { return web.waitUntilElementAppearVisible(costsItemsPageLocator).isDisplayed(); }

    public boolean waitUntilCostsLineItemsLoaded() {
        if(!web.isElementVisible(costsLineItemsSectionLocator)) {
            web.click(By.xpath("//div[.='Overview']"));
            Common.sleep(1000);
            web.click(By.xpath("//div[.='Budget']"));
            return web.waitUntilElementAppearVisible(costsLineItemsSectionLocator).isDisplayed();
        }
        else return true;
    }

    public void fillFieldByName(String fieldName, String fieldValues) {
        By textFieldLocator = By.xpath(String.format(costsItemsPageFormat+textFieldLocatorFormat, fieldName));
        By textFieldLoc = By.xpath(String.format(costsItemsPageFormat+textFieldFormat, fieldName));
        By textFieldLocPE = By.xpath(String.format(policyexceptionPageLocator+textFieldFormatPE, fieldName));
        By listBoxLocator = By.xpath(String.format(costsItemsPageFormat+listBoxFormat, fieldName));
        By listBoxLocatorPE = By.xpath(String.format(policyexceptionPageLocator+listBoxFormat, fieldName));
        By buttonToClickLocator = By.xpath(String.format(buttonNameFormat, fieldName));
        By datePickerLocator = By.xpath(String.format(costsItemsPageFormat+datePickerFormat, fieldName));
        By dateFieldLocator = By.xpath("//ads-md-calendar[@class=\"ng-scope ng-isolate-scope\"]//input[@placeholder=\"dd/MM/yyyy\"]");
        By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, fieldName));

        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(datePickerLocator)) {
                web.click(datePickerLocator);
                web.typeClean(dateFieldLocator,fieldValue);
                web.click(By.xpath("//ads-md-calendar[@class=\"ng-scope ng-isolate-scope\"]//button"));}
            if (web.isElementPresent(textFieldLocator)) {
                scrollToFieldName(web.findElement(textFieldLocator));
                web.typeClean(textFieldLocator, fieldValue);
            } else if (web.isElementPresent(textFieldLocPE)) {
                web.typeClean(textFieldLocPE, fieldValue);
            }else if (web.isElementPresent(listBoxLocator)) {
                scrollToFieldName(web.findElement(listBoxLocator));
                web.findElement(listBoxLocator).click();
                for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        break;
                    }
                }
            }else if (web.isElementPresent(listBoxLocatorPE)) {
                web.findElement(listBoxLocatorPE).click();
                web.waitUntilElementAppearVisible(By.xpath(String.format(listBoxValueFormatPE, fieldValue)));
                List<WebElement> options = web.findElements(By.xpath(String.format(listBoxValueFormatPE,fieldValue)));
                for (WebElement element : options){
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        Common.sleep(500);
                        break;
                    }
                }
            }else if (web.isElementPresent(comboBoxLocator)) {
                web.typeClean(comboBoxLocator, fieldValue);
                Common.sleep(3000);
                if(!web.isElementPresent(By.xpath(comboBoxValueFormat)))
                    web.click(comboBoxLocator);
                for (WebElement element : web.findElements(By.xpath(comboBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        web.sleep(500);
                        web.click(By.xpath("//*[@id='content']//section//cost-line-items//md-divider[2]"));
                        break;
                    }
                }
                web.click(By.xpath("//*[@id='content']//section//cost-line-items//md-divider[2]"));
            }else if (web.isElementPresent(buttonToClickLocator)) {
                web.findElement(buttonToClickLocator).click();
            } else if (web.isElementPresent(textFieldLoc)) {
                scrollToFieldName(web.findElement(textFieldLoc));
                web.findElement(textFieldLoc).sendKeys(fieldValue);
            } else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }

    public void fillCurrency(String curreny,String expectedCostSectionName) {
        String costSectionLocator = "//cost-line-items//div[@class=\"cost-line-items ng-scope\"]";

        List<WebElement> element = web.findElements(By.xpath(costSectionLocator));

        for (int i = 1; i <= element.size(); i++) {
            String actualCostSectionName = web.findElement((By.xpath(costSectionLocator.concat("[" + i + "]/div[1]/div[1]")))).getText();
            System.out.println(actualCostSectionName);
            System.out.println(expectedCostSectionName.toUpperCase());
            if (actualCostSectionName.equals(expectedCostSectionName.toUpperCase())) {
                web.findElement(By.xpath(costSectionLocator.concat("[" + i + "]/div[1]//md-select"))).click();
                for (WebElement elements : web.findElements(By.xpath(listBoxValueFormat))) {
                    if (elements.getText().equalsIgnoreCase(curreny)) {
                        elements.click();
                        break;
                    }
                }
            }
        }
    }

    public SubTotalCurrencyDetails getSubTotalDetails(){
        return new SubTotalCurrencyDetails();
    }

    public BillingTableDetails getBillingTableDetails(){
        return new BillingTableDetails();
    }

    public List<String> getDefaultDataInRow(String fieldName){
        String rowLocator =String.format("//div[.='%s']", fieldName);
        String fieldsInRow = rowLocator.concat("/../div[contains(@class,'md-whiteframe-1dp layout-padding')]");

        return web.findElementsToStrings(By.xpath(fieldsInRow));
    }

    public List<String> getLocalDataInRow(String fieldName){
        String rowLocator =String.format("//div[.='%s']", fieldName);
        String fieldsInRow = rowLocator.concat("/../div/span");
        List<String> actual = new ArrayList<>();

        actual.add(web.findElement(By.xpath(fieldsInRow.concat("[1]"))).getText().concat(web.findElement(By.xpath(fieldsInRow.concat("[2]"))).getText()));
        return actual;
    }

    public String getFieldStatus(String fieldName){
        String rowLocator =String.format("//div[.='%s']/..//div[2]", fieldName);

        if(web.findElement(By.xpath(rowLocator)).getAttribute("class").contains("disabled"))
            return "Disabled";
        else
            return "Enabled";
    }

    public List<String> getCostsItemsBySection(String sectionName){
        String sectionLocator = "//div[@ng-repeat='group in $ctrl.costLineItemsTemplate']";
        int sectionsCount = web.findElements(By.xpath(sectionLocator)).size();

        for(int i=1;i<=sectionsCount;i++){
            String sectionHeaderLocator = sectionLocator+"["+i+"]//div[contains(@class,'md-subhead')]";
            String sectionHeaderName = web.findElement(By.xpath(sectionHeaderLocator)).getText();
            if(sectionHeaderName.equalsIgnoreCase(sectionName)){
                return web.findElementsToStrings(By.xpath(sectionLocator+"["+i+"]/div/div[1]"));
            }
        } return null;
    }

    public class SubTotalCurrencyDetails {
        private String subTotalSectionName;
        private String originalEstimateLocal;
        private String originalEstimate;

        private String costSubTotalSectionFormat = "//cost-line-items//div[contains(text(),'%s')]";

        public String getSubTotalSectionName() {
            return subTotalSectionName;
        }

        public String getOriginalEstimate() {
            return originalEstimate;
        }

        public String getOriginalEstimateLocal() {
            return originalEstimateLocal;
        }

        public void loadSubTotalCurrencyDetails(String subTotalSctName){
            String costSubTotalSectionLocator=String.format(costSubTotalSectionFormat,subTotalSctName);
            subTotalSectionName= web.findElement((By.xpath(costSubTotalSectionLocator.concat("/../div[1]")))).getText();
            originalEstimateLocal = web.findElement((By.xpath(costSubTotalSectionLocator.concat("/../div[2]")))).getText().replace("\n"," ");
            originalEstimate = web.findElement((By.xpath(costSubTotalSectionLocator.concat("/../div[3]")))).getText();
        }

        public String getProjectGrandTotal(){
            return web.findElement(By.xpath(grandTotalWithCurrencyLocator)).getText();
        }
    }

    public class BillingTableDetails {
        private String headerLocator = "//div[@class='billing-expenses ng-scope']";
        String billingSectionLocator = "//div[@ng-repeat='section in vm.model.sections']";
        String billingSectionRowsLocator = "//div[@ng-repeat='billingExpenseRow in section.rows']";

        public int getColumnHeaderCount(){ return web.findElements(By.xpath(headerLocator.concat("/div[1]/div"))).size(); }

        public String getColumnHeaderName(int column){ return web.findElement(By.xpath(headerLocator.concat("/div[1]/div["+column+"]"))).getText(); }

        public List<String> getColumnHeaderNames(){
            return web.findElementsToStrings(By.xpath("//div[contains(text(),'Item description')]/../div"));
        }

        public String getCellValue(int row, int column){
            String locator = headerLocator.concat("/div[").concat(Integer.toString(row).concat("]/div[").concat(Integer.toString(column).concat("]")));
            return web.findElement(By.xpath(locator)).getText();
        }

        public String getContractMonthCellValue(int row, int column){
            String locator = headerLocator+"/div["+row+"]/div["+column+"]//input[@ng-model='cell.value']";
            String attributeValue = web.findElement(By.xpath(locator)).getAttribute("ng-change");
            return attributeValue.split("cell, '")[1].split("',")[0];
        }

        public void updateContractMonthCellValue(String fieldValue,int column){
            String cellLocator =String.format("//div[contains(text(),'No. of months in contract term per FY')]//../..//div[contains(@flex,'noshrink')][%s]//input", column);
            web.typeClean(By.xpath(cellLocator),fieldValue);
        }

        private String getLocatorFormatInBillingTable(String fieldName){
            switch(fieldName){
                case "Base Compensation":
                    return  "//div[@class='ng-binding usageBuyoutFee']";
                case "Pension & Health":
                    return "//div[@class='ng-binding pensionAndHealth']";
                case "Bonus":
                    return "//div[@class='ng-binding bonus']";
                case "Agency fee (PRE or other)":
                    return "//div[@class='ng-binding agencyFee']";
                case "Other incurred costs (including non-reclaimable taxes)":
                    return "//div[@class='ng-binding otherCosts']";
                default:
                    throw  new IllegalArgumentException("Unknown field name: "+fieldName+". Unable to generate locator element");
            }
        }

        public void updateBillingTable(String fieldName,String fieldValue, int column) {
            String locator = getLocatorFormatInBillingTable(fieldName);
            web.findElement(By.xpath(locator.concat("/../../div["+column+"]//input"))).clear();

            for (int i = 0; i < fieldValue.length(); i++){
                char c = fieldValue.charAt(i);
                String s = new StringBuilder().append(c).toString();
                web.findElement(By.xpath(locator.concat("/../../div["+column+"]//input"))).sendKeys(s);
                Common.sleep(100);
            }
            Common.sleep(3000);
        }

        public void isTotalUpdated(String fieldName,String fieldValue,int column) {
            String locator = getLocatorFormatInBillingTable(fieldName);
            String actualValue = web.findElement(By.xpath(locator.concat("/../..//div[contains(@class,'total ng-binding')]"))).getText();
            if(!actualValue.equals(fieldValue))
                updateBillingTable(fieldName,fieldValue,column);
            web.sleep(3000);
        }

        public int getRowNumberInBillingTable(String fieldName){
            int sectionsSize = web.findElements(By.xpath(billingSectionLocator)).size();
            int rowsSize = web.findElements(By.xpath(billingSectionRowsLocator)).size();
            for(int section=1;section<=sectionsSize;section++){
                for(int row=1;row<=rowsSize;row++){
                        String locator = billingSectionLocator + "[" + section + "]" + billingSectionRowsLocator + "[" + row + "]";
                    String actualFieldName = null;
                    try {
                        actualFieldName = web.findElement(By.xpath(locator + "/div[1]")).getText();
                    } catch(Exception e){}
                    if (fieldName.equals(actualFieldName)) {
                            return row;
                    }
                }
            }
            return 0;
        }

        public List<String> getDataInRow(String fieldName){
            String rowLocator =String.format("//div[.='%s']", fieldName);
            String fieldsInRow = rowLocator.concat("/../../div");

            return web.findElementsToStrings(By.xpath(fieldsInRow));
        }


        public String isFieldEditable(int column){
            String actual = web.findElement(By.xpath("//div[.='No. of months in contract term per FY']/../../div["+column+"]/div[contains(@class,'ng-scope')]/div")).getAttribute("ng-if");

            if(actual.equals("!cell.readOnly"))
                return "Editable";
            else
                return "Not Editable";
        }

        public boolean isBillingTableVisisble(){
            return web.isElementVisible(By.xpath("//div[@data-ng-if='vm.model.isBillingExpense']"));
        }
    }

    public PolicyExceptionSection getPolicyexceptionSection(){
        if(web.isElementVisible(By.xpath(policyExceptionSectionLocator)))
            return new PolicyExceptionSection();
        else throw new ElementNotVisibleException("Check if Policy Exception Section loaded on CostItem Page");
    }

    public void waitUntilAddPolicyExceptionSectionAppears(){
        web.waitUntilElementAppearVisible(By.xpath("//form[@name='frmPolicyException']"));
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

        public List<String> loadPolicyexceptionTable(){
            List<String> actualValues = new ArrayList<>();
            String rowLocator = " //*[@id=\"content\"]//cost-line-items//policy-exceptions//policy-exceptions-table//md-table-container//tr";
            int stageNameColumnNumber;
            for(int i=1;i<=web.findElements(By.xpath(rowLocator)).size()-1;i++) {
                for(int j=1;j<=web.findElements(By.xpath(rowLocator.concat("[" + i + "][@role='button']/td"))).size()-1;j++) {
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

    public String checkCostDetailFieldByName(String fieldName) {
        String textLocatorFormat = "//div[.='%s']/../div[3]";
        By textFieldLocator = By.xpath(String.format(costsItemsPageFormat+textLocatorFormat, fieldName));
            if (web.isElementPresent(textFieldLocator)) {
                scrollToFieldName(web.findElement(textFieldLocator));
                return web.findElement(textFieldLocator).getText().replaceAll(",","");
            }  else {
                throw new IllegalArgumentException(String.format("Unknown cost item field name '%s'", fieldName));
            }
    }

    public boolean checkCurrencyOnCostItePage(String cur){
        List <WebElement> sections = web.findElements(By.xpath(sectionLocator));
        for (int i=1;i<=sections.size();i++){
            String sectionCurrencyLocator = sectionLocator+"[" +i+ "]//md-select-value[contains(@id,'select_value_label_')]/span[1]/div";
            if (web.findElement(By.xpath(sectionCurrencyLocator)).getText().equals(cur))
                return true;
            return false;
        }
        return false;
    }

    public boolean verifyCurrencyFieldIsEditable(){
        List <WebElement> sections = web.findElements(By.xpath(sectionLocator));
        for (int i=1;i<sections.size();i++){
            String sectionCurrencyLocator = sectionLocator+"[" +i+ "]//md-select-value[contains(@id,'select_value_label_')]/..";
            if (web.findElement(By.xpath(sectionCurrencyLocator)).getAttribute("aria-disabled").equals("false"))
                return true;
            return false;
        }
        return false;
    }

    public void editCurrencyOnCostSections(String currency) {
        List<WebElement> sections = web.findElements(By.xpath(sectionLocator));
        for (int i = 1; i < sections.size(); i++) {
            web.findElement(By.xpath(sectionLocator.concat("[" + i + "]/div[1]//md-select"))).click();
            for (WebElement elements : web.findElements(By.xpath(listBoxValueFormat))) {
                if (elements.getText().equalsIgnoreCase(currency)) {
                    elements.click();
                    web.sleep(1000);
                    break;
                }
            }
        }
    }

    public boolean checkGrandTotalCurrency(String currencyGroup ,String curSymbol){
        String grandTotallocator = "//cost-line-items//div[@class='cost-line-item-total layout-row']/";
        switch (currencyGroup) {
            case "Local":
                if (web.findElement(By.xpath(grandTotallocator.concat("div[2]"))).getText().substring(0, 1).equals(curSymbol))
                    return true;
            case "Default":
                if (web.findElement(By.xpath(grandTotallocator.concat("div[3]"))).getText().substring(0, 1).equals(curSymbol))
                    return true;
        }
        return false;
    }

    public List<String> checkCurrencyConversion(String fieldName) {
        By textFieldLocator = By.xpath(String.format(costsItemsPageFormat + textFieldLocatorFormat, fieldName));
        By textFieldLocator1 = By.xpath(String.format(costsItemsPageFormat + "//div[.='%s']/../div[3]", fieldName));
        List<String> actualValues = new ArrayList<>();
        if (web.isElementPresent(textFieldLocator)) {
            scrollToFieldName(web.findElement(textFieldLocator));
            actualValues.add(fieldName+": "+ (web.findElement(textFieldLocator1).getText().replaceAll("$","").trim()));
        }
        return actualValues;
    }

    public void selectCurrencyForActivateDirectBilling(String fieldName,String fieldValue){
        String locatorFormat = costsItemsPageFormat.concat("//ads-md-select[@placeholder='%s']//md-select");
        By locator = By.xpath(String.format(locatorFormat, CatagoryDPV.findByType(fieldName).getCurrencyFieldName()));
        web.findElement(locator).click();
        for (WebElement element : web.findElements(By.xpath("//md-content[@class='_md']/div/md-option[@ng-repeat=\"item in $ctrl.currencies\"]/div"))) {
            if (element.getText().equalsIgnoreCase(fieldValue)) {
                web.sleep(500);
                scrollToFieldName(element);
                web.sleep(500);
                element.click();
                web.sleep(1000);
                break;
            }
        }
    }

    public boolean checkVendorDropdownExists(String fieldName, String fieldValue){
        By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, fieldName));
        if (web.isElementPresent(comboBoxLocator))
            scrollToFieldName(web.findElement(comboBoxLocator));
        return (web.findElement(comboBoxLocator).getAttribute("value")).equals(fieldName);
    }

    public boolean checkRadioButtonsOnCostItemPage(String fieldName, String fieldValue){
        String value = null;
        if(fieldName.equals("Activate Direct Billing"))
             value = web.findElement(By.xpath(String.format("//ads-md-radio-button[1]//md-radio-button/div[2]/span/span[contains(text(),'%s')]/../../..",fieldName))).getAttribute("aria-checked");
        if(fieldName.equals("Do Not Activate Direct Billing"))
            value = web.findElement(By.xpath(String.format("//ads-md-radio-button[2]//md-radio-button/div[2]/span/span[contains(text(),'%s')]/../../..",fieldName))).getAttribute("aria-checked");
        return (value.equalsIgnoreCase(fieldValue));
    }

    public String checkSuccessfulMessage(){
        return web.findElement((By.xpath("//md-divider[@class='vendor-select-divider ng-scope']/following-sibling::p[2]"))).getText();
    }

    private void editCurrencyForSelectedVendor(AdCostsProductionDetailsPage prodPage,String categoryName, String fieldValue){
        if(!fieldValue.isEmpty())
            prodPage.selectCurrencyForActivateDirectBilling(categoryName, fieldValue.trim());
    }

    public boolean verifyCurrencyFieldIsEditable(String category){
        String locatorFormat = costsItemsPageFormat.concat("//ads-md-select[@placeholder='%s']//md-select");
        By locator = By.xpath(String.format(locatorFormat, CatagoryDPV.findByType(category).getCurrencyFieldName()));
        return (web.findElement(locator).getAttribute("aria-disabled").equals("false"));
    }

    public boolean checkVendorCanBeAddedOnFly(String fieldName, String fieldValue){
        By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, fieldName));
        if (web.isElementPresent(comboBoxLocator))
            scrollToFieldName(web.findElement(comboBoxLocator));
        return (web.findElement(comboBoxLocator).getAttribute("aria-invalid")).equals("false");
    }

    public boolean checkUsageVendorSectionExists(){
        return (web.isElementVisible(By.xpath("//md-divider[@class='vendor-select-divider ng-scope']")));
    }

    public boolean verifyVendorFieldIsEditable(String fieldName){
        String locatorFormat = costsItemsPageFormat.concat("//*[contains(@placeholder,'%s')][@role='combobox']/../..");
        By locator = By.xpath(String.format(locatorFormat, fieldName));
        return (web.findElement(locator).getAttribute("aria-disabled").equals("false"));
    }

    public void waitUntilCostItemPageDisappears(){
       if(web.isElementVisible(costsItemsPageLocator)) {
           clickBtnByName("Continue");
       }
    }
}