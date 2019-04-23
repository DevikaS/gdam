package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.XmppClient;
import com.google.gson.Gson;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.By;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: ruslan.semerenko
 * Date: 27.08.13 18:19
 */
public class XmppSteps extends ProjectFolderSteps {

    @Then("I should see message in jabber for file '$fileName' from folder '$folderPath' project '$projectName'")
    public void checkFileMessage(String fileName, String folderPath, String projectName) {
        Project project = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = createFolderOverCoreApi(folderPath, projectName);
        Content file = getCoreApi().getFileByName(folder.getId(), fileName);
        checkMessage(file, project, folderPath);

    }

    @Then("I should see message in jabber for asset '$assetName' from collection '$collectionName'")
    public void checkAssetMessage(String assetName, String collectionName) {
        AssetFilter category = getCoreApi().getAssetsFilterByName(collectionName, "");
        Content asset = getCoreApi().getAssetByName(category.getId(), assetName);
        checkMessage(asset, null, null);
    }

    @Then("I should see message in jabber for the following files from folder '$folderPath' project '$projectName': $filesTable")
    public void checkFileMessageForMultipleFiles(String folderPath, String projectName, ExamplesTable filesTable) {
        for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            Project project = getObjectByName(wrapVariableWithTestSession(projectName));
            Content folder = createFolderOverCoreApi(folderPath, projectName);
            checkMessageForMultipleFiles(row.get("FileName"),project, folderPath);
        }
    }

    @Then("I see the following files downloaded in jabber from folder '$folderPath' project '$projectName': $filesTable")
    public void checkFilesDownload(String folderPath, String projectName, ExamplesTable filesTable) {
        for (int i = 0; i < filesTable.getRowCount(); i++) {

            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            boolean expectedState = row.get("Should").equals("should");
            Project project = getObjectByName(wrapVariableWithTestSession(projectName));
            Content folder = createFolderOverCoreApi(folderPath, projectName);
            boolean actualState= checkFilesDownloaded(row.get("FileName"), project, folderPath);
            assertThat(actualState, is(expectedState));
        }
    }


    @When("I download the folder '$folderPath' or project '$projectName' using sendplus middle tier api: $filesTable")
    public void verifyProjectAndFolderDownloadViaSendplus(String folderPath, String projectName, ExamplesTable filesTable) throws IOException {

       for (int i = 0; i < filesTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(filesTable, i);
            Project project = getObjectByName(wrapVariableWithTestSession(projectName));
            Content folder = createFolderOverCoreApi(folderPath, projectName);
            HashMap<String, String>  fileDetails = getElementIdAndFileIdFromXmppForFile(row.get("FileName"), project, folderPath);
            downloadFolderAndProjectViaSendplus(fileDetails.get("ElementID"), fileDetails.get("FileID"));
        }


    }

    private boolean checkFilesDownloaded(String filename, Project project, String folderPath) {
        boolean flag=false;
        String jsonmessage = getLastMessage(project.getName(), folderPath);
        Map mygson = new Gson().fromJson(jsonmessage, Map.class);
        String fileObjectName = "fileName";
        String targetFileName = filename ;
        Iterator<Map> iterator = ((Map)mygson.get("files")).keySet().iterator();
        Object match=null;
        while (iterator.hasNext()) {
            match = iterator.next();
            if (((Map)((Map)mygson.get("files")).get(match)).get(fileObjectName).toString().equalsIgnoreCase(targetFileName)){
                flag=true;
                break;
            }
        }
        return flag;
    }


    private String getLastMessage(String proj, String fold) {
        User user = getData().getCurrentUser();
        XmppClient client = new XmppClient(getContext().xmppHost, getContext().xmppPort, getContext().xmppDomain);
        boolean isLogged = client.login(user.getEmail(), user.getPassword());
        if (!isLogged) {
            throw new IllegalStateException(String.format("Could not login into jabber for user '%s'", user.getEmail()));
        }
        long deadline = System.currentTimeMillis() + 30 * 1000; // 30 secs
        if (client.getMessages().size() == 0) {
            By elementLocatorDownloadMasterUsingSendplus = getSut().getUIMap().getByPageName("FileInfoPage", "DownloadMasterUsingSendplus");
            if (getSut().getWebDriver().isElementVisible(elementLocatorDownloadMasterUsingSendplus)) {
                getSut().getWebDriver().click(elementLocatorDownloadMasterUsingSendplus);
                Common.sleep(3000);
                By elementLocatorConfirmAlert = getSut().getUIMap().getByPageName("FileInfoPage", "ConfirmDownloadMasterUsingSendplus");
                getSut().getWebDriver().click(elementLocatorConfirmAlert);
            } else {
                downloadBySendplusFromFolder(proj, fold);
            }
        }
        while (client.getMessages().size() == 0) {
            if (System.currentTimeMillis() > deadline) {
                throw new RuntimeException("Timeout while waiting for message in jabber");
            }
            Common.sleep(100);
        }
        client.logout();
        return client.getMessages().get(client.getMessages().size() - 1).getBody();
    }

    private CustomMetadata parseMessage(String message) {

        return new Gson().fromJson(message, CustomMetadata.class);
    }

    private String getDownloadUrl(Content file) {

        StringBuilder url = new StringBuilder("/yadn-info/");
        url.append(file.getId()).append("/");
        url.append(file.getLastRevision().getMaster().getFileID()).append("?saveAs=").append(file.getName());
        return url.toString();
    }

    private void checkMessage(Content file, Project project, String folderPath) {
        String url = getDownloadUrl(file);
        CustomMetadata cm = parseMessage(getLastMessage("",""));
        CustomMetadata fileCm = cm.getOrCreateNode("files").getOrCreateNode("0");
        CustomMetadata fileInfoCm = fileCm.getOrCreateNode("remoteInfo");
        assertThat(cm.getString("description"), equalTo("Files from Adbank"));
        assertThat(cm.getString("errorString"), equalTo(""));
        assertThat(fileCm.getString("fileName"), equalTo(file.getName()));
        assertThat(fileInfoCm.getOrCreateNode("remoteProgress").getLong(file.getName()),
                equalTo(file.getLastRevision().getMaster().getFileSize()));
        assertThat(fileCm.getLong("totalBytes"), equalTo(file.getLastRevision().getMaster().getFileSize()));
        assertThat(fileCm.getString("url"), equalTo("0"));
        assertThat(fileCm.getString("fileId"), equalTo(file.getLastRevision().getMaster().getFileID()));
        assertThat(fileCm.getString("elementId"), equalTo(file.getId()));
        String namePrefix = "/";
        if (project != null && folderPath != null) {
            String rootFolder=project.getName();
            namePrefix = project.getName() + "/" + rootFolder + "/" + normalizePath(wrapPathWithTestSession(folderPath)) + "/";
        }
        assertThat(cm.getString("name"), equalTo(namePrefix + file.getName()));
        assertThat(cm.getString("sender"), equalTo("adbank\\40adstream.com@adstream"));
        assertThat(Math.abs(cm.getLong("started") - System.currentTimeMillis()), lessThan(5 * 60 * 1000L)); // 5 minutes
        assertThat(cm.getString("status"), equalTo("pending"));

    }

    private void checkMessageForMultipleFiles(String filename, Project project, String folderPath) {
        String jsonmessage = getLastMessage(project.getName(), folderPath);
        CustomMetadata cm = parseMessage(jsonmessage);
        Map mygson = new Gson().fromJson(jsonmessage, Map.class);
        String fileObjectName = "fileName";
        String targetFileName = filename ;
        Iterator<Map> iterator = ((Map)mygson.get("files")).keySet().iterator();
        Object match=null;
        while (iterator.hasNext()) {
            match = iterator.next();
            if (((Map)((Map)mygson.get("files")).get(match)).get(fileObjectName).toString().equalsIgnoreCase(targetFileName)){
                break;

            }
        }
        Integer matchKey = Integer.parseInt((String) match);
        String key = Integer.toString(matchKey);
        CustomMetadata fileCm = cm.getOrCreateNode("files").getOrCreateNode(key);
        CustomMetadata fileInfoCm = fileCm.getOrCreateNode("remoteInfo");
        assertThat(cm.getString("description"), equalTo("Files from Adbank"));
        assertThat(cm.getString("errorString"), equalTo(""));
        assertThat(fileCm.getString("fileName"), equalTo(targetFileName));
        assertThat(fileCm.getString("url"), equalTo(key));
        String namePrefix = "/";
        if (project != null && folderPath != null) {
            String rootFolder=project.getName();
            namePrefix = project.getName() + "/" + rootFolder + "/" + normalizePath(wrapPathWithTestSession(folderPath));
        }
        assertThat(cm.getString("name"), equalTo(namePrefix));
        assertThat(fileCm.getString("relativePath"), equalTo(namePrefix));
        assertThat(cm.getString("sender"), equalTo("adbank\\40adstream.com@adstream"));
        assertThat(cm.getString("status"), equalTo("pending"));
    }

    public HashMap<String, String> getElementIdAndFileIdFromXmppForFile(String filename, Project project, String folderPath)
    {
        HashMap<String, String> fileInfo = new HashMap<String, String>();
        String jsonmessage = getLastMessage(project.getName(), folderPath);
        CustomMetadata cm = parseMessage(jsonmessage);
        Map mygson = new Gson().fromJson(jsonmessage, Map.class);
        String fileObjectName = "fileName";
        String targetFileName = filename ;
        Iterator<Map> iterator = ((Map)mygson.get("files")).keySet().iterator();
        Object match=null;
        while (iterator.hasNext()) {
            match = iterator.next();
            if (((Map)((Map)mygson.get("files")).get(match)).get(fileObjectName).toString().equalsIgnoreCase(targetFileName)){
                break;

            }
        }
        Integer matchKey = Integer.parseInt((String) match);
        String key = Integer.toString(matchKey);
        CustomMetadata fileCm = cm.getOrCreateNode("files").getOrCreateNode(key);
        fileInfo.put("ElementID", fileCm.getString("elementId"));
        fileInfo.put("FileID", fileCm.getString("fileId"));
        return fileInfo;
    }



}
