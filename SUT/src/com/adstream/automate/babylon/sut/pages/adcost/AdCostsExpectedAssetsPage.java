package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created by Raja.Gone on 08/05/2017.
 */
public class AdCostsExpectedAssetsPage extends BaseAdCostPage<AdCostsExpectedAssetsPage> {

    private String expectedAssetsPageFormat = "//cost-expected-assets";
    private String parentFormLocator;
    private String expectedAssetFormLocator = parentFormLocator ="//form[@name='expectedAssetForm']";
    private String expectedAssetsSectionLocator =expectedAssetsPageFormat+"//expected-asset-list";
    private String editDataSectionLocator;
    private String aDIdAlert = "//span[@class='md-toast-text ng-binding'][@role='alert'][contains(text(),'%s')]";

    By expectedAssetsPageLocator = By.xpath(expectedAssetsPageFormat);

    public AdCostsExpectedAssetsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public boolean waitUntilExpectedAssetsPageVisible() { return web.isElementVisible(expectedAssetsPageLocator); }

    public void waitForAdIdSync(){
        web.waitUntilElementDisappear(By.xpath(String.format(aDIdAlert,"Ad-ID correct. Saving...")));
    }

    public AdCostsExpectedAssetFormPage getAdCostsExpectedAssetsFormPage() {
        if (web.isElementPresent(By.xpath(expectedAssetsPageFormat))) {
            clickBtnByName("Add a new expected asset");
            return new AdCostsExpectedAssetFormPage();
        } else if (web.isElementPresent(By.xpath(expectedAssetFormLocator)))
            return new AdCostsExpectedAssetFormPage();
        else throw new NoSuchElementException("Unable to open/locate ExpectedAssets section with locators: "+expectedAssetFormLocator+"  or "+expectedAssetFormLocator);
    }

    public String getParentLocator(){ return parentFormLocator; }

    public AdCostsExpectedAssetsSection getExpectedAssetsSection(){
        if(web.isElementPresent(By.xpath(expectedAssetsSectionLocator)))
            return new AdCostsExpectedAssetsSection();
        else
            return null;
    }

    // By default 'sectionCount' = 0, if number of 'Expected Assets/deliverables' = 1
    public void selectOptionFromExpectedAssetsMenuItem(String action,int sectionCount){
        web.findElement(getExpectedAssetsMenuLocator(sectionCount)).click();
        clickBtnInMenuItem(action);
    }

    private By getExpectedAssetsMenuLocator(int sectionCount){
        String sectionFormat;
        if(!(sectionCount==0))
            sectionFormat = expectedAssetsSectionLocator + "//tr[" + sectionCount + "]//button";
        else sectionFormat = expectedAssetsSectionLocator+"//button";
        return By.xpath(sectionFormat);
    }

    private String buttonFormatOnAlert = "//md-dialog[@role=\"dialog\"]//span[contains(text(),'%s')]";

    public void clickBtnOnAlert(String btnName){
        By buttonLocatorOnAlert = By.xpath(String.format(buttonFormatOnAlert, btnName));
        if(web.isElementPresent(buttonLocatorOnAlert))
            web.click(buttonLocatorOnAlert);
    }

    public String getExpectedAssetsDeliverablesCount(){
        return web.findElement(By.xpath(expectedAssetsPageFormat.concat("//h2[@class='ng-binding']"))).getText();
    }

    public class AdCostsExpectedAssetFormPage {
        private String textFieldLocatorFormat = "//input[contains(@id,'input')][@placeholder='%s']";
        private String comboBoxLocatorFormat = "//*[contains(@placeholder,'%s')] [@role='combobox'][@name='autocomplete']";
        private String comboBoxMultiSelectLocatorFormat = "//*[contains(@placeholder,'%s')]//*[contains(@name,'multiselect')]//li/input";
        private String radioButtonsFieldLocatorFormat = "//legend[contains(text(),\"%s\")]";
        private String listBoxFormat = "//*[contains(@placeholder,'%s')][@role='listbox']";
        private String listBoxValueFormat = "//md-content[@class='_md']/div/md-option/div";
        private String comboBoxValueFormat = "//li[@role=\"option\"]";
        private String multipleComboBoxValueFormat = "//li[@role='option']//span";
        private String comboBoxFormat = "//ul[@class='md-autocomplete-suggestions']//li";

        public String getParentLocator(){ return parentFormLocator; }


        public boolean waitUntilExpectedAssetsFormLoads() {
            return web.waitUntilElementAppear(By.xpath(getParentLocator())).isDisplayed();
        }

        public boolean waitUntilExpectedAssetsFormPageDisappear() {
            return web.waitUntilElementDisappear(By.xpath(getParentLocator()));
        }

