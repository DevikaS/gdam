package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.DojoCombo;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.List;

/*
 * Created by Janaki on 12.02.2015.
 */
public class ChangeBUOnBehalf extends AbstractPopUp {
    public final static String TITLE = "Select Client";
    public final static String TITLE_NODE = generateTitleNode(TITLE);
    private String title;
    private List<WebElement> controls;
    private DojoCombo onBehalfOfBU;
    private DojoCombo invoiceOnBehalfOfBU;

    public ChangeBUOnBehalf(BasePage parentPage, String title) {
        super(parentPage, title);
        this.title = title;
        controls = web.findElements(generateLocator("+ * .dijitComboBox"));
        onBehalfOfBU = new DojoCombo(parentPage, controls.get(0));
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
        web.sleep(1000);
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    public ChangeBUOnBehalf selectOnBehalfOfBU(String agencyName) {
        onBehalfOfBU.selectByVisibleText(agencyName);
        return new ChangeBUOnBehalf((BasePage)parentPage,  title);
    }

    public ChangeBUOnBehalf selectInvoiceOnBehalfOfBU(String agencyName) {
        initInvoiceOnBehalfOfBUControl().selectByVisibleText(agencyName);
        return new ChangeBUOnBehalf((BasePage)parentPage, title);
    }

    public List<String> getAvailableInvoiceOnBehalfOfBUs() {
        return initInvoiceOnBehalfOfBUControl().getValues();
    }

    public OrderItemPage changeBU() {
        clickOkBtn();
        web.sleep(1000);
        waitUntilLoadSpinnerDisappears();
        return new OrderItemPage(web);
    }

    private DojoCombo initInvoiceOnBehalfOfBUControl() {
        if (invoiceOnBehalfOfBU == null)
            invoiceOnBehalfOfBU = new DojoCombo(parentPage, controls.get(1));
        return invoiceOnBehalfOfBU;
    }

    protected By getPopUpLocator() {
        return By.xpath(TITLE_NODE);
    }
}