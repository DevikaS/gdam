package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.asset.preview.AssetPreviewInfoPage;
import com.adstream.automate.babylon.sut.pages.asset.preview.NewAssetPreviewPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by Janaki.Kamat on 27/09/2017.
 */
public class NewAssetPreviewPageSteps extends NewLibraryAssetsViewSteps {
    public NewAssetPreviewPage getPreviewPage() {
        return getSut().getPageCreator().getNewAssetPreviewPage();
    }

     @Then("{I |}'$condition' be on asset preview page")
    public void checkThatPreviewPageOpened(String condition) {
    }

    @When("{I |}'$shouldState' be able to play the asset on preview pageNEWLIB")
    @Then("{I |}'$shouldState' be able to play the asset on preview pageNEWLIB")
    public void checkThatPreviewIsPlayable(String shouldState)  throws InterruptedException {
        Boolean expected = shouldState.equals("should");
        NewAssetPreviewPage assetViewPage = getPreviewPage();
        assetViewPage.play( );
        Common.sleep(2000);
        assertThat(assetViewPage.getJwplayerState(), expected ? is("playing") : not(is("idle")));

    }

    @When("{I |}navigate to asset with title '$title' on preview pageNEWLIB")
    public void whenNavigateToAsset(String title)  {
        NewAssetPreviewPage assetViewPage = getPreviewPage();
        assetViewPage.naviagateToAsset(title);
    }

    @Then("{I |}'$condition' see '$title' on asset preview page")
    public void checkAssetTitle(String condition,String title) {
        Boolean expected = condition.equals("should");
        NewAssetPreviewPage assetViewPage = getPreviewPage();
        assertThat(String.format("Asset title %s is not displayed",title),assetViewPage.getTitle(),equalToIgnoringCase(title));
    }
}
