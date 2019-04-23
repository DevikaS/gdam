package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFilesAndFoldersSearchResultPage;
import com.adstream.automate.babylon.sut.pages.library.LibrarySearchResultPage;
import com.adstream.automate.utils.Common;
import org.hamcrest.Matcher;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import java.util.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 18.10.12
 * Time: 9:40

 */
public class GlobalSearchSteps extends BabylonSteps {

    @When("{I |}search by text '$text'")
    public void searchText(String text) {
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        baseAdBankPage.searchObject(text);
    }

    @When("{I |}search by text with test session '$text'")
    public void searchTextWithTestSession(String text) {
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        baseAdBankPage.searchObject(wrapVariableWithTestSession(text));
    }

    @When("{I |}search by email '$email'")
    public void searchEmail(String email) {
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        email = wrapUserEmailWithTestSession(email);
        baseAdBankPage.searchObject(email);

    }

    @When("{I |}click show all link for global user search")
    public void clickShowAll() {
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        baseAdBankPage.clickShowAllResults();
    }

    @When ("{I |}'$condition' match all words for strict search")
    public void clickMatchAllWords(String condition) {
        boolean action = condition.equalsIgnoreCase("check");
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        baseAdBankPage.clickMatchAllWords(action);
    }

    @When("{I |}click show all link for global user search for object '$objectName'")
    public void clickShowAll(String objectName) {
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        int number = baseAdBankPage.getHeadersOverShowAllResultsLink().indexOf(objectName) + 1;
        baseAdBankPage.clickShowAllResults(number);
    }

    @Then("check the total '$type' count remains same during scrolling")
    public void checkCountDuringScrolling(String type){
        if (type.equals("Files & Folders")) {
            AdbankFilesAndFoldersSearchResultPage filesAndFoldersSearchResultPage = getSut().getPageCreator().getFilesAndFoldersSearchResultPage();
            String count = filesAndFoldersSearchResultPage.getTotalCount(type);
            //Scrolling to position 200 and checking whether the count remains same
            filesAndFoldersSearchResultPage.scrollDownToFooter(200);
            String[] scrollCount = (filesAndFoldersSearchResultPage.getItemCount()).split("/");
            assertThat("File & Folders count", 200, equalTo(Integer.parseInt(scrollCount[0].trim())));
            assertThat("File & Folders count", Integer.parseInt(count), equalTo(Integer.parseInt(scrollCount[1].trim())));

        }
    }

    @Then("check strict search '$type' total count is less than the Global search count")
    public void checkCountSearches(String type) {
        if (type.equals("Files & Folders")) {
            AdbankFilesAndFoldersSearchResultPage filesAndFoldersSearchResultPage = getSut().getPageCreator().getFilesAndFoldersSearchResultPage();
            String strictSearchCount = filesAndFoldersSearchResultPage.getTotalCount(type);
            clickMatchAllWords("unCheck");
            getSut().getWebDriver().navigate().refresh();
            Common.sleep(3000);
            String globalSearchCount = filesAndFoldersSearchResultPage.getTotalCount(type);
            assertThat("File & Folders count", Integer.parseInt(strictSearchCount), lessThan(Integer.parseInt(globalSearchCount)));
        }
    }

    @When("{I |}click file '$fileName' link on search results popup")
    public void clickFileByNameOnSearchResults(String fileName) {
        getSut().getPageCreator().getBaseAdBankPage().clickFileLinkOnSearchResultsDropdown(fileName);
    }

    @Then("opening '$objectType' link '$objectName' in a new tab should be '$loadingTime' seconds")
    public void clickShowAlliinNewtab(String objectType,String objectName, String loadingTime) {
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        Long actualLoadingTime = baseAdBankPage.openLinkInNewTab(objectType,objectName);
        Long expectedLoadingTime = Long.parseLong(loadingTime);
        assertThat(actualLoadingTime, is(lessThanOrEqualTo(expectedLoadingTime)));
    }

