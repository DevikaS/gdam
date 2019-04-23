package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;


import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibCollectionPopUp;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionPage;
import com.adstream.automate.utils.Common;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionDetailsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibEditCollectionPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveCollectionPopup;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.openqa.selenium.By;

import java.util.Arrays;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.isIn;

/**
 * Created by Janaki.Kamat on 13/07/2017.
 */
public class CollectionDetailsPageSteps extends NewLibrarySteps {

    @When("{I |} go to  collection details page for collection '$collectionName'")
    public CollectionDetailsPage getCollectionDetailsPage(String collectionName) {
        return getSut().getPageNavigator().getCollectionDetailsPage(getCategoryId(wrapCollectionName(collectionName)));
    }

    public CollectionDetailsPage getCollectionDetailsPage() {
        return getSut().getPageCreator().getCollectionDetailsPage();
    }


    @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the collection '$collectionName'NEWLIB")
    public void checkAssetsVisibilityOnCollection(String condition, String assetsTitles, String collectionName) {
        CollectionDetailsPage page=getSut().getPageNavigator().getCollectionDetailsPage(getCategoryId(wrapCollectionName(collectionName)));
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = page.getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }

    @Then("{I |}'$condition' see assets with titles '$assetsTitles' in Shared Category '$collectionName'")
    public void checkAssetsinSharedCategory(String condition, String assetsTitles, String collectionName) {
        CollectionPage page=getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = page.getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }


    @Given("{I |}selected asset '$assetName' in the '$collectionName' collection pageNEWLIB")
    @When("{I |}select asset '$assetName' in the '$collectionName'  collection pageNEWLIB")
    public void selectAssetsInCollectionDetails(String assetName, String collectionName) {
        LibraryAsset page = getSut().getPageNavigator().getCollectionDetailsPage(getCategoryId(wrapCollectionName(collectionName)));
        for (String fileName : assetName.split(",")) page.selectFileByFileName(fileName);
    }


    /** Needs to be tested later  as of now the message comes up and goes quickly**/
    @Then("I '$condition' see  message '$message' for collection '$collectionName'")
    public void assertCollectionCreated(String condition,String message,String collectionName) {
        boolean cond=condition.equalsIgnoreCase("should");
        assertThat("Collection created message should appear", getSut().getPageNavigator().getCollectionDetailsPage(getCategoryId(wrapCollectionName(collectionName))).isCollectionCreatedMessageVisible(message), is(cond));
    }

