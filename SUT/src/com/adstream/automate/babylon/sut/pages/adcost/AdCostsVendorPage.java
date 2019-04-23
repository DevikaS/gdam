package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;


public class AdCostsVendorPage extends BaseAdCostPage<AdCostsVendorPage> {

    private String textFieldLocatorFormat = "//input[@placeholder='%s'][@id='input']";
    private String inputFieldLocatorFormat = "//md-input-container/label[contains(text(),'%s')]/following-sibling::input";
    private String checkBoxFormat1 = "//md-input-container/md-checkbox[@aria-label='%s']//div[@class='md-icon']";
    private String checkBoxFormat2 = "//ads-md-checkbox/md-checkbox//*[contains(text(), '%s')]/../../..//div[@class='md-icon']";
    private String radioButtonFormat = "//md-radio-button[@value='%s']/div[1]";
    private String listBoxFormat1 = "//*[@placeholder='%s'][@role='listbox']";
    private String listBoxFormat2= "//md-input-container/label[contains(text(),'%s')]/following-sibling::md-select";
    private String listBoxValueFormat = "//md-content//md-option/div[contains(text(),'%s')]";
    private String btnFormat = "//vendors-list//button//span[contains(text(),'%s')]";
    By vendorCreationPageVisibleLocator = By.xpath("//md-backdrop[@class='md-sidenav-backdrop md-opaque ng-scope']");


    public AdCostsVendorPage(ExtendedWebDriver web) {
        super(web);
    }
    public void load() {
        super.load();
    }

    public void clickNewBtnOnVendorPage(String btn){
           web.click(By.xpath(String.format(btnFormat,btn)));
    }

    public void clickActionOnPaymentRulePage(String btn){
        web.click(By.xpath(String.format("//*[contains(@id,\"dialogContent_\")]//md-input-container//ads-md-button//button//span[contains(text(),'%s')]", btn)));
    }

    public void fillDefaultCurrenyField(String fieldName,String currency){
        web.click(By.xpath("//md-select[@placeholder='Default Currency']"));
        selectOptionFromDropDown(fieldName,currency);
    }

    public void fillFieldByName(String fieldName, String fieldValues) {
        By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName));
        By inputFieldLocator = By.xpath(String.format(inputFieldLocatorFormat, fieldName));
        By listBoxLocator1 = By.xpath(String.format(listBoxFormat1, fieldName));
        By listBoxLocator2 = By.xpath(String.format(listBoxFormat2, fieldName));
        By radioButtonsFieldLocator = By.xpath(String.format(radioButtonFormat,fieldValues));
        By checkBoxFormatLocator1 = By.xpath(String.format(checkBoxFormat1,fieldName));
        By checkBoxFormatLocator2 = By.xpath(String.format(checkBoxFormat2,fieldName));
