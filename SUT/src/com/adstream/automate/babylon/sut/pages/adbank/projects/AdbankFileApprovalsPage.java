package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: reznik-d
 * Date: 12.03.13
 * Time: 15:53
 */
public class AdbankFileApprovalsPage extends AdbankFileViewPage {

    public AdbankFileApprovalsPage(ExtendedWebDriver web) {
        super(web);
    }

    private By getSumbitApprovalLinkLocator() {
        return By.cssSelector("[data-dojo-type='adbank.approvals.add_stage_button']");
    }

    private By getApplyTemplateLinkLocator() {
        return By.cssSelector("[data-dojo-type='adbank.approvals.apply_template_button']");
    }

    private By getSaveAsTemplateButton() {
        return By.cssSelector("[id*='save_template_button']");
    }

    private By getAddStageButtonLocator() {
        web.waitUntil(ExpectedConditions.elementToBeClickable(By.cssSelector("css=button[class^='add-stage']")));

        return By.cssSelector(".add-stage.button");
    }

    private String getStageContainer(String stage) {
        return String.format("//*[contains(@class,'border') and contains(@class,'mbl')][.//*[normalize-space()='%s']]", stage);
    }

    private String getUserContainer(String number, String userName) {
        return getStageContainer(number) + "//a[text()='" + userName + "']/ancestor::tr";
    }

    private By getUserEditCommentButtonLocator(String number, String userName) {
        return By.xpath(getUserContainer(number, userName) + "//*[@data-dojo-type='adbank.approvals.edit_stage_button']");
    }

    private By getStageTypeLocator(String number) {
        return By.xpath(getStageContainer(number) + "//td[@class='type']");
    }

    private By getApprovalStatusDropDownListLocator() {
        return By.cssSelector("#selectedCloseStatus");
    }

    private By getApprovalCurrentStatusLocator() {
        return By.cssSelector(".statusoverride>.current");
    }

    private By getCloseButtonLocator() {
        return By.cssSelector("[name='closeApprovalButton']:not([data-dojo-props*='Cancelled'])");
    }

    private By getCancelButtonLocator() {
        return By.cssSelector("[data-dojo-props*='Cancelled']");
    }

    public StagePopUp clickSubmitForApprovalLink() {
        web.click(getSumbitApprovalLinkLocator());
        return new StagePopUp(this);
    }

    public SelectApprovalTemplatePopup clickApplyTemplateLink() {
        web.click(getApplyTemplateLinkLocator());
        return new SelectApprovalTemplatePopup(this);
    }

    public SaveAsApprovalTemplatePopup clickSaveAsTemplateButton() {
        web.click(getSaveAsTemplateButton());
        return new SaveAsApprovalTemplatePopup(this);
    }

    public List<String> getAllApprovalsStages() {
        By locator = By.cssSelector(".snowblue-bg span.h4");
        if (web.isElementPresent(locator)) {
            return web.findElementsToStrings(locator);
        } else {
            return new ArrayList<>();
        }
    }

    public String getBreadcrubs() {
        return web.findElement(By.className("file-breadcamb")).getText().replaceAll("^..", "");
    }

    public void clickByFollowingBreadcrumbLink(String link) {
        web.click(By.linkText(link));
    }

    public ApprovalCommentPopUp approveOrRejectStageByName(String stageName, String action) {
        String stageXpath = String.format("//*[contains(@class,'shadow')][.//*[contains(@class,'h4') and normalize-space()='%s']]", stageName);

        if (action.equalsIgnoreCase("approve")) {
            web.click(By.xpath(String.format("%s//*[contains(@id,'approve_stage')]", stageXpath)));
        } else if (action.equalsIgnoreCase("reject")) {
            web.click(By.xpath(String.format("%s//*[contains(@id,'reject_stage')]", stageXpath)));
        } else {
            throw new IllegalArgumentException("Unknown action: " + action);
        }

        return new ApprovalCommentPopUp(this);
    }

    private By getEditLinkLocator(String stage) {
        return By.xpath(getStageContainer(stage) + "//*[@data-dojo-type='adbank.approvals.edit_stage_button']");
    }

    private By getApproveLinkLocator(String stage) {
        return By.xpath(getStageContainer(stage) + "//*[@data-dojo-type='adbank.approvals.approve_stage_button']");
    }

    private By getRejectLinkLocator(String stage) {
        return By.xpath(getStageContainer(stage) + "//*[@data-dojo-type='adbank.approvals.reject_stage_button']");
    }

    private By getSendReminderLinkLocator(String stage) {
        return By.xpath(getStageContainer(stage) + "//*[contains(@id,'send_reminder')]");
    }

