package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.ServiceLevelType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.BookmarkStationForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.LoadBookmarkForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.AdvancedDestinationsSearchForm;
import com.adstream.automate.babylon.sut.pages.traffic.element.TransferringDestinationPopup;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Link;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 28.08.13
 * Time: 18:10
 */
public class BroadcastDestinationForm extends AbstractForm {
    public static final String ROOT_NODE = "#destinationsBlock";
    private Link advancedSearch;
    private Edit search;
    private Edit additionalInstruction;
    private Button viewCriteria;
    private Button loadSelection;
    private Button saveSelection;
    private By cancelDestinationSelector = By.cssSelector("[data-role='cancelDelivery']");
    private By transferringDestinationSelector = By.cssSelector("[data-role='transferring']");
    private By atDestinationSelector = By.cssSelector("[data-role='atdestination']");
    private By holdDestinationSelector = By.cssSelector("[data-role='holdDelivery']");
    private By okButtonSelector = By.cssSelector("[data-id='ok']");
    private Checkbox serviceLevel;
    private boolean isAllDestinationsExpanded = false;

    public BroadcastDestinationForm(OrderItemPage parent) {
        super(parent);
        advancedSearch = new Link(parent, generateFormElementLocator(".b-destination-search .opener"));
        search = new Edit(parent, generateFormElementLocator(".b-search input"));
        viewCriteria = new Button(parent, generateFormElementLocator("[data-role='showSelectedBtn']"));
        loadSelection = new Button(parent, generateFormElementLocator("[data-role='loadBookmark']"));
        saveSelection = new Button(parent, generateFormElementLocator("[data-role='saveBookmark']"));
        expandDestinationMarketStations();
    }

    private enum Filter {
        VIEW_SELECTED_ONLY("View selected only"),
        VIEW_ALL("View all");

        private String name;

        private Filter(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return name;
        }
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

    public AdvancedDestinationsSearchForm getAdvancedDestinationsSearchForm() {
        if (!isAdvancedDestinationsSearchFormExpanded()) {
            WebElement element = getDriver().findElement(advancedSearch.getLocator());
            getDriver().getJavascriptExecutor().executeScript("arguments[0].scrollIntoView(true);", element);
            Common.sleep(500);
            advancedSearch.click();
        }
        return new AdvancedDestinationsSearchForm((OrderItemPage)parent);
    }

    public boolean isAdvancedDestinationsSearchFormExpanded() {
        return getDriver().isElementVisible(By.cssSelector(AdvancedDestinationsSearchForm.SUB_ROOT_NODE));
    }

    public void search(String query) {
        search.type(query + Keys.RETURN);
        waitUntilLoadSpinnerDisappears();
    }

    public void viewDestinationsByFilter(String filter) {
        if (filter.equalsIgnoreCase(Filter.VIEW_SELECTED_ONLY.toString()) && !viewCriteria.getText().equals(Filter.VIEW_ALL.toString())) {
            viewCriteria.click();
            ExpectedConditions.textToBePresentInElementLocated(viewCriteria.getLocator(), Filter.VIEW_ALL.toString());
        }
        else if (filter.equalsIgnoreCase(Filter.VIEW_ALL.toString()) && !viewCriteria.getText().equals(Filter.VIEW_SELECTED_ONLY.toString())) {
            viewCriteria.click();
            ExpectedConditions.textToBePresentInElementLocated(viewCriteria.getLocator(), Filter.VIEW_SELECTED_ONLY.toString());
        }
        else
            throw new IllegalArgumentException("Unknown filter: " + filter);
    }

    public String getDestinationsFilterTitle() {
        return viewCriteria.getText();
    }

    public boolean isLoadSelectionButtonActive() {
        return !loadSelection.getAttribute("class").contains("disabled");
    }

    public boolean isSaveSelectionButtonActive() {
        return !saveSelection.getAttribute("class").contains("disabled");
    }

    public BookmarkStationForm getBookmarkStationForm() {
        if (!isBookmarkStationFormVisible())
            clickSaveSelectionButton();
        return new BookmarkStationForm((OrderItemPage)parent);
    }

    public LoadBookmarkForm getLoadBookmarkForm() {
        if (!isLoadBookmarkFormVisible())
            clickLoadSelectionButton();
        return new LoadBookmarkForm((OrderItemPage)parent);
    }

    public boolean isBookmarkStationFormVisible() {
        return getDriver().isElementVisible(By.cssSelector(BookmarkStationForm.ROOT_NODE));
    }

    public boolean isLoadBookmarkFormVisible() {
        return getDriver().isElementVisible(By.cssSelector(LoadBookmarkForm.ROOT_NODE));
    }

    public void check(ServiceLevelType serviceLevelType, String destinationName, boolean isCheck) {
        switchByServiceLevel(serviceLevelType, destinationName);
        serviceLevel.setSelected(isCheck);
    }

    public boolean checkDestinationState(ServiceLevelType serviceLevelType, String destinationName, boolean isCheck) {
        switchByServiceLevel(serviceLevelType, destinationName);
        return serviceLevel.isEnabled();
    }

