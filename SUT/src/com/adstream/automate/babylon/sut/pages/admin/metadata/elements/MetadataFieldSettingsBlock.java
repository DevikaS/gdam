package com.adstream.automate.babylon.sut.pages.admin.metadata.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import com.google.common.base.Function;
import org.openqa.selenium.*;

import javax.annotation.Nullable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 30.05.13
 * Time: 9:56
 */
public class MetadataFieldSettingsBlock {
    protected ExtendedWebDriver web;
    protected Page parentPage;

    public MetadataFieldSettingsBlock(Page parentPage) {
        this.parentPage = parentPage;
        web = parentPage.getDriver();
    }

    public List<String> getAllAddedChoices() {
        By locator = By.cssSelector("[data-role='hierarchyOption'] [disabled]");
        if (web.isElementVisible(locator)) {
            return web.findElementsToStrings(locator, "value");
        } else {
            return new ArrayList<>();
        }
    }

    public List<String> getHierarchyNavigationBarItems() {
        return web.findElementsToStrings(By.cssSelector(".catStructure .fieldItem [title]"), "title");
    }

    public String getLinesNumberFieldErrorMessage() {
        web.click(By.cssSelector("[data-role='new-field-rows']"));
        By locator = By.cssSelector("[role='alert']");

        return web.isElementPresent(locator) ? web.findElement(locator).getText().trim() : "";
    }

    public boolean isInheritButtonPresent(String fieldName) {
        String locator = String.format("//div[@data-role='hierarchyOption' and descendant::input[@value='%s']]//div[@data-role='icon-inherit']", fieldName);
        return web.isElementPresent(By.xpath(locator)) && web.isElementVisible(By.xpath(locator));
    }

    public void typeDescription(String text) {
        web.typeClean(By.cssSelector("[data-role='new-field-description']"), text);
    }

    public void typeNumberOfLines(String text) {
        web.typeClean(By.cssSelector("[data-role='new-field-rows']"), text);
    }

    public void typeChoiceFieldName(String text) {
        web.typeClean(By.xpath("(//input[@data-role='input'])[last()]"), text);
    }

    public void typeFieldChoiceCustomCharacters(String fieldChoice, String customCharacters) {
        String customCharactersFieldLocator = String.format("//input[@value='%s']/../following-sibling::*/input[@data-role='customCharacters']", fieldChoice);
        new Edit(parentPage, By.xpath(customCharactersFieldLocator)).type(customCharacters);
    }

    public void selectFieldSize(String value) {
        if (value != null) {
            new DojoSelect(parentPage, By.cssSelector("[data-role='new-field-width']")).selectByVisibleText(value);
        }
    }

    public void selectDateFieldFormat(String value) {
        if (value != null) {
            new DojoSelect(parentPage, By.cssSelector("[data-role='new-field-dateType']")).selectByVisibleText(value);
        }
    }

    public void checkPhoneFieldFormat(String value) {
        web.click(By.cssSelector(String.format("[name='phoneFormat'][value='%s']", value)));
    }

    public void checkMakeItCompulsory() {
        setMakeItCompulsoryCheckboxState(true);
    }

    public void tickMarkAsAdvertiser() {
        setMarkAsAdvertiser(true);
    }

    public void unTickMarkAsAdvertiser() {
        setMarkAsAdvertiser(false);
    }

    public void tickMarkAsProduct() {
        setMarkAsProduct(true);
    }

    public void unTickMarkAsProduct() {
        setMarkAsProduct(false);
    }

    public void tickMarkAsCampaign() {
        setMarkAsCampaign(true);
    }

    public void unTickMarkAsCampaign() {
        setMarkAsCampaign(false);
    }

    public void tickDisplayThisFieldOnYourTableView() {
        setDisplayThisFieldOnYourTableView(true);
    }

    public void unTickDisplayThisFieldOnYourTableView() {
        setDisplayThisFieldOnYourTableView(false);
    }

    public void tickDisplayThisFieldOnYourDetailedView() {
        setDisplayThisFieldOnYourDetailedView(true);
    }

    public void unTickDisplayThisFieldOnYourDetailedView() {
        setDisplayThisFieldOnYourDetailedView(false);
    }

    public void unTickFieldIsEditable() {
        setFieldIsEditable(false);
    }