    private By getRemoveStageButtonLocator(String stage) {
        return By.xpath(getStageContainer(stage) + "//*[@data-dojo-type='adbank.approvals.remove_stage_button']");
    }

    private By getStageNameLocator(String number) {
        return By.xpath(getStageContainer(number) + "//*[contains(@class,'h4')]");
    }

    private By getStageDescriptionLocator(String number) {
        return By.xpath(getStageContainer(number) + "//textarea[@class='ui-input']");
    }

    private By getUserCommentLocator(String number, String userName) {
        return By.xpath(getUserContainer(number, userName) + "//*[@class='cell textblock']");
    }

    private By getSendUpdateButtonLocator(String number) {
        return By.xpath(getStageContainer(number) + "//*[@value='Send Updates']");
    }

    private By getLockedLocator(String number) {
        return By.xpath(getStageContainer(number) + "//h3//*[normalize-space(@title)='Locked']");
    }

    private By getNotificationLocator() {
        return By.cssSelector(".approvals");
    }

    private By getPopUpNotificationLocator() {
        return By.cssSelector(".ui-dialog-content");
    }

    private By getStageDeadlineDateTimeLocator(String number) {
        return By.xpath(getStageContainer(number) + "//*[@class='h3 mtm']");
    }

    private By getStageReminderDateTimeLocator(String number) {
        return By.xpath(getStageContainer(number) + "//span[@class='prm']");
    }

    private By getApproversQuantityLocator(String number) {
        return By.xpath(getStageContainer(number) + "//span[contains(.,'Approvers')]");
    }

    public String getUserComment(String number, String userName) {
        return web.findElement(getUserCommentLocator(number, userName)).getText().trim();
    }

    public StagePopUp clickAddApprovalStage() {
        if(isSubmitApprovalLinkDisplayed()) {
            clickSubmitForApprovalLink();
        } else {

            web.click(getAddStageButtonLocator());
        }
        return new StagePopUp(this);
    }

    public boolean isUserPresentInTheStage(String number, String userName) {
        By userLocator = By.xpath(getUserContainer(number, userName));
        return web.isElementPresent(userLocator) && web.isElementVisible(userLocator);
    }

    public boolean isSendUpdatesButtonPresent(String number) {
        Common.sleep(1000);
        return web.isElementPresent(getSendUpdateButtonLocator(number)) && web.isElementVisible(getSendUpdateButtonLocator(number));
    }

    public StagePopUp clickEditStage(String stage) {
        web.click(getEditLinkLocator(stage));
        return new StagePopUp(this);
    }

    public PopUpWindow clickApproveStage(String stage) {
        web.click(getApproveLinkLocator(stage));
        return new PopUpWindow(this);
    }

    public PopUpWindow clickRejectStage(String stage) {
        web.click(getRejectLinkLocator(stage));
        return new PopUpWindow(this);
    }

    public void sendReminder(String stage) {
        web.click(getSendReminderLinkLocator(stage));
        if (web.isAlertPresent()) web.switchTo().alert().accept();
    }

    public boolean isEditStageButtonPresent(String number) {
        return web.isElementPresent(getEditLinkLocator(number)) && web.isElementVisible(getEditLinkLocator(number));
    }

    public RemoveStageConfirmationPopUp clickRemoveStage(String stage) {
        web.click(getRemoveStageButtonLocator(stage));
        return new RemoveStageConfirmationPopUp(this);
    }

    public void clickStartApproval() {
        web.click(By.cssSelector("[name='save']"));
        web.sleep(2000);
    }

    public void StartApprovals() {
        //web.click(By.cssSelector("[name='save']"));
        web.click(By.xpath("//*[contains(@data-dojo-type,'adbank.approvals.start')]"));
        web.sleep(2000);
    }

    public boolean isStartApprovalButtonPresent() {
        return web.isElementPresent(By.cssSelector("[name='save']"));
    }

    public ApprovalCommentPopUp clickEditComment(String number, String userName) {
        web.click(getUserEditCommentButtonLocator(number, userName));
        return new ApprovalCommentPopUp(this);
    }