    public boolean isChecked(ServiceLevelType serviceLevelType, String destinationName) {
        switchByServiceLevel(serviceLevelType, destinationName);
        return serviceLevel.isSelected();
    }

    public void fillAdditionalInstruction(String destination, String instruction) {
        initAdditionalInstructionFieldByDestination(destination);
        additionalInstruction.type(instruction);
    }

    public boolean IsAdditionalInstructionFieldVisible(String destination) {
        initAdditionalInstructionFieldByDestination(destination);
       return additionalInstruction.isEnabled();
    }
    public String getAdditionalInstruction(String destination) {
        initAdditionalInstructionFieldByDestination(destination);
        return additionalInstruction.getValue();
    }

    public List<String> getBroadcastDestinations() {
        List<String> broadcastDestinations = new ArrayList<String>();
        if (!getDriver().isElementPresent(getDestinationContentLocator())) return broadcastDestinations;
        List<WebElement> destinations = getDriver().findElements(getDestinationContentLocator());
        for (WebElement destination : destinations)
            broadcastDestinations.add(destination.getText());
        return broadcastDestinations;
    }

    public List<String> getSubGroups() {
        List<String> subGroups = new ArrayList<String>();
        if (!getDriver().isElementPresent(getSubGroupsContentLocator())) return subGroups;
        List<WebElement> groups = getDriver().findElements(getSubGroupsContentLocator());
        for (WebElement group : groups)
            subGroups.add(group.getText());
        return subGroups;
    }

    public boolean isBroadcastDestinationVisible(String destinationName) {
        return getDriver().isElementVisible(generateContentLocatorByDestinationName(destinationName));
    }

    public boolean isBroadcastSubGroupVisible(String subGroupName) {
        return getDriver().isElementVisible(generateContentLocatorByDestinationName(subGroupName));
    }

    public boolean isBroadcastDestinationDeliveryTapeIconVisible(String destinationName) {
        return getDriver().isElementVisible(generateTapeIconLocatorByDestinationName(destinationName));
    }

    public boolean isBroadcastDestinationTableVisible() {
        return getDriver().isElementVisible(getDestinationTableRowLocator());
    }

    public boolean isAllDestinationsExpanded() {
        return isAllDestinationsExpanded;
    }

    private void clickSaveSelectionButton() {
        saveSelection.click();
    }

    private void clickLoadSelectionButton() {
        loadSelection.click();
    }

    private void expandDestinationMarketStations() {
        if (getDriver().isElementVisible(getDestinationMarketsToggleLocator())) {
            List<WebElement> toggles = getDriver().findElements(getDestinationMarketsToggleLocator());
            for (WebElement toggle : toggles) {
                isAllDestinationsExpanded = toggle.getText().equals("-");
                if (!toggle.getText().equals("-") && !toggle.getText().isEmpty()) {
                    toggle.click();
                    waitUntilLoadSpinnerDisappears();
                    getDriver().sleep(1000);
                }
            }
        }
    }

    private void switchByServiceLevel(ServiceLevelType serviceLevelType, String destinationName) {
        switch (serviceLevelType) {
            case STANDARD:
                serviceLevel = new Checkbox(parent, getStandardCheckBoxByDestinationName(destinationName));
                break;
            case EXPRESS:
                serviceLevel = new Checkbox(parent, getExpressCheckBoxByDestinationName(destinationName));
                break;
            case STANDARD_US:
                serviceLevel = new Checkbox(parent, getStandardUSCheckBoxByDestinationName(destinationName));
                break;
            case EXPRESS_US:
                serviceLevel = new Checkbox(parent, getExpressUSCheckBoxByDestinationName(destinationName));
                break;
            case RED_HOT:
                serviceLevel = new Checkbox(parent, getRedHotCheckBoxByDestinationName(destinationName));
                break;
            default:
                throw new IllegalArgumentException("Unknown service level type: " + serviceLevelType.toString());
        }
    }

    private void initAdditionalInstructionFieldByDestination(String destination) {
        if (additionalInstruction == null) {
            additionalInstruction = new Edit(parent, getAdditionalInstructionsFieldLocator(destination));
        }
    }

    private By getFormLocator() {
        return generateFormElementLocator(".b-destinations-list");
    }

    private By getDestinationMarketsToggleLocator() {
        return generateFormElementLocator("[data-dojo-type='ordering.form.destinations.toggleGroup']");
    }

    private By getDestinationTableRowLocator() {
        return generateFormElementLocator("[data-dojo-type='ordering.form.destinations.Table'] .row");
    }

    private By getDestinationContentLocator() {
        return generateServiceLevelContentLocator(".destination");
    }

    private By getSubGroupsContentLocator() {
        return generateServiceLevelContentLocator(".group");
    }

    private By getStandardCheckBoxByDestinationName(String name) {
        return generateControlLocatorByDestinationName(name, ServiceLevelType.STANDARD.getKey());
    }

    private By getExpressCheckBoxByDestinationName(String name) {
        return generateControlLocatorByDestinationName(name, ServiceLevelType.EXPRESS.getKey());
    }

    private By getStandardUSCheckBoxByDestinationName(String name) {
        return generateControlLocatorByDestinationName(name, ServiceLevelType.STANDARD_US.getKey());
    }

