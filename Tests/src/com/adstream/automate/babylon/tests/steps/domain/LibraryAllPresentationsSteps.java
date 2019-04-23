package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAllPresentationsPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 02.11.12
 * Time: 15:35
 */
public class LibraryAllPresentationsSteps extends LibraryPresentationsSteps  {

    public AdbankLibraryAllPresentationsPage getLibraryPresentationsPage() {
        return getSut().getPageCreator().getLibraryAllPresentationsPage();
    }

    public AdbankLibraryAllPresentationsPage getLibraryPresentationsPage(String presentationId) {
        return null;
    }

    @Given("I am on the all presentations page")
    @When("{I |}go to the all presentations page")
    public void openAllPresentationsPage() {
        getSut().getPageNavigator().getLibraryAllPresentationsPage();
        Common.sleep(1000);
    }

    @When("I select '$presentationName' from search popup")
    public void selectPresentationFromSearchPopup(String presentationName) {
        getSut().getPageCreator().getLibraryAllPresentationsPage()
                .selectPresentationFromSearchPopup(wrapVariableWithTestSession(presentationName));
    }

    @Given("I created new presentation '$presentationName' with description '$description' through UI")
    @When("I create new presentation '$presentationName' with description '$description' through UI")
    public void createNewReel(String presentationName, String description) {
        createNewReelThroughUI(presentationName, description);
    }

    @When("{I |}delete presentation '$presentationName'")
    public void deletePresentation(String presentationName) {
        AdbankLibraryAllPresentationsPage libraryAllPresentationsPage = getSut().getPageCreator().getLibraryAllPresentationsPage();
        libraryAllPresentationsPage.clickPresentationRow(wrapVariableWithTestSession(presentationName));
        PopUpWindow popUpWindow = libraryAllPresentationsPage.clickDeleteButton();
        popUpWindow.action.click();
    }

    @When("I open presentations list on all presentations page")
    public void openPresentationsList() {
        getSut().getPageNavigator().getLibraryAllPresentationsPage().clickAllPresentations();
        Common.sleep(1000);
    }

    // | Name |
    @When("I delete the following presentations: $presentationsTable")
    public void deletePresentations(ExamplesTable presentationsTable) {
        AdbankLibraryAllPresentationsPage libraryAllPresentationsPage = getSut().getPageCreator().getLibraryAllPresentationsPage();

        for (int i = 0; i < presentationsTable.getRowCount(); i++) {
            Map<String, String> row = BaseStep.parametrizeTabularRow(presentationsTable, i);
            libraryAllPresentationsPage.clickPresentationRow(wrapVariableWithTestSession(row.get("Name")));
            Common.sleep(100);
        }
        PopUpWindow popUpWindow = libraryAllPresentationsPage.clickDeleteButton();
        popUpWindow.action.click();
    }

