package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.DestinationList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 26/09/2017.
 */
public class NewAdbankLibraryAssetsDestinationPage extends LibraryAssetsInfoPage {
    private final String ROOT_NODE = "asset-tab-deliveries";
    public NewAdbankLibraryAssetsDestinationPage(ExtendedWebDriver web) {
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

    private By getPageLocator(){
        return By.tagName("asset-tab-deliveries");
    }

    public String verifyDestination(String destination,String key)
    {
        String getDestination="";
        String value="";
        for (WebElement elem:web.findElements(By.cssSelector(".delivery-item"))) {
            {
                getDestination = web.findElement(By.cssSelector(".delivery-item-name")).getText();
                if (getDestination.equalsIgnoreCase(destination))
                {
                    switch(key)
                    {
                        case "Order #":
                            value=elem.findElement(By.cssSelector(".delivery-item-description a[class=\"link\"]")).getText();
                            break;
                        case "Destination":
                            value=getDestination;
                            break;
                      /*  case "Date Ordered":
                            value=web.findElement(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div[3]")).getText();
                            break;
                        case "Ordered by":
                            value=web.findElement(By.xpath("//div[@class='rows-content clearfix']/article[" + row + "]/div[4]")).getText();
                            break;*/
                        case "Status":
                            value=elem.findElement(By.cssSelector(".text-muted.smalltext")).getText();
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



    public DestinationList getAssetsDestinationList() {
        if (!web.isElementVisible(By.cssSelector(".delivery-item")))
            return null; // due to QC & Ingest Only items
        return new DestinationList(web);
    }



}
