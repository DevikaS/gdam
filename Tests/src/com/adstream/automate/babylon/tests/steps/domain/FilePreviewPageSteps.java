package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewPage;
import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewCommentsPage;
import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewInfoPage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/**
 * User: lynda-k
 * Date: 25.12.13
 * Time: 12:00
 */
public class FilePreviewPageSteps extends AbstractPreviewSteps {
    public FilePreviewPage getPreviewPage() {
        return getSut().getPageCreator().getFilePreviewPage();
    }

    public FilePreviewInfoPage getPreviewInfoPage() {
        return getSut().getPageCreator().getFilePreviewInfoPage();
    }

    public FilePreviewCommentsPage getPreviewCommentsPage() {
        return getSut().getPageCreator().getFilePreviewCommentsPage();
    }

    @Given("{I |}opened comments tab on opened file preview page")
    @When("{I |}open comments tab on opened file preview page")
    public FilePreviewCommentsPage openCommentsTabOnOpenedPage() {
        return getPreviewPage().clickCommentsTab();
    }

    @Given("{I |}downloaded original file on opened file preview page")
    @When("{I |}download original file on opened file preview page")
    public void downloadOriginalFileOnOpenedPage() {
        downloadOriginalFile();
    }

    @Given("{I |}downloaded proxy file on opened file preview page")
    @When("{I |}download proxy file on opened file preview page")
    public void downloadProxyFileOnOpenedPage() {
        downloadProxyFile();
    }

    @Given("{I |}added comment '$comment' on opened file preview comments page")
    @When("{I |}add comment '$comment' on opened file preview comments page")
    public void addCommentOnOpenedPage(String comment) {
        FilePreviewCommentsPage page = getPreviewCommentsPage();
        page.typeComment(comment);
        page.clickCommentButton();
    }

    @When("{I |}replay '$reply' on comment '$comment' on opened file preview comments page")
    public void replayOnComment(String reply, String comment) {
        FilePreviewCommentsPage page = getPreviewCommentsPage();
        page.clickReplyLink(comment);
        page.typeReplyComment(reply);
        page.clickReplyButton();
    }

    @Then("{I |}'$condition' be on file preview page")
    public void checkThatPreviewPageOpened(String condition) {
        checkThatPreviewPageOpened(condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$condition' see Edit link on opened file preview page")
    public void checkThatEditLinkPresent(String condition) {
        checkThatEditLinkPresent(condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$condition' see Download original button on opened file preview page")
    public void checkThatDownloadOriginalButtonPresent(String condition) {
        checkThatDownloadOriginalButtonPresent(condition.equalsIgnoreCase("should"));
    }

    @Then("{I |}'$condition' see Download proxy button on opened file preview page")
    public void checkThatDownloadProxyButtonPresent(String condition) {
        checkThatDownloadProxyButtonPresent(condition.equalsIgnoreCase("should"));
    }

   // | UserName | Content | Date |
    @Then("{I |}'$condition' see following comments on opened file preview comments page: $data")
    public void checkThatCommentPresent(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<Map<String,String>> actualComments = getPreviewCommentsPage().getCommentsList();

        for (Map<String,String> row : parametrizeTableRows(data)) {
            Map<String,String> expectedComment = new HashMap<String,String>();
            User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName")));

            expectedComment.put("UserName", user.getFullName());
            expectedComment.put("Content", row.get("Content"));

            //hardcoded date format according to resolution in NGN-9351
            expectedComment.put("Date", parseDateTime(row.get("Date")).toString("M/d/yyyy"));

            assertThat(actualComments, shouldState ? hasItem(expectedComment) : not(hasItem(expectedComment)));
        }
    }

    @Then("{I |}'$condition' see '$tabNames' tab on opened file preview page")
    public void checkTabPresence(String condition, String tabNames) {
        checkTabPresence(condition.equalsIgnoreCase("should"), tabNames);
    }

    protected DateTime parseDateTime(String date) {
        if (date.equalsIgnoreCase("Today")) {
            return DateTime.now();
        } else if (date.equalsIgnoreCase("Yesterday")) {
            return DateTime.now().minusDays(1);
        } else if (date.equalsIgnoreCase("Tomorrow")) {
            return DateTime.now().plusDays(1);
        } else {
            return DateTimeFormat.forPattern(TestsContext.getInstance().storiesDateTimeFormat).parseDateTime(date);
        }
    }
}