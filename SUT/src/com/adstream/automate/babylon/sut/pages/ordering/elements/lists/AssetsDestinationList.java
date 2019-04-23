package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.babylon.sut.pages.ordering.OrderSummaryPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 21.08.2014.
 */
public class AssetsDestinationList extends AbstractList {
    public AssetsDestinationList(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getListLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getListLocator()));
    }

    public static class AssetsDestination extends DestinationToDelivery {
        private Link orderReferenceLink;

        public AssetsDestination(ExtendedWebDriver web, WebElement rowElement, AssetsDestinationList parent) {
            super(web, rowElement);
            orderReferenceLink = new Link(parent, By.xpath("//article[@ng-repeat='delivery in vm.deliveriesList']/div[1]//a"));
        }

        public AssetsDestination(ExtendedWebDriver web, WebElement rowElement, AssetsDestinationList parent, String test) {
            super(web, rowElement, test);
            orderReferenceLink = new Link(parent, By.cssSelector(".column-0 a"));
        }

        public OrderSummaryPage openOrderSummaryPage() {
            if (!web.isElementVisible(By.className("b-summary")))
                clickOrderReferenceLink();
            return new OrderSummaryPage(web);
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
        for (AssetsDestination assetsDestination : getAssetsDestinationsOrder())
            if (assetsDestination.getDestination().equals(destinationName))
                return assetsDestination;
        return null;
    }

    public AssetsDestination getAssetsDestByOrderReference(String orderReference) {
        for (AssetsDestination assetsDestination: getAssetsDestinationsOrder())
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

    private List<AssetsDestination> getAssetsDestinationsOrder() {
        if (!web.isElementPresent(getAssetsDestinationRowLocator())) return null;
        List<WebElement> rows = web.findElements(getAssetsDestinationRowLocator());
        List<AssetsDestination> assetsDestinations = new ArrayList<>();
        for (WebElement row: rows)
            assetsDestinations.add(new AssetsDestination(web, row, this, ""));
        return assetsDestinations;
    }

    private By getAssetsDestinationRowLocator() {
        return generateListLocator(".row");
    }
}