    public void tickMarkAsHouseNumber() {
        setMarkAsHouseNumber(true);
    }

    public void unTickMarksAsHouseNumber() {
        setMarkAsHouseNumber(false);
    }

    public void tickMakeThisFieldAvailableInDelivery() {
        setMakeThisFieldAvailableInDelivery(true);
    }

    public void unTickMakeThisFieldAvailableInDelivery() {
        setMakeThisFieldAvailableInDelivery(false);
    }

    public void tickMakeItCommonForOrder() {
        setMakeItCommonForOrder(true);
    }

    public void unTickMakeItCommonForOrder() {
        setMakeItCommonForOrder(false);
    }

    public void tickMakeThisFieldAvailableForBilling() {
        setMakeThisFieldAvailableForBilling(true);
    }

    public void unTickMakeThisFieldAvailableForBilling() {
        setMakeThisFieldAvailableForBilling(false);
    }

    public void setMakeItCompulsoryCheckboxState(boolean isSelected) {
        new Checkbox(parentPage, By.cssSelector("[data-role='new-field-required']")).setSelected(isSelected);
    }

    public void uncheckMakeItCompulsory() {
        setMakeItCompulsoryCheckboxState(false);
    }

    public void checkHideCheckbox() {
        setHideCheckboxState(true);
    }

    public void uncheckHideCheckbox() {
        setHideCheckboxState(false);
    }

    public void setHideCheckboxState(boolean isSelected) {
        new Checkbox(parentPage, By.cssSelector("[data-role='new-field-hidden']")).setSelected(isSelected);
    }

    public void checkAddOnTheFly() {
        new Checkbox(parentPage, By.cssSelector("[data-role='dictionary-allowModifying']")).select();
    }

    public void uncheckAddOnTheFly() {
        new Checkbox(parentPage, By.cssSelector("[data-role='dictionary-allowModifying']")).deselect();
    }

    public void checkMultipleChoices() {
        new Checkbox(parentPage, By.cssSelector("[data-role='dictionary-allowMultiSelect']")).select();
    }

    public void uncheckMultipleChoices() {
        new Checkbox(parentPage, By.cssSelector("[data-role='dictionary-allowMultiSelect']")).deselect();
    }

    public void chooseDefaultDictionaryValue(String value) {
        new Checkbox(parentPage, By.cssSelector(String.format("[data-role='hierarchyOption'] [value='%s']", value))).select();
    }

    public void selectDefaultValue(String value) {
        new Checkbox(parentPage, By.cssSelector(String.format(".defaultValueRow [value='%s']", value))).select();
    }

    public void addHierarchyChoice(String optionName) {
        List<String> list = new ArrayList<>();
        list.add(optionName);
        addHierarchyChoices(list);
    }

    public void addHierarchyChoices(List<String> optionNames) {
        if (optionNames == null || optionNames.isEmpty()) {
            return;
        }
        for (String optionName : optionNames) {
            clickAddChoiceButton();
            typeChoiceFieldName(optionName);
        }
        web.getJavascriptExecutor().executeScript("window.scrollBy(0, 500)");
        clickSaveButton();
       // web.waitUntilElementAppear(
         //       By.xpath("(//div[contains(@class, 'formCatalogueRow')])[last()]/span[contains(@class, 'icon-accept-green-lib')]"));
    }

    public void removeHierarchyOptionByName(String optionName) {
        web.clickThroughJavascript(By.cssSelector(String.format("[title='%s']~.edit-tip [data-role='deleteIcon']", optionName)));
        web.sleep(1000);
    }

    public void clickLastAddHierarchyOption() {
        web.clickThroughJavascript(By.cssSelector(".catStructure :last-child [title]~.edit-tip [data-role='addIcon']"));
    }

    public void clickHierarchyNavigationBarItemByName(String name) {
        web.click(By.cssSelector(String.format(".catStructure .fieldItem [title='%s']", name)));
        Common.sleep(1000);
    }

    public void clickInheritButtonByName(String fieldName) {
        String locator = String.format("//div[@data-role='hierarchyOption' and descendant::input[@value='%s']]//div[@data-role='icon-inherit']", fieldName);
        Common.sleep(1000);
        web.click(By.xpath(locator));
        Common.sleep(1000);
    }