    @Then("{I |}'$condition' see QCed assets with titles '$assetsTitles' in the collection '$collectionName'NEWLIB")
    public void checkQCedAssetsVisibilityOnCollection(String condition, String assetsTitles, String collectionName) {
        CollectionDetailsPage page=getSut().getPageNavigator().getCollectionDetailsPage(getCategoryId(wrapCollectionName(collectionName)));
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = page.getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(wrapVariableWithTestSession(expectedAssetTitle)) : not(hasItem(wrapVariableWithTestSession(expectedAssetTitle))));
        }
    }


    @Given("I navigated to '$collection' on collection details page")
    @When("I navigate to '$collection' on collections details page")
    public void navigateCollections(String collection) {
        CollectionDetailsPage page = getSut().getPageNavigator().getCollectionDetailsPage(getCategoryId(wrapCollectionName(collection)));
        page.selectUsingBreadCrum(wrapCollectionName(collection));
    }

    @When("I delete the collection '$collectionName' on collection details pageNEWLIB")
    public void deleteCollectionsNEWLIB(String collectionName) {
        getSut().getPageNavigator().getCollectionDetailsPage(getCategoryId(wrapCollectionName(collectionName)));
        CollectionDetailsPage page = getSut().getPageCreator().getCollectionDetailsPage();
        LibRemoveCollectionPopup popup = page.clickRemoveCollection();
        popup.clickAction();
    }


    @When("I rename library collection '$collectionName' to '$renamedCollectionName' on collections details page")
    public void clickOnEditNEWLIB(String collectionName,String renamedCollectionName  )
    {
        getSut().getPageNavigator().getCollectionDetailsPage(getCategoryId(wrapCollectionName(collectionName)));
        CollectionDetailsPage page = getSut().getPageCreator().getCollectionDetailsPage();
        LibCollectionPopUp popup = page.clickEditCollectionDetails();
        popup.setCollectionName(wrapVariableWithTestSession(renamedCollectionName));
        popup.clickAction();
        Common.sleep(2000);
    }

    @Then("I '$condition' see collection '$collection' in breadcrum on collections details pageNEWLIB")
    public void verifyCollectioninBreadCrum(String condition,String collection) {
        CollectionDetailsPage page = getSut().getPageCreator().getCollectionDetailsPage();
        boolean shouldState = condition.equals("should");
        Object[] collectionsList = page.getBreadCrum().toArray();
        String newString=null;
        StringBuilder actualstrBuilder = new StringBuilder();
        String[] stringArray = Arrays.toString(Arrays.copyOf(collectionsList, collectionsList.length, String[].class)).split("\n\uE90C, ");
        for (int i = 0; i < stringArray.length-1; i++) {
            actualstrBuilder.append(stringArray[i].replace("[","").replace("]","")).append(">");
        }
        actualstrBuilder.append(stringArray[stringArray.length-1].replace("]",""));
        StringBuilder expstrBuilder = new StringBuilder();
        String[] expectedCollection=collection.split(">");
        for(int j=0;j<expectedCollection.length-1;j++){
            if(!Arrays.asList("...", "Collections","My Collections").contains(expectedCollection[j]))
               expstrBuilder.append(wrapCollectionName(expectedCollection[j])).append(">");
            else
               expstrBuilder.append(expectedCollection[j]).append(">");
        }
        expstrBuilder.append(wrapCollectionName(expectedCollection[expectedCollection.length-1]));
        assertThat("BreadCrum is not showing up correct hierarchy",expstrBuilder.toString(),equalToIgnoringWhiteSpace(actualstrBuilder.toString()));
    }


    @When("I '$set' the collection '$collection' as home collection on collections details page")
    public void setAsHomeCollection(String setHomeCollection,String collection) {
        CollectionDetailsPage page = getCollectionDetailsPage(collection);
        switch(setHomeCollection){
            case "set" :
                page.setAsHomeCollection(wrapCollectionName(collection));
                break;
            case "unset" :
                page.removeAsHomeCollection(wrapCollectionName(collection));
                break;
            default:
                throw new IllegalArgumentException("Illegal argument " + setHomeCollection + " for setting home collection");
        }

    }

    @When("{I }click Collection Tab on collection details page")
    public void clickCollectionTab() {
        getSut().getWebDriver().waitUntilElementAppear(By.xpath(".//ads-ui-breadcrumbs//a[contains(text(),\"Collections\")]"));
        getSut().getWebDriver().click(By.xpath(".//ads-ui-breadcrumbs//a[contains(text(),\"Collections\")]"));
        Common.sleep(1000);
    }

    @Then("I '$condition' see collection '$collection' in breadcrum on collections pageNEWLIB")
    public void verifyCollectioninBreadCrumOnCollectionPage(String condition,String collection) {
        CollectionPage page = getSut().getPageCreator().getCollectionPage();
        boolean shouldState = condition.equals("should");
        Object[] collectionsList = page.getBreadCrum().toArray();
        String newString=null;
        StringBuilder actualstrBuilder = new StringBuilder();
        String[] stringArray = Arrays.toString(Arrays.copyOf(collectionsList, collectionsList.length, String[].class)).split("\n\uE90C, ");
        for (int i = 0; i < stringArray.length-1; i++) {
            actualstrBuilder.append(stringArray[i].replace("[","").replace("]","")).append(">");
        }
        actualstrBuilder.append(stringArray[stringArray.length-1].replace("]",""));
        StringBuilder expstrBuilder = new StringBuilder();
        String[] expectedCollection=collection.split(">");
        for(int j=0;j<expectedCollection.length-1;j++){
            if(!Arrays.asList("...", "Collections","My Collections").contains(expectedCollection[j]))
                expstrBuilder.append(wrapCollectionName(expectedCollection[j])).append(">");
            else
                expstrBuilder.append(expectedCollection[j]).append(">");
        }
        expstrBuilder.append(wrapCollectionName(expectedCollection[expectedCollection.length-1]));
        assertThat("BreadCrum is not showing up correct hierarchy",expstrBuilder.toString(),equalToIgnoringWhiteSpace(actualstrBuilder.toString()));
    }

    @When("{I }click library asset Tab on collection details page")
    public void clickLibraryAssetTab() {
        CollectionDetailsPage collectionPage = getSut().getPageCreator().getCollectionDetailsPage();
        collectionPage.clickLibraryAssetTab();
        Common.sleep(1000);
    }


    @When("I edit the collection '$collection' to new name '$name' in collections details page")
    public void editCollection(String collection,String name) {
        CollectionDetailsPage page = getCollectionDetailsPage(collection);
        LibEditCollectionPopup editPopup=page.openMenuPopup().editCollection();
        editPopup.enterCollectionName(wrapCollectionName(name)).clickSave();
    }


    @When("{I| }click on filter link on Collection details for collection '$collection'NEWLIB")
    public void clickFilterLink(String collection) {
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionDetailsPage();
        libraryPage.clickAssetFilter();
   }


}
