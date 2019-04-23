package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.TableFilterOrderSummaryPageSettings;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: Geethanjali.K
 * Date: 12.02.18
 * Time: 22:33
 */
public class ViewBillingPage extends BaseOrderingPage<ViewBillingPage> {
    private Button backBtn;
    public static final String billingProps = ".clearfix.pbxs.ng-scope";
    public static final String billingProps_notVisible = ".clearfix.pbm.ptl.size4of5.relative";

    public ViewBillingPage(ExtendedWebDriver web) {
        super(web);
        backBtn = new Button(this, By.cssSelector("[data-role='formContainer'] .back"));
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getOrderSummaryContentLocator());
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getOrderSummaryContentLocator()));
    }

    public OrderSummaryPage back() {
        backBtn.click();
        return new OrderSummaryPage(web);
    }


    private By getBillingLocator() {
        return By.cssSelector(billingProps);
    }

    public ViewBilling getBilling() {
        if (!checkViewBillingOpened())
            throw new NoSuchElementException("There is no Billing part on the Order Proceed page!");
        WebElement billingData = web.findElement(getBillingLocator());
        return new ViewBilling(web, this, billingData);
    }

    public void waitUntilBillingIsVisible() {
        long start = System.currentTimeMillis();
        final long timeOut = 300;
        final long globalTimeout = 7 * 60 * 1000; // 7 min's

        do {
            if (timeOut > 0)
                web.navigate().refresh();
                Common.sleep(timeOut * 1);
        } while (!web.isElementVisible(By.cssSelector("[ng-repeat='bill in billing.billingItem.bills']")) && System.currentTimeMillis() - start < globalTimeout);
        if (System.currentTimeMillis() - start > globalTimeout) {
            throw new TimeoutException("Timeout while checking the Billing. Check billing on 'View Billing' page");
        }
    }

    private By getBillingLocator_new() {
        return By.cssSelector(billingProps_notVisible);
    }

    public boolean checkViewBillingOpened(){
        boolean result=true;
        try { web.findElement(getBillingLocator_new()); }
        catch (Exception e)
        { result = false;}

        return result;
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

 }