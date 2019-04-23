package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.approval.ApprovalStage;
import com.adstream.automate.babylon.JsonObjects.approval.StageReminder;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import java.io.File;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * User: ruslan.semerenko
 * Date: 22.06.13 17:59
 */
public class CreateApprovalTest extends CreateFileTest {
    protected static User submitter;
    protected static List<String> allFiles = new LinkedList<>();
    protected static List<Content> transcodedFiles = new ArrayList<>();
    protected static List<String> approvers = new ArrayList<>();
    protected static volatile Map<String, String> filesWithApproval = new ConcurrentHashMap<>();

    @Override
    public void runOnce() {
        logIn(getParam("login"), getParam("password"));
        submitter = getService().createUser(getCurrentAgency().getId(), getUser());
        for (int i = 0 ; i < 100; i++) {
            approvers.add(getService().createUser(getCurrentAgency().getId(), getUser()).getId());
            if (i % 10 == 9) {
                log.info(String.format("Created %d users", i + 1));
            }
        }
        for (int i = 0; i < 10; i++) {
            Project project = getService().createProject(getProject());
            Role role = getRoleByName("project.admin");
            TeamPermission ownerPermission = new TeamPermission(project.getId(), getParam("login"), role.getId(), true, null);
            getService().addUserToProjectTeam(new TeamPermission[] {ownerPermission});
            for (int j = 0; j < 3; j++) {
                Content folder = getService().createContent(project.getId(), getFolder(project.getId()));
                for (int k = 0; k < 3; k++) {
                    Content file = uploadFile(new File(getParam("filePath")), folder.getId());
                    allFiles.add(file.getId());
                }
                Role roleContributor = getRoleByName("project.contributor");
                TeamPermission contributorPermission =
                        new TeamPermission(folder.getId(), submitter.getEmail(), roleContributor.getId(), true, null);
                getService().addUserToProjectTeam(project.getId(), new TeamPermission[] {contributorPermission});
            }
            if (i % 10 == 9) {
                log.info(String.format("Created %d projects", i + 1));
            }
        }
    }

    @Override
    public void beforeStart() {
        logIn(submitter.getEmail(), "1");
        int transcodedFilesCount = transcodedFiles.size();
        for (int i = 0; i < 80 - transcodedFilesCount; i++) {
            Content file;
            do {
                String fileId = allFiles.get(Gen.getInt(allFiles.size()));
                file = getService().getContent(fileId);
            } while (file.getLastRevision().getPreview() == null);
            transcodedFiles.add(file);
            allFiles.remove(file.getId());
            if (i % 10 == 9) {
                log.info(String.format("Found %d transcoded files", i + 1));
            }
        }
    }

    @Override
    public void start() {
        Content file = transcodedFiles.get(Gen.getInt(transcodedFiles.size()));
        String approvalId = filesWithApproval.get(file.getId());
        ApprovalStage stage = getStage(file, approvalId);

        String approvalIdFromServer =
                getService().createApprovalStage(file.getId(), file.getLastRevision().getMaster().getFileID(), stage);
        if (approvalId == null) {
            filesWithApproval.put(file.getId(), approvalIdFromServer);
        }
    }

    @Override
    public void afterRun() {
    }

    private ApprovalStage getStage(Content file, String approvalId) {
        String previewId = file.getLastRevision().getPreview().get(0).getFileID();
        String masterId = file.getLastRevision().getMaster().getFileID();

        List<String> membersIds = new ArrayList<>();
        membersIds.add(approvers.get(Gen.getInt(approvers.size())));

        Map<String, String> metadata = new HashMap<>();
        metadata.put("previewFileId", previewId);

        ApprovalStage stage = new ApprovalStage();
        stage.setName(Gen.getHumanReadableString(6, true));
        stage.setApprovalType("WaitAll");
        stage.setDescription(Gen.getHumanReadableString(6, true));
        stage.setMembersIds(membersIds);
        stage.setOwners(new ArrayList<>());
        stage.setYadnFileId(masterId);
        stage.setEntityName(file.getName());
        stage.setProjectName(file.getProject().getId());
        stage.setEntityType("image");
        stage.setShortId("3f");
        stage.setProjectId(file.getProject().getId());
        stage.setFolderId(file.getParents()[0]);
        stage.setMetadata(metadata);
        stage.setDeadline(new StageReminder() {{setDate(new DateTime().plusDays(2));}});
        stage.setReminder(new StageReminder() {{setDate(new DateTime().plusDays(1));}});
        stage.setStartImmediately(true);
        if (approvalId != null) {
            stage.setApprovalId(approvalId);
        }
        return stage;
    }

    protected User getUser() {
        User user = new User();
        user.setAgency(getCurrentAgency());
        user.setPhoneNumber("1234567890");
        user.setAdvertiser(getCurrentAgency().getId());
        user.setPassword("abcdefghA1");
        user.setFullAccess();
        user.setRoles(new BaseObject[] {getRoleByName("agency.admin")});
        user.setFirstName(Gen.getHumanReadableString(6, true));
        user.setLastName(Gen.getHumanReadableString(6, true));
        user.setEmail((user.getFirstName() + "." + user.getLastName() + "@test.com").toLowerCase());
        return user;
    }

    @Override
    public BabylonMiddlewareService getService() {
        return (BabylonMiddlewareService) super.getService();
    }
}