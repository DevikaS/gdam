package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.babylon.JsonObjects.adcost.enums.CatagoryDPV;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Raja.Gone on 26/04/2017.
 */
public class AdCostsProductionDetailsPage extends BaseAdCostPage<AdCostsProductionDetailsPage> {

    private String textFieldLocatorFormat = "//*[contains(@id,'input')][@placeholder='%s']";
    private String comboBoxLocatorFormat = "//*[contains(@placeholder,'%s')] [@role='combobox']";
    private String radioButtonsFieldLocatorFormat = "//vendor-select[@currency-label=\"'%s'\"]//ads-md-radio-button";
    private String listBoxFormat = "//*[contains(@placeholder,'%s')][@role='listbox']";
    private String listBoxValueFormat = "//md-content[@class='_md']/div/md-option[@ng-repeat='item in $ctrl.countries']/div";
    private String comboBoxValueFormat = "//ul[@class='md-autocomplete-suggestions']";
    private String productionDetailsPageFormat = "//cost-production-details";
    private String travelCostFormLocator="//form[@name='travelCostForm']";
    private String travelDetailsSectionLocator = "//travel-costs-list";
    private String datePickerFormat = "//ads-md-datepicker[@placeholder=\"%s\"]//span[@code=\"calendar\"]";
    private String formInfoFormat = "//p[contains(@class,'lead')]";


    By productionDetailsPageLocator = By.xpath(productionDetailsPageFormat);

    public AdCostsProductionDetailsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public boolean waitUntilProdDetailsPageVisible() { return web.isElementVisible(productionDetailsPageLocator); }

    public void waitUntilProdDetailsPageDisappears() { web.waitUntilElementDisappear(productionDetailsPageLocator); }

    public void waitUntilAllFeildsLoads() {
        final long timeOut = 500;
        final long globalTimeout= 5 * 60 * 1000; // 5 mins
        By fieldsLocator = By.xpath("//fieldset");
        long start = System.currentTimeMillis();
        do{
            Common.sleep(timeOut * 1);
        }while(!web.isElementVisible(fieldsLocator) && System.currentTimeMillis() - start < globalTimeout);
        if (System.currentTimeMillis() - start > globalTimeout)
            throw new TimeoutException("Check if fields section loaded on Production-Details page!!");
        web.click(By.xpath("//h2"));
    }