//        By checkBoxFormatLocator3 = By.xpath(String.format(checkBoxFormat3,fieldName));


        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(inputFieldLocator)) {
                web.typeClean(inputFieldLocator, fieldValue);
            }else if (web.isElementPresent(textFieldLocator)) {
                web.typeClean(textFieldLocator, fieldValue);
            }
            else if (web.isElementPresent(listBoxLocator1)) {
                web.click(listBoxLocator1);
                Common.sleep(500);
                selectOptionFromDropDown(fieldName, fieldValue);
            }
            else if (web.isElementPresent(listBoxLocator2)) {
                web.click(listBoxLocator2);
                Common.sleep(500);
                selectOptionFromDropDown(fieldName,fieldValue);
            }
            else if (web.isElementPresent(radioButtonsFieldLocator)) {
               web.findElement(radioButtonsFieldLocator).click();
            }
            else if (web.isElementPresent(checkBoxFormatLocator1)) {
                String check = web.findElement(By.xpath(String.format(checkBoxFormat1.concat("/../.."),fieldName))).getAttribute("aria-checked");
                if (!check.equalsIgnoreCase(fieldValue))
                   web.findElement(checkBoxFormatLocator1).click();
            }
            else if (web.isElementPresent(checkBoxFormatLocator2)) {
                String check = web.findElement(By.xpath(String.format(checkBoxFormat2.concat("/../.."),fieldName))).getAttribute("aria-checked");
                if (!check.equalsIgnoreCase(fieldValue)||!check.equalsIgnoreCase("true") )
                    web.findElement(checkBoxFormatLocator2).click();
            }
            else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }

    private void selectOptionFromDropDown(String fieldName, String fieldValue){
        String locator = generateLocatorForListBoxValues(fieldName);
        for (WebElement element : web.findElements(By.xpath(String.format(locator,fieldValue)))) {
            if (element.getText().equalsIgnoreCase(fieldValue)) {
                web.scrollToElement(element);
                element.click();
                break;
            }
        }
    }

    public void fillPaymentSplitTable(String fieldName, String fieldValues){
        String tableColumnsLocator = "//*[@class='payment-split-table-item payment-split-header layout-row']/div[@ng-repeat='stage in $ctrl.splitStages']";
        String stageInputPercentageLocator = "//*[@class='payment-split-table-item payment-split-item ng-scope layout-row']//ads-md-input[@ng-repeat='stage in $ctrl.splitStages']";
        int noOfColumns = web.findElements(By.xpath(tableColumnsLocator)).size();

        for (int i=1; i<= noOfColumns; i++){
            String value = web.findElement(By.xpath(tableColumnsLocator.concat("[" + i + "]"))).getText();
            if(value.equalsIgnoreCase(fieldName)){
                WebElement element  = web.findElement(By.xpath(stageInputPercentageLocator.concat("["+ i + "]")));
                element.click();
                element.sendKeys(Keys.BACK_SPACE);
                element.sendKeys(fieldValues);
                break;
            }
        }
    }
    public void loadPaymentSplitTable(String fieldName, String fieldValues){
        String tableColumnsLocator = "//*[@class='payment-split-table-item payment-split-header layout-row']/div[@ng-repeat='stage in $ctrl.splitStages']";
        String stageInputPercentageLocator = "//*[@class='payment-split-table-item payment-split-item ng-scope layout-row']//ads-md-input[@ng-repeat='stage in $ctrl.splitStages']";
        int noOfColumns = web.findElements(By.xpath(tableColumnsLocator)).size();

        for (int i=1; i<= noOfColumns; i++){
            String value = web.findElement(By.xpath(tableColumnsLocator.concat("[" + i + "]"))).getText();
            if(value.equalsIgnoreCase(fieldName)){
                WebElement element  = web.findElement(By.xpath(stageInputPercentageLocator.concat("["+ i + "]")));
                element.click();
                element.sendKeys(Keys.BACK_SPACE);
                element.sendKeys(fieldValues);
                break;
            }
        }
    }
    public void saveVendors(){
        web.findElement((By.xpath("//button/span/ads-spinner/following-sibling::span[contains(text(),'Save')]"))).click();
        web.isElementVisible(By.xpath("//span[contains(text(),'Vendor has been saved')]"));
    }

    public void SearchForVendor(String vendor){
        WebElement element = web.findElement(By.xpath("//md-input-container//label[contains(text(),'Filter')]"));
        element.click();
        element.sendKeys(vendor);
    }

    public int getVendorsRowCount(){
        return web.findElements(By.xpath("//md-list-item[@ng-repeat='vendor in $ctrl.vendors']")).size();
    }

    public void openVendorDetails(int rowCount){
        web.sleep(500);
        web.click(By.xpath(String.format("//md-list-item[@ng-repeat='vendor in $ctrl.vendors']".concat("[" +rowCount+ "]").concat("/div/button"))));
        web.waitUntilElementAppear(vendorCreationPageVisibleLocator);
        web.sleep(1000);
    }

    public String loadVendorDetails(int rowCount) {
        return (web.findElement(By.xpath(String.format("//md-list-item[@ng-repeat='vendor in $ctrl.vendors']".concat("[" +rowCount+ "]").concat("/div/button")))).getAttribute("aria-label"));
    }

    private String generateLocatorForListBoxValues(String fieldName){
        String listBoxValueFormatLocator = listBoxValueFormat;
        String locatorFormat = "//md-content//md-option[@ng-repeat='(key, value) in criterion.values']/div";
        switch (fieldName){
            case "Category":
                listBoxValueFormatLocator = "//md-content//md-option[contains(@ng-repeat,'category in $ctrl.')][@ng-value='category']/div";
                break;
            case "Default Currency":
                listBoxValueFormatLocator = "//md-content//md-option[@ng-repeat='currency in $ctrl.paymentCurrencies']/div";
                break;
            case "BudgetRegion":
                listBoxValueFormatLocator = locatorFormat;
                break;
            case "CostType":
                listBoxValueFormatLocator = locatorFormat;
                break;
            case "ContentType":
                listBoxValueFormatLocator = locatorFormat;
                break;
            case "ProductionType":
                listBoxValueFormatLocator = locatorFormat;
                break;
            case "IsAIPE":
                listBoxValueFormatLocator = locatorFormat;
                break;
            case "Costs Total Type":
                listBoxValueFormatLocator = "//md-content//md-option[@ng-repeat='type in $ctrl.costTotalTypes']/div";
                break;
        }
        return listBoxValueFormatLocator;
    }

    public VendorDetails getVendorDetailsSection(){
        return new VendorDetails();
    }

    public class VendorDetails{
        private String vendorName;
        private String sapVendorCode;
        private String production;
        private List<String> Category = new ArrayList<>();
        private String currency;
        private String ruleName;
        private String budgetRegion;
        private String contentType;
        private String productionType;
        private String totalCostAmount;
        private String pymntSplit;

        public String getVendorName() {
            return vendorName;
        }

        public void setVendorName(String vendorName) {
            vendorName = vendorName;
        }

        public String getSapVendorCode() {
            return sapVendorCode;
        }

        public void setSapVendorCode(String sapVendorCode) {
            sapVendorCode =sapVendorCode;
        }

        public String getProduction() {
            return production;
        }

        public void setProduction(String production) {
            this.production = production;
        }

        public String getProductionType() {
            return productionType;
        }

        public void setProductionType(String productionType) {
            this.productionType = productionType;
        }

        public List<String> getCategory(){
            return Category;
        }

        public void setCategory(List<String> Category) {
            this.Category = Category;
        }

        public String getCurrency() {
            return currency;
        }

        public void setCurrency(String currency) {
            this.currency = currency;
        }

        public String getRuleName() {
            return ruleName;
        }

        public void setRuleName(String ruleName) {
            this.ruleName = ruleName;
        }

        public String getpymntSplit() {
            return pymntSplit;
        }

        public void setpymntSplit(String pymntSplit) {
            this.pymntSplit = pymntSplit;
        }

        public String getBudgetRegion() {
            return budgetRegion;
        }

        public void setBudgetRegion(String budgetRegion) {
            this.budgetRegion = budgetRegion;
        }

        public String getContentType() {
            return contentType;
        }

        public void setContentType(String contentType) {
            this.contentType = contentType;
        }

        public String getTotalCostamount() {
            return totalCostAmount;
        }

        public void setTotalCostamount(String totalCostAmount) {
            this.totalCostAmount = totalCostAmount;
        }



        public void loadVendorDetail(){
          vendorName =(web.findElement(By.xpath("//md-input-container/label[contains(text(),'Name')]/following-sibling::input")).getAttribute("value"));
          sapVendorCode=(web.findElement(By.xpath("//md-input-container/label[contains(text(),'SAP Vendor Code')]/following-sibling::input")).getAttribute("value"));
          getCategories();
          currency = web.findElement(By.xpath("//md-select[@placeholder='Default Currency']")).getAttribute("aria-label");
          loadPaymentSplitTable();
        }

        private void getCategories(){
            int count = web.findElements(By.xpath("//ads-md-checkbox/md-checkbox[@aria-checked='true']")).size();
            for (WebElement cat: web.findElements(By.xpath("//ads-md-checkbox/md-checkbox[@aria-checked='true']/div[2]/span/span"))){
               Category.add(cat.getText());
            }
        }

        private void loadPaymentSplitTable(){
            String tableColumnsLocator = "//table//tr//th";
            String tableRowsLocator = "//table//tbody//tr";
            int noOfColumns = web.findElements(By.xpath(tableColumnsLocator)).size();
            int noOfRows = web.findElements(By.xpath(tableRowsLocator)).size();
            for (int i=1; i<= noOfRows; i++){
                for (int j=1; j<= noOfColumns; j++){
                    String headerValue = web.findElement(By.xpath(tableColumnsLocator.concat("[" + j + "]"))).getText();
                    String value = web.findElement(By.xpath(tableRowsLocator.concat("[" + i + "]").concat("//td").concat("[" + j + "]"))).getText();
                    switch(headerValue){
                     case "Name":
                       ruleName=value;
                       break;
                     case "Payment":
                       pymntSplit=value;
                        break;
                        case "BudgetRegion":
                          budgetRegion= value;
                            break;
                        case "ContentType":
                          contentType= value;
                            break;
                        case "ProductionType":
                          productionType = value;
                            break;
                        case "TotalCostAmount":
                          totalCostAmount=value;
                            break;
                    }
                }
            }
        }
    }

    public void clickEditCategoryOption(String catagory){
        String selectOptionLocator = "//*[@class='_md md-open-menu-container md-whiteframe-z2 md-active md-clickable']//span[contains(text(),'Edit Category')]";
        web.findElement(By.xpath(String.format("//ads-md-checkbox/md-checkbox//*[contains(text(), '%s')]/../../../../following-sibling :: md-menu", catagory))).click();
        web.waitUntilElementAppear(By.xpath(selectOptionLocator));
        web.sleep(500);
        web.findElement(By.xpath(selectOptionLocator)).click();
        web.waitUntilElementAppear(By.xpath(String.format("//h3[contains(text(), '%s')]", catagory)));
    }

    public boolean isWarningMessagePresent(){
        return (web.isElementVisible(By.xpath("//span[contains(text(),'Vendor has not been saved. A vendor with the same Name, or SAP Code already exists')]")));
    }
}