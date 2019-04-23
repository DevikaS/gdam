package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: Devika Subramanian
 * Date: 15.02.16
 * Time:
 */
public class AgencyMarketPage extends BaseAdminPage<AgencyMarketPage> {

    private By defaultMarketLocator = By.xpath("//span[contains(text(),'custom')]");
    private By defaultmetaMarketLocator = By.xpath("//span[contains(text(),'meta')]");

    public AgencyMarketPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//button[contains(text(),'New Custom Market')]"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.xpath("//button[contains(text(),'New Custom Market')]")));
    }

    public boolean isDefaultMarket() {
        return web.isElementPresent(defaultMarketLocator);
    }
    public boolean isMetaMarket() {
        return web.isElementPresent(defaultmetaMarketLocator);
    }

    public String checkCustomMarketIsDisplayed(String customMarket) {
        return web.findElement(By.xpath("//div[contains(text(),'" + customMarket + "')]")).getText();
    }

    public void hideCustomMarket(String customMarket) {
       // web.findElement(By.xpath("//div[@name='custom']//div[@class='a5-unit-markets-list-item ng-isolate-scope']/div[2]")).click();
        int marketCount = web.findElements(By.xpath("//div[@name='custom']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div")).size();
        for(int market = 1; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//div[@name='custom']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div[" + market + "]/div[1]")).getText();
            if(marketList.contains(customMarket)) {
                web.findElement(By.xpath("//div[@name='custom']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div[" + market + "]/div[2]")).click();
                break;
            }
        }
    }

    public boolean checkCustomMarketIsDeleted(String customMarket) {
        int rowCount = web.findElements(By.xpath("//div[@class='content-container pam l-units-markets-list ng-scope']/div")).size();
        boolean flag = false;
        if(rowCount == 4)
        {
        int customCount =  web.findElements(By.xpath("//div[@name='custom']/div")).size();
            for(int count = 1; count <= customCount; count++) {
                String marketList = web.findElement(By.xpath("//div[@name='custom']/div[" + count +"]")).getText();
                if(marketList.contains(customMarket))
                {
                    flag = true;
                }
            }
        }
        return flag;
    }

    public void hideMetaMarket(String metaMarket) {
        int marketCount = web.findElements(By.xpath("//div[@name='meta']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div")).size();
        for(int market = 1; market <= marketCount; market++) {
        String marketList = web.findElement(By.xpath("//div[@name='meta']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div[" + market + "]/div[1]")).getText();
            if(marketList.contains(metaMarket)) {
                web.findElement(By.xpath("//div[@name='meta']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div[" + market + "]/div[2]")).click();
                break;
            }
        }

    }

    public void hideDefaultMarket(String defaultMarket) {
        int marketCount = web.findElements(By.xpath("//div[@name='default']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div")).size();
        for(int market = 1; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//div[@name='default']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div[" + market + "]/div[1]")).getText();
            if(marketList.contains(defaultMarket)) {
                web.findElement(By.xpath("//div[@name='default']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div[" + market + "]/div[2]")).click();
                break;
            }
        }

    }

    public void clickCustomMarket(String customMarket) {
        web.findElement(By.xpath("//div[contains(text(),'" + customMarket + "')]")).click();
    }

    public boolean checkdefaultMarketDisplayed(String defaultMarket) {
        int marketCount = web.findElements(By.xpath("//div[@name='default']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div")).size();
        boolean flag = false;
        for (int market = 1; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//div[@name='default']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div[" + market + "]/div[1]")).getText();
            if (marketList.contains(defaultMarket)) {
                flag = true;
                break;
            }
        }

        return flag;
    }

    public boolean checkMetaMarketDisplayed(String metaMarket) {
        int marketCount = web.findElements(By.xpath("//div[@name='meta']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div")).size();
        boolean flag = false;
        for(int market = 1; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//div[@name='meta']//div[@class='a5-unit-markets-list ng-scope ng-isolate-scope']/div[" + market + "]/div[1]")).getText();
            if(marketList.contains(metaMarket)) {
                flag = true;
                break;
            }
        }
        return flag;
    }

}