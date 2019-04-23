package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsActivityPage;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

public class LibraryPresentationsActivitySteps extends LibraryPresentationsSteps {

    public AdbankLibraryPresentationsActivityPage getLibraryPresentationsPage() {
        return getSut().getPageCreator().getLibraryPresentationsActivityPage();
    }

    public AdbankLibraryPresentationsActivityPage getLibraryPresentationsPage(String presentationId) {
        return getSut().getPageNavigator().getLibraryPresentationsActivityPage(presentationId);
    }

    @Given("I am on the presentation activity page '$presentationName'")
    @When("{I |}go to the presentation activity page '$presentationName'")
    public AdbankLibraryPresentationsActivityPage openLibraryPresentationActivityPage(String presentationName) {
        String presentationId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        return getSut().getPageNavigator().getLibraryPresentationsActivityPage(presentationId);
    }

    @Then("I '$condition' see presentation name '$presentationName' on presentations activity tab")
    public void checkThatPresentationNameIsCorrectlyDisplayed(String condition, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualPresentationName = openLibraryPresentationActivityPage(presentationName).getPresentationName();
        String expectedPresentationName = wrapVariableWithTestSession(presentationName);

        assertThat(actualPresentationName, shouldState ? equalTo(expectedPresentationName) : not(equalTo(expectedPresentationName)));
    }

    @Then("I '$condition' see No. Assets '$assetsCount' on presentation '$presentationName' activity tab")
    public void checkThatAssetsCountIsCorrectlyDisplayed(String condition, String assetsCount, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        assertThat(openLibraryPresentationActivityPage(presentationName).getAssetsCount(), shouldState ? equalTo(assetsCount) : not(equalTo(assetsCount)));
    }

    @Then("I '$condition' see No. Views '$viewsCount' on presentation '$presentationName' activity tab")
    public void checkThatViewsCountIsCorrectlyDisplayed(String condition, String viewsCount, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        assertThat(openLibraryPresentationActivityPage(presentationName).getViewsCount(), shouldState ? equalTo(viewsCount) : not(equalTo(viewsCount)));
    }

    @Then("I '$condition' see No. Downloads '$downloadsCount' on presentation '$presentationName' activity tab")
    public void checkThatDownloadsCountIsCorrectlyDisplayed(String condition, String downloadsCount, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        assertThat(openLibraryPresentationActivityPage(presentationName).getDownloadsCount(), shouldState ? equalTo(downloadsCount) : not(equalTo(downloadsCount)));
    }

    @Then("I '$condition' see Emails Sent '$emailsSentCount' on presentation '$presentationName' activity tab")
    public void checkThatEmailsSentCountIsCorrectlyDisplayed(String condition, String emailsSentCount, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        assertThat(openLibraryPresentationActivityPage(presentationName).getEmailsSentCount(), shouldState ? equalTo(emailsSentCount) : not(equalTo(emailsSentCount)));
    }

    @Then("I '$condition' see Public URL '$publicURLPath' on presentation '$presentationName' activity tab")
    public void checkThatPublicURLIsCorrectlyDisplayed(String condition, String publicURLPath, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualPublicURL = openLibraryPresentationActivityPage(presentationName).getPublicURL();
        String expectedPublicURL = String.format("%s/%s/", getContext().applicationUrl, wrapVariableWithTestSession(publicURLPath.toLowerCase()));

        assertThat(actualPublicURL, shouldState ? equalTo(expectedPublicURL) : not(equalTo(expectedPublicURL)));
    }

    @Then("I '$condition' see Total Duration '$expectedDuration' on presentation '$presentationName' activity tab")
    public void checkThatAssetsTotalDurationIsCorrectlyDisplayed(String condition, String expectedDuration, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualDuration = openLibraryPresentationActivityPage(presentationName).getTotalDuration();

        assertThat(actualDuration, shouldState ? equalTo(expectedDuration) : not(equalTo(expectedDuration)));
    }

    @Then("I '$condition' see '$dateField' is '$dateString' on presentation '$presentationName' activity tab")
    public void checkThatDateIsCorrectlyDisplayed(String condition, String dateField, String dateString, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");

        String actualDateString = "";
        String expectedDateString = dateString;

        Reel reel = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName));
        String dateTimeFormat = getData().getCurrentUser().getDateTimeFormatter().getDateTimeFormat();

        if (dateField.equalsIgnoreCase("datecreated")) {
            actualDateString = openLibraryPresentationActivityPage(presentationName).getDateCreated();
            if (dateString.equalsIgnoreCase("currentdate"))
                expectedDateString = DateTimeUtils.formatDate(reel.getCreated().toDate(), dateTimeFormat);
        } else if (dateField.equalsIgnoreCase("lastmodified")) {
            actualDateString = openLibraryPresentationActivityPage(presentationName).getLastModified();
            if (dateString.equalsIgnoreCase("lastmodifieddate"))
                expectedDateString = DateTimeUtils.formatDate(reel.getModified().toDate(), dateTimeFormat);
        }

        assertThat(actualDateString, shouldState ? equalTo(expectedDateString) : not(equalTo(expectedDateString)));
    }

    @Then("I '$condition' see Last modified equals to Date created on presentation '$presentationName' activity tab")
    public void checkThatLastModifiedEqualsDateCreated(String condition, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String lastModified = openLibraryPresentationActivityPage(presentationName).getLastModified();
        String dateCreated = openLibraryPresentationActivityPage(presentationName).getDateCreated();

        assertThat(lastModified, shouldState ? equalTo(dateCreated) : not(equalTo(dateCreated)));
    }

    @Then("I '$condition' see for user '$userType' presentation logo is thumbnail of asset '$fileName'")
    public void checkThatAssetThumbnailIsPresentationLogo(String condition, String userType, String fileName) {
        boolean shouldState = condition.equalsIgnoreCase("should");


        String actualFileId = getLibraryPresentationsPage().getPresentationLogoFileId();
        String expectedFileId = "";

        User user = getData().getUserByType(userType);
        AssetFilter collection = getCoreApi(user).getAssetsFilterByName("Everything", "", 0);
        if (collection == null) collection = getCoreApi(user).getAssetsFilterByName("My Assets", "", 0);

        List<Content> assetsList = getCoreApi(user).getAllAssetByName(collection.getId(), fileName);

        for (FilePreview filePreview : assetsList.get(assetsList.size()-1).getLastRevision().getPreview()) {
            if (filePreview.getA5Type().toLowerCase().contains("thumbnail")) {
                expectedFileId = filePreview.getFileID();
                break;
            }
        }

        assertThat(actualFileId, shouldState ? equalTo(expectedFileId) : not(equalTo(expectedFileId)));
    }
}