    public void clickDestroyButtonByName(String fieldName) {
        String locator = String.format("//div[@data-role='hierarchyOption' and descendant::input[@value='%s']]//div[@data-role='icon-destroy']", fieldName);
        web.click(By.xpath(locator));
    }

    public void clickAddChoiceButton() {
        web.click(By.cssSelector("[data-role='btn-add']"));
        Common.sleep(100);
    }

    public void clickSaveButton() {
        final WebElement saveButton = web.findElement(By.cssSelector("[data-role='saveField']"));
        web.scrollToElement(saveButton);
        Common.sleep(2000);
        if(!saveButton.isEnabled())
            throw new NoSuchElementException("Save button is not enabled!");
        else saveButton.click();
//       web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        Common.sleep(6000);
        web.waitUntil(new Function<WebDriver, Boolean>() {
            @Override
            public Boolean apply(@Nullable WebDriver webDriver) {
                try {
                    return web.findElements(By.className("error")).size() > 0 || !saveButton.isDisplayed();
                } catch (StaleElementReferenceException e) {
                    return true;
                }
            }
        }, "Wait until validation error will happen, save button will disappear or become stale.");
    }

    public void clickAvailableMetadataTab() {
        web.click(By.cssSelector("[data-role='listTab']"));
        web.sleep(1000);
    }

    public boolean isDescriptionFieldRed() {
        return web.isElementPresent(By.cssSelector("[data-role='new-field-description'].error"));
    }

    public void createRadioButtons(String text) {
        clickAddChoiceButton();
        Common.sleep(2000);
        web.findElement(By.xpath("(//input[@data-role='input'])[last()]")).sendKeys(text);
    }

    public boolean isLinesNumberFieldRed() {
        return web.isElementPresent(By.className("dijitValidationTextBoxError"));
    }

    public boolean isHideCheckboxSelected() {
        return new Checkbox(parentPage, By.cssSelector("[data-role='new-field-hidden']")).isSelected();
    }

    public boolean isCompulsoryCheckboxSelected() {
        return new Checkbox(parentPage, By.cssSelector("[data-role='new-field-required']")).isSelected();
    }

    public boolean isMakeItReadOnlyCheckboxSelected() {
        return new Checkbox(parentPage, getMakeItReadOnlyCheckBoxLocator()).isSelected();
    }

    public boolean isMarkAsAdvertiserCheckboxSelected() {
        return new Checkbox(parentPage, getMarkAsAdvertiserCheckBoxLocator()).isSelected();
    }

    public boolean isMarkAsProductCheckboxSelected() {
        return new Checkbox(parentPage, getMarkAsProductCheckBoxLocator()).isSelected();
    }

    public boolean isMakeThisFieldAvailableInDeliveryCheckBoxSelected() {
        return new Checkbox(parentPage, getMakeFieldAvailableInDeliveryLocator()).isSelected();
    }

    public boolean isMakeItCommonForOrderCheckBoxSelected() {
        return new Checkbox(parentPage, getMakeItCommonForOrderLocator()).isSelected();
    }

    public boolean isDisplayThisFieldOnYourTableViewSelected() {
        return new Checkbox(parentPage, getDisplayThisFieldOnYourTableViewLocator()).isSelected();
    }

    public boolean isDisplayThisFieldOnYourDetailedViewSelected() {
        return new Checkbox(parentPage, getDisplayThisFieldOnYourDetailedViewLocator()).isSelected();
    }

    public boolean isMarkAsHouseNumberSelected() {
        return new Checkbox(parentPage, getMarkedAsHouseNumberLocator()).isSelected();
    }

    public boolean isAddOnTheFlyCheckboxSelected() {
        return new Checkbox(parentPage, By.cssSelector("[data-role='dictionary-allowModifying']")).isSelected();
    }

    public boolean isMultipleChoicesCheckboxSelected() {
        return new Checkbox(parentPage, By.cssSelector("[data-role='dictionary-allowMultiSelect']")).isSelected();
    }

    public boolean isCompulsoryCheckboxDisabled() {
        return web.isElementPresent(By.cssSelector(".gray [data-role='new-field-required']"));
    }

    public boolean isHierarchyOptionPresent(String optionName) {
        return web.isElementPresent(By.cssSelector(String.format("[data-role='hierarchyOption'] [disabled][value='%s']", optionName)));
    }