    // $filter should be one of: 'from', 'to'
    @When("{I |}set '$filter' date filter as '$dateString' on all presentation page")
    public void setPresentationFilter(String filter, String dateString) {
        AdbankLibraryAllPresentationsPage libraryAllPresentationsPage = getSut().getPageCreator().getLibraryAllPresentationsPage();


        SimpleDateFormat storyDateFormatter = new SimpleDateFormat(TestsContext.getInstance().storiesDateTimeFormat);
        SimpleDateFormat testDateFormatter = new SimpleDateFormat(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        Date date;

        try {
            date = dateString.equalsIgnoreCase("currentdate") ? DateTimeUtils.getStartOfCurrentDay() : storyDateFormatter.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
            String message = String.format("Date should be in format: '%s'\n Actual Date is '%s'",
                    TestsContext.getInstance().storiesDateTimeFormat, dateString);
            throw new IllegalArgumentException(message);
        }

        dateString = testDateFormatter.format(date);

        if (filter.equalsIgnoreCase("from")) {
            libraryAllPresentationsPage.setFromDate(dateString);
        } else if (filter.equalsIgnoreCase("to")) {
            libraryAllPresentationsPage.setToDate(dateString);
        }
    }

    // $fieldName should be one of the following items: name, created, modified, duration
    @When("{I |}sorting presentations by field '$sortField' in order '$order'")
    public void sortPresentationList(String sortField, String order) {
        AdbankLibraryAllPresentationsPage libraryAllPresentationsPage = getSut().getPageCreator().getLibraryAllPresentationsPage();

        if (!libraryAllPresentationsPage.getClassOfSortField(sortField).contains(order.toLowerCase())) {
            libraryAllPresentationsPage.clickSortField(sortField);
            Common.sleep(2000);
            if (!libraryAllPresentationsPage.getClassOfSortField(sortField).contains(order.toLowerCase())) {
                libraryAllPresentationsPage.clickSortField(sortField);
                Common.sleep(2000);
            }
        }
    }

    @When("{I |}switch presentation tab to '$tabName'")
    public void switchTab(String tabName) {
        getSut().getPageCreator().getLibraryPresentationsPage().switchTab(tabName);
    }

    @Then("{I |} should see following count '$count' of presentations")
    public void checkCountOfTotalFiles(int count) {
        int actualState = getSut().getPageCreator().getLibraryAllPresentationsPage().getCountOfTotalPresenations();
        assertThat(String.format("Wrong number of presentations: %d, but should be %d", actualState, count), count == actualState);
    }

    @Then("I '$condition' see presentation list correctly filtered by default")
    public void checkThatPresentationsFilteredCorrectlyByDefault(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryAllPresentationsPage libraryAllPresentationsPage = getSut().getPageCreator().getLibraryAllPresentationsPage();
        List<String> actualPresentationList = libraryAllPresentationsPage.getActualPresentationFieldList("Name");
        String agencyId = getData().getCurrentUser().getAgency().getId();
        List<Reel> reelList = getCoreApi().getAgencyReels(agencyId, "_cm.common.name.untouched", LuceneSearchingParams.ORDER_ASCENDING);
        List<String> expectedPresentationList = new ArrayList<String>();
        if (reelList != null) for (Reel reel : reelList) expectedPresentationList.add(reel.getName());

        checkThatPresentationsListDisplayedCorrectly(shouldState, actualPresentationList, expectedPresentationList);
    }

    @Then("I '$condition' see correctly filtered by FromDate '$fromDateString' and ToDate '$toDateString' presentation list")
    public void checkThatPresentationsFilteredCorrectlyOnPresentationsPage(String condition, String fromDateString, String toDateString) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        AdbankLibraryAllPresentationsPage libraryAllPresentationsPage = getSut().getPageCreator().getLibraryAllPresentationsPage();
        List<String> actualPresentationList = libraryAllPresentationsPage.getActualPresentationFieldList("Name");

        SimpleDateFormat format = new SimpleDateFormat(TestsContext.getInstance().storiesDateTimeFormat);
        DateTime fromDate;
        DateTime toDate;

        try {
            fromDate = new DateTime(
                    fromDateString.equalsIgnoreCase("currentdate")
                            ? DateTimeUtils.getStartOfCurrentDay() : format.parse(fromDateString));
            toDate = new DateTime(
                    toDateString.equalsIgnoreCase("currentdate")
                            ? DateTimeUtils.getEndOfCurrentDay() : format.parse(toDateString));
        } catch (ParseException e) {
            e.printStackTrace();
            String message = String.format("Date should be in format: '%s'\n From date='%s', ToDate='%s'",
                    getData().getCurrentUser().getDateTimeFormatter().getDateFormat(), fromDateString, toDateString);
            throw new IllegalArgumentException(message);
        }

        List<String> expectedPresentationList = new ArrayList<String>();
        List<Reel> reelList = getCoreApi().getAgencyReels(getData().getCurrentUser().getAgency().getId(), null, null);

        if (reelList != null) {
            for (Reel reel : reelList) {
                if (reel.getCreated().compareTo(fromDate) >= 0 && reel.getCreated().compareTo(toDate) <= 0 ) {
                    expectedPresentationList.add(reel.getName());
                }
            }
        }

        Collections.sort(expectedPresentationList, String.CASE_INSENSITIVE_ORDER);

        checkThatPresentationsListDisplayedCorrectly(shouldState, actualPresentationList, expectedPresentationList);
    }

