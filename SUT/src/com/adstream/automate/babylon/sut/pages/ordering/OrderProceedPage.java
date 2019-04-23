package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.TransferOrderForm;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 18.11.13
 * Time: 15:37
 */
public class OrderProceedPage extends BaseOrderingPage<OrderProceedPage> {
    private Button backBtn;
    private Button vddBtn;
    private String warningForMixtureOfSdHdAssets;
    private Button saveAsDraftBtn;
    private Button transferOrderBtn;
    private Button confirm;
    private String invoicingOrganisation;
    private static final String ROOT_NODE = "[data-dojo-type='ordering.proceed.confirm']";
    private final String qcViewSummaryProps = "[data-dojo-type='ordering.proceed.QCView']";
    public static final String billingProps = "#billingPage";
    public static final String billingProps_notVisible = "//div[@class='pbs']/div[1]/div[1]/div[1]";

    public OrderProceedPage(ExtendedWebDriver web) {
        super(web);
        backBtn = new Button(this, By.className("back"));
        vddBtn = new Button(this, By.cssSelector(".unit-right .button"));
        saveAsDraftBtn = new Button(this, generatePageElementLocatorByDataRole("saveAsDraft"));
        transferOrderBtn = new Button(this, generatePageElementLocatorByDataRole("transfer"));
        confirm = new Button(this, generatePageElementLocatorByDataRole("confirm"));
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getOrderProceedPageLocator());
    }

    public void isLoaded() throws Error {
        waitUntilLoadBillingSpinnerDisappears();
        super.isLoaded();
        assertTrue(web.isElementVisible(getOrderProceedPageLocator()));
    }

    public OrderItemPage back() {
        backBtn.click();
        return new OrderItemPage(web);
    }

    public ViewDestinationDetailsPage ClickVDD_btn(){
        vddBtn.click();
        return new ViewDestinationDetailsPage(web);
    }


    public String getWarningForMixtureOfSdHdAssets() {
        if (warningForMixtureOfSdHdAssets == null)
            warningForMixtureOfSdHdAssets = web.findElement(generatePageElementLocator(".warningMixture")).getText().trim();
        return warningForMixtureOfSdHdAssets;
    }

    public static class OrderDetailsForm extends AbstractForm {
        private Checkbox handleStandardsConversions;
        private Checkbox notifyAboutDelivery;
        private Checkbox notifyAboutQC;
        private Edit emailList;
        private Edit jobNumber;
        private Edit poNumber;
        private Edit orderconfirmemail;
        private Edit ordercompleteemail;
        private Edit orderingestedemail;

        public OrderDetailsForm(OrderProceedPage parent) {
            super(parent);
        }

        @Override
        protected void initControls() {
            controls.put("Manage Format Conversions", handleStandardsConversions = new Checkbox(parent, By.name("handleStandardsConversions")));
            controls.put("Notify About Delivery", notifyAboutDelivery = new Checkbox(parent, By.name("notifyAboutDelivery")));
            controls.put("Notify About Passed QC", notifyAboutQC = new Checkbox(parent, By.name("notifyAboutQc")));
            controls.put("Recipients", emailList = new Edit(parent, By.cssSelector("div[id*='EmailList'] [data-name='notificationEmails']")));
            controls.put("Job Number", jobNumber = new Edit(parent, By.cssSelector("[data-name='jobNumber']")));
            controls.put("PO Number", poNumber = new Edit(parent, By.cssSelector("[data-name='poNumber']")));
            controls.put("Order Confirmed Recipients", orderconfirmemail = new Edit(parent, By.cssSelector("[id*='EmailList'] [data-name='notificationEmails.confirmed']")));
            controls.put("Order Completed Recipients", ordercompleteemail = new Edit(parent, By.cssSelector("[id*='EmailList'] [data-name='notificationEmails.completed']")));
            controls.put("Order Ingested Recipients", orderingestedemail = new Edit(parent, By.cssSelector("[id*='EmailList'] [data-name='notificationEmails.ingested']")));
        }

        @Override
        protected void loadForm() {}

        @Override
        protected void unloadForm() {}

        @Override
        protected String getRootNode() {
            return ROOT_NODE;
        }

        public boolean isFormatConversionSelected() {
            handleStandardsConversions = new Checkbox(parent, By.name("handleStandardsConversions"));
            return handleStandardsConversions.isSelected();
        }

        public boolean isFormatConversionActive() {
            handleStandardsConversions = new Checkbox(parent, By.name("handleStandardsConversions"));
            return handleStandardsConversions.isEnabled();
        }
    }

    public static class QcViewItem extends PageElement<OrderProceedPage> {
        private String clockNumber;
        private String advertiser;
        private String title;
        private String duration;
        private String format;
        private String subtitlesRequired;
        private Checkbox archive;

        public QcViewItem(ExtendedWebDriver web, OrderProceedPage parent, WebElement row) {
            super(web, parent);
            List<WebElement> units = row.findElements(By.className("display-table-cell"));
            if(units.size()>6){
            clockNumber = units.get(0).getText();
            advertiser = units.get(1).getText();
            subtitlesRequired = units.get(2).getText();
            title = units.get(3).getText();
            duration = units.get(4).getText();
            format = units.get(5).getText().replaceAll("\n ", "");
            archive = new Checkbox(parent, row.findElement(By.name("qcView")));
            } else {
            clockNumber = units.get(0).getText();
            advertiser = units.get(1).getText();
            title = units.get(2).getText();
            duration = units.get(3).getText();
            format = units.get(4).getText().replaceAll("\n ", "");
            archive = new Checkbox(parent, row.findElement(By.name("qcView")));
            }
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getSubtitlesRequired() { return subtitlesRequired;}

        public String getTitle() {
            return title;
        }

        public String getDuration() {
            return duration;
        }

        public String getFormat() {
            return format;
        }

        public boolean isArchiveSelected() {
            return archive.isSelected();
        }

        public boolean isArchiveActive() {
            if(archive.getAttribute("class").equalsIgnoreCase("none")) {
                return false;
            }else{
                return archive.isEnabled();
            }
        }

        public void selectArchive(boolean isSelected) {
            archive.setSelected(isSelected);
        }
    }

    public boolean isQcViewSummaryInfoVisible() {
        return web.isElementVisible(getQcViewSummaryItemLocator());
    }

    public QcViewItem getQcViewItemByClockNumber(String clockNumber) {
        for (QcViewItem qcViewItem : getQcViewItems())
            if (qcViewItem.getClockNumber().equals(clockNumber))
                return qcViewItem;
        return null;
    }

    public QcViewItem getQcViewItemByTitle(String title) {
        for (QcViewItem qcViewItem: getQcViewItems())
            if (qcViewItem.getTitle().equals(title))
                return qcViewItem;
        return null;
    }

    public List<String> getQcViewSummaryHeaders() {
        List<String> headers = new ArrayList<>();
        List<WebElement> qcViewHeaders = getQcViewHeaders();
        if (qcViewHeaders == null || qcViewHeaders.isEmpty()) return headers;
        for (WebElement qcViewHeader : qcViewHeaders)
            headers.add(qcViewHeader.getText().trim());
        return headers;
    }

    public int getQcViewItemsCount() {
        return web.findElements(getQcViewSummaryItemLocator()).size();
    }

    public Billing getBilling() {
        if (!isBillingVisible())
            throw new NoSuchElementException("There is no Billing part on the Order Proceed page!");
        WebElement billingData = web.findElement(getBillingLocator());
        return new Billing(web, this, billingData);
    }

    public boolean isBillingVisible() {
        return web.isElementVisible(getBillingLocator());
    }

    public boolean isBillingVisible_new() {
        boolean result=true;
        try { web.findElement(getBillingLocator_new()); }
        catch (Exception e)
        { result = false;}

        return result;
    }

    public OrderDetailsForm getOrderDetailsForm() {
        return new OrderDetailsForm(this);
    }

    public int getCountAutoCompleteEmails() {
        if (web.isElementVisible(getAutoCompleteItemLocator()))
            return web.findElements(getAutoCompleteItemLocator()).size();
        return 0;
    }

    public String getInvoicingOrganisation() {
        if (invoicingOrganisation == null)
            invoicingOrganisation = web.findElement(getInvoicingOrganisationLocator()).getText();
        return invoicingOrganisation;
    }

    public boolean isInvoiceToVisible() {
        return web.isElementVisible(getInvoicingOrganisationLocator());
    }

    public OrderingPage saveAsDraft() {
        clickSaveAsDraftBtn();
        return new OrderingPage(web);
    }

    public TransferOrderForm getTransferOrderForm() {
        if (!web.isElementVisible(By.cssSelector(TransferOrderForm.ROOT_NODE)))
            clickTransferBtn();
        return new TransferOrderForm(this);
    }

    public OrderingPage confirm() {
        clickConfirmBtn();
        return new OrderingPage(web);
    }

    public OrderEditSummaryPage confirmAfterOrderEdit() {
        clickConfirmBtn();
        return new OrderEditSummaryPage(web);
    }

    public boolean isConfirmButtonVisible() {
        return confirm.isVisible();
    }

    private void clickSaveAsDraftBtn() {
        saveAsDraftBtn.click();
    }

    private void clickTransferBtn() {
        transferOrderBtn.click();
    }

    private void clickConfirmBtn() {
        confirm.click();
    }

    private List<QcViewItem> getQcViewItems() {
        if (!getDriver().isElementVisible(getQcViewSummaryItemLocator()))
            throw new NoSuchElementException("There are no any Qc View Summary items on Order Proceed page!");
        List<WebElement> rows = getDriver().findElements(getQcViewSummaryItemLocator());
        List<QcViewItem> qcViewItems = new ArrayList<>();
        for (WebElement row : rows)
            qcViewItems.add(new QcViewItem(getDriver(), this, row));
        return qcViewItems;
    }

    private List<WebElement> getQcViewHeaders() {
        return web.findElements(generateQcViewSummaryPart(".h5 .display-table-cell"));
    }

    private By getQcViewSummaryItemLocator() {
        return generateQcViewSummaryPart(".b-content.display-table-row");
    }

    private void waitUntilLoadBillingSpinnerDisappears() {
        web.sleep(1000);
        web.waitUntilElementDisappear(By.cssSelector(".block-spinner > .orders-spinner"));
    }

    private By generateQcViewSummaryPart(String partialLocator) {
        return By.cssSelector(qcViewSummaryProps + " " + partialLocator);
    }

    private By generatePageElementLocatorByDataRole(String partialLocator) {
        return By.cssSelector(String.format("%s %s", ROOT_NODE, "[data-role='" + partialLocator + "']"));
    }

    private By generatePageElementLocator(String partialLocator) {
        return By.cssSelector(String.format("%s %s", ROOT_NODE, partialLocator));
    }

    private By getBillingLocator() {
        return By.cssSelector(billingProps);
    }

    // Web locater for empty billing
    private By getBillingLocator_new() {
        return By.xpath(billingProps_notVisible);
    }

    private By getInvoicingOrganisationLocator() {
        return By.cssSelector(".text-right.p");
    }

    private By getOrderProceedPageLocator() {
        return By.cssSelector(ROOT_NODE);
    }
}