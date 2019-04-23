package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.AssetFilter;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentByFileSize;
import com.adstream.automate.babylon.JsonObjects.comparator.ComparatorContentBy_created;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.*;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionDetailsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionFilterPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryAssetsPage;
import com.adstream.automate.page.Control;
import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by devika on 27/04/2017.
 */
public class NewLibraryAddAssetToProjectSteps extends LibraryHelperSteps {

    @Given("{I |}clicked Add to Project button on '$collection' library pageNEWLIB")
    @When("{I |}click Add to Project button on '$collection' library pageNEWLIB")
    public AddToProjectPopUp openAddToProjectPopUpNewLib(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collection));
        return libraryPage.openPopup().clickAddToProject();
    }

    @Given("{I |}add assets '$assetName' to project '$projectName' and folder '$folderName' from collection '$collectionName' pageNEWLIB")
    @When("{I |}add assets '$assetName' to project '$projectName' and folder '$folderName' from collection '$collection' pageNEWLIB")
    public void AddAssetToProject(String assetName, String projectName, String folderName, String collectionName) {

        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collectionName), getCategoryId(wrapCollectionName(collectionName)));
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
        AddToProjectPopUp addToProjectPopup = openAddToProjectPopUpNewLib(collectionName);
        addToProjectPopup.addToProjectFolder(wrapVariableWithTestSession(projectName), wrapVariableWithTestSession(folderName));
        addToProjectPopup.clickAdd();
    }

    @When("{I |}cancel Add to Project pop up from collection '$collectionName'NEWLIB")
    public void cancelPopupNewlib(String collectionName )
    {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        AddToProjectPopUp addToProjectPopup = openAddToProjectPopUpNewLib(collectionName);
        addToProjectPopup.cancelPopup();
    }

    @Given("{I |}added following asset '$assetName' of collection '$collectionName' to template '$projectName' folder '$path'NEWLIB")
    @When("{I |}add following asset '$assetName' of collection '$collectionName' to template '$projectName' folder '$path'NEWLIB")
    public void moveAssetToTemplatesFolderNewLib(String assetName, String collectionName, String projectName, String path) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        Content folder = createFolderTemplateOverCoreApi(path, projectName);
        getCoreApi().addAssetToProjectFolder(asset.getId(), folder.getId());
        long deadline = System.currentTimeMillis() + 10000;
        while (getCoreApi().getFileByName(folder.getId(), asset.getName()) == null) {
            if (System.currentTimeMillis() > deadline) {
                break;
            }
            Common.sleep(1000);
        }
    }


    @Given("{I |}added following asset '$assetName' of collection '$collectionName' to project '$projectName' folder '$path'NEWLIB")
    @When("{I |}add following asset '$assetName' of collection '$collectionName' to project '$projectName' folder '$path'NEWLIB")
    public void moveAssetToProjectsFolderNewLib(String assetName, String collectionName, String projectName, String path) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        Content folder = createFolderOverCoreApi(path, projectName);
        getCoreApi().addAssetToProjectFolder(asset.getId(), folder.getId());
        long deadline = System.currentTimeMillis() + 10000;
        while (getCoreApi().getFileByName(folder.getId(), asset.getName()) == null) {
            if (System.currentTimeMillis() > deadline) {
                break;
            }
            Common.sleep(1000);
        }
    }

    @Then("{I |}'$condition' see following search results for text '$textName' while adding asset '$assetName' from collection '$collectionName' pageNEWLIB: $data")
    public void openProjectPopup(String condition,String textName,String assetName,String collectionName,ExamplesTable data )
    {
        List<String> actualResult = new ArrayList();
        List<String> expectedResult = new ArrayList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            expectedResult.add(wrapVariableWithTestSession(row.get("SearchResults")));
        }
        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collectionName), getCategoryId(wrapCollectionName(collectionName)));
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
        AddToProjectPopUp addToProjectPopup = openAddToProjectPopUpNewLib(collectionName);
        addToProjectPopup.typeSearchText(textName);
        actualResult=addToProjectPopup.getAvailableForSearchProjectsListAsText();
        for(String expected:expectedResult) {
            assertThat(actualResult, condition.equalsIgnoreCase("should") ? hasItem(expected) : not(hasItem(expected)));
        }
        addToProjectPopup.cancelPopup();
    }



    @Then("{I |}'$condition' see projects '$projects' are available for selecting on Add Asset to Project popup while adding asset '$assetName' from collection '$collectionName' pageNEWLIB")
    public void checkProjectsSearch(String condition, String projects, String assetName, String collectionName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collectionName), getCategoryId(wrapCollectionName(collectionName)));

        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
        AddToProjectPopUp addToProjectPopup = openAddToProjectPopUpNewLib(collectionName);
        addToProjectPopup.typeSearchText(wrapVariableWithTestSession(projects));
        List<String> actualProjectList = addToProjectPopup.getAvailableForSearchProjectsListAsText();
        String expectedProjectName = wrapVariableWithTestSession(projects);
        assertThat(actualProjectList, shouldState ? hasItem(expectedProjectName) : not(hasItem(expectedProjectName)));
    }

    @Then("{I |}should see folder '$folderName' under '$pathName' of project '$projectName' on Add Asset to Project popup while adding asset '$assetName' from collection '$collectionName' pageNEWLIB")
    public void checkFoldersInAddToProjectPopup1(String folderName,String pathName,String projectName, String assetName, String collectionName) {
        List<String> actualList;
        LibraryAsset page = getSut().getPageNavigator().getLibraryPageNEWLIB(wrapCollectionName(collectionName), getCategoryId(wrapCollectionName(collectionName)));
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
        AddToProjectPopUp addToProjectPopup = openAddToProjectPopUpNewLib(collectionName);
        addToProjectPopup.clickRootFolder(wrapVariableWithTestSession(projectName));
        boolean actual = addToProjectPopup.isFolderExist(folderName,wrapPathWithTestSession(pathName));
        assertThat(actual,is(true));
    }

    @When("{I |}'$action' project '$projectName' and folder '$folderName' from collection '$collection' pageNEWLIB")
    public void selectFolder(String action,String projectName, String folderName, String collectionName)
    {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        AddToProjectPopUp addToProjectPopup = openAddToProjectPopUpNewLib(collectionName);
        if(action.equalsIgnoreCase("select")){
            addToProjectPopup.addToProjectFolder(wrapVariableWithTestSession(projectName), wrapVariableWithTestSession(folderName));

        }
        else {
            addToProjectPopup.typeSearchText(wrapVariableWithTestSession(projectName));
        }
    }


    @Then("I '$condition' see button '$elementName' enabled on add to project pop up from collection '$collectionName'NEWLIB")
    public void checkElementStateNewLib(String condition,String elementName, String collectionName) {
        boolean shouldState = condition.equals("should");
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        AddToProjectPopUp addToProjectPopup = openAddToProjectPopUpNewLib(collectionName);
        boolean actualState = addToProjectPopup.verifyButtonState();
        assertThat(actualState,shouldState ? equalTo(true) : not(equalTo(true)));
    }

    @Then("{I |}'$condition' see message '$message' while adding assets to project from collection '$collectionName' NEWLIB")
    public void verifyMessageForAddAssetToProject(String condition,String message,String collectionName)
    {
        LibraryAsset libraryPage = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actual = libraryPage.verifyToastMessage();
        assertThat(actual, shouldState? containsString(message) : not(containsString(message)));

    }

}