package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 29.08.12
 * Time: 13:29
 */
public class AdbankTemplateListWithSizePage extends AdbankPaginator {
    public AdbankTemplateListWithSizePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//div[contains(@class, 'title') and normalize-space(text())='Templates']"));
        web.waitUntilElementAppearVisible(By.cssSelector(".phs"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.xpath("//div[contains(@class, 'title') and normalize-space(text())='Templates']")));
        assertTrue(web.isElementVisible(By.cssSelector(".phs")));
    }

}
