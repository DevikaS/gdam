package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 14.04.14.
 */
public class ViewBilling extends PageElement<ViewBillingPage> {
    private String subTotal;
    private String tax;
    private String total;

    public ViewBilling(ExtendedWebDriver web, ViewBillingPage parent, WebElement billingData) {
        super(web, parent);

        waitUntilLoadBillingSpinnerDisappears();
        List<WebElement> prices = billingData.findElements(By.cssSelector(".border-top-dashed .plxs"));
        subTotal = prices.get(0).getText();
        tax = prices.get(1).getText();
        total = prices.get(2).getText();
    }

    public static class Item {
        private String item;
        private String qty;
        private String unit;
        private String totalPerItem;

        public Item(WebElement itemRow) {
            if (itemRow.getAttribute("class").contains("ng-scope")) {
                List<WebElement> units = itemRow.findElements(By.className("unit"));
                item = units.get(0).getText();
                qty = units.get(1).getText();
                unit = units.get(2).getText();
                totalPerItem = units.get(3).getText();
            } else {
                String bill = itemRow.getText();
                item = bill;
                qty = bill;
                unit = bill;
                totalPerItem = bill;
            }
        }

        public String getItem() {
            return item;
        }

        public String getQty() {
            return qty;
        }

        public String getUnit() {
            return unit;
        }

        public String getTotalPerItem() {
            return totalPerItem;
        }
    }

    public String getSubTotal() {
        return subTotal;
    }

    public String getTax() {
        return tax;
    }

    public String getTotal() {
        return total;
    }

    public Item getItemByName(String name) {
        for (Item item : geItems())
       if (item.getItem().contains(name))
        return item;
        return null;
    }

    private List<Item> geItems() {
        List<Item> items = new ArrayList<>();
        List<WebElement> rows = web.isElementVisible(getBillingItemLocator()) ? web.findElements(getBillingItemLocator()) : web.findElements(getBillingItemTableLocator());
        for (WebElement row : rows)
            items.add(new Item(row));
        return items;
    }

    private By getBillingItemTableLocator() {
        return generateBillingPartsLocator("[class^='pbs']");
    }

    private By getBillingItemLocator() {
        return generateBillingPartsLocator("[class^='pbs'] [ng-repeat*='bill']");
    }

    private By generateBillingPartsLocator(String partialLocator) {
        return By.cssSelector(ViewBillingPage.billingProps + " " + partialLocator);
    }

    private void waitUntilLoadBillingSpinnerDisappears() {
        web.waitUntilElementDisappear(By.cssSelector(".block-spinner .orders-spinner"));
        web.sleep(1000);
    }
}