    public void tickVisibleOnOrderSummary() {
        setVisibleOnOrderSummary(true);
    }

    public void tickFieldIsEditable() {
        setFieldIsEditable(true);
    }

    private void setMarkAsAdvertiser(boolean isSelected) {
        new Checkbox(parentPage, getMarkAsAdvertiserCheckBoxLocator()).setSelected(isSelected);
    }

    private void setMarkAsProduct(boolean isSelected) {
        new Checkbox(parentPage, getMarkAsProductCheckBoxLocator()).setSelected(isSelected);
    }

    private void setMarkAsCampaign(boolean isSelected) {
        new Checkbox(parentPage, getMarkAsCampaignCheckBoxLocator()).setSelected(isSelected);
    }

    private void setDisplayThisFieldOnYourTableView(boolean isSelected) {
        new Checkbox(parentPage, getDisplayThisFieldOnYourTableViewLocator()).setSelected(isSelected);
    }

    private void setDisplayThisFieldOnYourDetailedView(boolean isSelected) {
        new Checkbox(parentPage, getDisplayThisFieldOnYourDetailedViewLocator()).setSelected(isSelected);
    }

    private void setMarkAsHouseNumber(boolean isSelected) {
        new Checkbox(parentPage, getMarkedAsHouseNumberLocator()).setSelected(isSelected);
    }

    private void setMakeThisFieldAvailableInDelivery(boolean isSelected) {
        new Checkbox(parentPage, getMakeFieldAvailableInDeliveryLocator()).setSelected(isSelected);
    }

    private void setMakeItCommonForOrder(boolean isSelected) {
        new Checkbox(parentPage, getMakeItCommonForOrderLocator()).setSelected(isSelected);
    }

    private void setMakeThisFieldAvailableForBilling(boolean isSelected) {
        new Checkbox(parentPage, getMakeThisFieldAvailableForBillingLocator()).setSelected(isSelected);
    }

    private By getMarkAsAdvertiserCheckBoxLocator() {
        return generateMarkAsCheckboxByValue("advertiser");
    }

    private By getMarkAsProductCheckBoxLocator() {
        return generateMarkAsCheckboxByValue("product");
    }

    private By getMarkAsCampaignCheckBoxLocator() {
        return generateMarkAsCheckboxByValue("campaign");
    }

    private By getMakeItReadOnlyCheckBoxLocator() {
        return generateSettingCheckBoxByDataRole("new-field-readOnlyInTraffic");
    }

    private By getMakeFieldAvailableInDeliveryLocator() {
        return generateSettingCheckBoxByDataRole("availableForSchema");
    }

    private By getDisplayThisFieldOnYourTableViewLocator() {
        return generateSettingCheckBoxByDataRole("displayOnTableView");
    }

    private By getDisplayThisFieldOnYourDetailedViewLocator() {
        return generateSettingCheckBoxByDataRole("displayOnDetailedView");
    }

    private By getMarkedAsHouseNumberLocator() {
        return generateSettingCheckBoxByDataRole("markedAsHouseNumber");
    }

    private By getMakeItCommonForOrderLocator() {
        return generateSettingCheckBoxByDataRole("commonForOrder");
    }

    private By getMakeThisFieldAvailableForBillingLocator() {
        return generateSettingCheckBoxByDataRole("availableForBilling");
    }

    private By generateMarkAsCheckboxByValue(String partialLocator) {
        return By.cssSelector("[value='" + partialLocator + "']");
    }

    private By generateSettingCheckBoxByDataRole(String partialLocator) {
        return By.cssSelector("[data-role='" + partialLocator + "']");
    }

    private void setVisibleOnOrderSummary(boolean isSelected) {
        new Checkbox(parentPage, getVisibleOnOrderSummary()).setSelected(isSelected);
    }

    private By getVisibleOnOrderSummary() {
        return generateSettingCheckBoxByDataRole("new-field-visible-on-order-summary");
    }

    private void setFieldIsEditable(boolean isSelected) {
        new Checkbox(parentPage, getFieldIsEditable()).setSelected(isSelected);
    }

    private By getFieldIsEditable() {
        return generateSettingCheckBoxByDataRole("fieldIsEditable");
    }
}