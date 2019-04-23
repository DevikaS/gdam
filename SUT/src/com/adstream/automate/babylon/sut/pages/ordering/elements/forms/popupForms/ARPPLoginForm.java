package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.List;

/*
 * Created by demidovskiy-r on 04.08.2014.
 */
public class ARPPLoginForm extends AbstractPopUpLayer {
    public final static String ROOT_NODE = POPUP_ROOT_NODE + " .b-form-dialog";
    private Edit login;
    private Edit password;
    private List<WebElement> inputControls;

    public ARPPLoginForm(OrderItemPage parent) {
        super(parent);
        inputControls = getDriver().findElements(generateFormElementLocator(".dijitInputInner"));
    }

    @Override
    protected void initControls() {
        controls.put("Login", login = new Edit(parent, inputControls.get(0)));
        controls.put("Password", password = new Edit(parent, inputControls.get(1)));
    }

    @Override
    protected void loadForm() {
        getDriver().waitUntilElementAppearVisible(getFormLocator());
    }

    @Override
    protected void unloadForm() {
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    public void login() {
        clickOkBtn();
    }

    public void clickLoginButton() {
        action.click();
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}