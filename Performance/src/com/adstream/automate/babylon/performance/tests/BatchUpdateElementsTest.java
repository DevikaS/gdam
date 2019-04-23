package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.Identity;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicInteger;

public class BatchUpdateElementsTest extends CreateProjectTest {
    private static Project project;
    private static List<String> parents = new ArrayList<>();
    private static AtomicInteger counter = new AtomicInteger();

    @Override
    public void beforeStart() {
        super.beforeStart();
        if (project == null) {
            project = getService().createProject(getProject());
            getService().addUserToProjectTeam(project.getId(), getTeamPermission(project.getId()));
            parents.add(project.getId());
        }
        List<String> files = new ArrayList<>();
        log.info("Create files");
        for (int folderCounter = 0; folderCounter < 4; folderCounter++) {
            String parent = parents.get(Gen.getInt(parents.size()));
            Content folder = getService().createContent(parent, getFolder(project.getId()));
            parents.add(folder.getId());
            for (int fileCounter = 0; fileCounter < 25; fileCounter++) {
                Content file = uploadFile(new File(getParam("filePath")), folder.getId());
                files.add(file.getId());
            }
        }
        log.info("Wait for transcoding");
        for (String fileId : files) {
            Content file;
            long start = System.currentTimeMillis();
            do {
                file = getService().getContent(fileId);
            } while (file.getLastRevision().getPreview() == null && System.currentTimeMillis() - start < 60000);
        }
        log.info("Preparation done");
    }

    @Override
    public void start() {
        CustomMetadata cm = new CustomMetadata();
        CustomMetadata common = cm.getOrCreateNodeForPath("_cm.common");
        common.put("Campaign", new String[] {""});
        common.put("advertiser", new String[] {"Advertiser"});
        common.put("brand", new String[] {"Brand " + counter.getAndIncrement() % 2});
        common.put("product", new String[] {""});
        common.put("sub_brand", new String[] {""});
        long start = System.currentTimeMillis();
        String processId = getService().batchUpdateElementsMetadata(getCurrentAgency().getId(), project.getId(), cm);
        try {
            getService().batchTaskApi().waitTillDone(processId);
        } catch (TimeoutException e) {
            e.printStackTrace();
        }
        log.info("Batch update finished: " + (System.currentTimeMillis() - start));
        Common.sleep(1000);
    }

    private Content getFolder(String projectId) {
        Content content = new Content();
        content.setProject(new Identity(projectId, null));
        content.setName(Gen.getHumanReadableString(6, true));
        content.setSubtype("folder");
        return content;
    }
}
