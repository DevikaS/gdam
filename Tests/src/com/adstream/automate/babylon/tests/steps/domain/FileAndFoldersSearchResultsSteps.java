package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFilesAndFoldersSearchResultPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.isIn;
import static org.hamcrest.Matchers.not;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 06.12.12
 * Time: 14:28

 */
public class FileAndFoldersSearchResultsSteps extends BaseStep {

    // | FolderName | FileName | ShouldState |
    @Then("I should see following folders and files for user '$userPlan' project '$projectName' after search on the page: $searchObjects")
    public void checkSearchObjects(String userPlan, String projectName, ExamplesTable searchObjects) {
        AdbankFilesAndFoldersSearchResultPage filesAndFoldersSearchResultPage = getSut().getPageCreator().getFilesAndFoldersSearchResultPage();
        User user;
        if (!userPlan.isEmpty()) user= getData().getUserByType(userPlan);
        else user= getData().getCurrentUser();
        String projectId= getCoreApi(user).getProjectByName(wrapVariableWithTestSession(projectName)).getId();
        filesAndFoldersSearchResultPage.parseObjectsList();
        for (int i = 0 ; i < searchObjects.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(searchObjects, i);
            boolean shouldState = row.get("ShouldState") != null && row.get("ShouldState").equalsIgnoreCase("should");
            Content folder = null;
            if (row.get("FolderName")!=null && !row.get("FolderName").isEmpty()) {
                String path = wrapPathWithTestSession(normalizePath(row.get("FolderName")));
                folder = getCoreApi(user).createFolderRecursive(path, projectId, projectId);
                assertThat(folder.getId(), shouldState ? isIn(filesAndFoldersSearchResultPage.getFoldersId()) : not(isIn(filesAndFoldersSearchResultPage.getFoldersId())));
            }
            if (row.get("FileName")!=null && !row.get("FileName").isEmpty()) {
                Content file = getCoreApi(user).getFileByName(folder.getId(), row.get("FileName"));
                assertThat(file.getId(), shouldState ? isIn(filesAndFoldersSearchResultPage.getFilesId()) : not(isIn(filesAndFoldersSearchResultPage.getFilesId())));
            }
        }
    }

}