    private By getExpressUSCheckBoxByDestinationName(String name) {
        return generateControlLocatorByDestinationName(name, ServiceLevelType.EXPRESS_US.getKey());
    }

    private By getRedHotCheckBoxByDestinationName(String name) {
        return generateControlLocatorByDestinationName(name, ServiceLevelType.RED_HOT.getKey());
    }

    private By generateServiceLevelContentLocator(String partialLocator) {
        return By.cssSelector(partialLocator + " .service-level[class$='data-column'] .cell-content");
    }

    private By generateContentLocatorByDestinationName(String name) {
        return name.contains("-")
               ? By.xpath("//*[@data-role='row']//*[contains(@class,'data-column')]//*[contains(.,\"" + name.split("-")[1] + "\")]")
               : By.xpath("//*[@data-role='row']//*[contains(@class,'data-column')]//*[normalize-space(text())=\"" + name + "\"]");
    }

    private By generateColumnLocatorByDestinationName(String name) {
        return name.contains("-")
                ? By.xpath("//*[@data-role='row']//*[contains(@class,'data-column')]//*[contains(.,\"" + name.split("-")[1] + "\")]")
                : By.xpath("//*[@data-role='row']//*[contains(@class,'data-column')]//*[normalize-space(text())=\"" + name + "\"]/../..");
    }

    public void clickCancelButtonForDestination(String name){
        WebElement column =  getDriver().findElement(generateColumnLocatorByDestinationName(name));
        column.findElement(cancelDestinationSelector).click();
        getDriver().findElement(okButtonSelector).click();
    }

    public void clickTransferringButtonForDestination(String name, Map<String,String> data){
        WebElement column =  getDriver().findElement(generateColumnLocatorByDestinationName(name));
        column.findElement(transferringDestinationSelector).click();
        TransferringDestinationPopup transferringDestinationPopup= new TransferringDestinationPopup("Transferring",this.parent);
        transferringDestinationPopup.fillTransferringDestinationForm(data);
        transferringDestinationPopup.clickSaveButton();
      }

    public void clickAtDestinationButtonForDestination(String name, Map<String,String> data){
        WebElement column =  getDriver().findElement(generateColumnLocatorByDestinationName(name));
        column.findElement(atDestinationSelector).click();
        TransferringDestinationPopup transferringDestinationPopup= new TransferringDestinationPopup("At Destination",this.parent);
        transferringDestinationPopup.fillTransferringDestinationForm(data);
        Common.sleep(2000);
        transferringDestinationPopup.clickSaveButton();
        Common.sleep(6000);
    }

    public boolean checkForPresenceOfButton(String name,String button){
        WebElement column =  getDriver().findElement(generateColumnLocatorByDestinationName(name));
        boolean elemPresent=false;
        try {
            switch (button) {
                case "At Destination":
                    elemPresent = column.findElement(atDestinationSelector).isDisplayed();
                    break;
                case "Transferring" :
                    elemPresent = column.findElement(transferringDestinationSelector).isDisplayed();
                    break;
                case "hold" :
                    elemPresent = column.findElement(holdDestinationSelector).isDisplayed();
                    break;
                case "cancel":
                    elemPresent = column.findElement(cancelDestinationSelector).isDisplayed();
                    break;
                default:
                    elemPresent=false;
            }
       } catch (WebDriverException e) {
        elemPresent = false;
        }

       return elemPresent;
    }

    private By generateControlLocatorByDestinationName(String name, String value) {
        return name.contains("-")
               ? By.xpath("//*[@data-role='row']//*[contains(@class,'data-column')]//*[contains(.,\"" + name.split("-")[1] + "\")]/ancestor::*[@data-role='row']//*[@value='"+ value + "']")
               : By.xpath("//*[@data-role='row']//*[contains(@class,'data-column')]//*[@title=\"" + name + "\"]/ancestor::*[@data-role='row']//*[@value='"+ value + "']");
    }

    private By generateTapeIconLocatorByDestinationName(String name) {
        return name.contains("-")
                ? By.xpath("//*[@data-role='row']//*[contains(@class,'data-column')]//*[contains(.,\"" + name.split("-")[1] + "\")]/ancestor::*[@data-role='row']//*[contains(@class,'spriteicon i32x32_cassette')]")
                : By.xpath("//*[@data-role='row']//*[contains(@class,'data-column')]//*[@title=\"" + name + "\"]/ancestor::*[@data-role='row']//*[contains(@class,'spriteicon i32x32_cassette')]");
    }

    private By getAdditionalInstructionsFieldLocator(String availableField) {
        return By.xpath(String.format("//div[@id='destinationsBlock']//div[@title='%s']/ancestor::*[@data-role='row']//*[@data-role='comment']", availableField));
    }

  /*  public void clickHoldButtonForDestination(String name){
        WebElement column =  getDriver().findElement(generateColumnLocatorByDestinationName(name));
        column.findElement(holdDestinationSelector).click();
    } */

    public void clickHoldButtonForDestination(){
        getDriver().findElement(holdDestinationSelector).click();
    }


}