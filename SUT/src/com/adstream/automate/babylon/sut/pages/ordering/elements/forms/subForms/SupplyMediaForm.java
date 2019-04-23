package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AddMediaToOrderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.SelectNotificationGroup;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;

/*
 * Created by demidovskiy on 20.01.14.
 */
public class SupplyMediaForm extends AddMediaToOrderForm {
    public static final String ROOT_NODE = "#uploadContainer";
    private Button ftp;
    private Button physicalMedia;
    private Button nVerge;
    private Button selectGroup;
    private Edit assignee;
    private Edit postHouse;
    private Checkbox alreadySupplied;
    private Edit message;
    private DojoTextBox deadlineDate;
    private DojoTextBox daysBeforeFirstAirDate;
    private DojoCombo arrivalTime;

    public SupplyMediaForm(OrderItemPage parent) {
        super(parent);
        selectGroup = new Button(parent, generateElementLocatorByDataRole("selectGroupBtn"));
        ftp = new Button(parent, getFtpBtnLocator());
        physicalMedia = new Button(parent, getPhysicalMediaBtnLocator());
        nVerge = new Button(parent, getNVergeBtnLocator());
    }

    @Override
    protected void initControls() {
        controls.put("Assignee", assignee = new Edit(parent, generateElementLocatorByDataRole("assignees")));
        controls.put("Post House", postHouse = new Edit(parent, generateElementLocatorByDataRole("postHouse")));
        controls.put("Already Supplied", alreadySupplied = new Checkbox(parent, By.id("alreadySupplied")));
        controls.put("Message", message = new Edit(parent, generateElementLocatorByDataRole("message")));
        controls.put("Deadline Date", deadlineDate = new DojoTextBox(parent, generateFormElementLocator(".date")));
        controls.put("Days Before First Air Date", daysBeforeFirstAirDate = new DojoTextBox(parent, generateFormElementLocator(".dijitNumberTextBox")));
        controls.put("Arrival Time", arrivalTime = new DojoCombo(parent, generateFormElementLocator(".dijitTimeTextBox")));
    }

    @Override
    protected void loadForm() {
        getDriver().waitUntilElementAppearVisible(getSupplyMediaFormLocator());
    }

    @Override
    protected void unloadForm() {
        getDriver().waitUntilElementDisappear(getSupplyMediaFormLocator());
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    public SelectNotificationGroup getSelectNotificationGroup(String groupName) {
        if (!getDriver().isElementVisible(By.cssSelector(SelectNotificationGroup.ROOT_NODE)))
            clickSelectNotificationGroupBtn();
        return new SelectNotificationGroup(parent, groupName);
    }

    public void supplyVia(UploadRequestType uploadRequestType) {
        if (uploadRequestType.equals(UploadRequestType.FTP)) {
            if (!isUploadMessageContainerVisible() || !isUploadRequestButtonActive(UploadRequestType.FTP)) {
                clickFtpBtn();
                waitUntilUploadRequestBtnBecomeInactive(UploadRequestType.PHYSICAL.toString(), UploadRequestType.NVERGE.toString());
            }
        }
        else if (uploadRequestType.equals(UploadRequestType.PHYSICAL)) {
            if (!isUploadMessageContainerVisible() || !isUploadRequestButtonActive(UploadRequestType.PHYSICAL)) {
                clickPhysicalMediaBtn();
                waitUntilUploadRequestBtnBecomeInactive(UploadRequestType.FTP.toString(), UploadRequestType.NVERGE.toString());
            }
        } else if (uploadRequestType.equals(UploadRequestType.NVERGE)) {
            if (!isUploadMessageContainerVisible() || !isUploadRequestButtonActive(UploadRequestType.NVERGE)) {
                clickNVergeBtn();
                waitUntilUploadRequestBtnBecomeInactive(UploadRequestType.FTP.toString(), UploadRequestType.PHYSICAL.toString());
            }
        }
        else
            throw new IllegalArgumentException("Unknown upload request type: " + uploadRequestType.toString());
    }

    public int getCountAutoCompleteEmails() {
        if (getDriver().isElementVisible(getAutoCompleteItemLocator()))
            return getDriver().findElements(getAutoCompleteItemLocator()).size();
        return 0;
    }

    private boolean isUploadRequestButtonActive(UploadRequestType uploadRequestType) {
        switch (uploadRequestType) {
            case FTP: return !ftp.getAttribute("class").contains("inactiveButton");
            case PHYSICAL: return !physicalMedia.getAttribute("class").contains("inactiveButton");
            case NVERGE: return !nVerge.getAttribute("class").contains("inactiveButton");
            default: throw new IllegalArgumentException("Unknown upload request type: " + uploadRequestType.toString());
        }
    }

    private void waitUntilUploadRequestBtnBecomeInactive(final String btnNameFirst, final String btnNameSecond) {
        getDriver().waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return webDriver.findElement(generateUploadTypeBtnLocator(btnNameFirst)).getAttribute("class").contains("inactiveButton")
                        && webDriver.findElement(generateUploadTypeBtnLocator(btnNameSecond)).getAttribute("class").contains("inactiveButton");
            }
        });
    }

    private void clickSelectNotificationGroupBtn() {
        selectGroup.click();
    }

    private void clickFtpBtn() {
        ftp.click();
    }

    private void clickPhysicalMediaBtn() {
        physicalMedia.click();
    }

    private void clickNVergeBtn() {
        nVerge.click();
    }

    private boolean isUploadMessageContainerVisible() {
        return getDriver().isElementVisible(generateElementLocatorByDataRole("uploadMessageContainer"));
    }

    private By getFtpBtnLocator() {
        return generateUploadTypeBtnLocator(UploadRequestType.FTP.toString());
    }

    private By getPhysicalMediaBtnLocator() {
        return generateUploadTypeBtnLocator(UploadRequestType.PHYSICAL.toString());
    }

    private By getNVergeBtnLocator() {
        return generateUploadTypeBtnLocator(UploadRequestType.NVERGE.toString());
    }

    private By generateElementLocatorByDataRole(String partialLocator) {
        return By.cssSelector(getRootNode() + " [data-role='" + partialLocator + "']");
    }

    private By generateUploadTypeBtnLocator(String partialLocator) {
        return By.cssSelector(getRootNode() + " [data-upload-type='" + partialLocator + "']");
    }
}