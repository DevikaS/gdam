package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.*;
import com.adstream.automate.utils.Common;
import org.joda.time.DateTime;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: reznik-d
 * Date: 12.03.13
 * Time: 19:03
 */
public class StagePopUp extends PopUpWindow {
    public Edit teamNameEdit;
    public Link saveAndCloseLink;
    public Link addNewStageLink;
    public Button commonSaveButton;
    public Button advancedSaveButton;

    public StagePopUp(Page parentPage) {
        super(parentPage);
        teamNameEdit = new Edit(parentPage, generateLocator(".autocomplete [role='textbox']"));
        saveAndCloseLink = new Link(parentPage, generateLocator(".save_n_close"));
        addNewStageLink = new Link(parentPage, generateLocator(".save_n_add_new_stage"));
        commonSaveButton = new Button(parentPage, generateLocator("[name='save']"));
        advancedSaveButton = new Button(parentPage, generateLocator(".saveStage"));
        action = new Button(parentPage, generateLocator("[name='save']"));
        close = new Span(parentPage, generateLocator(".close"));
    }

    public List<String> getOwnerNames(){
        return web.findElementsToStrings(getOwnerNameLinksLocator());
    }

    public boolean isAllMustApproveSelected(){
        return web.findElement(getAllMustApproveButtonLocator()).isSelected();
    }

    public void typeName(String value) {
        web.typeClean(By.name("stageName"), value);
    }

    public void typeDescription(String value) {
        WebElement field = web.findElement(By.cssSelector("[data-role='stageDescription']"));
        field.clear();
        field.sendKeys(value);
    }

    public AdbankFileApprovalsPage selectOwner(String owner){
        new DojoSelect(parentPage, generateLocator("[role='listbox']")).selectByVisibleText(owner);
        Common.sleep(1000);
        return new AdbankFileApprovalsPage(web);
    }

    public AdbankFileApprovalsPage expandOwnersForm(){
        new Checkbox(parentPage, generateLocator("#showHideCheckBox")).select();
        Common.sleep(1000);
        return new AdbankFileApprovalsPage(web);
    }

    public void clickSingleApprovalsRadioButton(){
        web.click(getSingleApprovalButtonLocator());
    }

    public void clickAllMustApproveRadioButton(){
        web.click(getAllMustApproveButtonLocator());
    }

    public void clickSaveAndCloseLink(){
        Common.sleep(2000);
        web.click(generateLocator(".save_n_close"));

    }

    public AdbankFileApprovalsPage clickAddNewStageLink(){
        web.click(generateLocator(".save_n_add_new_stage"));
        Common.sleep(1000);
        web.waitUntilElementDisappear(getDeadlineDateLocator());
        return new AdbankFileApprovalsPage(web);
    }

    public AdbankFileApprovalsPage clickMakeStageOwnerButton(){
        new Button(parentPage, generateLocator(".makeStageOwnerBtn")).click();
        Common.sleep(1000);
        return new AdbankFileApprovalsPage(web);
    }

    public AdbankFileApprovalsPage clickSaveAndBack(){
        new Link(parentPage, generateLocator(".saveStageNBack")).click();
        Common.sleep(1000);
        return new AdbankFileApprovalsPage(web);
    }

    public void clickAdvancedSettingsButton(){
        web.click(getAdvancedSettingsButtonLocator());
    }

    public void setDeadline(DateTime deadline) {
        String deadlineDateId = getDeadlineDateElementId();
        this.setDate(deadlineDateId, deadline.toString("dd/MM/yyyy"));
        web.typeClean(getDeadlineHoursLocator(), deadline.toString("HH"));
        web.typeClean(getDeadlineMinutesLocator(), deadline.toString("mm"));
    }

    public void setReminder(DateTime reminder){
        String reminderDateId = getReminderDateElementId();
        this.setDate(reminderDateId, reminder.toString("dd/MM/yyyy"));
        web.typeClean(getReminderHoursLocator(), reminder.toString("HH"));
        web.typeClean(getReminderMinutesLocator(), reminder.toString("mm"));
    }

    public void addAnonymousApproverToStage(String email) {
        web.click(generateLocator("[id*='Autocomplete'][role='combobox']"));
        new Edit(parentPage, generateLocator(".autocomplete [role='textbox']")).typeWithInterval(email, 200);
        web.sleep(2000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", email)));
    }

    public void addApproverToStage(String name, String email) {
        web.click(generateLocator("[id*='Autocomplete'][role='combobox']"));
        new Edit(parentPage, generateLocator(".autocomplete [role='textbox']")).typeWithInterval(name, 100);
        web.sleep(2000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')][@role='option'][contains(.,'%s')][last()]", email)));
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

    public void removeUser(String name){
        web.click(getRemoveUserButtonLocator(name));
    }

    private By getSingleApprovalButtonLocator(){
        return By.cssSelector("[value='WaitAny']");
    }

    private By getAllMustApproveButtonLocator(){
        return By.cssSelector("[value='WaitAll']");
    }

    private By getDeadlineDateLocator(){
        return By.xpath("//*[@name='stageDeadline']/../input[1]");
    }

    private By getDeadlineHoursLocator(){
        return By.name("stageDeadlineHour");
    }

    private By getDeadlineMinutesLocator(){
        return By.name("stageDeadlineMin");
    }

    private By getReminderDateLocator(){
        return By.xpath("//*[@name='stageReminder']/../input[1]");
    }

    private By getReminderHoursLocator(){
        return By.name("stageReminderHour");
    }

    private By getReminderMinutesLocator(){
        return By.name("stageReminderMin");
    }

    private By getAdvancedSettingsButtonLocator(){
        return By.cssSelector(".button.advancedSettings");
    }

    private By getRemoveUserButtonLocator(String name) {
        return By.xpath(String.format("//li[contains(.,'%s')]/*[contains(@class,'as-close')]", name));
    }

    private By getOwnerNameLinksLocator(){
        return By.cssSelector("[id^='stageOwnerHolder'] a.no-decoration");
    }

    private String getDeadlineDateElementId(){
        return web.findElement(getDeadlineDateLocator()).getAttribute("id");
    }

    private String getReminderDateElementId(){
        return web.findElement(getReminderDateLocator()).getAttribute("id");
    }

    private void setDate(String id, String date){
        web.getJavascriptExecutor().executeScript(String.format("window.document.getElementById('%s').setAttribute('value', '%s');", id, date));
    }
}