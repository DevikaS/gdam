package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.elements.EditAgencyPopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: lynda-k
 * Date: 12.06.14
 * Time: 12:07
 */
public class AgencyOverviewPage extends BaseAdminPage<AgencyOverviewPage> {
    public AgencyOverviewPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='units.info.agency_item']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector("[data-dojo-type='units.info.agency_item']")));
    }


    public List<MetadataItem> getFullFieldsMap() {
        List<MetadataItem> fields = new ArrayList<>();

        for (final String name : getCommonFieldNames())
            fields.add(new MetadataItem(name, getCommonFieldValueByName(name)));

        for (final String name : getBrandingFieldNames())
            fields.add(new MetadataItem(name, getBrandingFieldValueByName(name)));

        fields.add(new MetadataItem("Auto accept shared categories", getAutoAcceptSharedCategoriesFieldValue()));
        fields.add(new MetadataItem("Allow extend dictionaries when accepting shared assets", getAllowExtendDictionariesFieldValue()));

        return fields;
    }

    public String getAutoAcceptSharedCategoriesFieldValue() {
        By locator = By.cssSelector("[data-role='autoaccept'] .value");
        return web.isElementPresent(locator) ? web.findElement(locator).getText().trim() : "";
    }

    public String getAllowExtendDictionariesFieldValue() {
        By locator = By.cssSelector("[data-role='enrichDictionary'] .value");
        return web.isElementPresent(locator) ? web.findElement(locator).getText().trim() : "";
    }

    public EditAgencyPopup getEditAgencyPopUp() {
        if (!web.isElementVisible(By.cssSelector(".popupWindow.dijitDialog:not([style*='display: none'])"))) {
             //web.click(By.cssSelector("[data-dojo-type='units.info.editAgency']"));
            web.click(By.xpath("//div[@class='pam']//div[contains(.,' Edit ')]"));
        }
        return new EditAgencyPopup(this);
    }

    private List<String> getCommonFieldNames() {
        return web.findElementsToStrings(By.cssSelector("label .caption > *"));
    }

    private String getCommonFieldValueByName(String name) {
        By locator = By.xpath(String.format("//label[.//*[normalize-space(text())='%s']]//*[contains(@class,'value')]", name));
        return web.isElementPresent(locator) ? web.findElement(locator).getText().replaceAll(", +",",").trim() : "";
    }

    private List<String> getBrandingFieldNames() {
        return web.findElementsToStrings(By.cssSelector(".bold.capitalize"));
    }

    private String getBrandingFieldValueByName(String name) {
        By colorPreviewLocator = By.xpath(String.format("//*[*[text()='%s']]/following-sibling::*/*[@style]", name));
        By imgPreviewLocator = By.xpath(String.format("//*[*[text()='%s']]/following-sibling::*/img", name));

        if (web.isElementPresent(colorPreviewLocator)) {
            return web.findElement(colorPreviewLocator).getAttribute("style").replaceAll(".*(#\\w{6}|#\\w{3})(?:[^\\w].*|$)","$1");
        } else if (web.isElementPresent(imgPreviewLocator)) {
            return web.findElement(imgPreviewLocator).getAttribute("src");
        } else {
            return "";
        }
    }
}