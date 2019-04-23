package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
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
public class AgencyEditMarketPage extends BaseAdminPage<AgencyEditMarketPage> {

    public AgencyEditMarketPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//button[contains(text(),'Delete This Market')]"));

    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.xpath("//button[contains(text(),'Delete This Market')]")));

    }

    public void addDestinationGroup()
    {
        int destinationGroupCount = web.findElements(By.xpath("//div[@class='a5-unit-destination-group-list ng-isolate-scope']/div")).size();
        for(int destinationGroup = 2; destinationGroup <= destinationGroupCount-1; destinationGroup++) {
            web.findElement(By.xpath("//div[@class='a5-unit-destination-group-list ng-isolate-scope']/div[" + destinationGroup + "]//input[@type='checkbox']")).click();
        }
    }

    public void selectDefaultMarket(String defaultMarket)
    {
        int marketCount = web.findElements(By.xpath("//div[@class='a5-unit-markets-menu-list ng-isolate-scope']/div[1]/div")).size();
        for(int market = 2; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//div[@class='a5-unit-markets-menu-list ng-isolate-scope']/div[1]/div[" + market + "]/span")).getText();
            if(marketList.contains(defaultMarket)) {
                web.findElement(By.xpath("//div[@class='a5-unit-markets-menu-list ng-isolate-scope']/div[1]/div[" + market + "]/span")).click();
                break;
            }
        }

    }

    public void selectMetaMarket(String metaMarket)
    {
        int marketCount = web.findElements(By.xpath("//div[@class='a5-unit-markets-menu-list ng-isolate-scope']/div[2]/div")).size();
        for(int market = 2; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//div[@class='a5-unit-markets-menu-list ng-isolate-scope']/div[2]/div[" + market + "]/span")).getText();
            if(marketList.contains(metaMarket)) {
                web.findElement(By.xpath("//div[@class='a5-unit-markets-menu-list ng-isolate-scope']/div[2]/div[" + market + "]/span")).click();
                break;
            }
        }

    }

    public void clickSave()
    {
        web.findElement(By.xpath("//button[contains(text(),'Save')]")).click();
    }

    public void editCustomMarkeName(String nameOfCustomMarket)
    {
        List<WebElement> editCustomeMarket = web.findElements(By.xpath("//div[@class='row a5-unit-markets-name-bar ng-isolate-scope']/label/span[contains(text(), 'Market Name')]//following-sibling::input"));
        for (int i = 0; i < editCustomeMarket.size(); i++) {
            editCustomeMarket.get(i).clear();
            Common.sleep(3000);
            editCustomeMarket.get(i).sendKeys(nameOfCustomMarket);
            Common.sleep(3000);
        }
    }

    public AgencyDeleteMarketPopUpWindow deleteCustomMarket()
    {
        web.findElement(By.xpath("//button[contains(text(),'Delete This Market')]")).click();
        return new AgencyDeleteMarketPopUpWindow(this);
    }

    public boolean checkDestinationGroupsAddedForCustomMarket() {
        int marketCount = web.findElements(By.xpath("//div[@class='row size1of1 clearfix']/div[3]/div[@class='a5-unit-destination-group-list ng-scope ng-isolate-scope']/div")).size();
        boolean flag = false;
        if (marketCount > 1)
        {
            flag = true;
        }
        return flag;
    }
}