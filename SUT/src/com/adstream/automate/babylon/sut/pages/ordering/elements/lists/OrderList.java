package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.OrderSummaryPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.OrderStatus;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 22.08.13
 * Time: 17:28
 */
public class OrderList extends AbstractList {

    public OrderList(ExtendedWebDriver web) {
        super(web);
    }

    public static class Order {
        private ExtendedWebDriver web;
        private WebElement expander;
        private WebElement orderReferenceLink;
        private String orderReference;
        private String dateTime;
        private String advertiser;
        private String brand;
        private String subBrand;
        private String product;
        private String campaign;
        private String market;
        private String poNumber;
        private String jobNumber;
        private String no_clocks;
        private String creator;
        private String owner;
        private String status;
        private WebElement container;
        private WebElement tableRow;

        // base structure: advertiser - brand - sub brand - product
        // campaign structure: advertiser - brand - product - campaign
        public Order(ExtendedWebDriver web, WebElement rowElement, OrderStatus orderStatus, boolean isCampaignVisible) {
            this.web = web;
            int counter ;
            this.container = rowElement;
            this.tableRow = rowElement.findElement(By.cssSelector("[data-type='tableRow']"));
            List<WebElement> cells = rowElement.findElements(By.cssSelector("[data-type='tableRow'] .cell"));
            expander = rowElement.findElement(By.className("expander"));
            if(cells.get(0).findElement(By.cssSelector(".cell-content a")).getAttribute("class").equalsIgnoreCase("spriteicon i16x16_pencil")){
                counter = 1;
            }else{
                counter = 0;
            }
            orderReferenceLink = cells.get(counter++).findElement(By.cssSelector(".cell-content a"));
            orderReference = orderReferenceLink.getText();
            dateTime = cells.get(counter++).findElement(getCellContentLocator()).getText();
            advertiser = cells.get(counter++).findElement(getCellContentLocator()).getText();
            brand = cells.get(counter++).findElement(getCellContentLocator()).getText();
            initDependentAdvertiserHierarchyFields(isCampaignVisible, cells);
            initDependentmarketFieldds(cells);
           // market = cells.get(6).findElement(getCellContentLocator()).getText();
            initDependentOtherFields(orderStatus, cells);
        }

        public String getOrderReference() {
            return orderReference;
        }

        public String getDateTime() {
            return dateTime;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getBrand() {
            return brand;
        }

        public String getSubBrand() {
            return subBrand;
        }

        public String getProduct() {
            return product;
        }

        public String getCampaign() {
            return campaign;
        }

        public String getMarket() {
            return market;
        }

        public String getPoNumber() {
            return poNumber;
        }

        public String getJobNumber() {
            return jobNumber;
        }

        public String getNo_clocks() {
            return no_clocks;
        }

        public String getCreator() {
            return creator;
        }

        public String getOwner() {
            return owner;
        }

        public String getStatus() {
            return status;
        }

        public OrderItemPage openOrderItemPage() {
            if (!web.isElementVisible(By.cssSelector("[data-dojo-type='ordering.form.Manager']")))
                clickOrderReferenceLink();
            return new OrderItemPage(web);
        }

        public OrderSummaryPage openOrderSummaryPage() {
            if (!web.isElementVisible(By.className("b-summary")))
                clickOrderReferenceLink();
            return new OrderSummaryPage(web);
        }

        public OrderNestedList getOrderNestedList() {
            if (!container.getAttribute("class").contains("expanded"))
                expandOrderNestedList();
            return new OrderNestedList(web);
        }

        public void selectOrder() {
            if (!tableRow.getAttribute("class").contains("selected"))
                clickTableRow();
        }

        private void initDependentAdvertiserHierarchyFields(boolean isCampaignVisible, List<WebElement> cells) {
            int counter ;
            if (isCampaignVisible) {
                subBrand = "";
                product = cells.get(4).findElement(getCellContentLocator()).getText();
                campaign = cells.get(5).findElement(getCellContentLocator()).getText();
            } else {
                if(cells.get(0).findElement(By.cssSelector(".cell-content a")).getAttribute("class").equalsIgnoreCase("spriteicon i16x16_pencil")){
                    counter = 5;
                }else{
                    counter = 4;
                }
                subBrand = cells.get(counter++).findElement(getCellContentLocator()).getText();
                product = cells.get(counter).findElement(getCellContentLocator()).getText();
                campaign = "";
            }
        }

        private void initDependentOtherFields(OrderStatus orderStatus, List<WebElement> cells) {
            int counter ;
            switch (orderStatus) {
                case VIEW_DRAFT_ORDERS:
                    poNumber = "";
                    jobNumber = "";
                    no_clocks = cells.get(7).findElement(getCellContentLocator()).getText();
                    creator = cells.get(8).findElement(getCellContentLocator()).getText();
                    owner = cells.get(9).findElement(getCellContentLocator()).getText();
                    status = "";
                    break;
                default:
                    if(cells.get(0).findElement(By.cssSelector(".cell-content a")).getAttribute("class").equalsIgnoreCase("spriteicon i16x16_pencil")){
                        counter = 8;
                    }else{
                        counter = 7;
                    }
                    poNumber = cells.get(counter++).findElement(getCellContentLocator()).getText();
                    jobNumber = cells.get(counter++).findElement(getCellContentLocator()).getText();
                    no_clocks = cells.get(counter++).findElement(getCellContentLocator()).getText();
                    creator = "";
                    owner = "";
                    status = cells.get(counter++).findElement(getCellContentLocator()).getText();
                    break;
            }
        }

        private void initDependentmarketFieldds(List<WebElement> cells)
        {
            int counter ;
            if(cells.get(0).findElement(By.cssSelector(".cell-content a")).getAttribute("class").equalsIgnoreCase("spriteicon i16x16_pencil")){
                counter = 7;
            }else{
                counter = 6;
            }
            market = cells.get(counter++).findElement(getCellContentLocator()).getText();
        }

        private void clickTableRow() {
            tableRow.click();
        }

        private void expandOrderNestedList() {
            expander.click();
        }

        private void clickOrderReferenceLink(){
            orderReferenceLink.click();
        }

        private By getCellContentLocator() {
            return By.className("cell-content");
        }
    }