    public List<Map<String,String>> getApproversInfo(String stageName) {
        List<Map<String,String>> approversInfo = new ArrayList<>();
        String stageLocator = String.format("//*[contains(@class,'border') and contains(@class,'mbl')][.//*[normalize-space()='%s']]", stageName);
        List<String> names = web.findElementsToStrings(By.xpath(String.format("%s//*[contains(@class,'table-data')]//a", stageLocator)));
        List<String> comments = web.findElementsToStrings(By.xpath(String.format("%s//*[contains(@id,'comment')]/*[contains(@class,'graybox')]", stageLocator)));
        List<String> statuses = web.findElementsToStrings(By.xpath(String.format("%s//*[contains(@class,'table-data')]//*[contains(@class,'size1of4')]//*[contains(@class,'valign-middle')]/span[2]", stageLocator)));

        for (int i = 0; i < names.size(); i++) {
            Map<String,String> row = new HashMap<>();
            row.put("UserName", names.get(i));
            row.put("Comment", comments.get(i));
            row.put("Status", statuses.get(i));
            approversInfo.add(row);
        }

        return approversInfo;
    }

    public List<Map<String,String>> getStagesInfo() {
        List<Map<String,String>> stagesInfo = new ArrayList<>();
        List<String> names = web.findElementsToStrings(By.cssSelector(".approvals .snowblue-bg .h4.no-bold"));
        List<String> statuses = web.findElementsToStrings(By.cssSelector(".approvals .snowblue-bg .h4.no-bold + .mls"), "class");
        List<String> descriptions = web.findElementsToStrings(By.cssSelector(".approvals textarea"));
        List<String> deadlines = web.findElementsToStrings(By.cssSelector(".approvals .h3"));
        List<String> reminders = web.findElementsToStrings(By.cssSelector(".approvals .bold+.prm"));

        for (int i = 0; i < names.size(); i++) {
            Map<String,String> row = new HashMap<>();
            row.put("Name", names.get(i));
            row.put("Status", statuses.get(i).replaceAll(".*icon-status-(\\w+).*", "$1").toLowerCase());
            row.put("Description", descriptions.get(i));
            row.put("Deadline", deadlines.get(i));
            row.put("Reminder", reminders.get(i));
            stagesInfo.add(row);
        }

        return stagesInfo;
    }

    public void expandApproversSection(String stage) {
        By locator = By.xpath(String.format("//*[contains(@class,'border') and contains(@class,'mbl')][.//*[contains(@class,'itemsList') and contains(@class,'none')]][.//*[normalize-space()='%s']]//*[@onclick]", stage));
        if (web.isElementPresent(locator)) web.click(locator);
    }

    public StagePopUp clickAdvancedSettingsOnStage(String stage) {
        web.click(By.xpath(String.format("//*[contains(@class,'border') and contains(@class,'mbl')][.//*[normalize-space()='%s']]//*[contains(@id,'advanced_settings')]", stage)));
        return new StagePopUp(this);
    }

    public boolean isApprovalsButtonsVisible(String stageName) {
        String stageXpath = String.format("//*[contains(@class,'shadow')][.//*[contains(@class,'h4') and normalize-space()='%s']]", stageName);
        return web.isElementVisible(By.xpath(String.format("%s//ancestor::node()[8]//*[contains(@id,'adbank_approvals')]/span[text()='Approve']", stageXpath)))
                && web.isElementVisible(By.xpath(String.format("%s//*[contains(@id,'adbank_approvals')]/span[text()='Reject']", stageXpath)));
    }

    public boolean isSubmitApprovalLinkDisplayed() {
        return web.isElementVisible(getSumbitApprovalLinkLocator());
    }

    public ApprovalCommentPopUp clickApproveStageAsApprover() {
        web.click(By.cssSelector(".approvebutton"));
        return new ApprovalCommentPopUp(this);
    }

    public ApprovalCommentPopUp clickRejectStageAsApprover() {
        web.click(By.cssSelector(".rejectbutton"));
        return new ApprovalCommentPopUp(this);
    }

    public boolean isStageLocked(String number) {
        return web.isElementPresent(getLockedLocator(number)) && web.isElementVisible(getLockedLocator(number));
    }

    public ApprovalCommentPopUp clickApproveRejectStageAsApprover(String action) {
        if(action.equalsIgnoreCase("approve")) {
            this.clickApproveStageAsApprover();
        }
        else if(action.equalsIgnoreCase("reject")) {
            this.clickRejectStageAsApprover();
        }
        else{
            throw new IllegalArgumentException("Wrong action '" + action + "', please use 'approve' or 'reject' ");
        }
        return new ApprovalCommentPopUp(this);
    }

    public String getStageColor(String number) {

        Object color;
        String stageColour, stage;

        stage = Integer.toString(Integer.parseInt(number) - 1);
        /* Convert convert stage number and save as the string */
        color = getDriver().getJavascriptExecutor().executeScript("return window.document.defaultView.getComputedStyle(" +
                "window.document.getElementsByClassName('stage')[" + stage +
                "].getElementsByTagName('h3')[0], null" +
                ").getPropertyValue('background-color')");

        stageColour = color.toString();
        return getColorFromRgb(stageColour);
    }

