package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryRelatedProjectsPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

/*
 * Created by demidovskiy-r on 11.08.2014.
 */
public class AdbankLibraryRelatedProjectsSteps extends LibrarySteps {

    private AdbankLibraryRelatedProjectsPage openAdbankLibraryRelatedProjectsPage(String collectionId, String assetId) {
        return getSut().getPageNavigator().getAdbankLibraryRelatedProjectsPage(collectionId, assetId);
    }

    private AdbankLibraryRelatedProjectsPage getAdbankLibraryRelatedProjectsPage() {
        return getSut().getPageCreator().getAdbankLibraryRelatedProjectsPage();
    }

    @Given("{I am |}on asset '$assetName' related projects info page in Library for collection '$collectionName'")
    @When("{I |}go to asset '$assetName' related projects info page in Library for collection '$collectionName'")
    public AdbankLibraryRelatedProjectsPage openRelatedProjectsPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        return openAdbankLibraryRelatedProjectsPage(collectionId, asset.getId());
    }

    @When("{I |}click related project '$projectName' on asset '$assetName' related projects info page in Library for collection '$collectionName'")
    public void clickRelatedProjectLink(String projectName, String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null) throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        AdbankLibraryRelatedProjectsPage page = openAdbankLibraryRelatedProjectsPage(collectionId, asset.getId());
        page.clickOriginatedProjectLink();
    }

    @Then("{I |}should see following originated project name '$projectName' on assets related projects info page in Library")
    public void checkOriginatedProjectName(String projectName) {
        assertThat("Check originated project name: ", getAdbankLibraryRelatedProjectsPage().getOriginatedProjectName(), equalTo(wrapVariableWithTestSession(projectName)));
    }

    @Then("{I |}'$should' see following originated project name '$projectName' on assets related projects info page in Library")
    public void checkOriginatedProjectName(String should, String projectName) {
        boolean shouldState = should.equalsIgnoreCase("should");
        assertThat("Check originated project name: ", getAdbankLibraryRelatedProjectsPage().getOriginatedProjectName(), equalTo(wrapVariableWithTestSession(projectName)));
    }

    @Then("{I |}'$shouldState' see following related {project|work request} name '$projectName' on assets related projects info page in Library")
    public void checkRleatedProjectName(String shouldState, String projectName) {
        boolean actualState = shouldState.equalsIgnoreCase("should");
        boolean expectedState = getAdbankLibraryRelatedProjectsPage().getRelatedProjectName(wrapAgencyName(projectName));
        assertThat("Check related project name: ", actualState == expectedState);
    }
}