        public void fillFieldByName(String fieldName, String fieldValues) {
            By textFieldLocator = By.xpath(String.format(parentFormLocator+textFieldLocatorFormat, fieldName));
            By comboBoxLocator = By.xpath(String.format(parentFormLocator+comboBoxLocatorFormat, fieldName));
            By comboBoxMultiSelectLocator = By.xpath(String.format(parentFormLocator+comboBoxMultiSelectLocatorFormat, fieldName));
            By listBoxLocator = By.xpath(String.format(parentFormLocator+listBoxFormat, fieldName));
            By radioButtonsFieldLocator = By.xpath(String.format(parentFormLocator+radioButtonsFieldLocatorFormat, fieldName));
            By buttonToClickLocator = By.xpath(String.format(parentFormLocator+buttonNameFormat, fieldName));

            for (String fieldValue : fieldValues.split(",")) {
                if (web.isElementPresent(radioButtonsFieldLocator)) {
                    web.findElement(By.xpath(String.format(parentFormLocator + "//md-radio-button[@value='%s']", fieldValue))).click();
                } else if (web.isElementPresent(listBoxLocator)) {
                    web.findElement(listBoxLocator).click();
                    for (WebElement element : web.findElements(By.xpath(listBoxValueFormat))) {
                        if (element.getText().equalsIgnoreCase(fieldValue)) {
                            web.scrollToElement(element);
                            element.click();
                            break;
                        }
                    }
                } else if (web.isElementPresent(comboBoxLocator)) {
                    web.findElement(comboBoxLocator).clear();
                    web.findElement(comboBoxLocator).sendKeys(fieldValue);
                    Common.sleep(500);
                    if(!web.isElementVisible(By.xpath(comboBoxFormat)))
                        web.findElement(comboBoxLocator).click();
                    for (WebElement element : web.findElements(By.xpath(comboBoxFormat))) {
                        if (element.getText().equalsIgnoreCase(fieldValue)) {
                            web.scrollToElement(element);
                            element.click();
                            break;
                        }
                    }
                }else if (web.isElementPresent(comboBoxMultiSelectLocator)) {
                    WebElement ele = getDriver().findElement(comboBoxMultiSelectLocator);
                    ele.click();
                    Common.sleep(500);
                    ele.sendKeys(fieldValue);
                    for (WebElement element : web.findElements(By.xpath(multipleComboBoxValueFormat))) {
                        if (element.getText().equalsIgnoreCase(fieldValue)) {
                            web.scrollToElement(element);
                            element.click();
                            break;
                        }
                    }
                }
                else if (web.isElementPresent(textFieldLocator)) {
                    web.typeClean(textFieldLocator, fieldValue);
                } else if (web.isElementPresent(buttonToClickLocator)) {
                    web.findElement(buttonToClickLocator).click();
                } else {
                    throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
                }
            }
        }

        public boolean verifyValuesForFieldsOnFormPage(String fieldName, String fieldValue) {
            By comboBoxLocator = By.xpath(String.format(parentFormLocator + comboBoxLocatorFormat, fieldName));
            if (web.isElementPresent(comboBoxLocator)) {
                web.findElement(comboBoxLocator).clear();
                web.findElement(comboBoxLocator).sendKeys(fieldValue);
                Common.sleep(500);
                if (!web.isElementVisible(By.xpath(comboBoxFormat)))
                    web.findElement(comboBoxLocator).click();
                if (web.findElement(By.xpath(comboBoxFormat)).getText().equalsIgnoreCase(fieldValue)) {
                        return true;
                }
            }
            return false;
        }

        public List<String> getFieldValues(String fieldName){
            By listBoxLocator = By.xpath(String.format(parentFormLocator+listBoxFormat, fieldName));
            if (web.isElementPresent(listBoxLocator)) {
                web.findElement(listBoxLocator).click();
                Common.sleep(5000);
                return web.findElementsToStrings(By.xpath(listBoxValueFormat));
            }
            return null;
        }
    }

    public class AdCostsExpectedAssetsSection{
        private String assetDetailsRowLocator = "//tr[@class='row table-item md-row ng-scope']";
        private String initiative;
        private String assetTitle;
        private String adId;
        private String length;
        private String definition;
        private String mediaTouchPoint;
        private String oval;
        private String firstAirInsertionDate;
        private String scrapped;
        private String country;

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

        public String getLength() {
            return length;
        }

        public void setLength(String length) {
            this.length = length;
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

        public int getExpectedAssetsSectionsCount() {
            return web.findElements(By.xpath(expectedAssetsSectionLocator.concat("//tr[contains(@class,'row table-item md-row ng-scope')]"))).size();
        }

        public void loadDataInExpectedAssetsSection(int childNode) {
            int sectionCount = 1+childNode;
            String tableHeadersLocator = expectedAssetsSectionLocator+"//th[contains(@class,'md-column ')]";
            String tableRowLocator = expectedAssetsSectionLocator+"//tr[contains(@class,'row table-item md-row ng-scope')]";

            setInitiative(web.findElement(By.xpath(expectedAssetsSectionLocator+"//tr["+sectionCount+"]//span[contains(@class,'asset-initiative')]")).getText());
            setAssetTitle(web.findElement(By.xpath(expectedAssetsSectionLocator+"//tr["+sectionCount+"]//span[contains(@class,'asset-title')]")).getText());
            setAdId(web.findElement(By.xpath(expectedAssetsSectionLocator+"//tr["+sectionCount+"]//span[contains(@class,'asset-adid')]")).getText());

            int tableColumnCount = web.findElements(By.xpath(tableHeadersLocator)).size();
            for (int j = 2; j < tableColumnCount; j++) {
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

        public String getAssetTitleForGivenSection(int assetSectionNumber){
            String assetTitleLocator=expectedAssetsSectionLocator + "//tr[" + assetSectionNumber + "]//span[contains(@class,'asset-title')]";
            return web.findElement(By.xpath(assetTitleLocator)).getText();
        }

        public boolean isAssetDetailsPresent(String assetTitle) {
            for (int i = 1; i <= getExpectedAssetsSectionsCount(); i++) {
                if(assetTitle.equalsIgnoreCase(getAssetTitleForGivenSection(i)))
                    return true;
            }
            return false;
        }
    }
}
