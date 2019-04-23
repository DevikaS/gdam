package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.FailedOrderList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;

/*
 * Created by demidovskiy-r on 29.04.14.
 */
public class FailedOrderPage extends BaseOrderingPage<FailedOrderPage> {
    public FailedOrderPage(ExtendedWebDriver web) {
        super(web);
    }

    public FailedOrderList getFailedOrderList() {
        if (!web.isElementVisible(By.className("itemsList")))
            throw new NoSuchElementException("Failed order list is not present on the page!");
        return new FailedOrderList(web);
    }

    public void clickCompleteionQueue()
    {
        By elementLocator = By.xpath("//a[@data-role='transactions']");
        web.click(elementLocator);
    }
}