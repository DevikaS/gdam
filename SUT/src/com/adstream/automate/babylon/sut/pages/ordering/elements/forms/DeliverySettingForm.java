package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.DeliverySettingPage;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;
import java.util.List;

/*
 * Created by demidovskiy-r on 27.08.2014.
 */
public class DeliverySettingForm extends AbstractForm {
    public final static String ROOT_NODE = "[data-dojo-type='admin.people.UsersDeliveryFormSettings']";
    private DojoCombo defaultMarket;
    private Edit expandedMultipleMarkets;
    private DojoAutoSuggest defaultTransferUser;
    private Edit defaultEmailNotifications;
    private DojoCombo closedCaptionsRequired;
    private Checkbox alwaysNotifyWhenPassedQC;
    private Checkbox alwaysNotifyWhenDelivered;
    private Checkbox alwaysHoldForApproval;
    private Checkbox exceptQCedMasters;
    private Checkbox alwaysAdbank;
    private DojoTextBox addMediaDeadlineDefault;

    public DeliverySettingForm(DeliverySettingPage parent) {
        super(parent);
    }

    @Override
    protected void initControls() {
        controls.put("Default Market", defaultMarket = new DojoCombo(parent, generateFormElementLocator("[id*='widget_admin_people_marketList']")));
        controls.put("Expanded Multiple Markets", expandedMultipleMarkets = new Edit(parent, generateFormElementLocator("[data-role='markets']")));
        controls.put("Default Transfer User", defaultTransferUser = new DojoAutoSuggest(parent, generateFormElementLocator(".as-selections")));
        controls.put("Default Email Notifications", defaultEmailNotifications = new Edit(parent, generateControlLocatorByName("defaultEmailNotifications")));
        controls.put("Closed Captions Required", closedCaptionsRequired = new DojoCombo(parent, generateFormElementLocator("[id*='closedCaptions'].dijitComboBox")));
        controls.put("Always Notify When Passed QC", alwaysNotifyWhenPassedQC = new Checkbox(parent, generateControlLocatorByName("notifyAboutQc")));
        controls.put("Always Notify When Delivered", alwaysNotifyWhenDelivered = new Checkbox(parent, generateControlLocatorByName("notifyAboutDelivery")));
        controls.put("Always Hold For Approval", alwaysHoldForApproval = new Checkbox(parent, generateControlLocatorByName("alwaysHoldForApproval")));
        controls.put("Except QCed Masters", exceptQCedMasters = new Checkbox(parent, generateControlLocatorByName("excludeFromLibrary")));
        controls.put("Always Adbank", alwaysAdbank = new Checkbox(parent, By.name("_cm.view.ordering.alwaysAdbank")));
        controls.put("Add Media Deadline Default", addMediaDeadlineDefault = new DojoTextBox(parent, generateFormElementLocator(".dijitNumberTextBox")));
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

    public List<String> getAvailableClosedCaptions() {
        getControls();
        return closedCaptionsRequired.getValues();
    }

    public int getCountAutoCompleteDefaultEmailNotifications() {
        if (getDriver().isElementVisible(getAutoCompleteItemLocator()))
            return getDriver().findElements(getAutoCompleteItemLocator()).size();
        return 0;
    }

    private By generateControlLocatorByName(String partialLocator) {
        return By.name(String.format("%s%s", "_cm.ordering.", partialLocator));
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}