    public List<String> getVisibleMarkets(OrderStatus orderStatus) {
        List<String> markets = new ArrayList<String>();
        List<Order> orders = getOrders(orderStatus);
        if (orders == null) return markets;
        for (Order order : orders)
            markets.add(order.getMarket());
        return markets;
    }

    public List<String> getVisibleColumnValues(OrderStatus orderStatus, String columnName) {
        return getVisibleColumnValues(orderStatus, Column.findByName(columnName));
    }

    public Order getOrderByOrderReference(String orderReference, OrderStatus orderStatus) {
        for (Order order : getOrders(orderStatus))
            if (order.getOrderReference().equals(orderReference))
                return order;
        return null;
    }

    public Order getOrderByMarket(String market, OrderStatus orderStatus) {
        for (Order order : getOrders(orderStatus))
            if (order.getMarket().equals(market))
                return order;
        return null;
    }

    public void sortByColumn(String columnTitle, String sortingOrder) {
        sortingOrder = SortingOrder.findByOrder(sortingOrder);
        int i = 0;
        while (!getColumnByTitle(columnTitle).getAttribute("class").contains(sortingOrder) && i < 2) {
            WebElement column = getColumnByTitle(columnTitle);
            column.click();
            web.waitUntil(ExpectedConditions.stalenessOf(column));
            i++;
        }
    }

    private List<Order> getOrders(OrderStatus orderStatus) {
        if (!web.isElementPresent(getOrderRowLocator())) return null;
        List<WebElement> rows = web.findElements(getOrderRowLocator());
        List<Order> orders = new ArrayList<Order>();
        for (WebElement row: rows)
            orders.add(new Order(web, row, orderStatus, isCampaignColumnVisible()));
        return orders;
    }

    private List<String> getVisibleColumnValues(OrderStatus orderStatus, Column column) {
        List<String> entities = new ArrayList<>();
        List<Order> orders = getOrders(orderStatus);
        if (orders == null) return entities;
        for (Order order : orders) {
            switch (column) {
                case ORDER_REFERENCE: entities.add(order.getOrderReference()); break;
                case MARKET: entities.add(order.getMarket()); break;
                case ADVERTISER: entities.add(order.getAdvertiser()); break;
                case BRAND: entities.add(order.getBrand()); break;
                case SUB_BRAND: entities.add(order.getSubBrand()); break;
                case PRODUCT: entities.add(order.getProduct()); break;
                case CAMPAIGN: entities.add(order.getCampaign()); break;
                default: throw new IllegalArgumentException("Unknown column: " + column);
            }
        }
        return entities;
    }

    private boolean isCampaignColumnVisible() {
        for (String columnTitle : getVisibleColumnTitles())
            if (columnTitle.contains(SchemaField.CAMPAIGN.toString()))
                return true;
        return false;
    }

    private enum Column {
        ORDER_REFERENCE("Order #"),
        MARKET("Market"),
        ADVERTISER("Advertiser"),
        BRAND("Brand"),
        SUB_BRAND("Sub Brand"),
        PRODUCT("Product"),
        CAMPAIGN("Campaign");

        private String name;

        private Column(String name) {
            this.name = name;
        }


        @Override
        public String toString() {
            return name;
        }

        public static Column findByName(String name) {
            for (Column column : values())
                if (name.startsWith(column.toString()))
                    return column;
            throw new IllegalArgumentException("Unknown column: " + name);
        }
    }

    private enum SortingOrder {
        ASC("asc"),
        DESC("desc");

        private String order;

        private SortingOrder(String order) {
            this.order = order;
        }


        @Override
        public String toString() {
            return order;
        }

        public static String findByOrder(String order) {
            for (SortingOrder ord : values())
                if (ord.toString().equalsIgnoreCase(order))
                    return ord.toString();
            throw new IllegalArgumentException("Unknown sorting order: " + order);
        }
    }

    private WebElement getColumnByTitle(String title) {
        if (!web.isElementVisible(getColumnTitleLocatorByTitle(title))) throw new NoSuchElementException("No column with title: " + title);
        return web.findElement(getColumnTitleLocatorByTitle(title));
    }

    private By getColumnTitleLocatorByTitle(String title) {
        return By.cssSelector(getRootNode() + " [data-dojo-type='common.table.header'] [title='" + title + "']");
    }

    private By getOrderRowLocator() {
        return generateListLocator("[data-dojo-type='ordering.main.toggler']");
    }
}