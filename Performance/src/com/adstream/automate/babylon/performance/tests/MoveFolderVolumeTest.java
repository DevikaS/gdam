package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicInteger;

public class MoveFolderVolumeTest extends AbstractPerformanceTestServiceWrapper {
    private final static AtomicInteger runCount = new AtomicInteger(0);

    private Project defaultProject;
    private static User agencyAdmin;
    private static final String AGENCY_ADMIN_ROLE_ID = "4f6acc74dff0676e018e6dcc";

    private static Project projectInitial;
    private static String destinationProjectId;
    private static final int folderCount = 100;
    private static final boolean doTestWithFiles = false;
    private static List<String> folderIds = new ArrayList<>();

    @Override
    public void runOnce() {
        log.info("Login as global admin...");
        logIn(getParam("login"), getParam("password"));
        log.info("Creating agency...");
        Agency agency = getService().createAgency(generateAgency());

        log.info("Creating agency admin...");
        agencyAdmin = getService().createUser(agency.getId(), generateAgencyAdmin(agency));
        loginAsAgencyAdmin();

        projectInitial = getService().createProject(getProject("initial"));
        if (projectInitial != null) {
            getService().addUserToProjectTeam(projectInitial.getId(), getTeamPermission(projectInitial.getId()));
        } else {
            fail("Could not create project");
        }
    }

    private void generateFile(String folderId){
        uploadFile(new File(getParam("filePath")), folderId);
    }

    private void generateFoldersDeep(int folderCount){
        log.info("Begin generate " + folderCount + " folders");
        String nextFolderId;
        Content folder  = getService().createContent(projectInitial.getId(), getFolder(projectInitial.getId()));
        nextFolderId = folder.getId();
        folderIds.add(nextFolderId);
        for (int i =0; i<(folderCount - 1);i++){
            Content nextFolder  = getService().createContent(nextFolderId, getFolder(projectInitial.getId()));
            nextFolderId = nextFolder.getId();
            if (doTestWithFiles) generateFile(nextFolderId);
        }
    }

    private void generateFoldersFlat(int folderCount){
        log.info("Begin generate " + folderCount + " folders");
        for (int i =0; i<folderCount;i++){
            Content folder  = getService().createContent(projectInitial.getId(), getFolder(projectInitial.getId()));
            folderIds.add(folder.getId());
            if (doTestWithFiles) generateFile(folder.getId());
        }
    }

    private void loginAsAgencyAdmin() {
        log.info("Login to system by: " + agencyAdmin.getEmail());
        logIn(agencyAdmin.getEmail(), getParam("password"));
    }

    protected Agency generateAgency() {
        return ObjectsFactory.createAgency(getParam("storageId"));
    }

    protected User generateAgencyAdmin(Agency agency) {
        User user = ObjectsFactory.getUser(agency, getService().getRole(AGENCY_ADMIN_ROLE_ID));
        user.setFullAccess();
        return user;
    }

    @Override
    public void beforeStart() {
        loginAsAgencyAdmin();
        Project projectTo = getService().createProject(getProject());
        if (projectTo != null) {
            getService().addUserToProjectTeam(projectTo.getId(), getTeamPermission(projectTo.getId()));
        } else {
            fail("Could not create project");
        }
        destinationProjectId = projectTo.getId();
        generateFoldersDeep(folderCount);
        //generateFoldersFlat(folderCount);
    }

    @Override
    public void start() {
        String processId = getService().moveFolder(folderIds, destinationProjectId, true);
        try {
            getService().batchTaskApi().waitTillDone(processId);
        } catch (TimeoutException e) {
            log.error(e);
        }
        destinationProjectId = (runCount.incrementAndGet() & 1) == 0?destinationProjectId:projectInitial.getId();
    }

    @Override
    public void afterRun() {
        log.info("after run");
    }

    protected Project getProject(String name) {
        if (defaultProject == null) {
            Project project = new Project();
            project.setMediaType("Broadcast");
            project.setAdministrators(new String[0]);
            project.setSubtype("project");
            project.setLogo("");
            project.setDateStart(new DateTime());
            project.setDateEnd(new DateTime().plus(Period.days(1)));
            defaultProject = project;
        }

        defaultProject.setName(name!=null?name:Gen.getHumanReadableString(8, true));
        defaultProject.setJobNumber(Gen.getHumanReadableString(8, true));
        return defaultProject;
    }

    protected Project getProject() {
       return getProject(null);
    }

    protected TeamPermission[] getTeamPermission(String projectId) {
        return new TeamPermission[] {
                new TeamPermission(projectId, getCurrentUser().getId(), getAgencyAdminRole().getId(), true, null)
        };
    }

    private Role getAgencyAdminRole() {
        return getRoleByName("project.admin");
    }

    protected Content getFolder(String projectId) {
        Content content = new Content();
        content.setProject(new Identity(projectId, null));
        content.setName(Gen.getHumanReadableString(6, true));
        content.setSubtype("folder");
        return content;
    }



}
