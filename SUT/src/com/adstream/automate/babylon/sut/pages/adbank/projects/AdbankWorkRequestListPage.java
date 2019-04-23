package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 9/12/14
 * Time: 9:12 AM

 */
public class AdbankWorkRequestListPage extends AdbankPaginator {

    public AdbankWorkRequestListPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//a[normalize-space(text())='Work Requests']"));
        web.waitUntilElementAppear(By.cssSelector(".itemsList"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.xpath("//a[normalize-space(text())='Work Requests']")));
        assertTrue(web.isElementPresent(By.cssSelector(".itemsList")));
    }

    public AdbankWorkRequestCreatePage clickNewWorkRequest() {
        web.click(getCreateNewWorkRequestButtonSelector());
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));
        return new AdbankWorkRequestCreatePage(web);
    }

    public boolean isCreateNewWorkRequestPopUpVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow [data-dojo-props*='adkit']"));
    }

    private By getCreateNewWorkRequestButtonSelector() {
        return By.cssSelector("[data-dojo-type=\"adbank.projects.createWorkRequestButton\"]");
    }

}
