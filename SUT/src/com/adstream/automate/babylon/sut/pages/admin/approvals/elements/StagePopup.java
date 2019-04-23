package com.adstream.automate.babylon.sut.pages.admin.approvals.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 13.09.13
 * Time: 19:03
 */
public class StagePopup extends PopUpWindow {
    public StagePopup(Page parentPage) {
        super(parentPage);
    }

    public void selectDeadlineDate(String value) {
        new DojoCombo(parentPage, generateLocator(".unit:nth-child(1) [role='combobox']")).selectByVisibleText(value);
    }

    public void selectReminderDate(String value) {
        new DojoCombo(parentPage, generateLocator(".unit:nth-child(2) [role='combobox']")).selectByVisibleText(value);
    }

    public void typeDeadlineHours(String value) {
        web.typeClean(generateLocator("[name='stageDeadlineHour']"), value);
    }

    public void typeDeadlineMinutes(String value) {
        web.typeClean(generateLocator("[name='stageDeadlineMin']"), value);
    }

    public void typeReminderHours(String value) {
        web.typeClean(generateLocator("[name='stageReminderHour']"), value);
    }

    public void typeReminderMinutes(String value) {
        web.typeClean(generateLocator("[name='stageReminderMin']"), value);
    }

    public void typeName(String value) {
        web.typeClean(generateLocator("[name='stageName']"), value);
    }

    public void typeDescription(String value) {
        web.typeClean(generateLocator("[data-role='stageDescription']"), value);
    }

    public void selectApprover(String approver) {
        new Edit(parentPage, generateLocator(".autocomplete [role='textbox']")).type(approver);
        web.sleep(1000);
        new DojoCombo(parentPage, generateLocator(".autocomplete")).selectByVisibleText(approver);

    }

    public void selectOwner(String owner) {
        new DojoSelect(parentPage, generateLocator("[role='listbox']")).selectByVisibleText(owner);
    }

    public void addAnonymoususerToStage(String email) {
        web.click(generateLocator(".additionalusers .autocomplete [role='combobox']"));
        new Edit(parentPage, generateLocator(".additionalusers .autocomplete [role='textbox']")).typeWithInterval(email, 200);
        web.sleep(2000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", email)));
    }

    public void selectUsersToNotify(String name, String email) {
        web.click(generateLocator(".additionalusers .autocomplete [role='combobox']"));
        new Edit(parentPage, generateLocator(".additionalusers .autocomplete [role='textbox']")).typeWithInterval(name, 100);
        web.sleep(2000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", email)));
    }

    public void clearDeadline() {
        web.click(generateLocator(".clearDeadline"));
    }

    public void clearReminder() {
        web.click(generateLocator(".clearReminder"));
    }

    public void clickAdvancedSettingsButton() {
        web.click(generateLocator(".advancedSettings"));
    }

    public void clickMakeStageOwnerButton() {
        web.click(generateLocator(".makeStageOwnerBtn"));
    }

    public void clickSaveAndCloseLink() {
        web.click(generateLocator(".save_n_close"));
    }

    public boolean isSaveAndCloseLinkVisible() {
        By locator = generateLocator(".save_n_close");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public void clickSaveAndAddNewStageLink() {
        web.click(generateLocator(".save_n_add_new_stage"));
    }

    public void clickSaveAndBackLink() {
        web.click(generateLocator(".saveStageNBack"));
    }

    public void checkMultipleApprovalStage() {
        web.click(generateLocator("[value='WaitAll']"));
    }

    public void checkSingleApprovalStage() {
        web.click(generateLocator("[value='WaitAny']"));
    }

    public void expandOwnersList() {
        new Checkbox(parentPage, generateLocator("#showHideCheckBox")).select();
    }

    public void collapseOwnersList() {
        new Checkbox(parentPage, generateLocator("#showHideCheckBox")).deselect();
    }
}