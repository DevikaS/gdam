package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 22/09/2017.
 */
public class NewAdbankLibraryAssetRelatedProjectsPage extends LibraryAssetsInfoPage {
    private final static By OriginatedProject = By.xpath("//a[contains(@class,'project-name')]");
    public NewAdbankLibraryAssetRelatedProjectsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(getPageLocator());
        Common.sleep(1000);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(getPageLocator()));
    }

    public String getOriginatedProjectName() {

        return web.findElement(OriginatedProject).getText();

    }

    public void clickOriginatedProjectLink()
    {
        web.findElement(OriginatedProject).click();
    }

    public boolean isMessageDisplayed(String message)
    {
        web.waitUntilElementAppear(By.xpath("//asset-tab-related-projects//h4[.='" + message + "']"));
        return web.isElementVisible(By.xpath("//asset-tab-related-projects//h4[.='" + message + "']"));
    }


    public By getPageLocator() {
        return By.tagName("asset-tab-related-projects");
    }

}
