package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.sut.pages.ordering.BaseOrderingPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.List;

/*
 * Created by demidovskiy-r on 30.07.2014.
 */
public class AssignSomeoneToSupplyMediaForm extends AbstractPopUpLayer {
    public final static String ROOT_NODE = POPUP_ROOT_NODE + " .content";
    private Button selectGroup;
    private Button ftp;
    private Button physicalMedia;
    private Button nVerge;
    private Edit assignee;
    private Edit postHouse;
    private Checkbox alreadySupplied;
    private Edit message;
    private DojoTextBox deadlineDate;
    private DojoTextBox daysBeforeFirstAirDate;
    private DojoCombo arrivalTime;
    private String orderNumber;
    private String clockNumber;
    private String previousAssignee;

    public AssignSomeoneToSupplyMediaForm(BaseOrderingPage parent) {
        super(parent);
        List<WebElement> cells = getDriver().findElements(generateFormElementLocator(".break-all"));
       // orderNumber = cells.get(0).getText();
        orderNumber = cells.get(0).getText().replaceAll("\\s+","");
       // clockNumber = cells.get(1).getText();
        clockNumber = cells.get(1).getText().replaceAll("\\s+", "");
        previousAssignee = cells.get(2).getText().replaceAll("\\s+", "");
        ftp = new Button(parent, getFtpBtnLocator());
       // selectGroup = new Button(parent, generateElementLocatorByDataRole("selectGroupBtn"));
        selectGroup = new Button(parent, generateSelectGroupButtonLocator("selectGroup(uploadRequest)"));
        physicalMedia = new Button(parent, getPhysicalMediaBtnLocator());
        nVerge = new Button(parent, getNVergeBtnLocator());
        action = new Button(parent, generatePopUpElementLocator("+ * .confirm"));
    }

    @Override
    protected void initControls() {
       // controls.put("Assignee", assignee = new Edit(parent, generateElementLocatorByDataRole("assignees")));
        controls.put("Assignee", assignee = new Edit(parent, generateElementLocatorByModel("assignees")));
        controls.put("Post House", postHouse = new Edit(parent, generateElementLocatorByDataRole("postHouse")));
        controls.put("Already Supplied", alreadySupplied = new Checkbox(parent, By.id("alreadySupplied")));
        controls.put("Message", message = new Edit(parent, generateElementLocatorByDataRole("message")));
        controls.put("Deadline Date", deadlineDate = new DojoTextBox(parent, generateFormElementLocator(".date")));
        controls.put("Days Before First Air Date", daysBeforeFirstAirDate = new DojoTextBox(parent, generateFormElementLocator(".dijitNumberTextBox")));
        controls.put("Arrival Time", arrivalTime = new DojoCombo(parent, generateFormElementLocator(".dijitTimeTextBox")));
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

    @Override
    public String getFieldValue(String fieldName) {
        if (fieldName.equals("Order Number")) return getOrderNumber();
        if (fieldName.equals("Clock Number")) return getClockNumber();
        if (fieldName.equals("Previous Assignee")) return getPreviousAssignee();
        return super.getFieldValue(fieldName);
    }

    public SelectNotificationGroup getSelectNotificationGroup(String groupName) {
        if (!getDriver().isElementVisible(By.cssSelector(SelectNotificationGroup.ROOT_NODE)))
            clickSelectNotificationGroupBtn();
        return new SelectNotificationGroup((BaseOrderingPage)parent, groupName);
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public String getClockNumber() {
        return clockNumber;
    }

    public String getPreviousAssignee() {
        return previousAssignee;
    }

    public void supplyVia(UploadRequestType uploadRequestType) {
        if (uploadRequestType.equals(UploadRequestType.FTP)) {
            if (!isUploadMessageContainerVisible() || !isUploadRequestButtonActive(UploadRequestType.FTP)) {
                clickFtpBtn();
              //  waitUntilUploadRequestBtnBecomeInactive(UploadRequestType.PHYSICAL.toString(), UploadRequestType.NVERGE.toString());
                waitUntilUploadRequestBtnBecomeDisabled(UploadRequestType.FTP.toString());
            }
        }
        else if (uploadRequestType.equals(UploadRequestType.PHYSICAL)) {
            if (!isUploadMessageContainerVisible() || !isUploadRequestButtonActive(UploadRequestType.PHYSICAL)) {
                clickPhysicalMediaBtn();
                //waitUntilUploadRequestBtnBecomeInactive(UploadRequestType.FTP.toString(), UploadRequestType.NVERGE.toString());
                waitUntilUploadRequestBtnBecomeDisabled(UploadRequestType.PHYSICAL.toString());
            }
        } else if (uploadRequestType.equals(UploadRequestType.NVERGE)) {
            if (!isUploadMessageContainerVisible() || !isUploadRequestButtonActive(UploadRequestType.NVERGE)) {
                clickNVergeBtn();
                //waitUntilUploadRequestBtnBecomeInactive(UploadRequestType.FTP.toString(), UploadRequestType.PHYSICAL.toString());
                waitUntilUploadRequestBtnBecomeDisabled(UploadRequestType.NVERGE.toString());
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

    public void send() {
        clickOkBtn();
    }


    public void setRemovePreviousAssignees(String shouldState)
    {
        WebElement elementLocator=getDriver().findElement(By.xpath("//input[contains(@ng-model,'uploadRequest.resetAssignees')]"));

        if(shouldState.equals("check"))
        {
            if (!elementLocator.isSelected())
                elementLocator.click();
        }
        else
            if(elementLocator.isSelected())
                elementLocator.click();
     }

    public boolean getRemovePreviousAssignees()
    {
        return getDriver().findElement(By.xpath("//input[contains(@ng-model,'uploadRequest.resetAssignees')]")).isSelected();
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
    private void waitUntilUploadRequestBtnBecomeDisabled(final String btnNameFirst) {
        getDriver().waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return webDriver.findElement(generateUploadTypeBtnLocator(btnNameFirst)).getAttribute("class").contains("inactiveButton");
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

    private By generateSelectGroupButtonLocator(String partialLocator) {

        return By.cssSelector(getRootNode() + " [ng-click='" + partialLocator + "']");
    }

    private By generateUploadTypeBtnLocator(String partialLocator) {
       // return By.cssSelector(getRootNode() + " [data-upload-type='" + partialLocator + "']");
        return By.cssSelector(getRootNode() + " [ng-click=\"uploadRequest.uploadType = '" + partialLocator + "'\"]");
    }

    private By generateElementLocatorByModel(String partialLocator) {

        return By.cssSelector(getRootNode() + " [ng-model='uploadRequest." + partialLocator + "']" +" .input");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}