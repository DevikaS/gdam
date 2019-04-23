package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.FilePreview;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankProjectTabs;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 15.09.12 15:49
 */
public abstract class AbstractProjectTabsSteps extends BaseStep implements ProjectActivity {
    // additional private field, for set up expected activity in each implemented method
    // from ProjectActivity interface
    private String expectedActivity;

    protected abstract Project getObjectByName(String objectName);

    protected abstract Project getObjectByName(String objectName, User user);

    @Deprecated
    protected void checkActivity(AdbankProjectTabs page, boolean should, String userName, String message, String value){
        List<String> activities = page.getLastActivities();
        //todo add check datatime activity through api
        String expectedActivity = createActivity(userName, message, value);
        if (should)
            assertThat(activities, hasItem(expectedActivity));
        else
            assertThat(activities, not(hasItem(expectedActivity)));
    }

    /**
     * Method checking activity like: 'user1@test.com has shared project to Erick Cartman (user2@test.com) SouthParkProject'
     * Projects/Templates/Work requests/Work request templates.
     *
     * @param page here we detect which one kind page we are using now: Projects, templates etc...
     * @param condition should state
     * @param sender User name(email)
     * @param project Project name
     * @param recipient User name(email)
     */
    protected void checkProjectShareActivity(AdbankProjectTabs page, String condition, String sender, String project, String recipient){
        boolean shouldState = condition.equalsIgnoreCase("should");
        sharedProjectToUserActivity(null, sender, project, recipient);
        assertThat(getActualActivities(page), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    /**
     * Method need for checking activity like: 'Erik Cartman uploaded file /folder/file1.jpg' in our Object such us:
     * Projects/Templates/Work requests/Work request templates.
     *
     * @param page here we detect which one kind page we are using now: Projects, templates etc...
     * @param condition should state
     * @param uploader User name(email) who uploaded
     * @param filePath path to file, like: /ParentFolder/ChildFolder/fil1.jpg
     */
    protected void checkUploadFileActivity(AdbankProjectTabs page, String condition, String uploader, String filePath) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        uploadFileActivity(null, uploader, filePath);
        assertThat(getActualActivities(page), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    /**
     * Method need for checking activity like: 'Erik Cartman created project SouthParkProject' in our Object such us:
     * Projects/Templates/Work requests/Work request templates.
     *
     * @param page here we detect which one kind page we are using now: Projects, templates etc...
     * @param condition should state
     * @param author User name(email) who created project
     * @param projectName project name
     */
    protected void checkCreateObject(AdbankProjectTabs page, String condition, String author, String projectName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        createObject(null, author, projectName);
        assertThat(getActualActivities(page), shouldState ? hasItem(expectedActivity) : not(hasItem(expectedActivity)));
    }

    /**
     * Method which need to get all last activities on Object page (Projects/Templates/Work requests/WR templates)
     * @param page kind of object
     * @return list of all activities
     */
    private List<String> getActualActivities(AdbankProjectTabs page) {
        return page.getLastActivities();
    }

    protected void checkActivities(AdbankProjectTabs page, ExamplesTable activitiesTable, boolean sorted) {
        List<String> activities = page.getLastActivities();
        List<String> expectedActivities = new ArrayList<>();
        for (int i = 0; i < activitiesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(activitiesTable, i);
            expectedActivities.add(createActivity(row.get("UserName"), row.get("Message"), row.get("Value")));
        }
        if (sorted)
            assertThat(activities, equalTo(expectedActivities));
        else
            for (String expectedActivity : expectedActivities) {
                assertThat(activities, hasItem(expectedActivity));
            }
    }

    protected void checkSortingForProjectActivities(AdbankProjectTabs page, ExamplesTable activitiesTable) {
        List<String> activities = page.getLastActivities();
        List<String> expectedActivities = new ArrayList<>();
        for (int i = 0; i < activitiesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(activitiesTable, i);
            if (row.get("Message").equalsIgnoreCase("shared folder")) {
                sharedProjectToUserActivity("should", row.get("UserName"), row.get("Value"), row.get("UserName"));
                expectedActivities.add(expectedActivity);
            } else {
                expectedActivities.add(createActivity(row.get("UserName"), row.get("Message"), row.get("Value")));
            }
        }
        assertThat(activities, equalTo(expectedActivities));
    }


    @Deprecated
    protected String createActivity(String userName, String message, String value) {
        if (message.equals("created project")
                || message.equals("created folder")
                || message.equals("published project")
                || message.equals("updated project")
                || message.equals("clone the project")
                || message.equals("created the template")
                || message.equals("updated the template")
                || message.equals("clone the template")
                || message.equals("hat Projekt erstellt")
                || message.equals("a créé le projet")
                || message.equals("creó el proyecto")
                || message.equals("proyecto creado")
                || message.equals("downloaded folder")) {
            value = wrapVariableWithTestSession(value);
        } else if (message.startsWith("copied file") || message.startsWith("copied the file")
                || message.startsWith("moved file") || message.startsWith("moved the file")) {
            String quoteSymbol = message.contains("'") ? "'" : "\"";
            String[] parts = message.split(quoteSymbol);
            StringBuilder str = new StringBuilder();
            parts[1] = wrapPathWithTestSession(parts[1]);
            parts[3] = wrapPathWithTestSession(parts[3]);
            str.append(parts[0]).append(quoteSymbol).append(parts[1]).append(quoteSymbol);
            str.append(parts[2]).append(quoteSymbol).append(parts[3]).append(quoteSymbol);
            message = str.toString();
        } else if (message.startsWith("shared file with")) {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(message.replaceAll("shared file with\\s*(.*)\\s*", "$1")));
            message = String.format("shared file with %s", user.getEmail());
        } else if (message.startsWith("uploaded") || message.startsWith("downloaded") || message.startsWith("played")) {
            int lastSlashIndex = value.lastIndexOf("/");
            if (lastSlashIndex >= 0) {
                String path = value.substring(0, lastSlashIndex);
                String file = value.substring(lastSlashIndex);
                value = wrapPathWithTestSession(path) + file;
            }
        }
        User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));
        return String.format("%s %s %s", user.getFullName(), message, value).trim();
    }

