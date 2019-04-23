package com.adstream.automate.babylon.sut.pages.admin.views;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 17.06.2015.
 */
public  class ViewAssetManagementPage extends BaseAdminPage<ViewAssetManagementPage> {
    private final static String ROOT_NODE = "[data-dojo-type='admin.views.main_panel']";

    public ViewAssetManagementPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getPageLocator()));
    }

    protected String getRootNode() {
        return ROOT_NODE;
    }

    protected By generatePageLocator(String partialLocator) {
        return By.cssSelector(String.format("%s %s", getRootNode(), partialLocator));
    }

    private By getPageLocator() {
        return By.cssSelector(getRootNode());
    }

    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code starts
    private By getAdvertiserLocator() {
        return By.cssSelector(".preview-form.phm.three-columns div:nth-child(2) input");
    }

    public String getAdvertiserValue() {
        return web.findElement(getAdvertiserLocator()).getAttribute("value").trim();
    }

    public void fillAdvertiserTextBox(String text) {
        web.sleep(3000);
        web.typeClean(getAdvertiserLocator(), text);
    }

    private By getBrandLocator() {
        return By.cssSelector(".preview-form.phm.three-columns div:nth-child(3) input");
    }

    public String getBrandValue() {
        return web.findElement(getBrandLocator()).getAttribute("value").trim();
    }

    public void fillBrandTextBox(String text) {
        web.sleep(3000);
        web.typeClean(getBrandLocator(), text);
    }

    private By getTitleLocator() {
        return By.cssSelector(".preview-form.phm.three-columns div:nth-child(7) input");
    }

    public String getTitleValue() {
        return web.findElement(getTitleLocator()).getAttribute("value").trim();
    }

    public void fillTitleTextBox(String text) {
        web.sleep(3000);
        web.typeClean(getTitleLocator(), text);
    }
    public void clickSaveButton() {
        web.click(By.cssSelector(".button.secondary.save"));
        Common.sleep(3000);
    }
    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code Ends
}