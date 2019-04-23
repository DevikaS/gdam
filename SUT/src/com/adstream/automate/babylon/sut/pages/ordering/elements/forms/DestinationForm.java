package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.DeleteDestinationPopUp;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 04.03.14.
 */
public class DestinationForm extends AbstractForm {
    public final static String ROOT_NODE = "[data-dojo-type='common.form.manager']";
    private String title;
    private Button closeBtn;
    private Button addBtn;
    private Button deleteDestinationBtn;
    private Button cancelBtn;

    public DestinationForm(OrderItemPage parent) {
        super(parent);
        title = getDriver().findElement(getFormTitleLocator()).getText();
        addBtn = new Button(parent, By.cssSelector("[data-id='add']"));
        deleteDestinationBtn = new Button(parent, By.cssSelector("[data-id='delete']"));
        cancelBtn = new Button(parent, By.cssSelector("[data-id='cancel']"));
        closeBtn = new Button(parent, By.cssSelector("[data-id='close-dialog']"));
    }

    @Override
    protected void initControls() {
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

    public String getFormTitle() {
        return title;
    }

    public void add() {
        addBtn.click();
        Common.sleep(10000);
        unloadForm();
    }

    public void cancel() {
        cancelBtn.click();
        unloadForm();
    }

    public void close() {
        closeBtn.click();
        unloadForm();
    }

    public DeleteDestinationPopUp getDeleteDestinationPopUp() {
        if (!getDriver().isElementVisible(By.xpath(DeleteDestinationPopUp.TITLE_NODE)))
            deleteDestination();
        return new DeleteDestinationPopUp((OrderItemPage)parent, "Delete destination");
    }

    public boolean isAddButtonActive() {
        return !addBtn.getAttribute("class").contains("disabled");
    }

    private void deleteDestination() {
        deleteDestinationBtn.click();
    }

    protected By getControlLocatorByName(String name) {
        return By.name(name);
    }

    private By getFormTitleLocator() {
        return By.cssSelector(".popupWindow.dijitDialog:not([style*='display: none']) [id='${id}_title']");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}