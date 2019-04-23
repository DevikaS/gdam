package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 9/11/14
 * Time: 12:34 PM

 */
public class AdbankWorkRequestTemplatesListPage extends AdbankPaginator {

    public AdbankWorkRequestTemplatesListPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//a[@class='active' and normalize-space(text())='Work Request Templates']"));
        web.waitUntilElementAppear(By.cssSelector(".itemsList"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.xpath("//a[@class='active' and normalize-space(text())='Work Request Templates']")));
        assertTrue(web.isElementPresent(By.cssSelector(".itemsList")));
    }

    public AdbankWorkRequestTemplateCreatePage clickCreateNewWorkRequestTemplate() {
        web.click(getCreateNewWorkRequestTemplateButtonSelector());
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));
        return new AdbankWorkRequestTemplateCreatePage(web);
    }

    public boolean isCreateNewWorkRequestTemplatePopUpVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow [data-dojo-props*='adkit']"));
    }

    public void clickUseTemplateButton(String workTemplateName) {
        String locator = String.format("//*[@data-type='tableRow'][.//a[normalize-space()='%s']]//*[@data-dojo-type='common.newProject']", workTemplateName);
        web.click(By.xpath(locator));
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup [data-role='schemedContent']"));
    }

    private By getCreateNewWorkRequestTemplateButtonSelector() {
        return By.cssSelector("[data-dojo-type='common.newTemplate']");
    }
}
