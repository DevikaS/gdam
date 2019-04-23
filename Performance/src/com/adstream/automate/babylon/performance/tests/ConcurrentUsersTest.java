package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.With;
import com.adstream.automate.utils.Gen;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * User: ruslan.semerenko
 * Date: 04.03.13 18:28
 */
public class ConcurrentUsersTest extends OpenDashboardTest {
    private static List<String> foldersList = new CopyOnWriteArrayList<>();
    private static Map<String, String> foldersToProjectsMap = new ConcurrentHashMap<>();
    private User defaultUser;

    @Override
    public void beforeStart() {
        super.beforeStart();
    }

    @Override
    public void start() {
        switch (Gen.getInt(18)) {
            case 0:
                createProject();
                break;
            case 1:
                createFolder();
                break;
            case 2:
                createFile();
                break;
            case 3:
                createUser();
                break;
            case 4:
                createReel();
                break;
            case 5:
            case 6:
            case 7:
            case 8:
                globalSearch();
                break;
            case 9:
            case 10:
            case 11:
            case 12:
                findProjects();
                break;
            case 13:
            case 14:
            case 15:
            case 16:
                searchAssets();
                break;
            case 17:
                // open dashboard
                super.start();
                break;
        }
    }

    private void createProject() {
        Project project = getService().createProject(getProject());
        getService().addUserToProjectTeam(project.getId(), getTeamPermission(project.getId()));
        foldersToProjectsMap.put(project.getId(), project.getId());
        foldersList.add(project.getId());
    }

    private void createFolder() {
        String parent = foldersList.get(Gen.getInt(foldersList.size()));
        String projectId = foldersToProjectsMap.get(parent);

        Content content = new Content();
        content.setName(Gen.getHumanReadableString(6, true));
        content.setSubtype("folder");

        Content folder = getService().createContent(parent, content);
        String folderId = folder.getId();

        foldersToProjectsMap.put(folderId, projectId);
        foldersList.add(folderId);

        if (isCoreService()) {
            Role role = getService().findRoles(new LuceneSearchingParams().setQuery("name:project.admin"))
                                    .getResult().get(0);
            getService().getAclSubjects(role.getId(), projectId);
        }
        getService().getProject(projectId, new With(true, false, true));
        LuceneSearchingParams query =
                new LuceneSearchingParams().setSortingField("_created").setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING);
        getService().findFoldersContent(folderId, query);
        getService().getFilesCount(projectId, folderId);
    }

    private void createFile() {
        String folderId = foldersList.get(Gen.getInt(foldersList.size()));
        Content file = uploadFile(new File(getParam("filePath")), folderId);
        if (file == null) {
            fail("Can not create file");
        }
    }

    private void createUser() {
        User user = getService().createUser(getCurrentAgency().getId(), getUser());
        if (user == null) {
            fail("Can not create user");
        }
    }

    protected User getUser() {
        if (defaultUser == null) {
            defaultUser = new User();
            defaultUser.setAgency(getCurrentAgency());
            defaultUser.setPhoneNumber("1234567890");
            defaultUser.setAdvertiser(getCurrentAgency().getId());
            defaultUser.setPassword("abcdefghA1");
            defaultUser.setAccess();
            defaultUser.setRoles(new BaseObject[] {getGuestRole()});
        }
        defaultUser.setFirstName(Gen.getHumanReadableString(6, true));
        defaultUser.setLastName(Gen.getHumanReadableString(6, true));
        defaultUser.setEmail((defaultUser.getFirstName() + "." + defaultUser.getLastName() + "@test.com").toLowerCase());
        return defaultUser;
    }

    protected Role getGuestRole() {
        return getRoleById("4fba0ec37fec91f70b5a0917");
    }

    protected void createReel() {
        Reel reel = new Reel();
        reel.setName(Gen.getHumanReadableString(8));
        reel.setDescription(Gen.getHumanReadableString(8));
        reel = getService().createReel(reel);
        if (reel == null) {
            fail("Can not create reel");
        }
    }

    private void globalSearch() {
        getService().globalSearch(new LuceneSearchingParams().setQuery(Gen.getHumanReadableString(3)));
    }

    private void findProjects() {
        getService().findProjects(getQuery());
    }

    private LuceneSearchingParams getQuery() {
        return new LuceneSearchingParams()
                .setResultsOnPage(8)
                .setPageNumber(1)
                .setQuery(Gen.getHumanReadableString(3) + "*");
    }

    private void searchAssets() {
        SearchResult<Content> result = getAssets(getParamInt("assetsOnPage"));
        if (result == null || result.getResult().size() == 0) {
            fail("Error while searching assets");
        }
    }

    private SearchResult<Content> getAssets(int count) {
        return getService().findAssets(getMyAssetsCategoryId(), new LuceneSearchingParams().setResultsOnPage(count));
    }
}
