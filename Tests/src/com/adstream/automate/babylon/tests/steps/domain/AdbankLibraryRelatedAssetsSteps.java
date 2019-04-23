package com.adstream.automate.babylon.tests.steps.domain;


import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectFilesPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryRelatedAssetsPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

/**
 * Created by sobolev-a on 17.07.2014.
 */
public class AdbankLibraryRelatedAssetsSteps extends LibrarySteps {


    @Given("{I am |}on asset '$assetName' info page in Library for collection '$categoriesName' on related assets page")
    @When("{I |}go to asset '$assetName' info page in Library for collection '$categoriesName' on related assets page")
    public AdbankLibraryAssetsInfoPage openAdbankLibraryRelatedAssetsPage(String assetName, String collectionName) {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }
        return getSut().getPageNavigator().getAdbankLibraryRelatedAssetsPage(collectionId, asset.getId());
    }

    @Given("{I |}typed related asset '$filename' on related assets page on pop-up")
    @When("{I |}type related asset '$filename' on related assets page on pop-up")
    public void typeRelatedFileName(String fileName) {
        AdbankLibraryRelatedAssetsPage adbankLibraryRelatedAssetsPage = getSut().getPageCreator().getAdbankLibraryRelatedAssetsPage();
        adbankLibraryRelatedAssetsPage.clickLinkToExistingButton();
        adbankLibraryRelatedAssetsPage.typeRelatedFileName(fileName);
    }

    @Given("{I |}selected following related files '$files' on related asset pop-up")
    @When("{I |}select following related files '$files' on related asset pop-up")
    public void selectFollowingRelatedFiles(String files) {
        AdbankLibraryRelatedAssetsPage adbankLibraryRelatedAssetsPage = getSut().getPageCreator().getAdbankLibraryRelatedAssetsPage();
        for (String file : files.split(",")) {
            adbankLibraryRelatedAssetsPage.selectRelatedAssets(file);
        }
        adbankLibraryRelatedAssetsPage.clickSaveButton();
        Common.sleep(3000);
    }

    @Given("{I |}deleted following files '$files' on related assets page")
    @When("{I |}delete following files '$files' on related assets page")
    public void deleteFollowingFiles(String files) {
        AdbankLibraryRelatedAssetsPage adbankFileAttachmentsPage = getSut().getPageCreator().getAdbankLibraryRelatedAssetsPage();
        for (String file : files.split(",")) {
            adbankFileAttachmentsPage.deleteRelatedFile(file);
        }
    }

    @Then("{I |}should see following count '$count' of related files on assets pop-up")
    public void checkCountOfRelatedFiles(String count) {
        AdbankLibraryRelatedAssetsPage AdbankLibraryRelatedAssetsPage = getSut().getPageCreator().getAdbankLibraryRelatedAssetsPage();
        int expectedState = Integer.parseInt(count);
        int actualState = AdbankLibraryRelatedAssetsPage.getCountOfRelatedAssets();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}should see following count '$count' of related files on assets page")
    public void checkCountOfRelatedFilesProjectPage(String count) {
        AdbankProjectFilesPage AdbankLibraryRelatedAssetsPage = getSut().getPageCreator().getProjectFilesPage();
        int expectedState = Integer.parseInt(count);
        int actualState = AdbankLibraryRelatedAssetsPage.relatedFilesCount();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see LinkToExisting button on assets page")
    public void checkLinkToExisting(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getAdbankLibraryRelatedAssetsPage().isLinkToExistButtonExist();

        assertThat(actualState, is(shouldState));
    }

    @Then("{I |}'$condition' see following files '$file' on related assets page")
    public void checkIsRelatedFiles(String condition, String file) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryRelatedAssetsPage pageObject = getSut().getPageCreator().getAdbankLibraryRelatedAssetsPage();

        for (String asset : file.split(",")) {
            assertThat("Bad asset on related assets page: ", shouldState, is(pageObject.isRelatedFileNotExist(asset)));
        }
    }

    @Then("{I |}'$should' see remove button of following related assets '$files' on related assets page")
    public void checkRemoveButton(String should, String files) {
        boolean shouldState = should.equalsIgnoreCase("should");
        AdbankLibraryRelatedAssetsPage pageObject = getSut().getPageCreator().getAdbankLibraryRelatedAssetsPage();

        for (String asset : files.split(",")) {
            assertThat(shouldState, is(pageObject.isRelatedFileDeleteButtonExist(asset)));
        }
    }

    @Then("{I |}'$should' see '$tab' tab on asset info page")
    public void checlRelatedFileTab(String condition, String tab) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getProjectFileInfoPage().isTabVisible(tab);

        assertThat(String.format("Something is wrong with tab %s on asset info page", tab), shouldState, is(actualState));
    }
}