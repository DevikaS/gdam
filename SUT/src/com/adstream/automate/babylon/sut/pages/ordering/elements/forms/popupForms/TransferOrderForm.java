package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.page.AbstractControl;
import com.adstream.automate.page.controls.DojoAutoSuggest;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.Map;

/*
 * Created by demidovskiy-r on 19.03.14.
 */
public class TransferOrderForm extends AbstractPopUpLayer {
    public final static String ROOT_NODE = POPUP_ROOT_NODE + " [data-dojo-type='common.form.form']";
    private String orderNumber;
    private DojoAutoSuggest transferTo;
    private Edit message;

    public TransferOrderForm(BasePage parent) {
        super(parent);
        orderNumber = getDriver().findElement(generateFormElementLocator(".blue")).getText();
    }

    @Override
    protected void initControls() {
        controls.put("Transfer to", transferTo = new DojoAutoSuggest(parent, generateFormElementLocator(".as-selections")));
        controls.put("Message", message = new Edit(parent, generateFormElementLocator(".dijitTextArea")));
    }

    @Override
    protected void loadForm() {
        getDriver().waitUntilElementAppear(getFormLocator());
    }

    @Override
    protected void unloadForm() {
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    public void send() {
        clickOkBtn();
    }

    public boolean isSendButtonEnabled() {
        return !action.getAttribute("class").contains("disabled");
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void fillTransfer(Map<String, String> fields) {
        for (Map.Entry<String, String> field : fields.entrySet()) {
            String fieldName = field.getKey();
            String fieldValue = field.getValue();
            if (getControls().containsKey(fieldName)) {
                AbstractControl control = getControls().get(fieldName);
                if (control instanceof Edit) {
                    if (control.isEnabled())
                        ((Edit) control).type(fieldValue,1000);}
                else if (control instanceof DojoAutoSuggest) {
                    WebElement transferedit = getDriver().findElement(By.xpath("//span[contains(.,'Enter the email of the person')]"));
                    transferedit.sendKeys(fieldValue);
                    if (getDriver().isElementPresent(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", fieldValue))))
                        getDriver().click(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", fieldValue)));
                    getDriver().sleep(2000);
                }
                else
                    throw new IllegalStateException("Unknown class of control: " + control.getClass());
            } else
                throw new IllegalArgumentException("Unknown field name: " + fieldName);
        }
    }


    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}