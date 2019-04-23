package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.approvals.*;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.model.ExamplesTable;

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.hasItem;

/**
 * User: reznik-d
 * Date: 15.03.13
 * Time: 13:17
 */
public class ProjectApprovalsSteps extends AbstractProjectTabsSteps {

    @Override
    protected Project getObjectByName(String projectName) {
        return getCoreApi().getProjectByName(projectName);
    }

    @Override
    protected Project getObjectByName(String projectName, User user) {
        return getCoreApi(user).getProjectByName(projectName);
    }

    @Given("{I am |}on project '$project' approvals received page")
    @When("{I |}go to project '$project' approvals received page")
    public AdbankProjectApprovalsReceivedPage openProjectApprovalsReceivedPage(Project project) {
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getProjectApprovalsReceivedPage(project.getId());
    }

    @Given("{I am |}on project '$project' approvals submitted page")
    @When("{I |}go to project '$project' approvals submitted page")
    public AdbankProjectApprovalsSubmittedPage openProjectApprovalsSubmittedPage(Project project) {
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getProjectApprovalsSubmittedPage(project.getId());
    }

    @Given("{I am |}on project '$project' approvals not started page")
    @When("{I |}go to project '$project' approvals not started page")
    public AdbankProjectApprovalsNotStartedPage openProjectApprovalsNotStartedPage(Project project) {
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getProjectApprovalsNotStartedPage(project.getId());
    }

    @Given("{I am |}on projects approvals received page")
    @When("{I |}go to projects approvals received page")
    public AdbankProjectsApprovalsReceivedPage openProjectsApprovalsReceivedPage() {
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getProjectsApprovalsReceivedPage();
    }

    @Given("{I am |}on projects approvals submitted page")
    @When("{I |}go to projects approvals submitted page")
    public AdbankProjectsApprovalsSubmittedPage openProjectsApprovalsSubmittedPage() {
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getProjectsApprovalsSubmittedPage();
    }

    @Given("{I am |}on projects approvals not started page")
    @When("{I |}go to projects approvals not started page")
    public AdbankProjectsApprovalsNotStartedPage openProjectsApprovalsNotStartedPage() {
        getSut().getWebDriver().navigate().refresh();
        return getSut().getPageNavigator().getProjectsApprovalsNotStartedPage();
    }

    @When("{I |}select approval by file name '$fileName' from folder '$path' and project '$projectName' on opened approvals page")
    public void selectApproval(String fileName, String path, String projectName) {
        String fileId = getCoreApi().getFileByName(createFolderOverCoreApi(path, projectName).getId(), fileName).getId();
        getSut().getPageCreator().getProjectsApprovalsReceivedPage().selectApprovalByFileId(fileId);
    }

    @When("{I |}select '$fileName' file(s) from folder '$path' and project '$projectName' on opened approvals page")
    public void selectFilesOnProjectApprovalTab(String fileName,String path, String projectName) {
        AdbankProjectApprovalsPage adbankProjectApprovalsPage = getSut().getPageCreator().getProjectApprovalsNotStartedPage();
        String [] fileNames = fileName.split(",");
        String [] fileId = new String[fileNames.length];
        for (int i = 0; i <fileNames.length ; i++) {
            fileId[i] = getCoreApi().getFileByName(createFolderOverCoreApi(path, projectName).getId(), fileNames[i]).getId();
            adbankProjectApprovalsPage.selectApprovalByFileId(fileId[i]);
        }
    }

    @When ("{I |}click start button on opened approvals not started page")
    public void clickByStartButton(){
        getSut().getPageCreator().getProjectApprovalsNotStartedPage().clickStartButton();
    }

    @When("{I |}click open selected button on approvals page")
    public void clickByOpenSelectedButton() {
        getSut().getPageCreator().getProjectsApprovalsSubmittedPage().clickOpenSelectedButton();
    }

    @When("{I |}'$action' selected approvals on opened approvals page")
    public void clickApproveOrRejectButton(String action) {
        if (action.equalsIgnoreCase("approve")) {
            getSut().getPageCreator().getProjectsApprovalsReceivedPage().clickApproveButton().apply.click();
        } else if (action.equalsIgnoreCase("reject")) {
            getSut().getPageCreator().getProjectsApprovalsReceivedPage().clickRejectButton().apply.click();
        } else {
            throw new IllegalArgumentException(String.format("Unknown approvals action '%s'", action));
        }

        Common.sleep(2000);
    }

    @When("{I |}select client '$client' on opened project approvals page")
    public void selectClientOnProjectApprovalsPage(String client){
        getSut().getPageCreator().getProjectsApprovalsReceivedPage().selectClient(wrapVariableWithTestSession(client));
    }

    @When("{I |}check '$checkBoxName' checkbox in Approval Status area on opened project approvals page")
    public void checkOnProjectApprovalsPage(String name){
        getSut().getPageCreator().getProjectsApprovalsReceivedPage().selectApprovalStatusAdditionalCheckbox(name);
    }

