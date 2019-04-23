package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: Devika Subramanian
 * Date: 15.02.16
 * Time:
 */
public class AgencyCreateMarketPage extends BaseAdminPage<AgencyCreateMarketPage> {

    public AgencyCreateMarketPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//button[contains(text(),'Proceed')]"));

    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.xpath("//button[contains(text(),'Proceed')]")));

    }

    public void createCustomMarket(String nameOfCustomMarket)
    {

        List<WebElement> customMarket = web.findElements(By.xpath("//div[@class='row a5-unit-markets-name-bar ng-isolate-scope']/label/span[contains(text(), 'Market Name')]//following-sibling::input"));
        for (int i = 0; i < customMarket.size(); i++) {
            customMarket.get(i).clear();
            customMarket.get(i).sendKeys(nameOfCustomMarket);
            Common.sleep(3000);
            web.findElement(By.xpath("//button[contains(text(),'Proceed')]")).click();
            Common.sleep(3000);
        }

     }



}