    private String getColorFromRgb(String stageColour) {

        switch (stageColour) {
            case "rgb(121, 122, 122)":
                stageColour = "grey";
                break;
            case "rgb(103, 178, 68)":
                stageColour = "green";
                break;
            case "rgb(239, 48, 36)":
                stageColour = "red";
                break;
        }
        return stageColour;
    }

    public String getColorOfRejectedStage() {

        Object color;
        String stageColour;

        /* Convert convert stage number and save as the string */
        color = getDriver().getJavascriptExecutor().executeScript("return window.document.defaultView.getComputedStyle(" +
                "window.document.getElementsByClassName('rejected')[0].getElementsByTagName('h3')[0], null" +
                ").getPropertyValue('background-color')");

        stageColour = color.toString();
        return getColorFromRgb(stageColour);
    }

    public String getNotificationText() {
        return web.findElement(getNotificationLocator()).getText();
    }

    public String getPopUpNotificationText() {
        return web.findElement(getPopUpNotificationLocator()).getText();
    }

    public boolean isCloseButtonEnabled() {
        return web.findElement(getCloseButtonLocator()).isEnabled();
    }

    public void selectAutoCloseCheckbox() {
        new Checkbox(this, getAutoCloseCheckboxLocator()).select();
    }

    public void deselectAutoCloseCheckbox() {
        new Checkbox(this, getAutoCloseCheckboxLocator()).deselect();
    }

    public boolean isAutoCloseCheckboxSelected() {
        return web.findElement(getAutoCloseCheckboxLocator()).isSelected();
    }

    public boolean isAutoCloseCheckboxPresent() {
        return web.isElementPresent(getAutoCloseCheckboxLocator());
    }

    public ConfirmApprovalActionPopUp clickCloseButton() {
        web.click(getCloseButtonLocator());
        return new ConfirmApprovalActionPopUp(this);
    }

    public ConfirmApprovalActionPopUp clickCancelButton() {
        web.click(getCancelButtonLocator());
        return new ConfirmApprovalActionPopUp(this);
    }

    public String getCurrentApprovalStatus() {
        return web.findElement(getApprovalCurrentStatusLocator()).getText();
    }

    public boolean isApprovalStatusDropDownListPresent() {
        return web.isElementPresent(getApprovalStatusDropDownListLocator()) && web.isElementVisible(getApprovalStatusDropDownListLocator());
    }

    public String getStageName(String number) {
        return web.findElement(getStageNameLocator(number)).getText();
    }

    public String getStageDescription(String number) {
        return web.findElement(getStageDescriptionLocator(number)).getText();
    }

    public String getStageType(String number) {
        return web.findElement(getStageTypeLocator(number)).getText().trim();
    }

    public String getStageDeadlineDateTime(String number) {
        return web.findElement(getStageDeadlineDateTimeLocator(number)).getText();
    }

    public String getStageReminderDateTime(String number) {
        return web.findElement(getStageReminderDateTimeLocator(number)).getText();
    }

    public ApprovalCommentPopUp clickApproveButton() {
        web.findElement(getApproveButtonLocator()).click();
        return new ApprovalCommentPopUp(this);
    }

    public ApprovalCommentPopUp clickRejectButton() {
        web.findElement(getRejectButtonLocator()).click();
        return new ApprovalCommentPopUp(this);
    }

    public boolean isApproveButtonPresent() {
        return web.isElementVisible(getApproveButtonLocator());
    }

    public boolean isRejectButtonPresent() {
        return web.isElementVisible(getRejectButtonLocator());
    }

    public boolean isCloseButtonPresent() {
        return web.isElementVisible(getCloseButtonLocator());
    }

    private By getApproveButtonLocator() {
        return By.xpath("//*[contains(@id,'adbank_approvals')]/span[text()='Approve']");
    }

    private By getRejectButtonLocator() {
        return By.xpath("//*[contains(@id,'adbank_reject')]/span[text()='Reject']");
    }
    private By getAutoCloseCheckboxLocator() {
        return By.cssSelector("[data-dojo-type='adbank.approvals.changeSettings']");
    }

    public String getApproversQuantity(String number) {
        return web.findElement(getApproversQuantityLocator(number)).getText().split(" ")[0];
    }

    public boolean isStagePopUpDisplayed() {
        return  web.isElementVisible(By.xpath("//*[contains(@class,'popupWindow')][not(contains(@style,'display: none'))][*[contains(@title,'stage')]]"));
    }

    public boolean isNewApprovalPopUpDisplayed() {
        return web.isElementVisible(By.className("files-add-usage-rights"));
    }
}