    @When("{I |}uncheck '$checkBoxName' checkbox in Approval Status area on opened project approvals page")
    public void uncheckOnProjectApprovalsPage(String name){
        getSut().getPageCreator().getProjectsApprovalsReceivedPage().deselectApprovalStatusAdditionalCheckbox(name);
    }

    @When("{I |}select approval status '$status' on opened project approvals page")
    public void selectApprovalStatusOnProjectApprovalsPage(String status){
        getSut().getPageCreator().getProjectsApprovalsReceivedPage().selectApprovalStatus(status);
    }

    @When("{I |}select mediatype '$mediaType' on opened project approvals page")
    public void selectMediaTypeOnProjectApprovalsPage(String mediaType){
        getSut().getPageCreator().getProjectsApprovalsReceivedPage().selectMediaType(mediaType);
    }

    @When("{I |}select Date range for '$rangeType' from '$fromDate' to '$toDate' on opened project approvals page")
    public void selectDateRangeOnProjectApprovalsPage(String rangeType, String fromDate, String toDate){
        AdbankProjectsApprovalsPage page = getSut().getPageCreator().getProjectsApprovalsReceivedPage();

        if (rangeType.equalsIgnoreCase("Sent Date")) {
            page.tickSentDate();
        } else if (rangeType.equalsIgnoreCase("Due Date")) {
            page.tickDueDate();
        } else {
            throw new IllegalArgumentException(String.format("Unknown Date Range type: '%s'", rangeType));
        }

        page.selectRangeFrom(fromDate);
        Common.sleep(2000);
        page.selectRangeTo(toDate);
    }

    // next | previous
    @When("{I |}navigate to '$position' file on preview file of approvals")
    public void navigateToFile(String position) {
        getSut().getPageCreator().getAdbankProjectApprovalsPreviewFilePage().navigate(position);
    }

    @When("{I |}sort approvals by field '$field' by '$by' on approvals opened received page")
    public void sortByNameOnReceivedPage(String field, String by) {
        getSut().getPageCreator().getProjectsApprovalsReceivedPage().sortColumnNameByOrder(field,by);
    }

    @When("{I |}sort approvals by field '$field' by '$by' on opened approvals submitted page")
    public void sortByNameOnSubmitPage(String field, String by) {
        getSut().getPageCreator().getProjectsApprovalsSubmittedPage().sortColumnNameByOrder(field,by);
    }

    // field: FileName, Project
    // order: asc, desc
    @Then("{I |}should see sorted approvals by field '$field' by '$order' on opened approvals submitted page")
    public void checkSortedResult(String field, String order) {
        AdbankProjectsApprovalsSubmittedPage page = getSut().getPageCreator().getProjectsApprovalsSubmittedPage();
        checkSortingColumnByName(page, field, order);
    }

    // field: FileName, Project
    // order: asc, desc
    @Then("{I |}should see sorted approvals by field '$field' by '$order' on opened approvals received page")
    public void checkSortedResultReceived(String field, String order) {
        AdbankProjectsApprovalsReceivedPage page = getSut().getPageCreator().getProjectsApprovalsReceivedPage();
        checkSortingColumnByName(page, field, order);
    }


    // | FileName | Status | ApprovalStage |
    @Then("{I |}'$condition' see following approvals on opened project approvals page: $data")
    public void checkThatApprovalPresent(String condition, ExamplesTable data){
        boolean shouldState = condition.equals("should");
        List<Map<String,String>> actualApprovals = getSut().getPageCreator().getProjectsApprovalsReceivedPage().getApprovals(data.getHeaders());

        for (Map<String,String> expectedApproval : parametrizeTableRows(data)) {
            if (expectedApproval.get("ApprovalStage") != null)
                expectedApproval.put("ApprovalStage", wrapVariableWithTestSession(expectedApproval.get("ApprovalStage")));

            if (expectedApproval.get("ProjectName") != null)
                expectedApproval.put("ProjectName", wrapVariableWithTestSession(expectedApproval.get("ProjectName")));

            assertThat(actualApprovals, shouldState ? hasItem(expectedApproval) : not(hasItem(expectedApproval)));
        }
    }

    @Then("{I |}'$condition' see following count '$count' of approvals on received page")
    public void checkCountOfApprovalsReceivedPage(String condition, String count) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String actualState = getSut().getPageCreator().getProjectsApprovalsReceivedPage().getCountItems();