    protected Content createFolderOverCoreApi(String path, String objectName) {
        path = normalizePath(path);
        if (path.isEmpty())
            return null;
        path = (path.equalsIgnoreCase("Originals")) ? path : wrapPathWithTestSession(path);
        Project project = getObjectByName(wrapVariableWithTestSession(objectName));
        return getCoreApi().createFolderRecursive(path, project.getId(), project.getId());
    }

    protected Content createFolderOverCoreApi(String path, String objectName, User user) {
        path = normalizePath(path);
        if (path.isEmpty()) return null;
        path = wrapPathWithTestSession(path);
        Project project = getObjectByName(wrapVariableWithTestSession(objectName), user);
        return getCoreApi(user).createFolderRecursive(path, project.getId(), project.getId());
    }

    protected DateTime parseDateTime(String date) {
        return parseDateTime(date, TestsContext.getInstance().storiesDateTimeFormat);
    }

    protected String getRevisionProxyFileId(String fileName, String path, String projectName, int revision){
        return getRevisionPreviewFileId(fileName, path, projectName, revision, "proxy");
    }

    protected String getRevisionThumbnailFileId(String fileName, String path, String projectName, int revision){
        return getRevisionPreviewFileId(fileName, path, projectName, revision, "thumbnail");
    }

    private String getRevisionPreviewFileId(String fileName, String path, String projectName, int revision, String previewType) {
        Project fsObject = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        List<FilePreview> previews = file.getRevisions()[revision - 1].getPreview();

        for (FilePreview preview : previews){
            if (preview.getA5Type().contains(previewType)){
                return preview.getFileID();
            }
        }
        return null;
    }

    @Override
    public void sharedProjectToUserActivity(String shouldState, String sender, String project, String recipient) {
        String senderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(sender)).getFullName();
        String recipientFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(recipient)).getFullName();
        expectedActivity =
            String.format("%s has shared project to %s (%s) %s",
                senderFullName,
                recipientFullName,
                wrapUserEmailWithTestSession(recipient),
                wrapVariableWithTestSession(project));
    }

    @Override
    public void uploadFileActivity(String condition, String uploaderEmail, String filePath) {
        String uploaderFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(uploaderEmail)).getFullName();
        filePath = wrapPathWithTestSession(filePath);
        expectedActivity = String.format("%s uploaded file %s", uploaderFullName, filePath);
    }

    @Override
    public void createObject(String condition, String author, String objectName) {
        String authorFullName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(author)).getFullName();
        objectName = wrapVariableWithTestSession(objectName);
        expectedActivity = String.format("%s created project %s", authorFullName, objectName);
    }

    @Override
    public void updateObject(String condition, String author, String objectName) {

    }

    @Override
    public void downloadMasterFile(String condition, String uploader, String filePath) {

    }

    @Override
    public void sharedFileToUser(String condition, String sharedUserEmail, String fileName, String recipientEmail) {

    }

    @Override
    public void sharedForApproval(String condition, String sharedUserEmail, String fileName) {

    }

    @Override
    public void movedFileFromFolderToFolder(String condition, String movedUserEmail, String folderName, String toFolderName, String fileName) {

    }

    @Override
    public void sharedFolderToUserActivity(String shouldState, String sender, String file, String recipient) {

    }

    @Override
    public void createFolder(String condition, String author, String folderName) {

    }

    @Override
    public void viewedActivity(String condition, String viewerFullName) {

    }
}