    public void fillFieldByName(String fieldName, String fieldValues) {
        By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName));
        By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, fieldName));
        By listBoxLocator = By.xpath(String.format(listBoxFormat,fieldName));
        By radioButtonsFieldLocator =  By.xpath(String.format(radioButtonsFieldLocatorFormat,fieldName));
        By buttonToClickLocator = By.xpath(String.format(buttonNameFormat, fieldName));
        By datePickerLocator = By.xpath(String.format(productionDetailsPageFormat+datePickerFormat, fieldName));
        By dateFieldLocator =  By.xpath(String.format("//*[@class='ads-md-datepicker']//input[@placeholder='%s']", fieldName));

        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(datePickerLocator)) {
                web.click(datePickerLocator);
                web.typeClean(dateFieldLocator, fieldValue);
                web.click(By.xpath(String.format("//*[@class='ads-md-datepicker']//ads-md-input[@placeholder='%s']/../../following-sibling::div//span[.='Done']", fieldName)));
            } else if (web.isElementPresent(radioButtonsFieldLocator)) {
                WebElement element = web.findElement(radioButtonsFieldLocator);
                String radioButtonParent = String.format(radioButtonsFieldLocatorFormat,fieldName);
                element.findElement(By.xpath(String.format(productionDetailsPageFormat+radioButtonParent+"[@ng-value='%s']", fieldValue))).click();
            } else if(web.isElementPresent(listBoxLocator)) {
                web.findElement(listBoxLocator).click();
                if(fieldName.contains("City"))
                    listBoxValueFormat = listBoxValueFormat.replace("countries","cities");
                for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        break;
                    }
                }
            } else if (web.isElementPresent(comboBoxLocator)) {
                web.typeClean(comboBoxLocator, fieldValue);
                Common.sleep(3000);
                for (WebElement element : web.findElements(By.xpath(comboBoxValueFormat))) {
                    if (element.getText().equalsIgnoreCase(fieldValue)) {
                        element.click();
                        break;
                    }
                }
            } else if (web.isElementPresent(textFieldLocator)) {
                web.typeClean(textFieldLocator, fieldValue);
            } else if(web.isElementPresent(buttonToClickLocator)){
                new Button(this, buttonToClickLocator).click();
            } else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }

    public boolean checkVendorPresentUnderCategory(String category, String vendorName) {
        By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, category));
        if (web.isElementPresent(comboBoxLocator)) {
            web.typeClean(comboBoxLocator, vendorName);
            Common.sleep(2000);
            if(web.isElementVisible(By.xpath(comboBoxLocatorFormat)))
                return true;
            return false;
        }
        return false;
    }

    public AdCostsTravelCostFormPage getTravelCostFormPage() {
        if (!web.isElementPresent(By.xpath(travelCostFormLocator))) {
            web.findElement(By.xpath(String.format(buttonNameFormat, "Add Travel"))).click();
            return new AdCostsTravelCostFormPage();
        } else if (web.isElementPresent(By.xpath(travelCostFormLocator)))
            return new AdCostsTravelCostFormPage();
        else return null;
    }


    public TravelDetailsSection getTravelCostDetails(){
        if(web.isElementPresent(By.xpath(travelDetailsSectionLocator)))
            return new TravelDetailsSection();
        else
            return null;
    }

    public  void selectActivateDirectBilling(String fieldName){
        String locatorFormat = productionDetailsPageFormat.concat("//vendor-select[@category-name=\"'%s'\"]//ads-md-radio-button[@ng-value='true']");
        By locator = By.xpath(String.format(locatorFormat,fieldName));
        web.findElement(locator).click();
    }

    public void selectCurrencyForActivateDirectBilling(String fieldName,String fieldValue){
        String locatorFormat = productionDetailsPageFormat.concat("//ads-md-select[@placeholder='%s']//md-select");
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

    public String getFormInfoText() {
     return web.findElement(By.xpath(formInfoFormat)).getText();
    }

    public class AdCostsTravelCostFormPage {
        private String textFieldLocatorFormat = "//input[contains(@id,'input')][@placeholder='%s']";
        private String textAreaLocatorFormat = "//textarea[contains(@id,'input')][@placeholder='%s']";
        private String comboBoxLocatorFormat = "//*[contains(@placeholder,'%s')] [@role='combobox']";
        private String radioButtonsFieldLocatorFormat = "//legend[contains(text(),\"%s\")]";
        private String listBoxFormat = "//*[contains(@placeholder,'%s')][@role='listbox']";
        private String listBoxValueFormat = "//md-content[@class='_md']/div/md-option/div";
        private String comboBoxValueFormat = "//ul[@class='md-autocomplete-suggestions']";
        private String travelCostFormLocator = "//form[@name='travelCostForm']";

        public void fillFieldByName(String fieldName, String fieldValues) {
            By textFieldLocator = By.xpath(String.format(textFieldLocatorFormat, fieldName));
            By textAreaFieldLocator = By.xpath(String.format(textAreaLocatorFormat, fieldName));
            By comboBoxLocator = By.xpath(String.format(comboBoxLocatorFormat, fieldName));
            By listBoxLocator = By.xpath(String.format(travelCostFormLocator+listBoxFormat, fieldName));
            By radioButtonsFieldLocator = By.xpath(String.format(radioButtonsFieldLocatorFormat, fieldName));
            By buttonToClickLocator = By.xpath(String.format(buttonNameFormat, fieldName));

            for (String fieldValue : fieldValues.split(",")) {
                if (web.isElementPresent(radioButtonsFieldLocator)) {
                    web.findElement(By.xpath(String.format(travelCostFormLocator + "//md-radio-button[@value='%s']", fieldValue))).click();
                } else if (web.isElementPresent(listBoxLocator)) {
                    web.findElement(listBoxLocator).click();
                    for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                        if (element.getText().equalsIgnoreCase(fieldValue)) {
                            element.click();
                            break;
                        }
                    }
                } else if (web.isElementPresent(comboBoxLocator)) {
                    web.typeClean(comboBoxLocator, fieldValue);
                    Common.sleep(2000);
                    for (WebElement element : web.findElements(By.xpath(comboBoxValueFormat))) {
                        if (element.getText().equalsIgnoreCase(fieldValue)) {
                            element.click();
                            break;
                        }
                    }
                } else if (web.isElementPresent(textFieldLocator)) {
                    web.typeClean(textFieldLocator, fieldValue);
                } else if (web.isElementPresent(textAreaFieldLocator)) {
                    web.typeClean(textAreaFieldLocator, fieldValue);
                } else if (web.isElementPresent(buttonToClickLocator)) {
                    web.findElement(buttonToClickLocator).click();
                } else {
                    throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
                }
            }
        }

        public String getTravelCostFormLocator(){
            return travelCostFormLocator;
        }
    }

    public class TravelDetailsSection {
        private String travelDetailsRowLocator = "//tr[@ng-repeat='cost in $ctrl.travelCostsModels']";
        private String travelerName;
        private String travelerRole;
        private String shootCity;
        private String days;
        private String travelType;
        private String totalAgencyTravelCosts;

        public String getTotalAgencyTravelCosts() {
            return totalAgencyTravelCosts;
        }

        public void setTotalAgencyTravelCosts(String totalAgencyTravelCosts) {
            this.totalAgencyTravelCosts = totalAgencyTravelCosts;
        }

        public String getTravelType() {
            return travelType;
        }

        public void setTravelType(String travelType) {
            this.travelType = travelType;
        }

        public String getDays() {
            return days;
        }

        public void setDays(String days) {
            this.days = days;
        }

        public String getShootCity() {
            return shootCity;
        }

        public void setShootCity(String shootCity) {
            this.shootCity = shootCity;
        }

        public String getTravelerRole() {
            return travelerRole;
        }

        public void setTravelerRole(String travelerRole) {
            this.travelerRole = travelerRole;
        }

        public String getTravelerName() {
            return travelerName;
        }

        public void setTravelerName(String travelerName) {
            this.travelerName = travelerName;
        }

        public TravelDetailsSection() {
            web.findElement(By.xpath(travelDetailsSectionLocator));
        }

        public int getRowCount(String travellerRowName){
            int rowCount = web.findElements(By.xpath(travelDetailsSectionLocator.concat("//tbody//tr"))).size();
            for(int i=1;i<=rowCount;i++)
                if(web.findElement(By.xpath(travelDetailsSectionLocator.concat("//tbody//tr["+i+"]//td[1]"))).getText().equals(travellerRowName))
                    return i;
            throw new Error("Check Travel Details: Couldn't found row with travellerName: "+travellerRowName);
        }

        public void loadTravelDetailsSection(String travellerRowName) {
            int childNode=getRowCount(travellerRowName);
            String tableHeaderLocator = travelDetailsSectionLocator + "//thead//th[@class='md-column ng-isolate-scope']";
            int tableColumnCount = web.findElements(By.xpath(tableHeaderLocator)).size();
            for (int j = 1; j <= tableColumnCount; j++) {
                By tableCellLocator = By.xpath(travelDetailsSectionLocator + "//tr[@class='table-item item md-row ng-scope'][" + childNode + "]/td[" + j + "]");
                String tableColumnName = web.findElement(By.xpath(travelDetailsSectionLocator + "//thead//th[" + j + "]")).getText();
                String cellValue = web.findElement(tableCellLocator).getText();
                switch (tableColumnName) {
                    case "Traveller name":
                        setTravelerName(cellValue);
                        break;
                    case "Traveller role":
                        setTravelerRole(cellValue);
                        break;
                    case "Shoot city":
                        setShootCity(cellValue);
                        break;
                    case "No. of days":
                        setDays(cellValue);
                        break;
                    case "Travel type":
                        setTravelType(cellValue);
                        break;
                    case "Total Agency Travel Costs":
                        setTotalAgencyTravelCosts(cellValue);
                        break;
                }
            }
        }

        public int getRowsInTravelDetailsSection() {
            return web.findElements(getTravelDetailsRowLocator()).size();
        }

        private By getTravelDetailsRowLocator(){
            return By.xpath(travelDetailsSectionLocator.concat(travelDetailsRowLocator));
        }

        public void selectOptionFromTravelCostMenuItem(String action,int sectionCount){
            web.findElement(getTravelDetailsMenuLocator(sectionCount)).click();
            clickBtnInMenuItem(action);
        }

        private By getTravelDetailsMenuLocator(int sectionCount){
            String sectionFormat = travelDetailsSectionLocator.concat("//tr[@ng-repeat='cost in $ctrl.travelCostsModels'][" + (sectionCount) + "]//button");
            return By.xpath(sectionFormat);
        }

        public String getTravelerNameForGivenSection(int travelCostRowNumber){
            String travelerNameLocator=travelDetailsSectionLocator.concat(travelDetailsRowLocator).concat("[").concat(Integer.toString(travelCostRowNumber)).concat("]/td[1]");
            return web.findElement(By.xpath(travelerNameLocator)).getText();
        }

        public boolean isTravellerDetailsPresent(String travellerName) {
            int rows = getRowsInTravelDetailsSection();
            String rowLocator = travelDetailsSectionLocator.concat(travelDetailsRowLocator);
            for (int i = 1; i <= rows; i++) {
                if(travellerName.equalsIgnoreCase(web.findElement(By.xpath(rowLocator.concat("[").concat(Integer.toString(i)).concat("]/td[1]"))).getText()))
                    return true;
            }
            return false;
        }
    }

    public boolean verifyCurrencyFieldIsEditable(String category){
        String locatorFormat = productionDetailsPageFormat.concat("//ads-md-select[@placeholder='%s']//md-select");
        By locator = By.xpath(String.format(locatorFormat, CatagoryDPV.findByType(category).getCurrencyFieldName()));
        if (web.findElement(locator).getAttribute("aria-disabled").equals("false"))
            return true;
        return false;
    }

    public boolean verifyVendorFieldIsEditable(String fieldName){
        String locatorFormat = productionDetailsPageFormat.concat("//*[contains(@placeholder,'%s')][@role='combobox']/../..");
        By locator = By.xpath(String.format(locatorFormat, fieldName));
        return (web.findElement(locator).getAttribute("aria-disabled").equals("false"));
    }

    public boolean verifyActivatevendorFieldIsEditable(String catgName){
        String locatorFormat = productionDetailsPageFormat.concat("//vendor-select[@category-name=\"'%s'\"]//ads-md-radio-button//md-radio-button");
        List<WebElement>  radioButtons = web.findElements(By.xpath(String.format(locatorFormat,catgName)));
        boolean flag=false;
        for (int i=0;i< radioButtons.size();i++) {
            if (radioButtons.get(i).getAttribute("aria-disabled").equals("false"))
                flag=true;
        }
        return flag;
    }
}

