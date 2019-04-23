package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankLibraryPresentationsPage;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankPresentationPreviewPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import org.openqa.selenium.By;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 02.11.12
 * Time: 15:03

 */
public class AdbankLibraryPresentationsLayoutPage  extends AdbankLibraryPresentationsPage {

    public AdbankLibraryPresentationsLayoutPage(ExtendedWebDriver web) {
        super(web);
    }

    public void clickMetaDataCheckBox(String name) {
        web.click(By.cssSelector(String.format("[title*='%s']", name)));
    }

    public boolean isMetaDataCheckBoxChecked(String name) {
        return web.findElement(By.cssSelector(String.format("[title*='%s']", name))).isSelected();
    }

    public void setMetaDateCheckBoxInRequiredState(String name, String state) {
        if (state.equalsIgnoreCase("on")) {
            if (!web.findElement(By.name(name)).isSelected()) clickMetaDataCheckBox(name);
        }
        else {
            if (web.findElement(By.name(name)).isSelected()) clickMetaDataCheckBox(name);
        }
    }

    public boolean isTypeOfShowRBSelected(String value) {
        return web.findElement(By.cssSelector(String.format("[value='%s']", value))).isSelected();
    }

    public void clickTypeOfShow(String value) {
        web.click(By.cssSelector(String.format("[value='%s'] + .screen", value)));
    }

    public void clickThumbnailViewHorizontal() {
        web.click(By.cssSelector(".roller .icon"));
    }

    public void clickThumbnailViewGrid() {
        web.click(By.cssSelector(".grid .icon"));
    }

    public void clickSaveButton() {
        web.click(By.name("Save"));
    }

    public AdbankPresentationPreviewPage clickPreviewPresentationLink() {
        web.click(By.linkText("Preview Presentation"));
        return new AdbankPresentationPreviewPage(web);
    }

    public void clickCancelButton() {
        web.click(By.cssSelector(".mbm.mtl.clearfix.controls .cancel"));
    }

    public void expandAgencySectionByName(String agencyName) {
        By locator = By.xpath(String.format("//*[h4[normalize-space()='%s'] and .//*[contains(@class,'collapsed')]]//*[@data-role='arrow']", agencyName));
        if (web.isElementPresent(locator)) web.click(locator);
    }

    public void selectSchemaSectionTabByName(String agencyName, String sectionName) {
        web.click(By.xpath(String.format("//*[h4[normalize-space()='%s']]//*[contains(@class,'tabs')]//*[text()='%s']", agencyName, sectionName)));
    }

    public List<String> getCustomMetadataFieldsList(String agencyName, String sectionName) {
        expandAgencySectionByName(agencyName);
        selectSchemaSectionTabByName(agencyName, sectionName);

        return web.findElementsToStrings(By.xpath(String.format("//*[h4[normalize-space()='%s']]//*[contains(@class,'visible')]//label", agencyName)));
    }

    public void selectCustomMetadataField(String agencyName, String sectionName, String fieldName) {
        expandAgencySectionByName(agencyName);
        selectSchemaSectionTabByName(agencyName, sectionName);
        By fieldLocator = By.xpath(String.format("//*[h4[normalize-space()='%s']]//*[contains(@class,'visible')]//*[normalize-space(text())='%s']/input", agencyName, fieldName));

        new Checkbox(this, fieldLocator).select();
    }
}