    // $fieldName should be one of the following items: name, created, modified, duration
    // $order should be 'ASC' or 'DESC'
    @Then("I '$condition' see presentations sorted by '$fieldName' field in order '$order'")
    public void checkThatReelsSortedCorrectly(String condition, String fieldName, String order) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        AdbankLibraryAllPresentationsPage libraryAllPresentationsPage = getSut().getPageCreator().getLibraryAllPresentationsPage();
        List<String> actualPresentationList = libraryAllPresentationsPage.getActualPresentationFieldList(fieldName);
        List<String> expectedPresentationList = getExpectedPresentationListOrderedByField(fieldName, order);

        checkThatPresentationsListDisplayedCorrectly(shouldState, actualPresentationList, expectedPresentationList);
    }

    private List<String> getExpectedPresentationListOrderedByField(String fieldName, String order) {
        Map<String, String> ordering = new HashMap<String, String>();
        ordering.put("asc", LuceneSearchingParams.ORDER_ASCENDING);
        ordering.put("desc", LuceneSearchingParams.ORDER_DESCENDING);

        Map<String, String> sortingField = new HashMap<String, String>();
        sortingField.put("name", "_cm.common.name.untouched");
        sortingField.put("created", "_created");
        sortingField.put("modified", "_modified");
        sortingField.put("duration", "assets.duration");
        sortingField.put("views", "counter.view.views");

        String agencyId = getData().getCurrentUser().getAgency().getId();
        fieldName = fieldName.toLowerCase();
        order = order.toLowerCase();
        List<String> resultList = new ArrayList<String>();
        SimpleDateFormat dateTimeFormatter = new SimpleDateFormat(getData().getCurrentUser().getDateTimeFormatter().getDateTimeFormat());
        SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm:ss");

        for (Reel reel : getCoreApi().getAgencyReels(agencyId, sortingField.get(fieldName), ordering.get(order)) ) {
            if (fieldName.equalsIgnoreCase("name")) {
                resultList.add(reel.getName());
            } else if (fieldName.equalsIgnoreCase("created")) {
                resultList.add(dateTimeFormatter.format(reel.getCreated().toDate()));
            } else if (fieldName.equalsIgnoreCase("modified")) {
                resultList.add(dateTimeFormatter.format(reel.getModified().toDate()));
            } else if (fieldName.equalsIgnoreCase("duration")) {
                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.AM_PM, Calendar.AM);
                cal.set(Calendar.HOUR, 0);
                cal.set(Calendar.MINUTE, 0);
                cal.set(Calendar.SECOND, reel.getAssetsDuration());
                resultList.add(timeFormatter.format(cal.getTime()));
            } else if (fieldName.equalsIgnoreCase("views")) {
                resultList.add(Integer.toString(reel.getCounterViewViews()));
            }
        }

        return resultList;
    }

    @Then("{I |}'$condition' see default logo for presentation '$presentationName' on all presentation page")
    public void checkThatPresentationLogoIsDefault(String condition, String presentationName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getLibraryPresentationsPage().isPresentationLogoDefault(wrapVariableWithTestSession(presentationName));

        assertThat(actualState, is(expectedState));
    }


    @Then("I '$condition' see presentation '$presentationName' logo is asset '$fileName' for user '$userType'")
    public void checkThatAssetIsPresentationLogo(String condition, String presentationName, String fileName, String userType) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        String actualFileId = getLibraryPresentationsPage().getPresentationLogoFileIdByName(wrapVariableWithTestSession(presentationName));
        String expectedFileId = "";

        User user = getData().getUserByType(userType);
        AssetFilter collection = getCoreApi(user).getAssetsFilterByName("My Assets", "", 0);

        List<Content> assetsList = getCoreApi(user).getAllAssetByName(collection.getId(), fileName);

        for (FilePreview filePreview : assetsList.get(0).getLastRevision().getPreview()) {
            if (filePreview.getA5Type().toLowerCase().contains("thumbnail")) {
                expectedFileId = filePreview.getFileID();
                break;
            }
        }

        assertThat(actualFileId, shouldState ? equalTo(expectedFileId) : not(equalTo(expectedFileId)));
    }
}
