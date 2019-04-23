package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.babylon.sut.pages.ordering.PageElement;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.DeleteFailedOrderPopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 29.04.14.
 */
public class FailedOrderList extends AbstractList {

    public FailedOrderList(ExtendedWebDriver web) {
        super(web);
    }

    public static class Order extends PageElement<FailedOrderList> {
        private String orderReference;
        private String dateSubmitted;
        private String market;
        private String agency;
        private Button showError;
        private String status;
        private Button resend;
        private Button resend_new;
        private Button delete;

        public Order(ExtendedWebDriver web, FailedOrderList parent, WebElement rowElement) {
            super(web, parent);
            List<WebElement> cells = rowElement.findElements(getCellContentLocator());
            orderReference = cells.get(0).getText();
            dateSubmitted = cells.get(1).getText();
            market = cells.get(2).getText();
            agency = cells.get(3).getText();
            showError = new Button(parent, rowElement.findElement(generateButtonLocator("showError")));
            status = cells.get(5).getText();
           resend= new Button(parent,rowElement.findElement(By.cssSelector("[data-action='rerunTransaction'],[data-action='resend']")));
           delete = new Button(parent, rowElement.findElement(By.cssSelector("[data-action='removeItem'],[data-action='deleteTransaction']")));
        }

        public String getOrderReference() {
            return orderReference;
        }

        public String getDateSubmitted() {
            return dateSubmitted;
        }

        public String getMarket() {
            return market;
        }

        public String getAgency() {
            return agency;
        }

        public String getStatus() {
            return status;
        }

        public void resend() {
            resend.click();
            web.sleep(1000);
        }

        public DeleteFailedOrderPopUp getDeleteFailedOrderPopUp() {
            if (!web.isElementVisible(By.xpath(DeleteFailedOrderPopUp.TITLE_NODE)))
                clickDeleteButton();
            return new DeleteFailedOrderPopUp(parent, DeleteFailedOrderPopUp.TITLE);
        }

        private void clickDeleteButton() {
            delete.click();
        }

        private By generateButtonLocator(String partialLocator) {
            return By.cssSelector("[data-action='" + partialLocator + "']");
        }

        private By getCellContentLocator() {
            //return By.className("rows-content");
            return By.cssSelector(".column-title");
        }
    }

    public Order getFailedOrderByOrderReference(String orderReference) {
        for (Order order :getFailedOrders())
            if (order.getOrderReference().equals(orderReference))
                return order;
        return null;
    }


    public List<String> getVisibleOrderReferences() {
        List<String> orderReferences = new ArrayList<String>();
        List<Order> failedOrders = getFailedOrders();
        if (failedOrders == null) return orderReferences;
        for (Order order : failedOrders)
            orderReferences.add(order.getOrderReference());
        return orderReferences;
    }

    public List<String> getVisibleMarkets() {
        List<String> markets = new ArrayList<String>();
        List<Order> failedOrders = getFailedOrders();
        if (failedOrders == null) return markets;
        for (Order order : failedOrders)
            markets.add(order.getMarket());
        return markets;
    }

    public List<Order> getFailedOrders() {
        List<Order> orders = new ArrayList<Order>();
        if (!web.isElementPresent(getOrderRowLocator()))
            return null;
        List<WebElement> rows = web.findElements(getOrderRowLocator());
        for (WebElement row: rows)
            orders.add(new Order(web, this, row));
        return orders;
    }

    private By getOrderRowLocator() {
        return generateListLocator(".row");
    }
}