package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.tests.steps.domain.NewLibrary.LibraryHelperSteps;

import static org.hamcrest.MatcherAssert.assertThat;

/**
 * Created by Janaki.Kamat on 11/09/2017.
 */
public class CollectionDataPageSteps extends LibraryHelperSteps {
   /* @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the collection data '$collectionName'NEWLIB")
    public void checkAssetsVisibilityOnCollection(String condition, String assetsTitles, String collectionName) {
        getSut().getPageNavigator().getCollectionDataPage(getCategoryId(wrapCollectionName(collectionName)));
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = getSut().getPageCreator().getCollectionDataPage().getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }

    @Then("I '$condition' see collection '$collection' in breadcrum on collections data page")
    public void verifyCollectioninBreadCrum(String condition,String collection) {
        CollectionDataPage page = getSut().getPageCreator().getCollectionDataPage();
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
            expstrBuilder.append(expectedCollection[j]).append(">");
        }
        expstrBuilder.append(wrapCollectionName(expectedCollection[expectedCollection.length-1]));
        assertThat("BreadCrum is not showing up correct hierarchy",expstrBuilder.toString(),equalToIgnoringWhiteSpace(actualstrBuilder.toString()));
    }

    @Then("{I |}'$condition' see assets with titles '$assetsTitles' in the collection data page")
    public void checkAssetsVisibilityinCollectionPage(String condition, String assetsTitles) {
        CollectionDataPage page=getSut().getPageNavigator().getCollectionDataPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetsTitles = page.getPresentedAssetsTitles();
        for (String expectedAssetTitle : assetsTitles.split(",")) {
            assertThat(actualAssetsTitles, shouldState ? hasItem(expectedAssetTitle) : not(hasItem(expectedAssetTitle)));
        }
    }


    @Given("{I am |}on asset '$assetName' page from '$collectionName' in collection data page")
    @When("{I |}go to asset '$assetName' page from '$collectionName' in collection data page")
    public void openAssetPage(String assetName, String collectionName) {
        Content asset = getAsset(getCategoryId(wrapCollectionName(collectionName)), assetName);
        LibraryAsset libraryPage = getSut().getPageCreator().getCollectionPage();
        libraryPage.clickAsset(getCategoryId(wrapCollectionName(collectionName)),asset.getId());
    }


     @When("{I |}clear the search criteria in collection data page")
    public void clearSearchCriteria() {
        CollectionPage collectionPage = getSut().getPageCreator().getCollectionPage();
        collectionPage.clearSearchCollection();
    }*/
}
