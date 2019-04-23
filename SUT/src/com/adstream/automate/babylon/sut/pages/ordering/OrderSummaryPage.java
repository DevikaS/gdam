package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.AssignSomeoneToSupplyMediaForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.TableFilterOrderSummaryPageSettings;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.ClockDeliveryList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 16.09.13
 * Time: 22:33
 */
public class OrderSummaryPage extends BaseOrderingPage<OrderSummaryPage> {
    private Button backBtn;
    private Button viewBillingBtn;
    private Button viewDeliveryReportBtn;
    private Button viewConfirmationReportBtn;
    private Button sendNewUploadRequestBtn;

    public OrderSummaryPage(ExtendedWebDriver web) {
        super(web);
        backBtn = new Button(this, By.cssSelector("[data-role='formContainer'] .back"));
        viewBillingBtn = new Button(this, generateViewButtonLocator("View Billing"));
        viewDeliveryReportBtn = new Button(this, generateViewButtonLocator("View Delivery Report"));
        viewConfirmationReportBtn = new Button(this, generateViewButtonLocator("View Confirmation Report"));
        sendNewUploadRequestBtn = new Button(this, generateViewButtonLocator("Send New Upload Request"));
    }

    private String pageBlockViewDeliveryReport = "#the-canvas";

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getOrderSummaryContentLocator());
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getOrderSummaryContentLocator()));
    }

    public OrderingPage back() {
        backBtn.click();
        return new OrderingPage(web);
    }

    public void clickViewDeliveryReportButton(){
        viewDeliveryReportBtn.click();
    }

    public void clickViewBillingButton(){
        viewBillingBtn.click();
    }

    private By getViewDeliveryReportPopUpLocator() {
        return By.id("report");
    }

    public boolean checkViewDeliveryReportOpened(){
        web.sleep(2000);
        Set<String> windowId = web.getWindowHandles();    // get  window id of current window
        Iterator<String> itererator = windowId.iterator();

        String mainWinID = itererator.next();
        String  newAdwinID = itererator.next();

        web.switchTo().window(newAdwinID);

        web.waitUntilElementAppearVisible(getViewDeliveryReportPopUpLocator());
        return web.findElement(By.cssSelector(pageBlockViewDeliveryReport)).isDisplayed();
    }

    public static class OrderSummaryInformation {
        private String orderNumber;
        private String organisation;
        private String dateSubmitted;
        private String createdBy;
        private String jobNumber;
        private String poNumber;
        private String flag;
        private String market;
        private String assignedToSupplyMedia;
        private String invoicedOrganisation;

        public OrderSummaryInformation(ExtendedWebDriver web, WebElement orderSummaryInformation) {
            List<WebElement> firstColumnCells = orderSummaryInformation.findElements(generateColumnLocator("nth-child(1)"));
            List<WebElement> secondColumnCells = orderSummaryInformation.findElements(generateColumnLocator("nth-child(2)"));
            WebElement assignedToSupplyMediaElement = orderSummaryInformation.findElement(generateColumnLocator("nth-child(3)"));
            orderNumber = prepareValue(firstColumnCells.get(0).getText());
            organisation = prepareValue(firstColumnCells.get(1).getText());
            dateSubmitted = prepareValue(firstColumnCells.get(2).getText());
            createdBy = prepareValue(firstColumnCells.get(3).getText());
            jobNumber = prepareValue(secondColumnCells.get(0).getText());
            poNumber = prepareValue(secondColumnCells.get(1).getText());
            flag = secondColumnCells.get(2).findElement(By.className("icon-market")).getAttribute("class");
            assignedToSupplyMedia = assignedToSupplyMediaElement.getText().replaceAll("\n", " ").trim();
            market = secondColumnCells.get(2).findElement(By.cssSelector(".unit:last-child")).getText();
            invoicedOrganisation = secondColumnCells.size() < 4 ? "" : prepareValue(secondColumnCells.get(3).getText());
        }

        public String getOrderNumber() {
            return orderNumber;
        }

        public String getOrganisation() {
            return organisation;
        }

        public String getDateSubmitted() {
            return dateSubmitted;
        }

        public String getCreatedBy() {
            return createdBy;
        }

        public String getJobNumber() {
            return jobNumber;
        }

        public String getPoNumber() {
            return poNumber;
        }

        public String getFlag() {
            return flag;
        }

        public String getMarket() {
            return market;
        }

        public String getAssignedToSupplyMedia() {
            return assignedToSupplyMedia;
        }

        public String getInvoicedOrganisation() {
            return invoicedOrganisation;
        }

        private By generateColumnLocator(String partialLocator) {
            return By.cssSelector(".size1of5:" + partialLocator + " .pvxs");
        }

        private String prepareValue(String value) {
            return value.replaceAll("^\\D+:\\s+", "");
        }
    }

    public OrderSummaryInformation getOrderSummaryInformation() {
        if (!web.isElementVisible(getOrderSummaryInformationLocator()))
            throw  new NoSuchElementException("There is no Order Summary Information section on Order Summary Page!");
        WebElement orderSummaryInformation = web.findElement(getOrderSummaryInformationLocator());
        return new OrderSummaryInformation(web, orderSummaryInformation);
    }

    public ClockDeliveryList getClockDeliveryList() {
        if (!web.isElementVisible(By.className("itemsList")))
            throw new NoSuchElementException("Clock delivery list is not present on the page!");
        return new ClockDeliveryList(web);
    }

    public boolean isViewDeliveryReportButtonEnabled() {
        return viewDeliveryReportBtn.isEnabled();
    }

    public boolean isViewButtonVisible(String buttonName) {
        return isViewBtnVisible(buttonName);
    }

    public AssignSomeoneToSupplyMediaForm getAssignSomeoneToSupplyMediaForm() {
        if (!isAssignSomeoneToSupplyMediaFormVisible())
            clickSendNewRequestButton();
        return new AssignSomeoneToSupplyMediaForm(this);
    }

    public boolean isAssignSomeoneToSupplyMediaFormVisible() {
        return web.isElementVisible(By.cssSelector(AssignSomeoneToSupplyMediaForm.ROOT_NODE));
    }

    private void clickSendNewRequestButton() {
        sendNewUploadRequestBtn.click();
    }

    private boolean isViewBtnVisible(String buttonName) {
        switch (buttonName) {
            case "Send New Upload Request": return sendNewUploadRequestBtn.isVisible();
            case "View Confirmation Report": return viewConfirmationReportBtn.isVisible();
            case "View Delivery Report": return viewDeliveryReportBtn.isVisible();
            case "View Billing": return viewBillingBtn.isVisible();
            default: throw new IllegalArgumentException("Unknown button: " + buttonName);
        }
    }

    private By generateViewButtonLocator(String partialLocator) {
        return By.xpath("//button[normalize-space(.)='" + partialLocator + "']");
    }

    private By getOrderSummaryInformationLocator() {
        return By.id("summaryInfo");
    }

    private By getOrderSummaryContentLocator() {
        return By.className("b-summary");
    }


    private Button simpleDropDownBtn;
    private Button initSimpleDropDownBtn() {
        if (simpleDropDownBtn == null)
            simpleDropDownBtn = new Button(this, generateOperationControlsLocator());
        return simpleDropDownBtn;
    }

    private By generateOperationControlsLocator() {
        return By.cssSelector("[data-role='dropButton']" );
    }

    private void expandTableFiltersSettings() {
        initSimpleDropDownBtn().click();
    }

    public TableFilterOrderSummaryPageSettings getTableFilterSettings() {
        if (!web.isElementVisible(By.cssSelector(TableFilterOrderSummaryPageSettings.ROOT_NODE)))
            expandTableFiltersSettings();
        return new TableFilterOrderSummaryPageSettings(this);
    }
}