    @Then("file '$fileName' loading time should be '$time' seconds after clicking file on search results popup")
    public void checkFileLoadingTimeFromGrlobalSearc(String fileName, String loadingTime){
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        Long actualLoadingTime = baseAdBankPage.getFileLoadingTime(fileName);
        Long expectedLoadingTime = Long.parseLong(loadingTime);
        assertThat(actualLoadingTime, is(lessThanOrEqualTo(expectedLoadingTime)));
    }


    @Then("{I |}'$condition' see show all results link on quick search menu")
    public void checkShowAllResultsLinkVisibility(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        assertThat(baseAdBankPage.isShowAllResultsLinkVisible(), equalTo(shouldState));
    }

    @Then("{I |}'$condition' see search object '$objectName'")
    public void checkSearchObject(String condition, String objectName) {
        boolean shouldState = condition.equalsIgnoreCase("Should");
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        List<String> listOfLinks = baseAdBankPage.getDropdownListOfLinks();
        Matcher matcher = shouldState ? hasItem(objectName) : not(hasItem(objectName));
        assertThat(listOfLinks, matcher);
    }

    @Then("{I |}should see next count '$count' found items")
    public void checkSearchObject(int count) {
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        int listOfLinks = baseAdBankPage.getSearchResultNumItems().size();
        assertThat("Wrong number of result: " + listOfLinks, listOfLinks == count);
    }

    @Then("{I |}'$condition' see search object '$objectName' with type '$objectType' after wrap according to search '$text' with '$textType' type")
    public void checkSearchObjectWithWrap(String condition, String objectName, String objectType, String text, String textType) {
        //ToDo if count of objects more than 3, it's need to check only text.
        boolean shouldState = condition.equalsIgnoreCase("Should");
        BaseAdBankPage baseAdBankPage = getSut().getPageCreator().getBaseAdBankPage();
        List<String> listOfLinks = baseAdBankPage.getDropdownListOfLinks();
        List<String> listOfHeaders = baseAdBankPage.getHeadersOverShowAllResultsLink();
        int length = text.length();

        if (shouldState) {
            for (String objName : objectName.split(",")) {
                if (listOfHeaders.size() == 0) {Assert.fail("Search returned zero results"); }
                if (objectType.equalsIgnoreCase("Files & Folders") || objectType.equalsIgnoreCase("Assets") || objectType.equalsIgnoreCase("Shared Collections")) {
                    if (listOfHeaders.size() == 1) {
                        for (String item : listOfLinks)
                            if (!item.equalsIgnoreCase("Show all results"))
                                assertThat(item.toLowerCase(), containsString(text.toLowerCase()));
                    } else if (listOfHeaders.size() > 1) {
                        int groupNum = listOfHeaders.lastIndexOf(objectType);
                        int counter = 0;
                        for (String item : listOfLinks) {
                            if (item.equalsIgnoreCase("Show all results")) {
                                counter++;
                            } else if (counter > groupNum) {
                                assertThat(item.toLowerCase(), containsString(text.toLowerCase()));
                                break;
                            }
                        }
                    } else {
                        Assert.fail("Undescribe situation when by assets or file/folder name exist others objects");
                    }
                } else {
                    String compare = checkSearchResult(objectType, wrapVariableWithTestSession(objName), textType);

                    if (listOfHeaders.size() > 1) { // ToDo more than 1 founded object
                        int groupNum = listOfHeaders.lastIndexOf(objectType);
                        int counter = 0;

                        for (String item : listOfLinks) {
                            if (item.equalsIgnoreCase("Show all results")) {
                                counter++;
                            } else if (counter > groupNum) {
                                assertThat(compare.substring(0, length - 1), equalToIgnoringCase(item.substring(0, length-1)));
                            }
                        }
                    } else {
                        for (String item : listOfLinks)
                            if (!item.equalsIgnoreCase("Show all results"))
                                assertThat(compare.substring(0, length - 1), equalToIgnoringCase(item.substring(0, length-1)));
                    }

                }
            }
        }
    }

    // Type can be one of: Projects, Assets, Files & Folders
    @Then("I '$condition' see items '$items' of type '$type' in global search result")
    public void checkGlobalSearchItems(String condition, String items, String type) {
        BaseAdBankPage page = getSut().getPageCreator().getBaseAdBankPage();
        boolean should = condition.equalsIgnoreCase("should");
        List<String> actualElements = page.getGlobalSearchResultItems(type);
        for (String item : items.split(",")) {
            assertThat(actualElements.contains(item), is(should));
        }
    }

