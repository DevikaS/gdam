package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
  * User: lynda-k
 * Date: 25.02.14
 * Time: 12:07
 */
public class AgencyMetadataMappingCreatePage extends BaseAdminPage<AgencyMetadataMappingCreatePage> {
    public AgencyMetadataMappingCreatePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[ng-click*='saveMapping']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector("[ng-click*='saveMapping']")));
    }

    public List<String> getListOfMappedFields() {
        List<String> mappedItems = web.findElementsToStrings(getMappedFieldItemsLocator());
        for (int i = 0; i < mappedItems.size(); i++) {
            mappedItems.set(i, mappedItems.get(i).replaceAll("([\\n\\r]+|Delete$)", ""));
        }
        return mappedItems;
    }

    public List<String> getGroupNames(String businessUnit) {
        return web.findElementsToStrings(getGroupNamesLocator(businessUnit));
    }

    public List<String> getFieldNames(String businessUnit, String groupName) {
        return web.findElementsToStrings(getFieldNamesLocator(businessUnit, groupName));
    }

    public boolean isGroupExpanded(String businessUnit, String groupName) {
        return web.findElement(getGroupLocator(businessUnit, groupName)).getAttribute("class").contains("active");
    }

    public void selectMetadataScopeTabByName(String scopeName) {
        web.click(getMetadataScopeTabLocatorByName(scopeName));
    }

    public void expandGroup(String businessUnit, String groupName) {
        if (!isGroupExpanded(businessUnit, groupName)) {
            web.click(getGroupLocator(businessUnit, groupName));
        }
        Common.sleep(2000);
    }

    public void collapseGroup(String businessUnit, String groupName) {
        if (isGroupExpanded(businessUnit, groupName)) web.click(getGroupLocator(businessUnit, groupName));
    }

    public void choiseField(String businessUnit, String groupName, String fieldName) {
        web.click(getFieldLocator(businessUnit, groupName, fieldName));
    }

    public void removeMappedFieldsItem(String fieldFrom, String fieldTo) {
        web.click(getMappedFieldItemRemoveButtonLocator(fieldFrom, fieldTo));
    }

    public void saveMetadataMapping() {
        web.click(getSaveButtonLocator());
        web.sleep(2000);
    }


    private By getSaveButtonLocator() {
        return By.cssSelector("[ng-click*='saveMapping']");
    }

    private By getMetadataScopeTabLocatorByName(String scopeName) {
        return By.cssSelector(String.format(".tabs [heading='%s']", scopeName));
    }

    private By getGroupNamesLocator(String businessUnit) {
        return By.xpath(String.format("//*[@class='visible']//*[contains(text(),'%s')]/following-sibling::*[@heading]", businessUnit));
    }

    private By getGroupLocator(String businessUnit, String groupName) {
        return By.xpath(String.format("%s//*[@ng-click]", getGroupContainerXpath(businessUnit, groupName)));
    }

    private By getFieldNamesLocator(String businessUnit, String groupName) {
        return By.xpath(String.format("%s//*[not(contains(@class,'selected'))]/button",
                getGroupContainerXpath(businessUnit, groupName)));
    }

    private By getFieldLocator(String businessUnit, String groupName, String fieldName) {
        return By.xpath(String.format("%s//*[not(contains(@class,'selected'))]/button[normalize-space(text())='%s']",
                getGroupContainerXpath(businessUnit, groupName), fieldName));
    }

    private By getMappedFieldItemsLocator() {
        return By.cssSelector(".visible .mapping-item");
    }

    private By getMappedFieldItemRemoveButtonLocator(String fieldFrom, String fieldTo) {
        return By.xpath(String.format("//*[@class='visible']//*[contains(@class,'mapping-item')]" +
                "[.//*[contains(@class,'ng-binding')][1][normalize-space(text())='%s']]" +
                "[.//*[contains(@class,'ng-binding')][last()][normalize-space(text())='%s']]//button",
                fieldFrom, fieldTo));
    }

    private String getGroupContainerXpath(String businessUnit, String groupName) {
        return String.format("//*[@class='visible']//*[contains(text(),'%s')]/following-sibling::*[@heading='%s']",
                businessUnit, groupName);
    }
}
