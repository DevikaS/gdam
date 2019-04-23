package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.library.LibrarySearchResultPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.hamcrest.Matcher;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 05.02.13
 * Time: 18:47

 */
public class LibrarySearchSteps extends BaseStep {

    @When("I select '$itemsCount' on the library search results page")
    public void selectItemsOnLSRpage(String itemsCount) {
        LibrarySearchResultPage librarySearchResultPage = getSut().getPageCreator().getLibrarySearchResultPage();
        librarySearchResultPage.setItemPerPage(itemsCount);
    }

    @Then("I '$condition' see assets '$assetsName' on the library search results page")
    public void checkAssetsVisibility(String condition, String assetsName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualAssetNames = getSut().getPageCreator().getLibrarySearchResultPage().getUploadedElementsText();

        if (assetsName.isEmpty() && shouldState)
            assertThat(actualAssetNames.size(), equalTo(0));

        for (String expectedAssetName : assetsName.split(","))
            assertThat(actualAssetNames, shouldState ? hasItem(expectedAssetName) : not(hasItem(expectedAssetName)));
    }
}