    @Then("I should see items '$items' of type '$type' with proper order in global search result")
    public void checkOrderOfGlobalSearchItems(String items, String type) {
        BaseAdBankPage page = getSut().getPageCreator().getBaseAdBankPage();
        List<String> actualElements = page.getGlobalSearchResultItems(type);
        String [] properOrder = items.split(",");
        Common.sleep(4000);
        assertThat(actualElements, contains(properOrder));
    }


    @Then("{I |}should see address book page with next user{s|} '$users'")
    public void checkSearchInAddressBook(String users) {
        List<String> actualUsers = getSut().getPageCreator().getAdbankAddressbookPage().getAllUsersLink();

        for (String expectedUser: users.split(",")) assertThat(actualUsers, hasItem(expectedUser));
    }

    @Then("{I |}should see following items in the drop-down control on library search page: $itemsValues")
    public void checkItemsInTheDDLibrarySearchPage(ExamplesTable itemsValues) {
        LibrarySearchResultPage librarySearchResultPage = getSut().getPageCreator().getLibrarySearchResultPage();
        List<String> itemsPerPage = librarySearchResultPage.getAvailableMetadataFilters();
        assertThat("", itemsPerPage.size(), equalTo(itemsValues.getRowCount()));
        for (int i = 0 ; i < itemsValues.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(itemsValues, i);
            assertThat("", row.get("Name"), isIn(itemsPerPage));
        }
    }

    @Then("{I |}should see none selected collection on library search page")
    public void checkThatNoneSelectedCollection() {
        LibrarySearchResultPage librarySearchResultPage = getSut().getPageCreator().getLibrarySearchResultPage();
        assertThat("", librarySearchResultPage.isAnyCollectionSelected(), equalTo(false));
    }

    @Then("{I |}'$condition' see Item Per Page with selected value '$expectedValue' by default on library search page")
    public void checkItemPerPageSelectedValueOnProjectSearchResult(String condition, String expectedValue) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualValue = getSut().getPageCreator().getLibrarySearchResultPage().getItemsPerPageSelectedValues();

        assertThat(actualValue, shouldState ? equalTo(expectedValue) : not(equalTo(expectedValue)));
    }

    @Then("{I |}'$condition' see Item Per Page with available values '$values' on library search page")
    public void checkItemPerPageAvailableValuesOnProjectSearchResult(String condition, String values) {
        List<String> actualValues = getSut().getPageCreator().getLibrarySearchResultPage().getItemsPerPageValues();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> expectedValues = new ArrayList<String>();
        Collections.addAll(expectedValues, values.split(","));

        assertThat(actualValues, shouldState ? equalTo(expectedValues) : not(equalTo(expectedValues)));
    }

    @Then("{I |}'$condition' see the following files '$files' on global search result")
    public void checkForSuccessionOnGlobalSearch(String condition, String files) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualFiles = getSut().getPageCreator().getBaseAdBankPage().getListResultAssetFromGlobalSearch();

        for (String expectedFile : files.split(","))
            assertThat(actualFiles, shouldState ? hasItem(expectedFile) : not(hasItem(expectedFile)));
    }

    protected String checkSearchResult(String objectType, String text, String textType) {
        if (objectType.equalsIgnoreCase("Project")) {
            Project project = getCoreApi().getProjectByName(text);
            if (textType.equalsIgnoreCase("Name")) {
                return text;
            } else {
                return project.getName();
            }
        } else if (objectType.equalsIgnoreCase("Folder")) {
            List<Content> folder = getCoreApi().searchContentByFolderName(text, new LuceneSearchingParams());
            return folder.get(0).getName();
        } else if (objectType.equalsIgnoreCase("Template") || objectType.equalsIgnoreCase("Templates")) {
            Project template = getCoreApi().getTemplateByName(text);
            if (textType.equalsIgnoreCase("Name")) {
                return text;
            } else {
                return template.getName();
            }
        } else if (objectType.equalsIgnoreCase("File")) {
            return text;
        }
        return null;
    }

}
