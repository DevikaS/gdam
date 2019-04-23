package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectFileInfoPage;
import com.adstream.automate.babylon.sut.pages.file.preview.AnnotationsPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.util.ArrayList;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class AnnotationSteps extends BaseStep {

    AnnotationsPage annotationsPage;
    String parentHandle = null;

    @Given("{I |}clicked on Annotation button on file info page")
    @When("{I |}click on Annotation button on file info page")
    public void clickonAnnotateButton(){
        Common.sleep(2000);
        AdbankProjectFileInfoPage pageObject = getSut().getPageCreator().getProjectFileInfoPage();
        pageObject.clickAnnotationButton();

        setParentHandle(getSut().getWebDriver().getWindowHandle());
        annotationsPage = getSut().getPageCreator().getAnnotationsPage();
        for (String winHandle : getSut().getWebDriver().getWindowHandles()) {
            // Switch to child window
            getSut().getWebDriver().switchTo().window(winHandle);
        }
    }

    @Given("{I |}played the file on the opened Annotations tool")
    @When("{I |}play the file on the opened Annotations tool")
    public void playFileOnAnnotations() {
        Common.sleep(1000);
        annotationsPage.clickOnPlayButton();
    }

    @Given("{I |}create an annotation with notes '$notes' and '$action' it")
    @When("{I |}created an annotation with notes '$notes' and '$action' it")
    public void addAnnotation(String notes, String action) {
        annotationsPage.clickOnNewAnnotationButton();
        annotationsPage.writeCommentInCommentsSection(notes);
        annotationsPage.clickOnSaveButton();
    }

    @Given("{I |}edit annotation with notes '$notes' and '$action' it")
    @When("{I |} edited annotation with notes '$notes' and '$action' it")
    public void editAnnotation(String notes, String action)  {
        annotationsPage.clickOnEditIcon();
        annotationsPage.editCommentInEditAnnotationSection(notes);
        annotationsPage.clickOnSaveButtonEditAnnotationSection();
        Common.sleep(2000);
    }

    @Given("{I |}add a comment to an annotation as '$comment' and '$action' it")
    @When("{I |} added a comment to an annotation as '$comment' and '$action' it")
    public void addCommentToAnnotation(String comment, String action) {
        annotationsPage.clickOnReply();
        annotationsPage.writeCommentInReplySection(comment);
        Common.sleep(1000);
        annotationsPage.clickOnSaveButtonInReplySection();
        Common.sleep(2000);
        annotationsPage.clickOnSaveButtonInReplySection();
    }

    @Given("{I |}select the first annotation")
    @When("{I |}selected the first annotation")
    public void selectFirstAnnotation() {
        annotationsPage.selectAnnotation();
        Common.sleep(1000);
    }

    @Given("{I |}delete comment from annotation")
    @When("{I |}deleted comment from annotation")
    public void deleteCommentFromAnnotation() {
        annotationsPage.clickOnDeleteIconInReplyCommentsSection();
        Common.sleep(1000);
    }

    @Given("{I |}delete the annotation")
    @When("{I |}deleted the annotation")
    public void deleteAnnotation() {
        annotationsPage.clickOnDeleteIcon();
        Common.sleep(1000);
    }

    @Given("{I |} {open|close} compare view on Annotations page")
    @When("{I |} {opened|closed} compare view on Annotations page")
    public void openCompareView() {
        annotationsPage.clickOnCompare();
    }

    @Given("{I |}exit the comapre view on Annotations page")
    @When("{I |} exited the compare view on Annotations page")
    public void exitCompareView() {
        annotationsPage.clickOnExitCompare();
    }


    @Then("{I |}'$should' see Annotate button on file info page")
    public void isAnnotateButtonVisible(String should){
        boolean shouldState = should.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getProjectFileInfoPage().isAnnotationButtonVisible();
        assertThat(actualState, equalTo(shouldState));
    }

    @Then("{I |}'$should' see playable preview on file info page")
    public void isPlayablePreviewExist(String should) {
        boolean shouldState = should.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getProjectFileInfoPage().isPlayerAvailable();

        assertThat("Video player are not available", shouldState == actualState);
    }

    @Then("{I |} '$condition' see the annotation with notes '$notes'")
    public void verifyAnnotationNotes(String condition, String notes) {
        boolean should = condition.equalsIgnoreCase("should");
        String editedtext = annotationsPage.getEditedText();
        assertThat("Annotation notes not as expected", should ? editedtext.equals(notes) : editedtext==null ? true : !editedtext.equals(notes));
    }


    @Then("{I |} '$condition' see annotation with comment '$comment' from user '$user'")
    public void verifyAnnotationComments(String condition, String comment, String user) {
        boolean should = condition.equalsIgnoreCase("should");
        String userName = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(user)).getFullName();
        ArrayList<String> comments = annotationsPage.getAnnotationCommentsByUser(userName);
        assertThat("Annotation comment not as expected", should ? comments.contains(comment) : !comments.contains(comment));
    }

    @Then("{I |}'$condition' see version '$version' displayed on Annotations page")
    public void checkVersionDisplayed(String condition, String version) {
        boolean should = condition.equalsIgnoreCase("should");
        String actualVerions = annotationsPage.getCurrentVersion();
        assertThat("Correct verison is not displayed", should ? actualVerions.equals(version) : !actualVerions.equals(version));
    }

    @Then("{I |}'$condition' see link Compare on Annotations page")
    public void checkCompareButton(String condition) {
        boolean should = condition.equalsIgnoreCase("should");
        assertThat("Compare button visibility not as expected", should ? annotationsPage.isCompareLinkDisplayed() : !annotationsPage.isCompareLinkDisplayed());
    }

    @Then("{I |}'$condition' exit the compare view on Annotations page")
    public void isCompareViewExited(String condition) {
        boolean should = condition.equalsIgnoreCase("should");
        assertThat("Compare view visibility not as expected", should ? !annotationsPage.isCompareViewDisplayed() : annotationsPage.isCompareViewDisplayed());
    }

    @Then ("I should close the annotations window after the checks")
    public void closeAnnotations() {
        getSut().getWebDriver().close();
        getSut().getWebDriver().switchTo().window(getParentHandle());
    }


    private void setParentHandle(String parentHandleName) {
        parentHandle = parentHandleName;
    }

    private String getParentHandle() {
        return parentHandle;
    }
}
