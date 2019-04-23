package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: Devika Subramanian
 * Date: 15.02.16
 * Time:
 */
public class DestinationPage extends BaseAdminPage<DestinationPage> {

    public DestinationPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//a[@class='select2-choice']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.xpath("//a[@class='select2-choice']")));
    }

    public List<String> getMarkets() {
        List<String> markets = new ArrayList<>();
        web.findElement(By.xpath("//a[@class='select2-choice']")).click();
        int cnt = web.findElements(By.xpath("//ul[@id='select2-results-2']/li")).size();
        for (int market = 1; market <= cnt; market++) {
            String marketList = web.findElement(By.xpath("//ul[@id='select2-results-2']/li[" + market + "]")).getText();
            markets.add(marketList);
        }
        return markets;
    }

    public void selectMarkets(String typeOfMarket)
    {
        web.findElement(By.xpath("//a[@class='select2-choice']")).click();
        int marketCount = web.findElements(By.xpath("//ul[@id='select2-results-2']/li")).size();
        for(int market = 1; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//ul[@id='select2-results-2']/li[" + market + "]")).getText();
            if(marketList.contains(typeOfMarket)) {
                web.findElement(By.xpath("//ul[@id='select2-results-2']/li[" + market + "]")).click();
                break;
            }
        }
    }

    public int getCountOfDefaultmarkets()
    {
        int metaCount = web.findElements(By.xpath("//div[@items=\"destCtrl.marketGroups\"]/div[1]/div")).size();
        return metaCount;
    }

    public int getCountOfMetamarkets()
    {
        int defaultCount = web.findElements(By.xpath("//div[@items=\"destCtrl.marketGroups\"]/div[2]/div")).size();
        return defaultCount;
    }

    public void selectDefaultMarket(String defaultMarket)
    {
        int marketCount = web.findElements(By.xpath("//div[@class='a5-market-group-list ng-isolate-scope']/div[1]/div")).size();
        for(int market = 2; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//div[@class='a5-market-group-list ng-isolate-scope']/div[1]/div[" + market + "]/span")).getText();
            if(marketList.contains(defaultMarket)) {
                web.findElement(By.xpath("//div[@class='a5-market-group-list ng-isolate-scope']/div[1]/div[" + market + "]/span")).click();
                break;
            }
        }
    }

    public void selectMetaMarket(String metaMarket)
    {
        int marketCount = web.findElements(By.xpath("//div[@class='a5-market-group-list ng-isolate-scope']/div[2]/div")).size();
        for(int market = 2; market <= marketCount; market++) {
            String marketList = web.findElement(By.xpath("//div[@class='a5-market-group-list ng-isolate-scope']/div[2]/div[" + market + "]/span")).getText();
            if(marketList.contains(metaMarket)) {
                web.findElement(By.xpath("//div[@class='a5-market-group-list ng-isolate-scope']/div[2]/div[" + market + "]/span")).click();
                break;
            }
        }
    }

    public int checkDestinationGroupsForMarket()
    {
        int destinationGroupCount = web.findElements(By.xpath("//div[@class='a5-destination-group-list ng-isolate-scope']/div")).size();
        return destinationGroupCount;

    }


}