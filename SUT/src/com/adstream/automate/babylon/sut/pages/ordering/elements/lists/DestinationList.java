package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryAssetsDestinationPage;
import com.adstream.automate.babylon.sut.pages.ordering.OrderSummaryPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 26/09/2017.
 */
public class DestinationList extends NewAdbankLibraryAssetsDestinationPage {
    public DestinationList(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getAssetsDestinationRowLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getAssetsDestinationRowLocator()));
    }

    public static class AssetsDestination {
        private Link orderReferenceLink;
        private ExtendedWebDriver web;

        public String getDestination() {
            return destination;
        }

        private String destination;

        public String getDestinationDescription() {
            return destinationDescription;
        }

        private String destinationDescription;

        public String getOrderReference() {
            return orderReference;
        }

        private String orderReference;

        public String getStatus() {
            return status;
        }

        private  String status;

        public Link getOrderReferenceLink() {
            return orderReferenceLink;
        }

        public ExtendedWebDriver getWeb() {
            return web;
        }

        public AssetsDestination(ExtendedWebDriver web, WebElement rowElement, DestinationList parent) {
            this.web=web;
            orderReferenceLink = new Link(parent, By.cssSelector(".delivery-item .link"));
            destination=rowElement.findElement(By.cssSelector(".delivery-item-name")).getText();
            status=rowElement.findElement(By.xpath("//div[contains(@class,\"delivery-item-description\")][2]//span[2]")).getText().split(":")[0].trim();
            orderReference=rowElement.findElement(By.cssSelector(".delivery-item-description .link")).getText();
            destinationDescription=rowElement.findElement(By.cssSelector(".delivery-item-description")).getText();
        }

        public OrderSummaryPage openOrderSummaryPage() {
            this.getOrderReferenceLink().click();
            Common.sleep(2000);
            return new OrderSummaryPage(this.getWeb());
        }

        public boolean isOrderReferenceLinkVisible() {
            return orderReferenceLink.isVisible();
        }

        private void clickOrderReferenceLink(){
            orderReferenceLink.click();
        }
    }

    public AssetsDestination getAssetsDestinationByName(String destinationName) {
        for (AssetsDestination assetsDestination : getAssetsDestinations())
            if (assetsDestination.getDestination().equals(destinationName))
                return assetsDestination;
        return null;
    }

    public AssetsDestination getAssetsDestinationByOrderReference(String orderReference) {
        for (AssetsDestination assetsDestination: getAssetsDestinations())
            if (assetsDestination.getOrderReference().equals(orderReference))
                return assetsDestination;
        return null;
    }

    public AssetsDestination getAssetsDestByName(String destinationName) {
        for (AssetsDestination assetsDestination : getAssetsDestinations())
            if (assetsDestination.getDestination().equals(destinationName))
                return assetsDestination;
        return null;
    }

    public AssetsDestination getAssetsDestByOrderReference(String orderReference) {
        for (AssetsDestination assetsDestination: getAssetsDestinations())
            if (assetsDestination.getOrderReference().equals(orderReference))
                return assetsDestination;
        return null;
    }

    private List<AssetsDestination> getAssetsDestinations() {
        if (!web.isElementPresent(getAssetsDestinationRowLocator())) return null;
        List<WebElement> rows = web.findElements(getAssetsDestinationRowLocator());
        List<AssetsDestination> assetsDestinations = new ArrayList<>();
        for (WebElement row: rows)
            assetsDestinations.add(new AssetsDestination(web, row, this));
        return assetsDestinations;
    }

    private By getAssetsDestinationRowLocator() {
        return By.cssSelector(".delivery-item");
    }
}
