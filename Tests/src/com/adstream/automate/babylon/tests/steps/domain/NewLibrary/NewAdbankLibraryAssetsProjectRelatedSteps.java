package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryAssetRelatedProjectsPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

/**
 * Created by devika on 21/11/2017.
 */
public class NewAdbankLibraryAssetsProjectRelatedSteps extends LibraryHelperSteps {

    private NewAdbankLibraryAssetRelatedProjectsPage openNewAdbankLibraryAssetRelatedProjectsPage(String collectionId, String assetId) {
        return getSut().getPageNavigator().getNewAdbankLibraryAssetRelatedProjectsPage(assetId);
    }

    private NewAdbankLibraryAssetRelatedProjectsPage getNewAdbankLibraryRelatedProjectsPage() {
        return getSut().getPageCreator().getNewAdbankLibraryAssetRelatedProjectsPage();
    }

    @Given("{I am |}on asset '$assetName' related projects info page in Library for collection '$collectionName' NEWLIB")
    @When("{I |}go to asset '$assetName' related projects info page in Library for collection '$collectionName' NEWLIB")
    public NewAdbankLibraryAssetRelatedProjectsPage openRelatedProjectsPage1(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null)
            throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        return openNewAdbankLibraryAssetRelatedProjectsPage(collectionId, asset.getId());


    }

    @Then("{I |}'$condition' see following originated {project|work request} name '$projectName' on assets related projects info page in Library NEWLIB")
    public void checkOriginatedProjectNameNewLib(String condition,String projectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(getNewAdbankLibraryRelatedProjectsPage().getOriginatedProjectName(),  shouldState ? equalTo(wrapVariableWithTestSession(projectName)) : not(equalTo(wrapVariableWithTestSession(projectName))));
    }

    @When("{I |}click related project '$projectName' on asset '$assetName' related projects info page in Library for collection '$collectionName' NEWLIB")
    public void clickRelatedProjectLinkNewLib(String projectName, String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        NewAdbankLibraryAssetRelatedProjectsPage page = openNewAdbankLibraryAssetRelatedProjectsPage(collectionId, asset.getId());
        page.clickOriginatedProjectLink();
    }


    @Then("{I |} should see a message '$message' on assets related projects info page in Library NEWLIB")
    public void isOriginatedProjectNameVisible(String message) {
        boolean actualState = getNewAdbankLibraryRelatedProjectsPage().isMessageDisplayed(message);
        assertThat(actualState, is(true));
    }
    @Then("{I |}'$condition' see usage expired text '$text' on opened asset related project pageNEWLIB")
    public void checkUsageExpiredLabelPresentOnRelatedProjectsPage(String condition,String text) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState=getNewAdbankLibraryRelatedProjectsPage().isUsageIndicatorLabelExist(text);
        assertThat(actualState, is(expectedState));
    }

}