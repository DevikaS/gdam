package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.AssetsDestinationList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 21.08.2014.
 */
public class AdbankLibraryAssetsDestinationPage extends AdbankLibraryAssetsInfoPage {
    private final String ROOT_NODE = ".overflow-hidden";
    private final String market = "//select[@ng-model='vm.selectedMarket']";
    private final String destination = "//select[@ng-model='vm.selectedDestination']";
    private final String serviceLevel = "//select[@ng-model='vm.selectedLevel']";
    public AdbankLibraryAssetsDestinationPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(getPageLocator()));
    }

    public AssetsDestinationList getAssetsDestinationList() {
        if (!web.isElementVisible(By.xpath("//article[@ng-repeat='delivery in vm.deliveriesList']")))
            return null; // due to QC & Ingest Only items
        return new AssetsDestinationList(web);
    }

    public AssetsDestinationList getAssetsDestList() {
        if (!web.isElementVisible(By.className("itemsList")))
            return null; // due to QC & Ingest Only items
        return new AssetsDestinationList(web);
    }


    public void selectMarket(String text)
    {
        selectValueFromDropdown(market, text);
    }

    public void selectDestination(String text)
    {

        Common.sleep(5000);
        selectValueFromDropdown(destination, text);
    }
    public void selectServiceLevel(String text)
    {

        selectValueFromDropdown(serviceLevel,text);
    }

    private By getPageLocator() {
        return By.cssSelector(ROOT_NODE);
    }

    public void selectValueFromDropdown(String field, String value) {
        WebElement select = web.findElement(By.xpath(field));
        List<WebElement> options = select.findElements(By.tagName("option"));
        for (WebElement option : options) {
            if(value.equals(option.getText())) {
                option.click();
                break;
            }
        }
    }

    public void clickSend()
    {

        Common.sleep(1000);
        web.findElement(By.xpath("//button[contains(text(),'Send')]")).click();
        web.waitUntilElementAppear(By.xpath("//*[contains(.,'has been made successfully')]"));
    }
    public String verifyDestinationDetails(String destination,String key)
    {
        String getDestination="";
        String value="";
        int rowCount = web.findElements(By.xpath("//div[@class='rows-content clearfix']/article[@ng-repeat='delivery in vm.deliveriesList']")).size();
        for (int row = 1; row <= rowCount; row++) {
            int dataList = web.findElements(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div")).size();
            for (int data = 1; data <= dataList; data++) {
                getDestination = web.findElement(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div[" + data + "]")).getText();
                if (getDestination.equalsIgnoreCase(destination))
                {
                    switch(key)
                    {
                        case "Order #":
                            value=web.findElement(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div[1]")).getText();
                            break;
                        case "Destination":
                            value=web.findElement(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div[2]")).getText();
                            break;
                        case "Date Ordered":
                            value=web.findElement(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div[3]")).getText();
                            break;
                        case "Ordered by":
                            value=web.findElement(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div[4]")).getText();
                            break;
                        case "Status":
                            value=web.findElement(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div[5]")).getText();
                            break;
                        default:
                            throw new IllegalArgumentException("Unknown field type given");
                    }
                    break;
                }
            }
        }
        return value;
    }
}