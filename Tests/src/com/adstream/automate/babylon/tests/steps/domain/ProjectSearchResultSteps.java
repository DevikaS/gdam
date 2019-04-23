package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFilesAndFoldersSearchResultPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectSearchResultPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankTemplateSearchResultPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 03.10.12
 * Time: 15:07

 */
public class ProjectSearchResultSteps  extends BaseStep {

    @When("{I |}select Item Per Page '$value' on '$searchPage' search page")
    public void selectItemPerPageForProjectSearchResult(String value, String searchPage) {
        getSearchPageByName(searchPage).selectObjectsCountOnPage(value);
    }

    @Then("{I |}should see following count '$count' of total {projects|files|assets} on search result page")
    public void checkCountOfTotalProjects(int count) {
        int actualState = getSut().getPageCreator().getProjectSearchResultPage().getCountOfTotalProject();
        assertThat(String.format("Wrong number of total projects, on search result page: %d, but should be %d", actualState, count), count == actualState);
    }

    @Then("{I |}'$condition' see Item Per Page with selected value '$expectedValue' by default on '$searchPage' search page")
    public void checkItemPerPageSelectedValueOnProjectSearchResult(String condition, String expectedValue, String searchPage) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualValue = getSearchPageByName(searchPage).getItemPerPageSelectedValue();

        assertThat(actualValue, shouldState ? equalTo(expectedValue) : not(equalTo(expectedValue)));
    }

    @Then("{I |}'$condition' see Item Per Page with available values '$values' on '$searchPage' search page")
    public void checkItemPerPageAvailableValuesOnProjectSearchResult(String condition, String values, String searchPage) {
        List<String> actualValues = getSearchPageByName(searchPage).getItemPerPageAvailableValues();
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> expectedValues = new ArrayList<String>();
        Collections.addAll(expectedValues, values.split(","));

        assertThat(actualValues, shouldState ? equalTo(expectedValues) : not(equalTo(expectedValues)));
    }

    @Then("{I |}should see items count '$count' on the project search page")
    public void checkCountOfItemsOnProjectSearchPage(String count) {
        AdbankProjectSearchResultPage projectSearchResultPage = getSut().getPageCreator().getProjectSearchResultPage();
        assertThat(projectSearchResultPage.getItemsCount(), equalTo(Integer.parseInt(count)));
    }

    @Then("{I |}'$condition' see following projects on the project search page '$projectName'")
    public void checkProjectsOnThePage(String condition, String projectName) {
        AdbankProjectSearchResultPage projectSearchResultPage = getSut().getPageCreator().getProjectSearchResultPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (String pN: projectName.split(",")) {
            Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(pN));
            assertThat(projectSearchResultPage.getObjectsId(), shouldState ? hasItem(project.getId()) : not(hasItem(project.getId())));
        }
    }

    @Then("{I |}'$condition' see following templates on the template search page '$templateName'")
    public void checkTemplatesOnThePage(String condition, String templateName) {
        AdbankTemplateSearchResultPage templateSearchResultPage = getSut().getPageCreator().getTemplateSearchResultPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (String tN: templateName.split(",")) {
            Project template = getCoreApi().getTemplateByName(wrapVariableWithTestSession(tN));
            assertThat(templateSearchResultPage.getObjectsId(), shouldState ? hasItem(template.getId()) : not(hasItem(template.getId())));
        }
    }

    @Then("I '$condition' see following files & folders on the search page '$objectName' for object '$type'")
    public void checkFFOnThePage(String condition, String objectName, String type) {
        AdbankFilesAndFoldersSearchResultPage filesAndFoldersSearchResultPage = getSut().getPageCreator().getFilesAndFoldersSearchResultPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        if (type.equalsIgnoreCase("Folder")) objectName = wrapVariableWithTestSession(objectName);
        for (String oN: objectName.split(",")) {
            assertThat(oN, isIn(filesAndFoldersSearchResultPage.getAllItems()));
        }
    }

    @When("{I |}select business unit '$businessUnit' on projects search result page")
    public void selectBusinessUnit(String businessUnit) {
        getSut().getPageCreator().getFilesAndFoldersSearchResultPage()
                .selectBusinessUnit(wrapAgencyName(businessUnit));
    }

    private AdbankPaginator getSearchPageByName(String searchPage) {
        if (searchPage.equalsIgnoreCase("project")) {
            return getSut().getPageCreator().getProjectSearchResultPage();
        } else if (searchPage.equalsIgnoreCase("template")) {
            return getSut().getPageCreator().getTemplateSearchResultPage();
        } else if (searchPage.equalsIgnoreCase("files and folders")) {
            return getSut().getPageCreator().getFilesAndFoldersSearchResultPage();
        }

        throw new IllegalArgumentException(String.format("Unknown search page '%s'", searchPage));
    }

}
