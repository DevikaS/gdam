package com.adstream.automate.babylon.sut.pages.admin.views;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 17.06.2015.
 */
public  class ViewAssetManagementSettingsPage extends BaseAdminPage<ViewAssetManagementSettingsPage> {
    private final static String ROOT_NODE = "[data-dojo-type='admin.views.main_panel']";

    public ViewAssetManagementSettingsPage(ExtendedWebDriver web) {
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

    public void clickSaveButton() {
        web.click(By.cssSelector(".button.secondary.save"));
        Common.sleep(1000);
    }

    public void setMaxNumberOfFields(String maxNumber)
    {
        web.findElement(By.xpath("//table[@data-role='max_fields_selector']//tbody//td[@data-dojo-attach-point='titleNode']")).click();
        web.findElement(By.xpath("//tbody[@class='dijitReset']//tr[@aria-label='"+maxNumber+"']")).click();
    }

}