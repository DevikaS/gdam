package com.adstream.automate.babylon.tests.steps.domain.ordering.section;

import com.adstream.automate.babylon.JsonObjects.ordering.Bookmark;
import com.adstream.automate.babylon.JsonObjects.ordering.BookmarkDestination;
import com.adstream.automate.babylon.JsonObjects.ordering.Destination;
import com.adstream.automate.babylon.JsonObjects.ordering.ServiceLevel;
import com.adstream.automate.babylon.sut.pages.ordering.elements.ServiceLevelType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.BroadcastDestinationForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.BookmarkStationForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.LoadBookmarkForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.AdvancedDestinationsSearchForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.MultipleSearchResultsPopUp;
import com.adstream.automate.babylon.tests.steps.domain.ordering.DraftOrderSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/*
 * Created by demidovskiy-r on 30.05.2014.
 */
public class BroadcastDestinationsSteps extends DraftOrderSteps {

    private BookmarkStationForm getBookmarkStationForm() {
        return getOrderItemPage().getBroadcastDestinationForm().getBookmarkStationForm();
    }

    private LoadBookmarkForm getLoadBookmarkForm() {
        return getOrderItemPage().getBroadcastDestinationForm().getLoadBookmarkForm();
    }

    private AdvancedDestinationsSearchForm getAdvancedDestinationsSearchForm() {
        return getOrderItemPage().getBroadcastDestinationForm().getAdvancedDestinationsSearchForm();
    }

    private Map<String, String> prepareBookmarkData(Map<String, String> row) {
        if (row.containsKey("Name")) row.put("Name", wrapVariableWithTestSession(row.get("Name")));
        if (row.containsKey("Make Bookmark Available To All BU Users")) row.put("Make Bookmark Available To All BU Users", String.valueOf(row.get("Make Bookmark Available To All BU Users").equals("should")));
        return row;
    }

    private List<BookmarkDestination> prepareBookmarkDestinations(String market, String[] destinations) {
        List<BookmarkDestination> bookmarkDestinations = new ArrayList<>(destinations.length);
        for (String destination_serviceLvl: destinations) {
            String[] parts = destination_serviceLvl.split(":");
            Destination destination = getCoreApi().getDestinationByName(market, parts[0]);
            ServiceLevel serviceLevel = getCoreApi().getDestinationServiceLevelByName(destination, parts[1]);

            BookmarkDestination bookmarkDestination = new BookmarkDestination();
            bookmarkDestination.setDestinationId(Integer.valueOf(destination.getKey()));
            bookmarkDestination.setServiceLevelId(Integer.valueOf(serviceLevel.getKey()));

            bookmarkDestinations.add(bookmarkDestination);
        }
        return bookmarkDestinations;
    }

    // check or uncheck
    /*
    | ServiceLevel |.... | ServiceLevel N |
    | Destination  |.... | Destination N  |
    where :
        ServiceLevel: Standard, Express, Standard (US), Express (US), Red Hot
        Destination: any of exist for market
     */
    @When("{I |}'$check' following destinations for Select Broadcast Destinations form on order item page: $fieldsTable")
    public void fillSelectBroadcastDestinationForm(String check, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (Map.Entry<String, String> entry: row.entrySet())
            for (String value : entry.getValue().split(";")) {
                form.check(ServiceLevelType.findByName(entry.getKey()), value, check.equals("check"));
            }
    }
    @Then("{I |}'$shouldState' see select destination translated as '$translatedtext' on order item page")
    public void isSelectBroadcastDestinationTranslated(String shouldState, String translatedtext) {
        boolean expectedCondition = shouldState.equalsIgnoreCase("should");
        assertThat("Check visibility broadcast destination: " ,getOrderItemPage().isTranslatedSelectDestination(translatedtext),equalTo(expectedCondition));
    }

    // enabled | disabled
    @Then("{I |}should see following destinations '$disabled' in Select Broadcast Destinations form on order item page: $fieldsTable")
    public void checkSelectBroadcastDestinationForm(String shouldState, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (Map.Entry<String, String> entry: row.entrySet())
            for (String value : entry.getValue().split(";"))
                assertThat("Check visibility broadcast destination: " + value , form.checkDestinationState(ServiceLevelType.findByName(entry.getKey()), value, true), is(shouldState.equals("enabled")));
    }

    @When("{I |}cancel following destinations for Select Broadcast Destinations form on order item page '$destinations'")
    public void cancelDestinationOnSelectBroadcastDestinationForm(String destinations) {
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
            for (String value : destinations.split(";")) {
                form.search(value);
                form.clickCancelButtonForDestination(value);
            }
    }

