package com.adstream.automate.babylon.tests.steps.domain.mediamanager;

import com.adstream.automate.babylon.sut.pages.mediamanager.MediaCheckerHistoryPage;
import com.adstream.automate.babylon.sut.pages.mediamanager.MediaManagerHistoryPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.hamcrest.core.IsEqual;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by Saritha.Dhanala on 09/05/2018.
 */
public class MediaManagerHistorySteps extends BaseStep {

    @Given("I am on Media Manager History page")
    @When("{I |}go to Media Manager History page")
    public void openMMHistoryPage() {
        getSut().getPageNavigator().getMediaManagerHistoryPage();
    }

    @Given("I am on Media Checker History page")
    @When("{I |}go to Media Checker History page")
    public void openMCHistoryPage() {
        getSut().getPageNavigator().getMediaCheckerHistoryPage();
    }


    @Then("{I |}'$should' see the file with '$clockNumber' as '$status' on '$date' in '$pageName' History page")
    public void verifyMessageInHistory(String condition, String clockNumber, String status, String date, String pageName){
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean IsPresentInHistory = false;

        if(pageName.equals("Media Manager")){
            MediaManagerHistoryPage page = getSut().getPageCreator().getMMHistoryPage();
            IsPresentInHistory = page.verifyStatusMessage(wrapVariableWithTestSession(clockNumber), status, date);
        }else if(pageName.equals("Media Checker")){
            MediaCheckerHistoryPage page = getSut().getPageCreator().getMCHistoryPage();
            IsPresentInHistory = page.verifyStatusMessage(wrapVariableWithTestSession(clockNumber), status, date);
        }

        assertThat("Status is present in History Page ", IsPresentInHistory, equalTo(shouldState) );
    }

    @When("{I |} click clocknmuber '$clock' link")
    public void clickClockNumber(String clock){
        getSut().getPageCreator().getMMHistoryPage().clickClockNumberLink(wrapVariableWithTestSession(clock));
    }


    @Then("{I |}am able to navigate between the pages in History page")
    public void verifyPagenavigationInUploaderHistory() {
        String[] values = getSut().getPageCreator().getMMHistoryPage().clicknavigatorRight();
        assertThat("Pagination right does not happen ", values[0], lessThan(values[1]));
        values = getSut().getPageCreator().getMMUploadPage().clicknavigatorLeft();
        assertThat("Pagination right does not happen ", values[0], greaterThan(values[1]));
    }

    @Then("{I | }should see following pagination sizes with default size '$size' in the dropdown in MM History page:$data")
    public void checkFilesPerPageSizeInMMHistoryPage(String size, ExamplesTable data) {
        List<String> sizes = getSut().getPageCreator().getMMHistoryPage().getPaginationSizesPage(size);
        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            assertThat(sizes.get(i), containsString(row.get("PaginationSize")));
        }

    }

    @Then("{I |}should see the number of results displayed per MM history page is '$number'")
    public void checkResultsInHistoryPage(String number) {
        assertThat("Number of files displayed ", getSut().getPageCreator().getMMHistoryPage().numberOfResultsDisplayed(), equalTo(Integer.parseInt(number)));

    }
}
