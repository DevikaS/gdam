package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;

import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibSingleEditAssetMetadataPage;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import static org.hamcrest.MatcherAssert.assertThat;

/**
 * Created by Janaki.Kamat on 06/02/2018.
 */
public class LibSingleEditAssetMetadataPageSteps extends NewLibraryAssetsViewSteps {
    @Then("{I |}'$condition' see '$editMessage' message on single edit Asset page")
    public void checkEditMessage(String condition,String editMessage) {
        Boolean expected = condition.equals("should");
        LibSingleEditAssetMetadataPage editAssetMetadataPage = getSut().getPageCreator().getSingleLibEditAssetMetadataPage();
        assertThat(String.format("%s Edit message should be displayed",editMessage),editAssetMetadataPage.getEditMessage().equalsIgnoreCase(editMessage));
    }

    @When("{I |}click '$editMessage' message on single edit Asset page")
    public void clickEditMessage(String editMessage) {
        LibSingleEditAssetMetadataPage editMultiAssetMetadataPage = getSut().getPageCreator().getSingleLibEditAssetMetadataPage();
        editMultiAssetMetadataPage.clickEditMessage(editMessage);
    }
}