        assertThat(actualState, shouldState ? equalTo(count) : not(equalTo(count)));
    }

    @Then("{I |}'$condition' see file names '$fileNames' on opened project approvals page")
    public void checkThatApprovalPresent(String condition, String fileNames){
        boolean shouldState = condition.equals("should");
        List<String> actualFileNames = getSut().getPageCreator().getProjectsApprovalsReceivedPage().getApprovalsFilesNames();

        for (String expectedFileName : fileNames.split(","))
            assertThat(actualFileNames, shouldState ? hasItem(expectedFileName) : not(hasItem(expectedFileName)));
    }

    @Then("{I |}'$condition' see '$files' file on tab '$tab' on project '$project' approvals page")
    public void checkThatApprovalPresentOnTab(String condition, String files, String tab, Project project){
        boolean shouldState = condition.equals("should");
        List<String> actualFileNames = new ArrayList<>();

        if (tab.equalsIgnoreCase("received")) {
            actualFileNames = openProjectApprovalsReceivedPage(project).getFileNames();
        } else if (tab.equalsIgnoreCase("submitted")) {
            actualFileNames = openProjectApprovalsSubmittedPage(project).getFileNames();
        } else if (tab.equalsIgnoreCase("not started")) {
            actualFileNames = openProjectApprovalsNotStartedPage(project).getFileNames();
        }

        for (String expectedFileName : files.split(","))
            assertThat(actualFileNames, shouldState ? hasItem(expectedFileName) : not(hasItem(expectedFileName)));
    }

    @Then("{I |}should be on preview file page of approvals")
    public void checkPreviewPage() {
        getSut().getPageCreator().getAdbankProjectApprovalsPreviewFilePage();
    }

    @Then("{I |}should see following count '$numberOfFiles' files on preview page of approvals")
    public void checkCountFiles(String numberOfFiles) {
        String actualNumberOfFiles = getSut().getPageCreator().getAdbankProjectApprovalsPreviewFilePage().getNumberOfFiles();
        assertThat("Number of files:", numberOfFiles, equalTo(actualNumberOfFiles));
    }

    @Then("{I |}'$should' be on current position '$position' preview of approvals")
    public void checkCurrentPosition(String should, String position) {
        boolean shouldState = should.equalsIgnoreCase("should");
        String currentPosition = getSut().getPageCreator().getAdbankProjectApprovalsPreviewFilePage().getCurrentPositionOnView();
        assertThat(currentPosition, shouldState ? equalTo(position) : not(equalTo(position)));
    }

    @Then("{I |}'$should' see following stages '$stages' on preview of approvals page")
    public void checkStagesOnPreviewApprovalsPage(String should, String stages) {
        boolean shouldState = should.equalsIgnoreCase("should");
        List<String> actualState = getSut().getPageCreator().getAdbankProjectApprovalsPreviewFilePage().getApprovalStageName();

        for (String stage : stages.split(",")) {
            stage = wrapVariableWithTestSession(stage);
            assertThat(actualState, shouldState ? hasItem(stage) : not(hasItem(stage)));
        }
    }

    @Then("{I |}should be on approvals submitted page")
    public void checkOfApprovalsSubmittedPage() {
        getSut().getPageCreator().getProjectApprovalsSubmittedPage();
    }

    @Then("{I |}should be on approvals received page")
    public void checkOfApprovalsReceivedPage() {
        getSut().getPageCreator().getProjectApprovalsReceivedPage();
    }

    @Then("{I |}'$condition' see '$button' button disabled on opened approvals page")
    public void checkThatApproveRejectButtonIsDisabled(String condition, String button) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;

        if (button.equalsIgnoreCase("approve")) {
            actualState = getSut().getPageCreator().getProjectApprovalsReceivedPage().isApproveButtonDisabled();
        } else if (button.equalsIgnoreCase("reject")) {
            actualState = getSut().getPageCreator().getProjectApprovalsReceivedPage().isRejectButtonDisabled();
        } else {
            throw new IllegalArgumentException(String.format("Unknown button '%s' on approvals page", button));
        }

        assertThat(actualState, is(expectedState));
    }
    @Then("{I |}'$condition' see '$clients' clients on opened projects approvals page")
    public void checkClientInTheList(String condition, String clients) {
        boolean shouldState= condition.equalsIgnoreCase("should");

        List<String> actualClients = getSut().getPageCreator().getProjectsApprovalsReceivedPage().getApprovalsClientsNames();
        for (String expectedClientName : clients.split(",")) {
            expectedClientName = wrapVariableWithTestSession(expectedClientName);
            assertThat(actualClients, shouldState ? hasItem(expectedClientName) : not(hasItem(expectedClientName)));
        }

    }

    private void checkSortingColumnByName(AdbankProjectsApprovalsPage page, String field, String order) {
        List<String> actualElements;
        switch (field) {
            case "FileName":
                actualElements = page.getFileNames();
                break;
            case "Project":
                actualElements = page.getProjectNames();
                break;
            default:
                throw new IllegalArgumentException("Unknown field: " + field);
        }
        List<String> expectedElements = new ArrayList<>(actualElements);
        Collections.sort(expectedElements);
        if (order.equals("desc")) {
            Collections.reverse(expectedElements);
        }
        assertThat(actualElements, equalTo(expectedElements));
    }
}