    @When("{I |}click transferring for '$destination' destinations on Select Broadcast Destinations form on order item page:$fields")
    public void clickTransferringOnSelectBroadcastDestinationForm(String destinations,ExamplesTable fields) {
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (String value : destinations.split(";"))
            form.clickTransferringButtonForDestination(value,parametrizeTableRows(fields).get(0));
    }

    @When("{I |}click at destination for '$destination' destinations on Select Broadcast Destinations form on order item page:$fields")
    public void clickAtDestinationOnSelectBroadcastDestinationForm(String destinations,ExamplesTable fields) {
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (String value : destinations.split(";"))
            form.clickAtDestinationButtonForDestination(value,parametrizeTableRows(fields).get(0));
    }

    @When("{I |}{fill|update} Search Stations field by value '$value' for Select Broadcast Destinations form on order item page")
    public void fillSearchStations(String value) {
        getOrderItemPage().getBroadcastDestinationForm().search(value);
    }

    // filter: View selected only, View all
    @When("{I |}view destinations by following filter '$filter' at Select Broadcast Destinations form on order item page")
    public void viewDestinationsByFilter(String filter) {
        getOrderItemPage().getBroadcastDestinationForm().viewDestinationsByFilter(filter);
    }

    @When("{I |}fill for destination '$destination' following additional instruction '$instruction' on Select Broadcast Destinations form")
    public void fillDestinationAdditionalInstructions(String destination, String instruction) {
        getOrderItemPage().getBroadcastDestinationForm().fillAdditionalInstruction(destination, instruction);
    }
    @When("{I |}'$AddlIns' for destination '$destination' following additional instruction '$instruction' on Select Broadcast Destinations form")
    public void fillOrSkipDestinationAdditionalInstructions(String AddlIns,String destination, String instruction) {
        if(AddlIns.equalsIgnoreCase("fill"))
        getOrderItemPage().getBroadcastDestinationForm().fillAdditionalInstruction(destination, instruction);
    }

    @Then("{I |}'$shouldState' see additional instruction for destination '$destination' on Select Broadcast Destinations form is visible")
    public void checkDestinationAdditionalInstructionsVisibility(String shouldState,String destination) {
        boolean expectedCondition = shouldState.equalsIgnoreCase("should");
        assertThat("Check additional instruction for destination: " + destination,
                getOrderItemPage().getBroadcastDestinationForm().IsAdditionalInstructionFieldVisible(destination), equalTo(expectedCondition));
    }
    // | Market | Destination Type | Syscode | Delivery Type | Syscodes | File |
    @When("{I |}fill following fields for Advanced search form on Select Broadcast Destination section: $fieldsTable")
    public void fillAdvancedSearchForm(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        AdvancedDestinationsSearchForm form = getAdvancedDestinationsSearchForm();
        if (row.containsKey("File")) {
            row.put("File", getFilePath(row.get("File")));
            form.uploadFile(row, true);
        } else
            form.fill(row);
    }

