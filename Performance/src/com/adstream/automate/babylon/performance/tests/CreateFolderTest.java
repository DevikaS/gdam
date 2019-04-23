package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Identity;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.utils.Gen;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 27.07.12 10:41
 */
public class CreateFolderTest extends SearchProjectsTest {
    private static List<String> parents = new ArrayList<>();
    private static Map<String, String> parentProjects = new HashMap<>();

    @Override
    public void runOnce() {
        super.runOnce();
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        if (parents.isEmpty()) {
            LuceneSearchingParams query = new LuceneSearchingParams().setResultsOnPage(25);
            for (int i = 0; i < 10; i++) {
                query.setPageNumber(i + 1);
                for (Project project : getService().findProjects(query).getResult()) {
                    Content rootFolder = getProjectRootFolder(project.getId());
                    if (rootFolder != null) {
                        addParent(rootFolder.getId(), project.getId());
                    }
                }
            }
        }
    }

    @Override
    public void start() {
        String parent = parents.get(Gen.getInt(parents.size()));
        String projectId = parentProjects.get(parent);
        Content folder = getService().createContent(parent, getFolder(projectId));
        String folderId = folder.getId();
        addParent(folderId, projectId);
        if (isCoreService()) {
            Role role = getService().findRoles(new LuceneSearchingParams().setQuery("_cm.common.name:project.admin"))
                                    .getResult().get(0);
            getService().getAclSubjects(role.getId(), projectId);
        }
        LuceneSearchingParams query =
                new LuceneSearchingParams().setSortingField("_created")
                        .setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING).setResultsOnPage(10).setPageNumber(1);
        getService().findFoldersContent(folderId, query);
        if (getService() instanceof BabylonMiddlewareService) {
            ((BabylonMiddlewareService) getService()).getProjectFolders(projectId, parent);
        }
    }

    @Override
    public void afterRun() {
    }

    protected Content getFolder(String projectId) {
        Content content = new Content();
        content.setProject(new Identity(projectId, null));
        content.setName(Gen.getHumanReadableString(6, true));
        content.setSubtype("folder");
        return content;
    }

    private void addParent(String folderId, String projectId) {
        if (parents.contains(folderId)) return;
        parents.add(folderId);
        parentProjects.put(folderId, projectId);
    }
}