package com.adstream.automate.babylon.sut.pages.admin.approvals;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.RemovingPopup;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.StagePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 25.09.13
 * Time: 12:07
 */
public class ApprovalTemplatePage extends BaseAdminPage<ApprovalTemplatePage> {
    public static final String INITIAL_STAGE_NAME = "Stage 1";

    public ApprovalTemplatePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector(".approvals"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector(".approvals")));
    }

    public List<Map<String,String>> getTemplateInformation() {
        List<Map<String,String>> templateInformation = new ArrayList<Map<String, String>>();
        List<String> fieldNames = web.findElementsToStrings(By.cssSelector(".projectViewForm .caption span"));
        List<String> fieldValues = web.findElementsToStrings(By.cssSelector(".projectViewForm .value"));

        for (int i = 0; i < fieldNames.size(); i++) {
            Map<String,String> field = new HashMap<String, String>();
            field.put("FieldName", fieldNames.get(i));
            field.put("FieldValue", fieldValues.get(i));
            templateInformation.add(field);
        }

        return templateInformation;
    }

    public List<String> getStagesNamesList() {
        return web.findElementsToStrings(By.cssSelector(".approvals .no-bold:not(.blue):not(:empty)"));
    }

    public List<String> getStagesDeadlinesList() {
        return web.findElementsToStrings(By.cssSelector(".approvals .h3.mtm"));
    }

    public List<String> getStagesRemindersList() {
        return web.findElementsToStrings(By.cssSelector(".approvals .bold+.prm"));
    }

    public List<String> getStagesDescriptionsList() {
        return web.findElementsToStrings(By.cssSelector(".approvals textarea[readonly]"));
    }

    public List<Map<String,String>> getStagesList() {
        List<Map<String,String>> stagesList = new ArrayList<Map<String, String>>();
        List<String> names = getStagesNamesList();
        List<String> deadlines = getStagesDeadlinesList();
        List<String> reminders = getStagesRemindersList();
        List<String> descriptions = getStagesDescriptionsList();

        for (int i = 0; i < names.size(); i++) {
            Map<String,String> stage = new HashMap<String,String>();
            stage.put("Name", names.get(i));
            stage.put("Deadline", deadlines.get(i));
            stage.put("Reminder", reminders.get(i));
            stage.put("Description", descriptions.get(i));
            stagesList.add(stage);
        }

        return stagesList;
    }

    public List<String> getStageApproversNamesList(String stageName) {
        return web.findElementsToStrings(getStageApproversNamesLocator(stageName));
    }

    public List<String> getStageApproversCommentsList(String stageName) {
        return web.findElementsToStrings(getStageApproversCommentsLocator(stageName));
    }

    public List<String> getStageApproversResponsesList(String stageName) {
        return web.findElementsToStrings(getStageApproversResponsesLocator(stageName));
    }

    public List<Map<String,String>> getStageApproversList(String stageName) {
        expandStageApproversList(stageName);
        List<Map<String,String>> stageApproversList = new ArrayList<Map<String, String>>();
        List<String> names = getStageApproversNamesList(stageName);
        List<String> comments = getStageApproversCommentsList(stageName);
        List<String> responses = getStageApproversResponsesList(stageName);

        for (int i = 0; i < names.size(); i++) {
            Map<String,String> stageApprover = new HashMap<String,String>();
            stageApprover.put("Name", names.get(i));
            stageApprover.put("Comment", comments.get(i));
            stageApprover.put("Response", responses.get(i));
            stageApproversList.add(stageApprover);
        }

        return stageApproversList;
    }

    public boolean isStageApproversListPresent(String stageName) {
        return !web.findElement(getStageApproversListLocator(stageName)).getAttribute("class").contains("none");
    }

    public boolean isStagePresent(String stageName) {
        return web.isElementPresent(getStageLocator(stageName)) && web.isElementVisible(getStageLocator(stageName));
    }

    public boolean isInitialStagePresent() {
        return isStagePresent(INITIAL_STAGE_NAME);
    }

    public boolean isRemoveStageLinkPresent(String stageName) {
        By locator = getRemoveStageLinkLocator(stageName);
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public RemovingPopup clickDeleteButton() {
        web.click(getDeleteButtonLocator());
        return new RemovingPopup(this);
    }

    public StagePopup clickNewStageButton() {
        web.click(getNewStageButtonLocator());
        return new StagePopup(this);
    }

    public StagePopup clickEditStageLink(String stageName) {
        web.click(getEditStageLinkLocator(stageName));
        return new StagePopup(this);
    }

    public StagePopup clickEditInitialStageLink() {
        return clickEditStageLink(INITIAL_STAGE_NAME);
    }

    public RemovingPopup clickRemoveStageLink(String stageName) {
        web.click(getRemoveStageLinkLocator(stageName));
        return new RemovingPopup(this);
    }

    public void clickAdvancedSettingsStageLink(String stageName) {
        web.click(getAdvancedSettingsStageLinkLocator(stageName));
    }

    public void clickExpandApproversStageLink(String stageName) {
        web.click(getExpandApproversStageLinkLocator(stageName));
    }

    public void expandStageApproversList(String stageName) {
        if (!isStageApproversListPresent(stageName)) {
            web.click(getExpandApproversStageLinkLocator(stageName));
        }
    }

    public void collapseStageApproversList(String stageName) {
        if (isStageApproversListPresent(stageName)) {
            web.click(getExpandApproversStageLinkLocator(stageName));
        }
    }

    public void clickEditInitialStage() {
        clickEditStageLink(INITIAL_STAGE_NAME);
    }

    private By getDeleteButtonLocator() {
        return By.cssSelector("[id*='remove_template_button']");
    }

    private By getNewStageButtonLocator() {
        return By.cssSelector("[widgetid*='add_stage_button']");
    }

    private By getEditStageLinkLocator(String stageName) {
        return By.xpath(getStageXpath(stageName) + "//*[contains(@widgetid,'edit_stage_button')]");
    }

    private By getRemoveStageLinkLocator(String stageName) {
        return By.xpath(getStageXpath(stageName) + "//*[contains(@widgetid,'remove_stage_button')]");
    }

    private By getAdvancedSettingsStageLinkLocator(String stageName) {
        return By.xpath(getStageXpath(stageName) + "//*[contains(@widgetid,'advanced_settings_button')]");
    }

    private By getExpandApproversStageLinkLocator(String stageName) {
        return By.xpath(getStageXpath(stageName) + "//*[contains(@class,'people')]/following-sibling::*[contains(@class,'h4')]");
    }

    private By getStageApproversListLocator(String stageName) {
        return By.xpath(getStageXpath(stageName) + "//*[contains(@class,'itemsList')]");
    }

    private By getStageApproversNamesLocator(String stageName) {
        return By.xpath(getStageXpath(stageName) + "//a");
    }

    private By getStageApproversCommentsLocator(String stageName) {
        return By.xpath(getStageXpath(stageName) + "//*[contains(@class,'size3of6')]");
    }

    private By getStageApproversResponsesLocator(String stageName) {
        return By.xpath(getStageXpath(stageName) + "//*[@class='itemsList']//*[contains(@class,'status')]/following-sibling::*");
    }

    private By getStageLocator(String stageName) {
        return By.xpath(getStageXpath(stageName));
    }

    private String getStageXpath(String stageName) {
        return String.format("//*[contains(@class,'border ')][.//*[normalize-space()='%s']]", stageName);
    }
}