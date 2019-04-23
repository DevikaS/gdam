package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.asset.preview.AssetPreviewPage;
import com.adstream.automate.babylon.sut.pages.asset.preview.AssetPreviewInfoPage;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.junit.Assert;

import static org.hamcrest.MatcherAssert.assertThat;

/**
 * User: lynda-k
 * Date: 25.12.13
 * Time: 12:00
 */
public class AssetPreviewPageSteps extends AbstractPreviewSteps {
    public AssetPreviewPage getPreviewPage() {
        return getSut().getPageCreator().getAssetPreviewPage();
    }

    public AssetPreviewInfoPage getPreviewInfoPage() {
        return getSut().getPageCreator().getAssetPreviewInfoPage();
    }

    @Given("{I |}downloaded original file on opened asset preview page")
    @When("{I |}download original file on opened asset preview page")
    public void downloadOriginalFileOnOpenedPage() {
        downloadOriginalFile();
    }

    @Given("{I |}downloaded proxy file on opened asset preview page")
    @When("{I |}download proxy file on opened asset preview page")
    public void downloadProxyFileOnOpenedPage() {
        downloadProxyFile();
    }

    @When("{I |}open destinations tab on opened asset preview page")
    public void openAssetsDestinationInfoPage() {
        getPreviewPage().openDestinationsTab();
    }

    @Then("{I |}'$condition' be on asset preview page")
    public void checkThatPreviewPageOpened(String condition) {
        checkThatPreviewPageOpened(condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$shouldState' be able to play the asset on preview page")
    public void checkThatPreviewIsPlayable(String shouldState){
        Boolean expected = shouldState.equals("should not");
        AssetPreviewPage assetViewPage = getSut().getPageCreator().getAssetPreviewPage();
        FlowPlayerProxy player = assetViewPage.getFlowPlayer();
        player.play();
        assertThat("Asset could not be played",expected.equals(player.isPaused()));
    }

    @Then("{I |}'$condition' see Edit link on opened asset preview page")
    public void checkThatEditLinkPresent(String condition) {
        checkThatEditLinkPresent(condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$condition' see Download original button on opened asset preview page")
    public void checkThatDownloadOriginalButtonPresent(String condition) {
        checkThatDownloadOriginalButtonPresent(condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$condition' see Download proxy button on opened asset preview page")
    public void checkThatDownloadProxyButtonPresent(String condition) {
        checkThatDownloadProxyButtonPresent(condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$condition' see '$tabNames' tab on opened asset preview page")
    public void checkTabPresence(String condition, String tabNames) {
        checkTabPresence(condition.equalsIgnoreCase("should"), tabNames);
    }
}