    // used only for upload wrong types of files
    @When("{I |}fill upload file field for Advanced search form on Select Broadcast Destination section: $fieldsTable")
    public void fillAdvancedSearchUploadFileField(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("File")) row.put("File", getFilePath(row.get("File")));
        getAdvancedDestinationsSearchForm().uploadFile(row, false);
    }

    @When("{I |}do searching for current filter options on Advanced Search form of Select Broadcast Destination section")
    public void doAdvancedSearching() {
        getAdvancedDestinationsSearchForm().search();
    }

    @When("{I |}do searching by multiple syscodes on Advanced Search form of Select Broadcast Destination section")
    public void doAdvancedSearchingByMultipleSysCodes() {
        getAdvancedDestinationsSearchForm().multipleSearch();
    }

    @When("{I |}do searching by uploaded syscodes on Advanced Search form of Select Broadcast Destination section")
    public void doAdvancedSearchingByUploadedSysCodes() {
        getAdvancedDestinationsSearchForm().multipleSearchByUploadedSysCodes();
    }

    // action: apply, cancel, close
    @When("{I |}'$action' Your multiple search results popup on Advanced Search form of Select Broadcast Destination section")
    public void doActionWithMultipleSearchResultsPopUp(String action) {
        MultipleSearchResultsPopUp popUp = getAdvancedDestinationsSearchForm().getMultipleSearchResultsPopUp();
        switch (action) {
            case "apply": popUp.apply(); break;
            case "cancel": popUp.cancel(); break;
            case "close": popUp.close(); break;
            default: throw new IllegalArgumentException("Unknown action: " + action);
        }
    }

    @When("{I |}reset {search result|filter options} on Advanced Search form of Select Broadcast Destination section")
    public void resetAdvancedSearchForm() {
        getAdvancedDestinationsSearchForm().reset();
    }

    // | Name | Destination | Make Bookmark Available To All BU Users |
    @Given("{I |}create bookmark{s|} for order with market '$market' with following fields: $fieldsTable")
    @When("{I |}created bookmark{s|} for order with market '$market' with following fields: $fieldsTable")
    public void createBookmarks(String market, ExamplesTable fieldsTable) {
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = prepareBookmarkData(parametrizeTabularRow(fieldsTable, i));
            Bookmark bookmark = getCoreApi().createBookmark(row.get("Name"), market, Boolean.valueOf(row.get("Make Bookmark Available To All BU Users")));
            if (row.containsKey("Destination") && !row.get("Destination").isEmpty()) {
                String[] destinations = row.get("Destination").split(";");
                List<BookmarkDestination> bookmarkDestinations = prepareBookmarkDestinations(market, destinations);
                bookmark.setValues(bookmarkDestinations);
                getCoreApi().updateBookmark(bookmark);
            }
        }
    }

    // | Name | Make Bookmark Available To All BU Users |
    @When("{I |}fill following fields for Bookmark stations form of Select Broadcast Destinations section on order item page: $fieldsTable")
    public void fillBookmarkStationForm(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareBookmarkData(parametrizeTabularRow(fieldsTable));
        getBookmarkStationForm().fill(row);
    }

    @When("{I |}delete following station{s|} '$stationNamesList' on Bookmark stations form of Select Broadcast Destinations section")
    public void deleteStations(String stationNamesList) {
        BookmarkStationForm form = getBookmarkStationForm();
        for (String stationName : stationNamesList.split(","))
            form.getStationByName(stationName).delete();
    }

    @When("{I |}bookmark selected station list on Bookmark stations form of Select Broadcast Destinations section")
    public void bookmarkStationsList() {
        getBookmarkStationForm().bookmark();
    }

    @When("{I |}click Bookmark button on Bookmark stations form of Select Broadcast Destinations section")
    public void clickBookmarkButton() {
        getBookmarkStationForm().clickBookmarkBtn();
    }

    @When("{I |}bookmark previously saved stations list on Bookmark stations form of Select Broadcast Destinations section")
    public void overwriteBookmarkStationsList() {
        getBookmarkStationForm().getSaveBookmarkPopUp().clickOkBtn();
    }

    @When("{I |}load bookmark{s|} with following name{s|} '$bookmarkNames' on Select a pre-set you wish to load form of Select Broadcast Destinations section")
    public void loadBookmarks(String bookmarkNames) {
        for (String bookmarkName : bookmarkNames.split(",")) {
            LoadBookmarkForm form = getLoadBookmarkForm();
            form.getBookmarkByName(wrapVariableWithTestSession(bookmarkName)).selectBookmark();
            form.loadBookmark();
        }
    }

    @When("{I |}delete bookmark with following name '$bookmarkName' on Select a pre-set you wish to load form of Select Broadcast Destinations section")
    public void deleteBookmark(String bookmarkName) {
        getLoadBookmarkForm().getBookmarkByName(wrapVariableWithTestSession(bookmarkName)).getDeleteBookmarkPopUp().clickOkBtn();
    }

    @Then("{I |}'$shouldState' see following destinations filter '$filter' at Select Broadcast Destinations form on order item page")
    public void checkDestinationsFilterTitle(String shouldState, String filter) {
        assertThat("Check destinations filter title: " + filter, getOrderItemPage().getBroadcastDestinationForm().getDestinationsFilterTitle(),
                                                                 shouldState.equals("should") ? equalTo(filter) : not(equalTo(filter)));
    }

    // | Standard | Express | Standard (US) | Express (US) | Red Hot |
    @Then("{I |}'$shouldState' see selected following destinations for order item on Select Broadcast Destinations form: $fieldsTable")
    public void checkBroadcastDestinationsForm(String shouldState, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (Map.Entry<String, String> entry: row.entrySet())
            for (String value : entry.getValue().split(";"))
                assertThat("Check is selected destination: " + value + " for service level: " + entry.getKey(),
                            form.isChecked(ServiceLevelType.findByName(entry.getKey()), value), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see following destinations '$destinations' in destination table on Select Broadcast Destinations form")
    public void checkVisibilityBroadcastDestinations(String shouldState, String destinations) {
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (String destinationName : destinations.split(";"))
            assertThat("Check visibility broadcast destination: " + destinationName , form.isBroadcastDestinationVisible(destinationName), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see following destinations sub groups '$subGroups' in destination table on Select Broadcast Destinations form")
    public void checkVisibilityBroadcastDestinationSubGroups(String shouldState, String subGroups) {
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (String subGroupName : subGroups.split(","))
            assertThat("Check visibility broadcast destinations sub group: " + subGroupName, form.isBroadcastSubGroupVisible(subGroupName), is(shouldState.equals("should")));
    }

    // delivery type: tape, electronic
    @Then("{I |}'$shouldState' see following destinations '$destinations' with delivery tape icon in destination table on Select Broadcast Destinations form")
    public void checkVisibilityDeliveryTapeIcon(String shouldState, String destinations) {
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (String destinationName : destinations.split(";"))
            assertThat("Check visibility delivery tape icon for destination: " + destinationName , form.isBroadcastDestinationDeliveryTapeIconVisible(destinationName), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see destination table with destinations for order item on Select Broadcast Destinations form")
    public void checkVisibilityBroadcastDestinationTable(String shouldState) {
        assertThat("Check visibility broadcast destination table: ", getOrderItemPage().getBroadcastDestinationForm().isBroadcastDestinationTableVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see expanded all markets destinations for order item on Select Broadcast Destinations form")
    public void checkExpandedMarketsDestinations(String shouldState) {
        assertThat("Check expanded market destinations: ", getOrderItemPage().getBroadcastDestinationForm().isAllDestinationsExpanded(), is(shouldState.equals("should")));
    }

    @Then("{I |}should see following additional instruction '$instruction' for destination '$destination' on Select Broadcast Destinations form")
    public void checkDestinationAdditionalInstructions(String instruction, String destination) {
        assertThat("Check additional instruction for destination: " + destination,
                    getOrderItemPage().getBroadcastDestinationForm().getAdditionalInstruction(destination), equalTo(instruction));
    }

    // state: enabled, disabled
    // Market,Destination Type,Syscode,Delivery Type,Syscodes,File
    @Then("{I |}should see '$state' following fields '$fields' for order item on Advanced search form of Select Broadcast Destinations section")
    public void checkAdvancedSearchFormFieldsState(String state, String fields) {
        AdvancedDestinationsSearchForm form = getAdvancedDestinationsSearchForm();
        for (String fieldName : fields.split(","))
            assertThat("Check Advanced Search form field: " + fieldName, form.isFieldEnabled(fieldName), is(state.equals("enabled")));
    }

    @Then("{I |}'$shouldState' see validation file type error next to upload File field on Advanced Search form of Select Broadcast Destination section")
    public void checkAdvancedSearchUploadFileValidation(String shouldState) {
        assertThat("Check visibility validation file type error: ", getAdvancedDestinationsSearchForm().isValidationFileTypeErrorVisible(),
                                                                    is(shouldState.equals("should")));
    }

    // foundState: found, not found
    @Then("{I |}should see following '$foundState' syscodes '$syscodesList' in the right order on Your multiple search results popup on Advanced Search form of Select Broadcast Destination section")
    public void checkMultipleSearchPopUpSysCodesOrder(String foundState, String syscodesList) {
        List<String> syscodes = Arrays.asList(syscodesList.split(","));
        assertThat("Check " + foundState + " syscodes order: ", getAdvancedDestinationsSearchForm().getMultipleSearchResultsPopUp().getMultipleSearchResultsList().getVisibleSysCodes(foundState.equals("found")),
                                                                equalTo(syscodes));
    }

    // foundState: found, not found
    @Then("{I |}'$shouldState' see following '$foundState' syscode{s|} '$sysCodesList' on Your multiple search results popup on Advanced Search form of Select Broadcast Destination section")
    public void checkMultipleSearchPopUpVisibilitySysCodes(String shouldState, String foundState, String sysCodesList) {
        List<String> syscodes = getAdvancedDestinationsSearchForm().getMultipleSearchResultsPopUp().getMultipleSearchResultsList().getVisibleSysCodes(foundState.equals("found"));
        for (String syscode: sysCodesList.split(","))
            assertThat("Check visibility " + foundState + " syscodes: ", syscodes, shouldState.equals("should") ? hasItem(syscode) : not(hasItem(syscode)));
    }

    // state: inactive, active
    @Then("{I |}should see '$state' Load a selection button of Select Broadcast Destinations section on order item page")
    public void checkLoadSelectionBtnState(String state) {
        assertThat("Check Load a selection button state: ", getOrderItemPage().getBroadcastDestinationForm().isLoadSelectionButtonActive(),
                                                            is(state.equals("active")));
    }

    // state: inactive, active
    @Then("{I |}should see '$state' Save this selection button of Select Broadcast Destinations section on order item page")
    public void checkSaveThisSelectionBtnState(String state) {
        assertThat("Check Save this selection button state: ", getOrderItemPage().getBroadcastDestinationForm().isSaveSelectionButtonActive(),
                                                               is(state.equals("active")));
    }

    // state: inactive, active
    @Then("{I |}should see '$state' Bookmark button on Bookmark stations form of Select Broadcast Destinations section")
    public void checkBookmarkBtnState(String state) {
        assertThat("Check Bookmark button state: ", getBookmarkStationForm().isBookmarkButtonActive(), is(state.equals("active")));
    }

    @Then("{I |}should see auto complete bookmarks count '$bookmarksCount' under Name on Bookmark stations form of Select Broadcast Destinations section")
    public void checkAutoCompleteBookmarksCount(int bookmarksCount) {
        assertThat("Check auto complete bookmarks count: ", getBookmarkStationForm().getCountAutoCompleteBookmarks(), equalTo(bookmarksCount));
    }

    // | Service Level | Destination |
    @Then("{I |}should see following data on Bookmark stations form of Select Broadcast Destinations section: $fieldsTable")
    public void checkBookmarkThisStationsFormData(ExamplesTable fieldsTable) {
        BookmarkStationForm form = getBookmarkStationForm();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            BookmarkStationForm.Station station = form.getStationByName(row.get("Destination"));
            assertThat("Service Level: ", station.getServiceLevel(), equalTo(row.get("Service Level")));
            assertThat("Destination: ", station.getDestinationName(), equalTo(row.get("Destination")));
        }
    }

    @Then("{I |}'$shouldState' see Bookmark stations form of Select Broadcast Destinations section on order item page")
    public void checkVisibilityBookmarkStationsForm(String shouldState) {
        assertThat("Check visibility Bookmark stations form: ", getOrderItemPage().getBroadcastDestinationForm().isBookmarkStationFormVisible(),
                                                                is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see following bookmark{s|} '$bookmarkNamesList' on Select a pre-set you wish to load form of Select Broadcast Destinations section")
    public void checkVisibilityBookmarks(String shouldState, String bookmarkNamesList) {
        List<String> visibleBookmarkNames = getLoadBookmarkForm().getVisibleBookmarkNames();
        for (String bookmarkName: bookmarkNamesList.split(","))
            assertThat("Check visibility bookmark: " + bookmarkName, visibleBookmarkNames, shouldState.equals("should")
                                                                     ? hasItem(wrapVariableWithTestSession(bookmarkName))
                                                                     : not(hasItem(wrapVariableWithTestSession(bookmarkName))));
    }

    @Then("{I |}'$shouldState' see Remove icon for following bookmark '$bookmarkName' on Select a pre-set you wish to load form of Select Broadcast Destinations section")
    public void checkRemoveBookmarkIconVisibility(String shouldState, String bookmarkName) {
        assertThat("Check Remove bookmark icon visibility: ", getLoadBookmarkForm().getBookmarkByName(wrapVariableWithTestSession(bookmarkName)).isRemoveBookmarkIconVisible(),
                                                              is(shouldState.equals("should")));
    }

    @When("{I |}hold following destinations for Select Broadcast Destinations form on order item page '$destinations'")
    public void holdDestinationOnSelectBroadcastDestinationForm(String destinations) {
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        for (String value : destinations.split(";"))
            getOrderItemPage().getBroadcastDestinationForm().search(value);
        Common.sleep(2000);
        form.clickHoldButtonForDestination();
    }


    @When ("{I |} '$condition' see '$button' button for  '$destination' destinations on Select Broadcast Destinations form on order item page")
    @Then ("{I |} '$condition' see '$button' button for  '$destination' destinations on Select Broadcast Destinations form on order item page")
    public void checkForAbsenceOfAtTransferringAndAtDestinationBroadcastDestinationForm(String condition,String button,String destinations) {
        Boolean check="should".equalsIgnoreCase(condition);
        BroadcastDestinationForm form = getOrderItemPage().getBroadcastDestinationForm();
        assertThat("Tranfer to destination should not be set",check.equals(form.checkForPresenceOfButton(destinations,button)));
    }

}