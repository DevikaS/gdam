package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 02.12.13
 * Time: 17:11
 */
public class DestinationDeliveredList extends AbstractList {
    private final String ROOT_NODE = "[data-role='assetPreviewContainer'] .itemsList";

    public DestinationDeliveredList(ExtendedWebDriver web) {
        super(web);
    }

    public static class DestinationDelivered extends DestinationToDelivery {
        public DestinationDelivered(ExtendedWebDriver web, WebElement rowElement, String test) {
            super(web, rowElement, test);
        }
    }

    public DestinationDelivered getDestinationDeliveredByOrderReference(String orderReference) {
        for (DestinationDelivered destinationDelivered : getDestinationDelivered())
            if (destinationDelivered.getOrderReference().equals(orderReference))
                return destinationDelivered;
        return null;
    }

    private List<DestinationDelivered> getDestinationDelivered() {
        if (!web.isElementPresent(getDestinationDeliveredRowLocator())) return null;
        List<WebElement> rows = web.findElements(getDestinationDeliveredRowLocator());
        List<DestinationDelivered> destinationDelivereds = new ArrayList<>();
        for (WebElement row : rows)
            destinationDelivereds.add(new DestinationDelivered(web, row, ""));
        return destinationDelivereds;
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    private By getDestinationDeliveredRowLocator() {
        return generateListLocator(".row:not([class*='selected'])");
    }
}