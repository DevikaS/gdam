package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.babylon.sut.pages.ordering.elements.StepsOrderType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries.Markets;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.ApprovalConfirmationPopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 26.08.13
 * Time: 2:04
 */
public class OrderNestedList extends AbstractList {

    public OrderNestedList(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(generateNestedListLocator());
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(generateNestedListLocator()));
    }

    public static class OrderItem {
        private OrderNestedList parent;

        public WebElement getClockLink() {
            return clockLink;
        }

        public void setClockLink(WebElement clockLink) {
            this.clockLink = clockLink;
        }

        private WebElement clockLink;
        private String clock;
        private String advertiser;
        private String product;
        private String title;
        private String campaign;
        private String clave;
        private String onAirDate;
        private String format;
        private String duration;
        private String status;
        private String approve;
        private Button onHoldBtn;
        private WebElement nestedTableRow;
        private List<WebElement> cells;

        public OrderItem(OrderNestedList parent, WebElement row, StepsOrderType orderType, String market) {
            List<WebElement> cells = row.findElements(By.className("size1of10"));
            this.parent = parent;
            this.nestedTableRow = row;
            this.cells = cells;
            clockLink = cells.get(0).findElement(By.tagName("a"));
            clock = clockLink.getText();
            advertiser = cells.get(1).findElement(getCellContentLocator()).getText();
            product = cells.get(2).findElement(getCellContentLocator()).getText();
            initDependentFields(orderType, market);
        }


        public String getClockNumber() {
            return clock;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getProduct() {
            return product;
        }

        public String getTitle() {
            return title;
        }

        public String getClave() {
            return clave;
        }

        public String getOnAirDate() {
            return onAirDate;
        }

        public String getFormat() {
            return format;
        }

        public String getDuration() {
            return duration;
        }

        public String getCampaign() { return campaign; }

        // getting on demand, because it is present only for confirmed orders
        public String getStatus() {
            if (status == null)
                status = cells.get(7).findElement(By.tagName("div")).getText();
            return status;
        }

        // getting on demand, because it is present only for confirmed orders
        public String getApprove() {
            if (approve == null)
                approve = initApproveElement().findElement(By.cssSelector("[data-role*='approvalStatus']")).getText();
            return approve;
        }

        public void selectOrderItem() {
            if (!nestedTableRow.getAttribute("class").contains("selected"))
                clickNestedTableRow();
        }

        public ApprovalConfirmationPopUp getApprovalConfirmationPopUp() {
            if (!parent.getDriver().isElementVisible(By.xpath(ApprovalConfirmationPopUp.TITLE_NODE)))
                clickOnHoldBtn();
            return new ApprovalConfirmationPopUp(parent, ApprovalConfirmationPopUp.TITLE);
        }

        private void initDependentFields(StepsOrderType orderType, String market) {
            switch (orderType) {
                case MUSIC:
                    campaign = cells.get(3).findElement(getCellContentLocator()).getText();
                    title = cells.get(4).findElement(getCellContentLocator()).getText();
                    onAirDate = cells.get(5).findElement(getCellContentLocator()).getText();
                    format = cells.get(6).findElement(getCellContentLocator()).getText();
                    duration = "";
                    break;
                default:
                    int indexStep = 0;
                    campaign = "";
                    title = cells.get(3).findElement(getCellContentLocator()).getText();
                    if (market.equals(Markets.SPAIN.toString())) {
                        clave = cells.get(4).findElement(getCellContentLocator()).getText();
                        indexStep = 1;
                    }
                    onAirDate = cells.get(4 + indexStep).findElement(getCellContentLocator()).getText();
                    format = cells.get(5 + indexStep).findElement(getCellContentLocator()).getText();
                    duration = cells.get(6 + indexStep).findElement(getCellContentLocator()).getText();
                    break;
            }
        }

        private By getCellContentLocator() {
            return By.tagName("span");
        }

        private void clickNestedTableRow() {
            nestedTableRow.click();
        }

        private WebElement initApproveElement() {
            return nestedTableRow.findElement(By.className("size1of15"));
        }

        private Button initOnHoldBtn() {
            if (onHoldBtn == null)
                onHoldBtn = new Button(parent, initApproveElement().findElement(getCellContentLocator()));
            return onHoldBtn;
        }

        private void clickOnHoldBtn() {
            initOnHoldBtn().click();
        }
    }

    public OrderItem getOrderItemByClockNumber(String clockNumber, StepsOrderType orderType, String market) {
        for (OrderItem orderItem : getOrderItems(orderType, market))
            if (orderItem.getClockNumber().equals(clockNumber))
                return orderItem;
        return null;
    }

    public List<String> getVisibleOrderItemsClockNumbers(StepsOrderType orderType, String market) {
        List<String> clockNumbers = new ArrayList<String>();
        List<OrderItem> orderItems = getOrderItems(orderType, market);
        if (orderItems == null) return clockNumbers;
        for (OrderItem orderItem : orderItems)
            clockNumbers.add(orderItem.getClockNumber());
        return clockNumbers;
    }

    private List<OrderItem> getOrderItems(StepsOrderType orderType, String market) {
        if (!web.isElementPresent(getOrderItemRowLocator())) return null;
        List<WebElement> rows = web.findElements(getOrderItemRowLocator());
        List<OrderItem> orderItems = new ArrayList<OrderItem>();
        for (WebElement row : rows)
            orderItems.add(new OrderItem(this, row, orderType, market));
        return orderItems;
    }

    private By getOrderItemRowLocator() {
        return generateNestedListLocator(".row");
    }
}